within Hydrogen;


model thermal

  parameter Real Cth= 162116 "J/K";
  parameter Real Rth = 0.0668 "K/W";
  //parameter Real Tamb =298.15;
  parameter Real Wpump=1100*0.75;
  Real Qcooling;
  Real Qloss;
  Real Hloss;
  Real CpH;
  Real CpO;
  
  Modelica.Blocks.Interfaces.RealInput Wpem annotation(
    Placement(visible = true, transformation(origin = {-96, 44}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 32}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Top annotation(
    Placement(visible = true, transformation(origin = {92, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {113, 61}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput nH annotation(
    Placement(visible = true, transformation(origin = {-96, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput nO annotation(
    Placement(visible = true, transformation(origin = {-96, -42}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -76}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Pelec annotation(
    Placement(visible = true, transformation(origin = {-98, 76}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 82}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Tamb annotation(
    Placement(visible = true, transformation(origin = {-94,-78}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {44, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
equation
//Thermal submodel
  Cth * der(Top) = Wpem + Wpump - Qcooling - Qloss - Hloss;
//Wpem = (Vcell - Vtn) * Icell * n_cells;
  Qcooling = 2000 + 110 * Pelec;
  Qloss = (1 / Rth) * (Top - (Tamb+273.15));
  Hloss=nH*CpH*(Top-(Tamb+273.15))+nO*CpO*(Top-(Tamb+273.15));
  CpH=(29.11-1.92e-3*Top+4e-6*Top^2-8.7e-10*Top^3);
  CpO=(25.48+1.52e-2*Top-7.16e-6*Top^2+1.31e-9*Top^3);
annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-19, 31}, extent = {{-35, 31}, {19, -13}}, textString = "Wpem"), Text(origin = {-32, -11}, extent = {{-26, 17}, {28, -25}}, textString = "nH"), Text(origin = {-21, -83}, extent = {{-37, 31}, {15, -9}}, textString = "nO"), Text(origin = {81, 62}, extent = {{-23, 24}, {13, -14}}, textString = "Top"), Text(origin = {22, 37}, lineColor = {0, 0, 255}, extent = {{-68, 21}, {68, -69}}, textString = "Thermal"), Text(origin = {-22, 96}, extent = {{-28, -30}, {18, 14}}, textString = "Pelec"), Text(origin = {63, -42}, extent = {{-27, 22}, {27, -22}}, textString = "Tamb")}, coordinateSystem(initialScale = 0.1)));
end thermal;
