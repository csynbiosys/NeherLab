function [model] = COVID19_NeherModel_V3_Over()

% model.AMIGOjac = 1;                                                         % Compute Jacobian 0 = No, 1 = yes
model.input_model_type='charmodelC';                                        % Model introduction: 'charmodelC'|'c_model'|'charmodelM'|'matlabmodel'|'sbmlmodel'|'blackboxmodel'|'blackboxcost

model.n_st=12*9;                                                               % Number of states
model.n_par=47;                                                             % Number of model parameters
model.n_stimulus=2;                                                         % Number of inputs, stimuli or control variables   
model.stimulus_names=char('Mt', 'COS');                                % Name of stimuli or control variables
model.st_names=char('Sus_0','Exp1_0','Exp2_0','Exp3_0','Inf_0','Sev_0','Cri_0','Ovf_0','Rec_0','Fat_0','CumHos_0','CumCri_0', ...
                    'Sus_1','Exp1_1','Exp2_1','Exp3_1','Inf_1','Sev_1','Cri_1','Ovf_1','Rec_1','Fat_1','CumHos_1','CumCri_1', ...
                    'Sus_2','Exp1_2','Exp2_2','Exp3_2','Inf_2','Sev_2','Cri_2','Ovf_2','Rec_2','Fat_2','CumHos_2','CumCri_2', ...
                    'Sus_3','Exp1_3','Exp2_3','Exp3_3','Inf_3','Sev_3','Cri_3','Ovf_3','Rec_3','Fat_3','CumHos_3','CumCri_3', ...
                    'Sus_4','Exp1_4','Exp2_4','Exp3_4','Inf_4','Sev_4','Cri_4','Ovf_4','Rec_4','Fat_4','CumHos_4','CumCri_4', ...
                    'Sus_5','Exp1_5','Exp2_5','Exp3_5','Inf_5','Sev_5','Cri_5','Ovf_5','Rec_5','Fat_5','CumHos_5','CumCri_5', ...
                    'Sus_6','Exp1_6','Exp2_6','Exp3_6','Inf_6','Sev_6','Cri_6','Ovf_6','Rec_6','Fat_6','CumHos_6','CumCri_6', ...
                    'Sus_7','Exp1_7','Exp2_7','Exp3_7','Inf_7','Sev_7','Cri_7','Ovf_7','Rec_7','Fat_7','CumHos_7','CumCri_7', ...
                    'Sus_8','Exp1_8','Exp2_8','Exp3_8','Inf_8','Sev_8','Cri_8','Ovf_8','Rec_8','Fat_8','CumHos_8','CumCri_8');      % Names of the states

model.par_names=char('Npop','R_0','epp','ipd','ofs','HB','ICUb','t_i','t_l','t_c', 't_h',...
                     'ze_a0','m_a0','c_a0','f_a0',...
                     'ze_a1','m_a1','c_a1','f_a1',...
                     'ze_a2','m_a2','c_a2','f_a2',...
                     'ze_a3','m_a3','c_a3','f_a3',...
                     'ze_a4','m_a4','c_a4','f_a4',...
                     'ze_a5','m_a5','c_a5','f_a5',...
                     'ze_a6','m_a6','c_a6','f_a6',...
                     'ze_a7','m_a7','c_a7','f_a7',...
                     'ze_a8','m_a8','c_a8','f_a8');  % Names of the parameters

