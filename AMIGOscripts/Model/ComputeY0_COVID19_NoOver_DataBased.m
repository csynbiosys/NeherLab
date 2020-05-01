
function [y0] = ComputeY0_COVID19_NoOver_DataBased(agess,cases,N,dat)

y0cum = dat(:,1);

confirmed = ([5, 5, 10, 15, 20, 25, 30, 40, 50]) / 100;
severe    = ([1, 3, 3, 3, 6, 10, 25, 35, 50]) / 100;
% severe    =  severe.*confirmed;
critical  = ([5, 10, 10, 15, 20, 25, 35, 45, 55]) / 100;
% critical = critical.*severe; % Luci added
fatality  = ([30, 30, 30, 30, 30, 40, 40, 50, 50]) / 100;


Inf = y0cum(1)*((agess.*confirmed)./sum(agess.*confirmed));
Sev = y0cum(2)*((agess.*severe)./sum(agess.*severe));
Cri = y0cum(3)*((agess.*critical)./sum(agess.*critical));
Rec = y0cum(4)*((agess.*(((1-severe)+(1-confirmed))/2))./sum(agess.*(((1-severe)+(1-confirmed))/2)));
Fat = y0cum(5)*((agess.*fatality)./sum(agess.*fatality));

n = round((agess/sum(agess))*N);
ages = n / sum(n);
pop  = zeros(11, 9);


pop(1, :) = n;
pop(1, :) = pop(1, :) - cases*ages;
pop(2, :) = pop(2, :) + cases*ages*0.7/3;
pop(3, :) = pop(3, :) + cases*ages*0.7/3;
pop(4, :) = pop(4, :) + cases*ages*0.7/3;


pop(5, :) = pop(5, :) + Inf;
pop(6, :) = pop(6, :) + Sev;
pop(7, :) = pop(7, :) + Cri;
pop(8, :) = pop(8, :) + Rec;
pop(9, :) = pop(9, :) + Fat;
pop(10, :) = pop(10, :) + Sev;
pop(11, :) = pop(11, :) + Cri;


y0 = [pop(:)',sum(pop(1, :)),(sum(pop(2, :))+sum(pop(3, :))+sum(pop(4, :))), sum(pop(5, :)), sum(pop(6, :)),...
    sum(pop(7, :)),sum(pop(8, :)),sum(pop(9, :)),sum(pop(10, :)),sum(pop(11, :))];

end





























