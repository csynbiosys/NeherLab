%% Inputs
%    -- epccOutputResultFileNameBase: Tag for the files generated
%    -- epcc_exps: Index of the parameter vector initial guess
%    -- global_theta_guess: Initial guess for the theta vector
%    -- expdata: Path for the matlab structure with the experimental data


function [] = PE_COVID19_V1(epccOutputResultFileNameBase,epcc_exps,global_theta_guess,expdata)
    
    %% Section taken from Processes (Lucia), helps me understand if there is
    % any errors or issues
    
    % Write the header information of the .dat file in which the results of
    % PE (estimates, relative confidence intervals, residuals, relative
    % residuals and the time required for computation) will be stored. 
    
    resultFileName = [strcat(epccOutputResultFileNameBase),'.dat'];
    rng shuffle;
    rngToGetSeed = rng;
    
    fid = fopen(resultFileName,'w');
    fprintf(fid,'HEADER DATE %s\n',datestr(datetime()));
    fprintf(fid,'HEADER RANDSEED %d\n',rngToGetSeed.Seed);
    fclose(fid);
    
    startTime = datenum(now);

    results_folder = strcat('NeherModelCovid19_PE',datestr(now,'yyyy-mm-dd-HHMMSS'));
    short_name     = strcat('TNMCov19',int2str(epcc_exps));
    
    addpath('../Model')
    addpath('.')
    
    %% Clear variables nedded by AMIGO
    
    clear inputs
    clear model;
    clear exps;
    clear best_global_theta;
    clear pe_results;
    clear pe_inputs;

    %% Load data to be fitted
    Dat = load(expdata);
    
    %% Load Model
    model = COVID19_NeherModel_V3_Over;
    inputs.model = model;
    inputs.model.par=Params_SIR([],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[5,5,5,5,5,5,5,5,5]); % Default theta vector, need to see how to modify this deppending on what do we wanna do

    inputs.pathd.results_folder = results_folder;                        
    inputs.pathd.short_name     = short_name;
    inputs.pathd.runident       = 'initial_setup';

    %% Compute Y0 (might not be required if we fit it)
    y0 = ComputeY0_COVID19_Over_WebApp([],[],inputs.model.par(1));
    
    %% Compute inputs for the model (this might need modifications deppending on what we wanna do or on how we handle the different parameters of the functions deppending on the data we have)
    % Example on how to define the mitigation measure structure
    mitigations = cell(1,2);
    mitigations{1,1}.val = 40; mitigations{1,1}.tmin = '1-feb-2020'; mitigations{1,1}.tmax = '1-sep-2020';
    % mitigations{1,2}.val = 60; mitigations{1,2}.tmin = '1-mar-2020'; mitigations{1,2}.tmax = '1-may-2020';

    [cp, M_Tx, M_Ty, T_endx] = Inputs_SIR([],[],[],mitigations);
    
    %% Define boundaries for the parameters (Need to discuss boundaries for the different parameters)
    global_theta_min = [0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0];
    global_theta_max = [10,10,10,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10];

    global_theta_guess = global_theta_guess';

    %% Training and validation set definition (Are we gonna do this???)
%     % Define a randomised vector with the indexes of the experiments
%     exps_indexall = [6,3,11,7,8,5,1,2,4,9,10,12];
% 
%     % Split the pseudo-data in training and test set
%     exps_indexTraining = exps_indexall(1:length(exps_indexall)/3*2);
%     exps_indexTest =  exps_indexall(length(exps_indexall)/3*2+1:end);

    %% Specifications for Parameter Estimation (Commented parts need to be modified once I know the structure of the data and if we use validation or not)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
                        %%%%%%%%%%%%%%%%%%%%%%       

%     exps.n_exp = length(exps_indexTraining);            % Number of experiments to be used in the multi-experiments fit

