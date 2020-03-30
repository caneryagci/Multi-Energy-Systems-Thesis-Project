model WindTurbine_PS
  inner outer PowerSystems.System system;

  Modelica.Blocks.Interfaces.RealInput windSpeed
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  PowerSystems.Common.Thermal.BdCondV bdCond(m= 2)
      annotation (Placement(transformation(extent={{-70,-18},{-50,2}}, rotation=
             0)));
  PowerSystems.AC3ph.Nodes.BusBar busbar
    annotation (Placement(
          transformation(extent={{-80,-90},{-60,-70}}, rotation=0)));
  PowerSystems.AC3ph.Sensors.Psensor sensor
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}},rotation=0)));
  PowerSystems.Examples.Wind.Components.Rotor rotor(R=40)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  PowerSystems.Mechanics.Rotational.Rotor inertia(J=300, w_start=314/generator.par.pp)
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio=generator.par.pp
      /200)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  PowerSystems.AC3ph.Inverters.InverterAverage inverter1
    annotation (Placement(transformation(extent={{-10,-44},{-30,-24}})));
  PowerSystems.Common.Thermal.BdCondV bdCond1(m=1)
      annotation (Placement(transformation(extent={{-30,-18},{-10,2}}, rotation=
             0)));
  PowerSystems.AC1ph_DC.Sensors.PVImeter meterDC(av=true, tcst=0.1)
    annotation (Placement(transformation(extent={{0,-44},{20,-24}},
                                                                  rotation=0)));
  PowerSystems.AC3ph.Inverters.InverterAverage inverter2
    annotation (Placement(transformation(extent={{30,-44},{50,-24}})));
  PowerSystems.AC3ph.Inverters.Select select2
    annotation (Placement(transformation(extent={{30,-2},{50,18}})));
  PowerSystems.Common.Thermal.BdCondV bdCond2(m=1)
      annotation (Placement(transformation(extent={{30,-18},{50,2}},   rotation=
             0)));
  PowerSystems.AC3ph.Transformers.TrafoIdeal trafo(redeclare record Data =
      PowerSystems.AC3ph.Transformers.Parameters.TrafoIdeal(V_nom={690,15e3}, S_nom=3e6))
    annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
  PowerSystems.AC3ph.Ports.ACdq0_p term
    annotation (Placement(transformation(extent={{0,-110},{20,-90}})));
  Modelica.Blocks.Sources.RealExpression vPhasor_set[2](y={0.5 - min(
      windSpeed, 15)/20,0.25*windSpeed/15})
  annotation (Placement(transformation(extent={{-10,-4},{-30,16}})));
  Wind.Asynchron_dfig_Can asynchron annotation(
    Placement(visible = true, transformation(origin = {-61, -35}, extent = {{11, -11}, {-11, 11}}, rotation = 0)));
equation
  connect(asynchron.phiRotor, inverter1.theta) annotation(
    Line(points = {{-72, -24}, {-78, -24}, {-78, 24}, {-10, 24}, {-10, -24}, {-14, -24}, {-14, -24}}, color = {0, 0, 127}));
  connect(asynchron.term, busbar.term) annotation(
    Line(points = {{-50, -34}, {-44, -34}, {-44, -60}, {-80, -60}, {-80, -80}, {-70, -80}, {-70, -80}, {-70, -80}}, color = {0, 120, 120}));
  connect(asynchron.term_r, inverter1.AC) annotation(
    Line(points = {{-50, -28}, {-40, -28}, {-40, -34}, {-30, -34}, {-30, -34}}, color = {0, 120, 120}));
  connect(busbar.term, sensor.term_p) annotation(
    Line(points = {{-70, -80}, {-60, -80}}, color = {0, 110, 110}));
  connect(rotor.flange, gear.flange_a) annotation(
    Line(points = {{-30, 50}, {-20, 50}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(gear.flange_b, inertia.flange_a) annotation(
    Line(points = {{0, 50}, {10, 50}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(inverter1.heat, bdCond1.heat) annotation(
    Line(points = {{-20, -24}, {-20, -18}}, color = {176, 0, 0}, smooth = Smooth.None));
  connect(bdCond2.heat, inverter2.heat) annotation(
    Line(points = {{40, -18}, {40, -24}}, color = {176, 0, 0}, smooth = Smooth.None));
  connect(select2.vPhasor_out, inverter2.vPhasor) annotation(
    Line(points = {{46, -2}, {46, -6}, {50, -6}, {50, -20}, {46, -20}, {46, -24}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(select2.theta_out, inverter2.theta) annotation(
    Line(points = {{34, -2}, {34, -6}, {30, -6}, {30, -20}, {34, -20}, {34, -24}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(inverter2.AC, busbar.term) annotation(
    Line(points = {{50, -34}, {60, -34}, {60, -60}, {-80, -60}, {-80, -80}, {-70, -80}}, color = {0, 120, 120}, smooth = Smooth.None));
  connect(inverter1.DC, meterDC.term_p) annotation(
    Line(points = {{-10, -34}, {0, -34}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(meterDC.term_n, inverter2.DC) annotation(
    Line(points = {{20, -34}, {30, -34}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(sensor.term_n, trafo.term_p) annotation(
    Line(points = {{-40, -80}, {-30, -80}}, color = {0, 120, 120}, smooth = Smooth.None));
  connect(windSpeed, rotor.v) annotation(
    Line(points = {{-100, 0}, {-88, 0}, {-88, 50}, {-51, 50}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(trafo.term_n, term) annotation(
    Line(points = {{-10, -80}, {10, -80}, {10, -100}}, color = {0, 120, 120}, smooth = Smooth.None));
  connect(vPhasor_set.y, inverter1.vPhasor) annotation(
    Line(points = {{-31, 6}, {-34, 6}, {-34, -20}, {-26, -20}, {-26, -24}}, color = {0, 0, 127}));
  annotation (                   Icon(graphics={
        Text(
            extent={{-100,90},{100,130}},
            lineColor={0,0,0},
            textString="%name"),
        Polygon(
          points={{-12,-6},{-60,-18},{-14,8},{-6,92},{0,6},{36,-76},{-12,-6}},
          lineColor={85,85,255},
          smooth=Smooth.None,
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-14,0},{2,-100}},
          lineColor={85,85,255},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-16},{-10,-4},{0,16},{28,24},{44,6},{34,-4},{0,-16}},
          lineColor={85,85,255},
          smooth=Smooth.None,
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid)}));
end WindTurbine_PS;
