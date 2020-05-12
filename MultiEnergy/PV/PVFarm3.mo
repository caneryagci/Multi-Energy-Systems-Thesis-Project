within PV;

model PVFarm3

  parameter Real SystemBase=100 "MVa";
  parameter Real v0=0.99422 "Power flow, node voltage";
  parameter Real anglev0=0.00158 "Power flow, node angle";
  parameter Real p0=0.44884 "Power flow, node active power";
  parameter Real q0=0 "Power flow, node reactive power";
  iPSL.Electrical.Solar.KTH.PFblocks.PVnew PVnew1 annotation (Placement(visible=true, transformation(
        origin={-92.5, -2.5},
        extent={{-12.5, -12.5}, {12.5, 12.5}},
        rotation=0)));
  iPSL.Electrical.Solar.KTH.PFblocks.DCBusBar DCBusBar1(Udc0 = 700)  annotation (Placement(visible=true, transformation(
        origin={-12.3692,15.0},
        extent={{-10.0,-10.0},{10.0,10.0}},
        rotation=0)));
  iPSL.Electrical.Solar.KTH.PFblocks.Staticgenerator staticgenerator1(
    v0=v0,
    anglev0=anglev0,
    p0=p0,
    q0=q0) annotation (Placement(visible=true, transformation(
        origin={110, 5},
        extent={{-10, -10}, {10, 10}},
        rotation=0)));
  Modelica.Blocks.Math.Gain gain1(k=1) annotation (Placement(visible=true, transformation(
        origin={35.0,-28.2447},
        extent={{-10.0,-10.0},{10.0,10.0}},
        rotation=-180)));
  Modelica.Blocks.Sources.Constant const3(k = v0) annotation(
    Placement(visible = true, transformation(origin = {20, 26.001}, extent = {{-3.999, -3.999}, {3.999, 3.999}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const5(k = 575) annotation(
    Placement(visible = true, transformation(origin = {33.999, -5}, extent = {{-3.999, -3.999}, {3.999, 3.999}}, rotation = 0)));
  iPSL.Electrical.Solar.KTH.PFblocks.Controller controller1(v0 = v0, xd = xd, xq = xq) annotation(
    Placement(visible = true, transformation(origin = {67.0368, 11.8218}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 600)  annotation(
    Placement(visible = true, transformation(origin = {-130, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 40)  annotation(
    Placement(visible = true, transformation(origin = {-135, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant PCC_voltage(k = 1.01) annotation(
    Placement(visible = true, transformation(origin = {-81, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PQbus annotation(
    Placement(visible = true, transformation(origin = {-17, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.InfiniteBus2 infiniteBus21(angle = 0) annotation(
    Placement(visible = true, transformation(origin = {-51, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Branches.PSAT.TwoWindingTransformer twoWindingTransformer(Sn = 500, V_b = 12500, Vn = 12500, kT = 12500 / 575) annotation(
    Placement(visible = true, transformation(origin = {11, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  iPSL.Electrical.Buses.Bus PVbus annotation(
    Placement(visible = true, transformation(origin = {39, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
  connect(gain1.y, DCBusBar1.Pac) annotation(
    Line(visible = true, origin = {-25.8892, 0.9021}, points = {{49.8892, -29.1468}, {-26.4646, -29.1468}, {-26.4646, 19.0979}, {1.52, 19.0979}, {1.52, 20.0979}}, color = {0, 0, 127}));
  connect(staticgenerator1.P, gain1.u) annotation(
    Line(points = {{121, -2.5213}, {125, -2.5213}, {125, -30}, {47, -30}, {47, -28.2447}}, color = {0, 0, 127}));
  connect(PVnew1.Udc, DCBusBar1.Vdc) annotation(
    Line(points = {{-107.5, 6}, {-107.5, 40}, {3.3777, 40}, {3.3777, 15}, {-1.3692, 15}}, color = {0, 0, 127}));
  connect(PVnew1.Iarray, DCBusBar1.Ipv) annotation(
    Line(points = {{-79, -2.5}, {-75, -2.5}, {-75, 12}, {-24.3692, 12}}, color = {0, 0, 127}));
  connect(const3.y, controller1.Vacref) annotation(
    Line(points = {{24.3989, 26.001}, {52.0368, 26.001}, {52.0368, 13.8218}, {55.0368, 13.8218}}, color = {0, 0, 127}));
  connect(controller1.Vdcref, const5.y) annotation(
    Line(points = {{55.0368, 3.8218}, {41.3979, 3.8218}, {41.3979, -5}, {38.3979, -5}}, color = {0, 0, 127}));
  connect(staticgenerator1.v, controller1.uac) annotation(
    Line(points = {{121, 12}, {125, 12}, {125, 41.5396}, {55.0368, 41.5396}, {55.0368, 18.8218}}, color = {0, 0, 127}));
  connect(controller1.id_ref, staticgenerator1.id_ref) annotation(
    Line(points = {{78.0368, 15.8218}, {95, 15.8218}, {95, 12}, {98, 12}}, color = {0, 0, 127}));
  connect(staticgenerator1.iq_ref, controller1.iq_ref) annotation(
    Line(points = {{98, 7}, {81.0368, 7}, {81.0368, 6.99457}, {78.0368, 6.99457}}, color = {0, 0, 127}));
  connect(DCBusBar1.Vdc, controller1.udc) annotation(
    Line(points = {{-1.3692, 15}, {22.5178, 15}, {22.5178, 10}, {55.0368, 10}, {55.0368, 8.8218}}, color = {0, 0, 127}));
  connect(const.y, PVnew1.E) annotation(
    Line(points = {{-120, 0}, {-115, 0}, {-115, -2.5}, {-107.5, -2.5}}, color = {0, 0, 127}));
  connect(const1.y, PVnew1.T) annotation(
    Line(points = {{-124, -30}, {-115, -30}, {-115, -11}, {-107.5, -11}}, color = {0, 0, 127}));
  connect(PCC_voltage.y, infiniteBus21.V) annotation(
    Line(points = {{-70, -74}, {-62, -74}}, color = {0, 0, 127}));
  connect(twoWindingTransformer.p, PQbus.p) annotation(
    Line(points = {{0, -74}, {-17, -74}}, color = {0, 0, 255}));
  connect(PVbus.p, twoWindingTransformer.n) annotation(
    Line(points = {{39, -74}, {22, -74}}, color = {0, 0, 255}));
  connect(PQbus.p, infiniteBus21.p) annotation(
    Line(points = {{-17, -74}, {-40, -74}}, color = {0, 0, 255}));
  connect(staticgenerator1.p, PVbus.p) annotation(
    Line(points = {{120, 5}, {140, 5}, {140, -75}, {40, -75}, {40, -75}}, color = {0, 0, 255}));
  annotation (
    Icon(coordinateSystem(
        
        initialScale=0.1,
        grid={10,10}), graphics={Text(origin = {-72.3502, 50}, fillPattern = FillPattern.Solid, extent = {{-17.6498, -10}, {17.6498, 10}}, textString = "E", fontName = "Arial"), Text(origin = {-72.3502, -50}, fillPattern = FillPattern.Solid, extent = {{-17.6498, -10}, {17.6498, 10}}, textString = "T", fontName = "Arial"), Rectangle(fillColor = {255, 255, 255}, extent = {{-100, -100}, {100, 100}})}),
    Diagram(coordinateSystem(
        extent={{-148.5,-105.0},{148.5,105.0}},
        preserveAspectRatio=true,
        initialScale=0.1,
        grid={5,5})),
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
