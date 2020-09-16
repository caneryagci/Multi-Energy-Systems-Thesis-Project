within Hydrogen;

model Controller_P2G3
  parameter Real Smax = 200;
  parameter Real S_emergency = 19.9;
  parameter Real Pnom = 46000;
  parameter Real Pshutdown = 0.1;
  parameter Real Pgain = 18000;
  parameter Real P_initial = 23;
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
  Hydrogen.first_order first_order1(T = 5, k = 1, y(fixed = true), y_start = P_initial) annotation(
    Placement(visible = true, transformation(origin = {150, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydrogen.gain gain(k = Pgain) annotation(
    Placement(visible = true, transformation(origin = {-44, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pmax annotation(
    Placement(visible = true, transformation(origin = {184, -124}, extent = {{-14, -14}, {14, 14}}, rotation = 0), iconTransformation(origin = {214, -40}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch13 annotation(
    Placement(visible = true, transformation(origin = {138, -124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const3(k = 50) annotation(
    Placement(visible = true, transformation(origin = {-84, -114}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch14 annotation(
    Placement(visible = true, transformation(origin = {-32, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant flexibility_service(k = 0) annotation(
    Placement(visible = true, transformation(origin = {108, -32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold = 0.5) annotation(
    Placement(visible = true, transformation(origin = {28, -138}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch annotation(
    Placement(visible = true, transformation(origin = {-28, -134}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealInput ptg_switch annotation(
    Placement(visible = true, transformation(origin = {82, -136}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {-98, -26}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
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
  connect(greaterThreshold.y, switch12.u2) annotation(
    Line(points = {{62, -32}, {42, -32}, {42, -68}, {26, -68}, {26, -68}}, color = {255, 0, 255}));
  connect(switch12.y, first_order1.u) annotation(
    Line(points = {{4, -68}, {-20, -68}, {-20, -10}, {118, -10}, {118, 20}, {138, 20}}, color = {0, 0, 127}));
  connect(first_order1.y, Pmin) annotation(
    Line(points = {{161, 20}, {170, 20}, {170, 2}, {186, 2}}, color = {0, 0, 127}));
  connect(feedback.y, gain.u) annotation(
    Line(points = {{-64, -22}, {-56, -22}, {-56, -22}, {-56, -22}}, color = {0, 0, 127}));
  connect(gain.y, add.u2) annotation(
    Line(points = {{-32, -22}, {-26, -22}, {-26, 10}, {4, 10}, {4, 10}}, color = {0, 0, 127}));
  connect(const3.y, switch14.u1) annotation(
    Line(points = {{-72, -114}, {-51, -114}, {-51, -92}, {-44, -92}}, color = {0, 0, 127}));
  connect(lessEqualThreshold.y, switch14.u2) annotation(
    Line(points = {{-42, 60}, {-42, -18}, {-44, -18}, {-44, -100}}, color = {255, 0, 255}));
  connect(first_order1.y, switch14.u3) annotation(
    Line(points = {{161, 20}, {170, 20}, {170, -102}, {66, -102}, {66, -120}, {-44, -120}, {-44, -108}}, color = {0, 0, 127}));
  connect(greaterEqualThreshold.y, switch13.u2) annotation(
    Line(points = {{120, -72}, {116, -72}, {116, -124}, {126, -124}, {126, -124}}, color = {255, 0, 255}));
  connect(switch14.y, switch13.u1) annotation(
    Line(points = {{-21, -100}, {56.5, -100}, {56.5, -116}, {126, -116}}, color = {0, 0, 127}));
  connect(first_order1.y, switch13.u3) annotation(
    Line(points = {{161, 20}, {170, 20}, {170, -102}, {88, -102}, {88, -132}, {126, -132}}, color = {0, 0, 127}));
  connect(flexibility_service.y, greaterThreshold.u) annotation(
    Line(points = {{98, -32}, {86, -32}, {86, -32}, {84, -32}}, color = {0, 0, 127}));
  connect(greaterThreshold1.y, switch.u2) annotation(
    Line(points = {{18, -138}, {0, -138}, {0, -134}, {-16, -134}, {-16, -134}}, color = {255, 0, 255}));
  connect(switch13.y, switch.u1) annotation(
    Line(points = {{150, -124}, {158, -124}, {158, -156}, {-8, -156}, {-8, -142}, {-16, -142}, {-16, -142}}, color = {0, 0, 127}));
  connect(first_order1.y, switch.u3) annotation(
    Line(points = {{161, 20}, {158, 20}, {158, -106}, {-8, -106}, {-8, -126}, {-16, -126}}, color = {0, 0, 127}));
  connect(switch.y, Pmax) annotation(
    Line(points = {{-38, -134}, {-60, -134}, {-60, -160}, {164, -160}, {164, -126}, {184, -126}, {184, -124}}, color = {0, 0, 127}));
  connect(ptg_switch, greaterThreshold1.u) annotation(
    Line(points = {{82, -136}, {42, -136}, {42, -138}, {40, -138}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-120, -150}, {200, 100}}, initialScale = 0.1), graphics = {Text(origin = {-46, -71}, extent = {{-30, 19}, {98, -31}}, textString = "generation"), Text(origin = {-55, 106}, extent = {{-25, 12}, {93, -64}}, textString = "S_storage"), Text(origin = {-54, -116}, extent = {{-34, 8}, {84, -20}}, textString = "P_total"), Rectangle(extent = {{-120, 100}, {200, -150}}), Text(origin = {-50, 37}, extent = {{-30, 19}, {82, -23}}, textString = "demand"), Text(origin = {162, 62}, extent = {{-30, 34}, {24, -38}}, textString = "Pmin"), Text(origin = {160, -29}, extent = {{-30, 23}, {26, -33}}, textString = "Pmax"), Text(origin = {46, -33}, lineColor = {0, 0, 255}, extent = {{-90, 57}, {68, -35}}, textString = "Controller")}),
    Diagram(graphics = {Bitmap(extent = {{-44, -22}, {-44, -22}})}, coordinateSystem(extent = {{-120, -150}, {200, 100}}, initialScale = 0.1)));
end Controller_P2G3;
