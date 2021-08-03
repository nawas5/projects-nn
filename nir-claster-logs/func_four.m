% соединяем данные со всех постов в длинный столбец - индекс номер поста

% function [ fourmeans, fourmeans1090 ] = func_four(Frames)
% 
%     fourmeans = [];
%     fourmeans1090 = [];
% 
%     k = 1;
% 
%     for i = 1:length(Frames)
%         if ~isempty([Frames(i).Post1])
%             for j = 1:length([Frames(i).Post1.freq])
%                 if Frames(i).Post1(j).freq ~= 1090000
%                     fourmeans.uT(k,1) = Frames(i).Post1(j).uT;
%                     fourmeans.T(k,1) = Frames(i).Post1(j).T;
%                     fourmeans.amp(k,1) = Frames(i).Post1(j).amp;
%                     fourmeans.freq(k,1) = Frames(i).Post1(j).freq;
%                     fourmeans.dur(k,1) = Frames(i).Post1(j).dur;
%                     fourmeans.az(k,1) = Frames(i).Post1(j).az;
%                     fourmeans.post(k,1) = 1;
%                     k = k + 1;
%                 end
%             end
%             
%         elseif ~isempty([Frames(i).Post2])
%             for j = 1:length([Frames(i).Post2.freq])
%                 if Frames(i).Post2(j).freq ~= 1090000
%                     fourmeans.uT(k,1) = Frames(i).Post2(j).uT;
%                     fourmeans.T(k,1) = Frames(i).Post2(j).T;
%                     fourmeans.amp(k,1) = Frames(i).Post2(j).amp;
%                     fourmeans.freq(k,1) = Frames(i).Post2(j).freq;
%                     fourmeans.dur(k,1) = Frames(i).Post2(j).dur;
%                     fourmeans.az(k,1) = Frames(i).Post2(j).az;
%                     fourmeans.post(k,1) = 2;
%                     k = k + 1;
%                 end
%             end
%         
%         elseif ~isempty([Frames(i).Post3])
%             for j = 1:length([Frames(i).Post3.freq])
%                 if Frames(i).Post3(j).freq ~= 1090000
%                     fourmeans.uT(k,1) = Frames(i).Post3(j).uT;
%                     fourmeans.T(k,1) = Frames(i).Post3(j).T;
%                     fourmeans.amp(k,1) = Frames(i).Post3(j).amp;
%                     fourmeans.freq(k,1) = Frames(i).Post3(j).freq;
%                     fourmeans.dur(k,1) = Frames(i).Post3(j).dur;
%                     fourmeans.az(k,1) = Frames(i).Post3(j).az;
%                     fourmeans.post(k,1) = 3;
%                     k = k + 1;
%                 end
%             end
%         
%         elseif ~isempty([Frames(i).Post4])
%             for j = 1:length([Frames(i).Post4.freq])
%                 if Frames(i).Post4(j).freq ~= 1090000
%                     fourmeans.uT(k,1) = Frames(i).Post4(j).uT;
%                     fourmeans.T(k,1) = Frames(i).Post4(j).T;
%                     fourmeans.amp(k,1) = Frames(i).Post4(j).amp;
%                     fourmeans.freq(k,1) = Frames(i).Post4(j).freq;
%                     fourmeans.dur(k,1) = Frames(i).Post4(j).dur;
%                     fourmeans.az(k,1) = Frames(i).Post4(j).az;
%                     fourmeans.post(k,1) = 4;
%                     k = k + 1;
%                 end
%             end
%         end
%     end
%     
%    
%     k = 1;
% 
%     for i = 1:length(Frames)
%         if ~isempty([Frames(i).Post1])
%             for j = 1:length([Frames(i).Post1.freq])
%                 if Frames(i).Post1(j).freq == 1090000
%                     fourmeans1090.uT(k,1) = Frames(i).Post1(j).uT;
%                     fourmeans1090.T(k,1) = Frames(i).Post1(j).T;
%                     fourmeans1090.amp(k,1) = Frames(i).Post1(j).amp;
%                     fourmeans1090.freq(k,1) = Frames(i).Post1(j).freq;
%                     fourmeans1090.dur(k,1) = Frames(i).Post1(j).dur;
%                     fourmeans1090.az(k,1) = Frames(i).Post1(j).az;
%                     fourmeans1090.post(k,1) = 1;
%                     k = k + 1;
%                 end
%             end
%             
%         elseif ~isempty([Frames(i).Post2])
%             for j = 1:length([Frames(i).Post2.freq])
%                 if Frames(i).Post2(j).freq == 1090000
%                     fourmeans1090.uT(k,1) = Frames(i).Post2(j).uT;
%                     fourmeans1090.T(k,1) = Frames(i).Post2(j).T;
%                     fourmeans1090.amp(k,1) = Frames(i).Post2(j).amp;
%                     fourmeans1090.freq(k,1) = Frames(i).Post2(j).freq;
%                     fourmeans1090.dur(k,1) = Frames(i).Post2(j).dur;
%                     fourmeans1090.az(k,1) = Frames(i).Post2(j).az;
%                     fourmeans1090.post(k,1) = 2;
%                     k = k + 1;
%                 end
%             end
%         
%         elseif ~isempty([Frames(i).Post3])
%             for j = 1:length([Frames(i).Post3.freq])
%                 if Frames(i).Post3(j).freq == 1090000
%                     fourmeans1090.uT(k,1) = Frames(i).Post3(j).uT;
%                     fourmeans1090.T(k,1) = Frames(i).Post3(j).T;
%                     fourmeans1090.amp(k,1) = Frames(i).Post3(j).amp;
%                     fourmeans1090.freq(k,1) = Frames(i).Post3(j).freq;
%                     fourmeans1090.dur(k,1) = Frames(i).Post3(j).dur;
%                     fourmeans1090.az(k,1) = Frames(i).Post3(j).az;
%                     fourmeans1090.post(k,1) = 3;
%                     k = k + 1;
%                 end
%             end
%         
%         elseif ~isempty([Frames(i).Post4])
%             for j = 1:length([Frames(i).Post4.freq])
%                 if Frames(i).Post4(j).freq == 1090000
%                     fourmeans1090.uT(k,1) = Frames(i).Post4(j).uT;
%                     fourmeans1090.T(k,1) = Frames(i).Post4(j).T;
%                     fourmeans1090.amp(k,1) = Frames(i).Post4(j).amp;
%                     fourmeans1090.freq(k,1) = Frames(i).Post4(j).freq;
%                     fourmeans1090.dur(k,1) = Frames(i).Post4(j).dur;
%                     fourmeans1090.az(k,1) = Frames(i).Post4(j).az;
%                     fourmeans1090.post(k,1) = 4;
%                     k = k + 1;
%                 end
%             end
%         end
%     end
% 
% end

