model electrolyser
  import SI = Modelica.SIunits;
  import Modelica.Constants.pi;
  import Modelica.Math;
  import ModelicaReference.Operators;
  import Modelica.ComplexMath;
  parameter SI.Temperature T_out = 283.15 "Hydrogen output temperature" annotation(
    Dialog(group = "Fundamental Definitions"));
  parameter SI.ActivePower P_el_n = 1e6 "Nominal power of the electrolyzer" annotation(
    Dialog(group = "Fundamental Definitions"));
  parameter SI.ActivePower P_el_max = 3 * P_el_n "Maximum power of the electrolyzer" annotation(
    Dialog(group = "Fundamental Definitions"));
  parameter SI.Voltage Vstd = 1.23 "Cell voltage at standard conditions";
  parameter SI.Temperature Top = 333.15 "Anode side cell membrane average temperature";
  parameter SI.Temperature Tstd = 298.15 "Standard Temperature";
  parameter Real F = 96485 "Faraday constant";
  parameter Real R = 8.314 "ideal gas constant";
  SI.Voltage Vcell "Cell Voltage";
  SI.Voltage Vocv "Open-circuit Voltage";
  SI.Voltage Vact "Activation Overpotential";
  SI.Voltage Vohm "Ohmic Overpotential";
  SI.Voltage Vrev "Reverse cell voltage";
  //SI.Power P_el "Electric power consumed by the electrolyzer";
  Real ppH_atm;
  Real ppO_atm;
  Real ppHtO_atm;
  SI.Pressure ppH_Pa;
  SI.Pressure ppO_Pa;
  SI.Pressure ppHtO_Pa;
  parameter SI.Pressure Pcat = 30;
  parameter SI.Pressure Pan = 30;
  parameter Real alfa_an = 0.7353 "charge transfer coefficient at anode";
  parameter SI.CurrentDensity i_an_std = 1.08e-4 "exchange current density anode at standard temperature(A/m2)";
  SI.CurrentDensity i_an "exchange current density anode(A/m2)";
  parameter SI.Energy Eexc = 52994 "Activation energy for electron transport in anode";
  parameter Real Epro = 10536 "Activation energy for proton transport in membrane";
  parameter SI.Area A = 290 "Membrane Area(m2)";
  parameter Real Smem = 178e-6 "Membrane thickness(m)";
  SI.Current Idc "DC input current";
  SI.CurrentDensity icell "Cell current density(A/m2)";
  Real sigma_mem "Membrane Conductivity";
  parameter SI.Conductivity sigma_mem_std = 10.31 "Membrane conductivity at standard temperature";
  Real u;
  SI.Resistance Rmem;
  Modelica.Blocks.Interfaces.RealInput Pdc(final quantity = "Power", final unit = "W") annotation(
    Placement(visible = true, transformation(origin = {-78, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-78, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

equation
//Voltages
  Vcell = Vocv + Vact + Vohm;
  Vrev = Vstd - 0.0009 * (Top - Tstd);
  Vocv = Vrev + R * Top / (2 * F) * log(ppH_atm * sqrt(ppO_atm) / ppHtO_atm);
  u = icell / (2 * i_an);
  Vact = R * Top / (2 * alfa_an * F) * log(u + sqrt(u * u + 1));
  Vohm = Rmem * icell;
//Ohmic resistance
  Rmem = Smem / sigma_mem;
  sigma_mem = sigma_mem_std * exp(Epro / R * (1 / Top - 1 / Tstd));
//Current and Current density
  i_an = i_an_std * exp(-1 * Eexc / R * (1 / Top / (1 / Tstd)));
  icell * A = Idc;
  Idc = Pdc / Vcell;
//Partial pressures
  ppHtO_Pa = 6.1078e-3 * exp(17.2694 * ((Top - 273.15) / (Top - 34.85)));
  ppH_Pa = Pcat - ppHtO_Pa;
  ppO_Pa = Pan - ppHtO_Pa;
//Convert from Pa to atm
  ppH_Pa = ppH_atm * 101325;
  ppO_Pa = ppO_atm * 101325;
  ppHtO_Pa = ppO_atm * 101325;
  annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Text(origin = {-92, -24}, extent = {{-6, 0}, {14, -4}}, textString = "Pdc"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)));
end electrolyser;
