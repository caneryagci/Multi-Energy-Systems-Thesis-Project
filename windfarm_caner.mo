model windfarm_caner
  Wind.weibull_random_wind_speed_generator weibull_random_wind_speed_generator annotation(
    Placement(visible = true, transformation(origin = {-24, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable scale(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/scale(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-74, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable shape(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/shape_k(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-72, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Rotor_caner rotor_caner annotation(
    Placement(visible = true, transformation(origin = {20, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(scale.y[1], weibull_random_wind_speed_generator.scale) annotation(
    Line(points = {{-62, 32}, {-48, 32}, {-48, 26}, {-32, 26}, {-32, 26}}, color = {0, 0, 127}));
  connect(shape.y[1], weibull_random_wind_speed_generator.shape) annotation(
    Line(points = {{-60, 0}, {-42, 0}, {-42, 16}, {-32, 16}, {-32, 16}}, color = {0, 0, 127}));
  connect(weibull_random_wind_speed_generator.windspeed, rotor_caner.v) annotation(
    Line(points = {{-14, 20}, {0, 20}, {0, 24}, {8, 24}, {8, 24}}, color = {0, 0, 127}));
protected
  annotation(
    uses(PowerGrids(version = "1.0.0"), PowerSystems(version = "1.0.0"), TransiEnt(version = "1.2.0"), Modelica(version = "3.2.3"), Buildings(version = "6.0.0")));
end windfarm_caner;
