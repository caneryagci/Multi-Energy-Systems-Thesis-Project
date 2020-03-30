model WF
extends PowerSystems.Generic.Ports.PartialSource(
    final potentialReference=false, final definiteReference=false);
  parameter Boolean cut_out = false
  "stop producing energy as wind exceeds cut-out speed of 20-25 m/s"
    annotation(Dialog(group="Features"));
  PowerSystems.Generic.PrescribedPowerSource mills(
    redeclare package PhaseSystem = PhaseSystem,
    definiteReference = definiteReference)
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.Trapezoid disturbance(
    rising=120,
    period=86400,
    offset=1,
    width=1800,
    falling=1800,
    startTime=20040,
    amplitude=if cut_out then -1 else 0)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
Modelica.Blocks.Math.Gain MW2W(k=1e6)
  annotation (Placement(transformation(extent={{14,-6},{26,6}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(fileName = "C:/Users/Caner/Desktop/Modelica Libraries/PowerSystems-master/PowerSystems-master/PowerSystems/Examples/PowerWorld/Resources/LoadData.txt", table = fill(0.0, 0, 10), tableName = "tab", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-76, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(combiTimeTable1.y[1], product.u2) annotation(
    Line(points = {{-64, -4}, {-24, -4}, {-24, -6}, {-22, -6}}, color = {0, 0, 127}));
  connect(disturbance.y, product.u1) annotation(
    Line(points = {{-39, 30}, {-30, 30}, {-30, 6}, {-22, 6}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(mills.terminal, terminal) annotation(
    Line(points = {{60, 0}, {100, 0}}, color = {0, 120, 120}, smooth = Smooth.None));
  connect(product.y, MW2W.u) annotation(
    Line(points = {{1, 0}, {12.8, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(MW2W.y, mills.P) annotation(
    Line(points = {{26.6, 0}, {39, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-48, 24}, {-32, -100}}, lineColor = {85, 85, 255}, fillColor = {85, 85, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{-44, 24}, {-98, 22}, {-46, 38}, {-28, 88}, {-32, 36}, {0, -6}, {-44, 24}}, lineColor = {85, 85, 255}, smooth = Smooth.None, fillColor = {85, 85, 255}, fillPattern = FillPattern.Solid), Rectangle(extent = {{32, 24}, {48, -100}}, lineColor = {85, 85, 255}, fillColor = {85, 85, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{36, 24}, {-12, 20}, {32, 38}, {54, 86}, {48, 36}, {82, -2}, {36, 24}}, lineColor = {85, 85, 255}, smooth = Smooth.None, fillColor = {85, 85, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-100, -100}, {100, -140}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, textString = "%name%")}),
    uses(Modelica(version = "3.2.3")));

end WF;
