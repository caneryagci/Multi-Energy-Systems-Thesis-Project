within Wind;

model Windfarm8
  iPSL.Electrical.Buses.InfiniteBus infiniteBus annotation(
    Placement(visible = true, transformation(origin = {-46, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable windspeed(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Co_simulation/Base Case/windspeed.txt", smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {26, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner iPSL.Electrical.SystemBase SysData annotation(
    Placement(visible = true, transformation(origin = {84, 90}, extent = {{-10, -10}, {14, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PwLine pwLine(B = 0.001, G = 0,R = 0.01, X = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {4, -20}, extent = {{-6, -4}, {6, 4}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus annotation(
    Placement(visible = true, transformation(origin = {-18, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {26, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Wind.GE.Type_3.GE_WT ge_wt(Kpp = 300, _P0 = 1.0)  annotation(
    Placement(visible = true, transformation(origin = {56, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(bus1.p, pwLine.n) annotation(
    Line(points = {{26, -20}, {12, -20}, {12, -20}, {12, -20}}, color = {0, 0, 255}));
  connect(pwLine.p, bus.p) annotation(
    Line(points = {{-4, -20}, {-18, -20}, {-18, -20}, {-18, -20}}, color = {0, 0, 255}));
  connect(bus.p, infiniteBus.p) annotation(
    Line(points = {{-18, -20}, {-34, -20}, {-34, -20}, {-34, -20}}, color = {0, 0, 255}));
  connect(windspeed.y[1], ge_wt.Wind_Speed) annotation(
    Line(points = {{38, 32}, {56, 32}, {56, -12}, {56, -12}}, color = {0, 0, 127}));
  connect(ge_wt.pwPin1, bus1.p) annotation(
    Line(points = {{44, -20}, {24, -20}, {24, -20}, {26, -20}, {26, -20}}, color = {0, 0, 255}));
end Windfarm8;
