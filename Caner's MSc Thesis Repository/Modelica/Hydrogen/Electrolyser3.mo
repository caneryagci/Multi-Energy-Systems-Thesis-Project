within Hydrogen;

model Electrolyser3

//extends Modelica.Electrical.Analog.Interfaces.OnePort;
  import SI = Modelica.SIunits;
  import Modelica.Constants.pi;
  import Modelica.Math;
  import ModelicaReference.Operators;
  import Modelica.ComplexMath;
  
  parameter Real Vstd = 1.23 "Cell voltage at standard conditions";
  parameter Real Top_0 = 333.15 "Anode side cell membrane average temperature";
  parameter Real Tstd = 298.15 "Standard Temperature";
  parameter Real F = 96485 "Faraday constant";
  parameter Real R = 8.314 "ideal gas constant";
  parameter Real Cth= 162116 "J/K";
  parameter Real Rth = 0.0668 "K/W";
  parameter Real Tamb = 296;
  
  Modelica.SIunits.Voltage Vcell "Cell Voltage";
  Real Vocv "Open-circuit Voltage";
  Real Vact "Activation Overpotential";
  Real Vohm "Ohmic Overpotential";
  Real Vrev "Reverse cell voltage";
  Real Top (start=Top_0);
  SI.Power Pdc "Electric power input of the electrolyzer";
  //Real Pdc_mw "Electric power input of the electrolyzer in MW";
  //SI.Power Pel "Electric power consumed by the electrolyzer";
  Real ppH_atm;
  Real ppO_atm;
  Real ppHtO_atm;
  Real ppH_Pa;
  Real ppO_Pa;
  Real ppHtO_Pa;
  Real Qelectrolysis;
  parameter Real Wpump=1100*0.75;
  Real Qloss;
  Real Hloss;
  Real CpH;
  Real CpO;
  
  parameter Real Ibase = 400;
  parameter Real Vbase = 1000;
  parameter Real Pcat = 30;
  parameter Real Pan = 30;
  parameter Real alfa_an = 0.7353 "charge transfer coefficient at anode";
  parameter Real i_an_std = 1.08e-4 "exchange current density anode at standard temperature(A/m2)";
  parameter Real i_an = 1.0205e-3 "exchange current density anode(A/m2)";
  parameter Real Eexc = 52994 "Activation energy for electron transport in anode";
  parameter Real Epro = 10536 "Activation energy for proton transport in membrane";
  parameter Real A = 290 "Membrane Area(m2)";
  parameter Real Smem = 178e-6 "Membrane thickness(m)";
  Modelica.SIunits.Current Icell "DC input current";
  Real jcell "Cell current density(A/m2)";
  Real sigma_mem "Membrane Conductivity";
  parameter Real sigma_mem_std = 10.31 "Membrane conductivity at standard temperature S/m";
  //Real Q "Heat produced by cell";
  Real Rmem;
  parameter Real Vtn = 1.48 "minimum energy in form of electricity to heat to perform electrolysis(V)";
  //parameter Real n_cells = 500*200 "number of series cells";
  parameter Real n_cells_series = 60 "number of series cells";
  parameter Real n_cells_parallel = 1 "number of parallel cells";
  parameter Real LHV = 3.0 "Lower heating value hydrogen";
  //Real nH "Total hydrogen production rate in Nm3/h";
  Real nO "Total oxygen production rate";
  Real efficiency1;
  Real efficiency2;
  //Real i_an;
  //Real Vdc;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = Tstd);
  Modelica.Blocks.Interfaces.RealInput nH (start=100) annotation(
    Placement(visible = true, transformation(origin = {-100, 78}, extent = {{-14, -14}, {14, 14}}, rotation = 0), iconTransformation(origin = {-86, 66}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pdc_mw annotation(
    Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Vdc annotation(
    Placement(visible = true, transformation(origin = {92, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Idc annotation(
    Placement(visible = true, transformation(origin = {92, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
//Voltages
  Vcell = Vocv + Vact + Vohm;
  Vrev = Vstd - 0.0009 * (Top - Tstd);
  Vocv = Vrev + R * Top / (2 * F) * Modelica.Math.log(ppH_atm * sqrt(ppO_atm) / ppHtO_atm);
  Vact = R * Top / (2 * alfa_an * F) * Modelica.Math.asinh(jcell / (2 * i_an));
  Vohm = Rmem * jcell;
//Ohmic resistance
  Rmem = Smem / sigma_mem;
  sigma_mem = sigma_mem_std * Modelica.Math.exp(Epro / R * (1 / Top - 1 / Tstd));
//Current and Current density
  //i_an = i_an_std * Modelica.Math.exp(-1 * Eexc / R * (1 / Top / (1 / Tstd)));
  jcell * A = Icell;
  Pdc  = (Icell*n_cells_parallel)* (Vcell*n_cells_series);
  Pdc_mw=Pdc/30e9;
//Partial pressures
  ppHtO_Pa = 6.1078e-3 * Modelica.Math.exp(17.2694 * ((Top - 273.15) / (Top - 34.85)));
  ppH_Pa = Pcat - ppHtO_Pa;
  ppO_Pa = Pan - ppHtO_Pa;
//Convert from Pa to atm
  ppH_atm = ppH_Pa / 101325;
  ppO_atm = ppO_Pa / 101325;
  ppHtO_atm = ppHtO_Pa / 101325;
//Heat Loss from Electric Power
//Q = (Vcell - Vtn) * Icell * n_cells_series;
//Mass,molar/flow equations
  nH = n_cells_series * n_cells_parallel * Icell / (2 * F);
//nH = n_cells * Icell / (2 * F) * (22.414 * 3.6);
//(Nm3/h)/(mol/s)
  nO = n_cells_series * n_cells_parallel * Icell / (4 * F);
//Thermal submodel
  der(Top) = (Qelectrolysis + Wpump - Qloss - Hloss) / Cth;
  Qelectrolysis = (Vcell - Vtn) * Icell * n_cells_series;
  Qloss= 1/Rth*(Top-Tamb);
  Hloss=nH*CpH*(Top-Tamb)+nO*CpO*(Top-Tamb);
  CpH=(29.11-1.92e-3*Top+4e-6*Top^2-8.7e-10*Top^3);
  CpO=(25.48+1.52e-2*Top-7.16e-6*Top^2+1.31e-9*Top^3);
//efficiency
  efficiency1 = nH * 3000 / Pdc;
// LHV*kW(=3000)
  efficiency2 = 1.25 / Vcell;
//Pin
  Vdc = Vcell * n_cells_series;
 Idc = Icell * n_cells_parallel;
//Icell = p.i;
  LossPower = Qelectrolysis;
  annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {16, -9}, lineColor = {0, 0, 255}, extent = {{-68, 49}, {48, -29}}, textString = "Electrolyser"), Text(origin = {-83, 91}, extent = {{-9, 5}, {49, -17}}, textString = "nH2i_set"), Text(origin = {78, 74}, extent = {{-48, 14}, {8, -4}}, textString = "Pdc_MW"), Text(origin = {70, 27}, extent = {{-32, 27}, {8, -5}}, textString = "Vdc"), Text(origin = {53, -25}, extent = {{-7, 5}, {29, -27}}, textString = "Idc")}, coordinateSystem(initialScale = 0.1)),
  Diagram);




end Electrolyser3;
