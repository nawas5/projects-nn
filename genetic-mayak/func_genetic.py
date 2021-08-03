import random as random
import numpy as np

'''
    Функция получения выжившей популяции
        Входные параметры:
        - popul - наша популяция
        - popul_points - наша популяция - внутренние точки (оставшиеся внутренние точки)
        - val - текущие значения
        - nsurv - количество выживших
        - reverse - указываем требуемую операцию поиска результата: максимизация или минимизация
'''


def getSurvPopul(popul, popul_indoor, val, nsurv, reverse):
    # массив для новой популяции - координаты маяков
    newpopul = []
    # массив для новой популяции - оставшиеся внутренние точки (вычет координат маяков)
    newpopul_indoor = []
    # сортируем значения в val в зависимости от параметра reverse - максимизация или минимизация
    sval = sorted(val, reverse=reverse)
    # проходимся по циклу nsurv-раз (в итоге в newpopul запишется nsurv-лучших показателей)
    for i in range(nsurv):
        # получаем индекс i-того элемента sval в исходном массиве val
        index = val.index(sval[i])
        # в новую папуляцию добавляем элемент из текущей популяции с найденным индексом
        newpopul.append(popul[index])
        # в новую популяцию так же добавляем значения оставшихся точек
        newpopul_indoor.append(popul_indoor[index])
    # возвращаем новую популяцию (из nsurv элементов) и сортированный список val
    return newpopul, newpopul_indoor, sval


'''
    Функция получения родителей
        Входные параметры:
        - curr_popul - текущая популяция
        - curr_popul_indoor - текущая популяция оставшихся точек
        - nsurv - количество выживших
'''


def getParents(curr_popul, curr_popul_indoor, nsurv):
    # случайный индекс первого родителя в диапазоне от 0 до nsurv - 1
    indexp1 = random.randint(0, nsurv - 1)
    # случайный индекс второго родителя в диапазоне от 0 до nsurv - 1
    indexp2 = random.randint(0, nsurv - 1)
    # получаем первого бота-родителя по indexp1
    botp1 = curr_popul[indexp1]
    # получаем второго бота-родителя по indexp2
    botp2 = curr_popul[indexp2]
    # здесь берется бот текущей популяции - координаты четырех маяков - и выбираются остаточные точки
    botp1_indoor = curr_popul_indoor[indexp1]
    botp2_indoor = curr_popul_indoor[indexp2]
    return botp1, botp1_indoor, botp2, botp2_indoor  # Возвращаем обоих полученных ботов


'''
    Функция смешивания (кроссинговера) двух родителей 
        Входные параметры:
        - botp1 - первый бот-родитель
        - botp2 - второй бот-родитель
        - pointsIn - все внутренние точки
        - j - номер компонента бота - координаты одного маяка
'''


def crossPointFrom2Parents(botp1, botp2, pointsIn, j):
    pindex = random.random()  # Получаем случайное число в диапазоне от 0 до 1
    # Если pindex меньше 0.5, то берем значения от первого бота, иначе от второго
    if pindex < 0.5:
        # берем за x координаты одного маяка
        x = botp1[j]
        # в качестве y будет браться следующее - все точки внутри за вычетом данной координаты
        index = 0
        for i in range(len(pointsIn)):
            if pointsIn[i][0] == x[0] and pointsIn[i][1] == x[1]:
                index = i
        y = np.delete(pointsIn, index, axis=0)
    else:
        x = botp2[j]
        index = 0
        for i in range(len(pointsIn)):
            if pointsIn[i][0] == x[0] and pointsIn[i][1] == x[1]:
                index = i
        y = np.delete(pointsIn, index, axis=0)

    # смешивание родителей ботов
    # в итоге получаем координаты одного маяка и оставшиеся точки

    return x, y  # возвращаем значение бота
