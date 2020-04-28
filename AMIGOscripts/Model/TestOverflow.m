Ovf_0 = simCov19.sim.states{1}(:,8);
Ovf_1 = simCov19.sim.states{1}(:,8+12);
Ovf_2 = simCov19.sim.states{1}(:,8+12+12);
Ovf_3 = simCov19.sim.states{1}(:,8+12+12+12);
Ovf_4 = simCov19.sim.states{1}(:,8+12+12+12+12);
Ovf_5 = simCov19.sim.states{1}(:,8+12+12+12+12+12);
Ovf_6 = simCov19.sim.states{1}(:,8+12+12+12+12+12+12);
Ovf_7 = simCov19.sim.states{1}(:,8+12+12+12+12+12+12+12);
Ovf_8 = simCov19.sim.states{1}(:,8+12+12+12+12+12+12+12+12);


Cri_0 = simCov19.sim.states{1}(:,7);
Cri_1 = simCov19.sim.states{1}(:,7+12);
Cri_2 = simCov19.sim.states{1}(:,7+12+12);
Cri_3 = simCov19.sim.states{1}(:,7+12+12+12);
Cri_4 = simCov19.sim.states{1}(:,7+12+12+12+12);
Cri_5 = simCov19.sim.states{1}(:,7+12+12+12+12+12);
Cri_6 = simCov19.sim.states{1}(:,7+12+12+12+12+12+12);
Cri_7 = simCov19.sim.states{1}(:,7+12+12+12+12+12+12+12);
Cri_8 = simCov19.sim.states{1}(:,7+12+12+12+12+12+12+12+12);
Cri = (Cri_0+Cri_1+Cri_2+Cri_3+Cri_4+Cri_5+Cri_6+Cri_7+Cri_8);


ICUb = 49499;
freeICUb = ICUb - (Cri_0+Cri_1+Cri_2+Cri_3+Cri_4+Cri_5+Cri_6+Cri_7+Cri_8);

