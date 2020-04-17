
%% Get simulation results
load('TestSimulationNeherModelAMIGO_V3_NoOver.mat','simCov19')

%% Get cumulative results and save

[a,b] = size(simCov19.sim.states{1});

cumResCov19 = zeros(a,b/9);
r = 1:11:b;
for i=1:11 % States    
    for j=1:9 % Agge groups
        cumResCov19(:,i) = cumResCov19(:,i) + simCov19.sim.states{1}(:,r(j));
    end
    r = r+1;
end

% %% Cumulative deaths
% CD = zeros(size(cumResCov19(:,9)));
% for i=1:length(cumResCov19(:,9))
%     CD(i,1) = sum(cumResCov19(1:i,9));
% end
% 
% %% Cummulative recovered
% CR = zeros(size(cumResCov19(:,8)));
% for i=1:length(cumResCov19(:,8))
%     CR(i,1) = sum(cumResCov19(1:i,8));
% end


%% Plot results

figure
hold on
for i=1:11
    if i~=2 && i~=3 && i~=4
        plot(simCov19.sim.tsim{1}+1, round(cumResCov19(:,i)))
    end
end
% plot(simCov19.sim.tsim{1}+1, CD)
legend('S','I','H','C','R','cD','cH','cC')
set(gca, 'YScale', 'log')
ylabel('People')
xlabel('time(days)')
title('Time Period: 1-feb-2020 to 1-sep-2020')






























