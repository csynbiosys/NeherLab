function [model] = COVID19_NeherModel_V2()

% model.AMIGOjac = 0;                                                         % Compute Jacobian 0 = No, 1 = yes
model.input_model_type='charmodelC';                                        % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|'blackboxmodel'|'blackboxcost                             

model.n_st=81;                                                               % Number of states      
model.n_par=44;                                                             % Number of model parameters 
model.n_stimulus=1;                                                         % Number of inputs, stimuli or control variables   
model.stimulus_names=char('M_t');                                % Name of stimuli or control variables
model.st_names=char('S_0','E_01','E_02','E_03','I_0','H_0','C_0','R_0','D_0', ...
                    'S_1','E_11','E_12','E_13','I_1','H_1','C_1','R_1','D_1', ...
                    'S_2','E_21','E_22','E_23','I_2','H_2','C_2','R_2','D_2', ...
                    'S_3','E_31','E_32','E_33','I_3','H_3','C_3','R_3','D_3', ...
                    'S_4','E_41','E_42','E_43','I_4','H_4','C_4','R_4','D_4', ...
                    'S_5','E_51','E_52','E_53','I_5','H_5','C_5','R_5','D_5', ...
                    'S_6','E_61','E_62','E_63','I_6','H_6','C_6','R_6','D_6', ...
                    'S_7','E_71','E_72','E_73','I_7','H_7','C_7','R_7','D_7', ...
                    'S_8','E_81','E_82','E_83','I_8','H_8','C_8','R_8','D_8');      % Names of the states     
                
model.par_names=char('Npop','R_0','epp','cosphase','t_i','t_l','t_c', 't_h',...
                     'ze_0','m_0','c_0','f_0', ...
                     'ze_1','m_1','c_1','f_1', ...
                     'ze_2','m_2','c_2','f_2', ...
                     'ze_3','m_3','c_3','f_3', ...
                     'ze_4','m_4','c_4','f_4', ...
                     'ze_5','m_5','c_5','f_5', ...
                     'ze_6','m_6','c_6','f_6', ...
                     'ze_7','m_7','c_7','f_7', ...
                     'ze_8','m_8','c_8','f_8');  % Names of the parameters    

