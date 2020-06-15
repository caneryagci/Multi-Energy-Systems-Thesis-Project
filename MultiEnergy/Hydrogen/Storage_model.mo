within Hydrogen;

model Storage_model

//replaceable package Medium = Modelica.Media.Water.StandardWater;
  replaceable package Medium = Modelica.Media.IdealGases.SingleGases.H2;


  inner Modelica.Fluid.System system(T_ambient = 573.15,energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, momentumDynamics = Modelica.Fluid.Types.Dynamics.SteadyStateInitial, p_ambient = 3e+07, use_eps_Re = true)  annotation(
    Placement(visible = true, transformation(origin = {76, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 

 
 
  Modelica.Fluid.Sources.MassFlowSource_T boundary1(nPorts = 1, use_m_flow_in = true, redeclare package Medium = Medium) annotation(
    Placement(visible = true, transformation(origin = {-44, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 1, height = 0, offset = 2, startTime = 20)  annotation(
    Placement(visible = true, transformation(origin = {-88, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-18, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica.Fluid.Machines.ControlledPump pump(redeclare package Medium = Medium, control_m_flow = false, m_flow_nominal = 1, p_a_nominal = 100000, p_b_nominal = 200000, use_m_flow_set = true) annotation(
    Placement(visible = true, transformation(origin = {16, 36}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
 Modelica.Fluid.Sources.Boundary_pT boundary2(nPorts = 1,redeclare package Medium = Medium)  annotation(
    Placement(visible = true, transformation(origin = {-80, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium,diameter = 40e-2, length = 1, nParallel = 1)  annotation(
    Placement(visible = true, transformation(origin = {-40, 40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
 Modelica.Fluid.Sources.FixedBoundary boundary(redeclare package Medium = Medium,nPorts = 2, p = 300, use_p = false)  annotation(
    Placement(visible = true, transformation(origin = {64, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  connect(ramp.y, boundary1.m_flow_in) annotation(
    Line(points = {{-77, 12}, {-62, 12}, {-62, 6}, {-54, 6}}, color = {0, 0, 127}));
 connect(const.y, pump.m_flow_set) annotation(
    Line(points = {{-7, 68}, {22, 68}, {22, 44}}, color = {0, 0, 127}));
 connect(pump.port_b, pipe.port_a) annotation(
    Line(points = {{6, 36}, {-18, 36}, {-18, 40}, {-30, 40}, {-30, 40}}, color = {0, 127, 255}));
 connect(pipe.port_b, boundary2.ports[1]) annotation(
    Line(points = {{-50, 40}, {-62, 40}, {-62, 48}, {-70, 48}, {-70, 48}}, color = {0, 127, 255}));
 connect(boundary1.ports[1], boundary.ports[1]) annotation(
    Line(points = {{-34, -2}, {54, -2}, {54, -2}, {54, -2}}, color = {0, 127, 255}));
 connect(pump.port_a, boundary.ports[2]) annotation(
    Line(points = {{26, 36}, {42, 36}, {42, 0}, {54, 0}, {54, -2}}, color = {0, 127, 255}));
end Storage_model;
