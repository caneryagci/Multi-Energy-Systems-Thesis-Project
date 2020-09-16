within Hydrogen;

model Controller
  parameter Real S_b = 100 "System base power (MVA)" annotation(
    Dialog(group = "Power flow data"));
  parameter Real Sn = 100 "Nominal power (MVA)";
  // parameter Real V_0 = 1.00018548610126 "Voltage magnitude (pu)" annotation(Dialog(group = "Power flow data"));
  // parameter Real angle_0 = -0.0000253046024029618 "Voltage angle (deg)" annotation(Dialog(group = "Power flow data"));
  // parameter Real P_0 = 0.4 "Active power (pu)" annotation(Dialog(group = "Power flow data"));
  parameter Real Q_0 = 0.3 "Reactive power (pu)" annotation(
    Dialog(group = "Power flow data"));
  //parameter Real vref = 1.0002 "Voltage reference (pu)";
  parameter Real Td = 0.15 "d-axis inverter time constant (s)";
  parameter Real Tq = 0.15 "q-axis inverter time constant (s)";
  parameter Real Ki = 50.9005 "Integral gain of the voltage controller";
  parameter Real Kp = 0.0868 "Proportional gain of the voltage controller";
  Real v "Bus voltage magnitude (pu)";
  //Real anglev "Bus voltage angle (deg.)";
  //Real idref1(start = idref) "d-axis current setpoint";
  //Real iqref1(start = iqref) "q-axis current setpoint";
  //Real id "d-axis current (pu)";
  //Real iq "q-axis current (pu)";
  
   //Real P "Active power (pu)";
  //Real Q "Reactive power (pu)";
  Modelica.Blocks.Interfaces.RealInput angle_0 annotation(
    Placement(visible = true, transformation(origin = {-145, -15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, -20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Pref annotation(
    Placement(visible = true, transformation(origin = {-150, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput idref(start=0.03) annotation(
    Placement(visible = true, transformation(origin = {160, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput iqref(start=0.04) annotation(
    Placement(visible = true, transformation(origin = {160, -45}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -55}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vref annotation(
    Placement(visible = true, transformation(origin = {-145, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput vd annotation(
    Placement(visible = true, transformation(origin = {-125, 45}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput vq annotation(
    Placement(visible = true, transformation(origin = {-130, 25}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {30, 80}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
protected
  parameter Real CoB = Sn / S_b;
  //parameter Real Pref = P_0 * CoB;
  //parameter Real vd0 = -V_0 * sin(angle_0) "Initialitation";
  //parameter Real vq0 = V_0 * cos(angle_0) "Initialitation";
  //parameter Real idref = (vq0 * Q_0 * CoB + Pref * vd0) / (vq0 ^ 2 + vd0 ^ 2) "Initialitation";
  //parameter Real iqref = ((-vd0 * Q_0 * CoB) + Pref * vq0) / (vq0 ^ 2 + vd0 ^ 2) "Initialitation";
  Real x(start = Q_0 * CoB);
  Real Qref(start = Q_0 * CoB);
equation
//vd=-v * sin(angle_0);
//vq= v * cos(angle_0);
  v = sqrt(vq ^ 2 + vd ^ 2);
  der(x) = Ki * (vref - v);
  Qref = x + Kp * (vref - v);
  idref = (vq * Qref + Pref * CoB * vd) / (vq ^ 2 + vd ^ 2);
  iqref = ((-vd * Qref) + Pref * CoB * vq) / (vq ^ 2 + vd ^ 2);
  //der(id) = (idref - id) / Td;
  //der(iq) = (iqref - iq) / Tq;
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(fillColor = {255, 255, 255}, extent = {{-100, -100}, {100, 100}}), Text(origin = {0, 15.3102}, fillPattern = FillPattern.Solid, extent = {{-31.415, -20.0667}, {31.415, 20.0667}}, textString = "%name", fontName = "Arial")}),
    Diagram(coordinateSystem(extent = {{-148.5, -105.0}, {148.5, 105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})),
    Documentation(info = "<html>
<table cellspacing=\"1\" cellpadding=\"1\" border=\"1\"><tr>
<td align=center  width=50%><p>Development level</p></td>
<td align=center width=25% bgcolor=yellow><p> 2 </p></td>
</tr> 
</table> 
<p></p>   
<table cellspacing=\"1\" cellpadding=\"1\" border=\"1\">
<tr>
<td><p>Reference</p></td>
<td><p>Constant PV Generator, Solar Photo-Voltaic Generator, PSAT Manual 2.1.8</p></td>
</tr>
<tr>
<td><p>Last update</p></td>
<td>September 2015</td>
</tr>
<tr>
<td><p>Author</p></td>
<td><p>Joan Russinol, SmarTS Lab, KTH Royal Institute of Technology</p></td>
</tr>
<tr>
<td><p>Contact</p></td>
<td><p><a href=\"mailto:luigiv@kth.se\">luigiv@kth.se</a></p></td>
</tr>
</table>
</html>", revisions = "<html>
<!--DISCLAIMER-->
<p>Copyright 2015-2016 RTE (France), SmarTS Lab (Sweden), AIA (Spain) and DTU (Denmark)</p>
<ul>
<li>RTE: <a href=\"http://www.rte-france.com\">http://www.rte-france.com</a></li>
<li>SmarTS Lab, research group at KTH: <a href=\"https://www.kth.se/en\">https://www.kth.se/en</a></li>
<li>AIA: <a href=\"http://www.aia.es/en/energy\"> http://www.aia.es/en/energy</a></li>
<li>DTU: <a href=\"http://www.dtu.dk/english\"> http://www.dtu.dk/english</a></li>
</ul>
<p>The authors can be contacted by email: <a href=\"mailto:info@itesla-ipsl.org\">info@itesla-ipsl.org</a></p>

<p>This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. </p>
<p>If a copy of the MPL was not distributed with this file, You can obtain one at <a href=\"http://mozilla.org/MPL/2.0/\"> http://mozilla.org/MPL/2.0</a>.</p>
</html>"));
end Controller;
