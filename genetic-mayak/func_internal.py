import numpy as np
import random as random
import matplotlib.path as mpltPath

'''
    Функция получения точек, заполняющих помещение,
        число углов комнаты задается в rooms
        Входные параметры:
        - rooms - координаты комнаты [x, y]
        - kstepx - шаг сетки по оси х
        - kstepy - шаг сетки по оси y
        
'''


def create_points(rooms, kstepx, kstepy):
    # превращаем лист координат комнаты в array
    rooms = np.array(rooms)
    # находим критические точки комнаты
    xmin = min(rooms[:, 0])
    xmax = max(rooms[:, 0])
    ymin = min(rooms[:, 1])
    ymax = max(rooms[:, 1])

    # делаем сетку для анализа комнаты
    kx = (xmax - xmin) / kstepx
    ky = (ymax - ymin) / kstepy
    # делаем сетку по x
    x = np.arange(xmin, xmax, kx)
    # делаем сетку по y
    y = np.arange(ymin, ymax, ky)

    # формируем координаты комнаты
    xx, yy = np.meshgrid(x, y)

    # формируем path комнаты
    path = mpltPath.Path(rooms)

    points = []
    for i in range(len(xx)):
        for j in range(len(xx[i])):
            points.append([xx[i][j], yy[i][j]])

    # определяем какие точки сетки лежат вне path комнаты
    inside2 = path.contains_points(points)

    # делаем пустые списки для точек внутри комнаты,
    # и для внешних точек, которые не попали в комнату
    pointsIn = []
    pointsOut = []

    for i in range(len(inside2)):
        if inside2[i] == True:
            pointsIn.append(points[i])
        else:
            pointsOut.append(points[i])

    pointsIn = np.array(pointsIn)
    pointsOut = np.array(pointsOut)
    # возвращаем точки, которые лежат внутри комнаты и которые лежат вне комнаты
    # возвращаем шаг сетки
    return pointsIn, pointsOut, kx, ky


'''
    Функция создания координат маяков
        Входные параметры:
        - pointsIn - внутренние координаты комнаты
        - nmayak - число маяков 
'''


def create_coord_mayak(pointsIn, nmayak):
    # создаем пустую матрицу под координаты маяков
    coord_mayak = np.zeros((nmayak, 2))
    for i in range(nmayak):
        # случайным образом берем координаты маяков из набора точек внутри помещения
        coord_mayak[i] = random.choice(pointsIn)
    return coord_mayak


'''
    Функция учёта координат маяков внутри помещения
        Входные параметры:
        - coord_mayak - координаты маяков
        - pointsIn - внутренние координаты комнаты
        - nmayak - число маяков 
'''


def create_points_indoors(coord_mayak, pointsIn, nmayak):
    # создаем пустой массив под индексы координат маяков
    index = []
    for i in range(len(pointsIn)):
        for j in range(nmayak):
            if pointsIn[i][0] == coord_mayak[j][0] and pointsIn[i][1] == coord_mayak[j][1]:
                index.append(i)

    # удаляем координаты маяков из набора внутренних точек
    pointsInMetka = np.delete(pointsIn, index, axis=0)
    return pointsInMetka


'''
    Функция расчета геометрического фактора для всех точек внутри помещения
        Входные параметры:
        - pointsInMetka - координаты оставшихся внутренних точек
        - pointsOut - координаты внешних точек
        - coord_mayak - координаты маяков
        - nmayak - число маяков 
        - factor - значение DOP для точек, для которых невозможно вычислить DOP
'''


