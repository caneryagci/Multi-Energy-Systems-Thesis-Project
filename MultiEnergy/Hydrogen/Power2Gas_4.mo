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
    Placement(visible = true, transformation(origin = {-7, 45}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Hydrogen.Controller_DSM controller_DSM annotation(
    Placement(visible = true, transformation(origin = {55, 37}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Electrolyser/Text/gas_demand_pu.txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {56, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Hydrogen.Electrolyser4 electrolyser4 annotation(
    Placement(visible = true, transformation(origin = {-43, -3}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
equation
  connect(twoWindingTransformer1.p, bus.p) annotation(
    Line(points = {{13, -70}, {-4, -70}}, color = {0, 0, 255}));
  connect(bus.p, infiniteBus2.p) annotation(
    Line(points = {{-4, -70}, {-13, -70}, {-13, -72}}, color = {0, 0, 255}));
  connect(bus1.p, twoWindingTransformer1.n) annotation(
    Line(points = {{44, -70}, {35, -70}}, color = {0, 0, 255}));
  connect(Vangle.y, staticgen.angle_0) annotation(
    Line(points = {{5, -34}, {29.5, -34}, {29.5, -35}, {48, -35}}, color = {0, 0, 127}));
  connect(storage2.p_tank_bar, controller_DSM.S_storage) annotation(
    Line(points = {{14, 52}, {14, 10}, {50, 10}, {50, 16}}, color = {0, 0, 127}));
  connect(staticgen.p, bus1.p) annotation(
    Line(points = {{84, -34}, {98, -34}, {98, -70}, {44, -70}}, color = {0, 0, 255}));
  connect(V.y, infiniteBus2.V) annotation(
    Line(points = {{-46, -72}, {-36, -72}, {-36, -72}, {-34, -72}}, color = {0, 0, 127}));
  connect(V.y, staticgen.V_0) annotation(
    Line(points = {{-46, -72}, {-42, -72}, {-42, -46}, {16, -46}, {16, -22}, {48, -22}, {48, -20}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[1], controller_DSM.demand) annotation(
    Line(points = {{44, 80}, {24, 80}, {24, 40}, {36, 40}, {36, 42}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[1], storage2.nH2_o) annotation(
    Line(points = {{44, 80}, {-52, 80}, {-52, 50}, {-22, 50}, {-22, 52}, {-20, 52}}, color = {0, 0, 127}));
  connect(controller_DSM.Pmin, electrolyser4.Pord) annotation(
    Line(points = {{80, 50}, {86, 50}, {86, 94}, {-82, 94}, {-82, -2}, {-60, -2}, {-60, 0}}, color = {0, 0, 127}));
  connect(electrolyser4.nH_pu, storage2.nH2_i) annotation(
    Line(points = {{-44, 16}, {-42, 16}, {-42, 34}, {-20, 34}, {-20, 34}}, color = {0, 0, 127}));
  connect(electrolyser4.Pout, controller_DSM.P) annotation(
    Line(points = {{-24, 4}, {66, 4}, {66, 18}, {66, 18}}, color = {0, 0, 127}));
  connect(electrolyser4.Pout, staticgen.P_0) annotation(
    Line(points = {{-24, 4}, {26, 4}, {26, -48}, {48, -48}, {48, -48}}, color = {0, 0, 127}));
  connect(electrolyser4.nH_pu, controller_DSM.generation) annotation(
    Line(points = {{-44, 16}, {26, 16}, {26, 28}, {38, 28}, {38, 28}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(graphics = {Text(origin = {-25, -59}, lineColor = {0, 0, 255}, extent = {{-11, 1}, {11, -1}}, textString = "infinite bus")}, coordinateSystem(initialScale = 0.1)));
end Power2Gas_4;
