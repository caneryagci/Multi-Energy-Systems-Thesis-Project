model windspeed_caner
  Wind.weibull_random_wind_speed_generator weibull_random_wind_speed_generator annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable shape(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/shape_k(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-38, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable scale(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/scale(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-40, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput windspeed annotation(
    Placement(visible = true, transformation(origin = {58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(scale.y[1], weibull_random_wind_speed_generator.scale) annotation(
    Line(points = {{-28, 22}, {-18, 22}, {-18, 6}, {2, 6}, {2, 6}}, color = {0, 0, 127}));
  connect(shape.y[1], weibull_random_wind_speed_generator.shape) annotation(
    Line(points = {{-26, -16}, {-16, -16}, {-16, -4}, {2, -4}, {2, -4}}, color = {0, 0, 127}));
  connect(weibull_random_wind_speed_generator.windspeed, windspeed) annotation(
    Line(points = {{20, 0}, {58, 0}}, color = {0, 0, 127}));

annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Text(origin = {89, 1}, extent = {{-9, 7}, {7, -3}}, textString = "ws"), Text(origin = {-4, 1}, lineColor = {85, 0, 255}, extent = {{-56, 37}, {56, -37}}, textString = "WS"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end windspeed_caner;
