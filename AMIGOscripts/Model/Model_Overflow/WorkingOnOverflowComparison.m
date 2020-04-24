%% import data

cd D:\SynBioSysNeher\NeherLab\.git\AMIGOscripts\Data
Neher_res_summary = tdfread('covid.summary.tsv');
Neher_res = tdfread('covid.allresults.tsv');
cd D:\SynBioSysNeher\NeherLab\.git\AMIGOscripts\Model

load('TestSimulationNeherModelAMIGO_V3_Over.mat','simCov19')
%% Check for negatives
r_neg = zeros(1,size(simCov19.sim.states{1,1},2)); 
for c=1:size(simCov19.sim.states{1,1},2)
     r_neg(c) = sum(simCov19.sim.states{1,1}(:,c)<0);
end
find(r_neg~=0)


name = {'Sus_0','Exp1_0','Exp2_0','Exp3_0','Inf_0','Sev_0','Cri_0','Ovf_0','Rec_0','Fat_0','CumHos_0','CumCri_0', ...
                    'Sus_1','Exp1_1','Exp2_1','Exp3_1','Inf_1','Sev_1','Cri_1','Ovf_1','Rec_1','Fat_1','CumHos_1','CumCri_1', ...
                    'Sus_2','Exp1_2','Exp2_2','Exp3_2','Inf_2','Sev_2','Cri_2','Ovf_2','Rec_2','Fat_2','CumHos_2','CumCri_2', ...
                    'Sus_3','Exp1_3','Exp2_3','Exp3_3','Inf_3','Sev_3','Cri_3','Ovf_3','Rec_3','Fat_3','CumHos_3','CumCri_3', ...
                    'Sus_4','Exp1_4','Exp2_4','Exp3_4','Inf_4','Sev_4','Cri_4','Ovf_4','Rec_4','Fat_4','CumHos_4','CumCri_4', ...
                    'Sus_5','Exp1_5','Exp2_5','Exp3_5','Inf_5','Sev_5','Cri_5','Ovf_5','Rec_5','Fat_5','CumHos_5','CumCri_5', ...
                    'Sus_6','Exp1_6','Exp2_6','Exp3_6','Inf_6','Sev_6','Cri_6','Ovf_6','Rec_6','Fat_6','CumHos_6','CumCri_6', ...
                    'Sus_7','Exp1_7','Exp2_7','Exp3_7','Inf_7','Sev_7','Cri_7','Ovf_7','Rec_7','Fat_7','CumHos_7','CumCri_7', ...
                    'Sus_8','Exp1_8','Exp2_8','Exp3_8','Inf_8','Sev_8','Cri_8','Ovf_8','Rec_8','Fat_8','CumHos_8','CumCri_8'};


Cri = simCov19.sim.states{1,1}(:,[7:12:size(simCov19.sim.states{1,1},2)]);
Over = simCov19.sim.states{1,1}(:,[8:12:size(simCov19.sim.states{1,1},2)]);

figure;
plot(1:1:214,sum(sum(Over,2)<0))

Minimum = zeros(1,size(Over,2));
Maximum = zeros(1,size(Over,2));
for i=1:size(Over,2)
    Minimum(1,i) = min(Over(:,i));
    Maximum(1,i) = max(Over(:,i));
end
Minimum
Maximum
