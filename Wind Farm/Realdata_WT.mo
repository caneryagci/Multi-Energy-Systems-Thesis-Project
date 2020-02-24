model Realdata_WT
  //parameter Real scale(min=0) = 11 "Scale parameter in m/s";//lambda
  //parameter Real shape(min=0) = 2.02 "Shape parameter in p.u.";
  parameter Integer n = 60 "Number of intervals";
  parameter Real Cp = 0.53 "Power coefficient";
  parameter Modelica.SIunits.Velocity Vcutin = 4 "Cut-in velocity";
  parameter Modelica.SIunits.Velocity Vrated = 13 "Rated velocity";
  parameter Modelica.SIunits.Velocity Vcutoff = 22 "Cut-off velocity";
  parameter Modelica.SIunits.Velocity Vmax = 25 "Maximum velocity (v<=Vmax)";
  parameter Real area = 11310 "Swept Area";//m2 Swept Area
  final parameter Modelica.SIunits.Velocity dv = Vmax / n "Velocity increment";
  final parameter Modelica.SIunits.Velocity vDiscrete[n] = array(k * dv for k in 1:n) "Discrete velocities";
  final parameter Real weibull[n] = array(((shape/scale)*(vDiscrete[k]/scale)^(shape - 1)*exp(-(vDiscrete[k]/scale)^shape)) for k in 1:n) "Weibull probaility";
  final parameter Real weibull_sum = sum(weibull) "Sum of all weibull probabilities";
  Real p_wind[n];   // MW;
  Real total[n];
  Real Pavg;
   Modelica.Blocks.Interfaces.RealInput scale annotation(
    Placement(visible = true, transformation(origin = {-100, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 56}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
               Modelica.Blocks.Interfaces.RealInput shape annotation(
    Placement(visible = true, transformation(origin = {-100, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -54}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
                   OpenIPSL.Interfaces.PwPin pin annotation(
    Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 // Modelica.Blocks.Interfaces.RealOutput v(unit = "m/s") "Wind velocity" annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
equation
for i in 1:n loop
    if vDiscrete[i] <=Vcutin then
      p_wind[i]=0;
    elseif vDiscrete[i] > Vcutin and vDiscrete[i] <=Vrated then
      p_wind[i]= 0.5 * Cp *area * 1.225 * vDiscrete[i] ^ 3 / 1e6; // MW;
    elseif vDiscrete[i] >Vrated and vDiscrete[i] <=Vcutoff then
      p_wind[i]= 0.5 * Cp * area * 1.225 * Vrated ^ 3 / 1e6; // MW;
    else
      p_wind[i]=0;
    end if;
  end for; 

  total = weibull .* p_wind;
  Pavg = sum(total); // MWh(multiply by minutes or hours for hourly daily average?)

end Realdata_WT;
