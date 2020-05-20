%% Directory and file names

maind = ['E:\UNI\D_Drive\PhD\Year_1\2020_04_7_COVID19\GitRepo\AMIGOscripts\NoInfected\'];
dire = [maind, '\Instance5\'];
ftag = ['PE_Test9_NoInfected_IOC_Error03_HigherBounds_NoParams_MoreIter-'];

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
Dat = load(['../Data/','ItalyData_20200415','.mat']);
clear inputs;
inputs.model = x.pe_inputs.model;
inputs.pathd.results_folder = x.pe_inputs.pathd.results_folder;
inputs.pathd.short_name     = x.pe_inputs.pathd.short_name;
inputs.pathd.runident       ='-sim';
inputs.plotd.plotlevel='noplot';
        
        
AMIGO_Prep(inputs);

for j=1:100
    
    try
        x = load([dire,ftag,num2str(j),'.mat']);
        
        best_global_theta =  x.pe_inputs.model.par;
        clear exps;
        exps.n_exp = length(Dat.Data.exp_data);
    
    
        for iexp=1:length(Dat.Data.exp_data)
            %% Compute inputs for the model (this might need modifications deppending on what we wanna do or on how we handle the different parameters of the functions deppending on the data we have)
            % Example on how to define the mitigation measure structure
            mitigations = cell(1,2);
            mitigations{1,1}.val = 40; mitigations{1,1}.tmin = Dat.Data.start_date{iexp}; mitigations{1,1}.tmax = Dat.Data.end_date{iexp};
    %         mitigations{1,2}.val = 60; mitigations{1,2}.tmin = '1-mar-2020'; mitigations{1,2}.tmax = Dat.Data.end_date{iexp};

            try
                [cp, M_Tx, ~, ~] = Inputs_SIR(Dat.Data.start_date{iexp},Dat.Data.end_date{iexp},0,mitigations);
                M_Ty = min(max(1-ExtractMitigation_NoInfected(Dat.Data.country_id{iexp}, Dat.Data.start_date{iexp},Dat.Data.end_date{iexp}),0.01),1);
%                 M_Ty = ExtractMitigation_NoInfected(Dat.Data.country_id{iexp}, Dat.Data.start_date{iexp},Dat.Data.end_date{iexp});
%                 M_Ty = 1-(0.5 + ((M_Ty-0)*(1-0.5))/(1-0));
            catch
                [cp, M_Tx, M_Ty, ~] = Inputs_SIR(Dat.Data.start_date{iexp},Dat.Data.end_date{iexp},0,mitigations);
            end
            M_Ty = x.pe_results.ioc.u{1}(1,:);
            %         exp_indexData = exps_indexTraining(iexp);
            exps.exp_type{iexp} = Dat.Data.exp_type{1}; 

            exps.n_obs{iexp}=Dat.Data.n_obs{iexp}-1;                                        % Number of observables per experiment        
            exps.obs_names{iexp} = Dat.Data.obs_names{iexp}(2:end,:);
            exps.obs{iexp} = GetObser_V2_NoInfected(Dat.Data.obs{iexp});% Name of the observables 
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Considers that we have the same number of points for each observable
            exps.u_interp{iexp} = 'step';
            exps.u{iexp} = [M_Ty;cp];
            exps.t_con{iexp} = M_Tx;

            exps.t_f{iexp} = Dat.Data.t_f{iexp}(1); 
            exps.n_s{iexp} = Dat.Data.n_s{iexp}(1);
            exps.t_s{iexp} = Dat.Data.t_s{iexp}(1,:);

    %         if isempty(Dat.Data.t_con{1})
    %             exps.t_con{iexp} = [Dat.Data.t_s{iexp}(1,1),Dat.Data.t_s{iexp}(1,end)]; %%%%%%%%%%%%%%%%%%%%% Check if this is needed
    %         else
    %             exps.t_con{iexp} = Dat.Data.t_con{iexp};
    %         end

            exps.data_type = Dat.Data.data_type{iexp}; 
            exps.noise_type = Dat.Data.noise_type{iexp};
            exps.exp_data{iexp} = Dat.Data.exp_data{iexp}(2:end,:)';
            exps.error_data{iexp} = Dat.Data.error_data{iexp}(2:end,:)';
            
            r = 1:12:108;
            r2 = 1:5:45;
            r3 = 5:12:length(x.pe_inputs.exps.exp_y0{1});
            for i=1:9
                x.pe_inputs.exps.exp_y0{1}(r(i)+1:r(i)+3) = x.pe_results.ioc.uy0(r2(i):r2(i)+2);
                x.pe_inputs.exps.exp_y0{1}(r(i)+4) = x.pe_results.ioc.uy0(r2(i)+3);
                x.pe_inputs.exps.exp_y0{1}(r(i)+7) = x.pe_results.ioc.uy0(r2(i)+4);

                temp = x.pe_inputs.exps.exp_y0{1}(r(i)+1:r(i)+9);
                temp(8) = [];
                age = AgeDistributions('ITA');
                x.pe_inputs.exps.exp_y0{1}(r(i)) = age(i) -sum(temp);

            end

            %%%%%%%%%%%%%%%%%%%%% 
            y0 =  x.pe_inputs.exps.exp_y0{1};
            
            exps.exp_y0{iexp} = y0;


        end
        
        
        inputs.model.par = best_global_theta;
        
        inputs.model.par(2)=1;
        inputs.model.par(3) = 0;
        
        inputs.exps  = exps;

        
        
        inputs.ivpsol.ivpsolver='cvodes';
        inputs.ivpsol.senssolver='fdsens5';
        inputs.model.positiveStates=1;
        inputs.ivpsol.rtol=1.0D-8;
        inputs.ivpsol.atol=1.0D-8;


        sim_results = AMIGO_SObs(inputs);
        
    
        %% Figure out index for validation
%         fdf = Dat.Data.start_date{1};
%         lsf = '16-Apr-2020'; % The date is not inclusive
%         
%         trd = daysact(fdf, lsf);
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Compute SSE on the test set
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ADD THE NORMALISATION BY THE EXPERIMENTAL MAXIMUM FOR NO VIAS????? 
        SSE = zeros(length(Dat.Data.exp_data),(Dat.Data.n_obs{iexp}-1));
        nanpres = zeros(1,length(Dat.Data.exp_data));
        for iexp=1:length(Dat.Data.exp_data)

            if sum(sum(isnan(sim_results.sim.sim_data{iexp}(:,:))))~=0
                nanpres(1,iexp) = 1;
            end
            SSE(iexp,:) = sum((Dat.Data.exp_data{1,iexp}(2:end,:)'-sim_results.sim.sim_data{iexp}(:,:)).^2,'omitnan');
        end

        sim_inputs = inputs;
        sim_exps = exps;
        save([strcat(dire,'\SimRun-',num2str(j),'.mat')],'sim_results','sim_inputs','sim_exps','best_global_theta','SSE','nanpres');
    
    catch
    end
    
end

cfvs = nan(1,100);
for i=1:100
   try
       x = load([dire,'\SimRun-',num2str(i),'.mat']);
       cfvs(i) = sum(x.SSE);
   catch
   end
end

micf = min(cfvs);
bestind = find(cfvs==min(cfvs));
bestind = bestind(1);

bestfit = load([dire,ftag,num2str(bestind),'.mat']);
bestsim = load([dire,'\SimRun-',num2str(bestind),'.mat']);
save([dire,'BestFit.mat'],'bestfit','bestsim')


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
[a,b] = size(bestsim.sim_results.sim.states{1});

cumResCov19 = zeros(a,(b)/9);
r = 1:12:b;
for i=1:12 % States    
    for j=1:9 % Agge groups
        cumResCov19(:,i) = cumResCov19(:,i) + bestsim.sim_results.sim.states{1}(:,r(j));
    end
    r = r+1;
end

%%

Dat = load(['../Data/','ItalyData_20200415','.mat']);

figure
subplot(5,1,1)
hold on
plot(Dat.Data.t_s{1}(1,:), Dat.Data.exp_data{1}(1,:))
% plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,1))
plot(bestsim.sim_results.sim.tsim{1}, cumResCov19(:,5))

title('Inf')
% set(gca, 'YScale', 'log')

subplot(5,1,2)
hold on
plot(Dat.Data.t_s{1}(1,:), Dat.Data.exp_data{1}(2,:))
% plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,1))
plot(bestsim.sim_results.sim.tsim{1}, cumResCov19(:,6))

title('Sev')
% set(gca, 'YScale', 'log')


subplot(5,1,3)
hold on
plot(Dat.Data.t_s{1}(1,:), Dat.Data.exp_data{1}(3,:))
% plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,2))
plot(bestsim.sim_results.sim.tsim{1}, cumResCov19(:,7))
title('Cri')
% set(gca, 'YScale', 'log')


subplot(5,1,4)
hold on
plot(Dat.Data.t_s{1}(1,:), Dat.Data.exp_data{1}(4,:))
% plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,3))
plot(bestsim.sim_results.sim.tsim{1}, cumResCov19(:,9))
title('Rec')
% set(gca, 'YScale', 'log')


subplot(5,1,5)
hold on
plot(Dat.Data.t_s{1}(1,:), Dat.Data.exp_data{1}(5,:))
% plot(bestfit.pe_results.sim.tsim{1}, bestfit.pe_results.sim.obs{1}(:,4))
plot(bestsim.sim_results.sim.tsim{1}, cumResCov19(:,10))
title('Fat')
% set(gca, 'YScale', 'log')

saveas(gcf,[dire, 'SimulationVSData.png'])


%%




