function [ fourmeans ] = func_four(Frames)

    fourmeans = [];

    k = 1;

    for i = 1:length(Frames)
        if ~isempty([Frames(i).Post1])
            for j = 1:length([Frames(i).Post1.freq])
 
                    fourmeans.uT(k,1) = Frames(i).Post1(j).uT;
                    fourmeans.T(k,1) = Frames(i).Post1(j).T;
                    fourmeans.amp(k,1) = Frames(i).Post1(j).amp;
                    fourmeans.freq(k,1) = Frames(i).Post1(j).freq;
                    fourmeans.dur(k,1) = Frames(i).Post1(j).dur;
                    fourmeans.az(k,1) = Frames(i).Post1(j).az;
                    fourmeans.post(k,1) = 1;
                    k = k + 1;
                
            end
            
        elseif ~isempty([Frames(i).Post2])
            for j = 1:length([Frames(i).Post2.freq])
               
                    fourmeans.uT(k,1) = Frames(i).Post2(j).uT;
                    fourmeans.T(k,1) = Frames(i).Post2(j).T;
                    fourmeans.amp(k,1) = Frames(i).Post2(j).amp;
                    fourmeans.freq(k,1) = Frames(i).Post2(j).freq;
                    fourmeans.dur(k,1) = Frames(i).Post2(j).dur;
                    fourmeans.az(k,1) = Frames(i).Post2(j).az;
                    fourmeans.post(k,1) = 2;
                    k = k + 1;
               
            end
        
        elseif ~isempty([Frames(i).Post3])
            for j = 1:length([Frames(i).Post3.freq])
               
                    fourmeans.uT(k,1) = Frames(i).Post3(j).uT;
                    fourmeans.T(k,1) = Frames(i).Post3(j).T;
                    fourmeans.amp(k,1) = Frames(i).Post3(j).amp;
                    fourmeans.freq(k,1) = Frames(i).Post3(j).freq;
                    fourmeans.dur(k,1) = Frames(i).Post3(j).dur;
                    fourmeans.az(k,1) = Frames(i).Post3(j).az;
                    fourmeans.post(k,1) = 3;
                    k = k + 1;
                
            end
        
        elseif ~isempty([Frames(i).Post4])
            for j = 1:length([Frames(i).Post4.freq])
               
                    fourmeans.uT(k,1) = Frames(i).Post4(j).uT;
                    fourmeans.T(k,1) = Frames(i).Post4(j).T;
                    fourmeans.amp(k,1) = Frames(i).Post4(j).amp;
                    fourmeans.freq(k,1) = Frames(i).Post4(j).freq;
                    fourmeans.dur(k,1) = Frames(i).Post4(j).dur;
                    fourmeans.az(k,1) = Frames(i).Post4(j).az;
                    fourmeans.post(k,1) = 4;
                    k = k + 1;
                
            end
        end
    end
    
   


end