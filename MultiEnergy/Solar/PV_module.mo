within Solar;

model PV_module
  //extends Modelica.Electrical.PowerConverters.Interfaces.DCAC.DCtwoPin;
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
    Placement(visible = true,transformation(extent = {{-139, 62}, {-99, 102}}, rotation = 0), iconTransformation(origin = {-119, 25}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput SolarIrradiationPerSquareMeter annotation(
    Placement(visible = true,transformation(extent = {{-142, -102}, {-102, -62}}, rotation = 0), iconTransformation(extent = {{-134, -36}, {-102, -4}}, rotation = 0)));
equation
  TCell = T_amb + (NoctTempCell - NoctTemp) * SolarIrradiationPerSquareMeter / NoctRadiation;
  PowerPV = SolarIrradiationPerSquareMeter * Area * EtaVar;
  EtaVar = Eta0 - TempCoeff * (TCell - NoctTemp) * Eta0;
  DCOutputPower = PowerPV;
  //v=;
  //i=;
end PV_module;
