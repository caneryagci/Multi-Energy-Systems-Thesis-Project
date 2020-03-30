model new
  WF wf1 (redeclare package PhaseSystem =
        PowerSystems.PhaseSystems.DirectCurrent) annotation(
    Placement(visible = true, transformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner PowerSystems.System system annotation(
    Placement(visible = true, transformation(origin = {-90, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Generic.FixedVoltageSource fixedVoltageSource1 annotation(
    Placement(visible = true, transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  PowerSystems.Generic.Inverter inverter1 annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(wf1.terminal, inverter1.terminal_dc) annotation(
    Line(points = {{-48, 0}, {0, 0}, {0, 0}, {0, 0}}, color = {0, 120, 120},smooth=Smooth.None));
  connect(inverter1.terminal, fixedVoltageSource1.terminal) annotation(
    Line(points = {{20, 0}, {36, 0}, {36, 0}, {36, 0}}, color = {0, 120, 120},smooth=Smooth.None));

annotation(
    uses(PowerSystems(version = "0.6.0")));end new;
