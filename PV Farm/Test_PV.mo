model Test_PV
  Irradiance_gen irradiance_gen1 annotation(
    Placement(visible = true, transformation(origin = {-42, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable alfa(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/alfa(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-86, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable beta(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/beta(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-84, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable B_int(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/B_int(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-84, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(B_int.y[1], irradiance_gen1.B_int) annotation(
    Line(points = {{-72, -46}, {-64, -46}, {-64, -22}, {-52, -22}, {-52, -22}}, color = {0, 0, 127}));
  connect(beta.y[1], irradiance_gen1.beta) annotation(
    Line(points = {{-72, -12}, {-66, -12}, {-66, -16}, {-52, -16}, {-52, -16}}, color = {0, 0, 127}));
  connect(alfa.y[1], irradiance_gen1.alfa) annotation(
    Line(points = {{-74, 16}, {-62, 16}, {-62, -10}, {-52, -10}, {-52, -10}}, color = {0, 0, 127}));
  annotation(Modelica(version = "3.2.3"));end Test_PV;
