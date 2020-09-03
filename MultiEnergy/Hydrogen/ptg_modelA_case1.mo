within Hydrogen;

model ptg_modelA_case1
  iPSL.Electrical.Buses.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {44, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus2(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-24, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(Sb = 50,Sn = 100, V_b = 12500, Vn = 12500, fn = 50, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {24, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus annotation(
    Placement(visible = true, transformation(origin = {-4, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.staticgen staticgen( Td = 5, Tq = 5)  annotation(
    Placement(visible = true, transformation(origin = {63, -35}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Vangle(y = -0.0000253046024029618)  annotation(
    Placement(visible = true, transformation(origin = {-6, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Storage2 storage2(S_storage)  annotation(
    Placement(visible = true, transformation(origin = {-25, 51}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1.02)  annotation(
    Placement(visible = true, transformation(origin = {-68, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.LCOH lcoh annotation(
    Placement(visible = true, transformation(origin = {8, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = electrolyser_simple.electrochemical_simple.efficiency2)  annotation(
    Placement(visible = true, transformation(origin = {-28, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Controller_P2G3 controller_P2G3 annotation(
    Placement(visible = true, transformation(origin = {50.5198, 51.1101}, extent = {{-22.4881, -28.1101}, {37.4802, 18.7401}}, rotation = 0)));
  Hydrogen.electrolyser_simple electrolyser_simple annotation(
    Placement(visible = true, transformation(origin = {-82, 8}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput gas_demand annotation(
    Placement(visible = true, transformation(origin = {-114, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-114, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput P_order annotation(
    Placement(visible = true, transformation(origin = {-142, 12}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-142, 12}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
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
  connect(const.y, infiniteBus2.V) annotation(
    Line(points = {{-56, -72}, {-36, -72}, {-36, -72}, {-34, -72}}, color = {0, 0, 127}));
  connect(const.y, staticgen.V_0) annotation(
    Line(points = {{-56, -72}, {-44, -72}, {-44, -20}, {48, -20}, {48, -20}}, color = {0, 0, 127}));
  connect(realExpression.y, lcoh.efficiency) annotation(
    Line(points = {{-17, -120}, {-12, -120}, {-12, -124}, {0, -124}}, color = {0, 0, 127}));
  connect(storage2.S_storage, controller_P2G3.S_storage) annotation(
    Line(points = {{-4, 58}, {18, 58}, {18, 64}, {35, 64}}, color = {0, 0, 127}));
  connect(electrolyser_simple.Pelec, controller_P2G3.P) annotation(
    Line(points = {{-56, 26}, {36, 26}}, color = {0, 0, 127}));
  connect(electrolyser_simple.nH2, controller_P2G3.generation) annotation(
    Line(points = {{-56, -3}, {14, -3}, {14, 36}, {34, 36}}, color = {0, 0, 127}));
  connect(electrolyser_simple.nH2, storage2.nH2_i) annotation(
    Line(points = {{-56, -2}, {-48, -2}, {-48, 40}, {-38, 40}, {-38, 40}}, color = {0, 0, 127}));
  connect(electrolyser_simple.Pelec, staticgen.P_0) annotation(
    Line(points = {{-56, 26}, {-28, 26}, {-28, -14}, {30, -14}, {30, -48}, {48, -48}}, color = {0, 0, 127}));
  connect(P_order, electrolyser_simple.Porder) annotation(
    Line(points = {{-142, 12}, {-112, 12}, {-112, 18}, {-100, 18}, {-100, 16}}, color = {0, 0, 127}));
  connect(gas_demand, storage2.nH2_o) annotation(
    Line(points = {{-114, 62}, {-38, 62}, {-38, 58}, {-38, 58}}, color = {0, 0, 127}));
  connect(gas_demand, controller_P2G3.demand) annotation(
    Line(points = {{-114, 62}, {-70, 62}, {-70, 86}, {18, 86}, {18, 54}, {34, 54}, {34, 52}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(graphics = {Text(origin = {-25, -59}, lineColor = {0, 0, 255}, extent = {{-11, 1}, {11, -1}}, textString = "infinite bus")}, coordinateSystem(extent = {{-120, -120}, {120, 120}}, initialScale = 0.1)),
    Icon(coordinateSystem(extent = {{-120, -120}, {120, 120}})));





end ptg_modelA_case1;
