within P2H;

model P2H_basecase
  Hydrogen.staticgen staticgen(Td = 5, Tq = 5)  annotation(
    Placement(visible = true, transformation(origin = {54, -38}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  P2H.storage storage annotation(
    Placement(visible = true, transformation(origin = {-8, 62}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  P2H.HP1 hp1 annotation(
    Placement(visible = true, transformation(origin = {-17, 7}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Vangle(y = -0.0000253046024029618) annotation(
    Placement(visible = true, transformation(origin = {2, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {22, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(Sn = 100, V_b = 12500, Vn = 12500, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {2, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus annotation(
    Placement(visible = true, transformation(origin = {-26, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus2(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-54, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  P2H.controller_p2h controller_p2h annotation(
    Placement(visible = true, transformation(origin = {68, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  P2H.LCODH lcodh annotation(
    Placement(visible = true, transformation(origin = {196, -106}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = hp1.COP)  annotation(
    Placement(visible = true, transformation(origin = {142, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput heat_demand annotation(
    Placement(visible = true, transformation(origin = {-80, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 72}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Tambient annotation(
    Placement(visible = true, transformation(origin = {-78, 28}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-78, 28}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput V annotation(
    Placement(visible = true, transformation(origin = {-88, -28}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-88, -28}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(hp1.Pelec, staticgen.P_0) annotation(
    Line(points = {{9, 14}, {22, 14}, {22, -42}, {32, -42}, {32, -48}, {43, -48}}, color = {0, 0, 127}));
  connect(Vangle.y, staticgen.angle_0) annotation(
    Line(points = {{13, -38}, {43, -38}}, color = {0, 0, 127}));
  connect(twoWindingTransformer1.p, bus.p) annotation(
    Line(points = {{-9, -62}, {-26, -62}}, color = {0, 0, 255}));
  connect(bus1.p, twoWindingTransformer1.n) annotation(
    Line(points = {{22, -62}, {13, -62}}, color = {0, 0, 255}));
  connect(infiniteBus2.p, bus.p) annotation(
    Line(points = {{-43, -62}, {-26, -62}}, color = {0, 0, 255}));
  connect(staticgen.p, bus1.p) annotation(
    Line(points = {{69, -38}, {71, -38}, {71, -62}, {22, -62}}, color = {0, 0, 255}));
  connect(hp1.Pelec, controller_p2h.P) annotation(
    Line(points = {{9, 14}, {28, 14}, {28, 43}, {48, 43}}, color = {0, 0, 127}));
  connect(controller_p2h.Pmin, hp1.Pord) annotation(
    Line(points = {{90, 60}, {90, -20}, {-58, -20}, {-58, -6}, {-35, -6}, {-35, -7}}, color = {0, 0, 127}));
  connect(realExpression.y, lcodh.COP) annotation(
    Line(points = {{153, -108}, {172.5, -108}, {172.5, -110}, {188, -110}}, color = {0, 0, 127}));
  connect(heat_demand, storage.Q_demand) annotation(
    Line(points = {{-80, 72}, {-24, 72}, {-24, 72}, {-24, 72}}, color = {0, 0, 127}));
  connect(Tambient, hp1.Tamb) annotation(
    Line(points = {{-78, 28}, {-50, 28}, {-50, 20}, {-36, 20}, {-36, 20}}, color = {0, 0, 127}));
  connect(hp1.Q, storage.Q_generation) annotation(
    Line(points = {{10, 26}, {20, 26}, {20, 38}, {-50, 38}, {-50, 54}, {-24, 54}, {-24, 56}}, color = {0, 0, 127}));
  connect(hp1.Q, controller_p2h.generation) annotation(
    Line(points = {{10, 26}, {20, 26}, {20, 55}, {48, 55}}, color = {0, 0, 127}));
  connect(storage.S, controller_p2h.S_storage) annotation(
    Line(points = {{10, 74}, {48, 74}, {48, 74}, {48, 74}}, color = {0, 0, 127}));
  connect(heat_demand, controller_p2h.demand) annotation(
    Line(points = {{-80, 72}, {-38, 72}, {-38, 90}, {30, 90}, {30, 66}, {48, 66}, {48, 66}}, color = {0, 0, 127}));
  connect(V, infiniteBus2.V) annotation(
    Line(points = {{-88, -28}, {-80, -28}, {-80, -62}, {-64, -62}}, color = {0, 0, 127}));
  connect(V, staticgen.V_0) annotation(
    Line(points = {{-88, -28}, {42, -28}}, color = {0, 0, 127}));
protected
end P2H_basecase;
