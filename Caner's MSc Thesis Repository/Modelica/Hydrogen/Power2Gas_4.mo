within Hydrogen;

model Power2Gas_4
  Modelica.Blocks.Sources.Step V(height = 0.03, offset = 1.0, startTime = 80) annotation(
    Placement(visible = true, transformation(origin = {-58, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {44, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus2(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-24, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(Sn = 100, V_b = 12500, Vn = 12500, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {24, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus annotation(
    Placement(visible = true, transformation(origin = {-4, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.staticgen staticgen annotation(
    Placement(visible = true, transformation(origin = {63, -35}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Vangle(y = -0.0000253046024029618)  annotation(
    Placement(visible = true, transformation(origin = {-6, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.Storage2 storage2 annotation(
    Placement(visible = true, transformation(origin = {-31, 51}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Electrolyser/Text/gas_demand_pu.txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {54, 72}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Hydrogen.Electrolyser4 electrolyser4 annotation(
    Placement(visible = true, transformation(origin = {-54, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID pid annotation(
    Placement(visible = true, transformation(origin = {44, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
  connect(V.y, infiniteBus2.V) annotation(
    Line(points = {{-46, -72}, {-36, -72}, {-36, -72}, {-34, -72}}, color = {0, 0, 127}));
  connect(V.y, staticgen.V_0) annotation(
    Line(points = {{-46, -72}, {-42, -72}, {-42, -46}, {16, -46}, {16, -22}, {48, -22}, {48, -20}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[1], storage2.nH2_o) annotation(
    Line(points = {{43, 72}, {-52, 72}, {-52, 58}, {-45, 58}}, color = {0, 0, 127}));
  connect(electrolyser4.nH_pu, storage2.nH2_i) annotation(
    Line(points = {{-54, 9}, {-54, 42}, {-45, 42}, {-45, 40}}, color = {0, 0, 127}));
  connect(electrolyser4.Pout, staticgen.P_0) annotation(
    Line(points = {{-43, 2}, {26, 2}, {26, -46}, {48, -46}, {48, -48}}, color = {0, 0, 127}));
  connect(electrolyser4.nH_pu, pid.u_m) annotation(
    Line(points = {{-54, 10}, {-54, 14}, {44, 14}, {44, 18}}, color = {0, 0, 127}));
  connect(pid.y, electrolyser4.Pord) annotation(
    Line(points = {{55, 30}, {84, 30}, {84, 90}, {-76, 90}, {-76, -2}, {-64, -2}, {-64, 0}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[1], pid.u_s) annotation(
    Line(points = {{44, 72}, {8, 72}, {8, 30}, {32, 30}, {32, 30}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(graphics = {Text(origin = {-25, -59}, lineColor = {0, 0, 255}, extent = {{-11, 1}, {11, -1}}, textString = "infinite bus")}, coordinateSystem(initialScale = 0.1)));
end Power2Gas_4;
