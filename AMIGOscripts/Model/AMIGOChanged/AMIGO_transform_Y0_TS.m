% $Header: svn://.../trunk/AMIGO2R2016/Kernel/AMIGO_transform_theta.m 2046 2015-08-24 12:43:55Z attila $


function [privstruct,inputs]=AMIGO_transform_Y0_TS(inputs,results,privstruct)
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

model1 = ...                                                              % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('dIPTGi = (k_in_IPTG*(u_IPTG-IPTGi)+((k_in_IPTG*(u_IPTG-IPTGi))^2)^0.5)/2-(k_out_IPTG*(IPTGi-u_IPTG)+((k_out_IPTG*(IPTGi-u_IPTG))^2)^0.5)/2',...
                    'daTci = (k_in_aTc*(u_aTc-aTci)+((k_in_aTc*(u_aTc-aTci))^2)^0.5)/2-(k_out_aTc*(aTci-u_aTc)+((k_out_aTc*(aTci-u_aTc))^2)^0.5)/2',...
                    'dL_RFP = 1/0.1386*(kL_p_m0 + (kL_p_m/(1+(T_GFP/theta_T*(1/(1+(aTci/theta_aTc)^n_aTc)))^n_T)))-0.0165*L_RFP',...
                    'dT_GFP = 1/0.1386*(kT_p_m0 + (kT_p_m/(1+(L_RFP/theta_L*(1/(1+(IPTGi/theta_IPTG)^n_IPTG)))^n_L)))-0.0165*T_GFP');
                
model2 = ...                                                              % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('dIPTGi = k_iptg*(u_IPTG-IPTGi)',...
                    'daTci = k_aTc*(u_aTc-aTci)',...
                    'dL_RFP = 1/0.1386*(kL_p_m0 + (kL_p_m/(1+(T_GFP/theta_T*(1/(1+(aTci/theta_aTc)^n_aTc)))^n_T)))-0.0165*L_RFP',...
                    'dT_GFP = 1/0.1386*(kT_p_m0 + (kT_p_m/(1+(L_RFP/theta_L*(1/(1+(IPTGi/theta_IPTG)^n_IPTG)))^n_L)))-0.0165*T_GFP');
                
model3 = ...                                                              % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('dIPTGi = k_iptg*(u_IPTG-IPTGi)-0.0165*IPTGi',...
                    'daTci = k_aTc*(u_aTc-aTci)-0.0165*aTci',...
                    'dL_RFP = 1/0.1386*(kL_p_m0 + (kL_p_m/(1+(T_GFP/theta_T*(1/(1+(aTci/theta_aTc)^n_aTc)))^n_T)))-0.0165*L_RFP',...
                    'dT_GFP = 1/0.1386*(kT_p_m0 + (kT_p_m/(1+(L_RFP/theta_L*(1/(1+(IPTGi/theta_IPTG)^n_IPTG)))^n_L)))-0.0165*T_GFP');
                
if strcmp(inputs.model.eqns, model1) 
    for iexp=1:inputs.exps.n_exp
        y0 = M1_Compute_SteadyState_OverNight(inputs,privstruct.theta,inputs.exps.exp_data{iexp}(1,:),inputs.meta.init_U{iexp});
        privstruct.y_0{iexp} = y0;
        privstruct.exp_y0{iexp} = y0;
        inputs.exps.exp_y0{iexp} = y0;
    end
elseif strcmp(inputs.model.eqns, model2) 
    for iexp=1:inputs.exps.n_exp
        y0 = M2_Compute_SteadyState_OverNight(inputs,privstruct.theta,inputs.exps.exp_data{iexp}(1,:),inputs.meta.init_U{iexp});
        privstruct.y_0{iexp} = y0;
        privstruct.exp_y0{iexp} = y0;
        inputs.exps.exp_y0{iexp} = y0;
    end
elseif strcmp(inputs.model.eqns, model3) 
    for iexp=1:inputs.exps.n_exp
        y0 = M3_Compute_SteadyState_OverNight(inputs,privstruct.theta,inputs.exps.exp_data{iexp}(1,:),inputs.meta.init_U{iexp});
        privstruct.y_0{iexp} = y0;
        privstruct.exp_y0{iexp} = y0;
        inputs.exps.exp_y0{iexp} = y0;
    end
end









return;