for j=1:length(Cri_0)
    freeICUb = ICUb - (Cri_0(j)+Cri_1(j)+Cri_2(j)+Cri_3(j)+Cri_4(j)+Cri_5(j)+Cri_6(j)+Cri_7(j)+Cri_8(j));
    disp(freeICUb)
    if(freeICUb<0)
        if(Cri_8(j) > -freeICUb)
            Cri_8(j) = Cri_8(j)+freeICUb;Ovf_8(j) = Ovf_8(j)-freeICUb;freeICUb = 0; else ;Ovf_8(j) = Ovf_8(j)+Cri_8(j);freeICUb = freeICUb+Cri_8(j);Cri_8(j) = 0;end
        if(Cri_7(j) > -freeICUb);Cri_7(j) = Cri_7(j)+freeICUb;Ovf_7(j) = Ovf_7(j)-freeICUb;freeICUb = 0; else ;Ovf_7(j) = Ovf_7(j)+Cri_7(j);freeICUb = freeICUb+Cri_7(j);Cri_7(j) = 0;end
        if(Cri_6(j) > -freeICUb);Cri_6(j) = Cri_6(j)+freeICUb;Ovf_6(j) = Ovf_6(j)-freeICUb;freeICUb = 0; else ;Ovf_6(j) = Ovf_6(j)+Cri_6(j);freeICUb = freeICUb+Cri_6(j);Cri_6(j) = 0;end
        if(Cri_5(j) > -freeICUb);Cri_5(j) = Cri_5(j)+freeICUb;Ovf_5(j) = Ovf_5(j)-freeICUb;freeICUb = 0; else ;Ovf_5(j) = Ovf_5(j)+Cri_5(j);freeICUb = freeICUb+Cri_5(j);Cri_5(j) = 0;end
        if(Cri_4(j) > -freeICUb);Cri_4(j) = Cri_4(j)+freeICUb;Ovf_4(j) = Ovf_4(j)-freeICUb;freeICUb = 0; else ;Ovf_4(j) = Ovf_4(j)+Cri_4(j);freeICUb = freeICUb+Cri_4(j);Cri_4(j) = 0;end
        if(Cri_3(j) > -freeICUb);Cri_3(j) = Cri_3(j)+freeICUb;Ovf_3(j) = Ovf_3(j)-freeICUb;freeICUb = 0; else ;Ovf_3(j) = Ovf_3(j)+Cri_3(j);freeICUb = freeICUb+Cri_3(j);Cri_3(j) = 0;end
        if(Cri_2(j) > -freeICUb);Cri_2(j) = Cri_2(j)+freeICUb;Ovf_2(j) = Ovf_2(j)-freeICUb;freeICUb = 0; else ;Ovf_2(j) = Ovf_2(j)+Cri_2(j);freeICUb = freeICUb+Cri_2(j);Cri_2(j) = 0;end
        if(Cri_1(j) > -freeICUb);Cri_1(j) = Cri_1(j)+freeICUb;Ovf_1(j) = Ovf_1(j)-freeICUb;freeICUb = 0; else ;Ovf_1(j) = Ovf_1(j)+Cri_1(j);freeICUb = freeICUb+Cri_1(j);Cri_1(j) = 0;end
        if(Cri_0(j) > -freeICUb);Cri_0(j) = Cri_0(j)+freeICUb;Ovf_0(j) = Ovf_0(j)-freeICUb;freeICUb = 0; else ;Ovf_0(j) = Ovf_0(j)+Cri_0(j);freeICUb = freeICUb+Cri_0(j);Cri_0(j) = 0;end;end
    if(freeICUb>0)
        if(Ovf_0(j)>freeICUb)
            Cri_0(j) = Cri_0(j)+freeICUb;Ovf_0(j) = Ovf_0(j)-freeICUb;freeICUb = 0; else ;Cri_0(j) = Cri_0(j)+Ovf_0(j);freeICUb = freeICUb-Ovf_0(j);Ovf_0(j) = 0;end
        if(Ovf_1(j)>freeICUb);Cri_1(j) = Cri_1(j)+freeICUb;Ovf_1(j) = Ovf_1(j)-freeICUb;freeICUb = 0; else ;Cri_1(j) = Cri_1(j)+Ovf_1(j);freeICUb = freeICUb-Ovf_1(j);Ovf_1(j) = 0;end
        if(Ovf_2(j)>freeICUb);Cri_2(j) = Cri_2(j)+freeICUb;Ovf_2(j) = Ovf_2(j)-freeICUb;freeICUb = 0; else ;Cri_2(j) = Cri_2(j)+Ovf_2(j);freeICUb = freeICUb-Ovf_2(j);Ovf_2(j) = 0;end
        if(Ovf_3(j)>freeICUb);Cri_3(j) = Cri_3(j)+freeICUb;Ovf_3(j) = Ovf_3(j)-freeICUb;freeICUb = 0; else ;Cri_3(j) = Cri_3(j)+Ovf_3(j);freeICUb = freeICUb-Ovf_3(j);Ovf_3(j) = 0;end
        if(Ovf_4(j)>freeICUb);Cri_4(j) = Cri_4(j)+freeICUb;Ovf_4(j) = Ovf_4(j)-freeICUb;freeICUb = 0; else ;Cri_4(j) = Cri_4(j)+Ovf_4(j);freeICUb = freeICUb-Ovf_4(j);Ovf_4(j) = 0;end
        if(Ovf_5(j)>freeICUb);Cri_5(j) = Cri_5(j)+freeICUb;Ovf_5(j) = Ovf_5(j)-freeICUb;freeICUb = 0; else ;Cri_5(j) = Cri_5(j)+Ovf_5(j);freeICUb = freeICUb-Ovf_5(j);Ovf_5(j) = 0;end
        if(Ovf_6(j)>freeICUb);Cri_6(j) = Cri_6(j)+freeICUb;Ovf_6(j) = Ovf_6(j)-freeICUb;freeICUb = 0; else ;Cri_6(j) = Cri_6(j)+Ovf_6(j);freeICUb = freeICUb-Ovf_6(j);Ovf_6(j) = 0;end
        if(Ovf_7(j)>freeICUb);Cri_7(j) = Cri_7(j)+freeICUb;Ovf_7(j) = Ovf_7(j)-freeICUb;freeICUb = 0; else ;Cri_7(j) = Cri_7(j)+Ovf_7(j);freeICUb = freeICUb-Ovf_7(j);Ovf_7(j) = 0;end
        if(Ovf_8(j)>freeICUb);Cri_8(j) = Cri_8(j)+freeICUb;Ovf_8(j) = Ovf_8(j)-freeICUb;freeICUb = 0; else ;Cri_8(j) = Cri_8(j)+Ovf_8(j);freeICUb = freeICUb-Ovf_8(j);Ovf_8(j) = 0;end;end
end       
    
    
Ovf = (Ovf_0+Ovf_1+Ovf_2+Ovf_3+Ovf_4+Ovf_5+Ovf_6+Ovf_7+Ovf_8);    
    
    
intss = susen./sused;    
    
    
    
    
    
    
    