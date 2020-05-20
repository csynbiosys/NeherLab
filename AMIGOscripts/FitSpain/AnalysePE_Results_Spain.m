%% Directory and file names

maind = ['E:\UNI\D_Drive\PhD\Year_1\2020_04_7_COVID19\GitRepo\AMIGOscripts\FitSpain\'];
dire = [maind, '\Instance5\'];
ftag = ['PE_Test10_NoInfected_SpanishData_R0epp_Till7Apr-'];

%% Check convergence curves
figure
hold on
for i=1:100
   try
       x = load([dire,ftag,num2str(i),'.mat']);
       stairs(x.pe_results.nlpsol.neval, x.pe_results.nlpsol.f)
       xlabel('Iteration')
       ylabel('CFV')
   catch
   end
end
set(gca, 'YScale', 'log')
saveas(gcf,[dire, 'Convergence.png'])


%% Extract best fit
cfvs = nan(1,100);
for i=1:100
   try
       x = load([dire,ftag,num2str(i),'.mat']);
       cfvs(i) = x.pe_results.fit.f;
   catch
   end
end

micf = min(cfvs);
bestind = find(cfvs==min(cfvs));
bestind = bestind(1);

bestfit = load([dire,ftag,num2str(bestind),'.mat']);
save([dire,'BestFit.mat'],'bestfit')



%% Distributions of parameters

mkdir([dire,'Distributions'])
for i=1:length(string(bestfit.pe_inputs.PEsol.id_global_theta))
    dist = normpdf([bestfit.pe_results.fit.thetabest(i)-(4*bestfit.pe_results.fit.g_var_cov_mat(i,i)):(bestfit.pe_results.fit.g_var_cov_mat(i,i)/100):bestfit.pe_results.fit.thetabest(i)+(4*bestfit.pe_results.fit.g_var_cov_mat(i,i))],...
        bestfit.pe_results.fit.thetabest(i),bestfit.pe_results.fit.g_var_cov_mat(i,i));
    figure
    plot([bestfit.pe_results.fit.thetabest(i)-(4*bestfit.pe_results.fit.g_var_cov_mat(i,i)):(bestfit.pe_results.fit.g_var_cov_mat(i,i)/100):bestfit.pe_results.fit.thetabest(i)+(4*bestfit.pe_results.fit.g_var_cov_mat(i,i))],...
        dist)
    ylabel('Density')
    nam = (bestfit.pe_inputs.PEsol.id_global_theta(i,:));
    xlabel(nam)
    saveas(gcf,strcat(dire,'Distributions\', 'KernelDensity_',nam(find(~isspace(nam))),'.png'))
end



%% Simulate against data
r = 1:12:108;
r2 = 1:5:45;
r3 = 5:12:length(bestfit.pe_inputs.exps.exp_y0{1});
for i=1:9
    bestfit.pe_inputs.exps.exp_y0{1}(r(i)+1:r(i)+3) = bestfit.pe_results.fit.local_theta_y0_estimated{1}(r2(i):r2(i)+2);
    bestfit.pe_inputs.exps.exp_y0{1}(r(i)+4) = bestfit.pe_results.fit.local_theta_y0_estimated{1}(r2(i)+3);
    bestfit.pe_inputs.exps.exp_y0{1}(r(i)+7) = bestfit.pe_results.fit.local_theta_y0_estimated{1}(r2(i)+4);
    
    temp = bestfit.pe_inputs.exps.exp_y0{1}(r(i)+1:r(i)+9);
    temp(8) = [];
    age = AgeDistributions('ESP');
    bestfit.pe_inputs.exps.exp_y0{1}(r(i)) = age(i) -sum(temp);
    
end


bestfit.pe_inputs.model.par(bestfit.pe_results.PEsol.index_global_theta) = bestfit.pe_results.fit.global_theta_estimated;
% bestfit.pe_inputs.model.par(2) = 3.7;
bestfit.pe_inputs.PEsol=[];
AMIGO_Prep(bestfit.pe_inputs)
% bestfit.pe_inputs.model.par(10) = 10;
sim = AMIGO_SModel(bestfit.pe_inputs);

[a,b] = size(bestfit.pe_results.sim.states{1});

cumResCov19 = zeros(a,(b)/9);
r = 1:12:b;
for i=1:12 % States    
    for j=1:9 % Agge groups
        cumResCov19(:,i) = cumResCov19(:,i) + sim.sim.states{1}(:,r(j));
    end
    r = r+1;
end

%%

Dat = load(['../Data/','SpainData_20200429','.mat']);

figure
subplot(5,1,1)
hold on
plot(bestfit.exps.t_s{1}, Dat.Data.exp_data{1}(1,1:length(bestfit.pe_results.sim.exp_data{1}(:,1))))
% plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,1))
plot(sim.sim.tsim{1}, cumResCov19(:,5))

title('Inf')
% set(gca, 'YScale', 'log')

subplot(5,1,2)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,1))
% plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,1))
plot(sim.sim.tsim{1}, cumResCov19(:,11))

title('Sev')
% set(gca, 'YScale', 'log')


subplot(5,1,3)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,2))
% plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,2))
plot(sim.sim.tsim{1}, cumResCov19(:,12))
title('Cri')
% set(gca, 'YScale', 'log')


subplot(5,1,4)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,3))
% plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,3))
plot(sim.sim.tsim{1}, cumResCov19(:,9))
title('Rec')
% set(gca, 'YScale', 'log')


subplot(5,1,5)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,4))
% plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,4))
plot(sim.sim.tsim{1}, cumResCov19(:,10))
title('Fat')
% set(gca, 'YScale', 'log')

saveas(gcf,[dire, 'SimulationVSData.png'])


%%




















