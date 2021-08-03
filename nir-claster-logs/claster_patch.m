% %% иерархическая кластеризация
eucD = pdist([Fmeas.post1.freq(1:50000)], 'euclidean');
clustEuc = linkage(eucD, 'average');
cophenet(clustEuc, eucD)

[h,nodes] = dendrogram(clustEuc,50);
h_gca = gca;
h_gca.TickDir = 'out';
h_gca.TickLength = [.002 0];
h_gca.XTickLabel = [];
% 
% 
% eucD = pdist([Fourmeans.freq, Fourmeans.dur], 'euclidean');
% clustEuc = linkage(eucD, 'average');
% cophenet(clustEuc, eucD)
% 
% [h,nodes] = dendrogram(clustEuc,10);
% h_gca = gca;
% h_gca.TickDir = 'out';
% h_gca.TickLength = [.002 0];
% h_gca.XTickLabel = [];
% 
% hidx = cluster(clustEuc,'criterion','distance','cutoff');
% for i = 1:20
%     clust = find(hidx==i);
%     gscatter(meas(clust,1),meas(clust,2),meas(clust,3),ptsymb{i});
%     hold on
% end
% hold off
% xlabel('Sepal Length');
% ylabel('Sepal Width');
% zlabel('Petal Length');
% view(-137,10);
% grid on
% 
hidx = cluster(clustEuc,'criterion','distance','cutoff', 0.5e5);
figure
gscatter([Fourmeans.T(1:50000)],[Fourmeans.dur(1:50000)],hidx)
title('Значение частоты импульсов по времени')
xlabel('Время T, сек')
ylabel('Частота freq, Гц')
grid on
% 
% eucD = pdist([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)], 'euclidean');
% clustEuc = linkage(eucD, 'average');
% cophenet(clustEuc, eucD)
% 
% [h,nodes] = dendrogram(clustEuc,20);
% h_gca = gca;
% h_gca.TickDir = 'out';
% h_gca.TickLength = [.002 0];
% h_gca.XTickLabel = [];
% 
% %% k-means
% [cidx2,cmeans2] = kmeans([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],9,'dist','sqeuclidean');
% [silh2,h] = silhouette([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],cidx2,'sqeuclidean');
% [cidx2,cmeans2] = kmeans([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],9,'dist','cosine');
% [silh2,h] = silhouette([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],cidx2,'cosine');
% [cidx2,cmeans2] = kmeans([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],9,'dist','correlation');
% [silh2,h] = silhouette([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],cidx2,'correlation');
% %% dbscan

% kD = pdist2([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],[Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],'euc','Smallest',minpts);
plot(sort(kD(end,:)));
title('k-distance graph')
xlabel('Points sorted with 50th nearest distances')
ylabel('50th nearest distances')
grid
% epsilon = 2;
% labels = dbscan(X,epsilon,minpts);
% gscatter(X(:,1),X(:,2),labels);
% title('epsilon = 2 and minpts = 50')
% grid
% 
% labels = dbscan([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],epsilon,minpts);
labels = dbscan([Fourmeans.freq(1:50000)/max([Fourmeans.freq(1:50000)]), Fourmeans.dur(1:50000)/max([Fourmeans.dur(1:50000)])],0.005,100);
minpts = 100;
figure
kD = pdist2([Fourmeans.freq(1:50000)/max([Fourmeans.freq(1:50000)]), Fourmeans.dur(1:50000)/max([Fourmeans.dur(1:50000)])],[Fourmeans.freq(1:50000)/max([Fourmeans.freq(1:50000)]), Fourmeans.dur(1:50000)/max([Fourmeans.dur(1:50000)])],'euc','Smallest',minpts);
figure
gscatter([Fourmeans.T(1:50000)],[Fourmeans.freq(1:50000)],labels)
title('Значение частоты импульсов по времени')
xlabel('Время T, сек')
ylabel('Частота freq, Гц')
grid on
% 
 figure
