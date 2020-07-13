within Wind;

model Windfarm2
  iPSL.Electrical.Machines.PSAT.Order4 order4(D = 0, M = 2.8756 * 2,Sn = 100, Vn = 20000, ra = 0, xd1 = 0.245)  annotation(
    Placement(visible = true, transformation(origin = {42, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner iPSL.Electrical.SystemBase SysData annotation(
    Placement(visible = true, transformation(origin = {80, 84}, extent = {{-10, -10}, {14, 10}}, rotation = 0)));
  iPSL.Electrical.Loads.PSAT.LOADPQ pwLoadPQ1(P_0 = 50, Q_0 = 0.06, V_0 = 1.02, V_b = 20000, angle_0 = 0) annotation(
    Placement(visible = true, transformation(origin = {78, -65}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PwLine pwLine3(B = 0.001 / 2, G = 0, R = 0.01, X = 0.1) annotation(
    Placement(visible = true, transformation(origin = {78, -31}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  iPSL.Electrical.Controls.PSAT.AVR.AVRTypeI aVRI(vrmax = 7.57) annotation(
    Placement(visible = true, transformation(extent = {{-4, 24}, {16, 44}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1.02) annotation(
    Placement(visible = true, transformation(origin = {-52, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(order4.p, pwLine3.p) annotation(
    Line(points = {{54, 4}, {78, 4}, {78, -20}, {78, -20}}, color = {0, 0, 255}));
  connect(pwLine3.n, pwLoadPQ1.p) annotation(
    Line(points = {{78, -42}, {78, -42}, {78, -54}, {78, -54}}, color = {0, 0, 255}));
  connect(order4.v, aVRI.v) annotation(
    Line(points = {{53, 7}, {64, 7}, {64, 20}, {-16, 20}, {-16, 30}, {-6, 30}}, color = {0, 0, 127}));
  connect(aVRI.vf, order4.vf) annotation(
    Line(points = {{17, 34}, {22, 34}, {22, 10}, {33, 10}, {33, 9}}, color = {0, 0, 127}));
  connect(const.y, aVRI.vref) annotation(
    Line(points = {{-41, 34}, {-25.5, 34}, {-25.5, 40}, {-6, 40}}, color = {0, 0, 127}));
  connect(order4.pm0, order4.pm) annotation(
    Line(points = {{34, -6}, {10, -6}, {10, 0}, {34, 0}, {34, 0}}, color = {0, 0, 127}));
  annotation(
    uses(WindPowerPlants(version = "1.X.X"), Modelica(version = "3.2.3")));

end Windfarm2;
