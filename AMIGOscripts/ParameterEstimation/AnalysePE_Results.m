%% Directory and file names

maind = ['E:\UNI\D_Drive\PhD\Year_1\2020_04_7_COVID19\GitRepo\AMIGOscripts\ParameterEstimation\'];
dire = [maind, '\PE_Results_ItalyData_20200415_30-Apr-2020\'];
ftag = ['PE_Test1_R0SF-'];

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

figure
subplot(5,1,1)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,1))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.states{1}(:,104))
title('Inf')
set(gca, 'YScale', 'log')

subplot(5,1,2)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,2))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.states{1}(:,105))
title('Sev')
set(gca, 'YScale', 'log')


subplot(5,1,3)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,3))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.states{1}(:,106))
title('Cri')
set(gca, 'YScale', 'log')


subplot(5,1,4)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,4))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.states{1}(:,107))
title('Rec')
set(gca, 'YScale', 'log')


subplot(5,1,5)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,5))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.states{1}(:,108))
title('Fat')
set(gca, 'YScale', 'log')

saveas(gcf,[dire, 'SimulationVSData.png'])

%% Distributions of parameters

for i=1:length((bestfit.pe_results.fit.thetabest))
    
    
end





































