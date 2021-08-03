function [ config ] = config_build()
    addpath('additional');
%     Воронеж
%     PostsBLH(:,1) = [51.400773; 39.035690; 172.5];
%     PostsBLH(:,2) = [51.535456; 39.286083; 119.0];
%     PostsBLH(:,3) = [51.552025; 38.989821; 196.4];
%     PostsBLH(:,4) = [51.504039; 39.108616; 124.4];
%     Армения
    PostsBLH(:,1) = [40.106749; 44.325077; 851.2];
    PostsBLH(:,2) = [40.221671; 44.518625; 1250.4];
    PostsBLH(:,3) = [40.376235; 44.255345; 2034.1];
    PostsBLH(:,4) = [40.204856; 44.376949; 1002.0];

    BLHref = mean(PostsBLH');
    BLHref(3) = 0;
    for i = 1:size(PostsBLH,2)
        PostsENU(:,i) = BLH2ENU(PostsBLH(:,i),BLHref);
    end
    config.BLHref = BLHref;
    config.PostsBLH = PostsBLH;
    config.PostsENU = PostsENU;
    config.posts = PostsENU;
    config.aero_blh(:,1) = [51.81299090540705;  39.225784950229695; 0];
    config.aero_blh(:,2) = [52.79676996114492;  39.5098102080474;   0];
    config.aero_blh(:,3) = [52.9095513118827;   41.509321894684454; 0];
    config.aero_blh(:,4) = [51.85001778967282;  36.268843464105856; 0];
    config.aero_blh(:,5) = [53.35775123662653;  34.23637279362314;  0];
    config.aero_blh(:,6) = [54.6744534299724;   36.37870673282828;  0];
    config.aero_blh(:,7) = [50.825325583252976; 36.65202897303181;  0];
    config.aero_blh(:,8) = [55.47902224945949;  37.90197193346745;  0];
    for i = 1:length(config.aero_blh)
        config.aeroENU(:,i) = BLH2ENU(config.aero_blh(:,i),BLHref);
    end
%     config.c = 299792458/1e9;
    config.c = 299792458;
    config.hei = 5000;
    config.StartNumber = 15; % пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅ
    config.Vmax = 600;
    config.sigma_t = 100e-9;
    config.sigma_t_m = config.sigma_t*config.c;
    config.sigma_v = 10;
    config.sigma_d = 1e-6;
    config.posts_number = size(config.PostsENU,2);
    config.sigma_n = 10; %ns

    config.ranges.r21 = norm(PostsENU(:,2) - PostsENU(:,1));
    config.ranges.r31 = norm(PostsENU(:,3) - PostsENU(:,1));
    config.ranges.r41 = norm(PostsENU(:,4) - PostsENU(:,1));
    config.ranges.r32 = norm(PostsENU(:,3) - PostsENU(:,2));
    config.ranges.r42 = norm(PostsENU(:,4) - PostsENU(:,2));
    config.ranges.r43 = norm(PostsENU(:,4) - PostsENU(:,3));
end
