
function [obsn] = GetObser_V2_NoInfected_Spain(obs)

obsn = strings(size(obs,1),1);
for i=1:size(obs,1)

    switch string(obs(i,:))
        case 'Cum2Hospitalised'
            obsn(i,:) = strcat(obs(i,:), ' = CumHos_0+CumHos_1+CumHos_2+CumHos_3+CumHos_4+CumHos_5+CumHos_6+CumHos_7+CumHos_8');
        case 'Cum2Critical    '
            obsn(i,:) = strcat(obs(i,:), ' = CumCri_0+CumCri_1+CumCri_2+CumCri_3+CumCri_4+CumCri_5+CumCri_6+CumCri_7+CumCri_8');
        case 'Cum2Recovered   '
            obsn(i,:) = strcat(obs(i,:), ' = HoR_0+HoR_1+HoR_2+HoR_3+HoR_4+HoR_5+HoR_6+HoR_7+HoR_8');
        case 'Cum2Dead        '
            obsn(i,:) = strcat(obs(i,:), ' = Fat_0+Fat_1+Fat_2+Fat_3+Fat_4+Fat_5+Fat_6+Fat_7+Fat_8');
    end

end

obsn = char(obsn);














end




















