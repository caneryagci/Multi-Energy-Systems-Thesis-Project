within Hydrogen;

model Controller_DSM
parameter Real Smax = 100;
parameter Real nmax =1.1;
parameter Real nmin = 0.001;
//Real reference;




  
  Modelica.Blocks.Interfaces.RealInput P annotation(
    Placement(visible = true, transformation(origin = {-22, 84}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {60, -102}, extent = {{20, -20}, {-20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput S_storage annotation(
    Placement(visible = true, transformation(origin = {30, 84}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-28, -106}, extent = {{20, -20}, {-20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput generation annotation(
    Placement(visible = true, transformation(origin = {-88, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-88, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput demand annotation(
    Placement(visible = true, transformation(origin = {-88, -10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-102, 22}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pmin annotation(
    Placement(visible = true, transformation(origin = {76, -36}, extent = {{-22, -22}, {22, 22}}, rotation = 0), iconTransformation(origin = {127, 71}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pmax annotation(
    Placement(visible = true, transformation(origin = {77, -79}, extent = {{-23, -23}, {23, 23}}, rotation = 0), iconTransformation(origin = {128, 10}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID pid(limitsAtInit = true, withFeedForward = false, yMax = 1.1)  annotation(
    Placement(visible = true, transformation(origin = {-52, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Pbalance annotation(
    Placement(visible = true, transformation(origin = {24, -6}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-25, 71}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-2, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter Real S_emergency= 0.5*Smax;
equation
  if S_storage <= Smax then
    Pmin = Pbalance;
    Pmax = 1;
    //reference = 0;
  elseif S_storage > Smax then
    Pmin = 0.1;
    Pmax = Pmin;
    //reference = 0;
  elseif S_storage <= S_emergency then
    //reference = 0.1;
    Pmin = 1;
    Pmax = Pmin;
  else
    Pmin = Pbalance;
    Pmax = 1;
    //reference = 0;
  end if;
  connect(demand, pid.u_s) annotation(
    Line(points = {{-88, -10}, {-64, -10}}, color = {0, 0, 127}));
  connect(generation, pid.u_m) annotation(
    Line(points = {{-88, -50}, {-52, -50}, {-52, -22}}, color = {0, 0, 127}));
  connect(pid.y, gain.u) annotation(
    Line(points = {{-40, -10}, {-26, -10}, {-26, -8}, {-14, -8}, {-14, -8}}, color = {0, 0, 127}));
  connect(gain.y, Pbalance) annotation(
    Line(points = {{10, -8}, {17, -8}, {17, -6}, {24, -6}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {19, -6}, lineColor = {0, 0, 255}, extent = {{-65, 66}, {37, -42}}, textString = "Controller"), Text(origin = {-86, 53}, extent = {{-12, 9}, {60, -33}}, textString = "demand"), Text(origin = {-87, 1}, extent = {{75, -63}, {-11, 7}}, textString = "generation"), Text(origin = {59, -58}, extent = {{-25, 12}, {33, -26}}, textString = "P"), Text(origin = {-21, -74}, extent = {{-29, 34}, {29, -34}}, textString = "S_storage"), Text(origin = {74, 85}, extent = {{-20, 39}, {20, -39}}, textString = "Pmin"), Text(origin = {76, 25}, extent = {{-20, 39}, {20, -39}}, textString = "Pmax")}, coordinateSystem(initialScale = 0.1)));
end Controller_DSM;