gscatter([Fourmeans.T(1:50000)],[Fourmeans.dur(1:50000)],cidx2)
title('Значение длительности импульсов по времени')
xlabel('Время T, сек')
ylabel('Длительность импульса dur, нс')
grid on
%% гауссов
rng(3);
k = 20; % Number of GMM components
options = statset('MaxIter',1000);
%Sigma = {'diagonal','full'};
Sigma = {'diagonal','full'};% Options for covariance matrix type
nSigma = numel(Sigma);

%SharedCovariance = {true,false}; 
SharedCovariance = {true}; 
% Indicator for identical or nonidentical covariance matrices
SCtext = {'true'};
nSC = numel(SharedCovariance);

d = 1000; % Grid length
x1 = linspace(min([Fourmeans.freq(1:50000)])-2, max([Fourmeans.freq(1:50000)])+2, d);
x2 = linspace(min([Fourmeans.dur(1:50000)])-2, max([Fourmeans.dur(1:50000)])+2, d);
[x1grid,x2grid] = meshgrid(x1,x2);
X0 = [x1grid(:) x2grid(:)];

threshold = sqrt(chi2inv(0.99,2));
count = 1;
figure
for i = 1:nSigma
    
        gmfit = fitgmdist([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],k,'CovarianceType',Sigma{i}, ...
            'SharedCovariance',SharedCovariance{1},'Options',options); % Fitted GMM
        clusterX = cluster(gmfit,[Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)]); % Cluster index 
        mahalDist = mahal(gmfit,X0); % Distance from each grid point to each GMM component
        % Draw ellipsoids over each GMM component and show clustering result.
        subplot(2,1,count);
        h1 = gscatter([Fourmeans.freq(1:50000)],[Fourmeans.dur(1:50000)],clusterX);
        hold on
            for m = 1:k
                idx = mahalDist(:,m)<=threshold;
%                 Color = h1(m).Color*0.15 - 0.15*(h1(m).Color - 1);
                h2 = plot(X0(idx,1),X0(idx,2),'.','MarkerSize',1);
                uistack(h2,'bottom');
            end    
        plot(gmfit.mu(:,1),gmfit.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)
        title(sprintf('Sigma is %s\nSharedCovariance = %s',Sigma{i},SCtext{1}),'FontSize',8)
%         legend(h1,{'1','2','3','4','5','6','7','8','9'})
        legend(h1,{'1','2','3','4','5','6','7','8','9','10','11','12','13', ...
          '14','15','16','17','18','19','20'})
        grid on
        hold off
        count = count + 1;
        
    
end
rng(3);
k = 20; % Number of GMM components
options = statset('MaxIter',1000);
%Sigma = {'diagonal','full'};
Sigma = {'diagonal','full'};% Options for covariance matrix type
nSigma = numel(Sigma);

%SharedCovariance = {true,false}; 
SharedCovariance = {true}; 
% Indicator for identical or nonidentical covariance matrices
SCtext = {'true'};
nSC = numel(SharedCovariance);

d = 1000; % Grid length
x1 = linspace(min([Fourmeans.T(1:50000)])-2, max([Fourmeans.T(1:50000)])+2, d);
x2 = linspace(min([Fourmeans.dur(1:50000)])-2, max([Fourmeans.dur(1:50000)])+2, d);
[x1grid,x2grid] = meshgrid(x1,x2);
X0 = [x1grid(:) x2grid(:)];

threshold = sqrt(chi2inv(0.99,2));
count = 1;
figure
for i = 1:nSigma
    
        gmfit = fitgmdist([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],k,'CovarianceType',Sigma{i}, ...
            'SharedCovariance',SharedCovariance{1},'Options',options); % Fitted GMM
        clusterX = cluster(gmfit,[Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)]); % Cluster index 
        mahalDist = mahal(gmfit,X0); % Distance from each grid point to each GMM component
        % Draw ellipsoids over each GMM component and show clustering result.
        subplot(2,1,count);
        h1 = gscatter([Fourmeans.T(1:50000)],[Fourmeans.dur(1:50000)],clusterX);
        hold on
            for m = 1:k
                idx = mahalDist(:,m)<=threshold;
