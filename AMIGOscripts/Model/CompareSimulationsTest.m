

datanh = tdfread('covid.summary.tsv');

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






