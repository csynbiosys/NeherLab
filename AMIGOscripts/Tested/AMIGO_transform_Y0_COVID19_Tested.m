% $Header: svn://.../trunk/AMIGO2R2016/Kernel/AMIGO_transform_theta.m 2046 2015-08-24 12:43:55Z attila $


function [privstruct,inputs]=AMIGO_transform_Y0_COVID19_Tested(inputs,results,privstruct)
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

for iexp=1:inputs.exps.n_exp
    r = 5:12:length(inputs.exps.exp_y0{1});
    for i=1:length(r)
        y0 = ComputeY0_COVID19_NoOver_DataBased_V2_Tested(AgeDistributions('ITA'),inputs.exps.exp_data{iexp}(1,1),...
            sum(AgeDistributions('ITA')),inputs.exps.exp_data{1},privstruct.theta(find(inputs.PEsol.index_global_theta==12)));
        privstruct.y_0{iexp}(r(i)) = y0(r(i));
        privstruct.exp_y0{iexp}(r(i)) = y0(r(i));
        inputs.exps.exp_y0{iexp}(r(i)) = y0(r(i));
    end
end






return;