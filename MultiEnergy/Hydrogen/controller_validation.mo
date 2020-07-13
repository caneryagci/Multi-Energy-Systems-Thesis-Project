within Hydrogen;

model controller_validation
  Modelica.Blocks.Sources.Step step(height = 0.2, offset = 0.1, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = {-70, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 100, height = -1, offset = 5, startTime = 50)  annotation(
    Placement(visible = true, transformation(origin = {-78, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 10, height = 0.1, offset = 0.1, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = {-68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Controller_DSM controller_DSM annotation(
    Placement(visible = true, transformation(origin = {2, 22}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
equation
connect(step.y, controller_DSM.demand) annotation(
    Line(points = {{-58, 48}, {-42, 48}, {-42, 24}, {-22, 24}, {-22, 26}}, color = {0, 0, 127}));
  connect(ramp1.y, controller_DSM.generation) annotation(
    Line(points = {{-56, 0}, {-44, 0}, {-44, 10}, {-26, 10}, {-26, 8}, {-22, 8}}, color = {0, 0, 127}));
  connect(ramp.y, controller_DSM.S_storage) annotation(
    Line(points = {{-66, -62}, {-34, -62}, {-34, -12}, {-6, -12}, {-6, -4}, {-4, -4}}, color = {0, 0, 127}));
end controller_validation;
