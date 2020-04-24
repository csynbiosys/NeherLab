%% To Do
    % Generalise things once it works fine

%% Input (time varying parameter)
M_Ty = [0, 40, 60]/100;
M_Tx = [daysact('1-feb-2020',  '1-feb-2020'), daysact('1-feb-2020',  '20-mar-2020'), daysact('1-feb-2020',  '25-mar-2020')];
T_endx = daysact('1-feb-2020',  '1-sep-2020');

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

model = COVID19_NeherModel_V3;
inputs.model = model;
inputs.model.par=ParamsModel();

inputs.pathd.results_folder = results_folder;                        
inputs.pathd.short_name     = short_name;
inputs.pathd.runident       = 'initial_setup';

%% Experiment

% Definition of initial conditions
agess = [39721484, 42332393, 46094077, 44668271, 40348398, 42120077, 38488173, 24082598, 13147180];
pop  = zeros(12, 9);
ages = agess / sum(agess);
sizes = sum(agess);
cases = 9;

pop(1, :) = agess;
pop(1, :) = pop(1, :) - cases*ages;
pop(5, :) = pop(5, :) + cases*ages*0.3;
pop(2, :) = pop(2, :) + cases*ages*0.7/3;
pop(3, :) = pop(3, :) + cases*ages*0.7/3;
pop(4, :) = pop(4, :) + cases*ages*0.7/3;

y0 = pop(:)';

% Time definition
duration = T_endx;               % Duration in of the experiment (days)

% Experiment
clear newExps;
newExps.n_exp = 1;                                         % Number of experiments 
newExps.n_obs{1}=8;                                        % Number of observables per experiment        
newExps.obs_names{1} = char('Infected0','Hospitalised0', 'Critical0', 'Recovered0', 'Dead0', 'Overflow0', 'CumulativeHospital', 'CumulativeCritical');
                        
newExps.obs{1} = char('Infected0 = Inf_0','Hospitalised0 = Sev_0','Critical0 = Cri_0','Recovered0 = Rec_0','Dead0 = Fat_0', 'Overflow0 = Ovf_0', 'CumulativeHospital = CumHos_0', 'CumulativeCritical = CumCri_0');% Name of the observables 

newExps.exp_y0{1}=y0;                                      % Initial condition for the experiment    

newExps.t_f{1}=duration;                                   % Experiment duration
newExps.n_s{1}=duration;                             % Number of sampling times
newExps.t_s{1}=0:duration-1;                              % Times of samples

newExps.u_interp{1}='step';                                % Interpolating function for the input
newExps.n_steps{1}=length(M_Ty);                  % Number of steps in the input
newExps.u{1}= M_Ty;                                     % Time course of mitigation measures values for the input
newExps.t_con{1}=[M_Tx-1,T_endx-1];                     % Switching times
newExps.t_con{1}(1) = 0;

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
inputs.ivpsol.rtol=1.0D-13;
inputs.ivpsol.atol=1.0D-13;

inputs.plotd.plotlevel='full';

AMIGO_Prep(inputs);

simCov19 = AMIGO_SModel(inputs);

save('TestSimulationNeherModelAMIGO_V3.mat','simCov19')






























