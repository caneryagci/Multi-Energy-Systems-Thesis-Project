within Hydrogen;

model Storage

  Modelica.Blocks.Interfaces.RealOutput nH2_i "#moles of hydrogen output" annotation(
    Placement(visible = true, transformation(origin = {114, 6}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {108, -6}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput nH2_o  "#moles of hydrogen input" annotation(
    Placement(visible = true, transformation(origin = {-100, -26}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

parameter Real R=8.314 "Gas constant";
parameter Real T= 273.14+40 "Tank Temperature";
parameter Real V=100 "Volume of the tank";
Real p_tank(start=8e5) "Pressure in Pa";
  Modelica.Blocks.Interfaces.RealInput p_tank_bar annotation(
    Placement(visible = true, transformation(origin = {-100, 46}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-82, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  
//tank pressure [Bar]
  p_tank = p_tank_bar/1e-5;

//Tank Pressure in [Pa]
//der(p_tank) = R * T / V * (nH2_i - nH2_o);
 nH2_i = der(p_tank)*V/(R*T) +nH2_o;

  annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Text(origin = {102, 25}, extent = {{-10, 5}, {10, -5}}, textString = "nH2_i"), Text(origin = {-78, -26}, extent = {{-12, 6}, {8, -4}}, textString = "nH2_o"), Text(origin = {-87, 64}, extent = {{-11, 4}, {7, -2}}, textString = "P_tank"), Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {13, -3}, lineColor = {0, 0, 255}, extent = {{-61, 39}, {45, -23}}, textString = "Storage Tank")}, coordinateSystem(initialScale = 0.1)));


end Storage;
