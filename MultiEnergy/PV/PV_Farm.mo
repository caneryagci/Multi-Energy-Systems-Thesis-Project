within PV;

model PV_Farm
  Modelica.Blocks.Sources.CombiTimeTable alfa(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/MultiEnergy/PV/alfa(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-160, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable beta(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/MultiEnergy/PV/beta(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-160, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable B_int(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/MultiEnergy/PV/B_int(hourly).txt", tableName = "tab1", tableOnFile = true)  annotation(
    Placement(visible = true, transformation(origin = {-160, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PV.Irradiance irradiance annotation(
    Placement(visible = true, transformation(origin = {-100, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground groundDC annotation(
    Placement(visible = true, transformation(origin = {-16, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor annotation(
    Placement(visible = true, transformation(extent = {{4, 28}, {24, 48}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(extent = {{114, -108}, {134, -88}}, rotation = 0)));
  PhotoVoltaics.Components.SimplePhotoVoltaics.SimplePlantSymmetric simplePlantSymmetric(moduleData = moduleData, useConstantIrradiance = true) annotation(
    Placement(visible = true, transformation(origin = {-34, 24}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Blocks.Math.Division powerFactorActual annotation(
    Placement(visible = true, transformation(extent = {{-26, -102}, {-46, -82}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Basic.Star star annotation(
    Placement(visible = true, transformation(origin = {124, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor(m = 3) annotation(
    Placement(visible = true, transformation(origin = {94, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(extent = {{74, -102}, {54, -82}}, rotation = 0)));
  PhotoVoltaics.Components.Converters.MultiPhaseConverter converter annotation(
    Placement(visible = true, transformation(extent = {{34, 8}, {54, 28}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerSensorGrid annotation(
    Placement(visible = true, transformation(extent = {{64, 8}, {84, 28}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = Modelica.Constants.inf, uMin = Modelica.Constants.small) annotation(
    Placement(visible = true, transformation(extent = {{16, -102}, {-4, -82}}, rotation = 0)));
  PhotoVoltaics.Components.Blocks.MPTrackerSample mpTracker(ImpRef = moduleData.ImpRef, VmpRef = moduleData.VmpRef, samplePeriod = 0.1) annotation(
    Placement(visible = true, transformation(extent = {{14, -32}, {34, -12}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 3) annotation(
    Placement(visible = true, transformation(extent = {{44, -102}, {24, -82}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Sources.CosineVoltage cosineVoltage(V = fill(400 * sqrt(2 / 3), 3), freqHz = fill(50, 3), phase = -Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(3)) annotation(
    Placement(visible = true, transformation(origin = {124, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Sources.Constant powerfactor(k = -acos(0.9)) annotation(
    Placement(visible = true, transformation(extent = {{14, -64}, {34, -44}}, rotation = 0)));
  Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(m = 3) annotation(
    Placement(visible = true, transformation(origin = {124, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  parameter PhotoVoltaics.Records.SHARP_NU_S5_E3E moduleData annotation(
    Placement(visible = true, transformation(extent = {{104, 48}, {124, 68}}, rotation = 0)));
equation
  connect(powerSensorGrid.nv, star.plug_p) annotation(
    Line(points = {{74, 8}, {74, -62}, {124, -62}}, color = {0, 0, 255}));
  connect(simplePlantSymmetric.n, groundDC.p) annotation(
    Line(points = {{-34, 14}, {-16, 14}, {-16, -2}}, color = {0, 0, 255}));
  connect(converter.dc_p, powerSensor.nc) annotation(
    Line(points = {{34, 24}, {34, 38}, {24, 38}}, color = {0, 0, 255}));
  connect(powerFactorActual.u1, powerSensorGrid.power) annotation(
    Line(points = {{-24, -86}, {-24, -60}, {64, -60}, {64, 7}}, color = {0, 0, 127}));
  connect(gain.u, product.y) annotation(
    Line(points = {{46, -92}, {53, -92}}, color = {0, 0, 127}));
  connect(powerfactor.y, converter.phi) annotation(
    Line(points = {{35, -54}, {50, -54}, {50, 6}}, color = {0, 0, 127}));
  connect(converter.dc_n, groundDC.p) annotation(
    Line(points = {{34, 12}, {34, -2}, {-16, -2}}, color = {0, 0, 255}));
  connect(mpTracker.vRef, converter.vDCRef) annotation(
    Line(points = {{35, -22}, {38, -22}, {38, 6}}, color = {0, 0, 127}));
  connect(voltageQuasiRMSSensor.plug_p, currentQuasiRMSSensor.plug_n) annotation(
    Line(points = {{94, -32}, {94, -12}, {124, -12}}, color = {0, 0, 255}));
  connect(currentQuasiRMSSensor.plug_n, cosineVoltage.plug_p) annotation(
    Line(points = {{124, -12}, {124, -32}}, color = {0, 0, 255}));
  connect(powerSensor.pc, powerSensor.pv) annotation(
    Line(points = {{4, 38}, {4, 48}, {14, 48}}, color = {0, 0, 255}));
  connect(voltageQuasiRMSSensor.plug_n, star.plug_p) annotation(
    Line(points = {{94, -52}, {94, -62}, {124, -62}}, color = {0, 0, 255}));
  connect(converter.ac, powerSensorGrid.pc) annotation(
    Line(points = {{54, 18}, {64, 18}}, color = {0, 0, 255}));
  connect(limiter.y, powerFactorActual.u2) annotation(
    Line(points = {{-5, -92}, {-24, -92}, {-24, -98}}, color = {0, 0, 127}));
  connect(powerSensorGrid.nc, currentQuasiRMSSensor.plug_p) annotation(
    Line(points = {{84, 18}, {124, 18}, {124, 8}}, color = {0, 0, 255}));
  connect(cosineVoltage.plug_n, star.plug_p) annotation(
    Line(points = {{124, -52}, {124, -62}}, color = {0, 0, 255}));
  connect(limiter.u, gain.y) annotation(
    Line(points = {{18, -92}, {23, -92}}, color = {0, 0, 127}));
  connect(powerSensorGrid.pv, powerSensorGrid.pc) annotation(
    Line(points = {{74, 28}, {64, 28}, {64, 18}}, color = {0, 0, 255}));
  connect(product.u2, voltageQuasiRMSSensor.V) annotation(
    Line(points = {{76, -98}, {76, -42}, {83, -42}}, color = {0, 0, 127}));
  connect(mpTracker.power, powerSensor.power) annotation(
    Line(points = {{12, -22}, {4, -22}, {4, 27}}, color = {0, 0, 127}));
  connect(powerSensor.nv, groundDC.p) annotation(
    Line(points = {{14, 28}, {14, -2}, {-16, -2}}, color = {0, 0, 255}));
  connect(ground.p, star.pin_n) annotation(
    Line(points = {{124, -88}, {124, -82}}, color = {0, 0, 255}));
  connect(simplePlantSymmetric.p, powerSensor.pc) annotation(
    Line(points = {{-34, 34}, {-34, 38}, {4, 38}}, color = {0, 0, 255}));
  connect(product.u1, currentQuasiRMSSensor.I) annotation(
    Line(points = {{76, -86}, {76, -2}, {113, -2}}, color = {0, 0, 127}));
  connect(alfa.y[1], irradiance.alfa) annotation(
    Line(points = {{-148, 48}, {-118, 48}, {-118, 30}, {-110, 30}, {-110, 30}}, color = {0, 0, 127}));
  connect(beta.y[1], irradiance.beta) annotation(
    Line(points = {{-148, 18}, {-122, 18}, {-122, 24}, {-110, 24}, {-110, 24}}, color = {0, 0, 127}));
  connect(B_int.y[1], irradiance.B_int) annotation(
    Line(points = {{-148, -14}, {-116, -14}, {-116, 18}, {-110, 18}, {-110, 18}}, color = {0, 0, 127}));
  connect(irradiance.Irradiance, simplePlantSymmetric.variableIrradiance) annotation(
    Line(points = {{-90, 24}, {-48, 24}, {-48, 24}, {-46, 24}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
end PV_Farm;
