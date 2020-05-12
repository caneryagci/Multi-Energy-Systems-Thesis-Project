within Wind;

model Windfarm4

  iPSL.Electrical.Wind.GE.Type_3.GE_WT ge_wt1 annotation(
    Placement(visible = true, transformation(origin = {84, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable windspeed(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Co_simulation/Case 1/windspeed.txt", smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {26, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.SystemBase sysData annotation(
    Placement(visible = true, transformation(origin = {74, 86}, extent = {{-10, -10}, {14, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer(Sn = 500, V_b = 12500, Vn = 12500, kT = 12500 / 575)  annotation(
    Placement(visible = true, transformation(origin = {26, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus21(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-36, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PVbus annotation(
    Placement(visible = true, transformation(origin = {54, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PQbus annotation(
    Placement(visible = true, transformation(origin = {-2, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant PCC_voltage(k = 1.01)  annotation(
    Placement(visible = true, transformation(origin = {-66, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(ge_wt1.pwPin1, PVbus.p) annotation(
    Line(points = {{73, -24}, {54, -24}}, color = {0, 0, 255}));
  connect(PVbus.p, twoWindingTransformer.n) annotation(
    Line(points = {{54, -24}, {37, -24}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.p, PQbus.p) annotation(
    Line(points = {{15, -24}, {-2, -24}}, color = {0, 0, 255}));
  connect(PQbus.p, infiniteBus21.p) annotation(
    Line(points = {{-2, -24}, {-25, -24}}, color = {0, 0, 255}));
  connect(PCC_voltage.y, infiniteBus21.V) annotation(
    Line(points = {{-55, -24}, {-47, -24}}, color = {0, 0, 127}));
  connect(windspeed.y[1], ge_wt1.Wind_Speed) annotation(
    Line(points = {{37, 32}, {84, 32}, {84, -16}}, color = {0, 0, 127}));
  annotation(
    uses(iPSL(version = "1.1.0"), Modelica(version = "3.2.3")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));

end Windfarm4;
