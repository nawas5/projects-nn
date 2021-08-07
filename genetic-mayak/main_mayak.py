import numpy as np
import random as random
import time


from func_internal import create_points, create_coord_mayak, \
    create_points_indoors, create_dop_factor
from func_genetic import getSurvPopul, getParents, crossPointFrom2Parents
from func_plot import plot_rooms, plot_mayak, plot_dop_factor


# число маяков
nmayak = 4
# координаты комнаты
xrooms1, yrooms1 = 0, 0
xrooms2, yrooms2 = 1.15, 1
xrooms3, yrooms3 = 1, 3
xrooms4, yrooms4 = 2, -1
# задаем комнату
rooms = [[xrooms1, yrooms1], [xrooms2, yrooms2],
         [xrooms3, yrooms3], [xrooms4, yrooms4]]
# число углов комнаты
ncorner = len(rooms)
# шаг точек сетки - варьируемый параметр
kstepx, kstepy = 100, 50

# размер популяции
npopul = 20
# количество выживших особей (столько лучших ботов перейдет в новую популяцию)
nsurv = 10
# количество новых ботов (столько новых ботов будет создано)
nnew = npopul - nsurv
# размер бота (nmayak, 2) - число маяков на их координаты
# число эпох алгоритма
epohs = 20

# трехмерный массив популяции [n,nmayak,2] 
popul = []
# двумерный массив популяции [n, len(pointsInMetka]
popul_metka = []
# одномерный массив значений этих ботов - val(mean(DOP))
val = []

plotmeanval = []
plotminval = []

# рассматриваем расставку мяков при одной и той же конфигурации комнаты,
# тогда одиннаковые pointsOut, pointsIn
pointsIn, pointsOut, kx, ky = create_points(rooms, kstepx, kstepy)

# проходим по всей длине популяции
for i in range(npopul):
    # создаем массив координат маяков
    p = create_coord_mayak(pointsIn, nmayak)
    # создаем массив точек внутри помещения с учетом вычета координат маяков
    pi = create_points_indoors(p, pointsIn, nmayak)
    # добавляем компоненты в бота
    popul.append(p)
    popul_metka.append(pi)

# проходим по всем эпохам
for it in range(epohs):
    # создаем пустой список для значений ботов
    val = []

    # проходим по всей длине популяции
    for i in range(npopul):
        # берем очередного бота
        bot = popul[i]
        bot_metka = popul_metka[i]
        # высчитываем DOP для каждого бота
        DOP, points_true = create_dop_factor(rooms, bot_metka, bot, ncorner, factor)
        # plot_dop_factor(rooms, bot, DOP, bot_metka)
        # добавляем среднее значение в список
        val.append(sum(DOP) / len(DOP))

    # получаем новую популяцию
    newpopul, newpopul_metka, sval = getSurvPopul(popul, popul_metka, val, nsurv, 0)
    # выводим 5 лучших ботов
    print('')
    print(it, " ", [round(s, 8) for s in sval[0:5]])

    # добавляем среднее значение в список
    plotmeanval.append(val)
    # добавляем минимальное значение в список
    plotminval.append(sval[0])

    # проходимся по цикло nnew раз
    for i in range(nnew):
        # из newpopul (новой популяции) получаем двух случайных родителей-ботов
        # вытаскиваем координаты маяков и внешние точки
        botp1, botp1_metka, botp2, botp2_metka = getParents(newpopul, newpopul_metka, nsurv)

        # массив для нового бота
        newbot = []
        newbot_metka = []

        # проходимся по длине бота и осуществляем смешивание/скрещивание от родителей
        for j in range(nmayak):
            # получаем координаты одного маяка и остальные точки для этого маяка
            x, y = crossPointFrom2Parents(botp1, botp2, pointsIn, j)
            # координата маяка + все точки внутри помещения, кроме заданной

            # создаем область точек из которых будем выбирать новое значение маяка
            points_area_x = []
            points_area_y = []
            # чтобы смещалось вбок на пару точек

            # проходимся циклом по всем внутренним точкам
            # а если точка самая крайняя - если нет таких x точек, нет таких y точек
            for i in range(len(y)):
                # находим все точки внутри помещения, которые на таком же расстоянии x
                if y[i, 0] == x[0]:
                    # добавляем все y
                    points_area_y.append(y[i, 1])
                # находим все точки внутри помещения, которые на таком же расстоянии y
                if y[i, 1] == x[1]:
                    # добавляем все x
                    points_area_x.append(y[i, 0])

            # проверить на пустой список - и если пустой то это та-же точка и оставить её
            # если таких точек нет - значит точка граничная
            if len(points_area_x) == 0:
                points_area_x.append(x[0])
            if len(points_area_y) == 0:
                points_area_y.append(x[1])

            # находим область точек
            xmin = min(points_area_x)
            xmax = max(points_area_x)
            ymin = min(points_area_y)
            ymax = max(points_area_y)

            # формируем какое-то число от 0 до 1
            pindex = random.random()
            # eсли pindex меньше 0.5, то берем значения от первого бота, иначе от второго

            index_x = []
            index_y = []

            for i in range(len(y)):
                if y[i, 0] >= xmin and y[i, 0] <= xmax:
                    index_x.append(i)
                if y[i, 1] >= ymin and y[i, 1] <= ymax:
                    index_y.append(i)

            if len(index_x) == 0:
                iy = index_y[random.randint(0, len(index_y) - 1)]
                x = y[iy]
            if len(index_y) == 0:
                ix = index_x[random.randint(0, len(index_x) - 1)]
                x = y[ix]
            if len(index_x) != 0 and len(index_y) != 0:
                if pindex < 0.5:
                    iy = index_y[random.randint(0, len(index_y) - 1)]
                    x = y[iy]
                else:
                    ix = index_x[random.randint(0, len(index_x) - 1)]
                    x = y[ix]

            # тут могут улетать точки за пределы ибо это надо одновременно значит можно менять что-то одно таща за собой вторую координату
            newbot.append(list(x))

        newpopul_metka.append(create_points_indoors(newbot, pointsIn, ncorner))
        newpopul.append(np.array(newbot))

    popul = newpopul
    popul_metka = newpopul_metka

