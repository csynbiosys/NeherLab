% $Header: svn://.../trunk/AMIGO2R2016/Kernel/AMIGO_transform_theta.m 2046 2015-08-24 12:43:55Z attila $


function [privstruct,inputs]=AMIGO_transform_Y0(inputs,results,privstruct)
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

model1 = 


for iexp=1:inputs.exps.n_exp
    privstruct.y_0{iexp} = M3D_steady_state_MicroFluidics(privstruct.theta,0);
    privstruct.exp_y0{iexp} = M3D_steady_state_MicroFluidics(privstruct.theta,0);
    inputs.exps.exp_y0{iexp} = M3D_steady_state_MicroFluidics(privstruct.theta,0);
end






return;