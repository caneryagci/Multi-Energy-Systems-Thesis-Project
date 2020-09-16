within Wind;

model Windfarm

  inner PowerGrids.Electrical.System systemPowerGrids annotation(
    Placement(visible = true, transformation(origin = {130, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  PowerGrids.Types.PerUnit AA_01_GEN_UPu = GEN.port.VPu "Fig. 5-3, terminal voltage";
  PowerGrids.Types.PerUnit AA_02_GEN_PPu = GEN.port.PGenPu "Fig. 5-4, active power of the synchronous machine";
  PowerGrids.Types.PerUnit AA_03_GEN_PmechPu = GEN.PmPu "Fig. 5-5, mechanical power of the synchronous machine";
  PowerGrids.Types.PerUnit AA_04_GEN_omegaPu = GEN.omegaPu "Fig. 5-6, speed";
  Wind.Rotor rotor annotation(
    Placement(visible = true, transformation(origin = {-50, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable windspeed(fileName = "C:/Users/Caner/Desktop/Multi-Energy-Systems-Thesis-Project/Co_simulation/Base Case/windspeed.txt", smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, tableName = "tab1", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-130, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression zero2 annotation(
    Placement(visible = true, transformation(origin = {-8, -62}, extent = {{-12, -10}, {12, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression zero annotation(
    Placement(visible = true, transformation(origin = {-104, -40}, extent = {{-12, -10}, {12, 10}}, rotation = 0)));
  PowerGrids.Electrical.Loads.LoadImpedancePQInputs LOAD(PStart = 3.8e+08, SNom = 4.75e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true) annotation(
    Placement(visible = true, transformation(origin = {32, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step PLoad(height = 30e3, offset = 380e3, startTime = 2) annotation(
    Placement(visible = true, transformation(origin = {-8, -34}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  PowerGrids.Electrical.Buses.ReferenceBus NGEN(SNom = 5e+08, UNom = 21000, portVariablesPhases = true, portVariablesPu = true) annotation(
    Placement(visible = true, transformation(origin = {24, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  PowerGrids.Electrical.Controls.ExcitationSystems.IEEE_AC4A AVR(Ka = 200, Ta = 0.05, Tb = 10, Tc = 3, VrMax = 4) annotation(
    Placement(visible = true, transformation(origin = {-62, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression VrefPu(y = 1.00943) annotation(
    Placement(visible = true, transformation(origin = {-104, -25}, extent = {{-12, -11}, {12, 11}}, rotation = 0)));
  PowerGrids.Electrical.Machines.SynchronousMachine4Windings GEN(H = 4, PStart = -3.8e+08, QStart = 0, SNom = 4.75e+08, Tpd0 = 5.143, Tppd0 = 0.042, Tppq0 = 0.083, Tpq0 = 2.16, UNom = 21000, UPhaseStart = 0, UStart = 21000, portVariablesPhases = true, raPu = 0, referenceGenerator = true, xdPu = 2, xlPu = 0.15, xpdPu = 0.35, xppdPu = 0.25, xppqPu = 0.3, xpqPu = 0.5, xqPu = 1.8) annotation(
    Placement(visible = true, transformation(origin = {-26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(windspeed.y[1], rotor.windspeed) annotation(
    Line(points = {{-118, 54}, {-80, 54}, {-80, 66}, {-58, 66}, {-58, 66}}, color = {0, 0, 127}));
  connect(zero2.y, LOAD.QRefIn) annotation(
    Line(points = {{6, -62}, {10, -62}, {10, -48}, {22, -48}, {22, -48}}, color = {0, 0, 127}));
  connect(PLoad.y, LOAD.PRefIn) annotation(
    Line(points = {{1, -34}, {10, -34}, {10, -42}, {22, -42}}, color = {0, 0, 127}));
  connect(NGEN.terminal, LOAD.terminal) annotation(
    Line(points = {{24, -20}, {32, -20}, {32, -38}}));
  connect(zero.y, AVR.VsPu) annotation(
    Line(points = {{-91, -40}, {-80, -40}, {-80, -10}, {-72, -10}}, color = {0, 0, 127}));
  connect(zero.y, AVR.VuelPu) annotation(
    Line(points = {{-91, -40}, {-79.8, -40}, {-79.8, -22}, {-71.8, -22}}, color = {0, 0, 127}));
  connect(VrefPu.y, AVR.VrefPu) annotation(
    Line(points = {{-91, -25}, {-85.8, -25}, {-85.8, -18}, {-71.8, -18}}, color = {0, 0, 127}));
  connect(rotor.p_wind, GEN.PmPu) annotation(
    Line(points = {{-39, 73}, {-20, 73}, {-20, 30}, {-52, 30}, {-52, 4}, {-36, 4}}, color = {0, 0, 127}));
  connect(GEN.omegaPu, rotor.omega_m) annotation(
    Line(points = {{-16, 2}, {24, 2}, {24, 88}, {-72, 88}, {-72, 73}, {-58, 73}}, color = {0, 0, 127}));
  connect(GEN.terminal, NGEN.terminal) annotation(
    Line(points = {{-26, 0}, {-26, -10}, {-26, -10}, {-26, -20}, {-2, -20}, {-2, -20}, {24, -20}}));
  connect(AVR.efdPu, GEN.ufPuIn) annotation(
    Line(points = {{-51, -16}, {-48.5, -16}, {-48.5, -16}, {-44, -16}, {-44, -4}, {-41, -4}, {-41, -4}, {-36, -4}}, color = {0, 0, 127}));
  connect(GEN.VPu, AVR.VcPu) annotation(
    Line(points = {{-16, -6}, {0, -6}, {0, 20}, {-86, 20}, {-86, -14}, {-72, -14}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-180, -100}, {180, 100}})),
    experiment(StartTime = 0, StopTime = 2, Tolerance = 1e-6, Interval = 0.004),
    __OpenModelica_commandLineOptions = "--daeMode --tearingMethod=minimalTearing",
    __OpenModelica_simulationFlags(nls="kinsol", lv="LOG_INIT_HOMOTOPY", homotopyOnFirstTry="()"), experiment(StartTime = 0, StopTime = 15, Tolerance = 1e-06, Interval = 0.015),
  uses(Modelica(version = "3.2.3")));


end Windfarm;
