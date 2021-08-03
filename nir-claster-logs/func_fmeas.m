% создадим функции
% первая - объединяем все фреймы по постам - все импульсы из фреймов

% function [ fmeas, fmeas1090 ] = func_fmeas(Frames)
% 
%     fmeas = {};
%     fmeas1090 = {};
% 
%     k1 = 1;
%     k2 = 1;
%     k3 = 1;
%     k4 = 1;
% 
%     for i = 1:length(Frames)
%         if ~isempty([Frames(i).Post1])
%             for j = 1:length([Frames(i).Post1.freq])
%                 if Frames(i).Post1(j).freq ~= 1090000
%                     fmeas.post1.uT(k1,1) = Frames(i).Post1(j).uT;
%                     fmeas.post1.T(k1,1) = Frames(i).Post1(j).T;
%                     fmeas.post1.amp(k1,1) = Frames(i).Post1(j).amp;
%                     fmeas.post1.freq(k1,1) = Frames(i).Post1(j).freq;
%                     fmeas.post1.dur(k1,1) = Frames(i).Post1(j).dur;
%                     fmeas.post1.az(k1,1) = Frames(i).Post1(j).az;
%                     k1 = k1 + 1;
%                 end
%             end
%         end
%         if ~isempty([Frames(i).Post2])
%             for j = 1:length([Frames(i).Post2.freq])
%                 if Frames(i).Post2(j).freq ~= 1090000
%                     fmeas.post2.uT(k2,1) = Frames(i).Post2(j).uT;
%                     fmeas.post2.T(k2,1) = Frames(i).Post2(j).T;
%                     fmeas.post2.amp(k2,1) = Frames(i).Post2(j).amp;
%                     fmeas.post2.freq(k2,1) = Frames(i).Post2(j).freq;
%                     fmeas.post2.dur(k2,1) = Frames(i).Post2(j).dur;
%                     fmeas.post2.az(k2,1) = Frames(i).Post2(j).az;
%                     k2 = k2 + 1;
%                 end
%             end
%         end
%         if ~isempty([Frames(i).Post3])
%             for j = 1:length([Frames(i).Post3.freq])
%                 if Frames(i).Post3(j).freq ~= 1090000
%                     fmeas.post3.uT(k3,1) = Frames(i).Post3(j).uT;
%                     fmeas.post3.T(k3,1) = Frames(i).Post3(j).T;
%                     fmeas.post3.amp(k3,1) = Frames(i).Post3(j).amp;
%                     fmeas.post3.freq(k3,1) = Frames(i).Post3(j).freq;
%                     fmeas.post3.dur(k3,1) = Frames(i).Post3(j).dur;
%                     fmeas.post3.az(k3,1) = Frames(i).Post3(j).az;
%                     k3 = k3 + 1;
%                 end
%             end
%         end
%         if ~isempty([Frames(i).Post4])
%             for j = 1:length([Frames(i).Post4.freq])
%                 if Frames(i).Post4(j).freq ~= 1090000
%                     fmeas.post4.uT(k4,1) = Frames(i).Post4(j).uT;
%                     fmeas.post4.T(k4,1) = Frames(i).Post4(j).T;
%                     fmeas.post4.amp(k4,1) = Frames(i).Post4(j).amp;
%                     fmeas.post4.freq(k4,1) = Frames(i).Post4(j).freq;
%                     fmeas.post4.dur(k4,1) = Frames(i).Post4(j).dur;
%                     fmeas.post4.az(k4,1) = Frames(i).Post4(j).az;
%                     k4 = k4 + 1;
%                 end
%             end
%         end
%     end
%     
%     k1 = 1;
%     k2 = 1;
%     k3 = 1;
%     k4 = 1;
% 
%     for i = 1:length(Frames)
%         if ~isempty([Frames(i).Post1])
%             for j = 1:length([Frames(i).Post1.freq])
%                 if Frames(i).Post1(j).freq == 1090000
%                     fmeas1090.post1.uT(k1,1) = Frames(i).Post1(j).uT;
%                     fmeas1090.post1.T(k1,1) = Frames(i).Post1(j).T;
%                     fmeas1090.post1.amp(k1,1) = Frames(i).Post1(j).amp;
%                     fmeas1090.post1.freq(k1,1) = Frames(i).Post1(j).freq;
%                     fmeas1090.post1.dur(k1,1) = Frames(i).Post1(j).dur;
%                     fmeas1090.post1.az(k1,1) = Frames(i).Post1(j).az;
%                     k1 = k1 + 1;
%                 end
%             end
%         end
%         if ~isempty([Frames(i).Post2])
%             for j = 1:length([Frames(i).Post2.freq])
%                 if Frames(i).Post2(j).freq == 1090000
%                     fmeas1090.post2.uT(k2,1) = Frames(i).Post2(j).uT;
%                     fmeas1090.post2.T(k2,1) = Frames(i).Post2(j).T;
%                     fmeas1090.post2.amp(k2,1) = Frames(i).Post2(j).amp;
%                     fmeas1090.post2.freq(k2,1) = Frames(i).Post2(j).freq;
%                     fmeas1090.post2.dur(k2,1) = Frames(i).Post2(j).dur;
%                     fmeas1090.post2.az(k2,1) = Frames(i).Post2(j).az;
%                     k2 = k2 + 1;
%                 end
%             end
%         end
%         if ~isempty([Frames(i).Post3])
%             for j = 1:length([Frames(i).Post3.freq])
%                 if Frames(i).Post3(j).freq == 1090000
%                     fmeas1090.post3.uT(k3,1) = Frames(i).Post3(j).uT;
%                     fmeas1090.post3.T(k3,1) = Frames(i).Post3(j).T;
%                     fmeas1090.post3.amp(k3,1) = Frames(i).Post3(j).amp;
%                     fmeas1090.post3.freq(k3,1) = Frames(i).Post3(j).freq;
%                     fmeas1090.post3.dur(k3,1) = Frames(i).Post3(j).dur;
%                     fmeas1090.post3.az(k3,1) = Frames(i).Post3(j).az;
%                     k3 = k3 + 1;
%                 end
%             end
%         end
%         if ~isempty([Frames(i).Post4])
%             for j = 1:length([Frames(i).Post4.freq])
%                 if Frames(i).Post4(j).freq == 1090000
%                     fmeas1090.post4.uT(k4,1) = Frames(i).Post4(j).uT;
%                     fmeas1090.post4.T(k4,1) = Frames(i).Post4(j).T;
%                     fmeas1090.post4.amp(k4,1) = Frames(i).Post4(j).amp;
%                     fmeas1090.post4.freq(k4,1) = Frames(i).Post4(j).freq;
%                     fmeas1090.post4.dur(k4,1) = Frames(i).Post4(j).dur;
%                     fmeas1090.post4.az(k4,1) = Frames(i).Post4(j).az;
%                     k4 = k4 + 1;
%                 end
%             end
%         end
%     end
%     
% end

