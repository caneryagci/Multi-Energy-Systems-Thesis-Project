within PV;

model PVFarm3

  parameter Real SystemBase=100 "MVa";
  parameter Real v0=0.99422 "Power flow, node voltage";
  parameter Real anglev0=0.00158 "Power flow, node angle";
  parameter Real p0=0.44884 "Power flow, node active power";
  parameter Real q0=0 "Power flow, node reactive power";
  iPSL.Electrical.Solar.KTH.PFblocks.PVnew PVnew1(nSerialModules = 50)  annotation (Placement(visible=true, transformation(
        origin={-75, -5},
        extent={{-15, -15}, {15, 15}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant Tref(k = 25)  annotation(
    Placement(visible = true, transformation(origin = {-125, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant irradiation(k = 1000)  annotation(
    Placement(visible = true, transformation(origin = {-125, 5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const3(k = v0) annotation(
    Placement(visible = true, transformation(origin = {20, 31.001}, extent = {{-3.999, -3.999}, {3.999, 3.999}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const5(k = 700) annotation(
    Placement(visible = true, transformation(origin = {13.999, 0}, extent = {{-3.999, -3.999}, {3.999, 3.999}}, rotation = 0)));
  iPSL.Electrical.Solar.KTH.PFblocks.Controller controller1(v0 = v0, xd = xd, xq = xq) annotation(
    Placement(visible = true, transformation(origin = {64.5368, 14.3218}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = 0)));
  PV.staticgenerator staticgenerator(P_0 = 0.4)  annotation(
    Placement(visible = true, transformation(origin = {110, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PQbus annotation(
    Placement(visible = true, transformation(origin = {10.5, -81.5}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer(Sb = 100, Sn = 500, V_b = 12500, Vn = 12500, fn = 50, kT = 12500 / 750) annotation(
    Placement(visible = true, transformation(origin = {43.5, -81.5}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 0.2, offset = 1, startTime = 50) annotation(
    Placement(visible = true, transformation(origin = {-110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PVbus annotation(
    Placement(visible = true, transformation(origin = {71.5, -81.5}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus21(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-58.5, -71.5}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = 0)));
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
equation
  connect(Tref.y, PVnew1.T) annotation(
    Line(points = {{-114, -30}, {-105, -30}, {-105, -15.5}, {-93, -15.5}}, color = {0, 0, 127}));
  connect(irradiation.y, PVnew1.E) annotation(
    Line(points = {{-114, 5}, {-105, 5}, {-105, -5}, {-93, -5}}, color = {0, 0, 127}));
  connect(Tref.y, PVnew1.T) annotation(
    Line(points = {{-114, -30}, {-105, -30}, {-105, -15.5}, {-93, -15.5}}, color = {0, 0, 127}));
  connect(const3.y, controller1.Vacref) annotation(
    Line(points = {{24, 31}, {30, 31}, {30, 17}, {50, 17}}, color = {0, 0, 127}));
  connect(controller1.Vdcref, const5.y) annotation(
    Line(points = {{50, 4}, {36.3979, 4}, {36.3979, 0}, {18, 0}}, color = {0, 0, 127}));
  connect(controller1.id_ref, staticgenerator.idref) annotation(
    Line(points = {{80, 20}, {109, 20}, {109, -1}}, color = {0, 0, 127}));
  connect(controller1.iq_ref, staticgenerator.iqref) annotation(
    Line(points = {{80, 10}, {103, 10}, {103, -1}}, color = {0, 0, 127}));
  connect(PVbus.p, twoWindingTransformer.n) annotation(
    Line(points = {{71.5, -81.5}, {57, -81.5}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.p, PQbus.p) annotation(
    Line(points = {{30, -81.5}, {10.5, -81.5}}, color = {0, 0, 255}));
  connect(PQbus.p, infiniteBus21.p) annotation(
    Line(points = {{10.5, -81.5}, {-18, -81.5}, {-18, -71.5}, {-45, -71.5}}, color = {0, 0, 255}));
  connect(step.y, infiniteBus21.V) annotation(
    Line(points = {{-99, -70}, {-84, -70}, {-84, -71.5}, {-72, -71.5}}, color = {0, 0, 127}));
  connect(staticgenerator.p, PVbus.p) annotation(
    Line(points = {{120, -10}, {135, -10}, {135, -80}, {70, -80}, {70, -80}}, color = {0, 0, 255}));
  connect(staticgenerator.Vt, controller1.uac) annotation(
    Line(points = {{120, -5}, {130, -5}, {130, 40}, {35, 40}, {35, 25}, {50, 25}, {50, 25}}, color = {0, 0, 127}));
  annotation (
    Icon(coordinateSystem(
        
        initialScale=0.1,
        grid={10,10}), graphics={Rectangle(fillColor = {255, 255, 255}, extent = {{-100, -100}, {100, 100}}), Text(origin = {15, 0}, lineColor = {0, 0, 255}, extent = {{-65, 70}, {45, -60}}, textString = "PV Farm")}),
    Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, initialScale = 0.1, grid = {5, 5}), graphics = {Text(origin = {-60, -50}, lineColor = {0, 0, 255}, extent = {{-10, 5}, {10, -5}}, textString = "Infinite Bus")}),
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

end PVFarm3;
