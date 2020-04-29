% Multiple datasets are available from Spain
% This script is based on the data in https://github.com/datadista/datasets/tree/master/COVID%2019
% to which the webpage collecting data used by the math initiative in Spain
% referred as an updated source. 

%% 
clc,clear all,close all; 
%% Perform request at GET URL.
URL_Spain_nac= 'https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/nacional_covid19.csv'; 

myreadtable = @(filename)readtable(filename,'HeaderLines',1, ...
    'Delimiter',{','},'MultipleDelimsAsOne',0);
options = weboptions('ContentReader',myreadtable);
data = webread(URL_Spain_nac,options);
data.Properties.VariableNames = {'Date','CumConfirmedCases','CumRecovered','CumDeath','CumICU','CumHospitalised'};
% Notes 
% CumConfirmedCases -> Accumulated cases confirmed (PCR or AB test)
% CumICU -> Accumulated cases which required ICU
% CumHospitalised -> Accumulated cases which require hospitalisation(includes CumICU)
%% 
figure; 
plot(1:size(data,1),data.CumConfirmedCases,...
    1:size(data,1),data.CumRecovered,...
    1:size(data,1),data.CumDeath,...
    1:size(data,1),data.CumICU,...
    1:size(data,1),data.CumHospitalised)
legend('Confirmed','Recovered','Death','ICU','Hospitalised')
%%
URL_Spain_iscii = 'https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/ccaa_covid19_datos_isciii.csv'; 
myreadtable = @(filename)readtable(filename,'HeaderLines',1, ...
    'Delimiter',{','},'MultipleDelimsAsOne',0);
options = weboptions('ContentReader',myreadtable);
data_iscii = webread(URL_Spain_nac,options);
data_iscii.Properties.VariableNames = {'Date', 'cod_ine', 'CCAA', 'CumConfirmedCases', 'PCRp','TestABp','CumHospitalised','CumICU','CumDeath','CumRecovered'};

