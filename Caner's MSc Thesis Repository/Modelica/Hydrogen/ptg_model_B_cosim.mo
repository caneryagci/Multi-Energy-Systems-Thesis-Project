within Hydrogen;

model ptg_model_B_cosim
  iPSL.Electrical.Buses.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {44, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus2(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-24, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(Sb = 50,Sn = 100, V_b = 12500, Vn = 12500, fn = 50, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {24, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus annotation(
    Placement(visible = true, transformation(origin = {-4, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.staticgen staticgen( Td = 5, Tq = 5)  annotation(
    Placement(visible = true, transformation(origin = {71, -45}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Vangle(y = -0.0000253046024029618)  annotation(
    Placement(visible = true, transformation(origin = {12, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Storage2 storage2(S_storage)  annotation(
    Placement(visible = true, transformation(origin = {-24, 52}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Hydrogen.electrolyser_detailed electrolyser_detailed1 annotation(
    Placement(visible = true, transformation(origin = {-59, -3}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  Hydrogen.LCOH lcoh annotation(
    Placement(visible = true, transformation(origin = {8, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = electrolyser_detailed1.electrochemical.efficiency2)  annotation(
    Placement(visible = true, transformation(origin = {-28, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Controller_P2G3 controller_P2G3 annotation(
    Placement(visible = true, transformation(origin = {50.5198, 51.1101}, extent = {{-22.4881, -28.1101}, {37.4802, 18.7401}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput gas_demand annotation(
    Placement(visible = true, transformation(origin = {-80, 84}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 84}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput T_ambient annotation(
    Placement(visible = true, transformation(origin = {-106, -16}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-106, -16}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1.02) annotation(
    Placement(visible = true, transformation(origin = {-68, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(twoWindingTransformer1.p, bus.p) annotation(
    Line(points = {{13, -70}, {-4, -70}}, color = {0, 0, 255}));
  connect(bus.p, infiniteBus2.p) annotation(
    Line(points = {{-4, -70}, {-13, -70}, {-13, -72}}, color = {0, 0, 255}));
  connect(bus1.p, twoWindingTransformer1.n) annotation(
    Line(points = {{44, -70}, {35, -70}}, color = {0, 0, 255}));
  connect(Vangle.y, staticgen.angle_0) annotation(
    Line(points = {{23, -48}, {29.5, -48}, {29.5, -45}, {56, -45}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.nH2, storage2.nH2_i) annotation(
    Line(points = {{-32, -18}, {-6, -18}, {-6, 26}, {-62, 26}, {-62, 40}, {-40, 40}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.Pelec, staticgen.P_0) annotation(
    Line(points = {{-32, 12}, {30, 12}, {30, -58}, {56, -58}}, color = {0, 0, 127}));
  connect(realExpression.y, lcoh.efficiency) annotation(
    Line(points = {{-17, -120}, {-12, -120}, {-12, -124}, {0, -124}}, color = {0, 0, 127}));
  connect(storage2.S_storage, controller_P2G3.S_storage) annotation(
    Line(points = {{0, 60}, {19.5, 60}, {19.5, 64}, {35, 64}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.nH2, controller_P2G3.generation) annotation(
    Line(points = {{-32, -18}, {16, -18}, {16, 36}, {35, 36}}, color = {0, 0, 127}));
  connect(electrolyser_detailed1.Pelec, controller_P2G3.P) annotation(
    Line(points = {{-32, 12}, {22, 12}, {22, 26}, {35, 26}}, color = {0, 0, 127}));
  connect(controller_P2G3.Pmin, electrolyser_detailed1.Porder) annotation(
    Line(points = {{94, 62}, {100, 62}, {100, 104}, {-96, 104}, {-96, 12}, {-76, 12}, {-76, 13}}, color = {0, 0, 127}));
  connect(gas_demand, storage2.nH2_o) annotation(
    Line(points = {{-80, 84}, {-50, 84}, {-50, 60}, {-40, 60}, {-40, 61}}, color = {0, 0, 127}));
  connect(gas_demand, controller_P2G3.demand) annotation(
    Line(points = {{-80, 84}, {24, 84}, {24, 52}, {34, 52}, {34, 52}}, color = {0, 0, 127}));
  connect(T_ambient, electrolyser_detailed1.T_ambient) annotation(
    Line(points = {{-106, -16}, {-97, -16}, {-97, -17}, {-77, -17}}, color = {0, 0, 127}));
  connect(staticgen.p, bus1.p) annotation(
    Line(points = {{92, -44}, {100, -44}, {100, -70}, {44, -70}, {44, -70}}, color = {0, 0, 255}));
  connect(const.y, infiniteBus2.V) annotation(
    Line(points = {{-56, -72}, {-34, -72}, {-34, -72}, {-34, -72}}, color = {0, 0, 127}));
  connect(const.y, staticgen.V_0) annotation(
    Line(points = {{-56, -72}, {-52, -72}, {-52, -32}, {56, -32}, {56, -30}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(graphics = {Text(origin = {-25, -59}, lineColor = {0, 0, 255}, extent = {{-11, 1}, {11, -1}}, textString = "infinite bus")}, coordinateSystem(extent = {{-120, -120}, {120, 120}}, initialScale = 0.1)),
    Icon(coordinateSystem(extent = {{-120, -120}, {120, 120}})));


end ptg_model_B_cosim;
