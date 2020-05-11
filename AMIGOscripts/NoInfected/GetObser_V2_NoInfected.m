
function [obsn] = GetObser_V2_NoInfected(obs)

obsn = strings(size(obs,1),1);
for i=1:size(obs,1)

    switch string(obs(i,:))
        case 'CumHospitalised = '
            obsn(i,:) = strcat(obs(i,:), ' Sev_0+Sev_1+Sev_2+Sev_3+Sev_4+Sev_5+Sev_6+Sev_7+Sev_8');
        case 'CumCritical =     '
            obsn(i,:) = strcat(obs(i,:), ' Cri_0+Cri_1+Cri_2+Cri_3+Cri_4+Cri_5+Cri_6+Cri_7+Cri_8');
        case 'CumRecovered =    '
            obsn(i,:) = strcat(obs(i,:), ' HoR_0+HoR_1+HoR_2+HoR_3+HoR_4+HoR_5+HoR_6+HoR_7+HoR_8');
        case 'CumDead =         '
            obsn(i,:) = strcat(obs(i,:), ' Fat_0+Fat_1+Fat_2+Fat_3+Fat_4+Fat_5+Fat_6+Fat_7+Fat_8');
    end

end

obsn = char(obsn);














end




