% cos_phase is cos(2*pi*(t-tmax)), since I am not sure pi and cos will be
% valid options (just in case untill tested)
model.eqns=...                                                              % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('bet = R_0*M_t*(1+epp*cosphase)/t_i',...
                    'I_all = I_0+I_1+I_2+I_3+I_4+I_5+I_6+I_7+I_8',...
                    ...
                    'flux_S0   = (ze_0*bet)*(I_all/N)*S_0 + (0.1/9)',...
                    'flux_E10  = (1/t_l)*E_01*3',...
                    'flux_E20  = (1/t_l)*E_02*3',...
                    'flux_E30  = (1/t_l)*E_03*3',...
                    'flux_I_R0 = (1/t_i)*(1-m_0)*I_0',...
                    'flux_I_H0 = (1/t_i)*m_0*I_0',...
                    'flux_H_R0 = (1/t_h)*(1-c_0)*H_0',...
                    'flux_H_C0 = (1/t_h)*c_0*H_0',...
                    'flux_C_H0 = (1/t_c)*(1-f_0)*C_0',...
                    'flux_C_D0 = (1/t_c)*f_0*C_0',...
                    'dS_0 =  -flux_S0',...
                    'dE_01 = +flux_S0  - flux_E10',...
                    'dE_02 = +flux_E10 - flux_E20',...
                    'dE_03 = +flux_E20 - flux_E30',...
                    'dI_0 =  +flux_E30 - flux_I_R0 - flux_I_H0',...
                    'dH_0 =  +flux_I_H0 + flux_C_H0 - flux_H_R0 - flux_H_C0',...
                    'dC_0 =  +flux_H_C0 - flux_C_D0 - flux_C_H0',...
                    'dR_0 =  +flux_H_R0 + flux_I_R0',...
                    'dD_0 =  +flux_C_D0',...
                    ...
                    'flux_S1   = (ze_1*bet)*(I_all/N)*S_1 + (0.1/9)',...
                    'flux_E11  = (1/t_l)*E_11*3',...
                    'flux_E21  = (1/t_l)*E_12*3',...
                    'flux_E31  = (1/t_l)*E_13*3',...
                    'flux_I_R1 = (1/t_i)*(1-m_1)*I_1',...
                    'flux_I_H1 = (1/t_i)*m_1*I_1',...
                    'flux_H_R1 = (1/t_h)*(1-c_1)*H_1',...
                    'flux_H_C1 = (1/t_h)*c_1*H_1',...
                    'flux_C_H1 = (1/t_c)*(1-f_1)*C_1',...
                    'flux_C_D1 = (1/t_c)*f_1*C_1',...
                    'dS_1 =  -flux_S1',...
                    'dE_11 = +flux_S1  - flux_E11',...
                    'dE_12 = +flux_E11 - flux_E21',...
                    'dE_13 = +flux_E21 - flux_E31',...
                    'dI_1 =  +flux_E31 - flux_I_R1 - flux_I_H1',...
                    'dH_1 =  +flux_I_H1 + flux_C_H1 - flux_H_R1 - flux_H_C1',...
                    'dC_1 =  +flux_H_C1 - flux_C_D1 - flux_C_H1',...
                    'dR_1 =  +flux_H_R1 + flux_I_R1',...
                    'dD_1 =  +flux_C_D1',...
                    ...
                    'flux_S2   = (ze_2*bet)*(I_all/N)*S_2 + (0.1/9)',...
                    'flux_E12  = (1/t_l)*E_21*3',...
                    'flux_E22  = (1/t_l)*E_22*3',...
                    'flux_E32  = (1/t_l)*E_23*3',...
                    'flux_I_R2 = (1/t_i)*(1-m_2)*I_2',...
                    'flux_I_H2 = (1/t_i)*m_2*I_2',...
                    'flux_H_R2 = (1/t_h)*(1-c_2)*H_2',...
                    'flux_H_C2 = (1/t_h)*c_2*H_2',...
                    'flux_C_H2 = (1/t_c)*(1-f_2)*C_2',...
                    'flux_C_D2 = (1/t_c)*f_2*C_2',...
                    'dS_2 =  -flux_S2',...
                    'dE_21 = +flux_S2  - flux_E12',...
                    'dE_22 = +flux_E12 - flux_E22',...
                    'dE_23 = +flux_E22 - flux_E32',...
                    'dI_2 =  +flux_E32 - flux_I_R2 - flux_I_H2',...
                    'dH_2 =  +flux_I_H2 + flux_C_H2 - flux_H_R2 - flux_H_C2',...
                    'dC_2 =  +flux_H_C2 - flux_C_D2 - flux_C_H2',...
                    'dR_2 =  +flux_H_R2 + flux_I_R2',...
                    'dD_2 =  +flux_C_D2',...
                    ...
                    'flux_S3   = (ze_3*bet)*(I_all/N)*S_3 + (0.1/9)',...
                    'flux_E13  = (1/t_l)*E_31*3',...
                    'flux_E23  = (1/t_l)*E_32*3',...
                    'flux_E33  = (1/t_l)*E_33*3',...
                    'flux_I_R3 = (1/t_i)*(1-m_3)*I_3',...
                    'flux_I_H3 = (1/t_i)*m_3*I_3',...
                    'flux_H_R3 = (1/t_h)*(1-c_3)*H_3',...
                    'flux_H_C3 = (1/t_h)*c_3*H_3',...
                    'flux_C_H3 = (1/t_c)*(1-f_3)*C_3',...
                    'flux_C_D3 = (1/t_c)*f_3*C_3',...
                    'dS_3 =  -flux_S3',...
                    'dE_31 = +flux_S3  - flux_E13',...
                    'dE_32 = +flux_E13 - flux_E23',...
                    'dE_33 = +flux_E23 - flux_E33',...
                    'dI_3 =  +flux_E33 - flux_I_R3 - flux_I_H3',...
                    'dH_3 =  +flux_I_H3 + flux_C_H3 - flux_H_R3 - flux_H_C3',...
                    'dC_3 =  +flux_H_C3 - flux_C_D3 - flux_C_H3',...
                    'dR_3 =  +flux_H_R3 + flux_I_R3',...
                    'dD_3 =  +flux_C_D3',...
                    ...
                    'flux_S4   = (ze_4*bet)*(I_all/N)*S_4 + (0.1/9)',...
                    'flux_E14  = (1/t_l)*E_41*3',...
                    'flux_E24  = (1/t_l)*E_42*3',...
                    'flux_E34  = (1/t_l)*E_43*3',...
                    'flux_I_R4 = (1/t_i)*(1-m_4)*I_4',...
                    'flux_I_H4 = (1/t_i)*m_4*I_4',...
                    'flux_H_R4 = (1/t_h)*(1-c_4)*H_4',...
                    'flux_H_C4 = (1/t_h)*c_4*H_4',...
                    'flux_C_H4 = (1/t_c)*(1-f_4)*C_4',...
                    'flux_C_D4 = (1/t_c)*f_4*C_4',...
                    'dS_4 =  -flux_S4',...
                    'dE_41 = +flux_S4  - flux_E14',...
                    'dE_42 = +flux_E14 - flux_E24',...
                    'dE_43 = +flux_E24 - flux_E34',...
                    'dI_4 =  +flux_E34 - flux_I_R4 - flux_I_H4',...
                    'dH_4 =  +flux_I_H4 + flux_C_H4 - flux_H_R4 - flux_H_C4',...
                    'dC_4 =  +flux_H_C4 - flux_C_D4 - flux_C_H4',...
                    'dR_4 =  +flux_H_R4 + flux_I_R4',...
                    'dD_4 =  +flux_C_D4',...
                    ...
                    'flux_S5   = (ze_5*bet)*(I_all/N)*S_5 + (0.1/9)',...
                    'flux_E15  = (1/t_l)*E_51*3',...
                    'flux_E25  = (1/t_l)*E_52*3',...
                    'flux_E35  = (1/t_l)*E_53*3',...
                    'flux_I_R5 = (1/t_i)*(1-m_5)*I_5',...
                    'flux_I_H5 = (1/t_i)*m_5*I_5',...
                    'flux_H_R5 = (1/t_h)*(1-c_5)*H_5',...
                    'flux_H_C5 = (1/t_h)*c_5*H_5',...
                    'flux_C_H5 = (1/t_c)*(1-f_5)*C_5',...
                    'flux_C_D5 = (1/t_c)*f_5*C_5',...
                    'dS_5 =  -flux_S5',...
                    'dE_51 = +flux_S5  - flux_E15',...
                    'dE_52 = +flux_E15 - flux_E25',...
                    'dE_53 = +flux_E25 - flux_E35',...
                    'dI_5 =  +flux_E35 - flux_I_R5 - flux_I_H5',...
                    'dH_5 =  +flux_I_H5 + flux_C_H5 - flux_H_R5 - flux_H_C5',...
                    'dC_5 =  +flux_H_C5 - flux_C_D5 - flux_C_H5',...
                    'dR_5 =  +flux_H_R5 + flux_I_R5',...
                    'dD_5 =  +flux_C_D5',...
                    ...
                    'flux_S6   = (ze_6*bet)*(I_all/N)*S_6 + (0.1/9)',...
                    'flux_E16  = (1/t_l)*E_61*3',...
                    'flux_E26  = (1/t_l)*E_62*3',...
                    'flux_E36  = (1/t_l)*E_63*3',...
                    'flux_I_R6 = (1/t_i)*(1-m_6)*I_6',...
                    'flux_I_H6 = (1/t_i)*m_6*I_6',...
                    'flux_H_R6 = (1/t_h)*(1-c_6)*H_6',...
                    'flux_H_C6 = (1/t_h)*c_6*H_6',...
                    'flux_C_H6 = (1/t_c)*(1-f_6)*C_6',...
                    'flux_C_D6 = (1/t_c)*f_6*C_6',...
                    'dS_6 =  -flux_S6',...
                    'dE_61 = +flux_S6  - flux_E16',...
                    'dE_62 = +flux_E16 - flux_E26',...
                    'dE_63 = +flux_E26 - flux_E36',...
                    'dI_6 =  +flux_E36 - flux_I_R6 - flux_I_H6',...
                    'dH_6 =  +flux_I_H6 + flux_C_H6 - flux_H_R6 - flux_H_C6',...
                    'dC_6 =  +flux_H_C6 - flux_C_D6 - flux_C_H6',...
                    'dR_6 =  +flux_H_R6 + flux_I_R6',...
                    'dD_6 =  +flux_C_D6',...
                    ...
                    'flux_S7   = (ze_7*bet)*(I_all/N)*S_7 + (0.1/9)',...
                    'flux_E17  = (1/t_l)*E_71*3',...
                    'flux_E27  = (1/t_l)*E_72*3',...
                    'flux_E37  = (1/t_l)*E_73*3',...
                    'flux_I_R7 = (1/t_i)*(1-m_7)*I_7',...
                    'flux_I_H7 = (1/t_i)*m_7*I_7',...
                    'flux_H_R7 = (1/t_h)*(1-c_7)*H_7',...
                    'flux_H_C7 = (1/t_h)*c_7*H_7',...
                    'flux_C_H7 = (1/t_c)*(1-f_7)*C_7',...
                    'flux_C_D7 = (1/t_c)*f_7*C_7',...
                    'dS_7 =  -flux_S7',...
                    'dE_71 = +flux_S7  - flux_E17',...
                    'dE_72 = +flux_E17 - flux_E27',...
                    'dE_73 = +flux_E27 - flux_E37',...
                    'dI_7 =  +flux_E37 - flux_I_R7 - flux_I_H7',...
                    'dH_7 =  +flux_I_H7 + flux_C_H7 - flux_H_R7 - flux_H_C7',...
                    'dC_7 =  +flux_H_C7 - flux_C_D7 - flux_C_H7',...
                    'dR_7 =  +flux_H_R7 + flux_I_R7',...
                    'dD_7 =  +flux_C_D7',...
                    ...
                    'flux_S8   = (ze_8*bet)*(I_all/N)*S_8 + (0.1/9)',...
                    'flux_E18  = (1/t_l)*E_81*3',...
                    'flux_E28  = (1/t_l)*E_82*3',...
                    'flux_E38  = (1/t_l)*E_83*3',...
                    'flux_I_R8 = (1/t_i)*(1-m_8)*I_8',...
                    'flux_I_H8 = (1/t_i)*m_8*I_8',...
                    'flux_H_R8 = (1/t_h)*(1-c_8)*H_8',...
                    'flux_H_C8 = (1/t_h)*c_8*H_8',...
                    'flux_C_H8 = (1/t_c)*(1-f_8)*C_8',...
                    'flux_C_D8 = (1/t_c)*f_8*C_8',...
                    'dS_8 =  -flux_S8',...
                    'dE_81 = +flux_S8  - flux_E18',...
                    'dE_82 = +flux_E18 - flux_E28',...
                    'dE_83 = +flux_E28 - flux_E38',...
                    'dI_8 =  +flux_E38 - flux_I_R8 - flux_I_H8',...
                    'dH_8 =  +flux_I_H8 + flux_C_H8 - flux_H_R8 - flux_H_C8',...
                    'dC_8 =  +flux_H_C8 - flux_C_D8 - flux_C_H8',...
                    'dR_8 =  +flux_H_R8 + flux_I_R8',...
                    'dD_8 =  +flux_C_D8');


                
