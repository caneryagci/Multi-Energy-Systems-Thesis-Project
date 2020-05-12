within Wind;

model Rotor "Wind Turbine"
  import Modelica.Constants.pi;
  parameter Real c1 = 0.5176;
  parameter Real c2 = 116;
  parameter Real c3 = 0.4;
  parameter Real c4 = 5;
  parameter Real c5 = 21;
  parameter Real c6 = 0.0068;
  Modelica.Blocks.Interfaces.RealInput windspeed(start=15) annotation(
    Placement(visible = true, transformation(origin = {-106, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput p_wind(start = 1, final quantity = "Power", final unit = "W") "Power of wind(MW)" annotation(
    Placement(visible = true, transformation(origin = {102, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real Sbase = 100 "Power Rating [Normalization Factor] (MVA)";
  parameter Real rho = 1.225 "Air Density (kg/m^3)";
  parameter Modelica.SIunits.Velocity Vcutin = 4 "Cut-in velocity";
  parameter Modelica.SIunits.Velocity Vrated = 13.5 "Rated velocity";
  parameter Modelica.SIunits.Velocity Vcutoff = 22 "Cut-off velocity";
  parameter Modelica.SIunits.Velocity Vmax = 25 "Maximum velocity (v<=Vmax)";
  parameter Modelica.SIunits.Area area = 9000 "Swept Area(m2)";
  //parameter SI.Angle beta=1 "Pitch angle in degree";
  //parameter Real D = 70 "Rotor Diameter";
  parameter Real l=107 "Blade length (m)";
  parameter Real ngb=0.0084033613 "gear box ratio";//0.01123596
  parameter Real Radapt=ngb*l "r_{gearbox}*r";
  parameter Real beta = 1 "Blade(Pitch)angle in degrees";
  //parameter Real poles = 2 "Number of poles-pair";
  //parameter Real R = 17 "Rotor length (radius)(Diameter/2)";
  parameter Modelica.SIunits.Power P_nom = 1e6 "Nominal power";
  parameter Real freq=50 "frequency rating (Hz)";
  parameter Real wbase=2*pi*freq;
  //Real Tm(start=-P_nom/10);
  Real Cp "Power coefficient";
  Real lambda "Tip speed ratio";
  Real lambdai;
  Real lambdaLimited(min = 0) "Positive tip speed ratio";
 
  Modelica.Blocks.Interfaces.RealInput omega_m annotation(
    Placement(visible = true, transformation(origin = {-104, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation

// Tip speed ratio
  //lambda * windspeed = wm * R;
//lambdaLimited = if noEvent(lambda < 0) then 0 else lambda;

// Mechanical Power
  if windspeed <= Vcutin then
    p_wind * P_nom = 0;
  elseif windspeed > Vcutin and windspeed <= Vrated then
    p_wind * P_nom = 0.5 * Cp * area * rho * windspeed ^ 3;
  elseif windspeed > Vrated and windspeed <= Vcutoff then
    p_wind * P_nom = 0.5 * Cp * area * rho * Vrated ^ 3;
  else
    p_wind * P_nom = 0;
  end if;
//Power Coefficient Calculation
  Cp = c1 * (c2 * lambdai - c3 * beta - c4) * exp(-c5 * lambdai) + c6 * lambda;
  lambdai = 1 / (lambda + 0.08 * beta) - 0.035 / (beta ^ 3 + 1);
  // Tip speed ratio
  lambda = omega_m*wbase*Radapt/(windspeed);
  lambdaLimited = if noEvent(lambda<0) then 0 else lambda;
  

annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Text(origin = {-84, -24}, extent = {{-2, 2}, {2, -2}}, textString = "windspeed"), Text(origin = {-83, 40}, extent = {{-7, -6}, {3, 4}}, textString = "omega_m"), Text(origin = {41, -15}, lineColor = {0, 0, 255}, extent = {{-79, 41}, {11, -13}}, textString = "Rotor"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)),
    Diagram,
    version = "",
    __OpenModelica_commandLineOptions = "");
end Rotor;
