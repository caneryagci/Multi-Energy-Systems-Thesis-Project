model Rotor_PS "Transformation of wind to mechanical power. See S. Heier, Grid Integration of Wind Energy Conversion Systems, John Wiley & Sons Ltd.,
1998"
  import Modelica.Constants.pi;
  import SI = Modelica.SIunits;
  parameter Real c1=0.5176;
  parameter Real c2=116;
  parameter Real c3=0.4;
  parameter Real c4=5;
  parameter Real c5=21;
  parameter Real c6=0.0068;
  parameter Modelica.SIunits.Velocity Vcutin = 4 "Cut-in velocity";
  parameter Modelica.SIunits.Velocity Vrated = 12 "Rated velocity";
  parameter Modelica.SIunits.Velocity Vcutoff = 22 "Cut-off velocity";
  parameter Modelica.SIunits.Velocity Vmax = 25 "Maximum velocity (v<=Vmax)";
  parameter Modelica.SIunits.Angle beta = 0 "Pitch angle of blades (0..20deg)";
  parameter Modelica.SIunits.Density rho = 1.29 "Density of air";
  parameter Modelica.SIunits.Radius R = 17 "Rotor length (radius)";
  parameter Modelica.SIunits.Power P_nom = 1e6 "Nominal power"
    annotation(Dialog(group="Nominal"));
  Real A(quantity="AngularVelocity", unit="rad/s") = pi*R^2 "Area swept by rotor";
  Real Cp "power coefficient";
  Real lambda "tip speed ratio";
  Real lambdai;
  Real w = der(flange.phi);
  Real P(start = 1)"pu real power";
  //SIpu.Power P(start = 1);

  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange(tau(start=-P_nom/10))
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput v(unit="m/s") "wind speed"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.RealOutput Preal annotation(
    Placement(visible = true, transformation(origin = {110, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  0 = P*P_nom + w*flange.tau;
  //P*P_nom = 0.5*rho*A*v^3*Cp;
  if v <= Vcutin then
    P*P_nom = 0;
    
  elseif v > Vcutin and v <= Vrated then
    P*P_nom = 0.5 * Cp * A * rho * v ^ 3;

  elseif v > Vrated and v <= Vcutoff then
    P*P_nom = 0.5 * Cp * A * rho * Vrated ^ 3;

  else
    P*P_nom = 0;
  end if;
  
  Cp=c1*(c2*lambdai-c3*beta-c4)*exp(-c5*lambdai)+c6*lambda;
  lambdai = 1/(lambda+0.08*beta) - 0.035/(beta^3 + 1);
  lambda = w*R/v;
  Preal=P;
  annotation(
    Diagram(graphics),
    Icon(graphics = {Polygon(lineColor = {85, 85, 255}, fillColor = {85, 85, 255}, fillPattern = FillPattern.Solid, points = {{-6, -6}, {-86, -16}, {-8, 8}, {14, 86}, {6, 6}, {62, -58}, {-6, -6}}), Rectangle(lineColor = {85, 85, 255}, fillColor = {85, 85, 255}, fillPattern = FillPattern.Solid, extent = {{-8, 0}, {8, -100}})}, coordinateSystem(initialScale = 0.1)),
    uses(Modelica(version = "3.2.3")));
end Rotor_PS;
