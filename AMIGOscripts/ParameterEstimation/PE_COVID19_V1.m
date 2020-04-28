%% Inputs
%    -- epccOutputResultFileNameBase: Tag for the files generated
%    -- epcc_exps: Index of the parameter vector initial guess
%    -- global_theta_guess: Initial guess for the theta vector
%    -- expdata: Path for the matlab structure with the experimental data


function [] = PE_COVID19_V1(epccOutputResultFileNameBase,epcc_exps,global_theta_guess,expdata)
    
    %% Section taken from Processes (Lucia), helps me understand if there is
    % any errors or issues
    
    % Write the header information of the .dat file in which the results of
    % PE (estimates, relative confidence intervals, residuals, relative
    % residuals and the time required for computation) will be stored. 
    
    resultFileName = [strcat(epccOutputResultFileNameBase),'.dat'];
    rng shuffle;
    rngToGetSeed = rng;
    
    fid = fopen(resultFileName,'w');
    fprintf(fid,'HEADER DATE %s\n',datestr(datetime()));
    fprintf(fid,'HEADER RANDSEED %d\n',rngToGetSeed.Seed);
    fclose(fid);
    
    startTime = datenum(now);

    results_folder = strcat('NeherModelCovid19_PE',datestr(now,'yyyy-mm-dd-HHMMSS'));
    short_name     = strcat('TNMCov19',int2str(epcc_exps));
    
    addpath('../Model')
    addpath('.')
    
    %% Clear variables nedded by AMIGO
    
    clear inputs
    clear model;
    clear exps;
    clear best_global_theta;
    clear pe_results;
    clear pe_inputs;

    %% Load data to be fitted
    Dat = load(expdata);
    
    %% Load Model
    model = COVID19_NeherModel_V3_Over;
    inputs.model = model;
    inputs.model.par=Params_SIR([],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[5,5,5,5,5,5,5,5,5]); % Default theta vector, need to see how to modify this deppending on what do we wanna do

    inputs.pathd.results_folder = results_folder;                        
    inputs.pathd.short_name     = short_name;
    inputs.pathd.runident       = 'initial_setup';

    %% Compute Y0 (might not be required if we fit it)
    y0 = ComputeY0_COVID19_Over_WebApp([],[],inputs.model.par(1));
    
    %% Compute inputs for the model (this might need modifications deppending on what we wanna do or on how we handle the different parameters of the functions deppending on the data we have)
    % Example on how to define the mitigation measure structure
    mitigations = cell(1,2);
    mitigations{1,1}.val = 40; mitigations{1,1}.tmin = '1-feb-2020'; mitigations{1,1}.tmax = '1-sep-2020';
    % mitigations{1,2}.val = 60; mitigations{1,2}.tmin = '1-mar-2020'; mitigations{1,2}.tmax = '1-may-2020';

    [cp, M_Tx, M_Ty, T_endx] = Inputs_SIR([],[],[],mitigations);
    
    %% Define boundaries for the parameters (Need to discuss boundaries for the different parameters)
    global_theta_min = [0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0,0,0,0,...
                        0,0,0,0,0,0,0];
    global_theta_max = [10,10,10,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10,10,10,10,...
                        10,10,10,10,10,10,10];

    global_theta_guess = global_theta_guess';
















end





















