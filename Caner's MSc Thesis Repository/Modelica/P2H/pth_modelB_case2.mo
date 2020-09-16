within P2H;

model pth_modelB_case2
  Hydrogen.staticgen staticgen annotation(
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
    Placement(visible = true, transformation(origin = {30, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = hp2.COP)  annotation(
    Placement(visible = true, transformation(origin = {-24, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  HP1 hp2 annotation(
    Placement(visible = true, transformation(origin = {-17, 7}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  P2H.controller_APL controller_APL annotation(
    Placement(visible = true, transformation(origin = {47.7017, 69.582}, extent = {{-19.7017, -24.6271}, {32.8361, 16.418}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant V_bus(k = 1.02)  annotation(
    Placement(visible = true, transformation(origin = {-82, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput heat_demand annotation(
    Placement(visible = true, transformation(origin = {-86, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-86, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput P_order annotation(
    Placement(visible = true, transformation(origin = {-80, -8}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -8}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T_ambient annotation(
    Placement(visible = true, transformation(origin = {-88, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-88, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput pth_switch annotation(
    Placement(visible = true, transformation(origin = {-106, 54}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-106, 54}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
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
  connect(realExpression.y, lcodh.COP) annotation(
    Line(points = {{-13, -92}, {6.5, -92}, {6.5, -94}, {22, -94}}, color = {0, 0, 127}));
  connect(hp2.Q, storage.Q_generation) annotation(
    Line(points = {{10, 26}, {20, 26}, {20, 38}, {-50, 38}, {-50, 54}, {-24, 54}, {-24, 56}}, color = {0, 0, 127}));
  connect(hp2.Pelec, staticgen.P_0) annotation(
    Line(points = {{9, 14}, {22, 14}, {22, -42}, {32, -42}, {32, -48}, {43, -48}}, color = {0, 0, 127}));
  connect(storage.S, controller_APL.S_storage) annotation(
    Line(points = {{10, 74}, {16, 74}, {16, 82}, {34, 82}, {34, 82}}, color = {0, 0, 127}));
  connect(hp2.Pelec, controller_APL.P) annotation(
    Line(points = {{10, 14}, {24, 14}, {24, 46}, {34, 46}, {34, 48}}, color = {0, 0, 127}));
  connect(hp2.Q, controller_APL.generation) annotation(
    Line(points = {{10, 26}, {20, 26}, {20, 56}, {34, 56}, {34, 56}}, color = {0, 0, 127}));
  connect(V_bus.y, staticgen.V_0) annotation(
    Line(points = {{-70, -46}, {-26, -46}, {-26, -28}, {42, -28}, {42, -28}}, color = {0, 0, 127}));
  connect(V_bus.y, infiniteBus2.V) annotation(
    Line(points = {{-70, -46}, {-66, -46}, {-66, -62}, {-58, -62}, {-58, -62}}, color = {0, 0, 127}));
  connect(P_order, hp2.Pord) annotation(
    Line(points = {{-80, -8}, {-38, -8}, {-38, -8}, {-36, -8}}, color = {0, 0, 127}));
  connect(T_ambient, hp2.Tamb) annotation(
    Line(points = {{-88, 20}, {-38, 20}, {-38, 20}, {-36, 20}}, color = {0, 0, 127}));
  connect(heat_demand, storage.Q_demand) annotation(
    Line(points = {{-86, 74}, {-38, 74}, {-38, 72}, {-24, 72}, {-24, 72}}, color = {0, 0, 127}));
  connect(heat_demand, controller_APL.demand) annotation(
    Line(points = {{-86, 74}, {-48, 74}, {-48, 90}, {22, 90}, {22, 70}, {34, 70}, {34, 72}}, color = {0, 0, 127}));
  connect(pth_switch, controller_APL.pth_switch) annotation(
    Line(points = {{-106, 54}, {20, 54}, {20, 64}, {34, 64}, {34, 64}}, color = {0, 0, 127}));
protected


end pth_modelB_case2;
