function [val] = romans_dome(c)
  % "Romans coordinates"
  % "Traversing speaker counter clock wise."

  if ~exist('c', 'var')
  c = 'normal';
end

val.name = 'romans';
% "azimuth(deg) elevation(deg) distance(metres)"
S = [
     75 21 4.3
     45 21 4.3
     15 21 4.3
     345 21 4.3
     315 21 4.3
     285 21 4.3
     255 21 4.3
     225 21 4.3
     195 21 4.3
     165 21 4.3
     135 21 4.3
     105 21 4.3

     67.5 55 3.8
     22.5 55 3.8
     337.5 55 3.8
     292.5 55 3.8
     247.5 55 3.8
     202.5 55 3.8
     157.5 55 3.8
     112.5 55 3.8

     90 79 3.8
     0 79 3.8
     270 79 3.8
     180 79 3.8
       ];
val.id = {
	  'S1',
	  'S2',
	  'S3',
	  'S4',
	  'S5',
	  'S6',
	  'S7',
	  'S8',
	  'S9',
	  'S10',
	  'S11',
	  'S12', 
	  'S13', 
	  'S14', 
	  'S15', 
	  'S16', 
	  'S17', 
	  'S18', 
	  'S19', 
	  'S20',
	  'S21',
	  'S22', 
	  'S23', 
	  'S24', 
};

val.az = S(:,1)*pi/180;
val.el = S(:,2)*pi/180;
val.r = S(:,3);

% direction cosines, unit vector
  [val.x, val.y, val.z] = sph2cart(val.az, val.el, 1);

fprintf('%s\n', val.name);
end
