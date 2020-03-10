within Wind;

model Wind_turbine1 "Wind Turbine"
  import Modelica.Constants.pi;
  //Modelica.SIunits.Power power "Power of flange_a";
  Modelica.Blocks.Interfaces.RealInput windspeed annotation(
    Placement(visible = true, transformation(origin = {-174, -18}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  /* Modelica.Blocks.Interfaces.RealOutput p_wind annotation(
      Placement(visible = true, transformation(origin = {148, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  */
  Modelica.SIunits.Power p_wind "Power of wind";
  //MW
  parameter Real Sbase = 100 "Power Rating [Normalization Factor] (MVA)";
  parameter Real rho = 1.225 "Air Density (kg/m^3)";
  parameter Modelica.SIunits.Velocity Vcutin = 4 "Cut-in velocity";
  parameter Modelica.SIunits.Velocity Vrated = 13 "Rated velocity";
  parameter Modelica.SIunits.Velocity Vcutoff = 22 "Cut-off velocity";
  parameter Modelica.SIunits.Velocity Vmax = 25 "Maximum velocity (v<=Vmax)";
  parameter Modelica.SIunits.Area area = 11310 "Swept Area";
  //m2
  //parameter SI.Angle beta=1 "Pitch angle in degree";
  parameter Real D = 90 "Rotor Diameter";
  parameter Real beta = 1 "Blade(Pitch)angle in degrees";
  /*
              parameter Real lambdaMin "Minimum tip speed ratio of control range";
              parameter Real lambdaMax "Maximum tip speed ratio of control range";
              parameter Real lambdaOpt "Optimum tip speed ratio, matching betaOpt";
              parameter Real betaMin "Minimum pitch angle";
              parameter Real betaMax "Maximum pitch angle";
              parameter Real betaOpt "Optimum pitch angle, matching lambdaOpt";
             */
  Real Cp "Power coefficient";
  Real lambda "Tip speed ratio";
  Real lambdaLimited(min = 0) "Positive tip speed ratio";
  Real w(unit = "rad/s") "Angular velocity of flange";
  //Real Tm "Engine Shaft Torque";
  Modelica.Blocks.Interfaces.RealOutput omega_m annotation(
    Placement(visible = true, transformation(origin = {150, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {108, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
// Angular velocity
//w = der(phi); //phi=angle of flange
//w=(2*pi*N)/60;
//w=windspeed/
  w = 9 * windspeed / (D / 2);
  omega_m = w;
//Lambda constant value = 9
// Tip speed ratio
  lambda * windspeed = w * D / 2;
  lambdaLimited = if noEvent(lambda < 0) then 0 else lambda;
//Power Coefficient Calculation
  Cp = CpValue(lambdaLimited, beta);
  if windspeed <= Vcutin then
    p_wind = 0;
  elseif windspeed > Vcutin and windspeed <= Vrated then
    p_wind = 0.5 * Cp * area * rho * windspeed ^ 3 / (Sbase * 1e6);
// MW;
  elseif windspeed > Vrated and windspeed <= Vcutoff then
    p_wind = 0.5 * Cp * area * rho * Vrated ^ 3 / (Sbase * 1e6);
// MW;
  else
    p_wind = 0;
  end if;
// Power balance
//power = tau * w; //tau = torque of flange
//Tm = p_wind / w;
  annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Bitmap(origin = {2, -2}, extent = {{-102, 102}, {100, -100}}, imageSource = "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"), Text(origin = {-84, -24}, extent = {{-2, 2}, {2, -2}}, textString = "windspeed"), Text(origin = {105, 57}, extent = {{-3, -1}, {3, 1}}, textString = "P wind"), Text(origin = {108, -8}, extent = {{-4, 0}, {4, 0}}, textString = "w"), Text(origin = {107, -64}, extent = {{-5, 4}, {5, 0}}, textString = "Tm"), Text(origin = {-84, -95}, extent = {{2, -1}, {-6, 3}}, textString = "beta"), Text(origin = {-83, 40}, extent = {{-7, -6}, {3, 4}}, textString = "omega_m")}, coordinateSystem(extent = {{-200, -200}, {200, 200}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "",
    __OpenModelica_commandLineOptions = "");
end Wind_turbine1;
