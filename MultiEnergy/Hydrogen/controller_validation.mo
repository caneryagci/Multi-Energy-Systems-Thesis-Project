within Hydrogen;

model controller_validation
  Hydrogen.Controller_DSM controller_DSM annotation(
    Placement(visible = true, transformation(origin = {10, 14}, extent = {{-34, -34}, {34, 34}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 0.2, offset = 0.1, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = {-78, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1 annotation(
    Placement(visible = true, transformation(origin = {-76, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step2(height = 1, offset = 0.5, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = {4, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 100, height = 90, offset = 50, startTime = 50)  annotation(
    Placement(visible = true, transformation(origin = {-78, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(step2.y, controller_DSM.P) annotation(
    Line(points = {{16, -68}, {30, -68}, {30, -20}, {30, -20}}, color = {0, 0, 127}));
  connect(ramp.y, controller_DSM.S_storage) annotation(
    Line(points = {{-66, -62}, {-32, -62}, {-32, -38}, {2, -38}, {2, -22}, {0, -22}}, color = {0, 0, 127}));
  connect(step1.y, controller_DSM.generation) annotation(
    Line(points = {{-64, -6}, {-42, -6}, {-42, -4}, {-24, -4}, {-24, -4}}, color = {0, 0, 127}));
  connect(step.y, controller_DSM.demand) annotation(
    Line(points = {{-66, 48}, {-48, 48}, {-48, 22}, {-24, 22}, {-24, 22}}, color = {0, 0, 127}));
end controller_validation;
