within Hydrogen;

model Controller_DSM
  parameter Real Smax = 10;
  //parameter Real nmax = 1.1;
  //parameter Real nmin = 0.001;
  //parameter Real S_emergency = 4.75;
  //Real Pbalance;
  //Real upper;
  //Real lower;
  Modelica.Blocks.Interfaces.RealInput S_storage(start = 5) annotation(
    Placement(visible = true, transformation(origin = {-95, -19}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {-28, -106}, extent = {{20, -20}, {-20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput generation annotation(
    Placement(visible = true, transformation(origin = {-98, 16}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-96, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput demand annotation(
    Placement(visible = true, transformation(origin = {-100, 56}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-96, 14}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pmin annotation(
    Placement(visible = true, transformation(origin = {96, 42}, extent = {{-22, -22}, {22, 22}}, rotation = 0), iconTransformation(origin = {127, 71}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pmax annotation(
    Placement(visible = true, transformation(origin = {77, -65}, extent = {{-23, -23}, {23, 23}}, rotation = 0), iconTransformation(origin = {128, 10}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID pid(limitsAtInit = true, withFeedForward = false, yMax = 1.1) annotation(
    Placement(visible = true, transformation(origin = {-64, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-36, 56}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-14, 54}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 1, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {-2, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T = 1, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {60, 44}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold = 10) annotation(
    Placement(visible = true, transformation(origin = {-42, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold = 4.8) annotation(
    Placement(visible = true, transformation(origin = {-40, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {36, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {10, 50}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  //protected
  // parameter Real S_emergency= 0.49*Smax;
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-80, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {18, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
/* when S_storage <= Smax and S_storage >= S_emergency then
    Pbalance = 1;
    lower = 0;
    upper = 1;
  elsewhen S_storage < S_emergency then
    lower = 1;
    upper = 1;
    Pbalance = 0;
  elsewhen S_storage > Smax then
    lower = 0.1;
    upper = 0.1;
    Pbalance = 0;
  end when;
  */
  connect(demand, pid.u_s) annotation(
    Line(points = {{-100, 56}, {-76, 56}}, color = {0, 0, 127}));
  connect(generation, pid.u_m) annotation(
    Line(points = {{-98, 16}, {-64, 16}, {-64, 44}}, color = {0, 0, 127}));
  connect(pid.y, gain.u) annotation(
    Line(points = {{-53, 56}, {-46, 56}}, color = {0, 0, 127}));
  connect(gain.y, product.u1) annotation(
    Line(points = {{-27, 56}, {-21.5, 56}, {-21.5, 58}, {-21, 58}}, color = {0, 0, 127}));
  connect(firstOrder1.y, Pmin) annotation(
    Line(points = {{64, 44}, {78, 44}, {78, 42}, {96, 42}}, color = {0, 0, 127}));
  connect(firstOrder.y, Pmax) annotation(
    Line(points = {{10, -70}, {22, -70}, {22, -68}, {78, -68}, {78, -64}}, color = {0, 0, 127}));
  connect(S_storage, lessEqualThreshold.u) annotation(
    Line(points = {{-94, -18}, {-68, -18}, {-68, -6}, {-54, -6}, {-54, -6}}, color = {0, 0, 127}));
  connect(S_storage, greaterEqualThreshold.u) annotation(
    Line(points = {{-94, -18}, {-62, -18}, {-62, -40}, {-52, -40}, {-52, -38}}, color = {0, 0, 127}));
  connect(lessEqualThreshold.y, product.u2) annotation(
    Line(points = {{-30, -6}, {-22, -6}, {-22, 50}, {-21, 50}}, color = {255, 0, 255}));
  connect(add.y, firstOrder1.u) annotation(
    Line(points = {{48, 44}, {56, 44}, {56, 44}, {56, 44}}, color = {0, 0, 127}));
  connect(product.y, product1.u1) annotation(
    Line(points = {{-8, 54}, {2, 54}, {2, 54}, {2, 54}}, color = {0, 0, 127}));
  connect(greaterEqualThreshold.y, product1.u2) annotation(
    Line(points = {{-28, -38}, {-4, -38}, {-4, 46}, {2, 46}, {2, 46}}, color = {255, 0, 255}));
  connect(product1.y, add.u1) annotation(
    Line(points = {{16, 50}, {22, 50}, {22, 50}, {24, 50}}, color = {0, 0, 127}));
  connect(const.y, firstOrder.u) annotation(
    Line(points = {{-68, -68}, {-32, -68}, {-32, -70}, {-14, -70}, {-14, -70}}, color = {0, 0, 127}));
  connect(const1.y, add.u2) annotation(
    Line(points = {{30, -8}, {38, -8}, {38, 26}, {14, 26}, {14, 38}, {24, 38}, {24, 38}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {19, -6}, lineColor = {0, 0, 255}, extent = {{-65, 66}, {37, -42}}, textString = "Controller"), Text(origin = {-86, 53}, extent = {{-12, 9}, {60, -33}}, textString = "demand"), Text(origin = {-87, 1}, extent = {{75, -63}, {-11, 7}}, textString = "generation"), Text(origin = {59, -58}, extent = {{-25, 12}, {33, -26}}, textString = "P"), Text(origin = {-21, -74}, extent = {{-29, 34}, {29, -34}}, textString = "S_storage"), Text(origin = {74, 85}, extent = {{-20, 39}, {20, -39}}, textString = "Pmin"), Text(origin = {76, 25}, extent = {{-20, 39}, {20, -39}}, textString = "Pmax")}, coordinateSystem(initialScale = 0.1)));
end Controller_DSM;
