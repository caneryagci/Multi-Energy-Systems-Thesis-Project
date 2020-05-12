within Hydrogen;

model Static_generator "Constant PQ Generator, Solar Photo-Voltaic Generator"
  iPSL.Connectors.PwPin p annotation(
    Placement(visible = true, transformation(origin = {145, 2.7992}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real S_b = 100 "System base power (MVA)" annotation(
    Dialog(group = "Power flow data"));
  parameter Real Sn = 10 "Nominal power (MVA)";
  parameter Real V_0 = 1.00018548610126 "Voltage magnitude (pu) from PF" annotation(
    Dialog(group = "Power flow data"));
  parameter Real angle_0 = -0.0000253046024029618 "Voltage angle (deg) from Power Flow" annotation(
    Dialog(group = "Power flow data"));
  parameter Real P_0 = 0.1 "Active power (pu) from PF" annotation(
    Dialog(group = "Power flow data"));
  parameter Real Q_0 = 0.001 "Reactive power (pu) from Power Flow" annotation(
    Dialog(group = "Power flow data"));
  parameter Real Td = 15 "d-axis inverter time constant (s)";
  parameter Real Tq = 15 "q-axis inverter time constant (s)";
  //Real v "Bus voltage magnitude (pu)";
  Real anglev "Bus voltage angle (deg)";
  Real id "d-axis current (pu)";
  Real iq "q-axis current (pu)";
  Real vd(start = vd0) "d-axis voltage (pu)";
  Real vq(start = vq0) "q-axis voltage (pu)";
  Real P(start = Pref) "Active power (pu)";
  Real Q(start = Qref) "Reactive power (pu)";
  //Real idref1(start = idref) "d-axis current setpoint";
  //Real iqref1(start = iqref) "q-axis current setpoint";
  parameter Real CoB = Sn / S_b;
  parameter Real Pref = P_0 * CoB "Initialitation";
  parameter Real Qref = Q_0 * CoB "Initialitation";
  parameter Real vd0 = -V_0 * sin(angle_0) "Initialitation";
  parameter Real vq0 = V_0 * cos(angle_0) "Initialitation";
  //parameter Real idref = (vq0 * Qref + Pref * vd0) / (vq0 ^ 2 + vd0 ^ 2) "Initialitation";
  //parameter Real iqref = ((-vd0 * Qref) + Pref * vq0) / (vq0 ^ 2 + vd0 ^ 2) "Initialitation";
  Modelica.Blocks.Interfaces.RealInput idref annotation(
    Placement(visible = true, transformation(origin = {-150, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput iqref annotation(
    Placement(visible = true, transformation(origin = {-150, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput v annotation(
    Placement(visible = true, transformation(origin = {150, 75}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  P = vd * id + vq * iq;
  Q = vq * id - vd * iq;
  //idref1 = (vq * Qref + Pref * vd) / (vq ^ 2 + vd ^ 2);
  //iqref1 = ((-vd * Qref) + Pref * vq) / (vq ^ 2 + vd ^ 2);
  der(id) = (idref - id) / Td;
  der(iq) = (iqref - iq) / Tq;
  v = sqrt(p.vr ^ 2 + p.vi ^ 2);
  anglev = atan2(p.vi, p.vr);
  p.ir = -iq "change of sign due to the fact than in modelica when entering is + and in this case is going out";
  p.ii = id "change of sign due to the fact than in modelica when entering is + and in this case is going out";
  p.vr = vq;
  p.vi = -vd;
  annotation(
    Icon(coordinateSystem( initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(fillColor = {255, 255, 255}, extent = {{-100, -100}, {100, 100}}), Text(origin = {0, 15.3102}, fillPattern = FillPattern.Solid, extent = {{-31.415, -20.0667}, {31.415, 20.0667}}, textString = "%name", fontName = "Arial"), Text(origin = {110, 90}, extent = {{-10, 0}, {10, -10}}, textString = "Vac"), Text(origin = {-125, 85}, extent = {{-5, 5}, {5, -5}}, textString = "idref"), Text(origin = {-115, 15}, extent = {{-5, 5}, {5, -5}}, textString = "iqref")}),
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
<td><p>Constant PQ Generator, Solar Photo-Voltaic Generator, PSAT Manual 2.1.8</p></td>
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
end Static_generator;
