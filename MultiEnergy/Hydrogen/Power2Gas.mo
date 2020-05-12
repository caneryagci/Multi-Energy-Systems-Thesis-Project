within Hydrogen;

model Power2Gas

  Hydrogen.Storage storage(p_tank(fixed = false))  annotation(
    Placement(visible = true, transformation(origin = {-124, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 70000)  annotation(
    Placement(visible = true, transformation(origin = {-168, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 50, height = 1000, offset = 5000, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = {-174, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Electrolyser3 electrolyser3 annotation(
    Placement(visible = true, transformation(origin = {-61, -17}, extent = {{-31, -31}, {31, 31}}, rotation = 0)));
  iPSL.Electrical.Solar.KTH.PFblocks.Controller controller annotation(
    Placement(visible = true, transformation(origin = {51, 7}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 575)  annotation(
    Placement(visible = true, transformation(origin = {-10, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant PCC_voltage(k = 1.01) annotation(
    Placement(visible = true, transformation(origin = {-120, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PQbus annotation(
    Placement(visible = true, transformation(origin = {-56, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus21(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-90, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer(Sn = 100, V_b = 12500, Vn = 12500, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {-28, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PVbus annotation(
    Placement(visible = true, transformation(origin = {0, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.SystemBase sysData annotation(
    Placement(visible = true, transformation(origin = {134, 122}, extent = {{-10, -10}, {14, 10}}, rotation = 0)));
  Hydrogen.Static_generator static_generator annotation(
    Placement(visible = true, transformation(origin = {141, 9}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = PCC_voltage.k)  annotation(
    Placement(visible = true, transformation(origin = {-34, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, storage.nH2_o) annotation(
    Line(points = {{-157, -4}, {-146, -4}, {-146, 6}, {-132, 6}}, color = {0, 0, 127}));
  connect(ramp.y, storage.p_tank_bar) annotation(
    Line(points = {{-163, 28}, {-146, 28}, {-146, 13}, {-132, 13}, {-132, 14}}, color = {0, 0, 127}));
  connect(storage.nH2_i, electrolyser3.nH) annotation(
    Line(points = {{-113, 9}, {-109.25, 9}, {-109.25, 11}, {-101.5, 11}, {-101.5, 6}, {-87, 6}}, color = {0, 0, 127}));
  connect(const2.y, controller.Vdcref) annotation(
    Line(points = {{1, -42}, {6, -42}, {6, -11}, {23, -11}}, color = {0, 0, 127}));
  connect(electrolyser3.Vdc, controller.udc) annotation(
    Line(points = {{-30, -8}, {-4, -8}, {-4, 0}, {23, 0}}, color = {0, 0, 127}));
  connect(PCC_voltage.y, infiniteBus21.V) annotation(
    Line(points = {{-109, -112}, {-101, -112}}, color = {0, 0, 127}));
  connect(twoWindingTransformer.p, PQbus.p) annotation(
    Line(points = {{-39, -112}, {-56, -112}}, color = {0, 0, 255}));
  connect(PVbus.p, twoWindingTransformer.n) annotation(
    Line(points = {{0, -112}, {-17, -112}}, color = {0, 0, 255}));
  connect(PQbus.p, infiniteBus21.p) annotation(
    Line(points = {{-56, -112}, {-79, -112}}, color = {0, 0, 255}));
  connect(controller.id_ref, static_generator.idref) annotation(
    Line(points = {{76, 16}, {100, 16}, {100, 23}, {113, 23}}, color = {0, 0, 127}));
  connect(controller.iq_ref, static_generator.iqref) annotation(
    Line(points = {{76, -4}, {110, -4}, {110, 9}, {113, 9}}, color = {0, 0, 127}));
  connect(static_generator.p, PVbus.p) annotation(
    Line(points = {{166, 9}, {166, -112}, {0, -112}}, color = {0, 0, 255}));
  connect(static_generator.v, controller.uac) annotation(
    Line(points = {{166, 25}, {166, 42}, {8, 42}, {8, 22}, {24, 22}, {24, 24}}, color = {0, 0, 127}));
  connect(realExpression.y, controller.Vacref) annotation(
    Line(points = {{-22, 58}, {-8, 58}, {-8, 12}, {24, 12}, {24, 12}}, color = {0, 0, 127}));
protected
  annotation(
    uses(Modelica(version = "3.2.3"), iPSL(version = "1.1.0")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "");


end Power2Gas;
