within P2H;

model controller_p2h
  parameter Real Smax = 10;
  parameter Real S_emergency = 4.8;
  parameter Real Pnom = 46000;
  parameter Real Pshutdown = 0.1;
  parameter Real Pgain = 100;
  //Real error_pu;
  Modelica.Blocks.Interfaces.RealInput S_storage annotation(
    Placement(visible = true, transformation(origin = {-100, 82}, extent = {{-14, -14}, {14, 14}}, rotation = 0), iconTransformation(origin = {-100, 82}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pmin annotation(
    Placement(visible = true, transformation(extent = {{186, -14}, {210, 10}}, rotation = 0), iconTransformation(extent = {{100, 0}, {124, 24}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput P annotation(
    Placement(visible = true, transformation(origin = {-100, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -74}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold = 2400) annotation(
    Placement(visible = true, transformation(origin = {-51, 59}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold = 1200) annotation(
    Placement(visible = true, transformation(origin = {125, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {44, 58}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {16, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 5) annotation(
    Placement(visible = true, transformation(origin = {-8, 70}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch11 annotation(
    Placement(visible = true, transformation(origin = {92, -70}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant const1(k = 50) annotation(
    Placement(visible = true, transformation(origin = {113, -91}, extent = {{-5, -5}, {5, 5}}, rotation = 90)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = 55, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {-46, 24}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput generation annotation(
    Placement(visible = true, transformation(origin = {-100, -46}, extent = {{-18, -18}, {18, 18}}, rotation = 0), iconTransformation(origin = {-100, -14}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput demand annotation(
    Placement(visible = true, transformation(origin = {-100, -84}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-102, 38}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {-74, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch12 annotation(
    Placement(visible = true, transformation(origin = {14, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant const2(k = 50) annotation(
    Placement(visible = true, transformation(origin = {54, -88}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 0.5) annotation(
    Placement(visible = true, transformation(origin = {72, -32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant flexibility_service(k = 0) annotation(
    Placement(visible = true, transformation(origin = {108, -32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Hydrogen.gain gain(k = Pgain) annotation(
    Placement(visible = true, transformation(origin = {-44, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 10, k = 1)  annotation(
    Placement(visible = true, transformation(origin = {160, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 55, uMin = 0)  annotation(
    Placement(visible = true, transformation(origin = {57, -3}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
equation
/*
error_pu= balance_error/0.002;

 if S_storage <= Smax then
   if S_storage >= S_emergency then
    if balance_error < 0 then
    Pmin=P-error_pu;
    elseif balance_error > 0 then
    Pmin=P+error_pu;
    else
    Pmin=P;
    end if;
   else
    Pmin = 1;
   end if;
  
 elseif S_storage > Smax then
  Pmin=0.1;
  
 end if;
*/
  connect(S_storage, lessEqualThreshold.u) annotation(
    Line(points = {{-100, 82}, {-79, 82}, {-79, 59}, {-62, 59}}, color = {0, 0, 127}));
  connect(lessEqualThreshold.y, switch1.u2) annotation(
    Line(points = {{-41, 59}, {-28, 59}, {-28, 58}, {32, 58}}, color = {255, 0, 255}));
  connect(const.y, switch1.u3) annotation(
    Line(points = {{-4, 70}, {6, 70}, {6, 66}, {32, 66}}, color = {0, 0, 127}));
  connect(S_storage, greaterEqualThreshold.u) annotation(
    Line(points = {{-100, 82}, {136, 82}, {136, -73}, {133, -73}}, color = {0, 0, 127}));
  connect(switch1.y, switch11.u1) annotation(
    Line(points = {{55, 58}, {130, 58}, {130, -62}, {104, -62}}, color = {0, 0, 127}));
  connect(limiter.y, add.u1) annotation(
    Line(points = {{-37, 24}, {-15.5, 24}, {-15.5, 22}, {4, 22}}, color = {0, 0, 127}));
  connect(generation, feedback.u1) annotation(
    Line(points = {{-100, -46}, {-82, -46}, {-82, -22}}, color = {0, 0, 127}));
  connect(demand, feedback.u2) annotation(
    Line(points = {{-100, -84}, {-74, -84}, {-74, -30}}, color = {0, 0, 127}));
  connect(add.y, switch1.u1) annotation(
    Line(points = {{28, 16}, {38, 16}, {38, 42}, {14, 42}, {14, 50}, {32, 50}, {32, 50}}, color = {0, 0, 127}));
  connect(P, limiter.u) annotation(
    Line(points = {{-100, 30}, {-66, 30}, {-66, 24}, {-56, 24}}, color = {0, 0, 127}));
  connect(const1.y, switch11.u3) annotation(
    Line(points = {{113, -85.5}, {113, -78}, {104, -78}}, color = {0, 0, 127}));
  connect(greaterEqualThreshold.y, switch11.u2) annotation(
    Line(points = {{117, -73}, {114, -73}, {114, -70}, {104, -70}}, color = {255, 0, 255}));
  connect(const2.y, switch12.u1) annotation(
    Line(points = {{48, -88}, {38, -88}, {38, -76}, {26, -76}, {26, -76}}, color = {0, 0, 127}));
  connect(switch11.y, switch12.u3) annotation(
    Line(points = {{82, -70}, {70, -70}, {70, -60}, {26, -60}, {26, -60}}, color = {0, 0, 127}));
  connect(flexibility_service.y, greaterThreshold.u) annotation(
    Line(points = {{98, -32}, {86, -32}, {86, -32}, {84, -32}}, color = {0, 0, 127}));
  connect(greaterThreshold.y, switch12.u2) annotation(
    Line(points = {{62, -32}, {42, -32}, {42, -68}, {26, -68}, {26, -68}}, color = {255, 0, 255}));
  connect(feedback.y, gain.u) annotation(
    Line(points = {{-64, -22}, {-56, -22}, {-56, -22}, {-56, -22}}, color = {0, 0, 127}));
  connect(gain.y, add.u2) annotation(
    Line(points = {{-32, -22}, {-26, -22}, {-26, 10}, {4, 10}, {4, 10}}, color = {0, 0, 127}));
  connect(firstOrder.y, Pmin) annotation(
    Line(points = {{172, -2}, {192, -2}, {192, -2}, {198, -2}}, color = {0, 0, 127}));
  connect(switch12.y, limiter1.u) annotation(
    Line(points = {{4, -68}, {-14, -68}, {-14, -3}, {49, -3}}, color = {0, 0, 127}));
  connect(limiter1.y, firstOrder.u) annotation(
    Line(points = {{65, -3}, {109.5, -3}, {109.5, -2}, {148, -2}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Text(origin = {-50, -7}, extent = {{-30, 19}, {124, -27}}, textString = "generation"), Text(origin = {-57, 114}, extent = {{-25, 12}, {123, -70}}, textString = "S_storage"), Text(origin = {-46, -66}, extent = {{-34, 8}, {128, -24}}, textString = "P_total"), Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-64, 53}, extent = {{-30, 19}, {164, -41}}, textString = "demand")}, coordinateSystem(initialScale = 0.1)),
    Diagram(graphics = {Bitmap(extent = {{-44, -22}, {-44, -22}})}, coordinateSystem(initialScale = 0.1)));
end controller_p2h;
