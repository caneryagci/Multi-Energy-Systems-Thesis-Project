model Gas_grid2
  Modelica.Blocks.Sources.RealExpression iacSense(y = AC.i) annotation(
    Placement(visible = true, transformation(extent = {{-90, 0}, {-70, 20}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor L(L = 1e-3) annotation(
    Placement(visible = true, transformation(extent = {{34, 80}, {54, 100}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression vacSense(y = AC.v) annotation(
    Placement(visible = true, transformation(extent = {{-90, -60}, {-70, -40}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage AC(V = 480, freqHz = 50) annotation(
    Placement(visible = true, transformation(origin = {80, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Sources.RealExpression vdcSense(y = electrolyser1.Vcell) annotation(
    Placement(visible = true, transformation(extent = {{-90, -90}, {-70, -70}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant idSetpoint(k = 400) annotation(
    Placement(visible = true, transformation(extent = {{-90, 30}, {-70, 50}}, rotation = 0)));
  PVSystems.Control.PLL pll annotation(
    Placement(visible = true, transformation(origin = {-40, -50}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  PVSystems.Electrical.Assemblies.HBridge HB(d(start = 0.5)) annotation(
    Placement(visible = true, transformation(extent = {{2, 60}, {22, 80}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant iqSetpoint(k = 0) annotation(
    Placement(visible = true, transformation(extent = {{-90, -30}, {-70, -10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{-36, 34}, {-16, 54}}, rotation = 0)));
  PVSystems.Control.Assemblies.Inverter1phCurrentController control(d(start = 0.5)) annotation(
    Placement(visible = true, transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R(R = 1e-2) annotation(
    Placement(visible = true, transformation(extent = {{60, 80}, {80, 100}}, rotation = 0)));
  electrolyser electrolyser1 annotation(
    Placement(visible = true, transformation(origin = {-28, 74}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(HB.p2, L.p) annotation(
    Line(points = {{22, 75}, {28, 75}, {28, 90}, {34, 90}}, color = {0, 0, 255}));
  connect(idSetpoint.y, control.ids) annotation(
    Line(points = {{-69, 40}, {-40, 40}, {-40, 16}, {-22, 16}}, color = {0, 0, 127}));
  connect(AC.n, HB.n2) annotation(
    Line(points = {{80, 60}, {80, 50}, {28, 50}, {28, 65}, {22, 65}}, color = {0, 0, 255}));
  connect(iqSetpoint.y, control.iqs) annotation(
    Line(points = {{-69, -20}, {-40, -20}, {-40, 4}, {-22, 4}}, color = {0, 0, 127}));
  connect(control.d, HB.d) annotation(
    Line(points = {{1, 10}, {12, 10}, {12, 58}}, color = {0, 0, 127}));
  connect(vdcSense.y, control.vdc) annotation(
    Line(points = {{-69, -80}, {-6, -80}, {-6, -2}}, color = {0, 0, 127}));
  connect(iacSense.y, control.i) annotation(
    Line(points = {{-69, 10}, {-22, 10}}, color = {0, 0, 127}));
  connect(pll.theta, control.theta) annotation(
    Line(points = {{-29, -50}, {-29, -50}, {-14, -50}, {-14, -2}}, color = {0, 0, 127}));
  connect(L.n, R.p) annotation(
    Line(points = {{54, 90}, {60, 90}}, color = {0, 0, 255}));
  connect(vacSense.y, pll.v) annotation(
    Line(points = {{-69, -50}, {-52, -50}, {-52, -50}}, color = {0, 0, 127}));
  connect(R.n, AC.p) annotation(
    Line(points = {{80, 90}, {80, 80}}, color = {0, 0, 255}));
  connect(electrolyser1.p, HB.p1) annotation(
    Line(points = {{-28, 84}, {-28, 84}, {-28, 92}, {-8, 92}, {-8, 76}, {2, 76}, {2, 76}}, color = {0, 0, 255}));
  connect(electrolyser1.n, ground.p) annotation(
    Line(points = {{-28, 64}, {-26, 64}, {-26, 54}, {-26, 54}}, color = {0, 0, 255}));
  connect(HB.n1, ground.p) annotation(
    Line(points = {{2, 66}, {-10, 66}, {-10, 54}, {-26, 54}, {-26, 54}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.3"), PVSystems(version = "0.6.3")));
end Gas_grid2;
