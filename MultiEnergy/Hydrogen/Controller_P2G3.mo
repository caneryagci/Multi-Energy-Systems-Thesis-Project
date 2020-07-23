within Hydrogen;

model Controller_P2G3
  parameter Real Smax = 100;
  parameter Real S_emergency = 49.9;
  parameter Real Pnom = 46000;
  parameter Real Pshutdown = 0.1;
  parameter Real Pgain = 18000;
  //Real error_pu;
  Modelica.Blocks.Interfaces.RealInput S_storage annotation(
    Placement(visible = true, transformation(origin = {-100, 82}, extent = {{-14, -14}, {14, 14}}, rotation = 0), iconTransformation(origin = {-102, 80}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pmin annotation(
    Placement(visible = true, transformation(extent = {{174, -10}, {198, 14}}, rotation = 0), iconTransformation(origin = {213, 69}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput P annotation(
    Placement(visible = true, transformation(origin = {-100, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -124}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold = Smax) annotation(
    Placement(visible = true, transformation(origin = {-51, 59}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold = S_emergency) annotation(
    Placement(visible = true, transformation(origin = {127, -73}, extent = {{-7, -7}, {7, 7}}, rotation = 180)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {44, 58}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {16, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 5) annotation(
    Placement(visible = true, transformation(origin = {-8, 70}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch11 annotation(
    Placement(visible = true, transformation(origin = {92, -70}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant const1(k = 50) annotation(
    Placement(visible = true, transformation(origin = {107, -91}, extent = {{-5, -5}, {5, 5}}, rotation = 90)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = 55, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {-62, 30}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput generation annotation(
    Placement(visible = true, transformation(origin = {-100, -46}, extent = {{-18, -18}, {18, 18}}, rotation = 0), iconTransformation(origin = {-102, -70}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput demand annotation(
    Placement(visible = true, transformation(origin = {-100, -84}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-102, 20}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {-74, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch12 annotation(
    Placement(visible = true, transformation(origin = {14, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant const2(k = 50) annotation(
    Placement(visible = true, transformation(origin = {42, -80}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 0.5) annotation(
    Placement(visible = true, transformation(origin = {72, -32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant flexibility_service(k = 0) annotation(
    Placement(visible = true, transformation(origin = {108, -32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Hydrogen.first_order first_order1(T = 10, k = 1) annotation(
    Placement(visible = true, transformation(origin = {154, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.gain gain(k = Pgain)  annotation(
    Placement(visible = true, transformation(origin = {-44, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pmax annotation(
    Placement(visible = true, transformation(origin = {184, -124}, extent = {{-14, -14}, {14, 14}}, rotation = 0), iconTransformation(origin = {214, -40}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch13 annotation(
    Placement(visible = true, transformation(origin = {138, -124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const3(k = 50)  annotation(
    Placement(visible = true, transformation(origin = {-84, -114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch14 annotation(
    Placement(visible = true, transformation(origin = {-16, -122}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
    Line(points = {{-100, 82}, {136, 82}, {136, -73}, {135, -73}}, color = {0, 0, 127}));
  connect(switch1.y, switch11.u1) annotation(
    Line(points = {{55, 58}, {130, 58}, {130, -62}, {104, -62}}, color = {0, 0, 127}));
  connect(limiter.y, add.u1) annotation(
    Line(points = {{-53, 30}, {-15.5, 30}, {-15.5, 22}, {4, 22}}, color = {0, 0, 127}));
  connect(generation, feedback.u1) annotation(
    Line(points = {{-100, -46}, {-82, -46}, {-82, -22}}, color = {0, 0, 127}));
  connect(demand, feedback.u2) annotation(
    Line(points = {{-100, -84}, {-74, -84}, {-74, -30}}, color = {0, 0, 127}));
  connect(add.y, switch1.u1) annotation(
    Line(points = {{28, 16}, {38, 16}, {38, 42}, {14, 42}, {14, 50}, {32, 50}, {32, 50}}, color = {0, 0, 127}));
  connect(P, limiter.u) annotation(
    Line(points = {{-100, 30}, {-72, 30}}, color = {0, 0, 127}));
  connect(const1.y, switch11.u3) annotation(
    Line(points = {{107, -85.5}, {107, -78}, {104, -78}}, color = {0, 0, 127}));
  connect(greaterEqualThreshold.y, switch11.u2) annotation(
    Line(points = {{120, -72}, {114, -72}, {114, -70}, {104, -70}, {104, -70}}, color = {255, 0, 255}));
  connect(const2.y, switch12.u1) annotation(
    Line(points = {{35, -80}, {30.5, -80}, {30.5, -76}, {26, -76}}, color = {0, 0, 127}));
  connect(switch11.y, switch12.u3) annotation(
    Line(points = {{82, -70}, {70, -70}, {70, -60}, {26, -60}, {26, -60}}, color = {0, 0, 127}));
  connect(flexibility_service.y, greaterThreshold.u) annotation(
    Line(points = {{98, -32}, {86, -32}, {86, -32}, {84, -32}}, color = {0, 0, 127}));
  connect(greaterThreshold.y, switch12.u2) annotation(
    Line(points = {{62, -32}, {42, -32}, {42, -68}, {26, -68}, {26, -68}}, color = {255, 0, 255}));
  connect(switch12.y, first_order1.u) annotation(
    Line(points = {{4, -68}, {-20, -68}, {-20, -10}, {118, -10}, {118, 10}, {142, 10}}, color = {0, 0, 127}));
  connect(first_order1.y, Pmin) annotation(
    Line(points = {{165, 10}, {170, 10}, {170, 2}, {186, 2}}, color = {0, 0, 127}));
  connect(feedback.y, gain.u) annotation(
    Line(points = {{-64, -22}, {-56, -22}, {-56, -22}, {-56, -22}}, color = {0, 0, 127}));
  connect(gain.y, add.u2) annotation(
    Line(points = {{-32, -22}, {-26, -22}, {-26, 10}, {4, 10}, {4, 10}}, color = {0, 0, 127}));
  connect(switch13.y, Pmax) annotation(
    Line(points = {{149, -124}, {184, -124}}, color = {0, 0, 127}));
  connect(const3.y, switch14.u1) annotation(
    Line(points = {{-72, -114}, {-28, -114}}, color = {0, 0, 127}));
  connect(lessEqualThreshold.y, switch14.u2) annotation(
    Line(points = {{-42, 60}, {-34, 60}, {-34, -122}, {-28, -122}}, color = {255, 0, 255}));
  connect(first_order1.y, switch14.u3) annotation(
    Line(points = {{165, 10}, {170, 10}, {170, -102}, {88, -102}, {88, -142}, {-34, -142}, {-34, -130}, {-28, -130}}, color = {0, 0, 127}));
  connect(greaterEqualThreshold.y, switch13.u2) annotation(
    Line(points = {{120, -72}, {116, -72}, {116, -124}, {126, -124}, {126, -124}}, color = {255, 0, 255}));
  connect(switch14.y, switch13.u1) annotation(
    Line(points = {{-5, -122}, {62, -122}, {62, -116}, {126, -116}}, color = {0, 0, 127}));
  connect(first_order1.y, switch13.u3) annotation(
    Line(points = {{165, 10}, {170, 10}, {170, -102}, {88, -102}, {88, -132}, {126, -132}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-120, -150}, {200, 100}}, initialScale = 0.1), graphics = {Text(origin = {-46, -71}, extent = {{-30, 19}, {98, -31}}, textString = "generation"), Text(origin = {-55, 106}, extent = {{-25, 12}, {93, -64}}, textString = "S_storage"), Text(origin = {-54, -116}, extent = {{-34, 8}, {84, -20}}, textString = "P_total"), Rectangle(extent = {{-120, 100}, {200, -150}}), Text(origin = {-50, 37}, extent = {{-30, 19}, {82, -23}}, textString = "demand"), Text(origin = {162, 62}, extent = {{-30, 34}, {24, -38}}, textString = "Pmin"), Text(origin = {160, -29}, extent = {{-30, 23}, {26, -33}}, textString = "Pmax"), Text(origin = {46, -33}, lineColor = {0, 0, 255}, extent = {{-90, 57}, {68, -35}}, textString = "Controller")}),
    Diagram(graphics = {Bitmap(extent = {{-44, -22}, {-44, -22}})}, coordinateSystem(extent = {{-120, -150}, {200, 100}}, initialScale = 0.1)));
end Controller_P2G3;
