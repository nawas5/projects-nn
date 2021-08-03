% создать кластеризацию k-средних
% для данного метода требуется задать количество кластеров

function [ idx, cmeans, ilh, h ] = func_kmeans(frames, k, norm, dists, metrics)
    
    if norm == 0
        
        figure
        [idx, cmeans] = kmeans(frames, k, dists , metrics);
        % idx - индекс кластера
        % cmeans - центры кластеров
        % график контура - отображает меру того, как близко каждая точка в
        % одном кластере к точкам в соседних кластерах
        [ilh,h] = silhouette(frames, idx, metrics); 
        
    else   
        
        figure
        [idx, cmeans] = kmeans(normalize(frames), k, dists , metrics);
        [ilh,h] = silhouette(normalize(frames), idx, metrics);
        
    end

end