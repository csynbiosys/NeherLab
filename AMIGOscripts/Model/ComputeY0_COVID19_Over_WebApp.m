
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
    pop(1, i) = n(i);
    if i==round(9/2)
        pop(1, i) = pop(1, i) - cases;
        pop(5, i) = pop(5, i) + cases*0.3;
        pop(2, i) = pop(2, i) + cases*(0.7/3);
        pop(3, i) = pop(3, i) + cases*(0.7/3);
        pop(4, i) = pop(4, i) + cases*(0.7/3);
    end
y0 = [pop(:)',sum(pop(1, :)),(sum(pop(2, :))+sum(pop(3, :))+sum(pop(4, :))), sum(pop(5, :)), sum(pop(6, :)),...
    sum(pop(7, :)),sum(pop(8, :)),sum(pop(9, :)),sum(pop(10, :)),sum(pop(11, :)),sum(pop(12, :))];

end













