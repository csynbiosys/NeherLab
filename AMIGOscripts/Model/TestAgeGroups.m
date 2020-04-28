Ovf_0 = simCov19.sim.states{1}(:,8);
Ovf_1 = simCov19.sim.states{1}(:,8+12);
Ovf_2 = simCov19.sim.states{1}(:,8+12+12);
Ovf_3 = simCov19.sim.states{1}(:,8+12+12+12);
Ovf_4 = simCov19.sim.states{1}(:,8+12+12+12+12);
Ovf_5 = simCov19.sim.states{1}(:,8+12+12+12+12+12);
Ovf_6 = simCov19.sim.states{1}(:,8+12+12+12+12+12+12);
Ovf_7 = simCov19.sim.states{1}(:,8+12+12+12+12+12+12+12);
Ovf_8 = simCov19.sim.states{1}(:,8+12+12+12+12+12+12+12+12);

Ovf = (Ovf_0+Ovf_1+Ovf_2+Ovf_3+Ovf_4+Ovf_5+Ovf_6+Ovf_7+Ovf_8);    


datanh = tdfread('covid.allresults.tsv');

% Overflow
susen = datanh.overflow_0x28700x2D790x29';
% sused = round(simCov19.sim.states{1}(:,8+12+12+12+12+12))';
figure
hold on
plot(simCov19.sim.tsim{1}+1, susen)
plot(simCov19.sim.tsim{1}+1, Ovf_7)
legend('He', 'me')
title('Overflow')
set(gca, 'YScale', 'log')





% overflow_0x2800x2D90x29: [214×1 double]
% overflow_0x28100x2D190x29: [214×1 double]
% overflow_0x28200x2D290x29: [214×1 double]
% overflow_0x28300x2D390x29: [214×1 double]
% overflow_0x28400x2D490x29: [214×1 double]
% overflow_0x28500x2D590x29: [214×1 double]
% overflow_0x28600x2D690x29: [214×1 double]
% overflow_0x28700x2D790x29: [214×1 double]
overflow_0x28800x2B0x29: [214×1 double]
overflow_0x28total0x29: [214×1 double]