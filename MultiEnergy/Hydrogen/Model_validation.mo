within Hydrogen;

model Model_validation
  Hydrogen.EM_test eM_test(Tstd = 323.15)  annotation(
    Placement(visible = true, transformation(origin = {-6, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 300, height = 0.16, offset = 0.001, startTime = 5)  annotation(
    Placement(visible = true, transformation(origin = {-66, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ramp.y, eM_test.nH) annotation(
    Line(points = {{-55, 38}, {-28, 38}, {-28, 44}, {-14, 44}}, color = {0, 0, 127}));
protected
end Model_validation;
