model Irradiance_caner
  Solar.Irradiance_gen irradiance_gen annotation(
    Placement(visible = true, transformation(origin = {14, 2}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Irradiance annotation(
    Placement(visible = true, transformation(origin = {82, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable alfa(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/alfa(hourly).txt",tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-66, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable beta(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/beta(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-72, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable B_int(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/B_int(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-64, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(irradiance_gen.Irradiance, Irradiance) annotation(
    Line(points = {{48, 2}, {76, 2}, {76, 4}, {82, 4}}, color = {0, 0, 127}));
  connect(alfa.y[1], irradiance_gen.alfa) annotation(
    Line(points = {{-54, 28}, {-44, 28}, {-44, 22}, {-18, 22}, {-18, 22}}, color = {0, 0, 127}));
  connect(beta.y[1], irradiance_gen.beta) annotation(
    Line(points = {{-60, 0}, {-20, 0}, {-20, 2}, {-18, 2}}, color = {0, 0, 127}));
  connect(B_int.y[1], irradiance_gen.B_int) annotation(
    Line(points = {{-52, -28}, {-40, -28}, {-40, -20}, {-18, -20}, {-18, -18}}, color = {0, 0, 127}));

annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-6, 11}, lineColor = {85, 0, 255}, extent = {{-32, 29}, {46, -31}}, textString = "IR"), Text(origin = {86, 3}, extent = {{10, 5}, {-10, -5}}, textString = "irradiance")}));
end Irradiance_caner;
