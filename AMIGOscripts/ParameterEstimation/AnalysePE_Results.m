%% Directory and file names

maind = ['E:\UNI\D_Drive\PhD\Year_1\2020_04_7_COVID19\GitRepo\AMIGOscripts\ParameterEstimation\'];
dire = [maind, '\Instance2\'];
ftag = ['PE_Test4_HalfY0_R0eppTs_Imperial-'];

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
       cfvs(i) = x.pe_results.nlpsol.fbest;
   catch
   end
end

micf = min(cfvs);
bestind = find(cfvs==min(cfvs));
bestind = bestind(1);

bestfit = load([dire,ftag,num2str(bestind),'.mat']);
save([dire,'BestFit.mat'],'bestfit')

%% Simulate against data
% [a,b] = size(bestfit.pe_results.sim.states{1});
% 
% cumResCov19 = zeros(a,(b-9)/9);
% r = 1:11:b;
% for i=1:11 % States    
%     for j=1:9 % Agge groups
%         cumResCov19(:,i) = cumResCov19(:,i) + bestfit.pe_results.sim.states{1}(:,r(j));
%     end
%     r = r+1;
% end


figure
subplot(5,1,1)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,1))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,1))
title('Inf')
set(gca, 'YScale', 'log')

subplot(5,1,2)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,2))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,2))

title('Sev')
set(gca, 'YScale', 'log')


subplot(5,1,3)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,3))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,3))
title('Cri')
set(gca, 'YScale', 'log')


subplot(5,1,4)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,4))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,4))
title('Rec')
set(gca, 'YScale', 'log')


subplot(5,1,5)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,5))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,5))
title('Fat')
set(gca, 'YScale', 'log')

saveas(gcf,[dire, 'SimulationVSData.png'])

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


































