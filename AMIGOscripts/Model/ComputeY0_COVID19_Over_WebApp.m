
function [y0] = ComputeY0_COVID19_Over_WebApp(agess,cases,N)

if nargin == 0
    agess = [39721484, 42332393, 46094077, 44668271, 40348398, 42120077, 38488173, 24082598, 13147180];
    cases = 8;
    N = sum(agess);
else
    if isempty(agess);agess = [39721484, 42332393, 46094077, 44668271, 40348398, 42120077, 38488173, 24082598, 13147180]; end
    if isempty(cases); cases = 8; end
    if isempty(N); N = sum(agess); end
end

n = round((agess/sum(agess))*N);

% Definition of initial conditions
pop  = zeros(12, 9);

for i = 1:9
    pop(1, :) = n(i);
    if i==round(9/2)
        pop(1, :) = pop(1, :) - cases;
        pop(5, :) = pop(5, :) + cases*0.3;
        pop(2, :) = pop(2, :) + cases*(0.7/3);
        pop(3, :) = pop(3, :) + cases*(0.7/3);
        pop(4, :) = pop(4, :) + cases*(0.7/3);
    end
    y0 = pop(:)';

end













