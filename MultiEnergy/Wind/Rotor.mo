within Wind;

model Rotor "Wind Turbine"
  import Modelica.Constants.pi;
  parameter Real c1=0.5176;
  parameter Real c2=116;
  parameter Real c3=0.4;
  parameter Real c4=5;
  parameter Real c5=21;
  parameter Real c6=0.0068;
  //Modelica.SIunits.Power power "Power of flange_a";
  Modelica.Blocks.Interfaces.RealInput windspeed annotation(
    Placement(visible = true, transformation(origin = {-174, -18}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput p_wind (start = 1, final quantity="Power", final unit="W") "Power of wind(MW)" annotation(
      Placement(visible = true, transformation(origin = {148, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  
  parameter Real Sbase = 100 "Power Rating [Normalization Factor] (MVA)";
  parameter Real rho = 1.225 "Air Density (kg/m^3)";
  parameter Modelica.SIunits.Velocity Vcutin = 4 "Cut-in velocity";
  parameter Modelica.SIunits.Velocity Vrated = 12 "Rated velocity";
  parameter Modelica.SIunits.Velocity Vcutoff = 22 "Cut-off velocity";
  parameter Modelica.SIunits.Velocity Vmax = 25 "Maximum velocity (v<=Vmax)";
  parameter Modelica.SIunits.Area area = 7000 "Swept Area(m2)";
  //parameter SI.Angle beta=1 "Pitch angle in degree";
  //parameter Real D = 70 "Rotor Diameter";
  parameter Real beta = 1 "Blade(Pitch)angle in degrees";
  parameter Real poles=2 "Number of poles-pair";
  parameter Real omega_m0=120 "rad/s";
  parameter Real R = 17 "Rotor length (radius)(Diameter/2)";
  parameter Modelica.SIunits.Power P_nom = 1e6 "Nominal power";
            
  //Real Tm(start=-P_nom/10);
  Real Cp "Power coefficient";
  Real lambda "Tip speed ratio";
  Real lambdai;
  //Real lambdaLimited(min = 0) "Positive tip speed ratio";
  //Modelica.SIunits.Angle phi "Absolute rotation angle of flange";
  Modelica.SIunits.AngularVelocity wm;
  //Modelica.SIunits.AngularVelocity wm = der(phi);
  //Real wm(unit = "rad/s") "Angular velocity of flange";
  //Real Tm "Engine Shaft Torque";
  //Modelica.SIunits.Torque tau (start=-P_nom/10);
  
equation
// Angular velocity
//w = der(phi); //phi=angle of flange
//w=(2*pi*N)/60;
//w=windspeed/
//w = 9 * windspeed / (D / 2);
//omega_m = w;
//Lambda constant value = 9

// Tip speed ratio
  lambda * windspeed = wm * R;
  //lambdaLimited = if noEvent(lambda < 0) then 0 else lambda;
//Power Coefficient Calculation
  //Cp = 0.4;
  
// Power balance
  //0 = p_wind*P_nom + wm*Tm;
 /* 
  if windspeed <= Vcutin then
    p_wind*P_nom = 0;
    
  elseif windspeed > Vcutin and windspeed <= Vrated then
    p_wind*P_nom = 0.5 * Cp * area * rho * windspeed ^ 3;

  elseif windspeed > Vrated and windspeed <= Vcutoff then
    p_wind*P_nom = 0.5 * Cp * area * rho * Vrated ^ 3;

  else
    p_wind*P_nom = 0;
  end if;*/
//Power Coefficient Calculation
//Cp = 0.4;
// 0 = p_wind*P_nom + wm*tau;
 p_wind*P_nom = 0.5 * Cp * area * rho * Vrated ^ 3;
  Cp=c1*(c2*lambdai-c3*beta-c4)*exp(-c5*lambdai)+c6*lambda;
  lambdai = 1/(lambda+0.08*beta) - 0.035/(beta^3 + 1);
  lambda = wm*R/windspeed;
  annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Text(origin = {-84, -24}, extent = {{-2, 2}, {2, -2}}, textString = "windspeed"), Text(origin = {-83, 40}, extent = {{-7, -6}, {3, 4}}, textString = "omega_m"), Text(origin = {41, -15}, lineColor = {0, 0, 255}, extent = {{-79, 41}, {11, -13}}, textString = "Rotor"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)),
    Diagram,
    version = "",
    __OpenModelica_commandLineOptions = "");
end Rotor;