function [ fmeas] = func_fmeas(Frames)

    fmeas = {};


    k1 = 1;
    k2 = 1;
    k3 = 1;
    k4 = 1;

    for i = 1:length(Frames)
        if ~isempty([Frames(i).Post1])
            for j = 1:length([Frames(i).Post1.freq])
                
                    fmeas.post1.uT(k1,1) = Frames(i).Post1(j).uT;
                    fmeas.post1.T(k1,1) = Frames(i).Post1(j).T;
                    fmeas.post1.amp(k1,1) = Frames(i).Post1(j).amp;
                    fmeas.post1.freq(k1,1) = Frames(i).Post1(j).freq;
                    fmeas.post1.dur(k1,1) = Frames(i).Post1(j).dur;
                    fmeas.post1.az(k1,1) = Frames(i).Post1(j).az;
                    k1 = k1 + 1;
            end
        end
        if ~isempty([Frames(i).Post2])
            for j = 1:length([Frames(i).Post2.freq])
                
                    fmeas.post2.uT(k2,1) = Frames(i).Post2(j).uT;
                    fmeas.post2.T(k2,1) = Frames(i).Post2(j).T;
                    fmeas.post2.amp(k2,1) = Frames(i).Post2(j).amp;
                    fmeas.post2.freq(k2,1) = Frames(i).Post2(j).freq;
                    fmeas.post2.dur(k2,1) = Frames(i).Post2(j).dur;
                    fmeas.post2.az(k2,1) = Frames(i).Post2(j).az;
                    k2 = k2 + 1;
                
            end
        end
        if ~isempty([Frames(i).Post3])
            for j = 1:length([Frames(i).Post3.freq])
                
                    fmeas.post3.uT(k3,1) = Frames(i).Post3(j).uT;
                    fmeas.post3.T(k3,1) = Frames(i).Post3(j).T;
                    fmeas.post3.amp(k3,1) = Frames(i).Post3(j).amp;
                    fmeas.post3.freq(k3,1) = Frames(i).Post3(j).freq;
                    fmeas.post3.dur(k3,1) = Frames(i).Post3(j).dur;
                    fmeas.post3.az(k3,1) = Frames(i).Post3(j).az;
                    k3 = k3 + 1;
                
            end
        end
        if ~isempty([Frames(i).Post4])
            for j = 1:length([Frames(i).Post4.freq])
                
                    fmeas.post4.uT(k4,1) = Frames(i).Post4(j).uT;
                    fmeas.post4.T(k4,1) = Frames(i).Post4(j).T;
                    fmeas.post4.amp(k4,1) = Frames(i).Post4(j).amp;
                    fmeas.post4.freq(k4,1) = Frames(i).Post4(j).freq;
                    fmeas.post4.dur(k4,1) = Frames(i).Post4(j).dur;
                    fmeas.post4.az(k4,1) = Frames(i).Post4(j).az;
                    k4 = k4 + 1;
                
            end
        end
    end
  
end
