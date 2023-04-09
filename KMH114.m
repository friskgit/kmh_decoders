function [val] = KMH114(c)
      % "Studio 114 coordinates"
      % "Starting at left speaker, going clock wise, excluding center"

  if ~exist('c', 'var')
    c = 'full';
  end

  switch (c)
    case 'normal'
      val.name = 'KMH114';
			% azimuth(deg) elevation(deg) distance(metres)
      S = [
	   24.6		0	3.26
	   -26.34		0	3.3
	   -58.7		0	3.35
	   -106		0	3.27
	   -129.35 	0	3.364
	   129.35		0	3.376
	   106		0	3.262
	   58.7		0	3.296
	   45		18	3.02
	   -45		18	3.02
	   -135		18	3.05
	   135		18	3.02
	   0		90	1.60
      ];

      val.id = {'L', 
		'R', 
		'RSF', 
		'RSR', 
		'RR', 
		'RL', 
		'LSR', 
		'LSF', 
		'ULF', 
		'URF', 
		'URR', 
		'URL', 
		'VOG',};

    case 'full'
      val.name = 'KMH114C';
			% azimuth(deg) elevation(deg) distance(metres)
      S = [
	   24.6		0	3.26
	   0		0	3.27
	   -26.34	0	3.3
	   -58.7	0	3.35
	   -106		0	3.27
	   -129.35 	0	3.364
	   129.35	0	3.376
	   106		0	3.262
	   58.7		0	3.296
	   45		18	3.02
	   -45		18	3.02
	   -135		18	3.05
	   135		18	3.02
	   0		90	1.60
      ];

      val.id = {'L', 
		'C', 
		'R', 
		'RSF', 
		'RSR', 
		'RR', 
		'RL', 
		'LSR', 
		'LSF', 
		'ULF', 
		'URF', 
		'URR', 
		'URL', 
		'VOG',};

    otherwise
      error('unknown speaker array setting c = %s', c);
  end
  val.az = S(:,1)*pi/180;
  val.el = S(:,2)*pi/180;
  val.r = S(:,3);
				% direction cosines, unit vector
  [val.x, val.y, val.z] = sph2cart(val.az, val.el, 1);
  fprintf('%s\n', val.name);
end
