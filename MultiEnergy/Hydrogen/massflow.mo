within Hydrogen;

model massflow
  parameter Real F = 96485 "Faraday constant";
  parameter Real n_cells= 60 "number of cells";
  parameter Real Molar_massH = 2.016e-3"molar mass of hydrogen at 353 Kelvin";
  parameter Real Molar_massO = 31.999e-3 "molar mass of oxygen at 353 Kelvin";
  parameter Real densityH = 0.06953 "density of hydrogen at 353 K";
  parameter Real densityO = 1.104 "density of oxygen at 353 K";
  parameter Real scaling = 1086.956"50MW/46kW";
  //Real nH_pu;
  //Real nH "Total hydrogen production rate in Nm3/h";
  //Real nO "Total oxygen production rate";
  Modelica.Blocks.Interfaces.RealOutput nHtO annotation(
    Placement(visible = true, transformation(origin = {72, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput nH "mol/s" annotation(
    Placement(visible = true, transformation(origin = {66, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput nO "mol/s" annotation(
    Placement(visible = true, transformation(origin = {60, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Icell annotation(
    Placement(visible = true, transformation(origin = {-68, 18}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
//Mass/flow equations
  nH = Molar_massH * n_cells * Icell / (2 * F * densityH);
  nHtO = n_cells * Icell / (2 * F);
//(Nm3/h)/(mol/s)
  //nH_pu = nH / 0.161;
  nO = Molar_massH * n_cells * Icell / (4 * F *densityO);
annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {87, 58}, extent = {{-45, 30}, {9, -10}}, textString = "nHtO"), Text(origin = {86, 10}, extent = {{-50, 36}, {12, -10}}, textString = "nH"), Text(origin = {86, -71}, extent = {{-36, 35}, {12, -5}}, textString = "nO"), Text(origin = {-22, 60}, extent = {{-32, 26}, {20, -18}}, textString = "Icell"), Text(origin = {-10, 9}, lineColor = {0, 0, 255}, extent = {{-68, 49}, {80, -77}}, textString = "massflow")}, coordinateSystem(initialScale = 0.1)));
end massflow;