%     for iexp=1:length(exps_indexTraining)
%         exp_indexData = exps_indexTraining(iexp);
        exps.exp_type{iexp} = 'fixed'; 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NEED TO CHECK WITH THE DATA
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AVAILABLE OR MAIBE AUTOMATED
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FROM THE DATA STRUCTURE
        exps.n_obs{1}=7;                                        % Number of observables per experiment        
        exps.obs_names{1} = char('Infected','Hospitalised', 'Critical', 'Recovered', 'Dead', 'CumulativeHospital', 'CumulativeCritical');
        exps.obs{1} = char('Infected = Inf','Hospitalised = Sev','Critical = Cri','Recovered = Rec','Dead = Fat', 'CumulativeHospital = CumHos', 'CumulativeCritical = CumCri');% Name of the observables 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
%         exps.u_interp{iexp} = Data.u_interp{1,exp_indexData};
%         exps.t_f{iexp} = Data.t_con{1,exp_indexData}(end); 
%         exps.n_s{iexp} = Data.n_s{1,exp_indexData};
%         exps.t_s{iexp} = Data.t_s{1,exp_indexData}; 
%         exps.t_con{iexp} = Data.t_con{1,exp_indexData};
% 
%         if exp_indexData>3 && exp_indexData<7 % Pulses, requires to specify maximum and minimum value for the input
%             exps.n_pulses{iexp} = Data.n_pulses{1,exp_indexData};
%             exps.u_min{iexp} = Data.u_min{1,exp_indexData};
%             exps.u_max{iexp} = Data.u_max{1,exp_indexData};
%         else
%             exps.n_steps{iexp} = length(exps.t_con{iexp})-1;
%             exps.u{iexp} = Data.u{1,exp_indexData};
%         end

        exps.data_type = 'real'; 
        exps.noise_type = 'hetero';
%         exps.exp_data{iexp} = Data.exp_data{1,exp_indexData};
%         exps.error_data{iexp} = Data.error_data{1,exp_indexData};
        exps.exp_y0{iexp} = y0;
