within P2H;

model p2h
  P2H.HP1 hp1 annotation(
    Placement(visible = true, transformation(origin = {0, -20}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 30)  annotation(
    Placement(visible = true, transformation(origin = {-78, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 14000)  annotation(
    Placement(visible = true, transformation(origin = {-78, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 2000, height = 30, offset = -15, startTime = 200)  annotation(
    Placement(visible = true, transformation(origin = {-78, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp.y, hp1.Tinlet) annotation(
    Line(points = {{-67, 2}, {-47.5, 2}, {-47.5, 0}, {-28, 0}}, color = {0, 0, 127}));
  connect(const.y, hp1.Toutlet) annotation(
    Line(points = {{-67, -36}, {-52, -36}, {-52, -12}, {-28, -12}}, color = {0, 0, 127}));
  connect(const1.y, hp1.Pord) annotation(
    Line(points = {{-67, -66}, {-42, -66}, {-42, -26}, {-28, -26}}, color = {0, 0, 127}));
end p2h;
