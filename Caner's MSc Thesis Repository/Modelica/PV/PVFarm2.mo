within PV;

model PVFarm2 "Grid-tied 1-phase closed-loop inverter with PV source"

  PVSystems.Electrical.PVArray PV(v(start=450)) annotation (Placement(transformation(
        origin={-40,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant Gn(k=1000) annotation (Placement(
        transformation(extent={{-80,70},{-60,90}}, rotation=0)));
  Modelica.Blocks.Sources.Constant Tn(k=298.15) annotation (Placement(
        transformation(extent={{-80,30},{-60,50}}, rotation=0)));
  PVSystems.Electrical.Assemblies.HBridge Inverter             annotation (
      Placement(transformation(extent={{40,60},{60,80}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Inductor L(L=1e-3)   annotation (Placement(
        transformation(
        origin={86,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor Cdc(v(start=32.8), C=0.5)
    annotation (Placement(transformation(
        origin={24,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-20,40},{0,60}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression DCPower(y=-PV.i*PV.v)
    annotation (Placement(transformation(extent={{40,-72},{60,-52}})));
  Modelica.Blocks.Sources.RealExpression ACPower(y=R.v * R.i)
    annotation (Placement(transformation(extent={{40,-92},{60,-72}})));
  Modelica.Blocks.Math.Mean meanACPower(f=50)
    annotation (Placement(transformation(extent={{70,-92},{90,-72}})));
  Modelica.Blocks.Sources.RealExpression vdcSense(y = PV.v) annotation(
    Placement(visible = true, transformation(extent = {{-98, -132}, {-78, -112}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression iacSense(y = L.i) annotation(
    Placement(visible = true, transformation(extent = {{-98, -42}, {-78, -22}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant idSetpoint(k = 400) annotation(
    Placement(visible = true, transformation(extent = {{-98, -12}, {-78, 8}}, rotation = 0)));
  PVSystems.Control.Assemblies.Inverter1phCurrentController control(d(start = 0.5)) annotation(
    Placement(visible = true, transformation(origin = {-18, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant iqSetpoint(k = 0) annotation(
    Placement(visible = true, transformation(extent = {{-98, -72}, {-78, -52}}, rotation = 0)));
  Modelica.Blocks.Sources.Cosine vacEmulation(freqHz = 50) annotation(
    Placement(visible = true, transformation(extent = {{-98, -104}, {-78, -84}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor R(R = 1e-2) annotation(
    Placement(visible = true, transformation(origin = {86, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  PVSystems.Control.PLL pll annotation(
    Placement(visible = true, transformation(origin = {-52, -94}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
equation
  connect(Gn.y, PV.G) annotation(
    Line(points = {{-59, 80}, {-52, 80}, {-52, 73}, {-45.5, 73}}, color = {0, 0, 127}));
  connect(Tn.y, PV.T) annotation(
    Line(points = {{-59, 40}, {-52, 40}, {-52, 67}, {-45.5, 67}}, color = {0, 0, 127}));
  connect(Cdc.p, Inverter.p1) annotation(
    Line(points = {{24, 80}, {34, 80}, {34, 75}, {40, 75}}, color = {0, 0, 255}));
  connect(Cdc.n, Inverter.n1) annotation(
    Line(points = {{24, 60}, {34, 60}, {34, 65}, {40, 65}}, color = {0, 0, 255}));
  connect(Inverter.p2, L.p) annotation(
    Line(points = {{60, 75}, {70, 75}, {70, 80}, {86, 80}}, color = {0, 0, 255}));
  connect(PV.n, Cdc.n) annotation(
    Line(points = {{-40, 60}, {24, 60}}, color = {0, 0, 255}));
  connect(PV.n, ground.p) annotation(
    Line(points = {{-40, 60}, {-10, 60}}, color = {0, 0, 255}));
  connect(ACPower.y, meanACPower.u) annotation(
    Line(points = {{61, -82}, {64.5, -82}, {68, -82}}, color = {0, 0, 127}));
  connect(PV.p, Cdc.p) annotation(
    Line(points = {{-40, 80}, {24, 80}, {24, 80}, {24, 80}}, color = {0, 0, 255}));
  connect(vdcSense.y, control.vdc) annotation(
    Line(points = {{-77, -122}, {-14, -122}, {-14, -44}}, color = {0, 0, 127}));
  connect(idSetpoint.y, control.ids) annotation(
    Line(points = {{-77, -2}, {-30, -2}, {-30, -26}}, color = {0, 0, 127}));
  connect(iacSense.y, control.i) annotation(
    Line(points = {{-77, -32}, {-30, -32}}, color = {0, 0, 127}));
  connect(iqSetpoint.y, control.iqs) annotation(
    Line(points = {{-77, -62}, {-30, -62}, {-30, -38}}, color = {0, 0, 127}));
  connect(control.d, Inverter.d) annotation(
    Line(points = {{-6, -32}, {52, -32}, {52, 58}, {50, 58}}, color = {0, 0, 127}));
  connect(R.p, L.n) annotation(
    Line(points = {{86, 44}, {86, 44}, {86, 60}, {86, 60}}, color = {0, 0, 255}));
  connect(R.n, Inverter.n2) annotation(
    Line(points = {{86, 24}, {86, 24}, {86, 18}, {68, 18}, {68, 64}, {60, 64}, {60, 66}}, color = {0, 0, 255}));
  connect(vacEmulation.y, pll.v) annotation(
    Line(points = {{-76, -94}, {-66, -94}, {-66, -94}, {-64, -94}}, color = {0, 0, 127}));
  connect(pll.theta, control.theta) annotation(
    Line(points = {{-40, -94}, {-22, -94}, {-22, -44}, {-22, -44}}, color = {0, 0, 127}));
  annotation (Icon(graphics), experiment(StopTime=28, Interval=0.001),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
        <p>
          This example represents a simple yet complete grid-tied
          PV inverter system. A long simulation is performed so as
          to visualize the time evolution of the MPPT control,
          which is necessarily much slower than the output current
          control. This long simulation time is manageable because
          an averaged switch model is being used, which means that
          the simulation can have longer time steps.
        </p>
      
        <p>
          This evolution can be observed by plotting the DC bus
          voltage as well as the input and output power to the
          inverter:
        </p>
      
      
        <div class=\"figure\">
          <p><img src=\"modelica://PVSystems/Resources/Images/PVInverter1phSynchResultsA.png\"
                  alt=\"PVInverter1phSynchResultsA.png\" />
          </p>
        </div>
      
        <p>
          As expected, the power factor of the output power is 1
          (all active power), having the output current in synch
          with the grid voltage:
        </p>
      
      
        <div class=\"figure\">
          <p><img src=\"modelica://PVSystems/Resources/Images/PVInverter1phSynchResultsB.png\"
                  alt=\"PVInverter1phSynchResultsB.png\" /></p>
        </div>
      </html>"));

end PVFarm2;
