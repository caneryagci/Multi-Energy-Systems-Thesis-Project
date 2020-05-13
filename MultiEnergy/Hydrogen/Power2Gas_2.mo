within Hydrogen;

model Power2Gas_2


  Hydrogen.Storage storage(p_tank(fixed = false))  annotation(
    Placement(visible = true, transformation(origin = {-138, 14}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 80000000)  annotation(
    Placement(visible = true, transformation(origin = {-178, -8}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 30, height = 20, offset = 5000, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = {-184, 26}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant PCC_voltage(k = 1.01) annotation(
    Placement(visible = true, transformation(origin = {-62, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PQbus annotation(
    Placement(visible = true, transformation(origin = {2, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus21(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-32, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer(Sn = 100, V_b = 12500, Vn = 12500, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {30, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PVbus annotation(
    Placement(visible = true, transformation(origin = {58, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Static_generator static_generator(Td = 3, Tq = 3)  annotation(
    Placement(visible = true, transformation(origin = {141, -47}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1(y = 1.00018548610126)  annotation(
    Placement(visible = true, transformation(origin = {35, -37}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression2(y = -0.0000253046024029618)  annotation(
    Placement(visible = true, transformation(origin = {35, -49}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression4(y = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {35, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Hydrogen.Electrolyser3 electrolyser3 annotation(
    Placement(visible = true, transformation(origin = {-42, 20}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
equation
  connect(PCC_voltage.y, infiniteBus21.V) annotation(
    Line(points = {{-51, -110}, {-43, -110}}, color = {0, 0, 127}));
  connect(twoWindingTransformer.p, PQbus.p) annotation(
    Line(points = {{19, -110}, {2, -110}}, color = {0, 0, 255}));
  connect(PVbus.p, twoWindingTransformer.n) annotation(
    Line(points = {{58, -110}, {41, -110}}, color = {0, 0, 255}));
  connect(PQbus.p, infiniteBus21.p) annotation(
    Line(points = {{2, -110}, {-21, -110}}, color = {0, 0, 255}));
  connect(static_generator.p, PVbus.p) annotation(
    Line(points = {{173, -47}, {184, -47}, {184, -110}, {58, -110}}, color = {0, 0, 255}));
  connect(realExpression1.y, static_generator.V_0) annotation(
    Line(points = {{43, -37}, {115, -37}}, color = {0, 0, 127}));
  connect(realExpression2.y, static_generator.angle_0) annotation(
    Line(points = {{43, -49}, {85, -49}, {85, -47}, {115, -47}}, color = {0, 0, 127}));
  connect(realExpression4.y, static_generator.Q_0) annotation(
    Line(points = {{43, -73}, {109.5, -73}, {109.5, -70}, {115, -70}}, color = {0, 0, 127}));
  connect(ramp.y, storage.p_tank_bar) annotation(
    Line(points = {{-175, 26}, {-162, 26}, {-162, 23}, {-157, 23}}, color = {0, 0, 127}));
  connect(const.y, storage.nH2_o) annotation(
    Line(points = {{-170, -8}, {-166, -8}, {-166, 3}, {-157, 3}}, color = {0, 0, 127}));
  connect(electrolyser3.Pdc_pu, static_generator.P_0) annotation(
    Line(points = {{-22, 14}, {-2, 14}, {-2, -58}, {114, -58}, {114, -58}}, color = {0, 0, 127}));
  connect(storage.nH2_i, electrolyser3.nH) annotation(
    Line(points = {{-114, 14}, {-92, 14}, {-92, 48}, {-74, 48}}, color = {0, 0, 127}));
  connect(electrolyser3.Pdc_mw, static_generator.P_0) annotation(
    Line(points = {{-4, 50}, {10, 50}, {10, -58}, {114, -58}, {114, -58}}, color = {0, 0, 127}));
protected
  annotation(
    uses(Modelica(version = "3.2.3"), iPSL(version = "1.1.0")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "");



end Power2Gas_2;
