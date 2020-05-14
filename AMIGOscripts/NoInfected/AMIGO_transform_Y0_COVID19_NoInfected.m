% $Header: svn://.../trunk/AMIGO2R2016/Kernel/AMIGO_transform_theta.m 2046 2015-08-24 12:43:55Z attila $


function [privstruct,inputs]=AMIGO_transform_Y0_COVID19_NoInfected(inputs,results,privstruct)
% AMIGO_transform_theta: transforms theta vector in: local/global theta/y0
%
%******************************************************************************
% AMIGO2: dynamic modeling, optimization and control of biological systems    % 
% Code development:     Eva Balsa-Canto                                       %
% Address:              Process Engineering Group, IIM-CSIC                   %
%                       C/Eduardo Cabello 6, 36208, Vigo-Spain                %
% e-mail:               ebalsa@iim.csic.es                                    %
% Copyright:            CSIC, Spanish National Research Council               %
%******************************************************************************
%
%*****************************************************************************%
%                                                                             %
% AMIGO_transform_theta: transforms theta vector in: local/global theta/y0    %
%                                                                             %
%*****************************************************************************%

%% Add in 
%   - AMIGO_PEcost: After line 100
%   - AMIGO_PE: After line 246

%   - AMIGO_IOCcost: Line 71
%   - AMIGO_IOC: Line 184

for iexp=1:inputs.exps.n_exp
    r = 1:12:length(inputs.exps.exp_y0{1});
    ages = AgeDistributions('ITA');
    for i=1:length(r)
        sus = privstruct.y_0{iexp}(r(i):r(i)+11);
        disp(sus)
        sus = sus(2:10);
        sus(8) = [];
        Y0I = sum(sus);
        Y0S = ages(i)-Y0I;
        privstruct.y_0{iexp}(r(i)) = Y0S;
        privstruct.exp_y0{iexp}(r(i)) = Y0S;
        inputs.exps.exp_y0{iexp}(r(i)) = Y0S;
    end
end


return;







