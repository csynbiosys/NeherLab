
%Perform request at GET URL.
URL_Spain_iscii= 'https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/ccaa_covid19_datos_isciii.csv'; 

myreadtable = @(filename)readtable(filename,'HeaderLines',1,'Delimiter',{','},'MultipleDelimsAsOne',0); % options required to correctly decode the table
options = weboptions('ContentReader',myreadtable);
data_iscii = webread(URL_Spain_iscii,options);
data_iscii.Properties.VariableNames = {'Date', 'cod_ine', 'CCAA', 'CumConfirmedCases', 'PCRp','TestABp','CumHospitalised','CumICU','CumDeath','CumRecovered'};

% Compute a reduced table, in which CUMULATIVE results for each date are
% present
dates_unique = unique(data_iscii.Date);

% Definition of columns for extraction of data in a table
Dates = {};
H_with_symptoms = zeros(length(dates_unique),1);
C = zeros(length(dates_unique),1);
R_from_H = zeros(length(dates_unique),1);
D = zeros(length(dates_unique),1);
Total_cases = zeros(length(dates_unique),1);

for d=1:length(dates_unique)
    Dates(d) = {datestr(dates_unique(d))};
    Total_cases(d)=nansum(data_iscii{data_iscii.Date == datestr(dates_unique(d)),'CumConfirmedCases'});
    H_with_symptoms(d)=nansum(data_iscii{data_iscii.Date == datestr(dates_unique(d)),'CumHospitalised'});
    C(d)=nansum(data_iscii{data_iscii.Date == datestr(dates_unique(d)),'CumICU'});
    D(d)=nansum(str2num(char(data_iscii{data_iscii.Date == datestr(dates_unique(d)),'CumDeath'})));
    R_from_H(d)=nansum(str2num(char(data_iscii{data_iscii.Date == datestr(dates_unique(d)),'CumRecovered'})));
end
H_with_symptoms = H_with_symptoms-C;


%% Extract national Data

Header = {'Date','H_with_symptoms_cum','C_cum','R_from_H_cum','D_cum','Total_cases_cum'};
T = table(Dates',H_with_symptoms,C,R_from_H,D,Total_cases,'VariableNames',Header')

writetable(T,'Spain_NationalData_20200429.csv')