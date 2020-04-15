
%% Input (time varying parameter)
M_Ty = [0, 0.40, 0.60];
M_Tx = [daysact('1-feb-2002',  '1-feb-2002'), daysact('1-feb-2002',  '20-mar-2002'), daysact('1-feb-2002',  '25-mar-2002')];
T_endx = daysact('1-feb-2002',  '1-sep-2002');

%% Directory of AMIGO reults and others
foldnam = 'TestNeherModelCovid19_Rep1';
resultFileName = [strcat(foldnam),'.dat'];
rng shuffle;
rngToGetSeed = rng;
% Write the header information of the .dat file . 
fid = fopen(resultFileName,'w');
fprintf(fid,'HEADER DATE %s\n',datestr(datetime()));
fprintf(fid,'HEADER RANDSEED %d\n',rngToGetSeed.Seed);
fclose(fid);

startTime = datenum(now);

results_folder = strcat('TestNeherModelCovid19',datestr(now,'yyyy-mm-dd-HHMMSS'));
short_name     = strcat('TNMCov19',int2str(1));

%% Definition of AMIGO variables for inputs file
clear model;
clear exps;
clear best_global_theta;
clear pe_results;
clear pe_inputs;
clear inputs;

model = COVID19_NeherModel;
inputs.model = model;
inputs.pathd.results_folder = results_folder;                        
inputs.pathd.short_name     = short_name;
inputs.pathd.runident       = 'initial_setup';

%% Experiment

% Definition of initial conditions
ages = [39721484, 42332393, 46094077, 44668271, 40348398, 42120077, 38488173, 24082598, 13147180];
pop  = zeros(9, 9);
ages = ages / sum(ages);
sizes = 330000000;
cases = 9;

pop(1, :) = sizes * ages;
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
newExps.n_obs{1}=45;                                        % Number of observables per experiment        
newExps.obs_names{1} = char('Infected0','Hospitalised0', 'Critical0', 'Recovered0', 'Dead0',...
                            'Infected1','Hospitalised1', 'Critical1', 'Recovered1', 'Dead1',...
                            'Infected2','Hospitalised2', 'Critical2', 'Recovered2', 'Dead2',...
                            'Infected3','Hospitalised3', 'Critical3', 'Recovered3', 'Dead3',...
                            'Infected4','Hospitalised4', 'Critical4', 'Recovered4', 'Dead4',...
                            'Infected5','Hospitalised5', 'Critical5', 'Recovered5', 'Dead5',...
                            'Infected6','Hospitalised6', 'Critical6', 'Recovered6', 'Dead6',...
                            'Infected7','Hospitalised7', 'Critical7', 'Recovered7', 'Dead7',...
                            'Infected8','Hospitalised8', 'Critical8', 'Recovered8', 'Dead8');
                        
newExps.obs{1} = char('Infected0 = I_0','Hospitalised0 = H_0','Critical0 = C_0','Recovered0 = R_0','Dead0 = D_0',...
                      'Infected1 = I_1','Hospitalised1 = H_1','Critical1 = C_1','Recovered1 = R_1','Dead1 = D_1',...
                      'Infected2 = I_2','Hospitalised2 = H_2','Critical2 = C_2','Recovered2 = R_2','Dead2 = D_2',...
                      'Infected3 = I_3','Hospitalised3 = H_3','Critical3 = C_3','Recovered3 = R_3','Dead3 = D_3',...
                      'Infected4 = I_4','Hospitalised4 = H_4','Critical4 = C_4','Recovered4 = R_4','Dead4 = D_4',...
                      'Infected5 = I_5','Hospitalised5 = H_5','Critical5 = C_5','Recovered5 = R_5','Dead5 = D_5',...
                      'Infected6 = I_6','Hospitalised6 = H_6','Critical6 = C_6','Recovered6 = R_6','Dead6 = D_6',...
                      'Infected7 = I_7','Hospitalised7 = H_7','Critical7 = C_7','Recovered7 = R_7','Dead7 = D_7',...
                      'Infected8 = I_8','Hospitalised8 = H_8','Critical8 = C_8','Recovered8 = R_8','Dead8 = D_8');% Name of the observables 

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
inputs.ivpsol.senssolver='cvodes';
inputs.ivpsol.rtol=1.0D-10;
inputs.ivpsol.atol=1.0D-10;

inputs.plotd.plotlevel='noplot';

AMIGO_Prep(inputs);

simCov19 = AMIGO_SModel(inputs);

save('TestSimulationNeherModelAMIGO.mat','simCov19')






























