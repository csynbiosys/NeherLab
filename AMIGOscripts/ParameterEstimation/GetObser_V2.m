
function [obsn] = GetObser_V2(obs)

obsn = strings(size(obs,1),1);
for i=1:size(obs,1)

    switch string(obs(i,:))
        case {'Cum2Infected =    ', 'CumInfected =     '}
            if strcmp('CumInfected =     ', obs(i,:))
                obsn(i,:) = strcat(obs(i,:), ' Inf_0+Inf_1+Inf_2+Inf_3+Inf_4+Inf_5+Inf_6+Inf_7+Inf_8');
            else
                obsn(i,:) = strcat(obs(i,:), ' CumInf_0+CumInf_1+CumInf_2+CumInf_3+CumInf_4+CumInf_5+CumInf_6+CumInf_7+CumInf_8');
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




















