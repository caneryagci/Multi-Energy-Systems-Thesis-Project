model PV_farm2
  Irradiance_gen irradiance_gen1 annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable alfa_table(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/alfa(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-74, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable beta_table(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/beta(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-72, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable B_int_table(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/B_int(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-70, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(beta_table.y[1], irradiance_gen1.beta) annotation(
    Line(points = {{-60, -6}, {-10, -6}, {-10, 0}, {-8, 0}}, color = {0, 0, 127}));
  connect(B_int_table.y[1], irradiance_gen1.B_int) annotation(
    Line(points = {{-58, -44}, {-10, -44}, {-10, -12}, {-8, -12}}, color = {0, 0, 127}));
  connect(alfa_table.y[1], irradiance_gen1.alfa) annotation(
    Line(points = {{-62, 28}, {-8, 28}, {-8, 10}, {-8, 10}}, color = {0, 0, 127}));

annotation(
    uses(Modelica(version = "3.2.3")));end PV_farm2;
