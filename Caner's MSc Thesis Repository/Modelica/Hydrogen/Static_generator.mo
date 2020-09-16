within Hydrogen;

model Static_generator "Constant PQ Generator, Solar Photo-Voltaic Generator"
  iPSL.Connectors.PwPin p annotation(
    Placement(visible = true, transformation(origin = {145, 2.7992}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real S_b = 100 "System base power (MVA)" annotation(
    Dialog(group = "Power flow data"));
  parameter Real Sn = 100 "Nominal power (MVA)";
  /*parameter Real V_0 = 1.0 "Voltage magnitude (pu) from PF" annotation(
    Dialog(group = "Power flow data"));
  parameter Real angle_0 = -0.0000253046024029618 "Voltage angle (deg) from Power Flow" annotation(
    Dialog(group = "Power flow data"));
  
  parameter Real P_0 = 0.1 "Active power (pu) from PF" annotation(
    Dialog(group = "Power flow data"));
  parameter Real Q_0 = 0.001 "Reactive power (pu) from Power Flow" annotation(
    Dialog(group = "Power flow data"));
  */
  parameter Real Td = 15 "d-axis inverter time constant (s)";
  parameter Real Tq = 15 "q-axis inverter time constant (s)";
  Real v "Bus voltage magnitude (pu)";
  Real anglev "Bus voltage angle (deg)";
  Real id "d-axis current (pu)";
  Real iq "q-axis current (pu)";
  Real vd "d-axis voltage (pu)";
  Real vq "q-axis voltage (pu)";
  Real P "Active power (pu)";
  Real Q "Reactive power (pu)";
  Real idref1 "d-axis current setpoint";
  Real iqref1 "q-axis current setpoint";
  parameter Real CoB = Sn / S_b;
  //Real Pref  "Initialitation";
  //Real Qref "Initialitation";
  //Real vd0  "Initialitation";
  //Real vq0  "Initialitation";
  Modelica.Blocks.Interfaces.RealInput idref annotation(
    Placement(visible = true, transformation(origin = {-150, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-5, 85}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput iqref annotation(
    Placement(visible = true, transformation(origin = {-150, 55}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-65, 85}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  /*  
    Modelica.Blocks.Interfaces.RealInput V_0 annotation(
      Placement(visible = true, transformation(origin = {-150, 5}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 35}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput angle_0 annotation(
      Placement(visible = true, transformation(origin = {-150, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput P_0(start=0.1) annotation(
      Placement(visible = true, transformation(origin = {-150, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Q_0 annotation(
      Placement(visible = true, transformation(origin = {-150, -90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  */
  Modelica.Blocks.Interfaces.RealOutput Pac annotation(
    Placement(visible = true, transformation(origin = {150, 55}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Vt annotation(
    Placement(visible = true, transformation(origin = {150, 75}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vd1 annotation(
    Placement(visible = true, transformation(origin = {150, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput vq1 annotation(
    Placement(visible = true, transformation(origin = {150, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput angle annotation(
    Placement(visible = true, transformation(origin = {95, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {35, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  //Pref = P_0 * CoB "Initialitation";
  //Qref = Q_0 * CoB "Initialitation";
  //vd0 = -V_0 * sin(angle_0) "Initialitation";
  //vq0 = V_0 * cos(angle_0) "Initialitation";
  
  P = vd * id + vq * iq;
  Pac=P;
  Q = vq * id - vd * iq;
//idref1 = (vq * Qref + Pref * vd) / (vq ^ 2 + vd ^ 2);
//iqref1 = ((-vd * Qref) + Pref * vq) / (vq ^ 2 + vd ^ 2);
  idref1=idref;
  iqref1=iqref;
  der(id) = (idref1 - id) / Td;
  der(iq) = (iqref1 - iq) / Tq;
  v = sqrt(p.vr ^ 2 + p.vi ^ 2);
  Vt=v;
  anglev = atan2(p.vi, p.vr);
  p.ir = -iq "change of sign due to the fact than in modelica when entering is + and in this case is going out";
  p.ii = id "change of sign due to the fact than in modelica when entering is + and in this case is going out";
  p.vr = vq;
  p.vi = -vd;
  angle=anglev;
  vd1 = vd;
  vq1 = vq;
  annotation(
    Icon(coordinateSystem( initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(fillColor = {255, 255, 255}, extent = {{-100, -100}, {100, 100}}), Text(origin = {20, 5.31}, lineColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-31.42, -20.07}, {31.42, 20.07}}, textString = "%name", fontName = "Arial"), Text(origin = {100, 70}, lineColor = {0, 0, 255}, extent = {{-50, 20}, {10, -10}}, textString = "Vac"), Text(origin = {-5, 75}, lineColor = {0, 0, 255}, extent = {{-5, 5}, {45, -35}}, textString = "idref"), Text(origin = {-65, 65}, lineColor = {0, 0, 255}, extent = {{-5, 5}, {35, -25}}, textString = "iqref"), Text(origin = {-5,-75}, lineColor = {0, 0, 255}, extent = {{-5, 5}, {55, -35}}, textString = "angle_0"), Text(origin = {50, 25}, lineColor = {0, 0, 255}, extent = {{0, -5}, {40, 35}}, textString = "P_ac"), Text(origin = {-85, -45}, lineColor = {0, 0, 255}, extent = {{-5, 5}, {55, -25}}, textString = "Q_0")}),
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
