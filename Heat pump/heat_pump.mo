model heat_pump
  Buildings.Fluid.Storage.StratifiedEnhanced tan annotation(
    Placement(visible = true, transformation(origin = {-20, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Storage.Stratified tan1 annotation(
    Placement(visible = true, transformation(origin = {54, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Storage.ExpansionVessel exp annotation(
    Placement(visible = true, transformation(origin = {-56, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.HeatPumps.Carnot_TCon heaPum annotation(
    Placement(visible = true, transformation(origin = {3, 29}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Buildings.Fluid.HeatPumps.ReciprocatingWaterToWater heaPum1 annotation(
    Placement(visible = true, transformation(origin = {-72, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.HeatExchangers.Heater_T hea annotation(
    Placement(visible = true, transformation(origin = {-82, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(tan1.port_b, heaPum.port_b2) annotation(
    Line(points = {{64, 10}, {74, 10}, {74, -6}, {-12, -6}, {-12, 20}, {-12, 20}}, color = {0, 127, 255}));
  connect(heaPum.port_b1, tan1.port_a) annotation(
    Line(points = {{18, 38}, {44, 38}, {44, 10}, {44, 10}}, color = {0, 127, 255}));
  connect(tan.port_b, heaPum1.port_b2) annotation(
    Line(points = {{-10, -28}, {-2, -28}, {-2, -48}, {-82, -48}, {-82, -32}}, color = {0, 127, 255}));
  connect(heaPum1.port_b1, tan.port_a) annotation(
    Line(points = {{-62, -20}, {-30, -20}, {-30, -28}}, color = {0, 127, 255}));

annotation(
    uses(Buildings(version = "5.1.0")));end heat_pump;
