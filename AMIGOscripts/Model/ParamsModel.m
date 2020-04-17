
function [par] = ParamsModel()
% Example parameters to compare with webapp results (United States)   
% Phase
NumDays = daysact('1-jan-2020',  '1-sep-2020');
month2day = @(x) x*30+15;
cp = cos(2*pi*((NumDays/365)-(month2day(0)/365)));

% Age deppendent parameters
confirmed = ([5, 5, 10, 15, 20, 25, 30, 40, 50]) / 100;
severe    = ([1, 3, 3, 3, 6, 10, 25, 35, 50]) / 100;
severe    =  severe.*confirmed;
critical  = ([5, 10, 10, 15, 20, 25, 35, 45, 55]) / 100;
critical = critical.*severe; % Luci added
fatality  = ([30, 30, 30, 30, 30, 40, 40, 50, 50]) / 100;
% fatality = fatality.*critical; % Luci added
recovery  = 1 - severe;
% discharge = 1 - critical;
% stabilize = 1 - fatality;
% reported=1/30;
isolated = ([5, 5, 5, 5, 5, 5, 5, 5, 5]) / 100;

imports = 0.1;
ipd = imports/9;

par=[330000000,3.2,0.1,cp,ipd,3,3,14,3,...
          1-isolated(1),1-severe(1),critical(1),fatality(1)];  


% par_names=char('Npop','R_0','epp','cosphase','ipd','t_i','t_l','t_c', 't_h',...
%              'ze_0','m_0','c_0','f_0');  

end
