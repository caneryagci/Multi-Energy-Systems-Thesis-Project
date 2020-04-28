model Gas_grid
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Voltage Vrms=110 "RMS supply voltage";
  parameter Modelica.SIunits.Frequency f=50 "Frequency";
  parameter Modelica.SIunits.Angle constantFiringAngle=30*pi/180
    "Firing angle";
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-80, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage(V = sqrt(2) * Vrms, freqHz = f) annotation(
    Placement(visible = true, transformation(origin = {-80, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.PowerConverters.ACDC.Control.VoltageBridge2Pulse pulse2(constantFiringAngle = constantFiringAngle, f = f, useFilter = false) annotation(
    Placement(visible = true, transformation(origin = {-30, -2}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
  Modelica.Electrical.PowerConverters.ACDC.HalfControlledBridge2Pulse rectifier(offStart_p1 = true, offStart_p2 = true, useHeatPort = false) annotation(
    Placement(visible = true, transformation(extent = {{-40, 24}, {-20, 44}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor annotation(
    Placement(visible = true, transformation(origin = {50, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(
    Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  electrolyser electrolyser1(n_cells = 10)  annotation(
    Placement(visible = true, transformation(origin = {10, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(rectifier.ac_n, pulse2.ac_n) annotation(
    Line(points = {{-40, 28}, {-50, 28}, {-50, -8}, {-40, -8}}, color = {0, 0, 255}));
  connect(ground.p, sinevoltage.n) annotation(
    Line(points = {{-80, -40}, {-80, 10}}, color = {0, 0, 255}));
  connect(sinevoltage.p, rectifier.ac_p) annotation(
    Line(points = {{-80, 30}, {-80, 40}, {-40, 40}}, color = {0, 0, 255}));
  connect(pulse2.ac_p, rectifier.ac_p) annotation(
    Line(points = {{-40, 4}, {-60, 4}, {-60, 40}, {-40, 40}}, color = {0, 0, 255}));
  connect(pulse2.fire_p, rectifier.fire_p) annotation(
    Line(points = {{-36, 9}, {-36, 22}}, color = {255, 0, 255}));
  connect(rectifier.dc_p, voltagesensor.p) annotation(
    Line(points = {{-20, 40}, {50, 40}, {50, 20}}, color = {0, 0, 255}));
  connect(pulse2.fire_n, rectifier.fire_n) annotation(
    Line(points = {{-24, 9}, {-24, 22}}, color = {255, 0, 255}));
  connect(voltagesensor.n, currentSensor.p) annotation(
    Line(points = {{50, 0}, {50, -40}, {10, -40}}, color = {0, 0, 255}));
  connect(rectifier.dc_n, currentSensor.n) annotation(
    Line(points = {{-20, 28}, {-10, 28}, {-10, -40}}, color = {0, 0, 255}));
  connect(sinevoltage.n, rectifier.ac_n) annotation(
    Line(points = {{-80, 10}, {-80, 10}, {-80, -8}, {-50, -8}, {-50, 28}, {-40, 28}}, color = {0, 0, 255}));
  connect(electrolyser1.p, rectifier.dc_p) annotation(
    Line(points = {{10, 14}, {10, 40}, {-20, 40}}, color = {0, 0, 255}));
  connect(electrolyser1.n, currentSensor.p) annotation(
    Line(points = {{10, -6}, {10, -40}}, color = {0, 0, 255}));
protected
  annotation(
    uses(Modelica(version = "3.2.3"), PhotoVoltaics(version = "1.6.0")));
end Gas_grid;
