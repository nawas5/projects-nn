% figure
% plot3(config.posts(1,1), config.posts(2,1), config.posts(3,1),'rv')
% hold on
% plot3(config.posts(1,2), config.posts(2,2), config.posts(3,2),'kv')
% plot3(config.posts(1,3), config.posts(2,3), config.posts(3,3),'bv')
% plot3(config.posts(1,4), config.posts(2,4), config.posts(3,4),'gv')
% legend('Первый пост', 'Второй пост', 'Третий пост', 'Четвертый пост')
% grid on
% title('Взаимное расположение постов в пространстве')
% xlabel('Координата по X, м')
% ylabel('Координата по Y, м')
% zlabel('Координата по Z, м')

% N = 2482;
% figure
% stem([Frames(N).Post1.T],[Frames(N).Post1.freq])
% hold on
% stem([Frames(N).Post2.T],[Frames(N).Post2.freq])
% stem([Frames(N).Post3.T],[Frames(N).Post3.freq])
% stem([Frames(N).Post4.T],[Frames(N).Post4.freq])
% legend('П1','П2','П3','П4')
% grid on
% title('Значение частот импульсов в кадре')
% xlabel('Время T, сек')
% ylabel('Частота freq, Гц')

% N = 2479;
% figure
% stem([Frames(N).Post1.T],[Frames(N).Post1.dur])
% hold on
% stem([Frames(N).Post2.T],[Frames(N).Post2.dur])
% stem([Frames(N).Post3.T],[Frames(N).Post3.dur])
% stem([Frames(N).Post4.T],[Frames(N).Post4.dur])
% legend('П1','П2','П3','П4')
% grid on
% title('Значение длительностей импульсов в кадре')
% xlabel('Время T, сек')
% ylabel('Длительность импульса dur, нс')


% N = 2482;
% figure
% stem([Frames(N).Post1.T],[Frames(N).Post1.period] * 1e9)
% hold on
% stem([Frames(N).Post2.T],[Frames(N).Post2.period] * 1e9)
% stem([Frames(N).Post3.T],[Frames(N).Post3.period] * 1e9)
% stem([Frames(N).Post4.T],[Frames(N).Post4.period] * 1e9)
% legend('П1','П2','П3','П4')
% grid on
% title('Значение периода импульсов в кадре')
% xlabel('Время T, сек')
% ylabel('Период period, нс')

% 2244 - 2251 c 337.5 по 22.5
% close all;
% N = 2243;
% figure
% hold on
% for i = 1:16
%     stem([Frames(N + i).Post1.T],[Frames(N + i).Post1.freq] ,'r')
%     stem([Frames(N + i).Post2.T],[Frames(N + i).Post2.freq], 'b')
%     stem([Frames(N + i).Post3.T],[Frames(N + i).Post3.freq], 'k')
%     stem([Frames(N + i).Post4.T],[Frames(N + i).Post4.freq], 'm')
% end
% legend('П1','П2','П3','П4')
% grid on
% title('Значение частот импульсов в кадре')
% xlabel('Время T, сек')
% ylabel('Частота freq, Гц')

% close all;
% N = 2243;
% figure
% hold on
% for i = 1:16
%     stem([Frames(N + i).Post1.T],[Frames(N + i).Post1.dur] ,'r')
%     stem([Frames(N + i).Post2.T],[Frames(N + i).Post2.dur], 'b')
%     stem([Frames(N + i).Post3.T],[Frames(N + i).Post3.dur], 'k')
%     stem([Frames(N + i).Post4.T],[Frames(N + i).Post4.dur], 'm')
% end
% legend('П1','П2','П3','П4')
% grid on
% title('Значение длительностей импульсов в кадре')
% xlabel('Время T, сек')
% ylabel('Длительность импульса dur, нс')

close all;
N = 2243;
figure
hold on
for i = 1:16
    stem([Frames(N + i).Post1.T],[Frames(N + i).Post1.amp] ,'r')
    stem([Frames(N + i).Post2.T],[Frames(N + i).Post2.amp], 'b')
    stem([Frames(N + i).Post3.T],[Frames(N + i).Post3.amp], 'k')
    stem([Frames(N + i).Post4.T],[Frames(N + i).Post4.amp], 'm')
end
legend('П1','П2','П3','П4')
grid on
title('Значение амплитуды импульсов в кадре')
xlabel('Время T, сек')
ylabel('Амплитуда импульса amp')
% 
% close all;
% N = 2243;
% figure
% hold on
% for i = 1:16
%     stem([Frames(N + i).Post1.T],[Frames(N + i).Post1.period] * 1e3 ,'r')
%     stem([Frames(N + i).Post2.T],[Frames(N + i).Post2.period] * 1e3, 'b')
%     stem([Frames(N + i).Post3.T],[Frames(N + i).Post3.period] * 1e3, 'k')
%     stem([Frames(N + i).Post4.T],[Frames(N + i).Post4.period] * 1e3, 'm')
% end
% legend('П1','П2','П3','П4')
% grid on
% title('Значение периода импульсов в кадре')
% xlabel('Время T, сек')
% ylabel('Период импульсов period, мс')