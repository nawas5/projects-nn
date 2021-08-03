function [Frames] = log3stanreadframes()
% считывание лога по кадрам
if nargin == 0
folder = uigetdir(cd,'Выберите папку с логами!');
end
 warning off

files = dir(folder);
files = files(3:end);
N = length(files);
k = 0;
frames = 0;

%files_range = 1:N;
files_range = 1:100;

for i = files_range
    
    filename = [folder '\' files(i).name];
    f = fopen(filename);
    
    
    while feof(f)==0 
        s = fgetl(f);
        if contains(s,'pmask')
             frames = frames + 1;
             hour   = str2double(s(11:13));
             minute = str2double(s(15:16));
             sec    = str2double(s(18:28));
             time  = hour * 3600 + minute * 60 + sec;
             frame_time(frames) = time;
             Frames(frames).time = time;
             Frames(frames).Post1 = [];
             Frames(frames).Post2 = [];
             Frames(frames).Post3 = [];
             Frames(frames).Post4 = [];
               
        elseif contains(s,'+++')
            post_number = str2num(s(6));
            count = str2num(s(18:end));
            imps = [];
                imps.uT = [];
                imps.T = [];
                imps.amp = [];
                imps.freq = [];
                imps.dur = [];
                imps.az = [];
                imps.period = [];
                imps.d4c1 = [];
            for j = 1:count
                s = fgetl(f);
                data = strsplit(s);
                imp.uT = str2num(data{1,1});
                imp.T = time + imp.uT/1e9;
                imp.amp = str2num(data{1,3});
                imp.freq = str2num(data{1,6});
                imp.dur = str2num(data{1,10});
                imp.az = str2num(data{1,20});
                imp.period = 0;
                imp.d4c1 = data{1,21};
                imps(j) = imp;
                if j > 1
                    imps(j).period = imps(j).T - imps(j-1).T;
                end
            end
            
            if ~isempty(imps(1).T)
                switch post_number
                    case 1
                        Frames(frames).Post1 = imps;
                    case 2
                        Frames(frames).Post2 = imps;
                    case 3
                        Frames(frames).Post3 = imps;
                    case 4
                        Frames(frames).Post4 = imps;
                end
            end
        elseif contains(s,'match tbl count')
            count = str2num(s(findstr(s,'=')+1:end));
            for kk = 1:count
                s = fgetl(f);
                data = strsplit(s);
                
                if isempty(str2num(data{1,3}))
                    match(1,1) = 0;
                else
                    match(1,1) = str2num(data{1,3}) + 1;
                end
                
                if isempty(str2num(data{1,4}))
                    match(2,1) = 0;
                else
                    match(2,1) = str2num(data{1,4}) + 1;
                end
                
                if isempty(str2num(data{1,5}))
                    match(3,1) = 0;
                else
                    match(3,1) = str2num(data{1,5}) + 1;
                end
                
                if isempty(str2num(data{1,6}))
                    match(4,1) = 0;
                else
                    match(4,1) = str2num(data{1,6}) + 1;
                end
                
                Frames(frames).matches(:,kk) = match;
                    
            end
        end
    end
    frames
    fclose(f);
    
    k = k + 1;
%     disp(['Завершено ' (num2str(round(k/N*100))) ' % Кадров в файле: ' num2str(frames) ' Всего кадров обработано: ' num2str(all_frames)])
    
end

end



