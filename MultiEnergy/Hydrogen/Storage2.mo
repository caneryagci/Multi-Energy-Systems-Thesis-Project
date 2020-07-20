within Hydrogen;

model Storage2
  Modelica.Blocks.Interfaces.RealInput nH2_o  "#moles of hydrogen input" annotation(
    Placement(visible = true, transformation(origin = {-100, -26}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 44}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

//parameter Real R=8.314 "Gas constant";
  //parameter Real T= 273.14+70 "Tank Temperature";
  //parameter Real V=10 "Volume of the tank";
  //Real p_tank(start=8e5) "Pressure in Pa";
  Modelica.Blocks.Interfaces.RealInput nH2_i annotation(
    Placement(visible = true, transformation(origin = {-100, -72}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  Modelica.Blocks.Interfaces.RealOutput S_storage (start = 50) "m3" annotation(
    Placement(visible = true, transformation(origin = {106, 56}, extent = {{-22, -22}, {22, 22}}, rotation = 0), iconTransformation(origin = {122, 40}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
equation
//tank pressure [Bar]
//p_tank_bar = p_tank * 1e-5 / 1000;
//Tank Pressure in [Pa]
  der(S_storage) = nH2_i - nH2_o;
//der(p_tank) = R * T / V * (nH2_i - nH2_o);
//nH2_i = der(p_tank) * V / (R * T) + nH2_o;
  //error = nH2_i - nH2_o;
  annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Text(origin = {-54, -39}, lineColor = {0, 0, 255}, extent = {{-44, 27}, {10, -5}}, textString = "nH2_i"), Text(origin = {-60, 76}, lineColor = {0, 0, 255}, extent = {{-38, 26}, {18, -18}}, textString = "nH2_o"), Text(origin = {69, 40}, lineColor = {0, 0, 255}, extent = {{-31, 32}, {27, -18}}, textString = "S_tank"), Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {13, -3}, lineColor = {0, 0, 255}, extent = {{-61, 39}, {45, -23}}, textString = "Storage Tank")}, coordinateSystem(initialScale = 0.1)));



end Storage2;
