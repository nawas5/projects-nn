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
    Функция для проверки прямой видимости маяка и метки
        Входные параметры:
        - rooms - размеры комнаты
        - mayak - координаты маяка
        - metka - координаты метки
        Выходные параметры:
        - flag - 0 (отрезки не пересекаются); 1 (отрезки пересекаются)
'''

def intersection_segments(rooms, mayak, metka):

  # объявляем переменную flag
  # flag = 0 - метка и маяк в прямой видимости
  # flag = 1 - метка и маяк не в прямой видимости
  # (есть пересечение стены и прямой метка-маяк)

  flag = 0

  xm1 = mayak[0]
  ym1 = mayak[0]
  xm2 = metka[0]
  ym2 = metka[0]

  A1 = ym1 - ym2
  B1 = xm2 - xm1
  C1 = xm1 * ym2 - xm2 * ym1

  def intersection_point(x, y):
    if min(xm1, xm2) <= x <= max(xm1, xm2):
      # есть пересечение отрезков
      flag = 1
    else:
      # пересечения отрезков нет
      flag = 0
    return flag

  for i in range(ncorner):
    xc1, yc1 = rooms[i]
    if i != (ncorner - 1):
      xc2, yc2 = rooms[i+1]
    else:
      xc2, yc2 = rooms[0]

    A2 = yc1 - yc2
    B2 = xc2 - xc1
    C2 = xc1 * yc2 - xc2 * yc1

    if B1*A2 - B2*A1 and A1:
      y = (C2*A1 - C1*A2) / (B1*A2 - B2*A1)
      x = (-C1 - B1*y) / A1
      flag = intersection_point(x, y)
    elif B1*A2 - B2*A1 and A2:
      y = (C2*A1 - C1*A2) / (B1*A2 - B2*A1)
      x = (-C2 - B2*y) / A2
      flag = intersection_point(x, y)
    else:
      # пересечения отрезков нет, отрезки параллельны
      flag = 0

    return flag

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
        # здесь строить точки с прямой и проверять прямые соединяются или нет
        for j in range(nmayak):

          flag = intersection_segments(rooms, coord_mayak[j], pointsInMetka[i])

          if flag == 0:
            # увеличиваем переменную - сколько маяков видят метку
            flag_mayak += 1

            # если координата по х метки равна координате по х маяка
            # получаем, что метка и маяк образую собой вертикальную прямую - меняется только значение y
            if (pointsInMetka[i][0] - coord_mayak[j][0]) == 0 and (pointsInMetka[i][1] - coord_mayak[j][1]) != 0:
                # рассчиываем расстояние до каждого маяка
                # из формулы убираем значения для расстояния по х - нулевое, т.к. прямая вертикальна
                rast_matrix[j] = np.sqrt((pointsInMetka[i][1] - coord_mayak[j][1]) ** 2)
                grad_matrix[j] = (pointsInMetka[i] - coord_mayak[j]) / rast_matrix[j]

            # если координата по y метки равна координате по y маяка
            # получаем, что метка и маяк образую собой горизонтальную прямую - меняется только значение x

            elif (pointsInMetka[i][1] - coord_mayak[j][1]) == 0 and (pointsInMetka[i][0] - coord_mayak[j][0]) != 0:
                rast_matrix[j] = np.sqrt((pointsInMetka[i][0] - coord_mayak[j][0]) ** 2)
                grad_matrix[j] = (pointsInMetka[i] - coord_mayak[j]) / rast_matrix[j]

            # если точка и маяк лежат на кривой с наклоном
            # здесь также можно рассмотреть следующий цикл - будет строиться прямая и сравнение с каждой прямой,
            # которая образует стенку комнаты
            elif (pointsInMetka[i][1] - coord_mayak[j][1]) and (pointsInMetka[i][0] - coord_mayak[j][0]) != 0:
                rast_matrix[j] = (np.sqrt((pointsInMetka[i][0] - coord_mayak[j][0]) ** 2 +
                                          (pointsInMetka[i][1] - coord_mayak[j][1]) ** 2))
                grad_matrix[j] = (pointsInMetka[i] - coord_mayak[j]) / (rast_matrix[j])

        # если для одной метки насчитали 3 и более маяка в зоне видимости, то можно рассчитать DOP
        if flag_mayak >= 3:
            # увеличиваем число переменной для которой можно высчитать DOP
            points_true += 1
            DOP[i] = np.sqrt(np.trace(np.linalg.inv((grad_matrix.T).dot(grad_matrix))))

    return DOP, points_true