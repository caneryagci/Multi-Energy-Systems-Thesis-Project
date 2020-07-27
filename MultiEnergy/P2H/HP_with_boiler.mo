within P2H;

model HP_with_boiler
  import SI = Modelica.SIunits;
  import Modelica.Constants.pi;
  import Modelica.Math;
  import ModelicaReference.Operators;
  import Modelica.ComplexMath;
Real cop_50"Coefficient of Performance";
Real cop_70;
Real Php "kW";
Real Pboiler "kW";
Real Qtotal;
Real Qboiler;
Real Qhp;
Real COP;
parameter Real m=5 "mass flow of water kg/s";
parameter Real c=4.190"specific heat of water kj/(K.kg) at 70C";
parameter Real density=977.74"density of water(kg/m3)";


parameter Real Tdesign = 15;

  Modelica.Blocks.Interfaces.RealInput Tamb "Celcius" annotation(
    Placement(visible = true, transformation(origin = {-100, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Q "m3" annotation(
    Placement(visible = true, transformation(origin = {115, 85}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {115, 85}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Pord "MW" annotation(
    Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pelec "MW" annotation(
    Placement(visible = true, transformation(origin = {115, 29}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {115, 29}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
equation
//Heat Pump
  cop_50 = 3.461e-8 * Tamb ^ 5 + 1.29e-6 * Tamb ^ 4 + 4.353e-5 * Tamb ^ 3 + 0.002387 * Tamb ^ 2 + 0.1186 * Tamb + 5.063;
cop_70 = 1.457e-8*Tamb^5 - 9.658e-8* Tamb^4 + 6.609e-6 * Tamb^3 + 0.00101 * Tamb^2 + 0.05864 * Tamb + 3.295; 


Php = (Pord*1e3) - Pboiler;
Qtotal = Qhp + Qboiler;

Q=Qtotal/(c*density*(70-Tamb));

if Tamb < Tdesign then
  Qhp=Php*cop_50*m;
  Qboiler = m*c*20;
  COP = cop_50;
else
  Qhp=Php*cop_70*m;
  Qboiler = 0;
  COP = cop_70;
end if;
//Boiler
  Pboiler = Qboiler / 0.99;
  Pelec = Pord;
annotation(
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-27, 36}, extent = {{-45, 34}, {33, -22}}, textString = "Tambient"), Text(origin = {-27, -76}, extent = {{-33, 20}, {33, -20}}, textString = "Porder"), Text(origin = {52, 97}, extent = {{-12, 13}, {36, -41}}, textString = "Qgen"), Text(origin = {5, 4}, lineColor = {0, 0, 255}, extent = {{-49, 30}, {77, -42}}, textString = "Heat Pump"), Text(origin = {69, 30}, extent = {{-23, 16}, {23, -16}}, textString = "Php")}));

end HP_with_boiler;
