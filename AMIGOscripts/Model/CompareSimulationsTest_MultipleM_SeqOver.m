%% Load the equivalent data from the webapp
cd D:\SynBioSysNeher\NeherLab\.git\AMIGOscripts\Data
%datanh = tdfread('covid.summary_sequential.tsv');
datanh = tdfread('covid.summaryConstant.tsv');
cd D:\SynBioSysNeher\NeherLab\.git\AMIGOscripts\Model

%% Load the results of the simulation
load('TestSimulationNeherModelAMIGO_V3_NoOver.mat','simCov19')

% Get cumulative results

[a,b] = size(simCov19.sim.states{1});

cumResCov19 = zeros(a,b/9);
r = 1:11:b;
for i=1:11 % States    
    for j=1:9 % Agge groups
        cumResCov19(:,i) = cumResCov19(:,i) + simCov19.sim.states{1}(:,r(j));
    end
    r = r+1;
end

%% Check the initial states are the same
 St_us = [round(cumResCov19(1,1)),round(cumResCov19(1,5)),round(cumResCov19(1,6)),round(cumResCov19(1,7)),round(cumResCov19(1,8)),round(cumResCov19(1,9)),round(cumResCov19(1,10)),round(cumResCov19(1,11))];
 St_Ne = [datanh.susceptible_0x28total0x29(1,1),datanh.infectious_0x28total0x29(1,1),datanh.severe_0x28total0x29(1,1),datanh.ICU_0x28total0x29(1,1),datanh.cumulative_recovered_0x28total0x29(1,1),datanh.cumulative_fatality_0x28total0x29(1,1),datanh.cumulative_hospitalized_0x28total0x29(1,1),datanh.cumulative_critical_0x28total0x29(1,1)];

%%
% Susceptible
susen = datanh.susceptible_0x28total0x29';
sused = round(cumResCov19(:,1))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Susceptible')
disp('Max Error on susceptible [%]: ')
max((susen-sused)./susen*100)

% Recovered
susen = datanh.cumulative_recovered_0x28total0x29';
sused = round(cumResCov19(:,8))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Recovered')
disp('Max error on recovered [%]: ')
max((susen-sused)./susen*100)

% Infected
susen = datanh.infectious_0x28total0x29';
sused = round(cumResCov19(:,5))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Infected')
disp('Max error on infected [%]: ')
max((susen-sused)./susen*100)






