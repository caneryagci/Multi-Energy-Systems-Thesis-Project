within Hydrogen;

model Power2Gas

  Hydrogen.Storage storage(p_tank(fixed = false))  annotation(
    Placement(visible = true, transformation(origin = {-138, 14}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 70)  annotation(
    Placement(visible = true, transformation(origin = {-178, -8}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 30, height = 20, offset = 5000, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = {-184, 26}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Hydrogen.Electrolyser3 electrolyser3(n_cells_parallel = 500, n_cells_series = 200)  annotation(
    Placement(visible = true, transformation(origin = {-57, -13}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 700)  annotation(
    Placement(visible = true, transformation(origin = {-6, -26}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
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
  Modelica.Blocks.Sources.RealExpression realExpression(y = PCC_voltage.k)  annotation(
    Placement(visible = true, transformation(origin = {-34, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Static_generator static_generator(Td = 3, Tq = 3)  annotation(
    Placement(visible = true, transformation(origin = {141, -47}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression5(y = static_generator.v)  annotation(
    Placement(visible = true, transformation(origin = {26, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.SystemBase sysData annotation(
    Placement(visible = true, transformation(origin = {158, 102}, extent = {{-10, -10}, {14, 10}}, rotation = 0)));
  iPSL.Electrical.Solar.KTH.PFblocks.Controller controller annotation(
    Placement(visible = true, transformation(origin = {51, 7}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
equation
  connect(PCC_voltage.y, infiniteBus21.V) annotation(
    Line(points = {{-51, -110}, {-43, -110}}, color = {0, 0, 127}));
  connect(twoWindingTransformer.p, PQbus.p) annotation(
    Line(points = {{19, -110}, {2, -110}}, color = {0, 0, 255}));
  connect(PVbus.p, twoWindingTransformer.n) annotation(
    Line(points = {{58, -110}, {41, -110}}, color = {0, 0, 255}));
  connect(PQbus.p, infiniteBus21.p) annotation(
    Line(points = {{2, -110}, {-21, -110}}, color = {0, 0, 255}));
  connect(controller.id_ref, static_generator.idref) annotation(
    Line(points = {{76, 16}, {84, 16}, {84, 44}, {140, 44}, {140, -22}}, color = {0, 0, 127}));
  connect(controller.iq_ref, static_generator.iqref) annotation(
    Line(points = {{76, -4}, {88, -4}, {88, 40}, {122, 40}, {122, -22}}, color = {0, 0, 127}));
  connect(static_generator.p, PVbus.p) annotation(
    Line(points = {{173, -47}, {184, -47}, {184, -110}, {58, -110}}, color = {0, 0, 255}));
  connect(ramp.y, storage.p_tank_bar) annotation(
    Line(points = {{-175, 26}, {-162, 26}, {-162, 23}, {-157, 23}}, color = {0, 0, 127}));
  connect(const.y, storage.nH2_o) annotation(
    Line(points = {{-170, -8}, {-166, -8}, {-166, 3}, {-157, 3}}, color = {0, 0, 127}));
  connect(storage.nH2_i, electrolyser3.nH) annotation(
    Line(points = {{-114, 14}, {-104, 14}, {-104, 8}, {-88, 8}}, color = {0, 0, 127}));
  connect(realExpression5.y, controller.uac) annotation(
    Line(points = {{38, 62}, {52, 62}, {52, 40}, {10, 40}, {10, 22}, {24, 22}, {24, 24}}, color = {0, 0, 127}));
  connect(realExpression.y, controller.Vacref) annotation(
    Line(points = {{-22, 58}, {-8, 58}, {-8, 12}, {24, 12}, {24, 12}}, color = {0, 0, 127}));
  connect(electrolyser3.Vdc, controller.udc) annotation(
    Line(points = {{-22, -2.5}, {2.5, -2.5}, {2.5, 0}, {23, 0}}, color = {0, 0, 127}));
  connect(const2.y, controller.Vdcref) annotation(
    Line(points = {{1, -26}, {6, -26}, {6, -11}, {23, -11}}, color = {0, 0, 127}));
protected
  annotation(
    uses(Modelica(version = "3.2.3"), iPSL(version = "1.1.0")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "");


end Power2Gas;
