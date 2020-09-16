within Hydrogen;

model Power2Gas_3

  parameter Real SystemBase=100 "MVa";
  /*parameter Real v0=0.99422 "Power flow, node voltage";
  parameter Real anglev0=0.00158 "Power flow, node angle";
  parameter Real p0=0.44884 "Power flow, node active power";
  parameter Real q0=0 "Power flow, node reactive power";
  */
  Hydrogen.Electrolyser3 electrolyser3 annotation(
    Placement(visible = true, transformation(origin = {-54, 10}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 60000) annotation(
    Placement(visible = true, transformation(origin = {-168, -6}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Hydrogen.Storage storage annotation(
    Placement(visible = true, transformation(origin = {-122, 14}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  iPSL.Electrical.SystemBase sysData annotation(
    Placement(visible = true, transformation(origin = {154, 80}, extent = {{-10, -10}, {14, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 10, height = 0.3, offset = 0.5, startTime = 30)  annotation(
    Placement(visible = true, transformation(origin = {-168, 30}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  /*
  protected
    parameter Real vr=v0*cos(anglev0);
    parameter Real vi=v0*sin(anglev0);
    parameter Real A=vi*cos(anglev0) - vr*sin(anglev0);
    parameter Real B=vr*cos(anglev0) + vi*sin(anglev0);
    parameter Real idref0=(p0*B + q0*A)/(A^2 + B^2);
    parameter Real iqref0=((-q0*B) + p0*A)/(A^2 + B^2) "

                                  parameter Real vd0=-v0*sin(anglev0) ;
                                  parameter Real vq0=v0*cos(anglev0) ;
                                  parameter Real iqref0=2*(vq0*q0 + p0*vd0)/(vq0^2 + vd0^2) ;
                                  parameter Real idref0=2*(-vd0*q0 + p0*vq0)/(vq0^2 + vd0^2) ";
    parameter Real xq=2*iqref0*1.02;
    parameter Real xd=2*idref0*1.02;
  */
  iPSL.Electrical.Buses.Bus bus annotation(
    Placement(visible = true, transformation(origin = {30, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {86, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus2(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {10, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer1(Sn = 100, V_b = 12500, Vn = 12500, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {58, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression2(y = -0.0000253046024029618) annotation(
    Placement(visible = true, transformation(origin = {19, 5}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 0.03, offset = 1.0, startTime = 80)  annotation(
    Placement(visible = true, transformation(origin = {-66, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.staticgen staticgen annotation(
    Placement(visible = true, transformation(origin = {78, 6}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
equation
  connect(const.y, storage.nH2_o) annotation(
    Line(points = {{-159, -6}, {-150.5, -6}, {-150.5, 4}, {-140, 4}}, color = {0, 0, 127}));
  connect(storage.nH2_i, electrolyser3.nH) annotation(
    Line(points = {{-100, 14}, {-90, 14}, {-90, 27}, {-76, 27}}, color = {0, 0, 127}));
  connect(ramp.y, storage.p_tank_bar) annotation(
    Line(points = {{-159, 30}, {-152, 30}, {-152, 22}, {-140, 22}}, color = {0, 0, 127}));
  connect(twoWindingTransformer1.p, bus.p) annotation(
    Line(points = {{47, -66}, {30, -66}}, color = {0, 0, 255}));
  connect(bus1.p, twoWindingTransformer1.n) annotation(
    Line(points = {{86, -66}, {69, -66}}, color = {0, 0, 255}));
  connect(bus.p, infiniteBus2.p) annotation(
    Line(points = {{30, -66}, {24.5, -66}, {24.5, -68}, {21, -68}}, color = {0, 0, 255}));
  connect(step.y, infiniteBus2.V) annotation(
    Line(points = {{-54, -62}, {-28, -62}, {-28, -68}, {-1, -68}}, color = {0, 0, 127}));
  connect(realExpression2.y, staticgen.angle_0) annotation(
    Line(points = {{27, 5}, {34, 5}, {34, 6}, {65, 6}}, color = {0, 0, 127}));
  connect(step.y, staticgen.V_0) annotation(
    Line(points = {{-54, -62}, {-16, -62}, {-16, 18}, {65, 18}}, color = {0, 0, 127}));
  connect(electrolyser3.Pdc_mw, staticgen.P_0) annotation(
    Line(points = {{-27, 30}, {48, 30}, {48, -5}, {65, -5}}, color = {0, 0, 127}));
  connect(staticgen.p, bus1.p) annotation(
    Line(points = {{96, 6}, {100, 6}, {100, -66}, {86, -66}}, color = {0, 0, 255}));
  annotation (
    Icon(coordinateSystem(
        
        extent = {{-300, -300}, {300, 300}}, initialScale = 0.1), graphics={Text(origin = {-72.3502, 50}, fillPattern = FillPattern.Solid, extent = {{-17.6498, -10}, {17.6498, 10}}, textString = "E", fontName = "Arial"), Text(origin = {-72.3502, -50}, fillPattern = FillPattern.Solid, extent = {{-17.6498, -10}, {17.6498, 10}}, textString = "T", fontName = "Arial"), Rectangle(fillColor = {255, 255, 255}, extent = {{-100, -100}, {100, 100}})}),
    Diagram(coordinateSystem(extent = {{-300, -300}, {300, 300}}, initialScale = 0.1), graphics = {Text(origin = {9, -55}, lineColor = {0, 0, 255}, extent = {{-11, 1}, {11, -1}}, textString = "infinite bus")}),
    Documentation(info="<html>
<table cellspacing=\"1\" cellpadding=\"1\" border=\"1\"><tr>
<td align=center  width=50%><p>Development level</p></td>
<td align=center width=25% bgcolor=yellow><p> 2 </p></td>
</tr> 
</table> 
<p></p>     
<table cellspacing=\"1\" cellpadding=\"1\" border=\"1\">
<tr>
<td><p>Reference</p></td>
<td><p>TBD</p></td>
</tr>
<tr>
<td><p>Last update</p></td>
<td>TBD</td>
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
</html>", revisions="<html>
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

end Power2Gas_3;
