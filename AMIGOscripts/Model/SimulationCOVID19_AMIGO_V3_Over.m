%% To Do
    % Generalise things once it works fine

%% Input (time varying parameter)

% Example on how to define the mitigation measure structure
% mitigations = cell(1,2);
% mitigations{1,1}.val = 40; mitigations{1,1}.tmin = '1-feb-2020'; mitigations{1,1}.tmax = '1-sep-2020';
% mitigations{1,2}.val = 60; mitigations{1,2}.tmin = '1-mar-2020'; mitigations{1,2}.tmax = '1-may-2020';

[cp, M_Tx, M_Ty, T_endx] = Inputs_SIR([],[],[],[]);


%% Directory of AMIGO reults and others
foldnam = 'TestNeherModelCovid19_Rep3';
resultFileName = [strcat(foldnam),'.dat'];
rng shuffle;
rngToGetSeed = rng;
% Write the header information of the .dat file . 
fid = fopen(resultFileName,'w');
fprintf(fid,'HEADER DATE %s\n',datestr(datetime()));
fprintf(fid,'HEADER RANDSEED %d\n',rngToGetSeed.Seed);
fclose(fid);

startTime = datenum(now);

results_folder = strcat('TestNeherModelCovid19_V3',datestr(now,'yyyy-mm-dd-HHMMSS'));
short_name     = strcat('TNMCov19',int2str(1));

%% Definition of AMIGO variables for inputs file
clear model;
clear exps;
clear best_global_theta;
clear pe_results;
clear pe_inputs;
clear inputs;

model = COVID19_NeherModel_V3_Over;
inputs.model = model;
inputs.model.par=Params_SIR([],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[5,5,5,5,5,5,5,5,5]);

inputs.pathd.results_folder = results_folder;                        
inputs.pathd.short_name     = short_name;
inputs.pathd.runident       = 'initial_setup';

%% Experiment

y0 = ComputeY0_COVID19_Over([],[],inputs.model.par);

% Time definition
duration = T_endx;               % Duration in of the experiment (days)

% Experiment
clear newExps;
newExps.n_exp = 1;                                         % Number of experiments 
newExps.n_obs{1}=7;                                        % Number of observables per experiment        
newExps.obs_names{1} = char('Infected0','Hospitalised0', 'Critical0', 'Recovered0', 'Dead0', 'CumulativeHospital', 'CumulativeCritical');
                        
newExps.obs{1} = char('Infected0 = Inf_0','Hospitalised0 = Sev_0','Critical0 = Cri_0','Recovered0 = Rec_0','Dead0 = Fat_0', 'CumulativeHospital = CumHos_0', 'CumulativeCritical = CumCri_0');% Name of the observables 

newExps.exp_y0{1}=y0;                                      % Initial condition for the experiment    

newExps.t_f{1}=duration;                                   % Experiment duration
newExps.n_s{1}=duration;                             % Number of sampling times
newExps.t_s{1}=0:duration;                              % Times of samples

newExps.u_interp{1}='step';                                % Interpolating function for the input
newExps.n_steps{1}=length(M_Ty);                  % Number of steps in the input
newExps.u{1}= [M_Ty;cp];                                     % Time course of mitigation measures values for the input
newExps.t_con{1}=[M_Tx,T_endx];                     % Switching times
% newExps.t_con{1}(1) = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mock the experiment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inputs.exps = newExps;

inputs.exps.data_type='pseudo';
inputs.exps.noise_type='hetero_proportional';
inputs.exps.std_dev{1}=[0.0 0.0];

%% SIMULATION
inputs.ivpsol.ivpsolver='cvodes';
inputs.ivpsol.senssolver='fdsens5';
inputs.model.positiveStates=1;
inputs.ivpsol.rtol=1.0D-11;
inputs.ivpsol.atol=1.0D-11;

inputs.plotd.plotlevel='noplot';

AMIGO_Prep(inputs);

warning('off','MATLAB:MKDIR:DirectoryExists')
addpath('AMIGOChanged')

simCov19 = AMIGO_SModel_NoVer(inputs);


save('TestSimulationNeherModelAMIGO_V3_Over.mat','simCov19')






























