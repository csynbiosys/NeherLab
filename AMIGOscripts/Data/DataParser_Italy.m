
%Perform request at GET URL.
URL_Italy= 'https://raw.github.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni.json',

data = jsondecode(webread(URL_Italy))

dates = {data.data};
dates_unique = unique(dates);

% Definition of columns for extraction of data in a table
Dates = {};
H_with_symptoms = zeros(length(dates_unique),1);
C = zeros(length(dates_unique),1);
Total_H_C = zeros(length(dates_unique),1);
Home_confinement = zeros(length(dates_unique),1);
Total_positive_H_C_Home = zeros(length(dates_unique),1);
Delta_total_positive = zeros(length(dates_unique),1);
Daily_new_positive = zeros(length(dates_unique),1);
R_from_H = zeros(length(dates_unique),1);
D = zeros(length(dates_unique),1);
Total_cases = zeros(length(dates_unique),1);
Tests = zeros(length(dates_unique),1);

for d=1:length(dates_unique)
    ind = find(ismember(dates,dates_unique{d})); 
    Dates(d) = {dates_unique{d}};
    H_with_symptoms(d) = sum([data(ind).ricoverati_con_sintomi]);
    C(d)  = sum([data(ind).terapia_intensiva]);
    Total_H_C(d) = sum([data(ind).totale_ospedalizzati]);
    Home_confinement(d) = sum([data(ind).isolamento_domiciliare]);
    Total_positive_H_C_Home(d) = sum([data(ind).totale_positivi]);
    Delta_total_positive(d) = sum([data(ind).variazione_totale_positivi]);
    Daily_new_positive(d) = sum([data(ind).nuovi_positivi]);
    R_from_H(d) = sum([data(ind).dimessi_guariti]);
    D(d) = sum([data(ind).deceduti]); % cumulative
    Total_cases(d) = sum([data(ind).totale_casi]); 
    Tests(d) = sum([data(ind).tamponi]);  
end

Dates_only = {};
Time = {};
for d=1:length(Dates)
    Sep = split(Dates{d},'T');
    Dates_only(d)= {Sep{1,1}};
    Time(d) = {Sep{2,1}};
end

%% Extract national Data

Header = {'Date','Time','H_with_symptoms','C','Total_H_C','Home_confinement','Total_positive_H_C_Home','Delta_Total_positive','Daily_new_positive','R_from_H','D_cum','Total_cases','Tests'};
T = table(Dates_only',Time',H_with_symptoms,C,Total_H_C,Home_confinement,Total_positive_H_C_Home,Delta_total_positive,Daily_new_positive,R_from_H,D,Total_cases,Tests,'VariableNames',Header')

writetable(T,'Italy_NationalData_20200415.csv')









