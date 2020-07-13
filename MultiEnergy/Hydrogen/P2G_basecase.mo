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
  Hydrogen.staticgen staticgen( Td = 1, Tq = 1)  annotation(
    Placement(visible = true, transformation(origin = {63, -35}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Vangle(y = -0.0000253046024029618)  annotation(
    Placement(visible = true, transformation(origin = {-6, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Storage2 storage2(S_storage(start = 5))  annotation(
    Placement(visible = true, transformation(origin = {-25, 51}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Hydrogen.electrolyser_detailed electrolyser_detailed1 annotation(
    Placement(visible = true, transformation(origin = {-66, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Hydrogen.Controller_P2G3 controller_P2G3(Pgain = 20000)  annotation(
    Placement(visible = true, transformation(origin = {60, 24}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput v annotation(
    Placement(visible = true, transformation(origin = {-78, -52}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-78, -52}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput gas_demand annotation(
    Placement(visible = true, transformation(origin = {60, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {60, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
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
    Line(points = {{-43, -15}, {-6, -15}, {-6, 26}, {-62, 26}, {-62, 40}, {-39, 40}}, color = {0, 0, 127}));
  connect(storage2.S_storage, controller_P2G3.S_storage) annotation(
    Line(points = {{-4, 58}, {32, 58}, {32, 42}, {41, 42}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.nH2, controller_P2G3.generation) annotation(
    Line(points = {{-43, -15}, {14, -15}, {14, 21}, {40, 21}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.Pelec, staticgen.P_0) annotation(
    Line(points = {{-42, 11}, {30, 11}, {30, -48}, {48, -48}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.Pelec, controller_P2G3.P) annotation(
    Line(points = {{-42, 11}, {36, 11}, {36, 8}, {40, 8}}, color = {0, 0, 127}));
  connect(controller_P2G3.Pmin, electrolyser_detailed1.Porder) annotation(
    Line(points = {{84, 24}, {94, 24}, {94, 90}, {-92, 90}, {-92, 12}, {-80, 12}}, color = {0, 0, 127}));
  connect(v, infiniteBus2.V) annotation(
    Line(points = {{-78, -52}, {-46, -52}, {-46, -72}, {-34, -72}, {-34, -72}}, color = {0, 0, 127}));
  connect(v, staticgen.V_0) annotation(
    Line(points = {{-78, -52}, {18, -52}, {18, -20}, {48, -20}, {48, -20}}, color = {0, 0, 127}));
  connect(gas_demand, storage2.nH2_o) annotation(
    Line(points = {{60, 74}, {-58, 74}, {-58, 58}, {-39, 58}}, color = {0, 0, 127}));
  connect(gas_demand, controller_P2G3.demand) annotation(
    Line(points = {{60, 74}, {14, 74}, {14, 34}, {40, 34}, {40, 32}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(graphics = {Text(origin = {-25, -59}, lineColor = {0, 0, 255}, extent = {{-11, 1}, {11, -1}}, textString = "infinite bus")}, coordinateSystem(initialScale = 0.1)));


end P2G_basecase;
