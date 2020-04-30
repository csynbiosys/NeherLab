%% Inputs
%   - Country: String with the country name desired to get the mitigation
%   data over time
%   - fd: First day of the simulation (string)
%   - ld: Last day of the simulation (string)

function [mitigation] = ExtractMitigation(country, fd, ld)
%% Ad path of directory with mitigation json file
addpath('../../policy')

%% Get JSON file according to the country selected
switch country
    case {'Italy','italy','ITA'}
        fname = '../../policy/italy_mitigation.json';         
    case {'Spain','spain', 'ESP'}
        
    case {'UK', 'uk', 'United Kingdom', 'GBR'}
        
end

%% Open JSON file
fid = fopen(fname); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
val = jsondecode(str);

%% Extract data from file and modify date notation
VAL = orderfields(val);

mitval = struct2array(VAL);
mitdatB = fieldnames(VAL);
mitdat = strings(1,length(mitval));
for i=1:length(mitval)
    mitdat(1,i) = GetDateJson(mitdatB{i});
end

%% Check if we are asking for days with no data
if datetime(mitdat(1,end)) < datetime(ld)
    disp('You have asked to account for days where we do not have mitigation policy values!!!!')
    return
end


%% Check for empty dates
rnod = datetime(mitdat(1,1)):datetime(mitdat(1,end)); % Real vector of dates of days
rnod = string(datestr(rnod))';

% Add empty date in dates vector and and previous mitigation value in that
% point
if length(mitdat)~=length(rnod)
    for i=1:max(length(mitdat),length(rnod))
        if length(mitdat)<i
            mitdat = [mitdat,rnod(i)];
            mitval = [mitval,mitval(end)];
        elseif ~strcmp(mitdat(1,i),rnod(1,i))
            mitdat = [mitdat(1:i-1), rnod(i), mitdat(i:end)];
            mitval = [mitval(1:i-1), mitval(i-1),mitval(i:end)]; %% Alternative is to ad average of mitval(i-1) and mitval(i), which would be an interpolation
        end
    end
end


%% Extract mitigation vector bounded by the desired dates
simd = datetime(fd):datetime(ld); % Real vector of dates of days
simd = string(datestr(simd))';

indxs = zeros(1,length(mitdat));
for i=1:length(mitdat)
    for j=1:length(simd)
        if strcmp(mitdat(1,i),simd(1,j))
            indxs(1,i) = true;
        end
    end
end

mitigation = mitval(indxs==1);





end


















