model Rotor1 "Transformation of wind to mechanical power. See S. Heier, Grid Integration of Wind Energy Conversion Systems, John Wiley & Sons Ltd.,
1998"
  import Modelica.Constants.pi;
  parameter Real c1=0.5176;
  parameter Real c2=116;
  parameter Real c3=0.4;
  parameter Real c4=5;
  parameter Real c5=21;
  parameter Real c6=0.0068;
  parameter PowerSystems.Types.SI.Angle beta = 0 "Pitch angle of blades (0..20deg)";
  parameter PowerSystems.Types.SI.Density rho = 1.29 "Density of air";
  parameter PowerSystems.Types.SI.Radius R = 17 "Rotor length (radius)";
  parameter PowerSystems.Types.SI.Power P_nom = 1e6 "Nominal power"
    annotation(Dialog(group="Nominal"));
  PowerSystems.Types.SI.Area A = pi*R^2 "Area swept by rotor";
  Real Cp "power coefficient";
  Real lambda "tip speed ratio";
  Real lambdai;
  PowerSystems.Types.SI.AngularVelocity w = der(flange.phi);
  //PowerSystems.Types.SI.Power P(start = 1);
  Real P(start = 1);

  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange(tau(start=-P_nom/10))
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput v(unit="m/s") "wind speed"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
equation
  0 = P*P_nom + w*flange.tau;
  P*P_nom = 0.5*rho*A*v^3*Cp;
  Cp=c1*(c2*lambdai-c3*beta-c4)*exp(-c5*lambdai)+c6*lambda;
  lambdai = 1/(lambda+0.08*beta) - 0.035/(beta^3 + 1);
  lambda = w*R/v;
  annotation (Diagram(graphics), Icon(graphics={
        Polygon(
          points={{-6,-6},{-86,-16},{-8,8},{14,86},{6,6},{62,-58},{-6,-6}},
          lineColor={85,85,255},
          smooth=Smooth.None,
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,0},{8,-100}},
          lineColor={85,85,255},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid)}));
end Rotor1;
