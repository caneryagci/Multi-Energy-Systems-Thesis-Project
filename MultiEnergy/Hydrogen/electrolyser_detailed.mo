within Hydrogen;

model electrolyser_detailed
  Hydrogen.massflow massflow annotation(
    Placement(visible = true, transformation(origin = {44, -32}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Hydrogen.pressure pressure annotation(
    Placement(visible = true, transformation(origin = {58, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Porder annotation(
    Placement(visible = true, transformation(origin = {-88, 62}, extent = {{-18, -18}, {18, 18}}, rotation = 0), iconTransformation(origin = {-72, 68}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pelec annotation(
    Placement(visible = true, transformation(origin = {28, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {118, 66}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput nH2 annotation(
    Placement(visible = true, transformation(origin = {90, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {116, -64}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Hydrogen.thermal thermal annotation(
    Placement(visible = true, transformation(origin = {-38, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Hydrogen.electrochemical electrochemical annotation(
    Placement(visible = true, transformation(origin = {-27, 27}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable T_ambient(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Co_simulation/Tambient_hourly.txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-94, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(massflow.nH, nH2) annotation(
    Line(points = {{64, -30}, {74, -30}, {74, -84}, {90, -84}, {90, -84}}, color = {0, 0, 127}));
  connect(massflow.nH, thermal.nH) annotation(
    Line(points = {{64, -30}, {74, -30}, {74, -84}, {-76, -84}, {-76, -54}, {-54, -54}, {-54, -54}}, color = {0, 0, 127}));
  connect(massflow.nO, thermal.nO) annotation(
    Line(points = {{64, -44}, {68, -44}, {68, -76}, {-64, -76}, {-64, -66}, {-54, -66}, {-54, -66}}, color = {0, 0, 127}));
  connect(Porder, electrochemical.Pord) annotation(
    Line(points = {{-88, 62}, {-60, 62}, {-60, 30}, {-50, 30}, {-50, 30}}, color = {0, 0, 127}));
  connect(thermal.Top, electrochemical.Top) annotation(
    Line(points = {{-16, -38}, {-4, -38}, {-4, -8}, {-76, -8}, {-76, 20}, {-50, 20}, {-50, 20}}, color = {0, 0, 127}));
  connect(thermal.Top, pressure.Top) annotation(
    Line(points = {{-16, -38}, {20, -38}, {20, 48}, {42, 48}, {42, 48}}, color = {0, 0, 127}));
  connect(electrochemical.Icell, massflow.Icell) annotation(
    Line(points = {{-2, 12}, {8, 12}, {8, -22}, {30, -22}, {30, -22}}, color = {0, 0, 127}));
  connect(electrochemical.Wpem, thermal.Wpem) annotation(
    Line(points = {{-2, 20}, {12, 20}, {12, -24}, {-72, -24}, {-72, -44}, {-54, -44}, {-54, -44}}, color = {0, 0, 127}));
  connect(electrochemical.Pout, thermal.Pelec) annotation(
    Line(points = {{-2, 36}, {16, 36}, {16, -18}, {-68, -18}, {-68, -32}, {-54, -32}, {-54, -34}}, color = {0, 0, 127}));
  connect(pressure.ppHtO_atm, electrochemical.ppHtO) annotation(
    Line(points = {{80, 54}, {88, 54}, {88, 70}, {-44, 70}, {-44, 50}, {-44, 50}}, color = {0, 0, 127}));
  connect(pressure.ppH_atm, electrochemical.ppH) annotation(
    Line(points = {{80, 46}, {94, 46}, {94, 62}, {-28, 62}, {-28, 50}, {-30, 50}}, color = {0, 0, 127}));
  connect(pressure.ppO_atm, electrochemical.ppO) annotation(
    Line(points = {{80, 34}, {98, 34}, {98, 66}, {-14, 66}, {-14, 50}, {-16, 50}}, color = {0, 0, 127}));
  connect(electrochemical.Pout, Pelec) annotation(
    Line(points = {{-2, 36}, {6, 36}, {6, 86}, {28, 86}, {28, 86}}, color = {0, 0, 127}));
  connect(T_ambient.y[1], thermal.Tamb) annotation(
    Line(points = {{-82, -90}, {-30, -90}, {-30, -66}, {-30, -66}}, color = {0, 0, 127}));
protected
  annotation(
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-42, 57}, extent = {{-20, 37}, {34, -51}}, textString = "Porder"), Text(origin = {73, 51}, extent = {{-25, 27}, {15, -17}}, textString = "P"), Text(origin = {75, -50}, extent = {{-25, 32}, {13, -24}}, textString = "nH2"), Text(origin = {-6, 11}, lineColor = {0, 0, 255}, extent = {{-68, 49}, {80, -77}}, textString = "Electrolyser_ detailed"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end electrolyser_detailed;
