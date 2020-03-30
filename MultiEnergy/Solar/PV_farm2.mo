within Solar;

model PV_farm2
  Irradiance_gen irradiance_gen1 annotation(
    Placement(visible = true, transformation(origin = {-138, -68}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable alfa_table(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/alfa(hourly).txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-184, -52}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable beta_table(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/beta(hourly).txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-184, -68}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable B_int_table(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/B_int(hourly).txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-184, -88}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Tamb(k = 298) annotation(
    Placement(visible = true, transformation(origin = {-136, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PV_module pV_module1(Area = 1.44, Eta0 = 0.126, NoctRadiation = 1000, NoctTemp = 25 + 273, NoctTempCell = 46 + 273, TempCoeff = 0.0043)  annotation(
    Placement(visible = true, transformation(origin = {-88, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OpenIPSL.Electrical.SystemBase SysData annotation(
    Placement(visible = true, transformation(origin = {-176, -14}, extent = {{-12, -10}, {12, 10}}, rotation = 0)));
equation
  connect(Tamb.y, pV_module1.T_amb) annotation(
    Line(points = {{-124, -26}, {-108, -26}, {-108, -64}, {-100, -64}, {-100, -64}}, color = {0, 0, 127}));
  connect(irradiance_gen1.Irradiance, pV_module1.SolarIrradiationPerSquareMeter) annotation(
    Line(points = {{-118, -68}, {-100, -68}, {-100, -68}, {-100, -68}}, color = {0, 0, 127}));
  connect(B_int_table.y[1], irradiance_gen1.B_int) annotation(
    Line(points = {{-177.4, -88}, {-169.4, -88}, {-169.4, -88}, {-163.4, -88}, {-163.4, -80}, {-157.4, -80}}, color = {0, 0, 127}));
  connect(beta_table.y[1], irradiance_gen1.beta) annotation(
    Line(points = {{-177.4, -68}, {-157.4, -68}}, color = {0, 0, 127}));
  connect(alfa_table.y[1], irradiance_gen1.alfa) annotation(
    Line(points = {{-177.4, -52}, {-163.4, -52}, {-163.4, -58}, {-159.4, -58}, {-159.4, -58}, {-157.4, -58}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3"), AixLib(version = "0.7.3")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "",
    __OpenModelica_commandLineOptions = "");
end PV_farm2;
