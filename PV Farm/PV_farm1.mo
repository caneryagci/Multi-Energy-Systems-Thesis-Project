model PV_farm1
  PV_panel pV_panel1(P_0 = 0.4, Q_0 = 0.3, S_b = 100, V_0 = 1.00018548610126, angle_0 = -0.0000253046024029618)  annotation(
    Placement(visible = true, transformation(origin = {-84, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus1(displayPF = true)  annotation(
    Placement(visible = true, transformation(origin = {-26, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {12, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine1(B = 0.001 / 2, G = 0, R = 0.01, X = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {-8, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PwLine pwLine2(B = 0.001 / 2, G = 0, R = 0.01, X = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {-8, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Events.PwFault pwFault1(R = 25, X = 1, t1 = 2, t2 = 2.3)  annotation(
    Placement(visible = true, transformation(origin = {38, -18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  inner OpenIPSL.Electrical.SystemBase SysData(S_b = 100, fn = 50)  annotation(
    Placement(visible = true, transformation(origin = {-84, 84}, extent = {{-12, -10}, {12, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Machines.PSAT.Order3 order31(D = 0, M = 10,P_0 = 0.0401256732154526, Q_0 = 0.0262725307404601, Sn = 20, T1d0 = 8, Vn = 400, ra = 0.001, x1d = 0.302, xd = 1.9, xq = 1.7)  annotation(
    Placement(visible = true, transformation(origin = {-26, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Buses.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {10, 68}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Branches.PwLine pwLine3(B = 0.001 / 2, G = 0, R = 0.01, X = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {10, 46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OpenIPSL.Electrical.Loads.PSAT.LOADPQ loadpq1(P_0 = 0.15, Q_0 = 0.1, forcePQ = true)  annotation(
    Placement(visible = true, transformation(origin = {56, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenIPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(kT = 33 / 0.4)  annotation(
    Placement(visible = true, transformation(origin = {-54, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  connect(twoWindingTransformer1.p, bus1.p) annotation(
    Line(points = {{-42, -2}, {-34, -2}, {-34, 2}, {-26, 2}, {-26, 2}}, color = {0, 0, 255}));
  connect(pV_panel1.p, twoWindingTransformer1.n) annotation(
    Line(points = {{-72, -2}, {-64, -2}, {-64, -2}, {-66, -2}}, color = {0, 0, 255}));
  connect(pwFault1.p, bus2.p) annotation(
    Line(points = {{31, -18}, {24, -18}, {24, 2}, {12, 2}}, color = {0, 0, 255}));
  connect(loadpq1.p, bus2.p) annotation(
    Line(points = {{56, 10}, {56, 10}, {56, 16}, {26, 16}, {26, 2}, {12, 2}, {12, 2}}, color = {0, 0, 255}));
  connect(pwLine3.n, bus2.p) annotation(
    Line(points = {{10, 36}, {12, 36}, {12, 2}, {12, 2}}, color = {0, 0, 255}));
  connect(bus3.p, pwLine3.p) annotation(
    Line(points = {{10, 68}, {10, 68}, {10, 56}, {10, 56}}, color = {0, 0, 255}));
  connect(pwLine2.n, bus2.p) annotation(
    Line(points = {{1, -8}, {5, -8}, {5, -4}, {7, -4}, {7, 4}, {9, 4}, {9, 2}, {11, 2}}, color = {0, 0, 255}));
  connect(pwLine2.p, bus1.p) annotation(
    Line(points = {{-17, -8}, {-23, -8}, {-23, 2}, {-27, 2}, {-27, 0}, {-25, 0}, {-25, 2}}, color = {0, 0, 255}));
  connect(pwLine1.n, bus2.p) annotation(
    Line(points = {{1, 12}, {7, 12}, {7, 2}, {12, 2}}, color = {0, 0, 255}));
  connect(bus1.p, pwLine1.p) annotation(
    Line(points = {{-26, 2}, {-24, 2}, {-24, 4}, {-22, 4}, {-22, 12}, {-17, 12}}, color = {0, 0, 255}));
  connect(order31.p, bus3.p) annotation(
    Line(points = {{-16, 80}, {10, 80}, {10, 68}, {10, 68}}, color = {0, 0, 255}));
  connect(order31.pm0, order31.pm) annotation(
    Line(points = {{-34, 68}, {-34, 68}, {-34, 64}, {-44, 64}, {-44, 76}, {-38, 76}, {-38, 74}}, color = {0, 0, 127}));
  connect(order31.vf0, order31.vf) annotation(
    Line(points = {{-34, 92}, {-34, 92}, {-34, 94}, {-44, 94}, {-44, 86}, {-38, 86}, {-38, 86}}, color = {0, 0, 127}));
  annotation(
    uses(OpenIPSL(version = "1.5.0")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "",
    __OpenModelica_commandLineOptions = "");end PV_farm1;
