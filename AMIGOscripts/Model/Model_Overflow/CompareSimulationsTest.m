

datanh = tdfread('covid.summary6.tsv');

% Susceptible
susen = datanh.susceptible_0x28total0x29';
sused = round(cumResCov19(:,1))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Susceptible')
set(gca, 'YScale', 'log')

% Recovered
susen = datanh.cumulative_recovered_0x28total0x29';
sused = round(cumResCov19(:,9))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Recovered')
set(gca, 'YScale', 'log')

% Infected
susen = datanh.infectious_0x28total0x29';
sused = round(cumResCov19(:,5))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Infected')
set(gca, 'YScale', 'log')


% % Severe
% susen = datanh.infectious_0x28total0x29';
% sused = round(cumResCov19(:,5))';
% figure
% hold on
% plot(simCov19.sim.tsim{1}+1, susen)
% plot(simCov19.sim.tsim{1}+1, sused)
% legend('He', 'me')
% title('Infected')
% set(gca, 'YScale', 'log')



