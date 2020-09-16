within Hydrogen;

model controller_P2G
  //parameter Real Smax = 10;
  //parameter Real nmax = 1.1;
  //parameter Real nmin = 0.001;
  //parameter Real S_emergency = 4.75;
  //Real reference;
  Modelica.Blocks.Interfaces.RealInput P annotation(
    Placement(visible = true, transformation(origin = {-102, 170}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {60, -102}, extent = {{20, -20}, {-20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput S_storage(start = 5) annotation(
    Placement(visible = true, transformation(origin = {-154, -32}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-28, -106}, extent = {{20, -20}, {-20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput generation annotation(
    Placement(visible = true, transformation(origin = {-180, 106}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, -54}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput demand annotation(
    Placement(visible = true, transformation(origin = {-180, 130}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-102, 22}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pmin annotation(
    Placement(visible = true, transformation(origin = {157, 35}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {127, 71}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pmax annotation(
    Placement(visible = true, transformation(origin = {186, -22}, extent = {{-16, -16}, {16, 16}}, rotation = 0), iconTransformation(origin = {128, 10}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-114, 130}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID pid(limitsAtInit = true, yMax = 1.1) annotation(
    Placement(visible = true, transformation(origin = {-142, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //protected
  //parameter Real S_emergency= 0.48*Smax;
  Modelica.Blocks.Sources.Constant Pnom(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-36, -92}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Pshutdown(k = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-25, 31}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold = 10) annotation(
    Placement(visible = true, transformation(origin = {-88, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold = 4.8) annotation(
    Placement(visible = true, transformation(origin = {-88, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {2, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch11 annotation(
    Placement(visible = true, transformation(origin = {72, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch12 annotation(
    Placement(visible = true, transformation(origin = {118, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 1) annotation(
    Placement(visible = true, transformation(origin = {150, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T = 1) annotation(
    Placement(visible = true, transformation(origin = {110, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
/*  when S_storage <= Smax and S_storage >= S_emergency then
    Pmin = zeroOrderHold.y;
    Pmax = 1;
  elsewhen S_storage < S_emergency then
    Pmin = 1;
    Pmax = Pmin;
  elsewhen S_storage > Smax then
    Pmin = 0.1;
    Pmax = Pmin;
  end when;*/
  connect(demand, pid.u_s) annotation(
    Line(points = {{-180, 130}, {-154, 130}}, color = {0, 0, 127}));
  connect(generation, pid.u_m) annotation(
    Line(points = {{-180, 106}, {-142, 106}, {-142, 118}}, color = {0, 0, 127}));
  connect(pid.y, gain.u) annotation(
    Line(points = {{-131, 130}, {-121, 130}}, color = {0, 0, 127}));
  connect(S_storage, lessEqualThreshold.u) annotation(
    Line(points = {{-154, -32}, {-116, -32}, {-116, 28}, {-108, 28}, {-108, 30}, {-100, 30}}, color = {0, 0, 127}));
  connect(S_storage, greaterEqualThreshold.u) annotation(
    Line(points = {{-154, -32}, {-116, -32}, {-116, -4}, {-108, -4}, {-108, -2}, {-100, -2}}, color = {0, 0, 127}));
  connect(lessEqualThreshold.y, switch1.u2) annotation(
    Line(points = {{-76, 30}, {-38, 30}, {-38, 64}, {-10, 64}}, color = {255, 0, 255}));
  connect(gain.y, switch1.u1) annotation(
    Line(points = {{-108, 130}, {-48, 130}, {-48, 72}, {-10, 72}}, color = {0, 0, 127}));
  connect(Pshutdown.y, switch1.u3) annotation(
    Line(points = {{-18, 32}, {-6, 32}, {-6, 48}, {-22, 48}, {-22, 56}, {-10, 56}, {-10, 56}}, color = {0, 0, 127}));
  connect(greaterEqualThreshold.y, switch11.u2) annotation(
    Line(points = {{-76, -2}, {30, -2}, {30, 32}, {60, 32}}, color = {255, 0, 255}));
  connect(switch1.y, switch11.u1) annotation(
    Line(points = {{14, 64}, {36, 64}, {36, 40}, {60, 40}}, color = {0, 0, 127}));
  connect(Pnom.y, switch11.u3) annotation(
    Line(points = {{-27, -92}, {46, -92}, {46, 24}, {60, 24}}, color = {0, 0, 127}));
  connect(lessEqualThreshold.y, switch12.u2) annotation(
    Line(points = {{-76, 30}, {-52, 30}, {-52, -22}, {106, -22}}, color = {255, 0, 255}));
  connect(Pnom.y, switch12.u1) annotation(
    Line(points = {{-28, -92}, {72, -92}, {72, -14}, {106, -14}}, color = {0, 0, 127}));
  connect(Pmin, switch12.u3) annotation(
    Line(points = {{157, 35}, {158, 35}, {158, 8}, {94, 8}, {94, -30}, {106, -30}}, color = {0, 0, 127}));
  connect(switch11.y, firstOrder1.u) annotation(
    Line(points = {{84, 32}, {96, 32}, {96, 32}, {98, 32}}, color = {0, 0, 127}));
  connect(firstOrder1.y, Pmin) annotation(
    Line(points = {{122, 32}, {144, 32}, {144, 36}, {158, 36}}, color = {0, 0, 127}));
  connect(switch12.y, firstOrder.u) annotation(
    Line(points = {{130, -22}, {138, -22}, {138, -22}, {138, -22}}, color = {0, 0, 127}));
  connect(firstOrder.y, Pmax) annotation(
    Line(points = {{162, -22}, {176, -22}, {176, -22}, {186, -22}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {19, -6}, lineColor = {0, 0, 255}, extent = {{-65, 66}, {37, -42}}, textString = "Controller"), Text(origin = {-86, 53}, extent = {{-12, 9}, {60, -33}}, textString = "demand"), Text(origin = {-87, 1}, extent = {{75, -63}, {-11, 7}}, textString = "generation"), Text(origin = {59, -58}, extent = {{-25, 12}, {33, -26}}, textString = "P"), Text(origin = {-21, -74}, extent = {{-29, 34}, {29, -34}}, textString = "S_storage"), Text(origin = {74, 85}, extent = {{-20, 39}, {20, -39}}, textString = "Pmin"), Text(origin = {76, 25}, extent = {{-20, 39}, {20, -39}}, textString = "Pmax")}, coordinateSystem(extent = {{-200, -200}, {200, 200}}, initialScale = 0.1)),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
end controller_P2G;
