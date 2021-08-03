function [matches, poits] = build_matches(Frames, config)
    poits = [];
    k = 0;
    for i = 1:length(Frames)
        
%         out = frame_analysys(Frames(i), config); %Саньковая функция
        out.data = Frames(i).matches; %по умолчанию
        for j = 1:size(out.data,2)
            k = k + 1;
            poits(k).imps = zeros(4,5);
            poits(k).count = 0;
            poits(k).frame = i;
            if out.data(1,j)
                poits(k).imps(1,1) = Frames(i).Post1(out.data(1,j)).uT;
                poits(k).imps(1,2) = Frames(i).Post1(out.data(1,j)).T;
                poits(k).imps(1,3) = Frames(i).Post1(out.data(1,j)).freq;
                poits(k).imps(1,4) = Frames(i).Post1(out.data(1,j)).dur;
                poits(k).imps(1,5) = Frames(i).Post1(out.data(1,j)).period;
                poits(k).freq = Frames(i).Post1(out.data(1,j)).freq;
                poits(k).count = poits(k).count + 1;
                poits(k).d4c1 = Frames(i).Post1(out.data(1,j)).d4c1;
            end
            if out.data(2,j)
                poits(k).imps(2,1) = Frames(i).Post2(out.data(2,j)).uT;
                poits(k).imps(2,2) = Frames(i).Post2(out.data(2,j)).T;
                poits(k).imps(2,3) = Frames(i).Post2(out.data(2,j)).freq;
                poits(k).imps(2,4) = Frames(i).Post2(out.data(2,j)).dur;
                poits(k).imps(2,5) = Frames(i).Post2(out.data(2,j)).period;
                poits(k).freq = Frames(i).Post2(out.data(2,j)).freq;
                poits(k).count = poits(k).count + 1;
                poits(k).d4c1 = Frames(i).Post2(out.data(2,j)).d4c1;
            end
            if out.data(3,j)
                poits(k).imps(3,1) = Frames(i).Post3(out.data(3,j)).uT;
                poits(k).imps(3,2) = Frames(i).Post3(out.data(3,j)).T;
                poits(k).imps(3,3) = Frames(i).Post3(out.data(3,j)).freq;
                poits(k).imps(3,4) = Frames(i).Post3(out.data(3,j)).dur;
                poits(k).imps(3,5) = Frames(i).Post3(out.data(3,j)).period;
                poits(k).freq = Frames(i).Post3(out.data(3,j)).freq;
                poits(k).count = poits(k).count + 1;
                poits(k).d4c1 = Frames(i).Post3(out.data(3,j)).d4c1;
            end
            if out.data(4,j)
                poits(k).imps(4,1) = Frames(i).Post4(out.data(4,j)).uT;
                poits(k).imps(4,2) = Frames(i).Post4(out.data(4,j)).T;
                poits(k).imps(4,3) = Frames(i).Post4(out.data(4,j)).freq;
                poits(k).imps(4,4) = Frames(i).Post4(out.data(4,j)).dur;
                poits(k).imps(4,5) = Frames(i).Post4(out.data(4,j)).period;
                poits(k).freq = Frames(i).Post4(out.data(4,j)).freq;
                poits(k).count = poits(k).count + 1;
                poits(k).d4c1 = Frames(i).Post4(out.data(4,j)).d4c1;
            end
        end
        matches(i) = out;
    end
end

