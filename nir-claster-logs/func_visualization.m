close all;
figure
stem([fmeas.post1.T],[fmeas.post1.freq], 'r')
hold on
stem([fmeas.post2.T],[fmeas.post2.freq], 'b')
stem([fmeas.post3.T],[fmeas.post3.freq], 'k')
stem([fmeas.post4.T],[fmeas.post4.freq], 'm')
% legend('П1','П2','П3','П4')
% grid on
% title('Значение частот импульсов в кадре')
% xlabel('Время T, сек')
% ylabel('Частота freq, Гц')


% stem([fmeas1090.post1.T],[fmeas1090.post1.freq], 'r')
% stem([fmeas1090.post2.T],[fmeas1090.post2.freq], 'b')
% stem([fmeas1090.post3.T],[fmeas1090.post3.freq], 'k')
% stem([fmeas1090.post4.T],[fmeas1090.post4.freq], 'm')
legend('П1','П2','П3','П4')
grid on
title('Значение частот импульсов в кадре')
xlabel('Время T, сек')
ylabel('Частота freq, Гц')


% close all;
% figure
% stem([fmeas.post1.T],[fmeas.post1.dur], 'r')
% hold on
% stem([fmeas.post2.T],[fmeas.post2.dur], 'b')
% stem([fmeas.post3.T],[fmeas.post3.dur], 'k')
% stem([fmeas.post4.T],[fmeas.post4.dur], 'm')
% % legend('П1','П2','П3','П4')
% % grid on
% % title('Значение частот импульсов в кадре')
% % xlabel('Время T, сек')
% % ylabel('Частота freq, Гц')
% 
% 
% % stem([fmeas1090.post1.T],[fmeas1090.post1.dur], 'r*')
% % stem([fmeas1090.post2.T],[fmeas1090.post2.dur], 'b*')
% % stem([fmeas1090.post3.T],[fmeas1090.post3.dur], 'k*')
% % stem([fmeas1090.post4.T],[fmeas1090.post4.dur], 'm*')
% legend('П1','П2','П3','П4')
% grid on
% title('Значение длительности импульсов в кадре')
% xlabel('Время T, сек')
% ylabel('Длительность dur, нс')