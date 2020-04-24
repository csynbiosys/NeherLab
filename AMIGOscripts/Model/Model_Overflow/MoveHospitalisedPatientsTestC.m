


if(freeICUb<0)
{
    if(Cri_8 > -freeICUb){Cri_8 = Cri_8+freeICUb;Ovf_8 = Ovf_8-freeICUb;freeICUb = 0;} else {Ovf_8 = Ovf_8+Cri_8;freeICUb = freeICUb+Cri_8;Cri_8 = 0;}
    if(Cri_7 > -freeICUb){Cri_7 = Cri_7+freeICUb;Ovf_7 = Ovf_7-freeICUb;freeICUb = 0;} else {Ovf_7 = Ovf_7+Cri_7;freeICUb = freeICUb+Cri_7;Cri_7 = 0;}
    if(Cri_6 > -freeICUb){Cri_6 = Cri_6+freeICUb;Ovf_6 = Ovf_6-freeICUb;freeICUb = 0;} else {Ovf_6 = Ovf_6+Cri_6;freeICUb = freeICUb+Cri_6;Cri_6 = 0;}
    if(Cri_5 > -freeICUb){Cri_5 = Cri_5+freeICUb;Ovf_5 = Ovf_5-freeICUb;freeICUb = 0;} else {Ovf_5 = Ovf_5+Cri_5;freeICUb = freeICUb+Cri_5;Cri_5 = 0;}
    if(Cri_4 > -freeICUb){Cri_4 = Cri_4+freeICUb;Ovf_4 = Ovf_4-freeICUb;freeICUb = 0;} else {Ovf_4 = Ovf_4+Cri_4;freeICUb = freeICUb+Cri_4;Cri_4 = 0;}
    if(Cri_3 > -freeICUb){Cri_3 = Cri_3+freeICUb;Ovf_3 = Ovf_3-freeICUb;freeICUb = 0;} else {Ovf_3 = Ovf_3+Cri_3;freeICUb = freeICUb+Cri_3;Cri_3 = 0;}
    if(Cri_2 > -freeICUb){Cri_2 = Cri_2+freeICUb;Ovf_2 = Ovf_2-freeICUb;freeICUb = 0;} else {Ovf_2 = Ovf_2+Cri_2;freeICUb = freeICUb+Cri_2;Cri_2 = 0;}
    if(Cri_1 > -freeICUb){Cri_1 = Cri_1+freeICUb;Ovf_1 = Ovf_1-freeICUb;freeICUb = 0;} else {Ovf_1 = Ovf_1+Cri_1;freeICUb = freeICUb+Cri_1;Cri_1 = 0;}
    if(Cri_0 > -freeICUb){Cri_0 = Cri_0+freeICUb;Ovf_0 = Ovf_0-freeICUb;freeICUb = 0;} else {Ovf_0 = Ovf_0+Cri_0;freeICUb = freeICUb+Cri_0;Cri_0 = 0;}
}



if(freeICUb>0)
{
    if(Ovf_0>freeICUb){Cri_0 = Cri_0+freeICUb;Ovf_0 = Ovf_0-freeICUb;freeICUb = 0;} else {Cri_0 = Cri_0+Ovf_0;freeICUb = freeICUb-Ovf_0;Ovf_0 = 0;}
    if(Ovf_1>freeICUb){Cri_1 = Cri_1+freeICUb;Ovf_1 = Ovf_1-freeICUb;freeICUb = 1;} else {Cri_1 = Cri_1+Ovf_1;freeICUb = freeICUb-Ovf_1;Ovf_1 = 0;}
    if(Ovf_2>freeICUb){Cri_2 = Cri_2+freeICUb;Ovf_2 = Ovf_2-freeICUb;freeICUb = 2;} else {Cri_2 = Cri_2+Ovf_2;freeICUb = freeICUb-Ovf_2;Ovf_2 = 0;}
    if(Ovf_3>freeICUb){Cri_3 = Cri_3+freeICUb;Ovf_3 = Ovf_3-freeICUb;freeICUb = 3;} else {Cri_3 = Cri_3+Ovf_3;freeICUb = freeICUb-Ovf_3;Ovf_3 = 0;}
    if(Ovf_4>freeICUb){Cri_4 = Cri_4+freeICUb;Ovf_4 = Ovf_4-freeICUb;freeICUb = 4;} else {Cri_4 = Cri_4+Ovf_4;freeICUb = freeICUb-Ovf_4;Ovf_4 = 0;}
    if(Ovf_5>freeICUb){Cri_5 = Cri_5+freeICUb;Ovf_5 = Ovf_5-freeICUb;freeICUb = 5;} else {Cri_5 = Cri_5+Ovf_5;freeICUb = freeICUb-Ovf_5;Ovf_5 = 0;}
    if(Ovf_6>freeICUb){Cri_6 = Cri_6+freeICUb;Ovf_6 = Ovf_6-freeICUb;freeICUb = 6;} else {Cri_6 = Cri_6+Ovf_6;freeICUb = freeICUb-Ovf_6;Ovf_6 = 0;}
    if(Ovf_7>freeICUb){Cri_7 = Cri_7+freeICUb;Ovf_7 = Ovf_7-freeICUb;freeICUb = 7;} else {Cri_7 = Cri_7+Ovf_7;freeICUb = freeICUb-Ovf_7;Ovf_7 = 0;}
    if(Ovf_8>freeICUb){Cri_8 = Cri_8+freeICUb;Ovf_8 = Ovf_8-freeICUb;freeICUb = 8;} else {Cri_8 = Cri_8+Ovf_8;freeICUb = freeICUb-Ovf_8;Ovf_8 = 0;}
}














