
function [y0] = ComputeY0_COVID19_NoOver_DataBased_V2(agess,cases,N,dat)

y0cum = dat(:,1);

confirmed = ([5, 5, 10, 15, 20, 25, 30, 40, 50]) / 100;
severe    = ([1, 3, 3, 3, 6, 10, 25, 35, 50]) / 100;
% severe    =  severe.*confirmed;
critical  = ([5, 10, 10, 15, 20, 25, 35, 45, 55]) / 100;
% critical = critical.*severe; % Luci added
fatality  = ([30, 30, 30, 30, 30, 40, 40, 50, 50]) / 100;


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


Sev = y0cum(2)*((agess.*severe)./sum(agess.*severe));
agess2 = agess;
for i=1:9
    rem = sum(Sev-floor(Sev));
    
    t=((agess2.*severe)./sum(agess2.*severe));
    if i==9
        s=0;
    else
        s = min(t(logical(ceil((agess2.*severe)./sum(agess2.*severe)))));
    end
    rou = find(t == s);
    agess2(rou) = 0;
    
    Sev = floor(Sev) + rem*((agess2.*severe)./sum(agess2.*severe));
    
    rem2 = sum(Sev-floor(Sev));
    if rem2==0
        break;
    end
end



Cri = y0cum(3)*((agess.*critical)./sum(agess.*critical));
agess2 = agess;
for i=1:9
    rem = sum(Cri-floor(Cri));
    
    t=((agess2.*critical)./sum(agess2.*critical));
    if i==9
        s=0;
    else
        s = min(t(logical(ceil((agess2.*critical)./sum(agess2.*critical)))));
    end
    rou = find(t == s);
    agess2(rou) = 0;
    
    Cri = floor(Cri) + rem*((agess2.*critical)./sum(agess2.*critical));
    
    rem2 = sum(Cri-floor(Cri));
    if rem2==0
        break;
    end
end



Rec = y0cum(4)*((agess.*(((1-severe)+(1-confirmed))/2))./sum(agess.*(((1-severe)+(1-confirmed))/2)));
agess2 = agess;
for i=1:9
    rem = sum(Rec-floor(Rec));
    
    t=((agess2.*(((1-severe)+(1-confirmed))/2))./sum(agess2.*(((1-severe)+(1-confirmed))/2)));
    if i==9
        s=0;
    else
        s = min(t(logical(ceil(((agess2.*(((1-severe)+(1-confirmed))/2))./sum(agess2.*(((1-severe)+(1-confirmed))/2)))))));
    end
    rou = find(t == s);
    agess2(rou) = 0;
    
    Rec = floor(Rec) + rem*(((agess2.*(((1-severe)+(1-confirmed))/2))./sum(agess2.*(((1-severe)+(1-confirmed))/2))));
    
    rem2 = sum(Rec-floor(Rec));
    if rem2==0
        break;
    end
end


Fat = y0cum(5)*((agess.*fatality)./sum(agess.*fatality));
agess2 = agess;
for i=1:9
    rem = sum(Fat-floor(Fat));
    
    t=((agess2.*fatality)./sum(agess2.*fatality));
    if i==9
        s=0;
    else
        s = min(t(logical(ceil((agess2.*fatality)./sum(agess2.*fatality)))));
    end
    rou = find(t == s);
    agess2(rou) = 0;
    
    Fat = floor(Fat) + rem*((agess2.*fatality)./sum(agess2.*fatality));
    
    rem2 = sum(Fat-floor(Fat));
    if rem2==0
        break;
    end
end


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





























