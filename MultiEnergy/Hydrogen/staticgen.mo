within Hydrogen;

model staticgen
  iPSL.Connectors.PwPin p annotation(Placement(visible = true, transformation(origin = {55, 22.7992}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real S_b = 50 "System base power (MVA)" annotation(Dialog(group = "Power flow data"));
  parameter Real Sn = 50 "Nominal power (MVA)";
  /*parameter Real V_0 = 1.00018548610126 "Voltage magnitude (pu)" annotation(Dialog(group = "Power flow data"));
  parameter Real angle_0 = -0.0000253046024029618 "Voltage angle (deg)" annotation(Dialog(group = "Power flow data"));
  parameter Real P_0 = 0.4 "Active power (pu)" annotation(Dialog(group = "Power flow data"));
  */
  parameter Real Q_0 = 0.3 "Reactive power (pu)" annotation(Dialog(group = "Power flow data"));
  
  parameter Real Td = 15 "d-axis inverter time constant (s)";
  parameter Real Tq = 15 "q-axis inverter time constant (s)";
  Real v "Bus voltage magnitude (pu)";
  Real anglev "Bus voltage angle (deg)";
  Real id(start = 0.03) "d-axis current (pu)";
  Real iq(start = 0.04) "q-axis current (pu)";
  Real vd(start=-0.004) "d-axis voltage (pu)";
  Real vq(start=1) "q-axis voltage (pu)";
  Real P "Active power (pu)";
  Real Pref;
  
  Real Q(start = Qref) "Reactive power (pu)";
  Real idref1(start = 0.03) "d-axis current setpoint";
  Real iqref1(start = 0.04) "q-axis current setpoint";
  Modelica.Blocks.Interfaces.RealInput V_0 annotation(
    Placement(visible = true, transformation(origin = {-140, 25}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 75}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput angle_0 annotation(
    Placement(visible = true, transformation(origin = {-140, -10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput P_0 annotation(
    Placement(visible = true, transformation(origin = {-140, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pgen annotation(
    Placement(visible = true, transformation(origin = {155, 35}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {115, -35}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Qgen annotation(
    Placement(visible = true, transformation(origin = {145, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {115, -75}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
protected
  parameter Real CoB = Sn / S_b;
  //parameter Real Pref = P_0 * CoB "Initialitation";
  parameter Real Qref = Q_0 * CoB "Initialitation";
  //parameter Real vd0 = -V_0 * sin(angle_0) "Initialitation";
  //parameter Real vq0 = V_0 * cos(angle_0) "Initialitation";
  //parameter Real idref = (vq0 * Qref + Pref * vd0) / (vq0 ^ 2 + vd0 ^ 2) "Initialitation";
  //parameter Real iqref = ((-vd0 * Qref) + Pref * vq0) / (vq0 ^ 2 + vd0 ^ 2) "Initialitation";
equation
  Pref = P_0 * CoB "Initialitation";
  P = vd * id + vq * iq;
  Q = vq * id - vd * iq;
  idref1 = (vq * Qref + Pref * vd) / (vq ^ 2 + vd ^ 2);
  iqref1 = ((-vd * Qref) + Pref * vq) / (vq ^ 2 + vd ^ 2);
  der(id) = (idref1 - id) / Td;
  der(iq) = (iqref1 - iq) / Tq;
  v = sqrt(p.vr ^ 2 + p.vi ^ 2);
  anglev = atan2(p.vi, p.vr);
  p.ir = -iq "change of sign due to the fact than in modelica when entering is + and in this case is going out";
  p.ii = id "change of sign due to the fact than in modelica when entering is + and in this case is going out";
  p.vr = vq;
  p.vi = -vd;
  Pgen=P*50;
  Qgen=Q;
  annotation(Icon(coordinateSystem( initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(fillColor = {255, 255, 255}, extent = {{-100, -100}, {100, 100}}), Text(origin = {-20, -4.69}, lineColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-31.42, -20.07}, {81.42, 70.07}}, textString = "Staticgen", fontName = "Arial"), Text(origin = {-45, 70}, extent = {{-15, 20}, {25, -30}}, textString = "V"), Text(origin = {-30, -20}, extent = {{-40, 40}, {30, -40}}, textString = "Vangle"), Text(origin = {-25, -65}, extent = {{25, -35}, {-35, 35}}, textString = "Pord"), Text(origin = {85, -45}, extent = {{-45, 35}, {5, -5}}, textString = "PLoad"), Text(origin = {-30, 20},extent = {{70, -70}, {120, -110}}, textString = "QLoad")}), Diagram(coordinateSystem(extent = {{-148.5, -105.0}, {148.5, 105.0}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})), Documentation(info = "<html>
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


end staticgen;
