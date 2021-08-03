% иерархическая кластеризация
% здесь заранее не важно знать число кластеров, на которые хотим разбить
% набор данных

function [ eucD, clustEuc ] = func_hierarch( frames, metod, metrics)

    eucD = pdist( frames , metrics);
    clustEuc = linkage( eucD, metod, metrics);
    % метод - рычажное устройство
    % метрики расстояний

   
end