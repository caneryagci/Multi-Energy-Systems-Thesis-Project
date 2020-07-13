within Hydrogen;

model electrochemical
  import SI = Modelica.SIunits;
  import Modelica.Constants.pi;
  import Modelica.Math;
  import ModelicaReference.Operators;
  import Modelica.ComplexMath;
  parameter Real Sb=100 "System base(MVA)";
  parameter Real Pnom = 46000 "Nominal power (W)";
  parameter Real Vstd = 1.23 "Cell voltage at standard conditions";
  //Real Top (start=Top_0);
  parameter Real Tstd = 298.15 "Standard Temperature";
  parameter Real Tamb = 298.15;
  parameter Real F = 96485 "Faraday constant";
  parameter Real R = 8.314 "ideal gas constant";
  Real Vcell "Cell Voltage";
  Real Vocv "Open-circuit Voltage";
  Real Vact "Activation Overpotential";
  Real Vohm "Ohmic Overpotential";
  Real Vrev "Reverse cell voltage in standard conditions 1.229 at 298K";
  Real Pcell "Electric power input of the electrolyzer";
  //Real Pdc_mw "Electric power input of the electrolyzer in MW";
  //SI.Power Pel "Electric power consumed by the electrolyzer";
  parameter Real Pcat = 30;
  parameter Real Pan = 31;
  parameter Real alfa_an = 0.7353 "charge transfer coefficient at anode";
  parameter Real i_an_std = 1.08e-4 "exchange current density anode at standard temperature(A/m2)";
  
  parameter Real Eexc = 52994 "Activation energy for electron transport in anode";
  parameter Real Epro = 10536 "Activation energy for proton transport in membrane";
  parameter Real A_cm = 290 "Membrane Area(cm2)";
  parameter Real A_m = 290e-4 "membrane Area(m2)";
  parameter Real Smem = 178e-6 "Membrane thickness(m)";
  //Modelica.SIunits.Current Icell "DC input current";
  Real jcell "Cell current density(A/cm2)";
  Real sigma_mem "Membrane Conductivity";
  parameter Real sigma_mem_std = 10.31 "Membrane conductivity at standard temperature";
  //Real Wpem "Heat produced by cell";
  parameter Real Cth= 162116 "J/K";
  parameter Real Rth = 0.0668 "K/W";
  
  Real Rmem;
  parameter Real Vtn = 1.48 "minimum energy in form of electricity to heat to perform electrolysis(V)";
  parameter Real n_cells = 60 "number of cells";
  //parameter Real LHV = 3.0 "Lower heating value hydrogen";
  //Real nH "Total hydrogen production rate in Nm3/h";
  //Real efficiency1;
  Real efficiency2;
  //Real Pprod;
  
  //extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = Tstd);
  Modelica.Blocks.Interfaces.RealInput Pord annotation(
    Placement(visible = true, transformation(origin = {-100, 16}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 16}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  //initial equation
  //Pdc_mw=5;
  Modelica.Blocks.Interfaces.RealOutput Pout annotation(
    Placement(visible = true, transformation(origin = {110, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {108, 42}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));

//Real i_an(start=i_an_0);
  Modelica.Blocks.Interfaces.RealOutput Icell annotation(
    Placement(visible = true, transformation(origin = {110, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Wpem annotation(
    Placement(visible = true, transformation(origin = {110, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput ppHtO annotation(
    Placement(visible = true, transformation(origin = {-50, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-74, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput ppH annotation(
    Placement(visible = true, transformation(origin = {-10, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-10, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput ppO annotation(
    Placement(visible = true, transformation(origin = {28, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {50, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput Top annotation(
    Placement(visible = true, transformation(origin = {-100, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

protected
  parameter Real i_an_0 = 1.0205e-3 "exchange current density anode(A/m2)";
  parameter Real Top_0 = 333.15 "Anode side cell membrane average temperature";

initial equation
//i_an= i_an_0;
  Top= 323.15;

equation
//Voltages
  Vcell = Vocv + Vact + Vohm;
  Vrev = Vstd - 0.0009 * (Top - Tstd);
//Vrev = 1.5148-1.5421*1e-3*Top+9.523*1e-5*Top*log(Top)+9.84*1e-8*Top^2;
  Vocv = Vrev + R * Top / (2 * F) * Modelica.Math.log(ppH * sqrt(ppO) / ppHtO);
  Vact = R * Top / (2 * alfa_an * F) * Modelica.Math.asinh((jcell*1e4) / (2 * i_an_0));
  Vohm = Rmem * (jcell*1e4);
//Ohmic resistance
  Rmem = Smem / sigma_mem;
  sigma_mem = sigma_mem_std * Modelica.Math.exp(-(Epro / R) * (1 / Top - 1 / Tstd));
//Current and Current density
//i_an = i_an_std *  Modelica.Math.exp(-1 * Eexc / R * (1 / Top / (1 / Tstd)));
  jcell * A_cm = Icell;
  Icell = Pcell / Vcell;
//Icell = Pcell / Vcell * efficiency2;
  Pcell * n_cells = Pord * Pnom;
//Partial pressures
//ppHtO_atm = 6.1078e-3 * Modelica.Math.exp(17.2694 * ((Top - 273.15) / (Top - 34.85)));
//ppH_atm = Pcat - (ppHtO_atm/101325);
//ppO_atm = Pan - (ppHtO_atm/101325);
//Convert from Pa to atm
//ppH_atm = ppH_Pa / 101325;
//ppO_atm = ppO_Pa / 101325;
//ppHtO_atm = ppHtO_Pa / 101325;
//Heat Loss from Electric Power
//Mass/flow equations
//nH = n_cells * Icell / (2 * F);
//(Nm3/h)/(mol/s)
//nH_pu = nH/0.161;
//nO = n_cells * Icell / (4 * F);
/*Thermal submodel
  Cth * der(Top) = (Wpem + Wpump -Qcooling - Qloss - Hloss);
  Wpem = (Vcell - Vtn) * Icell * n_cells;
  Qloss = (1 / Rth) * (Top - Tamb);
  Hloss=nH*CpH*(Top-Tamb)+nO*CpO*(Top-Tamb);
  CpH=(29.11-1.92e-3*Top+4e-6*Top^2-8.7e-10*Top^3);
  CpO=(25.48+1.52e-2*Top-7.16e-6*Top^2+1.31e-9*Top^3);
*/
//efficiency
//efficiency1 = nH / (Pcell * n_cells);
  Wpem = (Vcell - Vtn) * Icell * n_cells;
// LHV*kW(=3000)
  efficiency2 = 1.25 / Vcell;
//Pin
//Pout = Vcell * Icell * n_cells * efficiency2 / Pn;
  Pout = Vcell * Icell * n_cells / (Pnom * efficiency2);
  //Pprod = Vcell * Icell * n_cells / (Pnom);
//Vcell * n_cells = p.v - n.v;
//0 = p.i + n.i;
//Icell = p.i;
  annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-4, 21}, lineColor = {0, 0, 255}, extent = {{-68, 49}, {80, -77}}, textString = "Electrochemical"), Text(origin = {86, 29}, extent = {{-50, 51}, {4, -9}}, textString = "Pelec"), Text(origin = {78, -43}, extent = {{-46, 49}, {14, -13}}, textString = "Wpem"), Text(origin = {65, -64}, extent = {{23, -14}, {-23, 14}}, textString = "Icell")}, coordinateSystem(initialScale = 0.1)),
    Diagram);


end electrochemical;
