
function [par] = ParamsModel()
% Example parameters to compare with webapp results (United States)   

% Age deppendent parameters
confirmed = ([5, 5, 10, 15, 20, 25, 30, 40, 50]) / 100;
severe    = ([1, 3, 3, 3, 6, 10, 25, 35, 50]) / 100;
severe    =  severe.*confirmed;
critical  = ([5, 10, 10, 15, 20, 25, 35, 45, 55]) / 100;
critical = critical.*severe; % Luci added
fatality  = ([30, 30, 30, 30, 30, 40, 40, 50, 50]) / 100;
fatality = fatality.*critical; % Luci added

% reported=1/30;
isolated = ([5, 5, 5, 5, 5, 5, 5, 5, 5]) / 100; % Luci mod based on table in webapp: was set to 5 

imports = 0.1;
ipd = imports/9;

N = 331002651;%327200000; %Mod Luci The previous number did not make sense with age distribution and N0 in parameters
R0 = 3.2;
epp = 0.1;
ofs = 2;
t_i = 3;
t_l = 3;
t_c = 14;
t_h = 3;

par=[N,R0,epp,ipd,ofs,t_i,t_l,t_c,t_h,...
      1-isolated(1),1-severe(1),critical(1),fatality(1),...
      1-isolated(2),1-severe(2),critical(2),fatality(2),...
      1-isolated(3),1-severe(3),critical(3),fatality(3),...
      1-isolated(4),1-severe(4),critical(4),fatality(4),...
      1-isolated(5),1-severe(5),critical(5),fatality(5),...
      1-isolated(6),1-severe(6),critical(6),fatality(6),...
      1-isolated(7),1-severe(7),critical(7),fatality(7),...
      1-isolated(8),1-severe(8),critical(8),fatality(8),...
      1-isolated(9),1-severe(9),critical(9),fatality(9)];  


% par_names=char('Npop','R_0','epp','ofs','t_i','t_l','t_c', 't_h'',...
%              'ze_0','m_0','c_0','f_0');  

end
