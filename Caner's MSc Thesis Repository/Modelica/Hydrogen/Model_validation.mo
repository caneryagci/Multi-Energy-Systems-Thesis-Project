within Hydrogen;

model Model_validation
  Hydrogen.thermal thermal annotation(
    Placement(visible = true, transformation(origin = {-28, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.massflow massflow annotation(
    Placement(visible = true, transformation(origin = {58, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.pressure pressure annotation(
    Placement(visible = true, transformation(origin = {54, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  electrochemical electrochemical1 annotation(
    Placement(visible = true, transformation(origin = {-14, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 0.5, offset = 0.5, startTime = 100)  annotation(
    Placement(visible = true, transformation(origin = {-88, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(thermal.Top, pressure.Top) annotation(
    Line(points = {{-16, -38}, {26, -38}, {26, 12}, {31, 12}, {31, 14}, {46, 14}}, color = {0, 0, 127}));
  connect(massflow.nH, thermal.nH) annotation(
    Line(points = {{70, -30}, {82, -30}, {82, -62}, {-48, -62}, {-48, -44}, {-36, -44}, {-36, -44}}, color = {0, 0, 127}));
  connect(massflow.nO, thermal.nO) annotation(
    Line(points = {{70, -38}, {80, -38}, {80, -58}, {-42, -58}, {-42, -50}, {-36, -50}, {-36, -50}}, color = {0, 0, 127}));
  connect(thermal.Top, electrochemical1.Top) annotation(
    Line(points = {{-16, -38}, {-6, -38}, {-6, 0}, {-30, 0}, {-30, 14}, {-24, 14}, {-24, 14}}, color = {0, 0, 127}));
  connect(pressure.ppHtO_atm, electrochemical1.ppHtO) annotation(
    Line(points = {{66, 18}, {72, 18}, {72, 40}, {-20, 40}, {-20, 26}, {-18, 26}}, color = {0, 0, 127}));
  connect(pressure.ppH_atm, electrochemical1.ppH) annotation(
    Line(points = {{66, 14}, {84, 14}, {84, 32}, {-14, 32}, {-14, 26}, {-14, 26}}, color = {0, 0, 127}));
  connect(pressure.ppO_atm, electrochemical1.ppO) annotation(
    Line(points = {{66, 8}, {90, 8}, {90, 30}, {-12, 30}, {-12, 26}, {-12, 26}}, color = {0, 0, 127}));
  connect(electrochemical1.Icell, massflow.Icell) annotation(
    Line(points = {{-4, 10}, {10, 10}, {10, -26}, {50, -26}, {50, -26}}, color = {0, 0, 127}));
  connect(electrochemical1.Wpem, thermal.Wpem) annotation(
    Line(points = {{-4, 12}, {20, 12}, {20, -18}, {-50, -18}, {-50, -38}, {-36, -38}, {-36, -38}}, color = {0, 0, 127}));
  connect(step.y, electrochemical1.Pord) annotation(
    Line(points = {{-76, -8}, {-52, -8}, {-52, 18}, {-24, 18}, {-24, 18}}, color = {0, 0, 127}));
protected
end Model_validation;
