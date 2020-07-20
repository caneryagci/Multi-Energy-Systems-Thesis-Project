within P2H;

model storage
  Modelica.Blocks.Interfaces.RealInput Q_demand annotation(
    Placement(visible = true, transformation(origin = {-100, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Q_generation annotation(
    Placement(visible = true, transformation(origin = {-100, -42}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -42}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput S(start=1200) annotation(
    Placement(visible = true, transformation(origin = {116, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {116, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
parameter Real m =5 "massflow";
parameter Real density=977.74"of water at 70C";
parameter Real heat_capacity=4.190"of water at 70C";
parameter Real V = 2400 "volume of water in tank m3";
  Modelica.Blocks.Interfaces.RealOutput T(start=70) annotation(
    Placement(visible = true, transformation(origin = {116, 12}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {116, 12}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
equation
density*heat_capacity*V*der(T)= m*(Q_generation - Q_demand);
der(S)= Q_generation - Q_demand;
annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {19, -26}, lineColor = {0, 0, 255}, extent = {{-81, 108}, {35, -50}}, textString = "Storage"), Text(origin = {-49, -66}, extent = {{-27, 32}, {25, -6}}, textString = "Gen"), Text(origin = {-47, 56}, extent = {{-37, 44}, {25, -6}}, textString = "Demand"), Text(origin = {72, 73}, extent = {{-30, 21}, {30, -21}}, textString = "S"), Text(origin = {71, 15}, extent = {{-15, 19}, {19, -25}}, textString = "T")}, coordinateSystem(initialScale = 0.1)));
end storage;
