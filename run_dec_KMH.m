function run_dec_KMH( order, location, array, funct )
  %% Call like this: run_dec_KMH(1, "KMH108_AE", "full", 9)
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

    %% set the ambisonic function to a default value
    if ~exist('funct', 'var') || isempty(funct)
      funct = 10;
    endif

    %% Info message
    printf('Using location %s\n', location);
    printf('Compiling to order %d\n', order);
    printf('Using function %d on the array \"%s\"\n', funct, array);
    
    if ~exist('ambi_run_pinv', 'file')
        addpath(fullfile('../../', 'matlab'));
        if ~exist('ambi_run_pinv', 'file')
            error('Cannot find ADT MATLAB scripts');
        end
    end
    
    %% set the channel definitions.
    C = ambi_channel_definitions(order, order, 'HP', 'ACN', 'SN3D');  %

    %% load the speaker array.
    S = loc(array);

    imaginary_speaker = [...
        0 0 -1; % one at the bottom 
			];
    switch funct
        case 1 % AllRAD
            ambi_run_allrad(...
                S,...
                [4,3], ...     % ambisonic order
                imaginary_speaker, ...  % imaginary speaker at bottom of dome
                [], ...        % default output
                false);         % graphics
            
        case 2 % EvenEnergy
            ambi_run_pinv(...
                S,...
                [order,order], ...      % ambisonic order
                imaginary_speaker, ...  % imaginary speaker at bottom of dome
                [], ...        % default output
                true, ...      % graphics
		'HV',...       % mixed order method
                1);
            
        case 3 % Mode-Matching
            ambi_run_pinv(...
                S, ...
                [order,order], ...      % ambisonic order
                imaginary_speaker, ... % imaginary speaker at bottom of dome
                [], ...        % default output
                true, ...      % graphics
		'HV',...       % mixed order method
                0);
            
        case 4 % Energy limited 50%
            ambi_run_pinv(...
                S, ...
                [order,order], ...      % ambisonic order
                imaginary_speaker, ...  % imaginary speaker at bottom of dome
                [], ...        % default output
                true, ...      % graphics
		'HV',...       % mixed order method
                1/2);

            % test for mixed order slepian new 3/5/2015
        case 5 % Spherical Slepian
            ambi_run_SSF(...
                S, ...
                C, ...%[order,order], ...      % ambisonic order
                imaginary_speaker, ...  % imaginary speaker at bottom of dome
                [], ...        % default output
                false, ...     % graphics
		'HV',...       % mixed order method
                []);

        case 6 % AllRAD ACN/N3D
            ambi_run_allrad(...
                S,...
                C, ...      % ambisonic order
                imaginary_speaker, ...  % imaginary speaker at bottom of dome
                [], ...         % default output
                false);         % don't do graphics
					     
	case 7 % Test
	  printf("Test complete.\n");
    end
end
