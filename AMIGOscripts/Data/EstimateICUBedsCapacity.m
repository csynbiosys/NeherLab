% This script analyses the ICU beds capability in Italy, Spain and UK 
% In the most recent survey on critical care bed numbers ('The variability
% of critical care bed numbers in Europe',2012), the number of critical
% care bed numbers is computed as a percentage of acute care bed numbers
% ,obtained from a document 2009 of the WHO, based on secondary info (https://link.springer.com/article/10.1007/s00134-012-2627-8/tables/2). 
% Not having access to updated info and given the time elapsed from the
% data, here I compare 
% - the number of ICU beds in the reference above
% - the number of ICU beds computed applying the same percentage value to
% updated data from WHO and considering the current population in each
% county
% - the value reported in papers on covid-19 response

%%
clc,clear all,close all; 
%%
AcuteCareBeds_WHO_2015 = [274.57, 238.54, 227.79];

% expressed over 10^5 population
% _2015 taken from:  add name of the file
%   Italy - last updated 2013
%   Spain - last updated 2014
%   UK - last updated 2014

% _2009 taken from: https://link.springer.com/article/10.1007/s00134-012-2627-8/tables/2 


ICU_beds = [3.7, 3.6, 2.8];
% expressed as a percentage of the AcuteCareBeds

Population = [60461825,46754778,67886011];
% Sum of age distribution available in DataSources.m
% they are slightly different from the value you can find in worldometer (https://www.worldometers.info/world-population/) [60476784,46828975,67825650]
% on the 29/04/2020


AcuteCareBeds_WHO_Total_2015 = AcuteCareBeds_WHO_2015.*Population/1e5;
AcuteCareBeds_WHO_Total_2009 = [201932, 124194, 147809];
% _2009 taken from the table referenced above

ICU_beds_2015on = ICU_beds.*AcuteCareBeds_WHO_Total_2015/100;
ICU_beds_2009 =  ICU_beds.*AcuteCareBeds_WHO_Total_2009/100;

ICU_beds = [ICU_beds_2009',ICU_beds_2015on'];

figure; 
bar(ICU_beds)
legend('2009','inferred 2015')
xticklabels({'Italy','Spain','UK'})

% Note: the value for Italy is an overestimate of the value reported in 
% 'How italian hospitals added 800ICU beds in 2 weeks response to the
% pandemic', which states
% 20/03/2020: 5712
% 20/02/2020: 5100

%% Export results
Header = {'Country','ICUBeds'};
Country = {'ITA','ESP','GBR'};
T = table(Country',round(ICU_beds_2009)','VariableNames',Header');

writetable(T,'ICUBedsCapacity.csv')
