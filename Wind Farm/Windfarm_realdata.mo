model Windfarm_realdata
  DelMod.Generators.windPlant windPlant1(P_0 = -50, Q_0 = 5.9758,Sn = 100, V_0 = 1, V_b = 33, alphap = 1, alphaq = 1, angle_0 = 4.7187)  annotation(
    Placement(visible = true, transformation(origin = {-34, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus1(V_b = 33, displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {-40, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  inner OpenIPSL.Electrical.SystemBase SysData(S_b = 100, fn = 50)  annotation(
    Placement(visible = true, transformation(origin = {-82, 72}, extent = {{-12, -10}, {12, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(Sb = 100, Sn = 100, V_b = 0.4, Vn = 0.4, fn = 50, kT = 33 / 0.4, r = 0.0016, x = 0.0827)  annotation(
    Placement(visible = true, transformation(origin = {-38, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  OpenIPSL.Electrical.Buses.InfiniteBus infiniteBus1(P_0 = 0.001, Q_0 = 0.00001, V_0 = 1, V_b = 0.4, angle_0 = 0, displayPF = false)  annotation(
    Placement(visible = true, transformation(origin = {-54, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/wind_speeds.txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-80, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Mean mean1 annotation(
    Placement(visible = true, transformation(origin = {54, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(combiTimeTable1.y[1], windPlant1.windSpeed) annotation(
    Line(points = {{-69, -18}, {-44, -18}}, color = {0, 0, 127}));
  connect(windPlant1.p, bus1.p) annotation(
    Line(points = {{-34, -8}, {-34, 3}, {-40, 3}, {-40, 12}}, color = {0, 0, 255}));
  connect(twoWindingTransformer1.p, bus1.p) annotation(
    Line(points = {{-38, 22}, {-38, 17}, {-40, 17}, {-40, 12}}, color = {0, 0, 255}));
  connect(infiniteBus1.p, twoWindingTransformer1.n) annotation(
    Line(points = {{-44, 56}, {-38, 56}, {-38, 44}, {-38, 44}, {-38, 46}, {-38, 46}}, color = {0, 0, 255}));
  annotation(
    uses(OpenIPSL(version = "1.5.0"), Modelica(version = "3.2.3")));end Windfarm_realdata;
