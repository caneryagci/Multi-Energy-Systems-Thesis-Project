within Hydrogen;

model P2G_basecase
  iPSL.Electrical.Buses.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {44, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus2(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-24, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(Sn = 100, V_b = 12500, Vn = 12500, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {24, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus annotation(
    Placement(visible = true, transformation(origin = {-4, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.staticgen staticgen( Td = 5, Tq = 5)  annotation(
    Placement(visible = true, transformation(origin = {63, -35}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Vangle(y = -0.0000253046024029618)  annotation(
    Placement(visible = true, transformation(origin = {-6, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Storage2 storage2(S_storage)  annotation(
    Placement(visible = true, transformation(origin = {-25, 51}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Hydrogen.electrolyser_detailed electrolyser_detailed1 annotation(
    Placement(visible = true, transformation(origin = {-68, -2}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Hydrogen.Controller_P2G3 controller_P2G3(Pgain = 20000)  annotation(
    Placement(visible = true, transformation(origin = {60, 24}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Electrolyser/Text/gas_demand_pu.txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {34, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1.02)  annotation(
    Placement(visible = true, transformation(origin = {-68, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.LCOH lcoh annotation(
    Placement(visible = true, transformation(origin = {0, -106}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = electrolyser_detailed1.electrochemical.efficiency2)  annotation(
    Placement(visible = true, transformation(origin = {-36, -106}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(twoWindingTransformer1.p, bus.p) annotation(
    Line(points = {{13, -70}, {-4, -70}}, color = {0, 0, 255}));
  connect(bus.p, infiniteBus2.p) annotation(
    Line(points = {{-4, -70}, {-13, -70}, {-13, -72}}, color = {0, 0, 255}));
  connect(bus1.p, twoWindingTransformer1.n) annotation(
    Line(points = {{44, -70}, {35, -70}}, color = {0, 0, 255}));
  connect(Vangle.y, staticgen.angle_0) annotation(
    Line(points = {{5, -34}, {29.5, -34}, {29.5, -35}, {48, -35}}, color = {0, 0, 127}));
  connect(staticgen.p, bus1.p) annotation(
    Line(points = {{84, -34}, {98, -34}, {98, -70}, {44, -70}}, color = {0, 0, 255}));
  connect(electrolyser_detailed1.nH2, storage2.nH2_i) annotation(
    Line(points = {{-47, -14}, {-6, -14}, {-6, 26}, {-62, 26}, {-62, 40}, {-39, 40}}, color = {0, 0, 127}));
  connect(storage2.S_storage, controller_P2G3.S_storage) annotation(
    Line(points = {{-4, 58}, {32, 58}, {32, 42}, {41, 42}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.nH2, controller_P2G3.generation) annotation(
    Line(points = {{-47, -14}, {14, -14}, {14, 21}, {40, 21}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.Pelec, staticgen.P_0) annotation(
    Line(points = {{-47, 10}, {30, 10}, {30, -48}, {48, -48}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.Pelec, controller_P2G3.P) annotation(
    Line(points = {{-47, 10}, {36, 10}, {36, 8}, {40, 8}}, color = {0, 0, 127}));
  connect(controller_P2G3.Pmin, electrolyser_detailed1.Porder) annotation(
    Line(points = {{84, 24}, {94, 24}, {94, 92}, {-92, 92}, {-92, 10}, {-81, 10}}, color = {0, 0, 127}));
  connect(const.y, infiniteBus2.V) annotation(
    Line(points = {{-56, -72}, {-36, -72}, {-36, -72}, {-34, -72}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[1], controller_P2G3.demand) annotation(
    Line(points = {{46, 76}, {66, 76}, {66, 50}, {26, 50}, {26, 32}, {40, 32}, {40, 32}}, color = {0, 0, 127}));
  connect(const.y, staticgen.V_0) annotation(
    Line(points = {{-56, -72}, {-44, -72}, {-44, -20}, {48, -20}, {48, -20}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[1], storage2.nH2_o) annotation(
    Line(points = {{46, 76}, {46, 76}, {46, 64}, {0, 64}, {0, 76}, {-62, 76}, {-62, 58}, {-38, 58}, {-38, 58}}, color = {0, 0, 127}));
  connect(realExpression.y, lcoh.efficiency) annotation(
    Line(points = {{-24, -106}, {-20, -106}, {-20, -110}, {-8, -110}, {-8, -110}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(graphics = {Text(origin = {-25, -59}, lineColor = {0, 0, 255}, extent = {{-11, 1}, {11, -1}}, textString = "infinite bus")}, coordinateSystem(extent = {{-120, -120}, {120, 120}})),
    Icon(coordinateSystem(extent = {{-120, -120}, {120, 120}})));


end P2G_basecase;
