model try5
  Hydrogen.Storage storage annotation(
    Placement(visible = true, transformation(origin = {-96, 50}, extent = {{-34, -34}, {34, 34}}, rotation = 0)));
  Hydrogen.Electrolyser3 electrolyser3 annotation(
    Placement(visible = true, transformation(origin = {-5, 65}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  Hydrogen.Static_generator static_generator annotation(
    Placement(visible = true, transformation(origin = {92, 0}, extent = {{-34, -34}, {34, 34}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer(Sn = 100, V_b = 12500, Vn = 12500, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {30, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus21(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-32, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PVbus annotation(
    Placement(visible = true, transformation(origin = {58, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PQbus annotation(
    Placement(visible = true, transformation(origin = {2, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 50, height = 0.005, offset = 0.5, startTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-184, 26}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 20) annotation(
    Placement(visible = true, transformation(origin = {-178, -8}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  iPSL.Electrical.SystemBase sysData annotation(
    Placement(visible = true, transformation(origin = {158, 120}, extent = {{-10, -10}, {14, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression2(y = 0) annotation(
    Placement(visible = true, transformation(origin = {-19, -23}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression4(y = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-17, -47}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 0.1, offset = 1, startTime = 90) annotation(
    Placement(visible = true, transformation(origin = {-96, -112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(storage.nH2_i, electrolyser3.nH) annotation(
    Line(points = {{-62, 49}, {-40, 49}, {-40, 82}, {-24, 82}}, color = {0, 0, 127}));
  connect(electrolyser3.Pdc_mw, static_generator.P_0) annotation(
    Line(points = {{18, 82}, {32, 82}, {32, -14}, {62, -14}, {62, -14}}, color = {0, 0, 127}));
  connect(twoWindingTransformer.p, PQbus.p) annotation(
    Line(points = {{19, -110}, {2, -110}}, color = {0, 0, 255}));
  connect(PQbus.p, infiniteBus21.p) annotation(
    Line(points = {{2, -110}, {-21, -110}}, color = {0, 0, 255}));
  connect(PVbus.p, twoWindingTransformer.n) annotation(
    Line(points = {{58, -110}, {41, -110}}, color = {0, 0, 255}));
  connect(PVbus.p, static_generator.p) annotation(
    Line(points = {{58, -110}, {160, -110}, {160, 0}, {130, 0}, {130, 0}}, color = {0, 0, 255}));
  connect(ramp.y, storage.p_tank_bar) annotation(
    Line(points = {{-176, 26}, {-170, 26}, {-170, 64}, {-123, 64}, {-123, 63}}, color = {0, 0, 127}));
  connect(const.y, storage.nH2_o) annotation(
    Line(points = {{-170, -8}, {-154, -8}, {-154, 34}, {-123, 34}, {-123, 35}}, color = {0, 0, 127}));
  connect(realExpression2.y, static_generator.angle_0) annotation(
    Line(points = {{-12, -22}, {24, -22}, {24, 0}, {62, 0}, {62, 0}}, color = {0, 0, 127}));
  connect(realExpression4.y, static_generator.Q_0) annotation(
    Line(points = {{-10, -46}, {42, -46}, {42, -26}, {62, -26}, {62, -28}}, color = {0, 0, 127}));
  connect(step.y, infiniteBus21.V) annotation(
    Line(points = {{-84, -112}, {-58, -112}, {-58, -110}, {-42, -110}, {-42, -110}}, color = {0, 0, 127}));
  connect(step.y, static_generator.V_0) annotation(
    Line(points = {{-84, -112}, {-52, -112}, {-52, 10}, {62, 10}, {62, 12}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "",
    uses(iPSL(version = "1.1.0"), Modelica(version = "3.2.3")));
end try5;