%                 Color = h1(m).Color*0.15 - 0.15*(h1(m).Color - 1);
                h2 = plot(X0(idx,1),X0(idx,2),'.','MarkerSize',1);
                uistack(h2,'bottom');
            end    
        plot(gmfit.mu(:,1),gmfit.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)
        title(sprintf('Sigma is %s\nSharedCovariance = %s',Sigma{i},SCtext{1}),'FontSize',8)
%         legend(h1,{'1','2','3','4','5','6','7','8','9'})
        legend(h1,{'1','2','3','4','5','6','7','8','9','10','11','12','13', ...
          '14','15','16','17','18','19','20'})
        grid on
        hold off
        count = count + 1;
        
    
end

rng(3);
k = 20; % Number of GMM components
options = statset('MaxIter',1000);
%Sigma = {'diagonal','full'};
Sigma = {'diagonal','full'};% Options for covariance matrix type
nSigma = numel(Sigma);

%SharedCovariance = {true,false}; 
SharedCovariance = {true}; 
% Indicator for identical or nonidentical covariance matrices
SCtext = {'true'};
nSC = numel(SharedCovariance);

d = 1000; % Grid length
x1 = linspace(min([Fourmeans.T(1:50000)])-2, max([Fourmeans.T(1:50000)])+2, d);
x2 = linspace(min([Fourmeans.freq(1:50000)])-2, max([Fourmeans.freq(1:50000)])+2, d);
[x1grid,x2grid] = meshgrid(x1,x2);
X0 = [x1grid(:) x2grid(:)];

threshold = sqrt(chi2inv(0.99,2));
count = 1;
figure
for i = 1:nSigma
    
        gmfit = fitgmdist([Fourmeans.T(1:50000)/max([Fourmeans.T(1:50000)]), Fourmeans.freq(1:50000)/max([Fourmeans.freq(1:50000)])],k,'CovarianceType',Sigma{i}, ...
            'SharedCovariance',SharedCovariance{1},'Options',options); % Fitted GMM
        clusterX = cluster(gmfit,[Fourmeans.T(1:50000)/max([Fourmeans.T(1:50000)]), Fourmeans.freq(1:50000)/max([Fourmeans.freq(1:50000)])]); % Cluster index 
        mahalDist = mahal(gmfit,X0); % Distance from each grid point to each GMM component
        % Draw ellipsoids over each GMM component and show clustering result.
        subplot(2,1,count);
        h1 = gscatter([Fourmeans.T(1:50000)],[Fourmeans.freq(1:50000)],clusterX);
        hold on
            for m = 1:k
                idx = mahalDist(:,m)<=threshold;
%                 Color = h1(m).Color*0.15 - 0.15*(h1(m).Color - 1);
                h2 = plot(X0(idx,1),X0(idx,2),'.','MarkerSize',1);
                uistack(h2,'bottom');
            end    
        plot(gmfit.mu(:,1),gmfit.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)
        title(sprintf('Sigma is %s\nSharedCovariance = %s',Sigma{i},SCtext{1}),'FontSize',8)
%         legend(h1,{'1','2','3','4','5','6','7','8','9'})
        legend(h1,{'1','2','3','4','5','6','7','8','9','10','11','12','13', ...
          '14','15','16','17','18','19','20'})
        grid on
        hold off
        count = count + 1;
        
    
end
%% спектральная кластеризация
[idx,V,D] = spectralcluster([Fourmeans.freq(1:50000), Fourmeans.dur(1:50000)],3);
idx20_2 = kmeans(V,20);

