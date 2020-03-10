model test3
  Modelica.Blocks.Sources.CombiTimeTable shape(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/shape_k(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-74, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable scale(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/scale(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-76, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  weibull_random_wind_speed_generator weibull_random_wind_speed_generator1(n = 300, vMax = 1200)  annotation(
    Placement(visible = true, transformation(origin = {-38, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 313)  annotation(
    Placement(visible = true, transformation(origin = {-60, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PV_module pV_module1(Area = 1.44, Eta0 = 0.126, NoctRadiation = 1000, NoctTemp = 25 + 273, NoctTempCell = 46 + 273, TempCoeff = 0.0043)  annotation(
    Placement(visible = true, transformation(origin = {4, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const.y, pV_module1.T_amb) annotation(
    Line(points = {{-48, 78}, {-22, 78}, {-22, 50}, {-8, 50}, {-8, 50}}, color = {0, 0, 127}));
  connect(weibull_random_wind_speed_generator1.windspeed, pV_module1.SolarIrradiationPerSquareMeter) annotation(
    Line(points = {{-26, 36}, {-12, 36}, {-12, 38}, {-8, 38}, {-8, 38}}, color = {0, 0, 127}));
  connect(shape.y[1], weibull_random_wind_speed_generator1.shape) annotation(
    Line(points = {{-63, 22}, {-50, 22}, {-50, 32}}, color = {0, 0, 127}));
  connect(scale.y[1], weibull_random_wind_speed_generator1.scale) annotation(
    Line(points = {{-65, 54}, {-50, 54}, {-50, 41}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3"), AixLib(version = "0.7.3")));end test3;