%     end


    %% Parameters to fit
    best_global_theta = global_theta_guess; % Need to add modifications in this vector (here or from outside) so it takes the necessary default values
    param_including_vector = [false,false,false,false,false,false,false,false,false,false,...
                                false,false,false,false,false,false,false,false,false,false,...
                                false,false,false,false,false,false,false,false,false,false,...
                                false,false,false,false,false,false,false,false,false,false,...
                                false,false,false,false,false,false,false];


    %% Define inputs structure for AMIGO
    inputs.exps  = exps;

    % GLOBAL UNKNOWNS (SAME VALUE FOR ALL EXPERMENTS)
    inputs.PEsol.id_global_theta=model.par_names(param_including_vector,:);
    inputs.PEsol.global_theta_guess=transpose(best_global_theta(param_including_vector));
    inputs.PEsol.global_theta_max=global_theta_max(param_including_vector);  % Maximum allowed values for the parameters
    inputs.PEsol.global_theta_min=global_theta_min(param_including_vector);  % Minimum allowed values for the parameters
    
    % % GLOBAL INITIAL CONDITIONS (Change this is multi-data fit will be done)
     inputs.PEsol.id_global_theta_y0=char('Sus_0','Exp1_0','Exp2_0','Exp3_0','Inf_0','Sev_0','Cri_0','Ovf_0','Rec_0','Fat_0','CumHos_0','CumCri_0', ...
                    'Sus_1','Exp1_1','Exp2_1','Exp3_1','Inf_1','Sev_1','Cri_1','Ovf_1','Rec_1','Fat_1','CumHos_1','CumCri_1', ...
                    'Sus_2','Exp1_2','Exp2_2','Exp3_2','Inf_2','Sev_2','Cri_2','Ovf_2','Rec_2','Fat_2','CumHos_2','CumCri_2', ...
                    'Sus_3','Exp1_3','Exp2_3','Exp3_3','Inf_3','Sev_3','Cri_3','Ovf_3','Rec_3','Fat_3','CumHos_3','CumCri_3', ...
                    'Sus_4','Exp1_4','Exp2_4','Exp3_4','Inf_4','Sev_4','Cri_4','Ovf_4','Rec_4','Fat_4','CumHos_4','CumCri_4', ...
                    'Sus_5','Exp1_5','Exp2_5','Exp3_5','Inf_5','Sev_5','Cri_5','Ovf_5','Rec_5','Fat_5','CumHos_5','CumCri_5', ...
                    'Sus_6','Exp1_6','Exp2_6','Exp3_6','Inf_6','Sev_6','Cri_6','Ovf_6','Rec_6','Fat_6','CumHos_6','CumCri_6', ...
                    'Sus_7','Exp1_7','Exp2_7','Exp3_7','Inf_7','Sev_7','Cri_7','Ovf_7','Rec_7','Fat_7','CumHos_7','CumCri_7', ...
                    'Sus_8','Exp1_8','Exp2_8','Exp3_8','Inf_8','Sev_8','Cri_8','Ovf_8','Rec_8','Fat_8','CumHos_8','CumCri_8');             % [] 'all'|User selected| 'none' (default)
     inputs.PEsol.global_theta_y0_max=repelem(1000, 108);                % Maximum allowed values for the initial conditions
     inputs.PEsol.global_theta_y0_min=repelem(0, 108);                % Minimum allowed values for the initial conditions
     inputs.PEsol.global_theta_y0_guess=y0;              % [] Initial guess
    
    % % LOCAL UNKNOWNS (DIFFERENT VALUES FOR DIFFERENT EXPERIMENTS)
    % 
    % inputs.PEsol.id_local_theta{1}='none';                % [] 'all'|User selected| 'none' (default)
    % % inputs.PEsol.local_theta_max{iexp}=[];              % Maximum allowed values for the paramters
    % % inputs.PEsol.local_theta_min{iexp}=[];              % Minimum allowed values for the parameters
    % % inputs.PEsol.local_theta_guess{iexp}=[];            % [] Initial guess
    % inputs.PEsol.id_local_theta_y0{1}='none';             % [] 'all'|User selected| 'none' (default)
    % % inputs.PEsol.local_theta_y0_max{iexp}=[];           % Maximum allowed values for the initial conditions
    % % inputs.PEsol.local_theta_y0_min{iexp}=[];           % Minimum allowed values for the initial conditions
    % % inputs.PEsol.local_theta_y0_guess{iexp}=[];         % [] Initial guess
 


    % COST FUNCTION RELATED DATA (Check if we are gonna use this or something else)
    inputs.PEsol.PEcost_type='lsq';                       % 'lsq' (weighted least squares default) | 'llk' (log likelihood) | 'user_PEcost'
    inputs.PEsol.lsq_type='Q_expmax';

    % SIMULATION
    inputs.ivpsol.ivpsolver='cvodes';
    inputs.ivpsol.senssolver='fdsens5';
    inputs.model.positiveStates=1;
    inputs.ivpsol.rtol=1.0D-11;
    inputs.ivpsol.atol=1.0D-11;

    
    % OPTIMIZATION (Check if we are gonna use this or something else)
    inputs.nlpsol.nlpsolver='eSS';
    inputs.nlpsol.eSS.maxeval = 200000;
    inputs.nlpsol.eSS.maxtime = 5000;
%     inputs.nlpsol.eSS.log_var = [1 2 3 4 5 6 7 8]; % Modify this according to the parameters we want to fit
    inputs.nlpsol.eSS.local.solver = 'lsqnonlin'; 
    inputs.nlpsol.eSS.local.finish = 'lsqnonlin';
    inputs.rid.conf_ntrials=500;
    inputs.plotd.plotlevel='noplot';

    %% Run
    AMIGO_Prep(inputs);
    
    pe_start = now;
    pe_inputs = inputs;
    results = AMIGO_PE(inputs);
    pe_results = results;
    pe_end = now;
    
    % Save the best theta
    best_global_theta(param_including_vector) = results.fit.thetabest;
    
    % Write results to the output file
    fid = fopen(resultFileName,'a');
    used_par_names = model.par_names(param_including_vector,:);
    
    for j=1:size(used_par_names,1)
        fprintf(fid,'PARAM_FIT %s %f\n', used_par_names(j,:), results.fit.thetabest(j));
    end
 
    % Time in seconds
    fprintf(fid,'PE_TIME %.1f\n', (pe_end-pe_start)*24*60*60);
    fclose(fid);
  
    save([strcat(epccOutputResultFileNameBase,'.mat')],'pe_results','exps','pe_inputs','best_global_theta');
    
    
    %% Simulation of validation set????
    
    
    
    
    
    

end





















