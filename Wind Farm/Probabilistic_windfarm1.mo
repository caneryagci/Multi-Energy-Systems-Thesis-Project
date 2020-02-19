model Probabilistic_windfarm1
  WindPowerPlants.Plants.GenericVariableSpeedElectrical plant(VRef = 33, powerMax = 2000000)  annotation(
    Placement(visible = true, transformation(origin = {-55, 9}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  WindPowerPlants.WindSources.Rayleigh rayleigh1(vMean = 19)  annotation(
    Placement(visible = true, transformation(origin = {-124, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(rayleigh1.v, plant.v) annotation(
    Line(points = {{-112, 8}, {-76, 8}, {-76, 10}, {-76, 10}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "",
    uses(WindPowerPlants(version = "1.1.1"), OpenIPSL(version = "1.5.0")),
    __OpenModelica_commandLineOptions = "");end Probabilistic_windfarm1;
