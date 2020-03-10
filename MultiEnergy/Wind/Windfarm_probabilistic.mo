within Wind;

model Windfarm_probabilistic
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/scale(hourly).txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-186, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/shape_k(hourly).txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-186, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  weibull_random_wind_speed_generator weibull_random_wind_speed_generator1 annotation(
    Placement(visible = true, transformation(origin = {-138, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenIPSL.Electrical.SystemBase SysData annotation(
    Placement(visible = true, transformation(origin = {-144, 26}, extent = {{-12, -10}, {12, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-82, -56}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(V_b = 0.4, Vn = 40, kT = 33 / 0.4) annotation(
    Placement(visible = true, transformation(origin = {-82, -78}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Buses.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {-82, -106}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Buses.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {-82, -160}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Branches.PwLine pwLine1(B = 0.001 / 2, G = 0, R = 0.01, X = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-82, -132}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Loads.PSAT.LOADPQ loadpq1(P_0 = 0.6, Q_0 = 0.1, forcePQ = true) annotation(
    Placement(visible = true, transformation(origin = {-82, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Machines.PSAT.Order3 order31(D = 0, M = 10, Sn = 100, T1d0 = 8, Vn = 400, ra = 0.001, x1d = 0.302, xd = 1.9, xq = 1.7) annotation(
    Placement(visible = true, transformation(origin = {6, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus4 annotation(
    Placement(visible = true, transformation(origin = {38, -60}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer2(kT = 33 / 0.4) annotation(
    Placement(visible = true, transformation(origin = {40, -80}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Wind.PSAT.PSAT_Type_3.PSAT_WT psat_wt1 annotation(
    Placement(visible = true, transformation(origin = {-98, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(combiTimeTable2.y[1], weibull_random_wind_speed_generator1.shape) annotation(
    Line(points = {{-175, -44}, {-155, -44}, {-155, -32}, {-150, -32}}, color = {0, 0, 127}));
  connect(combiTimeTable1.y[1], weibull_random_wind_speed_generator1.scale) annotation(
    Line(points = {{-175, -16}, {-157, -16}, {-157, -23}, {-150, -23}}, color = {0, 0, 127}));
  connect(twoWindingTransformer2.n, bus2.p) annotation(
    Line(points = {{40, -92}, {-82, -92}, {-82, -106}, {-82, -106}}, color = {0, 0, 255}));
  connect(bus4.p, twoWindingTransformer2.p) annotation(
    Line(points = {{38, -60}, {40, -60}, {40, -68}, {40, -68}}, color = {0, 0, 255}));
  connect(order31.p, bus4.p) annotation(
    Line(points = {{16, -40}, {36, -40}, {36, -60}, {38, -60}, {38, -60}}, color = {0, 0, 255}));
  connect(order31.vf0, order31.vf) annotation(
    Line(points = {{-2, -29}, {-4, -29}, {-4, -27}, {-16, -27}, {-16, -37}, {-6, -37}, {-6, -35}}, color = {0, 0, 127}));
  connect(order31.pm0, order31.pm) annotation(
    Line(points = {{-2, -51}, {-8, -51}, {-8, -51}, {-14, -51}, {-14, -43}, {-6, -43}, {-6, -45}}, color = {0, 0, 127}));
  connect(loadpq1.p, bus3.p) annotation(
    Line(points = {{-82, -170}, {-82, -160}}, color = {0, 0, 255}));
  connect(pwLine1.n, bus3.p) annotation(
    Line(points = {{-82, -142}, {-82, -142}, {-82, -160}, {-82, -160}}, color = {0, 0, 255}));
  connect(pwLine1.p, bus2.p) annotation(
    Line(points = {{-82, -122}, {-82, -122}, {-82, -106}, {-82, -106}}, color = {0, 0, 255}));
  connect(twoWindingTransformer1.n, bus2.p) annotation(
    Line(points = {{-82, -90}, {-82, -90}, {-82, -106}, {-82, -106}}, color = {0, 0, 255}));
  connect(twoWindingTransformer1.p, bus1.p) annotation(
    Line(points = {{-82, -66}, {-82, -66}, {-82, -56}, {-82, -56}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.3"), OpenIPSL(version = "1.5.0")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "",
    __OpenModelica_commandLineOptions = "");
end Windfarm_probabilistic;
