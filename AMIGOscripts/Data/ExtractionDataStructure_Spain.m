% Extraction of data structure for parameter estimation from 
% 
clc,clear all,close all
DataTable = readtable('Spain_NationalData_20200429.csv'); 
%% Plot to try and understand the data
% % Total hospital is the sum of hospital and ICU
% figure; 
% plot(1:1:size(DataTable,1),DataTable.H_with_symptoms_cum,...
%      1:1:size(DataTable,1),DataTable.C_cum);
%  legend('Hospital','ICU')
 
% Total_cases_cum is the cumulative sum of positives 

%% Notes on equivalences between name of fields in the data and the model state variables
% Hospital: DataTable.H_with_symptoms_cum;
% ICU:  DataTable.C_cum;
% Recovered: DataTable.R_from_H_cum
% Death: DataTable.D_cum
% Infectious: DataTable.Total_cases_cum????


%% Structure creation
Data.exp_type{1} = 'fixed';
Data.n_obs{1} = 5;
Data.country_id{1} = 'ESP'; %added guide extraction of data on ICUBeds
Data.start_date{1} = datestr(DataTable.Date(1,1))
Data.end_date{1} = datestr(DataTable.Date(55,1))
% NOTE: due to the decrease in infected after the 14th April, upper bound
% is set to index 55
Data.obs_names{1} = char('Cum2Infected','Cum2Hospitalised', 'Cum2Critical', 'Cum2Recovered', 'Cum2Dead');                       
Data.obs{1} = char('Cum2Infected = ','CumHospitalised = ', 'CumCritical = ', 'CumRecovered = ', 'CumDead = '); 
Data.n_s{1} = size(DataTable,1)*ones(Data.n_obs{1},1);
Data.t_f{1} = daysact(datestr(DataTable.Date(1,1)),datestr(DataTable.Date(55,1)))*ones(Data.n_obs{1},1);
Data.t_s{1} = repmat([0:1:Data.t_f{1}],Data.n_obs{1},1);
Data.t_con{1} = []
Data.u{1} = []
Data.exp_data{1} = [DataTable.Total_cases_cum(1:55,1)';DataTable.H_with_symptoms_cum(1:55,1)';DataTable.C_cum(1:55,1)';DataTable.R_from_H_cum(1:55,1)';DataTable.D_cum(1:55,1)']
Data.error_data{1} = zeros(size(Data.exp_data{1}));
Data.n_pulses{1} = [];
Data.data_type{1} = 'real';
Data.noise_type{1} = 'hetero';

%% Save structure
save('SpainData_20200429.mat','Data');
