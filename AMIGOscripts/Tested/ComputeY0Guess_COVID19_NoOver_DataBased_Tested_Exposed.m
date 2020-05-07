function [y0] = ComputeY0Guess_COVID19_NoOver_DataBased_Tested_Exposed(agess,cases,N)


n = round((agess/sum(agess))*N);
ages = n / sum(n);
pop  = zeros(1, 9);


pop(1, :) = n;
pop(1, :) = pop(1, :) - (cases*ages);
pop(1, :) = pop(1, :) - 100;

y0 = [pop(:)'];

end
