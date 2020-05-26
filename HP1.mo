model HP1
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {84, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T boundary(nPorts = 1, use_T_in = true, use_m_flow_in = true)  annotation(
    Placement(visible = true, transformation(origin = {-52, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate annotation(
    Placement(visible = true, transformation(origin = {-18, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Pipes.StaticPipe pipe(diameter = 0.3, length = 10)  annotation(
    Placement(visible = true, transformation(origin = {12, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT sink(nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {74, -2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T_fluid1(k = 333.15) annotation(
    Placement(visible = true, transformation(extent = {{-100, -16}, {-80, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant m_flow1(k = 2) annotation(
    Placement(visible = true, transformation(extent = {{-96, 20}, {-76, 40}}, rotation = 0)));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem annotation(
    Placement(visible = true, transformation(origin = {44, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(boundary.ports[1], massFlowRate.port_a) annotation(
    Line(points = {{-42, -2}, {-28, -2}}, color = {0, 127, 255}));
  connect(massFlowRate.port_b, pipe.port_a) annotation(
    Line(points = {{-8, -2}, {2, -2}, {2, -2}, {2, -2}}, color = {0, 127, 255}));
  connect(m_flow1.y, boundary.m_flow_in) annotation(
    Line(points = {{-74, 30}, {-72, 30}, {-72, 6}, {-62, 6}, {-62, 6}}, color = {0, 0, 127}));
  connect(T_fluid1.y, boundary.T_in) annotation(
    Line(points = {{-78, -6}, {-72, -6}, {-72, 2}, {-64, 2}, {-64, 2}}, color = {0, 0, 127}));
  connect(pipe.port_b, senTem.port_a) annotation(
    Line(points = {{22, -2}, {34, -2}, {34, -2}, {34, -2}}, color = {0, 127, 255}));
  connect(senTem.port_b, sink.ports[1]) annotation(
    Line(points = {{54, -2}, {64, -2}}, color = {0, 127, 255}));

annotation(
    uses(AixLib(version = "0.9.1"), Modelica(version = "3.2.3")),
    Diagram);
end HP1;
