function [y0] = ComputeY0Guess_COVID19_NoOver_DataBased_NoInfected(agess,cases,N,dat)

y0cum = dat(:,1);

confirmed = ([5, 5, 10, 15, 20, 25, 30, 40, 50]) / 100;
% severe    = ([1, 3, 3, 3, 6, 10, 25, 35, 50]) / 100;
% % severe    =  severe.*confirmed;
% critical  = ([5, 10, 10, 15, 20, 25, 35, 45, 55]) / 100;
% % critical = critical.*severe; % Luci added
% fatality  = ([30, 30, 30, 30, 30, 40, 40, 50, 50]) / 100;
fatalityT = 1-([0.002, 0.006, 0.03, 0.08, 0.15, 0.6, 2.2, 5.1, 9.3]) / 100;
severe = ([0.1, 0.3, 1.2, 3.2, 4.9, 10.2, 16.6, 24.3, 27.3]) / 100;


Inf = y0cum(1)*((agess.*confirmed)./sum(agess.*confirmed));
agess2 = agess;
for i=1:9
    rem = sum(Inf-floor(Inf));
    
    t=((agess2.*confirmed)./sum(agess2.*confirmed));
    if i==9
        s=0;
    else
        s = min(t(logical(ceil((agess2.*confirmed)./sum(agess2.*confirmed)))));
    end
    rou = find(t == s);
    agess2(rou) = 0;
    
    Inf = floor(Inf) + rem*((agess2.*confirmed)./sum(agess2.*confirmed));
    
    rem2 = sum(Inf-floor(Inf));
    if rem2==0
        break;
    end
end



Rec = y0cum(4)*((agess.*fatalityT)./sum(agess.*fatalityT));
agess2 = agess;
for i=1:9
    rem = sum(Rec-floor(Rec));
    
    t=((agess2.*fatalityT)./sum(agess2.*fatalityT));
    if i==9
        s=0;
    else
        s = min(t(logical(ceil(((agess2.*fatalityT)./sum(agess2.*fatalityT))))));
    end
    rou = find(t == s);
    agess2(rou) = 0;
    
    Rec = floor(Rec) + rem*(((agess2.*fatalityT)./sum(agess2.*fatalityT)));
    
    rem2 = sum(Rec-floor(Rec));
    if rem2==0
        break;
    end
end


pop  = zeros(5, 9);

pop(1, :) = pop(1, :)+1;
pop(2, :) = pop(2, :)+1;
pop(3, :) = pop(3, :)+1;
pop(4, :) = pop(4, :) + Inf;

pop(5, :) = pop(5, :) + Rec;


y0 = [pop(:)'];

end
