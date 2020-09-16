within Hydrogen;

model Controller_P2G2
  //parameter Real Smax=10;
  //parameter Real S_emergency=0.48;
  //parameter Real Pnom=1;
  //parameter Real Pshutdown=0.1;
  Modelica.Blocks.Interfaces.RealInput S_storage annotation (Placement(
        transformation(extent={{-112,-12},{-88,12}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput levelSetPoint annotation (Placement(
        transformation(extent={{94,-12},{118,12}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput demand annotation(
    Placement(visible = true, transformation(origin = {-98, 46}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, 46}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold = 4.8) annotation(
    Placement(visible = true, transformation(origin = {-2, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch11 annotation(
    Placement(visible = true, transformation(origin = {48, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold = 10) annotation(
    Placement(visible = true, transformation(origin = {-44, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {6, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-21, -35}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant2(k = 1) annotation(
    Placement(visible = true, transformation(origin = {41, -81}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 1)  annotation(
    Placement(visible = true, transformation(origin = {75, -9}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
equation
  
  connect(constant1.y, switch1.u3) annotation(
    Line(points = {{-13, -35}, {-6, -35}, {-6, -10}}, color = {0, 0, 127}));
  connect(lessEqualThreshold.y, switch1.u2) annotation(
    Line(points = {{-33, -2}, {-6, -2}}, color = {255, 0, 255}));
  connect(greaterEqualThreshold.y, switch11.u2) annotation(
    Line(points = {{9, -66}, {30, -66}, {30, -10}, {36, -10}}, color = {255, 0, 255}));
  connect(switch1.y, switch11.u1) annotation(
    Line(points = {{17, -2}, {36, -2}}, color = {0, 0, 127}));
  connect(S_storage, lessEqualThreshold.u) annotation(
    Line(points = {{-100, 0}, {-58, 0}, {-58, -2}, {-56, -2}}, color = {0, 0, 127}));
  connect(S_storage, greaterEqualThreshold.u) annotation(
    Line(points = {{-100, 0}, {-72, 0}, {-72, -68}, {-14, -68}, {-14, -66}}, color = {0, 0, 127}));
  connect(constant2.y, switch11.u3) annotation(
    Line(points = {{48, -80}, {48, -50}, {36, -50}, {36, -18}}, color = {0, 0, 127}));
  connect(demand, switch1.u1) annotation(
    Line(points = {{-98, 46}, {-20, 46}, {-20, 6}, {-6, 6}, {-6, 6}}, color = {0, 0, 127}));
  connect(switch11.y, firstOrder.u) annotation(
    Line(points = {{60, -10}, {64, -10}, {64, -10}, {66, -10}, {66, -8}}, color = {0, 0, 127}));
  connect(firstOrder.y, levelSetPoint) annotation(
    Line(points = {{82, -8}, {88, -8}, {88, -2}, {106, -2}, {106, 0}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(initialScale = 0.1)));
end Controller_P2G2;
