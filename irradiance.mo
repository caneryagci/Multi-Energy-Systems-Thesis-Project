model irradiance

  Modelica.Blocks.Interfaces.RealInput alfa(min = 0) annotation(
    Placement(visible = true, transformation(origin = {-34, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput beta(min = 0) annotation(
    Placement(visible = true, transformation(origin = {-44, 12}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput B_int annotation(
    Placement(visible = true, transformation(origin = {-44, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  //parameter Real mean = 700;
  //parameter Real standard_deviation = 1;
  //parameter Real alfa = 2;
  //parameter Real beta = 5;
  //parameter Real refIrradiance = 500; //W/m2
  parameter Real lower = 0;
  parameter Real upper = 1201;
  parameter Real IrMax = 1200 "Maximum Irradiance (Ir<=IrMax)";
  parameter Integer n = 300 "Number of intervals";
  final parameter Real dIr = IrMax / n "Velocity increment";
  Real IrDiscrete[n] = array(k * dIr for k in 1:n) "Discrete velocities";
  Real pdf_beta[n] = array((1 / B_int) * ((IrDiscrete[k] - lower) ^ (alfa - 1) * (upper - IrDiscrete[k]) ^ (beta - 1) / (upper - lower) ^ (alfa + beta - 1)) for k in 1:n);
  Real total_Ir[n];
  Real total_prob;
  Modelica.Blocks.Interfaces.RealOutput Irradiance annotation(
    Placement(visible = true, transformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/beta(hourly).txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-78, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/alfa(hourly).txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-78, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable2(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/B_int(hourly).txt", tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-78, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  total_prob = sum(pdf_beta);
  total_Ir = pdf_beta .* IrDiscrete/total_prob;
  Irradiance = sum(total_Ir)*3;
  connect(combiTimeTable1.y[1], alfa) annotation(
    Line(points = {{-66, 40}, {-58, 40}, {-58, 50}, {-34, 50}, {-34, 54}}, color = {0, 0, 127}));
  connect(combiTimeTable.y[1], beta) annotation(
    Line(points = {{-66, 12}, {-36, 12}, {-36, 12}, {-44, 12}}, color = {0, 0, 127}));
  connect(combiTimeTable2.y[1], B_int) annotation(
    Line(points = {{-66, -20}, {-58, -20}, {-58, -50}, {-44, -50}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Text(origin = {-101, 42}, extent = {{-5, 0}, {5, 0}}, textString = "alfa"), Text(origin = {-98, -17}, extent = {{4, 1}, {-4, -1}}, textString = "beta"), Text(origin = {-101, -80}, extent = {{3, 0}, {-3, 0}}, textString = "B_int"), Text(origin = {102, -14}, extent = {{2, -2}, {-2, 2}}, textString = "Irradiance"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)));

end irradiance;