% cos_phase is cos(2*pi*(t-tmax)), since I am not sure pi and cos will be
% valid options (just in case untill tested)
model.eqns=...                                                              % Equations describing system dynamics. Time derivatives are regarded 'd'st_name''
               char('bet = R_0*(1+epp*COS)/t_i',...
                    'Inft = (Inf_0+Inf_1+Inf_2+Inf_3+Inf_4+Inf_5+Inf_6+Inf_7+Inf_8)/Npop',...
                    ...
                    'freeICUb = ICUb - (Cri_0+Cri_1+Cri_2+Cri_3+Cri_4+Cri_5+Cri_6+Cri_7+Cri_8)',...
                    'if(freeICUb<0){',...
                    '    if(Cri_8 > -freeICUb){Cri_8 = Cri_8+freeICUb;Ovf_8 = Ovf_8-freeICUb;freeICUb = 0;} else {Ovf_8 = Ovf_8+Cri_8;freeICUb = freeICUb+Cri_8;Cri_8 = 0;}',...
                    '    if(Cri_7 > -freeICUb){Cri_7 = Cri_7+freeICUb;Ovf_7 = Ovf_7-freeICUb;freeICUb = 0;} else {Ovf_7 = Ovf_7+Cri_7;freeICUb = freeICUb+Cri_7;Cri_7 = 0;}',...
                    '    if(Cri_6 > -freeICUb){Cri_6 = Cri_6+freeICUb;Ovf_6 = Ovf_6-freeICUb;freeICUb = 0;} else {Ovf_6 = Ovf_6+Cri_6;freeICUb = freeICUb+Cri_6;Cri_6 = 0;}',...
                    '    if(Cri_5 > -freeICUb){Cri_5 = Cri_5+freeICUb;Ovf_5 = Ovf_5-freeICUb;freeICUb = 0;} else {Ovf_5 = Ovf_5+Cri_5;freeICUb = freeICUb+Cri_5;Cri_5 = 0;}',...
                    '    if(Cri_4 > -freeICUb){Cri_4 = Cri_4+freeICUb;Ovf_4 = Ovf_4-freeICUb;freeICUb = 0;} else {Ovf_4 = Ovf_4+Cri_4;freeICUb = freeICUb+Cri_4;Cri_4 = 0;}',...
                    '    if(Cri_3 > -freeICUb){Cri_3 = Cri_3+freeICUb;Ovf_3 = Ovf_3-freeICUb;freeICUb = 0;} else {Ovf_3 = Ovf_3+Cri_3;freeICUb = freeICUb+Cri_3;Cri_3 = 0;}',...
                    '    if(Cri_2 > -freeICUb){Cri_2 = Cri_2+freeICUb;Ovf_2 = Ovf_2-freeICUb;freeICUb = 0;} else {Ovf_2 = Ovf_2+Cri_2;freeICUb = freeICUb+Cri_2;Cri_2 = 0;}',...
                    '    if(Cri_1 > -freeICUb){Cri_1 = Cri_1+freeICUb;Ovf_1 = Ovf_1-freeICUb;freeICUb = 0;} else {Ovf_1 = Ovf_1+Cri_1;freeICUb = freeICUb+Cri_1;Cri_1 = 0;}',...
                    '    if(Cri_0 > -freeICUb){Cri_0 = Cri_0+freeICUb;Ovf_0 = Ovf_0-freeICUb;freeICUb = 0;} else {Ovf_0 = Ovf_0+Cri_0;freeICUb = freeICUb+Cri_0;Cri_0 = 0;}}',...
                    'if(freeICUb>0){',...
                    '    if(Ovf_0>freeICUb){Cri_0 = Cri_0+freeICUb;Ovf_0 = Ovf_0-freeICUb;freeICUb = 0;} else {Cri_0 = Cri_0+Ovf_0;freeICUb = freeICUb-Ovf_0;Ovf_0 = 0;}',...
                    '    if(Ovf_1>freeICUb){Cri_1 = Cri_1+freeICUb;Ovf_1 = Ovf_1-freeICUb;freeICUb = 0;} else {Cri_1 = Cri_1+Ovf_1;freeICUb = freeICUb-Ovf_1;Ovf_1 = 0;}',...
                    '    if(Ovf_2>freeICUb){Cri_2 = Cri_2+freeICUb;Ovf_2 = Ovf_2-freeICUb;freeICUb = 0;} else {Cri_2 = Cri_2+Ovf_2;freeICUb = freeICUb-Ovf_2;Ovf_2 = 0;}',...
                    '    if(Ovf_3>freeICUb){Cri_3 = Cri_3+freeICUb;Ovf_3 = Ovf_3-freeICUb;freeICUb = 0;} else {Cri_3 = Cri_3+Ovf_3;freeICUb = freeICUb-Ovf_3;Ovf_3 = 0;}',...
                    '    if(Ovf_4>freeICUb){Cri_4 = Cri_4+freeICUb;Ovf_4 = Ovf_4-freeICUb;freeICUb = 0;} else {Cri_4 = Cri_4+Ovf_4;freeICUb = freeICUb-Ovf_4;Ovf_4 = 0;}',...
                    '    if(Ovf_5>freeICUb){Cri_5 = Cri_5+freeICUb;Ovf_5 = Ovf_5-freeICUb;freeICUb = 0;} else {Cri_5 = Cri_5+Ovf_5;freeICUb = freeICUb-Ovf_5;Ovf_5 = 0;}',...
                    '    if(Ovf_6>freeICUb){Cri_6 = Cri_6+freeICUb;Ovf_6 = Ovf_6-freeICUb;freeICUb = 0;} else {Cri_6 = Cri_6+Ovf_6;freeICUb = freeICUb-Ovf_6;Ovf_6 = 0;}',...
                    '    if(Ovf_7>freeICUb){Cri_7 = Cri_7+freeICUb;Ovf_7 = Ovf_7-freeICUb;freeICUb = 0;} else {Cri_7 = Cri_7+Ovf_7;freeICUb = freeICUb-Ovf_7;Ovf_7 = 0;}',...
                    '    if(Ovf_8>freeICUb){Cri_8 = Cri_8+freeICUb;Ovf_8 = Ovf_8-freeICUb;freeICUb = 0;} else {Cri_8 = Cri_8+Ovf_8;freeICUb = freeICUb-Ovf_8;Ovf_8 = 0;}}',...
                    ...
                    'if(Ovf_0<0){Ovf_0=0;dOvf_0=0;}',...
                    'if(Ovf_1<0){Ovf_1=0;dOvf_1=0;}',...
                    'if(Ovf_2<0){Ovf_2=0;dOvf_2=0;}',...
                    'if(Ovf_3<0){Ovf_3=0;dOvf_3=0;}',...
                    'if(Ovf_4<0){Ovf_4=0;dOvf_4=0;}',...
                    'if(Ovf_5<0){Ovf_5=0;dOvf_5=0;}',...
                    'if(Ovf_6<0){Ovf_6=0;dOvf_6=0;}',...
                    'if(Ovf_7<0){Ovf_7=0;dOvf_7=0;}',...
                    'if(Ovf_8<0){Ovf_8=0;dOvf_8=0;}',...
                    ...
                    'dSus_0 = -((bet*ze_a0)*Mt*Sus_0*Inft + ipd)',...
                    'dExp1_0= ((bet*ze_a0)*Mt*Sus_0*Inft + ipd)-((3*Exp1_0)/t_l)',...
                    'dExp2_0= ((3*Exp1_0)/t_l) - ((3*Exp2_0)/t_l)',...
                    'dExp3_0= ((3*Exp2_0)/t_l) - ((3*Exp3_0)/t_l)',...
                    'dInf_0 = ((3*Exp3_0)/t_l) - (Inf_0/t_i)',...
                    'dSev_0 = (((1-m_a0)*Inf_0)/t_i) + (((1-f_a0)*Cri_0)/t_c) - (Sev_0/t_h) - (((1-f_a0)*Ovf_0)/t_c)',... % m_a0 is 1-severe, not severe. Last flux is the overflow
                    'dCri_0 = ((c_a0*Sev_0)/t_h) - (Cri_0/t_c)',...
                    'dOvf_0 = -((((1-f_a0)*Ovf_0)/t_c) + ((ofs*f_a0*Ovf_0)/t_c))',...
                    'dRec_0 = ((m_a0*Inf_0)/t_i) + (((1-c_a0)*Sev_0)/t_h)',...
                    'dFat_0 = ((f_a0*Cri_0)/t_c) + ((ofs*f_a0*Ovf_0)/t_c)',...
                    'dCumHos_0 = (((1-m_a0)*Inf_0)/t_i)',...
                    'dCumCri_0 = ((c_a0*Sev_0)/t_h)',...
                    ...
                    'dSus_1 = -((bet*ze_a1)*Mt*Sus_1*Inft + ipd)',...
                    'dExp1_1= ((bet*ze_a1)*Mt*Sus_1*Inft + ipd)-((3*Exp1_1)/t_l)',...
                    'dExp2_1= ((3*Exp1_1)/t_l) - ((3*Exp2_1)/t_l)',...
                    'dExp3_1= ((3*Exp2_1)/t_l) - ((3*Exp3_1)/t_l)',...
                    'dInf_1 = ((3*Exp3_1)/t_l) - (Inf_1/t_i)',...
                    'dSev_1 = (((1-m_a1)*Inf_1)/t_i) + (((1-f_a1)*Cri_1)/t_c) - (Sev_1/t_h) - (((1-f_a1)*Ovf_1)/t_c)',... % m_a1 is 1-severe, not severe. Last flux is the overflow
                    'dCri_1 = ((c_a1*Sev_1)/t_h) - (Cri_1/t_c)',...
                    'dOvf_1 = -((((1-f_a1)*Ovf_1)/t_c) + ((ofs*f_a1*Ovf_1)/t_c))',...
                    'dRec_1 = ((m_a1*Inf_1)/t_i) + (((1-c_a1)*Sev_1)/t_h)',...
                    'dFat_1 = ((f_a1*Cri_1)/t_c) + ((ofs*f_a1*Ovf_1)/t_c)',...
                    'dCumHos_1 = (((1-m_a1)*Inf_1)/t_i)',...
                    'dCumCri_1 = ((c_a1*Sev_1)/t_h)',...
                    ...
                    'dSus_2 = -((bet*ze_a2)*Mt*Sus_2*Inft + ipd)',...
                    'dExp1_2= ((bet*ze_a2)*Mt*Sus_2*Inft + ipd)-((3*Exp1_2)/t_l)',...
                    'dExp2_2= ((3*Exp1_2)/t_l) - ((3*Exp2_2)/t_l)',...
                    'dExp3_2= ((3*Exp2_2)/t_l) - ((3*Exp3_2)/t_l)',...
                    'dInf_2 = ((3*Exp3_2)/t_l) - (Inf_2/t_i)',...
                    'dSev_2 = (((1-m_a2)*Inf_2)/t_i) + (((1-f_a2)*Cri_2)/t_c) - (Sev_2/t_h)- (((1-f_a2)*Ovf_2)/t_c)',... % m_a2 is 1-severe, not severe. Last flux is the overflow
                    'dCri_2 = ((c_a2*Sev_2)/t_h) - (Cri_2/t_c)',...
                    'dOvf_2 = -((((1-f_a2)*Ovf_2)/t_c) + ((ofs*f_a2*Ovf_2)/t_c))',...
                    'dRec_2 = ((m_a2*Inf_2)/t_i) + (((1-c_a2)*Sev_2)/t_h)',...
                    'dFat_2 = ((f_a2*Cri_2)/t_c) + ((ofs*f_a2*Ovf_2)/t_c)',...
                    'dCumHos_2 = (((1-m_a2)*Inf_2)/t_i)',...
                    'dCumCri_2 = ((c_a2*Sev_2)/t_h)',...
                    ...
                    'dSus_3 = -((bet*ze_a3)*Mt*Sus_3*Inft + ipd)',...
                    'dExp1_3= ((bet*ze_a3)*Mt*Sus_3*Inft + ipd)-((3*Exp1_3)/t_l)',...
                    'dExp2_3= ((3*Exp1_3)/t_l) - ((3*Exp2_3)/t_l)',...
                    'dExp3_3= ((3*Exp2_3)/t_l) - ((3*Exp3_3)/t_l)',...
                    'dInf_3 = ((3*Exp3_3)/t_l) - (Inf_3/t_i)',...
                    'dSev_3 = (((1-m_a3)*Inf_3)/t_i) + (((1-f_a3)*Cri_3)/t_c) - (Sev_3/t_h) - (((1-f_a3)*Ovf_3)/t_c)',... % m_a3 is 1-severe, not severe. Last flux is the overflow
                    'dCri_3 = ((c_a3*Sev_3)/t_h) - (Cri_3/t_c)',...
                    'dOvf_3 = -((((1-f_a3)*Ovf_3)/t_c) + ((ofs*f_a3*Ovf_3)/t_c))',...
                    'dRec_3 = ((m_a3*Inf_3)/t_i) + (((1-c_a3)*Sev_3)/t_h)',...
                    'dFat_3 = ((f_a3*Cri_3)/t_c) + ((ofs*f_a3*Ovf_3)/t_c)',...
                    'dCumHos_3 = (((1-m_a3)*Inf_3)/t_i)',...
                    'dCumCri_3 = ((c_a3*Sev_3)/t_h)',...
                    ...
                    'dSus_4 = -((bet*ze_a4)*Mt*Sus_4*Inft + ipd)',...
                    'dExp1_4= ((bet*ze_a4)*Mt*Sus_4*Inft + ipd)-((3*Exp1_4)/t_l)',...
                    'dExp2_4= ((3*Exp1_4)/t_l) - ((3*Exp2_4)/t_l)',...
                    'dExp3_4= ((3*Exp2_4)/t_l) - ((3*Exp3_4)/t_l)',...
                    'dInf_4 = ((3*Exp3_4)/t_l) - (Inf_4/t_i)',...
                    'dSev_4 = (((1-m_a4)*Inf_4)/t_i) + (((1-f_a4)*Cri_4)/t_c) - (Sev_4/t_h) - (((1-f_a4)*Ovf_4)/t_c)',... % m_a4 is 1-severe, not severe. Last flux is the overflow
                    'dCri_4 = ((c_a4*Sev_4)/t_h) - (Cri_4/t_c)',...
                    'dOvf_4 = -((((1-f_a4)*Ovf_4)/t_c) + ((ofs*f_a4*Ovf_4)/t_c))',...
                    'dRec_4 = ((m_a4*Inf_4)/t_i) + (((1-c_a4)*Sev_4)/t_h)',...
                    'dFat_4 = ((f_a4*Cri_4)/t_c) + ((ofs*f_a4*Ovf_4)/t_c)',...
                    'dCumHos_4 = (((1-m_a4)*Inf_4)/t_i)',...
                    'dCumCri_4 = ((c_a4*Sev_4)/t_h)',...
                    ...
                    'dSus_5 = -((bet*ze_a5)*Mt*Sus_5*Inft + ipd)',...
                    'dExp1_5= ((bet*ze_a5)*Mt*Sus_5*Inft + ipd)-((3*Exp1_5)/t_l)',...
                    'dExp2_5= ((3*Exp1_5)/t_l) - ((3*Exp2_5)/t_l)',...
                    'dExp3_5= ((3*Exp2_5)/t_l) - ((3*Exp3_5)/t_l)',...
                    'dInf_5 = ((3*Exp3_5)/t_l) - (Inf_5/t_i)',...
                    'dSev_5 = (((1-m_a5)*Inf_5)/t_i) + (((1-f_a5)*Cri_5)/t_c) - (Sev_5/t_h) - (((1-f_a5)*Ovf_5)/t_c)',... % m_a5 is 1-severe, not severe. Last flux is the overflow
                    'dCri_5 = ((c_a5*Sev_5)/t_h) - (Cri_5/t_c)',...
                    'dOvf_5 = -((((1-f_a5)*Ovf_5)/t_c) + ((ofs*f_a5*Ovf_5)/t_c))',...
                    'dRec_5 = ((m_a5*Inf_5)/t_i) + (((1-c_a5)*Sev_5)/t_h)',...
                    'dFat_5 = ((f_a5*Cri_5)/t_c) + ((ofs*f_a5*Ovf_5)/t_c)',...
                    'dCumHos_5 = (((1-m_a5)*Inf_5)/t_i)',...
                    'dCumCri_5 = ((c_a5*Sev_5)/t_h)',...
                    ...
                    'dSus_6 = -((bet*ze_a6)*Mt*Sus_6*Inft + ipd)',...
                    'dExp1_6= ((bet*ze_a6)*Mt*Sus_6*Inft + ipd)-((3*Exp1_6)/t_l)',...
                    'dExp2_6= ((3*Exp1_6)/t_l) - ((3*Exp2_6)/t_l)',...
                    'dExp3_6= ((3*Exp2_6)/t_l) - ((3*Exp3_6)/t_l)',...
                    'dInf_6 = ((3*Exp3_6)/t_l) - (Inf_6/t_i)',...
                    'dSev_6 = (((1-m_a6)*Inf_6)/t_i) + (((1-f_a6)*Cri_6)/t_c) - (Sev_6/t_h) - (((1-f_a6)*Ovf_6)/t_c)',... % m_a6 is 1-severe, not severe. Last flux is the overflow
                    'dCri_6 = ((c_a6*Sev_6)/t_h) - (Cri_6/t_c)',...
                    'dOvf_6 = -((((1-f_a6)*Ovf_6)/t_c) + ((ofs*f_a6*Ovf_6)/t_c))',...
                    'dRec_6 = ((m_a6*Inf_6)/t_i) + (((1-c_a6)*Sev_6)/t_h)',...
                    'dFat_6 = ((f_a6*Cri_6)/t_c) + ((ofs*f_a6*Ovf_6)/t_c)',...
                    'dCumHos_6 = (((1-m_a6)*Inf_6)/t_i)',...
                    'dCumCri_6 = ((c_a6*Sev_6)/t_h)',...
                    ...
                    'dSus_7 = -((bet*ze_a7)*Mt*Sus_7*Inft + ipd)',...
                    'dExp1_7= ((bet*ze_a7)*Mt*Sus_7*Inft + ipd)-((3*Exp1_7)/t_l)',...
                    'dExp2_7= ((3*Exp1_7)/t_l) - ((3*Exp2_7)/t_l)',...
                    'dExp3_7= ((3*Exp2_7)/t_l) - ((3*Exp3_7)/t_l)',...
                    'dInf_7 = ((3*Exp3_7)/t_l) - (Inf_7/t_i)',...
                    'dSev_7 = (((1-m_a7)*Inf_7)/t_i) + (((1-f_a7)*Cri_7)/t_c) - (Sev_7/t_h) - (((1-f_a7)*Ovf_7)/t_c)',... % m_a7 is 1-severe, not severe. Last flux is the overflow
                    'dCri_7 = ((c_a7*Sev_7)/t_h) - (Cri_7/t_c)',...
                    'dOvf_7 = -((((1-f_a7)*Ovf_7)/t_c) + ((ofs*f_a7*Ovf_7)/t_c))',...
                    'dRec_7 = ((m_a7*Inf_7)/t_i) + (((1-c_a7)*Sev_7)/t_h)',...
                    'dFat_7 = ((f_a7*Cri_7)/t_c) + ((ofs*f_a7*Ovf_7)/t_c)',...
                    'dCumHos_7 = (((1-m_a7)*Inf_7)/t_i)',...
                    'dCumCri_7 = ((c_a7*Sev_7)/t_h)',...
                    ...
                    'dSus_8 = -((bet*ze_a8)*Mt*Sus_8*Inft + ipd)',...
                    'dExp1_8= ((bet*ze_a8)*Mt*Sus_8*Inft + ipd)-((3*Exp1_8)/t_l)',...
                    'dExp2_8= ((3*Exp1_8)/t_l) - ((3*Exp2_8)/t_l)',...
                    'dExp3_8= ((3*Exp2_8)/t_l) - ((3*Exp3_8)/t_l)',...
                    'dInf_8 = ((3*Exp3_8)/t_l) - (Inf_8/t_i)',...
                    'dSev_8 = (((1-m_a8)*Inf_8)/t_i) + (((1-f_a8)*Cri_8)/t_c) - (Sev_8/t_h) - (((1-f_a8)*Ovf_8)/t_c)',... % m_a8 is 1-severe, not severe. Last flux is the overflow
                    'dCri_8 = ((c_a8*Sev_8)/t_h) - (Cri_8/t_c)',...
                    'dOvf_8 = -((((1-f_a8)*Ovf_8)/t_c) + ((ofs*f_a8*Ovf_8)/t_c))',...
                    'dRec_8 = ((m_a8*Inf_8)/t_i) + (((1-c_a8)*Sev_8)/t_h)',...
                    'dFat_8 = ((f_a8*Cri_8)/t_c) + ((ofs*f_a8*Ovf_8)/t_c)',...
                    'dCumHos_8 = (((1-m_a8)*Inf_8)/t_i)',...
                    'dCumCri_8 = ((c_a8*Sev_8)/t_h)');



end
