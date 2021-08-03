% визуализация данных по постам и индексам fourmeans

figure

for i = 1:4
    clust = find(fourmeans.post==i);
    stem(fourmeans.T(clust),fourmeans.freq(clust));
    hold on
end

xlabel('T');
ylabel('freq');
grid on

figure

for i = 1:20
    clust = find(idx==i);
    stem(fourmeans.T(clust),fourmeans.freq(clust));
    hold on
end

xlabel('T');
ylabel('freq');
grid on