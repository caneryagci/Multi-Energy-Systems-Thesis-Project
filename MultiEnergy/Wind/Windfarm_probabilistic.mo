within Wind;

model Windfarm_probabilistic
inner outer PowerSystems.System system;
  PowerSystems.AC3ph.Inverters.InverterAverage inverter annotation(
    Placement(visible = true, transformation(origin = {100, -36}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PowerSystems.AC1ph_DC.Sensors.PVImeter PVImeter1(av = true, tcst = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {132, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Inverters.InverterAverage inverter1 annotation(
    Placement(visible = true, transformation(origin = {-130, -126}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Nodes.BusBar bus1 annotation(
    Placement(visible = true, transformation(origin = {-94, -124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Sensors.Psensor Psensor1 annotation(
    Placement(visible = true, transformation(origin = {-72, -124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Transformers.TrafoIdeal trafo annotation(
    Placement(visible = true, transformation(origin = {-36, -124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Common.Thermal.BdCondV bdCond(m = 2)  annotation(
    Placement(visible = true, transformation(origin = {57, -7}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  PowerSystems.Common.Thermal.BdCondV bdCond1 annotation(
    Placement(visible = true, transformation(origin = {101, -13}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  PowerSystems.Common.Thermal.BdCondV bdCond2 annotation(
    Placement(visible = true, transformation(origin = {-128, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression vPhasor_set(y = {0.5 - min(windSpeed, 15) / 20, 0.25 * windSpeed / 15})  annotation(
    Placement(visible = true, transformation(origin = {54, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Inverters.Select select1 annotation(
    Placement(visible = true, transformation(origin = {-128, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.Mechanics.Rotational.Rotor rotor11 annotation(
    Placement(visible = true, transformation(origin = {14, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear1 annotation(
    Placement(visible = true, transformation(origin = {-26, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PowerSystems.AC3ph.Ports.ACdq0_p term annotation(
    Placement(visible = true, transformation(origin = {6, -138}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {6, -138}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput windSpeed annotation(
    Placement(visible = true, transformation(origin = {-158, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-158, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  PowerSystems.AC3ph.Machines.Asynchron_dfig asynchron annotation(
    Placement(visible = true, transformation(origin = {50, -34}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Rotor1 rotor12 annotation(
    Placement(visible = true, transformation(origin = {-88, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(rotor12.flange, idealGear1.flange_a) annotation(
    Line(points = {{-78, -26}, {-44, -26}, {-44, -34}, {-36, -34}, {-36, -34}}));
  connect(windSpeed, rotor12.v) annotation(
    Line(points = {{-158, -30}, {-100, -30}, {-100, -26}, {-100, -26}}, color = {0, 0, 127}));
  connect(asynchron.term, bus1.term) annotation(
    Line(points = {{60, -34}, {68, -34}, {68, -104}, {-104, -104}, {-104, -124}, {-94, -124}, {-94, -124}}, color = {0, 120, 120}));
  connect(rotor11.flange_b, asynchron.airgap) annotation(
    Line(points = {{24, -34}, {36, -34}, {36, -28}, {50, -28}, {50, -28}}));
  connect(asynchron.term_r, inverter.AC) annotation(
    Line(points = {{60, -28}, {84, -28}, {84, -36}, {90, -36}, {90, -36}}, color = {0, 120, 120}));
  connect(asynchron.phiRotor, inverter.theta) annotation(
    Line(points = {{40, -24}, {34, -24}, {34, -4}, {106, -4}, {106, -26}, {106, -26}}, color = {0, 0, 127}));
  connect(bdCond.heat, asynchron.heat) annotation(
    Line(points = {{58, -16}, {56, -16}, {56, -22}, {56, -22}}, color = {176, 0, 0}));
  connect(rotor11.flange_b, asynchron.airgap) annotation(
    Line(points = {{24, -34}, {36, -34}, {36, -26}, {56, -26}, {56, -26}}));
  connect(windSpeed, rotor1.v) annotation(
    Line(points = {{-158, -30}, {-80, -30}}, color = {0, 0, 127}));
  connect(trafo.term_n, term) annotation(
    Line(points = {{-26, -124}, {12, -124}, {12, -138}, {6, -138}}, color = {0, 120, 120}));
  connect(rotor1.flange, idealGear1.flange_a) annotation(
    Line(points = {{-58, -30}, {-50, -30}, {-50, -34}, {-36, -34}, {-36, -34}}));
  connect(idealGear1.flange_b, rotor11.flange_a) annotation(
    Line(points = {{-16, -34}, {4, -34}, {4, -34}, {4, -34}}));
  connect(select1.vPhasor_out[1], inverter1.vPhasor[1]) annotation(
    Line(points = {{-122, -98}, {-110, -98}, {-110, -116}, {-124, -116}, {-124, -116}}, color = {0, 0, 127}, thickness = 0.5));
  connect(select1.theta_out, inverter1.theta) annotation(
    Line(points = {{-134, -98}, {-142, -98}, {-142, -116}, {-136, -116}, {-136, -116}}, color = {0, 0, 127}));
  connect(bdCond2.heat, inverter1.heat) annotation(
    Line(points = {{-128, -108}, {-129, -108}, {-129, -106}, {-128, -106}, {-128, -114}, {-130, -114}, {-130, -116}, {-130, -116}}, color = {176, 0, 0}));
  connect(Psensor1.term_n, trafo.term_p) annotation(
    Line(points = {{-62, -124}, {-46, -124}, {-46, -124}, {-46, -124}}, color = {0, 120, 120}));
  connect(bus1.term, Psensor1.term_p) annotation(
    Line(points = {{-94, -124}, {-82, -124}, {-82, -122}, {-82, -122}, {-82, -124}, {-82, -124}}, color = {0, 120, 120}));
  connect(inverter1.AC, bus1.term) annotation(
    Line(points = {{-120, -126}, {-94, -126}, {-94, -122}, {-94, -122}, {-94, -124}, {-94, -124}}, color = {0, 120, 120}));
  connect(PVImeter1.term_n, inverter1.DC) annotation(
    Line(points = {{142, -36}, {152, -36}, {152, -66}, {-152, -66}, {-152, -126}, {-140, -126}}, color = {0, 0, 255}));
  connect(inverter.DC, PVImeter1.term_p) annotation(
    Line(points = {{110, -36}, {122, -36}, {122, -36}, {122, -36}}, color = {0, 0, 255}));
  connect(vPhasor_set.y, inverter.vPhasor[1]) annotation(
    Line(points = {{65, 8}, {94, 8}, {94, -26}}, color = {0, 0, 127}));
  connect(bdCond1.heat, inverter.heat) annotation(
    Line(points = {{102, -22}, {100, -22}, {100, -26}, {100, -26}}, color = {176, 0, 0}));
  connect(rotor1.flange, idealGear1.flange_a) annotation(
    Line(points = {{-56, -32}, {-44, -32}, {-44, -34}, {-36, -34}, {-36, -34}}));
  annotation(
    uses(Modelica(version = "3.2.3"), OpenIPSL(version = "1.5.0")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "",
    __OpenModelica_commandLineOptions = "");
end Windfarm_probabilistic;
