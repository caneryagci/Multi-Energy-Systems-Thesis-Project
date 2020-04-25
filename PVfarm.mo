model PVfarm
  IR ir annotation(
    Placement(visible = true, transformation(origin = {-112, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable alfa(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/alfa(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-166, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable beta(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/beta(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-162, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable B_int(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/PV Farm/B_int(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-164, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter PhotoVoltaics.Records.SHARP_NU_S5_E3E moduleData annotation(
    Placement(visible = true, transformation(extent = {{60, 60}, {80, 80}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerSensorGrid annotation(
    Placement(visible = true, transformation(extent = {{20, 20}, {40, 40}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = Modelica.Constants.inf, uMin = Modelica.Constants.small) annotation(
    Placement(visible = true, transformation(extent = {{-28, -90}, {-48, -70}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor(m = 3) annotation(
    Placement(visible = true, transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Math.Division powerFactorActual annotation(
    Placement(visible = true, transformation(extent = {{-70, -90}, {-90, -70}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{70, -96}, {90, -76}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 3) annotation(
    Placement(visible = true, transformation(extent = {{0, -90}, {-20, -70}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(extent = {{30, -90}, {10, -70}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Sources.CosineVoltage cosineVoltage(V = fill(400 * sqrt(2 / 3), 3), freqHz = fill(50, 3), phase = -Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(3)) annotation(
    Placement(visible = true, transformation(origin = {80, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.MultiPhase.Basic.Star star annotation(
    Placement(visible = true, transformation(origin = {80, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation(
    Placement(visible = true, transformation(extent = {{-40, 40}, {-20, 60}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(m = 3) annotation(
    Placement(visible = true, transformation(origin = {80, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Basic.Ground groundDC annotation(
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant powerfactor(k = -acos(0.9)) annotation(
    Placement(visible = true, transformation(extent = {{-30, -52}, {-10, -32}}, rotation = 0)));
  PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(ImpRef = moduleData.ImpRef, VmpRef = moduleData.VmpRef, samplePeriod = 0.1) annotation(
    Placement(visible = true, transformation(extent = {{-30, -20}, {-10, 0}}, rotation = 0)));
  PhotoVoltaics.Components.Converters.MultiPhaseConverter converter annotation(
    Placement(visible = true, transformation(extent = {{-10, 20}, {10, 40}}, rotation = 0)));
  PhotoVoltaics.Components.SimplePhotoVoltaics.SimplePlantSymmetric simplePlantSymmetric(moduleData = moduleData, useConstantIrradiance = true)  annotation(
    Placement(visible = true, transformation(origin = {-78, 36}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
equation
  connect(alfa.y[1], ir.alfa) annotation(
    Line(points = {{-154, 20}, {-128, 20}, {-128, -2}, {-122, -2}}, color = {0, 0, 127}));
  connect(beta.y[1], ir.beta) annotation(
    Line(points = {{-150, -4}, {-130, -4}, {-130, -8}, {-122, -8}}, color = {0, 0, 127}));
  connect(B_int.y[1], ir.B_int) annotation(
    Line(points = {{-152, -36}, {-130, -36}, {-130, -14}, {-122, -14}}, color = {0, 0, 127}));
  connect(product.u1, currentQuasiRMSSensor.I) annotation(
    Line(points = {{32, -74}, {32, -74}, {34, -74}, {34, -32}, {34, 10}, {69, 10}}, color = {0, 0, 127}));
  connect(mpTracker.power, powerSensor.power) annotation(
    Line(points = {{-32, -10}, {-40, -10}, {-40, 39}}, color = {0, 0, 127}));
  connect(voltageQuasiRMSSensor.plug_n, star.plug_p) annotation(
    Line(points = {{50, -40}, {50, -50}, {80, -50}}, color = {0, 0, 255}));
  connect(powerSensorGrid.nc, currentQuasiRMSSensor.plug_p) annotation(
    Line(points = {{40, 30}, {54, 30}, {80, 30}, {80, 20}}, color = {0, 0, 255}));
  connect(currentQuasiRMSSensor.plug_n, cosineVoltage.plug_p) annotation(
    Line(points = {{80, 0}, {80, -6}, {80, -20}}, color = {0, 0, 255}));
  connect(voltageQuasiRMSSensor.plug_p, currentQuasiRMSSensor.plug_n) annotation(
    Line(points = {{50, -20}, {50, -10}, {80, -10}, {80, 0}}, color = {0, 0, 255}));
  connect(converter.dc_n, groundDC.p) annotation(
    Line(points = {{-10, 24}, {-10, 10}, {-60, 10}}, color = {0, 0, 255}));
  connect(limiter.u, gain.y) annotation(
    Line(points = {{-26, -80}, {-21, -80}}, color = {0, 0, 127}));
  connect(limiter.y, powerFactorActual.u2) annotation(
    Line(points = {{-49, -80}, {-60, -80}, {-60, -84}, {-60, -86}, {-68, -86}}, color = {0, 0, 127}));
  connect(ground.p, star.pin_n) annotation(
    Line(points = {{80, -76}, {80, -76}, {80, -74}, {80, -74}, {80, -70}, {80, -70}}, color = {0, 0, 255}));
  connect(converter.ac, powerSensorGrid.pc) annotation(
    Line(points = {{10, 30}, {16, 30}, {20, 30}}, color = {0, 0, 255}));
  connect(product.u2, voltageQuasiRMSSensor.V) annotation(
    Line(points = {{32, -86}, {38, -86}, {38, -30}, {39, -30}}, color = {0, 0, 127}));
  connect(mpTracker.vRef, converter.vDCRef) annotation(
    Line(points = {{-9, -10}, {-6, -10}, {-6, 18}}, color = {0, 0, 127}));
  connect(gain.u, product.y) annotation(
    Line(points = {{2, -80}, {9, -80}}, color = {0, 0, 127}));
  connect(powerSensor.pc, powerSensor.pv) annotation(
    Line(points = {{-40, 50}, {-40, 60}, {-30, 60}}, color = {0, 0, 255}));
  connect(powerFactorActual.u1, powerSensorGrid.power) annotation(
    Line(points = {{-68, -74}, {-60, -74}, {-60, -60}, {20, -60}, {20, 19}}, color = {0, 0, 127}));
  connect(converter.dc_p, powerSensor.nc) annotation(
    Line(points = {{-10, 36}, {-10, 50}, {-20, 50}}, color = {0, 0, 255}));
  connect(powerSensorGrid.nv, star.plug_p) annotation(
    Line(points = {{30, 20}, {30, 20}, {30, -2}, {30, -50}, {80, -50}}, color = {0, 0, 255}));
  connect(powerSensor.nv, groundDC.p) annotation(
    Line(points = {{-30, 40}, {-30, 40}, {-30, 12}, {-30, 10}, {-60, 10}}, color = {0, 0, 255}));
  connect(powerSensorGrid.pv, powerSensorGrid.pc) annotation(
    Line(points = {{30, 40}, {20, 40}, {20, 30}}, color = {0, 0, 255}));
  connect(cosineVoltage.plug_n, star.plug_p) annotation(
    Line(points = {{80, -40}, {80, -46}, {80, -50}}, color = {0, 0, 255}));
  connect(powerfactor.y, converter.phi) annotation(
    Line(points = {{-9, -42}, {6, -42}, {6, 18}}, color = {0, 0, 127}));
  connect(ir.Irradiance, simplePlantSymmetric.variableIrradiance) annotation(
    Line(points = {{-102, -8}, {-102, -8}, {-102, 36}, {-90, 36}, {-90, 36}}, color = {0, 0, 127}));
  connect(simplePlantSymmetric.n, groundDC.p) annotation(
    Line(points = {{-78, 26}, {-78, 26}, {-78, 16}, {-60, 16}, {-60, 10}, {-60, 10}}, color = {0, 0, 255}));
  connect(simplePlantSymmetric.p, powerSensor.pc) annotation(
    Line(points = {{-78, 46}, {-76, 46}, {-76, 50}, {-40, 50}, {-40, 50}}, color = {0, 0, 255}));
  annotation(
    uses(Modelica(version = "3.2.3"), PhotoVoltaics(version = "1.6.0")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "");
end PVfarm;
