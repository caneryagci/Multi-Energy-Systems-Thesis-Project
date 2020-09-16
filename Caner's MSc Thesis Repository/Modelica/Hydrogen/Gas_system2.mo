within Hydrogen;

model Gas_system2
  //package Medium = Buildings.Media.Air(extraPropertiesNames = {"Hydrogen"});
  //replaceable package Medium = Modelica.Media.IdealGases.SingleGases(extraPropertiesNames={"H2"});
  Modelica.Electrical.Analog.Basic.Inductor L(L = 1e-3) annotation(
    Placement(visible = true, transformation(extent = {{46, 92}, {66, 112}}, rotation = 0)));
  PVSystems.Electrical.Assemblies.HBridge HB(d(start = 0.5)) annotation(
    Placement(visible = true, transformation(origin = {13, 87}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{-38, 42}, {-18, 62}}, rotation = 0)));
  Hydrogen.Electrolyser electrolyser1(n_cells = 20000)  annotation(
    Placement(visible = true, transformation(origin = {-94, 92}, extent = {{-18, 18}, {18, -18}}, rotation = -90)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 60, height = 4, offset = 5, startTime = 10)  annotation(
    Placement(visible = true, transformation(origin = {-150, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor Cdc(C = 5e-1, v(start = 1)) annotation(
    Placement(visible = true, transformation(origin = {-28, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Sources.RealExpression iacSense(y = AC.i) annotation(
    Placement(visible = true, transformation(extent = {{-78, -42}, {-58, -22}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression idcSense(y = -electrolyser1.Icell) annotation(
    Placement(visible = true, transformation(extent = {{-78, -18}, {-58, 2}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression vdcSense(y = electrolyser1.Vcell * electrolyser1.n_cells) annotation(
    Placement(visible = true, transformation(extent = {{-78, 8}, {-58, 28}}, rotation = 0)));
  PVSystems.Control.Assemblies.Inverter1phCompleteController Controller(fline = 50, iT = 0.01, idMax = 20, ik = 0.1, iqMax = 20, vT = 0.5, vdcMax = 50, vk = 10) annotation(
    Placement(visible = true, transformation(origin = {-8, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression vacSense(y = AC.v) annotation(
    Placement(visible = true, transformation(extent = {{-78, -66}, {-58, -46}}, rotation = 0)));
  Modelica.Blocks.Math.Mean meanACPower(f = 50) annotation(
    Placement(visible = true, transformation(extent = {{70, -92}, {90, -72}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression DCPower(y = electrolyser1.Pdc_mw) annotation(
    Placement(visible = true, transformation(extent = {{40, -72}, {60, -52}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression ACPower(y = AC.v * AC.i) annotation(
    Placement(visible = true, transformation(extent = {{40, -92}, {60, -72}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage AC annotation(
    Placement(visible = true, transformation(origin = {90, 88}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Sine sine(amplitude = 20000, freqHz = 50)  annotation(
    Placement(visible = true, transformation(origin = {124, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(electrolyser1.n, ground.p) annotation(
    Line(points = {{-100, 74}, {-100, 71}, {-28, 71}, {-28, 62}}, color = {0, 0, 255}));
  connect(Cdc.n, ground.p) annotation(
    Line(points = {{-28, 76}, {-28, 62}}, color = {0, 0, 255}));
  connect(HB.p1, electrolyser1.p) annotation(
    Line(points = {{-2, 94}, {-8, 94}, {-8, 110}, {-94, 110}}, color = {0, 0, 255}));
  connect(Cdc.p, HB.p1) annotation(
    Line(points = {{-28, 96}, {-28, 96}, {-28, 104}, {-8, 104}, {-8, 94}, {-2, 94}, {-2, 94}}, color = {0, 0, 255}));
  connect(HB.n1, ground.p) annotation(
    Line(points = {{-2, 80}, {-8, 80}, {-8, 70}, {-28, 70}, {-28, 62}, {-28, 62}}, color = {0, 0, 255}));
  connect(L.p, HB.p2) annotation(
    Line(points = {{46, 102}, {34, 102}, {34, 94}, {28, 94}, {28, 94}}, color = {0, 0, 255}));
  connect(iacSense.y, Controller.iac) annotation(
    Line(points = {{-57, -32}, {-48, -32}, {-48, -16}, {-20, -16}}, color = {0, 0, 127}));
  connect(vdcSense.y, Controller.vdc) annotation(
    Line(points = {{-57, 18}, {-38, 18}, {-38, -4}, {-20, -4}}, color = {0, 0, 127}));
  connect(vacSense.y, Controller.vac) annotation(
    Line(points = {{-57, -56}, {-38, -56}, {-38, -20}, {-20, -20}}, color = {0, 0, 127}));
  connect(idcSense.y, Controller.idc) annotation(
    Line(points = {{-57, -8}, {-20, -8}}, color = {0, 0, 127}));
  connect(Controller.d, HB.d) annotation(
    Line(points = {{4, -12}, {14, -12}, {14, 70}, {14, 70}}, color = {0, 0, 127}));
  connect(ACPower.y, meanACPower.u) annotation(
    Line(points = {{61, -82}, {64.5, -82}, {68, -82}}, color = {0, 0, 127}));
  connect(AC.n, HB.n2) annotation(
    Line(points = {{90, 78}, {90, 78}, {90, 72}, {38, 72}, {38, 80}, {28, 80}, {28, 80}}, color = {0, 0, 255}));
  connect(AC.p, L.n) annotation(
    Line(points = {{90, 98}, {90, 98}, {90, 102}, {66, 102}, {66, 102}}, color = {0, 0, 255}));
  connect(sine.y, AC.v) annotation(
    Line(points = {{136, 110}, {158, 110}, {158, 86}, {104, 86}, {104, 88}, {102, 88}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3"), PVSystems(version = "0.6.3")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}}, initialScale = 0.1)),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
end Gas_system2;
