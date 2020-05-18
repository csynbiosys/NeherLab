%% Directory and file names

maind = ['E:\UNI\D_Drive\PhD\Year_1\2020_04_7_COVID19\GitRepo\AMIGOscripts\NoInfected\'];
dire = [maind, '\Instance4\'];
ftag = ['PE_Test2_IOC_epp_error03_R032-'];

%% Check convergence curves
figure
hold on
for i=1:100
   try
       x = load([dire,ftag,num2str(i),'.mat']);
       stairs(x.pe_results.nlpsol.conv_curve(:,1), x.pe_results.nlpsol.conv_curve(:,2))
       xlabel('Time')
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



%% Distributions of parameters

% mkdir([dire,'Distributions'])
% for i=1:length(string(bestfit.pe_inputs.PEsol.id_global_theta))
%     dist = normpdf([bestfit.pe_results.fit.thetabest(i)-(4*bestfit.pe_results.fit.g_var_cov_mat(i,i)):(bestfit.pe_results.fit.g_var_cov_mat(i,i)/100):bestfit.pe_results.fit.thetabest(i)+(4*bestfit.pe_results.fit.g_var_cov_mat(i,i))],...
%         bestfit.pe_results.fit.thetabest(i),bestfit.pe_results.fit.g_var_cov_mat(i,i));
%     figure
%     plot([bestfit.pe_results.fit.thetabest(i)-(4*bestfit.pe_results.fit.g_var_cov_mat(i,i)):(bestfit.pe_results.fit.g_var_cov_mat(i,i)/100):bestfit.pe_results.fit.thetabest(i)+(4*bestfit.pe_results.fit.g_var_cov_mat(i,i))],...
%         dist)
%     ylabel('Density')
%     nam = (bestfit.pe_inputs.PEsol.id_global_theta(i,:));
%     xlabel(nam)
%     saveas(gcf,strcat(dire,'Distributions\', 'KernelDensity_',nam(find(~isspace(nam))),'.png'))
% end



%% Simulate against data
r = 1:12:108;
r2 = 1:5:45;
r3 = 5:12:length(bestfit.pe_inputs.exps.exp_y0{1});
for i=1:9
    bestfit.pe_inputs.exps.exp_y0{1}(r(i)+1:r(i)+3) = bestfit.pe_results.ioc.uy0(r2(i):r2(i)+2);
    bestfit.pe_inputs.exps.exp_y0{1}(r(i)+4) = bestfit.pe_results.ioc.uy0(r2(i)+3);
    bestfit.pe_inputs.exps.exp_y0{1}(r(i)+7) = bestfit.pe_results.ioc.uy0(r2(i)+4);
    
    temp = bestfit.pe_inputs.exps.exp_y0{1}(r(i)+1:r(i)+9);
    temp(8) = [];
    age = AgeDistributions('ITA');
    bestfit.pe_inputs.exps.exp_y0{1}(r(i)) = age(i) -sum(temp);
    
end

bestfit.pe_inputs.model.par(2)=3.2;
bestfit.pe_inputs.model.par(3) = bestfit.pe_results.ioc.upar;
bestfit.pe_inputs.iocsol=[];
Dat = load(['../Data/','ItalyData_20200415','.mat']);

mitigations = cell(1,2);
mitigations{1,1}.val = 40; mitigations{1,1}.tmin = Dat.Data.start_date{1}; mitigations{1,1}.tmax = Dat.Data.end_date{1};
%         mitigations{1,2}.val = 60; mitigations{1,2}.tmin = '1-mar-2020'; mitigations{1,2}.tmax = Dat.Data.end_date{1};

try
    [cp, M_Tx, ~, ~] = Inputs_SIR(Dat.Data.start_date{1},Dat.Data.end_date{1},0,mitigations);
    M_Ty = min(max(1-ExtractMitigation_NoInfected(Dat.Data.country_id{1}, Dat.Data.start_date{1},Dat.Data.end_date{1}),0.01),1);
    %                 M_Ty = ExtractMitigation_NoInfected(Dat.Data.country_id{1}, Dat.Data.start_date{1},Dat.Data.end_date{1});
    %                 M_Ty = 1-(0.5 + ((M_Ty-0)*(1-0.5))/(1-0));
catch
    [cp, M_Tx, M_Ty, ~] = Inputs_SIR(Dat.Data.start_date{1},Dat.Data.end_date{1},0,mitigations);
end

M_Ty = bestfit.pe_results.ioc.u{1}(1,:);

bestfit.pe_inputs.exps.u_interp{1} = 'step';
bestfit.pe_inputs.exps.u{1} = [M_Ty;cp];
bestfit.pe_inputs.exps.t_con{1} = M_Tx;


inputs = AMIGO_Prep(bestfit.pe_inputs);

sim = AMIGO_SModel(inputs);

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

Dat = load(['../Data/','ItalyData_20200415','.mat']);

figure
subplot(5,1,1)
hold on
plot(bestfit.exps.t_s{1}, Dat.Data.exp_data{1}(1,:))
% plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,1))
plot(sim.sim.tsim{1}, cumResCov19(:,5))

title('Inf')
% set(gca, 'YScale', 'log')

subplot(5,1,2)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,1))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,1))
% plot(sim.sim.tsim{1}, cumResCov19(:,6))

title('Sev')
% set(gca, 'YScale', 'log')


subplot(5,1,3)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,2))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,2))
% plot(sim.sim.tsim{1}, cumResCov19(:,7))
title('Cri')
% set(gca, 'YScale', 'log')


subplot(5,1,4)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,3))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,3))
% plot(sim.sim.tsim{1}, cumResCov19(:,9))
title('Rec')
% set(gca, 'YScale', 'log')


subplot(5,1,5)
hold on
plot(bestfit.exps.t_s{1}, bestfit.exps.exp_data{1}(:,4))
plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,4))
% plot(sim.sim.tsim{1}, cumResCov19(:,10))
title('Fat')
% set(gca, 'YScale', 'log')

saveas(gcf,[dire, 'SimulationVSData.png'])


%%




















