model gasgrd
  Modelica.Blocks.Sources.Ramp ramp(duration = 30, height = 400, offset = 400, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = {-56, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  electrolyser electrolyser1 annotation(
    Placement(visible = true, transformation(origin = {-4, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp.y, electrolyser1.Pdc) annotation(
    Line(points = {{-44, 12}, {-24, 12}, {-24, -22}, {-12, -22}, {-12, -22}}, color = {0, 0, 127}));
protected
  annotation(
    uses(Modelica(version = "3.2.3")));
end gasgrd;
