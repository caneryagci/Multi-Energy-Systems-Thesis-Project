within Hydrogen;

model electrolyser_simple
  Hydrogen.massflow massflow annotation(
    Placement(visible = true, transformation(origin = {41, -55}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Hydrogen.pressure pressure annotation(
    Placement(visible = true, transformation(origin = {65, -11}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 323.15)  annotation(
    Placement(visible = true, transformation(origin = {-78, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.electrochemical_simple electrochemical_simple annotation(
    Placement(visible = true, transformation(origin = {-35, 19}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Porder annotation(
    Placement(visible = true, transformation(origin = {-96, 22}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pelec annotation(
    Placement(visible = true, transformation(origin = {76, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {116, 80}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput nH2 annotation(
    Placement(visible = true, transformation(origin = {88, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {117, -49}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
equation
  connect(const.y, pressure.Top) annotation(
    Line(points = {{-67, -36}, {-2, -36}, {-2, -28}, {34, -28}, {34, -4}, {51, -4}}, color = {0, 0, 127}));
  connect(electrochemical_simple.Icell, massflow.Icell) annotation(
    Line(points = {{-17, 7}, {12, 7}, {12, -44}, {26, -44}}, color = {0, 0, 127}));
  connect(Porder, electrochemical_simple.Pord) annotation(
    Line(points = {{-96, 22}, {-52, 22}}, color = {0, 0, 127}));
  connect(electrochemical_simple.Pout, Pelec) annotation(
    Line(points = {{-17, 26}, {34, 26}, {34, 70}, {76, 70}}, color = {0, 0, 127}));
  connect(massflow.nH, nH2) annotation(
    Line(points = {{62, -53}, {67, -53}, {67, -55}, {72, -55}, {72, -74}, {80, -74}, {80, -76}, {88, -76}}, color = {0, 0, 127}));
  connect(pressure.ppHtO_atm, electrochemical_simple.ppHtO) annotation(
    Line(points = {{84, 2}, {90, 2}, {90, 48}, {-48, 48}, {-48, 36}}, color = {0, 0, 127}));
  connect(pressure.ppH_atm, electrochemical_simple.ppH) annotation(
    Line(points = {{84, -6}, {94, -6}, {94, 52}, {-37, 52}, {-37, 36}}, color = {0, 0, 127}));
  connect(pressure.ppO_atm, electrochemical_simple.ppO) annotation(
    Line(points = {{84, -16}, {98, -16}, {98, 58}, {-24, 58}, {-24, 36}, {-25, 36}}, color = {0, 0, 127}));
  connect(const.y, electrochemical_simple.Top) annotation(
    Line(points = {{-66, -36}, {-64, -36}, {-64, 14}, {-52, 14}, {-52, 14}}, color = {0, 0, 127}));
protected
  annotation(
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {76, 80}, extent = {{-16, 24}, {16, -24}}, textString = "Pelec"), Text(origin = {78, -47}, extent = {{-12, 13}, {12, -13}}, textString = "nH2"), Text(origin = {-45, 21}, extent = {{-23, 21}, {23, -21}}, textString = "Porder"), Text(origin = {-4, 7}, lineColor = {0, 0, 255}, extent = {{-68, 49}, {80, -77}}, textString = "Electrolyser_simple"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end electrolyser_simple;
