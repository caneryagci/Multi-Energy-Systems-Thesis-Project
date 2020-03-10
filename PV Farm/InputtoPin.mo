model InputtoPin
  Modelica.Blocks.Interfaces.RealInput id annotation(
    Placement(visible = true, transformation(origin = {-90, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput iq annotation(
    Placement(visible = true, transformation(origin = {-90, 24}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 24}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vd annotation(
    Placement(visible = true, transformation(origin = {-94, -26}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, -26}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vq annotation(
    Placement(visible = true, transformation(origin = {-92, -68}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-92, -68}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  OpenIPSL.Interfaces.PwPin p annotation(
    Placement(visible = true, transformation(origin = {86, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {86, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput v(start=V_0) annotation(
    Placement(visible = true, transformation(origin = {82, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {82, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput angle(start=angle_0) annotation(
    Placement(visible = true, transformation(origin = {82, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {82, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

parameter Real V_0=1.00018548610126 "Voltage magnitude (pu)"
    annotation (Dialog(group="Power flow data"));
parameter Real angle_0=-0.0000253046024029618 "Voltage angle (deg)"
    annotation (Dialog(group="Power flow data"));
    
equation

  p.ir = iq
    "change of sign due to the fact than in modelica when entering is + and in this case is going out";
  p.ii = id
    "change of sign due to the fact than in modelica when entering is + and in this case is going out";
  p.vr = vq;
  p.vi = vd;
  
  v = sqrt(p.vr^2 + p.vi^2);
  angle = atan2(p.vi, p.vr);
  
annotation(
    uses(Modelica(version = "3.2.3"), OpenIPSL(version = "1.5.0")),
    Icon(graphics = {Text(origin = {-89, 52}, extent = {{-3, 0}, {3, 0}}, textString = "id"), Text(origin = {-87, 9}, extent = {{-3, -1}, {3, 1}}, textString = "iq"), Text(origin = {-90, -40}, extent = {{-4, 0}, {4, 0}}, textString = "vd"), Text(origin = {-91, -84}, extent = {{-3, 0}, {3, 0}}, textString = "vq"), Rectangle(origin = {-2, -2}, extent = {{-88, 94}, {88, -94}})}));end InputtoPin;
