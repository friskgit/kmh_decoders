function [val] = KMH108_AE(c)
  % "Studio 108 coordinates"
  % "Outputs in circle starting at left speaker, clockwise."
  % "No center speaker."
  if ~exist('c', 'var')
    c = 'normal';
  end

switch (c)
  case 'normal'
  val.name = 'KMH108_AE';
% azimuth(deg) elevation(deg) distance(metres)
S = [
     27.167559968   0.0           2.5	
     -27.1675599677 0.0           2.5	
     -63.8232425889 0.0           2.5	
     -107.595814243 0.0           2.5	
     -152.448537925 16.0459219806 2.5	
     152.551462075  16.0459219806 2.5	
     107.404185757  0.0           2.5	
     63.817161609   0.0           2.5	
];
val.id = {'L', 'R', 'FSR', 'SR', 'RR', 'RL', 'SL', 'FSR',};

case 'full'
  val.name = 'KMH108_AE_C';
% azimuth(deg) elevation(deg) distance(metres)
S = [
     27.167559968   0.0           2.5	
     0.0            0.0           2.5
     -27.1675599677 0.0           2.5	
     -63.8232425889 0.0           2.5	
     -107.595814243 0.0           2.5	
     -152.448537925 16.0459219806 2.5	
     152.551462075  16.0459219806 2.5	
     107.404185757  0.0           2.5	
     63.817161609   0.0           2.5	
];
val.id = {'L', 'C', 'R', 'FSR', 'SR', 'RR', 'RL', 'SL', 'FSR',};

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
