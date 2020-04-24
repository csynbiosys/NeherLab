%% To Do
    % Generalise things once it works fine

%% Input (time varying parameter)
NumDays = '1-sep-2020'; % Last day of the simulation
peakMonth = 0; %Peak month from 0 to 11
difda = daysact('1-jan-2020', '1-feb-2020'); % Offset of the first day of the simulation and the first day of the year
month2day = @(x) x*30+15; % Function from Neher code to get peak of seasonality of the month
maxd = daysact('1-feb-2020', NumDays); % Days of the simulation
da = 1:maxd; % String of days of the simulation
cp = cos(2*pi*(((da+difda)/365)-(month2day(peakMonth)/365))); % Cosine function
%% hp: Sequential
% % M1 Period = 01-feb-2020:01-mar-2020, Intensity =40;
% % M2 Period = 01-mar-2020:01-aug-2020, Intensity = 60;
% % M3 Period = 01-aug-2020:01-sep-2020, Intensity = 0; % this corresponds to no control
D_M1 = daysact('1-feb-2020', '01-mar-2020'); %duration M1
D_M2 = daysact('01-mar-2020','1-aug-2020'); %duration M2
D_M3 = daysact('1-aug-2020','1-sep-2020');
M = zeros(1,length(cp));
M(1,1:D_M1) = 40;
M(1,D_M1:D_M1+D_M2) = 60;
M(1,D_M1+D_M2:end) = 0;


M_Ty = 1-M./100; % Value of M(t) per day, realised that the value used in code is 1 minus the one selected in the app. This still does not consider when there is more than one measure

%% Test with 1 measure
% % % M1 Period = 01-feb-2020:01-03-2020, Intensity =40;
% M = zeros(1,length(cp));
% %M(1,1:daysact('1-feb-2020', '01-mar-2020')) = 40; %1 month only
% M(1,1:daysact('1-feb-2020', '01-sep-2020')) = 40; % constant through the period
% M_Ty = 1-M./100;
%%
% % hp: Overlap ---> This does not work yet
% M1 Period = 01-feb-2020:15-03-2020, Intensity =0.4;
% M2 Period = 01-03-2020:01-08-2020, Intensity = 0.6;
% M3 Period = 01-08-2020:01-09-2020, Intensity = 0.6;
%  M = ones(1,length(cp));
%  M1 = M; 
%  M1(1,1:daysact('1-feb-2020', '15-mar-2020')) = 0.40;
%  M2 = M;
%  ind1 = daysact('1-feb-2020', '1-mar-2020');
%  %ind2 = daysact('1-mar-2020', '1-aug-2020');
%  M2(1,ind1:end) = 0.60;
%  Mp = M1.*M2; 
%  Mp(Mp==1)=0;
%  M_Ty = 1-Mp; % Value of M(t) per day, realised that the value used in code is 1 minus the one selected in the app. This still does not consider when there is more than one measure
%%
M_Tx = 1:length(cp); % Time vector for the input
T_endx = length(cp); % Maximum number of days. It should be equal to maxd


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

model = COVID19_NeherModel_V3_NoOver2;
inputs.model = model;
inputs.model.par=ParamsModel();

inputs.pathd.results_folder = results_folder;                        
inputs.pathd.short_name     = short_name;
inputs.pathd.runident       = 'initial_setup';

%% Experiment

% Definition of initial conditions
agess = [39721484, 42332393, 46094077, 44668271, 40348398, 42120077, 38488173, 24082598, 13147180]; % age distribution of USA
pop  = zeros(11, 9);
ages = agess / sum(agess);
sizes = sum(agess);
cases = 8;

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
% inputs.ivpsol.ivpsolver='cvodes'; % Luci
% inputs.ivpsol.senssolver='fdsens5'; %Luci
% inputs.ivpsol.rtol=1.0D-13;
% inputs.ivpsol.atol=1.0D-13;

% inputs.plotd.plotlevel='noplot';

MInputs = AMIGO_Prep(inputs);

warning('off','MATLAB:MKDIR:DirectoryExists')
addpath('AMIGOChanged')
% 
% simCov19 = AMIGO_SModel_NoVer(inputs); % Luci


save('TestSimulationNeherModelAMIGO_V3_NoOver.mat','simCov19')






























