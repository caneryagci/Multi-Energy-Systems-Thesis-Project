within Hydrogen;

model Electrolyser
  import SI = Modelica.SIunits;
  import Modelica.Constants.pi;
  import Modelica.Math;
  import ModelicaReference.Operators;
  import Modelica.ComplexMath;
  
  
  
  /*parameter SI.Temperature T_out = 283.15 "Hydrogen output temperature" annotation(
      Dialog(group = "Fundamental Definitions"));
    //parameter SI.ActivePower P_el_n = 1e6 "Nominal power of the electrolyzer" annotation(
      Dialog(group = "Fundamental Definitions"));
    parameter SI.ActivePower P_el_max = 3 * P_el_n "Maximum power of the electrolyzer" annotation(
      Dialog(group = "Fundamental Definitions"));
    */
  parameter Real Vstd = 1.23 "Cell voltage at standard conditions";
  parameter Real Top = 333.15 "Anode side cell membrane average temperature";
  parameter Real Tstd = 298.15 "Standard Temperature";
  parameter Real F = 96485 "Faraday constant";
  parameter Real R = 8.314 "ideal gas constant";
  Modelica.SIunits.Voltage Vcell "Cell Voltage";
  Real Vocv "Open-circuit Voltage";
  Real Vact "Activation Overpotential";
  Real Vohm "Ohmic Overpotential";
  Real Vrev "Reverse cell voltage";
  SI.Power Pdc "Electric power input of the electrolyzer";
  //SI.Power Pel "Electric power consumed by the electrolyzer";
  Real ppH_atm;
  Real ppO_atm;
  Real ppHtO_atm;
  Real ppH_Pa;
  Real ppO_Pa;
  Real ppHtO_Pa;
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
  parameter Real sigma_mem_std = 10.31 "Membrane conductivity at standard temperature";
  Real Q "Heat produced by cell";
  Real Rmem;
  parameter Real Vtn = 1.48 "minimum energy in form of electricity to heat to perform electrolysis(V)";
  parameter Real n_cells = 10 "number of cells";
  parameter Real LHV = 3.0 "Lower heating value hydrogen";
  //Real nH "Total hydrogen production rate in Nm3/h";
  Real nO "Total oxygen production rate";
  Real efficiency1;
  Real efficiency2;
  Modelica.Electrical.Analog.Interfaces.PositivePin p annotation(
    Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n annotation(
    Placement(visible = true, transformation(extent = {{110, -10}, {90, 10}}, rotation = 0), iconTransformation(extent = {{110, 24}, {90, 44}}, rotation = 0)));
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = Tstd);
  Modelica.Blocks.Interfaces.RealOutput nH annotation(
    Placement(visible = true, transformation(origin = {-1.9984e-15, 112}, extent = {{-14, -14}, {14, 14}}, rotation = 90), iconTransformation(origin = {-1.9984e-15, 112}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
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
//i_an = i_an_std *  Modelica.Math.exp(-1 * Eexc / R * (1 / Top / (1 / Tstd)));
  jcell * A = Icell;
  Icell * n_cells = Pdc / Vcell;
//Partial pressures
  ppHtO_Pa = 6.1078e-3 * Modelica.Math.exp(17.2694 * ((Top - 273.15) / (Top - 34.85)));
  ppH_Pa = Pcat - ppHtO_Pa;
  ppO_Pa = Pan - ppHtO_Pa;
//Convert from Pa to atm
  ppH_atm = ppH_Pa / 101325;
  ppO_atm = ppO_Pa / 101325;
  ppHtO_atm = ppHtO_Pa / 101325;
//Heat Loss from Electric Power
  Q = (Vcell - Vtn) * Icell * n_cells;
//Mass/flow equations
  nH = n_cells * Icell / (2 * F) * (22.414 * 3.6);//(Nm3/h)/(mol/s)
  nO = n_cells * Icell / (4 * F);
//efficiency
  efficiency1 = nH * 3000 / Pdc;// LHV*kW(=3000)
  efficiency2 = 1.25 / Vcell;
//Pin
  Vcell * n_cells = p.v - n.v;
  0 = p.i + n.i;
  Icell = p.i;
  LossPower = Q;
  annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)));
end Electrolyser;
