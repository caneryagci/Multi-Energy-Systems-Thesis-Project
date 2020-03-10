within Solar;

model PV_module
  parameter Modelica.SIunits.Area Area "Area of one Panel";
  parameter Modelica.SIunits.Efficiency Eta0 "Maximum efficiency";
  parameter Modelica.SIunits.Temp_K NoctTemp "Defined temperature";
  parameter Modelica.SIunits.Temp_K NoctTempCell "Meassured cell temperature";
  parameter Modelica.SIunits.RadiantEnergyFluenceRate NoctRadiation "Defined radiation";
  parameter Modelica.SIunits.LinearTemperatureCoefficient TempCoeff "Temperature coeffient";
  Modelica.SIunits.Power PowerPV "Power of PV panels";
  Modelica.SIunits.Efficiency EtaVar "Efficiency of PV cell";
  Modelica.SIunits.Temp_K TCell "Cell temperature";
  Modelica.Blocks.Interfaces.RealOutput DCOutputPower(final quantity = "Power", final unit = "W") "DC output power of PV panels" annotation(
    Placement(transformation(extent = {{100, 70}, {120, 90}}), iconTransformation(extent = {{100, -10}, {120, 10}})));
  Modelica.Blocks.Interfaces.RealInput T_amb(final quantity = "ThermodynamicTemperature", final unit = "K") "Ambient temperature" annotation(
    Placement(transformation(extent = {{-139, 40}, {-99, 80}}), iconTransformation(extent = {{-140, 40}, {-100, 80}})));
  Modelica.Blocks.Interfaces.RealInput SolarIrradiationPerSquareMeter annotation(
    Placement(transformation(extent = {{-140, -80}, {-100, -40}}), iconTransformation(extent = {{-132, -72}, {-100, -40}})));
equation
  TCell = T_amb + (NoctTempCell - NoctTemp) * SolarIrradiationPerSquareMeter / NoctRadiation;
  PowerPV = SolarIrradiationPerSquareMeter * Area * EtaVar;
  EtaVar = Eta0 - TempCoeff * (TCell - NoctTemp) * Eta0;
  DCOutputPower = PowerPV;
end PV_module;
