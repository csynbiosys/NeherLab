function [model] = COVID19_NeherModel_V3()

% model.AMIGOjac = 1;                                                         % Compute Jacobian 0 = No, 1 = yes
model.input_model_type='charmodelC';                                        % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|'blackboxmodel'|'blackboxcost                             

model.n_st=81;                                                               % Number of states      
model.n_par=44;                                                             % Number of model parameters 
model.n_stimulus=1;                                                         % Number of inputs, stimuli or control variables   
model.stimulus_names=char('Mt');                                % Name of stimuli or control variables
model.st_names=char('Sus_0','Exp1_0','Exp2_0','Exp3_0','Inf_0','Sev_0','Cri_0','Ovf_0','Rec_0','Fat_0','CumHos_0','CumCri_0');      % Names of the states     
                
model.par_names=char('Npop','R_0','epp','cosphase','ipd','t_i','t_l','t_c', 't_h',...
                     'ze_a0','m_a0','c_a0','f_a0');  % Names of the parameters    

% cos_phase is cos(2*pi*(t-tmax)), since I am not sure pi and cos will be
% valid options (just in case untill tested)
model.eqns=...                                                              % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('bet = R_0*(ze_a0)*(1+epp*cosphase)/t_i',...
                    'Inft = (Inf_0)/Npop',...
                    ...
                    'dSus_0 = -(bet*Mt*Sus_0*Inft + ipd)',...
                    'dExp1_0= (bet*Mt*Sus_0*Inft + ipd)-((3*Exp1_0)/t_l)',...
                    'dExp2_0= ((3*Exp1_0)/t_l) - ((3*Exp2_0)/t_l)',...
                    'dExp3_0= ((3*Exp2_0)/t_l) - ((3*Exp3_0)/t_l)',...
                    'dInf_0 = ((3*Exp3_0)/t_l) - (Inf_0/t_i)',...
                    'dSev_0 = (((1-m_a0)*Inf_0)/t_i) + (((1-f_a0)*Cri)/t_c) - (Sev_0/t_h) - (((1-f_a0)*Ovf)/t_c)',... % m_a0 is 1-severe, not severe. Last flux is the overflow
                    'dCri_0 = ',...
                    'dOvf_0 = ',...
                    'dRec_0 = ',...
                    'dFat_0',...
                    'dCumHos_0 = ',...
                    'dCumCri_0 = ');


                
model.par=ParamsModel();



end