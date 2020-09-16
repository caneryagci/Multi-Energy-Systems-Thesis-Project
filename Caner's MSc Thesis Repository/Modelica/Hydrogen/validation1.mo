within Hydrogen;

model validation1
  Hydrogen.electrolyser_detailed electrolyser_detailed annotation(
    Placement(visible = true, transformation(origin = {11, 3}, extent = {{-43, -43}, {43, 43}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 25)  annotation(
    Placement(visible = true, transformation(origin = {-72, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 100, height = 50, offset = 0, startTime = 0)  annotation(
    Placement(visible = true, transformation(origin = {-72, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, electrolyser_detailed.T_ambient) annotation(
    Line(points = {{-60, -20}, {-28, -20}, {-28, -22}, {-24, -22}}, color = {0, 0, 127}));
  connect(ramp.y, electrolyser_detailed.Porder) annotation(
    Line(points = {{-61, 32}, {-20, 32}}, color = {0, 0, 127}));
end validation1;
