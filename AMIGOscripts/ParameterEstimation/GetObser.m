
function [obsn] = GetObser(obs)

obsn = strings(size(obs,1),1);
for i=1:size(obs,1)

    switch string(obs(i,:))
        case {'Cum2Infected =    ', 'CumInfected =     '}
            if strcmp('CumInfected =     ', obs(i,:))
                obsn(i,:) = strcat(obs(i,:), ' Inf');
            else
                obsn(i,:) = strcat(obs(i,:), ' CumInf');
            end
        case 'CumHospitalised = '
            obsn(i,:) = strcat(obs(i,:), ' Sev');
        case 'CumCritical =     '
            obsn(i,:) = strcat(obs(i,:), ' Cri');
        case 'CumRecovered =    '
            obsn(i,:) = strcat(obs(i,:), ' Rec');
        case 'CumDead =         '
            obsn(i,:) = strcat(obs(i,:), ' Fat');
    end

end

obsn = char(obsn);














end




















