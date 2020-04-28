

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
set(gca, 'YScale', 'log')

% Exposed
susen = datanh.exposed_0x28total0x29';
sused = (round(cumResCov19(:,2))'+round(cumResCov19(:,3))'+round(cumResCov19(:,4))');
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Exposed')
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

% Severe (Hospital)
susen = datanh.severe_0x28total0x29';
sused = round(cumResCov19(:,6))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Severe')
set(gca, 'YScale', 'log')


% Critical
susen = datanh.ICU_0x28total0x29';
sused = round(cumResCov19(:,7))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Critical')
set(gca, 'YScale', 'log')

% Overflow
susen = datanh.overflow_0x28total0x29';
sused = round(cumResCov19(:,8))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Overflow')
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

% Dead
susen = datanh.cumulative_fatality_0x28total0x29';
sused = round(cumResCov19(:,10))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Death')
set(gca, 'YScale', 'log')

% Cumulative Hospital 
susen = datanh.cumulative_hospitalized_0x28total0x29';
sused = round(cumResCov19(:,11))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Cummulative Hospital')
set(gca, 'YScale', 'log')

% Cumulative Critical
susen = datanh.cumulative_critical_0x28total0x29';
sused = round(cumResCov19(:,12))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, sused)
legend('He', 'me')
title('Cummulative Critical')
set(gca, 'YScale', 'log')



















