
function [par] = Params_SIR_NoInfected(N,R0,epp,ofs,t_i,t_l,t_c,t_h,HB,ICUb,imports,confirmed,severe,critical,fatality,isolated)
% If you want default parameter values, so you dont need to introduce
% anything as input
if nargin==0
    % Example parameters to compare with webapp results (United States)   

%     % Age deppendent parameters
    confirmed = ([5, 5, 10, 15, 20, 25, 30, 40, 50]) / 100;
%     severe    = ([1, 3, 3, 3, 6, 10, 25, 35, 50]) / 100;
%     severe    =  severe.*confirmed;
%     critical  = ([5, 10, 10, 15, 20, 25, 35, 45, 55]) / 100;
%     % critical = critical.*severe; % Luci added
%     fatality  = ([30, 30, 30, 30, 30, 40, 40, 50, 50]) / 100;
%     % fatality = fatality.*critical; % Luci added
    
    % Imperial Report (https://www.imperial.ac.uk/media/imperial-college/medicine/sph/ide/gida-fellowships/Imperial-College-COVID19-NPI-modelling-16-03-2020.pdf)
    severe = ([0.1, 0.3, 1.2, 3.2, 4.9, 10.2, 16.6, 24.3, 27.3]) / 100;
    critical = ([5, 5, 5, 5, 6.3, 12.2, 27.4, 43.2, 70.9]) / 100;
    fatality = ([0.002, 0.006, 0.03, 0.08, 0.15, 0.6, 2.2, 5.1, 9.3]) / 100;
    fatality = fatality./critical;
    
    % reported=1/30;
    isolated = ([0, 0, 0, 0, 0, 0, 0, 0, 0]) / 100;

    imports = 0.1;
    ipd = imports/9;
    
    N = 331002651;
    R0 = 3.2;
    epp = 0.1;
    ofs = 2;
    t_i = 15;
    t_l = 6;
    t_c = 5;
    t_h = 13;

    HB = 798288;
    ICUb = 49499;
else

    if isempty(N); N = 331002651; end

    if isempty(R0); R0 = 3.2; end

    if isempty(epp); epp = 0.1; end

    if isempty(ofs); ofs = 2; end

    if isempty(t_i); t_i = 15; end

    if isempty(t_l); t_l = 6; end

    if isempty(t_c); t_c = 5; end

    if isempty(t_h); t_h = 13; end
    
    if isempty(HB); HB = 798288; end

    if isempty(ICUb); ICUb = 49499; end

    if isempty(imports); imports = 0.1; end

    if isempty(confirmed); confirmed = ([5, 5, 10, 15, 20, 25, 30, 40, 50]) / 100; else; confirmed = (confirmed) / 100; end

%     if isempty(severe); severe = ([1, 3, 3, 3, 6, 10, 25, 35, 50]) / 100; severe = severe.*confirmed; else;  severe    = (severe) / 100; severe    =  severe.*confirmed;end
%     
%     if isempty(critical); critical = ([5, 10, 10, 15, 20, 25, 35, 45, 55]) / 100; else; critical  = (critical) / 100; end
% 
%     if isempty(fatality); fatality = ([30, 30, 30, 30, 30, 40, 40, 50, 50]) / 100; else; fatality  = (fatality) / 100; end

%     % Imperial
    if isempty(severe); severe = ([0.1, 0.3, 1.2, 3.2, 4.9, 10.2, 16.6, 24.3, 27.3]) / 100; else; severe = (severe) / 100; end
    if isempty(critical); critical = ([5, 5, 5, 5, 6.3, 12.2, 27.4, 43.2, 70.9]) / 100; else; critical  = (critical) / 100; end
    if isempty(fatality); fatality = ([0.002, 0.006, 0.03, 0.08, 0.15, 0.6, 2.2, 5.1, 9.3]) / 100; fatality = fatality./critical; else; fatality  = (fatality) / 100; end
    
    if isempty(isolated); isolated = ([0, 0, 0, 0, 0, 0, 0, 0, 0]) / 100; else; isolated = (isolated) / 100; end

    if length(confirmed)~=9 || length(severe)~=9 || length(critical)~=9 || length(fatality)~=9 || length(isolated)~=9
        disp('Please, introduce correct age dependent parameters (9 groups; no more, no less)')
        return
    end
    ipd = imports/9;

     % Age deppendent parameters
    
    % critical = critical.*severe; % Luci added
    
    % fatality = fatality.*critical; % Luci added

    % reported=1/30;
        
end

par=[N,R0,epp,ipd,ofs,HB,ICUb,t_i,t_l,t_c,t_h,...
      1-isolated(1),1-severe(1),critical(1),fatality(1),...
      1-isolated(2),1-severe(2),critical(2),fatality(2),...
      1-isolated(3),1-severe(3),critical(3),fatality(3),...
      1-isolated(4),1-severe(4),critical(4),fatality(4),...
      1-isolated(5),1-severe(5),critical(5),fatality(5),...
      1-isolated(6),1-severe(6),critical(6),fatality(6),...
      1-isolated(7),1-severe(7),critical(7),fatality(7),...
      1-isolated(8),1-severe(8),critical(8),fatality(8),...
      1-isolated(9),1-severe(9),critical(9),fatality(9)];  

% Params_SIR([],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]) ---> Test for
% when wanting to change a specific parameter

% par_names=char('Npop','R_0','epp','ofs','t_i','t_l','t_c', 't_h'',...
%              'ze_0','m_0','c_0','f_0');  

end
