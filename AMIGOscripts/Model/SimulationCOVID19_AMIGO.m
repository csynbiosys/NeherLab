
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
short_name     = strcat('TNMCov19',int2str(epcc_exps));

%% Definition of AMIGO variables for inputs file
clear model;
clear exps;
clear best_global_theta;
clear pe_results;
clear pe_inputs;

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
size = 330000000;
cases = 9;

pop(1, :) = size * ages;
pop(1, :) = pop(1, :) - cases*ages;
pop(5, :) = pop(5, :) + cases*ages*0.3;
pop(2, :) = pop(2, :) + cases*ages*0.7/3;
pop(3, :) = pop(3, :) + cases*ages*0.7/3;
pop(4, :) = pop(4, :) + cases*ages*0.7/3;

y0 = pop(:);

% Time definition
duration = T_endx;               % Duration in of the experiment (days)

% Experiment
clear newExps;
newExps.n_exp = 1;                                         % Number of experiments 
newExps.n_obs{1}=45;                                        % Number of observables per experiment        
newExps.obs_names{1} = char('Infected0','Hospitalised0', 'Critical0', 'Recovered0', 'Dead0',...
                            'Infected1','Hospitalised1', 'Critical1', 'Recovered1', 'Dead1',...
                            'Infected2','Hospitalised1', 'Critical1', 'Recovered1', 'Dead1',...
                            'Infected3','Hospitalised1', 'Critical1', 'Recovered1', 'Dead1',...
                            'Infected4','Hospitalised1', 'Critical1', 'Recovered1', 'Dead1',...
                            'Infected5','Hospitalised1', 'Critical1', 'Recovered1', 'Dead1',...
                            'Infected6','Hospitalised1', 'Critical1', 'Recovered1', 'Dead1',...
                            'Infected7','Hospitalised1', 'Critical1', 'Recovered1', 'Dead1',...
                            'Infected8','Hospitalised1', 'Critical1', 'Recovered1', 'Dead1');
newExps.obs{1} = char('LacI_M1 = L_RFP','TetR_M1 = T_GFP');% Name of the observables 

newExps.exp_y0{1}=y0;                                      % Initial condition for the experiment    

newExps.t_f{1}=duration;                                   % Experiment duration
newExps.n_s{1}=duration/5 + 1;                             % Number of sampling times
newExps.t_s{1}=0:5:duration ;                              % Times of samples

newExps.u_interp{1}='step';                                % Interpolating function for the input
newExps.n_steps{1}=round(duration/Stepd);                  % Number of steps in the input
newExps.u{1}= inducer;                                     % IPTG and aTc values for the input
newExps.t_con{1}=[0:180:1440];                     % Switching times



































