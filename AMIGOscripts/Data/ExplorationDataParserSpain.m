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
myreadtable = @(filename)readtable(filename,'HeaderLines',1, format,'%s%s'...
    'Delimiter',{','},'MultipleDelimsAsOne',0);
options = weboptions('ContentReader',myreadtable);
data_iscii = webread(URL_Spain_iscii,options);
data_iscii.Properties.VariableNames = {'Date', 'cod_ine', 'CCAA', 'CumConfirmedCases', 'PCRp','TestABp','CumHospitalised','CumICU','CumDeath','CumRecovered'};

% Compute the sum over coloumns of interest for each date
dates = unique(data_iscii.Date);
Confirmed = zeros(length(dates),1); 
Hospitalised = zeros(length(dates),1); 
ICU = zeros(length(dates),1); 
Deaths = zeros(length(dates),1); 
Recovered = zeros(length(dates),1); 


for i=1:length(dates)
    Confirmed(i)=nansum(data_iscii{data_iscii.Date == datestr(dates(i)),'CumConfirmedCases'});
    Hospitalised(i)=nansum(data_iscii{data_iscii.Date == datestr(dates(i)),'CumHospitalised'});
    ICU(i)=nansum(data_iscii{data_iscii.Date == datestr(dates(i)),'CumICU'});
    Deaths(i)=nansum(str2num(char(data_iscii{data_iscii.Date == datestr(dates(i)),'CumDeath'})));
    Recovered(i)=nansum(str2num(char(data_iscii{data_iscii.Date == datestr(dates(i)),'CumRecovered'})));

end
% figure; 
% plot(1:size(data,1),data.CumRecovered,...
%     1:length(Recovered),Recovered)
% legend('Recovered','Recovered2')
% 
% figure; 
% plot(1:size(data,1),data.CumHospitalised,...
%     1:length(Hospitalised),Hospitalised)
% legend('Hospitalised','Hospitalised')
% 
% figure; 
% plot(1:size(data,1),data.CumICU,...
%     1:length(ICU),ICU)
% legend('ICU','ICU2')

figure; 
plot(1:size(data,1),data.CumConfirmedCases,...
1:length(Confirmed),Confirmed);
legend('Confirmed','Confirmed2')

figure; 
plot(1:length(Confirmed),Confirmed,...
    1:length(Hospitalised),Hospitalised,...
    1:length(Recovered),Recovered,...
     1:length(ICU),ICU)
 legend('Confirmed','Hospitalised','Recovered','ICU')
%% Conclusions
% Based on the above graphs comparing the two datasets, we decided to 
% build the datastructure for PE using the data in ccaa_covid19_datos_isciii.csv
% Note that, these are cumulative data (no decrease in time) presenting discontinuities whenever
% there is a variation in the standard used to publish data (e.g. prevalence -> accumulated, 27/04/2020 Madrid)
% 








