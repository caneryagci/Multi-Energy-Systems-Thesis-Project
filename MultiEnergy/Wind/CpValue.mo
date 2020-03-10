within Wind;

function CpValue
  extends Modelica.Icons.Function;
  //input WindPowerPlants.Records.TurbineData.Generic turbineData "Wind turbine record";
  input Real lambda "Tip speed ratio";
  input Real beta "Pitch angle in degree";
  output Real cp "Power coefficient";
protected
  parameter Real c1 = 0.5;
  parameter Real c2 = 116;
  parameter Real c3 = 0.4;
  parameter Real c4 = 5;
  parameter Real c5 = 21;
  parameter Real c6 = 0;
protected
  Real lambda1 "Internal lambda";
algorithm
  lambda1 := 1 / (1 / (lambda + 0.08 * beta + Modelica.Constants.eps) - 0.035 / (beta ^ 3 + 1));
  cp := c1 * (c2 / lambda1 - c3 * beta - c4) * exp(-c5 / lambda1) + c6 * lambda1;
  cp := max(0, cp);
//in case it has negative value = "0"
end CpValue;
