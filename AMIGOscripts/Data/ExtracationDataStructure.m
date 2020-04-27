% Extraction of data structure for parameter estimation from 
% 

DataTable = readtable('Italy_NationalData_20200426.csv'); 
%% Plot to try and understand the data
% % prof that Total hospital is the sum of hospital and ICU
% figure; 
% plot(1:1:size(DataTable,1),DataTable.H_with_symptoms,...
%      1:1:size(DataTable,1),DataTable.C,...
%      1:1:size(DataTable,1),DataTable.Total_H_C);
%  legend('Hospital','ICU','TotalHospital')
%  
% DataTable.Total_H_C ==  DataTable.H_with_symptoms+DataTable.C
% % Proof that total_cases is the sum of positives (home, hospital), deaths
% % and recovered
% DataTable.Total_cases == DataTable.Total_positive_H_C_Home+DataTable.D_cum+DataTable.R_from_H;
% figure; 
% plot(1:1:size(DataTable,1),DataTable.Total_cases,...
%      1:1:size(DataTable,1),DataTable.Total_positive_H_C_Home);
% legend('TotalCases','TotalPositives')
%% Notes on equivalences between name of fields in the data and the model state variables
% Hospital DataTable.H_with_symptoms;
% ICU DataTable.C;
% Recovered DataTable.R_from_H
% Death DataTable.D
% Infectious DataTable.Home_confinement


%% Structure creation
Data.exp_type{1} = 'fixed';
Data.n_obs{1} = 5;
Data.start_date{1} = datestr(DataTable.Date(1,1))
Data.end_date{1} = datestr(DataTable.Date(end,1))
Data.obs_names{1} = char('CumInfected','CumHospitalised', 'CumCritical', 'CumRecovered', 'CumDead');                       
Data.obs{1} = char('CumInfected = ','CumHospitalised = ', 'CumCritical = ', 'CumRecovered = ', 'CumDead = '); 
Data.n_s{1} = size(DataTable,1)*ones(Data.n_obs{1},1);
Data.t_f{1} = daysact(datestr(DataTable.Date(1,1)),datestr(DataTable.Date(end,1)))*ones(Data.n_obs{1},1);
Data.t_s{1} = repmat([0:1:Data.t_f{1}],Data.n_obs{1},1);
Data.t_con{1} = []
Data.u{1} = []
Data.exp_data{1} = [DataTable.Home_confinement';DataTable.H_with_symptoms';DataTable.C';DataTable.R_from_H';DataTable.D_cum']
Data.error_data{1} = zeros(size(Data.exp_data{1}));
Data.n_pulses{1} = [];
Data.data_type{1} = 'real';
Data.noise_type{1} = 'hetero';

%% Save structure
save('ItalyData_20200426.mat','Data');
