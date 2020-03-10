model weibull_characteristic_plot
  parameter Real lambda(min=0) = 11 "Scale parameter in m/s";
  parameter Real shape(min=0) = 2.02 "Shape parameter in p.u.";
  parameter Integer n = 60 "Number of intervals";
  parameter Modelica.SIunits.Velocity Vcutin = 4 "Mean velocity";
  parameter Modelica.SIunits.Velocity Vrated = 13 "Mean velocity";
  parameter Modelica.SIunits.Velocity Vcutoff = 22 "Mean velocity";
  parameter Modelica.SIunits.Velocity vMax = 25 "Maximum velocity (v<=vMax)";
  parameter Real area = 11310;//m2 Swept Area

  final parameter Modelica.SIunits.Velocity dv = vMax / n "Velocity increment";
  final parameter Modelica.SIunits.Velocity vDiscrete[n] = array(k * dv for k in 1:n) "Discrete velocities";
  final parameter Real weibull[n] = array(((shape/lambda)*(vDiscrete[k]/lambda)^(shape - 1)*exp(-(vDiscrete[k]/lambda)^shape)) for k in 1:n) "Weibull probaility";
  final parameter Real weibull_sum = sum(weibull) "Sum of all weibull probabilities";
  //final parameter Real p_wind[n] = 0.5 * area * 1.225 * vDiscrete .^ 3 / 1e6; // MW;
  Real p_wind[n]; // MW;
  Real total[n];
  Real Pavg;
  
 // Modelica.Blocks.Interfaces.RealOutput v(unit = "m/s") "Wind velocity" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
  
equation
for i in 1:n loop
    if vDiscrete[i] <=Vcutin then
      p_wind[i]=0;
    elseif vDiscrete[i] > Vcutin and vDiscrete[i] <=Vrated then
      p_wind[i]= 0.5 * area * 1.225 * vDiscrete[i] ^ 3 / 1e6; // MW;
    elseif vDiscrete[i] >Vrated and vDiscrete[i] <=Vcutoff then
      p_wind[i]= 0.5 * area * 1.225 * Vrated ^ 3 / 1e6; // MW;
    else
      p_wind[i]=0;
    end if;
  end for;
  
  total = (weibull .* p_wind);
  Pavg = sum(total); // MWh(multiply by minutes or hours for hourly daily average?)
end weibull_characteristic_plot;
