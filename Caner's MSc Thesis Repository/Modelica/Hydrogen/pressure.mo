within Hydrogen;

model pressure

//Real ppH_atm;
  //Real ppO_atm;
  //Real ppHtO_atm;
  //Real ppH_Pa;
  //Real ppO_Pa;
  //Real ppHtO_Pa;
  parameter Real Pcat = 30;
  parameter Real Pan = 30;
  Modelica.Blocks.Interfaces.RealInput Top annotation(
    Placement(visible = true, transformation(origin = {-96, 38}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput ppHtO_atm annotation(
    Placement(visible = true, transformation(origin = {100, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput ppH_atm annotation(
    Placement(visible = true, transformation(origin = {100, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput ppO_atm annotation(
    Placement(visible = true, transformation(origin = {100, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
//Partial pressures
  ppHtO_atm = 6.1078e-3 * Modelica.Math.exp(17.2694 * ((Top - 273.15) / (Top - 34.85)));
  ppH_atm = Pcat - (ppHtO_atm/101325);
  ppO_atm = Pan - (ppHtO_atm/101325);
//Convert from Pa to atm
//ppH_atm = ppH_Pa / 101325;
//ppO_atm = ppO_Pa / 101325;
//ppHtO_atm = ppHtO_Pa / 101325;
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-47, 58}, extent = {{-11, 10}, {37, -38}}, textString = "Top"), Text(origin = {86, 64}, extent = {{-52, 30}, {8, -6}}, textString = "ppHtO"), Text(origin = {52, 42}, extent = {{-12, 8}, {36, -24}}, textString = "ppH"), Text(origin = {85, -37}, extent = {{-35, 27}, {9, -5}}, textString = "ppO"), Text(origin = {-8, 17}, lineColor = {0, 0, 255}, extent = {{-68, 49}, {80, -77}}, textString = "pressure")}, coordinateSystem(initialScale = 0.1)));
end pressure;
