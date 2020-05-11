%% Inputs
%    -- resultBase: Tag for the files generated (String)
%    -- nThetaGuesses: Number of initial guesses for theta (Integer)
%    -- expdata: Path for the matlab structure with the experimental data
%    (String, only the name of the file)

function [] = RUN_PE_COVID19_NoOver_V2_Tested_Exposed(resultBase,nThetaGuesses,expdata)
    
    %% Add necessary paths
    addpath('../Model')
    addpath('../Data')
    addpath('../Model/AMIGOChanged')
    addpath('.')


    %% Specify the allowed boundaries of the parameters
    theta_min = [1,0.001,0.001,0.0001,1,1,1,0.1,0.01,0.01,0.01,0.01,...
                        0.01,0.01,0.01,0.01,...
                        0.01,0.01,0.01,0.01,...
                        0.01,0.01,0.01,0.01,...
                        0.01,0.01,0.01,0.01,...
                        0.01,0.01,0.01,0.01,...
                        0.01,0.01,0.01,0.01,...
                        0.01,0.01,0.01,0.01,...
                        0.01,0.01,0.01,0.01,...
                        0.01,0.01,0.01,0.01];
                    
    theta_max = [1e9,50,5,30,10,1e9,1e9,30,30,30,30,1,...
                        1,1,1,1,...
                        1,1,1,1,...
                        1,1,1,1,...
                        1,1,1,1,...
                        1,1,1,1,...
                        1,1,1,1,...
                        1,1,1,1,...
                        1,1,1,1,...
                        1,1,1,1];
                    
    param_including_vector = [false,true,true,false,false,false,false,false,false,false,false,true,...
                                false,false,false,false,...
                                false,false,false,false,...
                                false,false,false,false,...
                                false,false,false,false,...
                                false,false,false,false,...
                                false,false,false,false,...
                                false,false,false,false,...
                                false,false,false,false,...
                                false,false,false,false];
                            
    param = Params_SIR_Tested([],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]); % Default theta vector, need to see how to modify this deppending on what do we wanna do
    
    theta.par = param;
    theta.max = theta_max;
    theta.min = theta_min;
    theta.fit = param_including_vector;

    %% Create a matrix of initial guesses for the vector of parameter estimates.

    M_norm = lhsdesign(nThetaGuesses,length(theta_min(param_including_vector)));
    M = zeros(size(M_norm));
    d = find(param_including_vector==1);
    for c=1:size(M_norm,2)
        for r=1:size(M_norm,1)
            M(r,c) = 10^(M_norm(r,c)*(log10(theta_max(1,d(c)))-log10(theta_min(1,d(c))))+log10(theta_min(1,d(c)))); % log exploration
        end
    end 

    
    M2 = zeros(nThetaGuesses,length(theta_min));
    for i=1:size(M_norm,1)
        M2(i,:) = param;
    end
    M2(:,(param_including_vector)) = M;
    
    % %check the location of the parameters that are fixed
    ParFull = M2;  
    save(['MatrixParameters_COVID19','.mat'],'ParFull');
    
    ParFull = load(['MatrixParameters_COVID19','.mat']);
    
    
    theta_min = zeros(1,length(theta_min));
    theta.min = theta_min;
    
    %% Run
    
    
    % This is to run the for loop for initial guesses that have not been
    % considered yet (to solve issues with the parfor stopping because it lost
    % connection to a worker)
    
    %%%%%%%%%% In order to use it, first you will need to move to the
    %%%%%%%%%% directory where the results are saved and then run the
    %%%%%%%%%% scritp again
    Folder='.';
    filePattern = fullfile(Folder, strcat(resultBase,'-','*PEMultiTest.mat'));
    Files = dir(filePattern);
    fi = strings(1,length(Files));
    for i=1:length(Files)
    fi(i) = Files(i).name;
    end
    
    
    parfor epcc_exps=1:nThetaGuesses
        m = [resultBase,'-',num2str(epcc_exps),'.mat'];

        if ~ismember(m,fi)

            try
                global_theta_guess = ParFull.ParFull(epcc_exps,:);
                epccOutputResultFileNameBase = [resultBase,'-',num2str(epcc_exps)];
                [out] = PE_COVID19_NoOver_V2_Tested_Exposed(epccOutputResultFileNameBase,epcc_exps,global_theta_guess,expdata,theta);
            catch err
                %open file
                errorFile = [resultBase,'-',num2str(epcc_exps),'.errorLog'];
                fid = fopen(errorFile,'a+');
                fprintf(fid, '%s', err.getReport('extended', 'hyperlinks','off'));
                % close file
                fclose(fid);
            end
        end
    end













end
















































