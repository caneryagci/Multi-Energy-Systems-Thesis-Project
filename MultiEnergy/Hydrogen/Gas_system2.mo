within Hydrogen;

model Gas_system2
  package Medium = Buildings.Media.Air(extraPropertiesNames = {"Hydrogen"});
  //replaceable package Medium = Modelica.Media.IdealGases.SingleGases(extraPropertiesNames={"H2"});
  Modelica.Blocks.Sources.RealExpression iacSense(y = AC.i) annotation(
    Placement(visible = true, transformation(extent = {{12, -40}, {32, -20}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Inductor L(L = 1e-3) annotation(
    Placement(visible = true, transformation(extent = {{34, 80}, {54, 100}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression vacSense(y = AC.v) annotation(
    Placement(visible = true, transformation(extent = {{12, -100}, {32, -80}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage AC(V = 480, freqHz = 50) annotation(
    Placement(visible = true, transformation(origin = {80, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Sources.RealExpression vdcSense(y = electrolyser1.Vcell) annotation(
    Placement(visible = true, transformation(extent = {{12, -130}, {32, -110}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant idSetpoint(k = 1500) annotation(
    Placement(visible = true, transformation(extent = {{10, -14}, {30, 6}}, rotation = 0)));
  PVSystems.Control.PLL pll annotation(
    Placement(visible = true, transformation(origin = {62, -90}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  PVSystems.Electrical.Assemblies.HBridge HB(d(start = 0.5)) annotation(
    Placement(visible = true, transformation(extent = {{2, 60}, {22, 80}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant iqSetpoint(k = 0) annotation(
    Placement(visible = true, transformation(extent = {{12, -70}, {32, -50}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{-38, 42}, {-18, 62}}, rotation = 0)));
  PVSystems.Control.Assemblies.Inverter1phCurrentController control(T = 0.001, d(start = 0.5), k = 0.3) annotation(
    Placement(visible = true, transformation(origin = {92, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Electrolyser electrolyser1 annotation(
    Placement(visible = true, transformation(origin = {-34, 82}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  storage2 storage21 annotation(
    Placement(visible = true, transformation(origin = {-114, 82}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 50, height = 12, offset = 0, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = {-102, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(HB.p2, L.p) annotation(
    Line(points = {{22, 75}, {28, 75}, {28, 90}, {34, 90}}, color = {0, 0, 255}));
  connect(idSetpoint.y, control.ids) annotation(
    Line(points = {{31, -4}, {62, -4}, {62, -24}, {80, -24}}, color = {0, 0, 127}));
  connect(AC.n, HB.n2) annotation(
    Line(points = {{80, 60}, {80, 50}, {28, 50}, {28, 65}, {22, 65}}, color = {0, 0, 255}));
  connect(iqSetpoint.y, control.iqs) annotation(
    Line(points = {{33, -60}, {62, -60}, {62, -36}, {80, -36}}, color = {0, 0, 127}));
  connect(control.d, HB.d) annotation(
    Line(points = {{103, -30}, {114, -30}, {114, 32}, {12, 32}, {12, 58}}, color = {0, 0, 127}));
  connect(vdcSense.y, control.vdc) annotation(
    Line(points = {{33, -120}, {96, -120}, {96, -42}}, color = {0, 0, 127}));
  connect(iacSense.y, control.i) annotation(
    Line(points = {{33, -30}, {80, -30}}, color = {0, 0, 127}));
  connect(pll.theta, control.theta) annotation(
    Line(points = {{73, -90}, {88, -90}, {88, -42}}, color = {0, 0, 127}));
  connect(vacSense.y, pll.v) annotation(
    Line(points = {{33, -90}, {50, -90}}, color = {0, 0, 127}));
  connect(HB.n1, ground.p) annotation(
    Line(points = {{2, 66}, {-10, 66}, {-10, 62}, {-28, 62}}, color = {0, 0, 255}));
  connect(electrolyser1.p, HB.p1) annotation(
    Line(points = {{-34, 92}, {-34, 96}, {-6, 96}, {-6, 74}, {2, 74}, {2, 76}}, color = {0, 0, 255}));
  connect(electrolyser1.n, ground.p) annotation(
    Line(points = {{-37, 72}, {-37, 67}, {-28, 67}, {-28, 62}}, color = {0, 0, 255}));
  connect(L.n, AC.p) annotation(
    Line(points = {{54, 90}, {78, 90}, {78, 80}, {80, 80}, {80, 80}}, color = {0, 0, 255}));
  connect(electrolyser1.nH, storage21.nH2_i) annotation(
    Line(points = {{-46, 82}, {-92, 82}, {-92, 87}, {-106, 87}}, color = {0, 0, 127}));
  connect(ramp1.y, storage21.nH2_o) annotation(
    Line(points = {{-90, 40}, {-84, 40}, {-84, 78}, {-106, 78}, {-106, 78}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3"), PVSystems(version = "0.6.3")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
end Gas_system2;
