model heat_pump
  Buildings.Fluid.Storage.StratifiedEnhanced tan annotation(
    Placement(visible = true, transformation(origin = {-18, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Storage.Stratified tan1 annotation(
    Placement(visible = true, transformation(origin = {18, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Storage.ExpansionVessel exp annotation(
    Placement(visible = true, transformation(origin = {-56, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

annotation(
    uses(Buildings(version = "5.1.0")));end heat_pump;
