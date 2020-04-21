model windfarm_caner
  Wind.weibull_random_wind_speed_generator weibull_random_wind_speed_generator annotation(
    Placement(visible = true, transformation(origin = {-24, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable scale(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/scale(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-74, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable shape(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Wind Farm/shape_k(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-72, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner PowerGrids.Electrical.System systemPowerGrids annotation(
    Placement(visible = true, transformation(origin = {-134, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 0, offset = 0.000939)  annotation(
    Placement(visible = true, transformation(origin = {50, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Electrical.Machines.SynchronousMachine4Windings synchronousMachine4Windings(H = 6, SNom = 5.5e+08, Tpd0 = 8, Tppd0 = 0.03, Tppq0 = 0.07, Tpq0 = 1, UNom = 24000, excitationPuType = PowerGrids.Types.Choices.ExcitationPuType.Kundur, portVariablesPhases = true, raPu = 0.003, timeConstApprox = PowerGrids.Types.Choices.TimeConstantsApproximation.classicalDefinition, xdPu = 1.81, xlPu = 0.15, xpdPu = 0.3, xppdPu = 0.23, xppqPu = 0.25, xpqPu = 0.65, xqPu = 1.76)  annotation(
    Placement(visible = true, transformation(origin = {84, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Wind.Rotor rotor annotation(
    Placement(visible = true, transformation(origin = {14, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Electrical.Buses.Bus bus(SNom = 5.5e+08, UNom = 24000, portVariablesPhases = true)  annotation(
    Placement(visible = true, transformation(origin = {90, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Electrical.Branches.TransformerFixedRatio transformerFixedRatio(R = 0.15e-2 * 419 ^ 2 / 550,SNom = 5.5e+08, UNomA = 24000, UNomB = 419000, X = 16e-2 * 419 ^ 2 / 550, portVariablesPhases = true, rFixed = 419 / 24)  annotation(
    Placement(visible = true, transformation(origin = {90, -46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  PowerGrids.Electrical.Buses.Bus bus1(SNom = 5.5e+08, UNom = 380000, portVariablesPhases = true)  annotation(
    Placement(visible = true, transformation(origin = {90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Electrical.Loads.LoadImpedancePQ GRIDL(PRef = 4.75e+08 * (if time < 2 then 1 else 1.05), QRef = 7.6e+07 * (if time < 2 then 1 else 1.04), SNom = 5e+08, UNom = 380000, URef = 1.05 * 380e3, portVariablesPhases = true, portVariablesPu = true) annotation(
    Placement(visible = true, transformation(origin = {78, -106}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerGrids.Electrical.Buses.EquivalentGrid GRID(R_X = 1 / 10, SNom = 5e+08, SSC = 2.5e+09, UNom = 380000, URef = 1.05 * 380e3, c = 1.1, portVariablesPhases = true, portVariablesPu = true) annotation(
    Placement(visible = true, transformation(origin = {122, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(scale.y[1], weibull_random_wind_speed_generator.scale) annotation(
    Line(points = {{-62, 32}, {-48, 32}, {-48, 26}, {-32, 26}, {-32, 26}}, color = {0, 0, 127}));
  connect(shape.y[1], weibull_random_wind_speed_generator.shape) annotation(
    Line(points = {{-60, 0}, {-42, 0}, {-42, 16}, {-32, 16}, {-32, 16}}, color = {0, 0, 127}));
  connect(step.y, synchronousMachine4Windings.ufPuIn) annotation(
    Line(points = {{62, 2}, {64, 2}, {64, 20}, {74, 20}, {74, 22}}, color = {0, 0, 127}));
  connect(weibull_random_wind_speed_generator.windspeed, rotor.windspeed) annotation(
    Line(points = {{-14, 20}, {-4, 20}, {-4, 24}, {6, 24}, {6, 24}}, color = {0, 0, 127}));
  connect(synchronousMachine4Windings.VPu, rotor.omega_m) annotation(
    Line(points = {{94, 20}, {106, 20}, {106, 46}, {-6, 46}, {-6, 30}, {6, 30}, {6, 30}}, color = {0, 0, 127}));
  connect(rotor.p_wind, synchronousMachine4Windings.PmPu) annotation(
    Line(points = {{24, 30}, {60, 30}, {60, 30}, {74, 30}, {74, 30}}, color = {0, 0, 127}));
  connect(synchronousMachine4Windings.terminal, bus.terminal) annotation(
    Line(points = {{84, 26}, {86, 26}, {86, -16}, {90, -16}, {90, -24}, {90, -24}}));
  connect(bus.terminal, transformerFixedRatio.terminalA) annotation(
    Line(points = {{90, -24}, {90, -24}, {90, -36}, {90, -36}}));
  connect(transformerFixedRatio.terminalB, bus1.terminal) annotation(
    Line(points = {{90, -56}, {90, -56}, {90, -70}, {90, -70}}));
  connect(GRIDL.terminal, bus1.terminal) annotation(
    Line(points = {{78, -106}, {78, -106}, {78, -76}, {90, -76}, {90, -70}, {90, -70}}));
  connect(GRID.terminal, bus1.terminal) annotation(
    Line(points = {{122, -110}, {120, -110}, {120, -76}, {90, -76}, {90, -70}, {90, -70}}));
protected
  annotation(
    uses(PowerGrids(version = "1.0.0"), PowerSystems(version = "1.0.0"), TransiEnt(version = "1.2.0"), Modelica(version = "3.2.3"), Buildings(version = "6.0.0"), WindPowerPlants(version = "1.3.0")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}}, initialScale = 0.1)),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "");
end windfarm_caner;
