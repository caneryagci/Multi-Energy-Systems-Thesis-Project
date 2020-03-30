within Wind;

model Rotor "Wind Turbine"
  import Modelica.Constants.pi;
  //Modelica.SIunits.Power power "Power of flange_a";
  Modelica.Blocks.Interfaces.RealInput windspeed annotation(
    Placement(visible = true, transformation(origin = {-174, -18}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  /* Modelica.Blocks.Interfaces.RealOutput p_wind annotation(
      Placement(visible = true, transformation(origin = {148, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  */
  Real p_wind (final quantity="Power", final unit="W") "Power of wind(MW)";
  //MW
  parameter Real Sbase = 100 "Power Rating [Normalization Factor] (MVA)";
  parameter Real rho = 1.225 "Air Density (kg/m^3)";
  parameter Modelica.SIunits.Velocity Vcutin = 4 "Cut-in velocity";
  parameter Modelica.SIunits.Velocity Vrated = 12 "Rated velocity";
  parameter Modelica.SIunits.Velocity Vcutoff = 22 "Cut-off velocity";
  parameter Modelica.SIunits.Velocity Vmax = 25 "Maximum velocity (v<=Vmax)";
  parameter Modelica.SIunits.Area area = 7000 "Swept Area(m2)";
  //parameter SI.Angle beta=1 "Pitch angle in degree";
  parameter Real D = 70 "Rotor Diameter";
  parameter Real beta = 1 "Blade(Pitch)angle in degrees";
  parameter Real poles=2 "Number of poles-pair";
  parameter Real omega_m0=120 "rad/s";
  
  /*          parameter Real lambdaMin "Minimum tip speed ratio of control range";
              parameter Real lambdaMax "Maximum tip speed ratio of control range";
              parameter Real lambdaOpt "Optimum tip speed ratio, matching betaOpt";
              parameter Real betaMin "Minimum pitch angle";
              parameter Real betaMax "Maximum pitch angle";
              parameter Real betaOpt "Optimum pitch angle, matching lambdaOpt";
             */
  Real Tm;
  Real Cp "Power coefficient";
  Real lambda "Tip speed ratio";
  Real lambdaLimited(min = 0) "Positive tip speed ratio";
  //Real wm(unit = "rad/s") "Angular velocity of flange";
  //Real Tm "Engine Shaft Torque";
  Modelica.Blocks.Interfaces.RealOutput omega_m annotation(
    Placement(visible = true, transformation(origin = {150, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput wm(start=omega_m0, fixed=false) annotation(
    Placement(visible = true, transformation(origin = {-176, 36}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 64}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
// Angular velocity
//w = der(phi); //phi=angle of flange
//w=(2*pi*N)/60;
//w=windspeed/
//w = 9 * windspeed / (D / 2);
//omega_m = w;
//Lambda constant value = 9
// Tip speed ratio
  lambda * windspeed = wm * D / 2;
  lambdaLimited = if noEvent(lambda < 0) then 0 else lambda;
//Power Coefficient Calculation
//Cp = CpValue(lambdaLimited, beta);
  Cp = 0.4;
  if windspeed <= Vcutin then
    p_wind = 0;
  elseif windspeed > Vcutin and windspeed <= Vrated then
    p_wind = 0.5 * Cp * area * rho * windspeed ^ 3;
//p_wind = 0.5 * Cp * area * rho * windspeed ^ 3 / (Sbase * 1e6);
// MW;
  elseif windspeed > Vrated and windspeed <= Vcutoff then
    p_wind = 0.5 * Cp * area * rho * Vrated ^ 3;
//p_wind = 0.5 * Cp * area * rho * Vrated ^ 3 / (Sbase * 1e6);
// MW;
  else
    p_wind = 0;
  end if;
// Power balance
  Tm = p_wind / wm;
  omega_m=wm/200;
  annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Text(origin = {-84, -24}, extent = {{-2, 2}, {2, -2}}, textString = "windspeed"), Text(origin = {-83, 40}, extent = {{-7, -6}, {3, 4}}, textString = "omega_m"), Text(origin = {41, -15}, lineColor = {0, 0, 255}, extent = {{-79, 41}, {11, -13}}, textString = "Rotor"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)),
    Diagram,
    version = "",
    __OpenModelica_commandLineOptions = "");
end Rotor;
