function run_orders(array, mode, funct)

  if ~exist('array', 'var') || isempty(array)
    array = 'KMH108_AE';
  end

  if ~exist('mode', 'var') || isempty(mode)
    mode = 'normal';
  end

  %% set the ambisonic function to a default value
  if ~exist('funct', 'var') || isempty(funct)
    funct = 10;
  endif
  
  printf('Running run_dec_KMH() for 1, 3, 5, 7 orders.\n\n')

    for i = [1,3,5,7]
    run_dec_KMH(i, array, mode, funct)
  endfor

end 