% Example parameters to compare with webapp results (United States)   
% Phase
NumDays = daysact('1-feb-2020',  '1-sep-2020');
month2day = @(x) x*30+15;
cp = cos(2*pi*((NumDays/365)-(month2day(0)/365)));

% Age deppendent parameters
confirmed = ([5, 5, 10, 15, 20, 25, 30, 40, 50]) / 100;
severe    = ([1, 3, 3, 3, 6, 10, 25, 35, 50]) / 100;
severe    =  severe.*confirmed;
critical  = ([5, 10, 10, 15, 20, 25, 35, 45, 55]) / 100;
critical = critical.*severe; % Luci added
fatality  = ([30, 30, 30, 30, 30, 40, 40, 50, 50]) / 100;
fatality = fatality.*critical; % Luci added
recovery  = 1 - severe;
% discharge = 1 - critical;
% stabilize = 1 - fatality;
% reported=1/30;
isolated = ([5, 5, 5, 5, 5, 5, 5, 5, 5]) / 100;

model.par=[330000000,3.2,0.1,cp,3,3,14,3,...
          isolated(1),severe(1),critical(1),fatality(1),...
          isolated(2),severe(2),critical(2),fatality(2),...
          isolated(3),severe(3),critical(3),fatality(3),...
          isolated(4),severe(4),critical(4),fatality(4),...
          isolated(5),severe(5),critical(5),fatality(5),...
          isolated(6),severe(6),critical(6),fatality(6),...
          isolated(7),severe(7),critical(7),fatality(7),...
          isolated(8),severe(8),critical(8),fatality(8),...
          isolated(9),severe(9),critical(9),fatality(9)];  


% par_names=char('Npop','R_0','epp','cosphase','t_i','t_l','t_c','t_h',...
%              'ze_0','m_0','c_0','f_0', ...
%              'ze_1','m_1','c_1','f_1', ...
%              'ze_2','m_2','c_2','f_2', ...
%              'ze_3','m_3','c_3','f_3', ...
%              'ze_4','m_4','c_4','f_4', ...
%              'ze_5','m_5','c_5','f_5', ...
%              'ze_6','m_6','c_6','f_6', ...
%              'ze_7','m_7','c_7','f_7', ...
%              'ze_8','m_8','c_8','f_8');  






end