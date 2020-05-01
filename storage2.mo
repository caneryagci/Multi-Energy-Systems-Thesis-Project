model storage2
  Modelica.Blocks.Interfaces.RealInput nH2_i "#moles of hydrogen input" annotation(
    Placement(visible = true, transformation(origin = {-96, 46}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 46}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput nH2_o  "#moles of hydrogen output" annotation(
    Placement(visible = true, transformation(origin = {-92, -26}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput p_tank_bar annotation(
    Placement(visible = true, transformation(origin = {88, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

parameter Real R=8.314 "Gas constant";
parameter Real T= 273.14+40 "Tank Temperature";
parameter Real V=100 "Volume of the tank";
Real p_tank(start=8e5) "Pressure in Pa";

equation
der(p_tank) = R*T/V*(nH2_i-nH2_o); //Tank Pressure in [Pa]
p_tank_bar = 1e-5*p_tank; //tank pressure [Bar]

annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Text(origin = {-82, 71}, extent = {{-10, 5}, {10, -5}}, textString = "nH2_i"), Text(origin = {-78, -26}, extent = {{-12, 6}, {8, -4}}, textString = "nH2_o"), Text(origin = {95, 74}, extent = {{-11, 4}, {7, -2}}, textString = "P_tank"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)));
end storage2;
