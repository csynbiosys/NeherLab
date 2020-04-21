%% Load the equivalent data from the webapp
cd D:\SynBioSysNeher\NeherLab\.git\AMIGOscripts\Data
%datanh = tdfread('covid.summary_sequential.tsv');
datanh = tdfread('covid.summary_overlap.tsv');
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
disp('Error on susceptible [%]: ')
(susen(end)-sused(end))/susen(end)*100

% Recovered
susen = datanh.cumulative_recovered_0x28total0x29';
sused = round(cumResCov19(:,8))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Recovered')
disp('Error on recovered [%]: ')
(susen(end)-sused(end))/susen(end)*100

% Infected
susen = datanh.infectious_0x28total0x29';
sused = round(cumResCov19(:,5))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Infected')
disp('Error on infected [%]: ')
(susen(end)-sused(end))/susen(end)*100






