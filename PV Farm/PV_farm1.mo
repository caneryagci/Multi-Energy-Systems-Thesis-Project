model PV_farm1
  OpenIPSL.Electrical.Buses.Bus bus1(displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {22, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {64, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine1(B = 0.001 / 2, G = 0, R = 0.01, X = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {44, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine2(B = 0.001 / 2, G = 0, R = 0.01, X = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {44, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Events.PwFault pwFault1(R = 25, X = 1, t1 = 2, t2 = 2.3)  annotation(
    Placement(visible = true, transformation(origin = {90, -18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  inner OpenIPSL.Electrical.SystemBase SysData(S_b = 100, fn = 50)  annotation(
    Placement(visible = true, transformation(origin = {-32, 84}, extent = {{-12, -10}, {12, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Machines.PSAT.Order3 order31(D = 0, M = 10,P_0 = 0.0401256732154526, Q_0 = 0.0262725307404601, Sn = 20, T1d0 = 8, Vn = 400, ra = 0.001, x1d = 0.302, xd = 1.9, xq = 1.7)  annotation(
    Placement(visible = true, transformation(origin = {26, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {62, 68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Branches.PwLine pwLine3(B = 0.001 / 2, G = 0, R = 0.01, X = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {62, 46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Loads.PSAT.LOADPQ loadpq1(P_0 = 0.15, Q_0 = 0.1, forcePQ = true)  annotation(
    Placement(visible = true, transformation(origin = {108, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(kT = 33 / 0.4)  annotation(
    Placement(visible = true, transformation(origin = {-2, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  weibull_random_wind_speed_generator weibull_random_wind_speed_generator1 annotation(
    Placement(visible = true, transformation(origin = {-122, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable scale(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/scale(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-166, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable shape(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/shape_k(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-168, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(shape.y[1], weibull_random_wind_speed_generator1.shape) annotation(
    Line(points = {{-156, -4}, {-146, -4}, {-146, 4}, {-134, 4}, {-134, 4}}, color = {0, 0, 127}));
  connect(scale.y[1], weibull_random_wind_speed_generator1.scale) annotation(
    Line(points = {{-154, 32}, {-146, 32}, {-146, 14}, {-134, 14}, {-134, 14}}, color = {0, 0, 127}));
  connect(bus1.p, pwLine1.p) annotation(
    Line(points = {{22, 2}, {31, 2}, {31, 4}, {30, 4}, {30, 12}, {35, 12}}, color = {0, 0, 255}));
  connect(pwLine2.p, bus1.p) annotation(
    Line(points = {{35, -8}, {36, -8}, {36, -6}, {29, -6}, {29, 4}, {25, 4}, {25, 0}, {22, 0}, {22, 2}}, color = {0, 0, 255}));
  connect(twoWindingTransformer1.p, bus1.p) annotation(
    Line(points = {{9, -2}, {18, -2}, {18, 0}, {17, 0}, {17, 4}, {22, 4}, {22, 2}}, color = {0, 0, 255}));
  connect(loadpq1.p, bus2.p) annotation(
    Line(points = {{108, 10}, {112, 10}, {112, 12}, {108, 12}, {108, 18}, {78, 18}, {78, 4}, {64, 4}, {64, 2}, {64, 2}, {64, 2}}, color = {0, 0, 255}));
  connect(bus3.p, pwLine3.p) annotation(
    Line(points = {{62, 68}, {62, 68}, {62, 56}, {62, 56}}, color = {0, 0, 255}));
  connect(pwLine3.n, bus2.p) annotation(
    Line(points = {{62, 37}, {71, 37}, {71, 39}, {64, 39}, {64, 5}, {66, 5}, {66, 3}, {64, 3}}, color = {0, 0, 255}));
  connect(order31.p, bus3.p) annotation(
    Line(points = {{36, 80}, {62, 80}, {62, 68}, {62, 68}}, color = {0, 0, 255}));
  connect(order31.vf0, order31.vf) annotation(
    Line(points = {{18, 91}, {18, 91}, {18, 93}, {18, 93}, {18, 95}, {8, 95}, {8, 87}, {14, 87}, {14, 85}}, color = {0, 0, 127}));
  connect(order31.pm0, order31.pm) annotation(
    Line(points = {{18, 69}, {18, 69}, {18, 69}, {18, 69}, {18, 65}, {8, 65}, {8, 77}, {14, 77}, {14, 75}}, color = {0, 0, 127}));
  connect(pwFault1.p, bus2.p) annotation(
    Line(points = {{83, -18}, {76, -18}, {76, 2}, {64, 2}}, color = {0, 0, 255}));
  connect(pwLine2.n, bus2.p) annotation(
    Line(points = {{53, -8}, {59, -8}, {59, -6}, {57, -6}, {57, -2}, {59, -2}, {59, 6}, {61, 6}, {61, 4}, {66, 4}, {66, 2}, {63, 2}}, color = {0, 0, 255}));
  connect(pwLine1.n, bus2.p) annotation(
    Line(points = {{53, 12}, {59, 12}, {59, 4}, {61.5, 4}, {61.5, 2}, {64, 2}}, color = {0, 0, 255}));
  annotation(
    uses(OpenIPSL(version = "1.5.0"), Modelica(version = "3.2.3"), AixLib(version = "0.7.3")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "",
    __OpenModelica_commandLineOptions = "");end PV_farm1;
