
%% Get simulation results
load('TestSimulationNeherModelAMIGO_V3_Over.mat','simCov19')

%% Get cumulative results and save

[a,b] = size(simCov19.sim.states{1});

cumResCov19 = zeros(a,(b-12)/9);
r = 1:12:b;
for i=1:12 % States    
    for j=1:9 % Agge groups
        cumResCov19(:,i) = cumResCov19(:,i) + simCov19.sim.states{1}(:,r(j));
    end
    r = r+1;
end


%% Plot results

figure
hold on
for i=1:12
    if i~=2 && i~=3 && i~=4
%         figure
        plot(simCov19.sim.tsim{1}+1, round(cumResCov19(:,i)))
    end
end
% plot(simCov19.sim.tsim{1}+1, CD)
legend('S','I','H','C','O','R','cD','cH','cC')
plot(simCov19.sim.tsim{1}+1,repelem(49499, length(simCov19.sim.tsim{1}+1)))
set(gca, 'YScale', 'log')
ylabel('People')
xlabel('time(days)')
title('Time Period: 1-feb-2020 to 1-sep-2020')






























