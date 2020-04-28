%% Inputs
%    -- resultBase: Tag for the files generated (String)
%    -- nThetaGuesses: Number of initial guesses for theta (Integer)
%    -- expdata: Path for the matlab structure with the experimental data
%    (String, only the name of the file)

function [] = RUN_PE_COVID19_V1(resultBase,nThetaGuesses,expdata)
    
    %% Add necessary paths
    addpath('../Model')
    addpath('../Model/AMIGOChanged')
    addpath('.')


    %% Specify the allowed boundaries of the parameters
    theta_min = [0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0];
    theta_max = [10,10,5,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10];

    %% Create a matrix of initial guesses for the vector of parameter estimates.


    %% Run

    














end
















































