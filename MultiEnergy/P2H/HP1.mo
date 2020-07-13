within P2H;
model HP1
  import SI = Modelica.SIunits;
  import Modelica.Constants.pi;
  import Modelica.Math;
  import ModelicaReference.Operators;
  import Modelica.ComplexMath;
Real cop;
Real Php;
Real Pboiler;
Real efficiency;
Real Qboiler;
parameter Real Tinlet=40;
  Modelica.Blocks.Interfaces.RealInput Tamb annotation(
    Placement(visible = true, transformation(origin = {-100, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Toutlet annotation(
    Placement(visible = true, transformation(origin = {-100, 32}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 32}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Q annotation(
    Placement(visible = true, transformation(origin = {115, 85}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {115, 85}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Pord annotation(
    Placement(visible = true, transformation(origin = {-100, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  cop = 7.505 + 0.1655 * Tinlet + 0.0006427 * Tinlet ^ 2 - 0.002327 * Tinlet * Toutlet - 0.1289 * Toutlet + 0.0006111 * Toutlet ^ 2 "Coefficient of Performance";
  Q=Php*cop;
  Pboiler = Q_boiler/efficiency;
  Qboiler = 1;
  efficiency=(40-Tamb)/40;
  
annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {5, 4}, lineColor = {0, 0, 255}, extent = {{-63, 40}, {63, -40}}, textString = "Boiler + HP"), Text(origin = {-41, 74}, extent = {{-33, 20}, {33, -20}}, textString = "T_inlet"), Text(origin = {5, 4}, lineColor = {0, 0, 255}, extent = {{-63, 40}, {63, -40}}, textString = "Boiler + HP"), Text(origin = {-41, 74}, extent = {{-33, 20}, {33, -20}}, textString = "T_inlet"), Text(origin = {-25, 41}, extent = {{-51, -19}, {37, 15}}, textString = "T_outlet"), Text(origin = {-34, -37}, extent = {{-46, 29}, {46, -29}}, textString = "P_order"), Text(origin = {76, 84}, extent = {{-24, 14}, {24, -14}}, textString = "nQ"), Text(origin = {74, -41}, extent = {{-22, 23}, {22, -23}}, textString = "Ppu")}, coordinateSystem(initialScale = 0.1)));
end HP1;
