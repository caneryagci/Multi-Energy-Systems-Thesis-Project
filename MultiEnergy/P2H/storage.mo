within P2H;

model storage
  Modelica.Blocks.Interfaces.RealInput Q_demand annotation(
    Placement(visible = true, transformation(origin = {-100, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Q_generation annotation(
    Placement(visible = true, transformation(origin = {-100, -42}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -42}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput S annotation(
    Placement(visible = true, transformation(origin = {116, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {116, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));

parameter Real density=1"of water";
parameter Real heat_capacity=1"of water";
parameter Real V = 1 "volume of water in tank";
  Modelica.Blocks.Interfaces.RealOutput T annotation(
    Placement(visible = true, transformation(origin = {116, 12}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {116, 12}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
equation
density*heat_capacity*der(T)= (Q_generation - Q_demand);
annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}})}));
end storage;
