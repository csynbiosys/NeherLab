
function [obsn] = GetObser_V2_Tested(obs)

obsn = strings(size(obs,1),1);
for i=1:size(obs,1)

    switch string(obs(i,:))
        case {'Cum2Infected =    ', 'CumInfected =     '}
            if strcmp('CumInfected =     ', obs(i,:))
                obsn(i,:) = strcat(obs(i,:), ' Tes_0+Tes_1+Tes_2+Tes_3+Tes_4+Tes_5+Tes_6+Tes_7+Tes_8');
            else
                obsn(i,:) = strcat(obs(i,:), ' CumTes_0+CumTes_1+CumTes_2+CumTes_3+CumTes_4+CumTes_5+CumTes_6+CumTes_7+CumTes_8');
            end
        case 'CumHospitalised = '
            obsn(i,:) = strcat(obs(i,:), ' Sev_0+Sev_1+Sev_2+Sev_3+Sev_4+Sev_5+Sev_6+Sev_7+Sev_8');
        case 'CumCritical =     '
            obsn(i,:) = strcat(obs(i,:), ' Cri_0+Cri_1+Cri_2+Cri_3+Cri_4+Cri_5+Cri_6+Cri_7+Cri_8');
        case 'CumRecovered =    '
            obsn(i,:) = strcat(obs(i,:), ' Rec_0+Rec_1+Rec_2+Rec_3+Rec_4+Rec_5+Rec_6+Rec_7+Rec_8');
        case 'CumDead =         '
            obsn(i,:) = strcat(obs(i,:), ' Fat_0+Fat_1+Fat_2+Fat_3+Fat_4+Fat_5+Fat_6+Fat_7+Fat_8');
    end

end

obsn = char(obsn);














end




















