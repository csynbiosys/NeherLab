
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










































