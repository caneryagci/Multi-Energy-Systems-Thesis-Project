within P2H;

model P2H_basecase
  Hydrogen.staticgen staticgen(Td = 5, Tq = 5)  annotation(
    Placement(visible = true, transformation(origin = {50, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  P2H.storage storage annotation(
    Placement(visible = true, transformation(origin = {-8, 62}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  P2H.HP1 hp1 annotation(
    Placement(visible = true, transformation(origin = {-17, 7}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Vangle(y = -0.0000253046024029618) annotation(
    Placement(visible = true, transformation(origin = {2, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {22, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(Sn = 100, V_b = 12500, Vn = 12500, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {2, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus annotation(
    Placement(visible = true, transformation(origin = {-26, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus2(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-54, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1.02)  annotation(
    Placement(visible = true, transformation(origin = {-88, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Heat Pump/Text/heat_demand.txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-66, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  P2H.controller_p2h controller_p2h annotation(
    Placement(visible = true, transformation(origin = {59, 81}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Heat Pump/Text/Tambient.txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-74, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  LCODH lcodh annotation(
    Placement(visible = true, transformation(origin = {6, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = hp1.COP)  annotation(
    Placement(visible = true, transformation(origin = {-48, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(hp1.Pelec, staticgen.P_0) annotation(
    Line(points = {{9, 14}, {22, 14}, {22, -42}, {32, -42}, {32, -41}, {42, -41}}, color = {0, 0, 127}));
  connect(Vangle.y, staticgen.angle_0) annotation(
    Line(points = {{13, -32}, {27.5, -32}, {27.5, -34}, {42, -34}}, color = {0, 0, 127}));
  connect(twoWindingTransformer1.p, bus.p) annotation(
    Line(points = {{-9, -62}, {-26, -62}}, color = {0, 0, 255}));
  connect(bus1.p, twoWindingTransformer1.n) annotation(
    Line(points = {{22, -62}, {13, -62}}, color = {0, 0, 255}));
  connect(infiniteBus2.p, bus.p) annotation(
    Line(points = {{-43, -62}, {-26, -62}}, color = {0, 0, 255}));
  connect(staticgen.p, bus1.p) annotation(
    Line(points = {{61, -34}, {71, -34}, {71, -62}, {22, -62}}, color = {0, 0, 255}));
  connect(const.y, infiniteBus2.V) annotation(
    Line(points = {{-77, -62}, {-65, -62}}, color = {0, 0, 127}));
  connect(const.y, staticgen.V_0) annotation(
    Line(points = {{-77, -62}, {-70, -62}, {-70, -26}, {42, -26}, {42, -26.5}}, color = {0, 0, 127}));
  connect(hp1.Q, storage.Q_generation) annotation(
    Line(points = {{9, 27}, {22, 27}, {22, 36}, {-44, 36}, {-44, 56}, {-24, 56}, {-24, 55}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[1], storage.Q_demand) annotation(
    Line(points = {{-55, 74}, {-46.5, 74}, {-46.5, 72}, {-24, 72}, {-24, 71}}, color = {0, 0, 127}));
  connect(storage.S, controller_p2h.S_storage) annotation(
    Line(points = {{11, 73}, {14.5, 73}, {14.5, 75}, {18, 75}, {18, 96}, {42, 96}, {42, 95}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[1], controller_p2h.demand) annotation(
    Line(points = {{-55, 74}, {-46, 74}, {-46, 87}, {42, 87}}, color = {0, 0, 127}));
  connect(hp1.Q, controller_p2h.generation) annotation(
    Line(points = {{9, 27}, {17, 27}, {17, 26}, {24, 26}, {24, 79}, {42, 79}}, color = {0, 0, 127}));
  connect(hp1.Pelec, controller_p2h.P) annotation(
    Line(points = {{9, 14}, {28, 14}, {28, 68}, {42, 68}}, color = {0, 0, 127}));
  connect(controller_p2h.Pmin, hp1.Pord) annotation(
    Line(points = {{78, 83}, {88, 83}, {88, -20}, {-58, -20}, {-58, -6}, {-35, -6}, {-35, -7}}, color = {0, 0, 127}));
  connect(combiTimeTable1.y[1], hp1.Tamb) annotation(
    Line(points = {{-63, 24}, {-46, 24}, {-46, 20}, {-35, 20}, {-35, 21}}, color = {0, 0, 127}));
  connect(realExpression.y, lcodh.COP) annotation(
    Line(points = {{-36, -104}, {-14, -104}, {-14, -106}, {-2, -106}, {-2, -106}}, color = {0, 0, 127}));
protected
end P2H_basecase;