def create_dop_factor(pointsInMetka, pointsOut, coord_mayak, nmayak, factor):
    # создаем пустую матрицу DOP
    DOP = np.zeros(len(pointsInMetka))
    # заполняем DOP значением, где невозможно произвести расчет DOP
    DOP[:] = factor
    # объявляем переменную - для скольких точек можно вычислить DOP
    # когда метку видят минимум 3 маяка
    points_true = 0

    # делаем цикл по всем точкам внутри помещения (кроме координат маяков)
    for i in range(len(pointsInMetka)):
        # объявляем матрицу расстояний от метки до маяков [rij]
        rast_matrix = np.zeros(nmayak)
        # объявляем градиентную матрицу
        grad_matrix = np.zeros((nmayak, 2))
        # объявляем переменную - число маяков, которые в прямой видимости у взятой i-ой метки
        flag_mayak = 0

        # заходим в цикл для каждого маяка
        for j in range(nmayak):

            # если координата по х метки равна координате по х маяка
            # получаем, что метка и маяк образую собой вертикальную прямую - меняется только значение y
            if (pointsInMetka[i][0] - coord_mayak[j][0]) == 0 and (pointsInMetka[i][1] - coord_mayak[j][1]) != 0:
                # находим значение ymin и ymax
                ymin = min([pointsInMetka[i][1], coord_mayak[j][1]])
                ymax = max([pointsInMetka[i][1], coord_mayak[j][1]])
                xconst = pointsInMetka[i][0]
                # объявляем флаг
                flag = 0
                # проверяем каждую точку вне помещения
                for k in range(len(pointsOut)):
                    # проверяем есть ли на искомой прямой точки лежащие вне помещения
                    # если такие точки есть, то говорим, что метка и маяк лежат не на прямой видимости
                    # точка вне - если такая же координата по x и ymin < y < ymax, то утверждаем,
                    # что метка и маяк не видят друг друга
                    if pointsOut[k][1] > ymin and pointsOut[k][1] < ymax and pointsOut[k][0] == xconst:
                        # поднимаем флаг и выходим из цикла, т.к нельзя рассчитать расстояние между меткой и маяком
                        flag = 1
                        break
                # если флаг не поднялся, т.е. метка и маяк на прямой видимости
                if flag != 1:
                    # увеличиваем переменную
                    flag_mayak += 1
                    # рассчиываем расстояние до каждого маяка
                    # из формулы убираем значения для расстояния по х - нулевое, т.к. прямая вертикальна
                    rast_matrix[j] = np.sqrt((pointsInMetka[i][1] - coord_mayak[j][1]) ** 2)
                    grad_matrix[j] = (pointsInMetka[i] - coord_mayak[j]) / rast_matrix[j]

            # если координата по y метки равна координате по y маяка
            # получаем, что метка и маяк образую собой горизонтальную прямую - меняется только значение x
            elif (pointsInMetka[i][1] - coord_mayak[j][1]) == 0 and (pointsInMetka[i][0] - coord_mayak[j][0]) != 0:
                xmin = min([pointsInMetka[i][0], coord_mayak[j][0]])
                xmax = max([pointsInMetka[i][0], coord_mayak[j][0]])
                yconst = pointsInMetka[i][1]
                flag = 0
                for k in range(len(pointsOut)):
                    if pointsOut[k][0] > xmin and pointsOut[k][0] < xmax and pointsOut[k][1] == yconst:
                        flag = 1
                        break
                if flag != 1:
                    flag_mayak += 1
                    rast_matrix[j] = np.sqrt((pointsInMetka[i][0] - coord_mayak[j][0]) ** 2)
                    grad_matrix[j] = (pointsInMetka[i] - coord_mayak[j]) / rast_matrix[j]

            # если точка и маяк лежат на кривой с наклоном
            # здесь также можно рассмотреть следующий цикл - будет строиться прямая и сравнение с каждой прямой,
            # которая образует стенку комнаты
            elif (pointsInMetka[i][1] - coord_mayak[j][1]) and (pointsInMetka[i][0] - coord_mayak[j][0]) != 0:
                # составляем уравнение прямой
                k_line = (pointsInMetka[i][1] - coord_mayak[j][1]) / (pointsInMetka[i][0] - coord_mayak[j][0])
                b_line = coord_mayak[j][1] - k_line * coord_mayak[j][0]
                flag = 0
                # заходим в цикл для каждой внешней точки
                for k in range(len(pointsOut)):
                    # находим интервал изменения координат по оси x
                    xmin = min([pointsInMetka[i][0], coord_mayak[j][0]])
                    xmax = max([pointsInMetka[i][0], coord_mayak[j][0]])
                    # находим внешние точки у которых x лежит в заданных пределах
                    if pointsOut[k][0] > xmin and pointsOut[k][0] < xmax:
                        # находим значение y для каждой точки вне комнаты
                        y_line = k_line * pointsOut[k][0] + b_line
                        # если рассчитанный y совпадает с y точки вне комнаты, значит точка лежит на прямой,
                        # соединяющей метку и маяк - точки не прямой видимости
                        if y_line == pointsOut[k][1]:
                            flag = 1
                            break
                if flag != 1:
                    flag_mayak += 1
                    rast_matrix[j] = (np.sqrt((pointsInMetka[i][0] - coord_mayak[j][0]) ** 2 +
                                              (pointsInMetka[i][1] - coord_mayak[j][1]) ** 2))
                    grad_matrix[j] = (pointsInMetka[i] - coord_mayak[j]) / (rast_matrix[j])

        # если для одной метки насчитали 3 и более маяка в зоне видимости, то можно рассчитать DOP
        if flag_mayak >= 3:
            # увеличиваем число переменной для которой можно высчитать DOP
            points_true += 1
            DOP[i] = np.sqrt(np.trace(np.linalg.inv((grad_matrix.T).dot(grad_matrix))))

    return DOP, points_true
