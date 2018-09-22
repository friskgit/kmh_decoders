function loop(mode)

  if ~exist('mode', 'var') || isempty(mode)
    mode = 'normal';
  end
  
  printf('Running run_dec_KMH() for 1, 3, 5 orders')

  for i = [1,3,5]
    run_dec_KMH(i, "KMH108_AE", mode, 10)
  endfor

end 
