
function [cp, M_Tx, M_Ty, T_endx] = Inputs_SIR(fds, lds, peakMonth, mitigations)

if nargin == 0
    fds = '1-feb-2020'; % Last day of the simulation
    lds = '1-sep-2020'; % First day of the simulation
    peakMonth = 0; %Peak month from 0 to 11
    mitigations = cell(1,1);
    mitigations{1,1}.val = 40; mitigations{1,1}.tmin = '1-feb-2020'; mitigations{1,1}.tmax = '1-sep-2020';
else
    if isempty(fds); fds = '1-feb-2020'; end
    if isempty(lds); lds = '1-sep-2020'; end
    if isempty(peakMonth); peakMonth = 0; end
    if isempty(mitigations); mitigations = cell(1,1); mitigations{1,1}.val = 40; mitigations{1,1}.tmin = '1-feb-2020'; mitigations{1,1}.tmax = '1-sep-2020'; end
end

NumDays = lds; % Last day of the simulation
difda = daysact('1-jan-2020', fds); % Offset of the first day of the simulation and the first day of the year
month2day = @(x) x*30+15; % Function from Neher code to get peak of seasonality of the month
maxd = daysact(fds, NumDays); % Days of the simulation
da = 0:maxd-1; % String of days of the simulation
cp = cos(2*pi*(((da+difda)/365)-(month2day(peakMonth)/365))); % Cosine function



M_Tx = da; % Time vector for the input
T_endx = length(da); % Maximum number of days. It should be equal to maxd
mits = nan(length(mitigations),T_endx);
for i=1:length(mitigations)
    if ~isempty(mitigations{1,i})
        dfz = daysact(fds, mitigations{1,i}.tmin);
        dfe = daysact(mitigations{1,i}.tmax, lds);
        mits(i,dfz+1:(T_endx-dfe)) = 1-mitigations{1,i}.val/100;
        mits(mits==0)= 0.01;
    end
end

if length(mitigations)>1
    M_Ty = prod(mits, 'omitnan');
else
    M_Ty = mits;
end












end






















