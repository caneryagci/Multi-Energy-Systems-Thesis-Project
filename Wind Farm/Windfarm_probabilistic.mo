model Windfarm_probabilistic
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/scale(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/shape_k(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-58, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  weibull_random_wind_speed_generator weibull_random_wind_speed_generator1 annotation(
    Placement(visible = true, transformation(origin = {-14, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Wind_turbine1 wind_turbine11 annotation(
    Placement(visible = true, transformation(origin = {26, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(weibull_random_wind_speed_generator1.windspeed, wind_turbine11.windspeed) annotation(
    Line(points = {{-2, -12}, {18, -12}, {18, -12}, {18, -12}}, color = {0, 0, 127}));
  connect(combiTimeTable2.y[1], weibull_random_wind_speed_generator1.shape) annotation(
    Line(points = {{-46, -28}, {-26, -28}, {-26, -16}, {-26, -16}}, color = {0, 0, 127}));
  connect(combiTimeTable1.y[1], weibull_random_wind_speed_generator1.scale) annotation(
    Line(points = {{-46, 0}, {-28, 0}, {-28, -6}, {-26, -6}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3")));end Windfarm_probabilistic;
