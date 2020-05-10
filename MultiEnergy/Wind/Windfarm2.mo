within Wind;

model Windfarm2

  WindPowerPlants.Plants.GenericVariableSpeed plant11 annotation(
    Placement(visible = true, transformation(origin = {56, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Wind.weibull_random_wind_speed_generator weibull_random_wind_speed_generator annotation(
    Placement(visible = true, transformation(origin = {-20, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable shape(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/shape_k(hourly).txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-72, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable scale(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/scale(hourly).txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-74, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  speedadaptor speedadaptor1 annotation(
    Placement(visible = true, transformation(origin = {14, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(shape.y[1], weibull_random_wind_speed_generator.shape) annotation(
    Line(points = {{-60, 0}, {-42, 0}, {-42, 16}, {-28, 16}}, color = {0, 0, 127}));
  connect(scale.y[1], weibull_random_wind_speed_generator.scale) annotation(
    Line(points = {{-62, 32}, {-48, 32}, {-48, 26}, {-28, 26}}, color = {0, 0, 127}));
  connect(weibull_random_wind_speed_generator.windspeed, speedadaptor1.vin) annotation(
    Line(points = {{-10, 20}, {-4, 20}, {-4, 16}, {2, 16}, {2, 16}}, color = {0, 0, 127}));
  connect(speedadaptor1.vout, plant11.v) annotation(
    Line(points = {{26, 16}, {44, 16}, {44, 16}, {44, 16}}, color = {0, 0, 127}));
  annotation(
    uses(WindPowerPlants(version = "1.X.X"), Modelica(version = "3.2.3")));

end Windfarm2;
