model new1
  Wind.weibull_random_wind_speed_generator weibull_random_wind_speed_generator1 annotation(
    Placement(visible = true, transformation(origin = {-50, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable scale(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/scale(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-86, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable shape(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/shape_k(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-88, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Lines.PIline line1(len = 100, ne = 1)  annotation(
    Placement(visible = true, transformation(origin = {-70, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Nodes.GroundOne grd1 annotation(
    Placement(visible = true, transformation(origin = {80, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Sensors.PVImeter PVImeter1(S_nom = 1e+06, V_nom = 1000)  annotation(
    Placement(visible = true, transformation(origin = {-20, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Lines.PIline line11(len = 500)  annotation(
    Placement(visible = true, transformation(origin = {14, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Sources.InfBus infBus(V_nom = 15000)  annotation(
    Placement(visible = true, transformation(origin = {50, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PowerSystems.AC3ph.Nodes.BusBar bus1 annotation(
    Placement(visible = true, transformation(origin = {-48, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner PowerSystems.System system annotation(
    Placement(visible = true, transformation(origin = {-74, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  WindTurbine_PS windTurbine_PS1 annotation(
    Placement(visible = true, transformation(origin = {-10, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(windTurbine_PS1.term, line1.term_p) annotation(
    Line(points = {{-8, -4}, {-10, -4}, {-10, -32}, {-94, -32}, {-94, -44}, {-80, -44}, {-80, -44}}, color = {0, 120, 120}));
  connect(weibull_random_wind_speed_generator1.windspeed, windTurbine_PS1.windSpeed) annotation(
    Line(points = {{-40, 6}, {-20, 6}, {-20, 6}, {-20, 6}}, color = {0, 0, 127}));
  connect(infBus.neutral, grd1.term) annotation(
    Line(points = {{60, -44}, {70, -44}, {70, -44}, {70, -44}}, color = {0, 0, 255}));
  connect(line11.term_n, infBus.term) annotation(
    Line(points = {{24, -44}, {40, -44}, {40, -44}, {40, -44}}, color = {0, 120, 120}));
  connect(PVImeter1.term_n, line11.term_p) annotation(
    Line(points = {{-10, -44}, {4, -44}, {4, -44}, {4, -44}}, color = {0, 120, 120}));
  connect(bus1.term, PVImeter1.term_p) annotation(
    Line(points = {{-48, -44}, {-30, -44}, {-30, -44}, {-30, -44}}, color = {0, 120, 120}));
  connect(line1.term_n, bus1.term) annotation(
    Line(points = {{-60, -44}, {-48, -44}, {-48, -44}, {-48, -44}}, color = {0, 120, 120}));
  connect(shape.y[1], weibull_random_wind_speed_generator1.shape) annotation(
    Line(points = {{-76, -14}, {-68, -14}, {-68, 2}, {-58, 2}, {-58, 2}}, color = {0, 0, 127}));
  connect(scale.y[1], weibull_random_wind_speed_generator1.scale) annotation(
    Line(points = {{-74, 14}, {-66, 14}, {-66, 12}, {-58, 12}, {-58, 12}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3"), PowerSystems(version = "1.0.0")));end new1;
