function [y0] = ComputeY0Guess_COVID19_NoOver_DataBased(agess,cases,N)



n = round((agess/sum(agess))*N);
ages = n / sum(n);
pop  = zeros(4, 9);


pop(1, :) = n;
pop(1, :) = pop(1, :) - cases*ages;
pop(2, :) = pop(2, :) + cases*ages*0.7/3;
pop(3, :) = pop(3, :) + cases*ages*0.7/3;
pop(4, :) = pop(4, :) + cases*ages*0.7/3;



y0 = [pop(:)'];

end
