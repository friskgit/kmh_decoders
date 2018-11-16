function run_dec_KMH( order, location, array, funct )
  %% Call like this: run_dec_KMH(1, "KMH108_AE", "full", 9)
  %% The location argument points to the room in KMH for which
  %% to calculate a decoder matrix.
  %% The array argument points to the particular variation of the speaker array.
  
    %% set order to 1 if argument is missing
    if ~exist('order', 'var') || isempty(order)
        order = 1;
    end
    
    %% loc is the current location for which to generate the decoder
    %% defaults to KMH108_AE()
    if ~exist('location', 'var') || isempty(location)
      loc = KMH108_AE();
      location = "KMH108_AE()";
    else
      loc = str2func(location)
    endif

    %% set array to 1 if argument is missing
    if ~exist('array', 'var') || isempty(array)
        array = 'normal';
    end

    %% set the ambisonic function to a default value,
    %% the empty function
    if ~exist('funct', 'var') || isempty(funct)
      funct = 7;
    endif

    printf('Using location %s\n', location);
    printf('Compiling to order %d\n', order);
    printf('Using function %d on the array \"%s\"\n', funct, array);

    %% Make sure that matlab scripts are loaded...
    if ~exist('ambi_run_pinv', 'file')
        addpath(fullfile('../../', 'matlab'));
        if ~exist('ambi_run_pinv', 'file')
            error('No MATLAB scripts...');
        end
    end
    
    %% set the channel definitions.
    %% Use ACN channel order and SN3D normalization as a default
    C = ambi_channel_definitions(order, order, 'HP', 'ACN', 'SN3D');  %
    MC = ambi_channel_definitions(4, 3, 'HV', 'ACN', 'SN3D');  %
    PC = ambi_channel_definitions(5, 3, 'HV', 'ACN', 'SN3D');  %
    
    %% load the speaker array.
    S = loc(array);

    imaginary_speaker = [...
        0 0 -1; % one at the bottom 
			];
    switch funct
    case 1 % AllRAD, Mixed order 4/3, see the MC channel definition above
            ambi_run_allrad(...
                S,...
                MC, ...     % channel definition
                imaginary_speaker, ...  % imaginary speaker at bottom of dome
                [], ...        % default output
                false);         % graphics
            
        case 2 % EvenEnergy
            ambi_run_pinv(...
                S,...
                C, ...      % channel definition
                imaginary_speaker, ...  % imaginary speaker at bottom of dome
                [], ...        % default output
                false, ...      % graphics
		'HV',...       % mixed order method
                0);

	    % This coesn't work
        case 3 % Mode-Matching
            ambi_run_pinv(...
                S, ...
                C, ...      % channel definition
                imaginary_speaker, ... % imaginary speaker at bottom of dome
                [], ...        % default output
                false, ...      % graphics
		'HV',...       % mixed order method
                0);
            % Funkar upp till 6 ordningen
        case 4 % Energy limited 50%
            ambi_run_pinv(...
                S, ...
                PC, ...      % channel definition
                imaginary_speaker, ...  % imaginary speaker at bottom of dome
                [], ...        % default output
                true, ...      % graphics
		'HV',...       % mixed order method
                1/2);

        case 5 % Spherical Slepian
            ambi_run_SSF(...
                S, ...
                [order,order], ...%[order,order], ...      % ambisonic order
                imaginary_speaker, ...  % imaginary speaker at bottom of dome
                [], ...        % default output
                false, ...     % graphics
		'HP',...       % mixed order method
                []);

        case 6 % AllRAD 
            ambi_run_allrad(...
                S,...
                C, ...      % ambisonic order
                imaginary_speaker, ...  % imaginary speaker at bottom of dome
                [], ...         % default output
                true);         % don't do graphics
					     
	case 7 % Test
	  printf("Test complete.\n");
    end
end
