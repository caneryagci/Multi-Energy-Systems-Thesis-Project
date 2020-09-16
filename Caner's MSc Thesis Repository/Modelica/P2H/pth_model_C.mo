within P2H;

model pth_model_C
  Hydrogen.staticgen staticgen(Td = 5, Tq = 5)  annotation(
    Placement(visible = true, transformation(origin = {54, -38}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  P2H.storage storage annotation(
    Placement(visible = true, transformation(origin = {-8, 62}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Vangle(y = -0.0000253046024029618) annotation(
    Placement(visible = true, transformation(origin = {2, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {22, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(Sn = 100, V_b = 12500, Vn = 12500, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {2, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus annotation(
    Placement(visible = true, transformation(origin = {-26, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus2(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-48, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  P2H.LCODH lcodh annotation(
    Placement(visible = true, transformation(origin = {40, -112}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = hP_with_boiler.COP)  annotation(
    Placement(visible = true, transformation(origin = {-12, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable T_ambient(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Co_simulation/Tambient_hourly.txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-76, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable Demand_profile(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Co_simulation/heat_demand.txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-72, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Vbus(k = 1.02)  annotation(
    Placement(visible = true, transformation(origin = {-80, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  P2H.HP_with_boiler hP_with_boiler annotation(
    Placement(visible = true, transformation(origin = {-34, 2}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  P2H.controller_APL controller_APL annotation(
    Placement(visible = true, transformation(origin = {46.415, 70.5831}, extent = {{-20.5935, -25.7419}, {34.3225, 17.1612}}, rotation = 0)));
equation
  connect(Vangle.y, staticgen.angle_0) annotation(
    Line(points = {{13, -38}, {43, -38}}, color = {0, 0, 127}));
  connect(twoWindingTransformer1.p, bus.p) annotation(
    Line(points = {{-9, -62}, {-26, -62}}, color = {0, 0, 255}));
  connect(bus1.p, twoWindingTransformer1.n) annotation(
    Line(points = {{22, -62}, {13, -62}}, color = {0, 0, 255}));
  connect(infiniteBus2.p, bus.p) annotation(
    Line(points = {{-37, -62}, {-26, -62}}, color = {0, 0, 255}));
  connect(staticgen.p, bus1.p) annotation(
    Line(points = {{69, -38}, {71, -38}, {71, -62}, {22, -62}}, color = {0, 0, 255}));
  connect(Vbus.y, infiniteBus2.V) annotation(
    Line(points = {{-69, -62}, {-58, -62}}, color = {0, 0, 127}));
  connect(Demand_profile.y[1], storage.Q_demand) annotation(
    Line(points = {{-60, 78}, {-44, 78}, {-44, 72}, {-24, 72}, {-24, 72}}, color = {0, 0, 127}));
  connect(T_ambient.y[1], hP_with_boiler.Tamb) annotation(
    Line(points = {{-65, 14}, {-52, 14}, {-52, 16}}, color = {0, 0, 127}));
  connect(hP_with_boiler.Q, storage.Q_generation) annotation(
    Line(points = {{-8, 20}, {14, 20}, {14, 38}, {-50, 38}, {-50, 56}, {-24, 56}, {-24, 56}}, color = {0, 0, 127}));
  connect(hP_with_boiler.Pelec, staticgen.P_0) annotation(
    Line(points = {{-8, 8}, {30, 8}, {30, -48}, {42, -48}, {42, -48}}, color = {0, 0, 127}));
  connect(Vbus.y, staticgen.V_0) annotation(
    Line(points = {{-68, -62}, {-64, -62}, {-64, -28}, {42, -28}, {42, -28}}, color = {0, 0, 127}));
  connect(realExpression.y, lcodh.COP) annotation(
    Line(points = {{-1, -100}, {27, -100}, {27, -118}}, color = {0, 0, 127}));
  connect(storage.S, controller_APL.S_storage) annotation(
    Line(points = {{10, 74}, {18, 74}, {18, 84}, {32, 84}, {32, 82}}, color = {0, 0, 127}));
  connect(Demand_profile.y[1], controller_APL.demand) annotation(
    Line(points = {{-60, 78}, {-42, 78}, {-42, 92}, {22, 92}, {22, 72}, {32, 72}, {32, 72}}, color = {0, 0, 127}));
  connect(hP_with_boiler.Q, controller_APL.generation) annotation(
    Line(points = {{-8, 20}, {14, 20}, {14, 56}, {32, 56}, {32, 56}}, color = {0, 0, 127}));
  connect(hP_with_boiler.Pelec, controller_APL.P) annotation(
    Line(points = {{-8, 8}, {22, 8}, {22, 46}, {32, 46}, {32, 48}}, color = {0, 0, 127}));
  connect(controller_APL.Pmin, hP_with_boiler.Pord) annotation(
    Line(points = {{86, 80}, {94, 80}, {94, 96}, {-92, 96}, {-92, -12}, {-52, -12}, {-52, -12}}, color = {0, 0, 127}));
protected


end pth_model_C;
