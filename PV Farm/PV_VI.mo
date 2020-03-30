model PV_VI
Modelica.Blocks.Interfaces.RealInput G "Solar irradiation" annotation (
      Placement(transformation(
        origin={-30,-55},
        extent={{-15,-15},{15,15}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealInput T "Panel temperature" annotation (
      Placement(transformation(
        origin={30,-55},
        extent={{-15,-15},{15,15}},
        rotation=90)));
  // Constants
  constant Modelica.SIunits.Charge q=1.60217646e-19 "Electron charge";
  constant Real Gn=1000 "STC irradiation";
  constant Modelica.SIunits.Temperature Tn=298.15 "STC temperature";
  // Basic datasheet parameters
  parameter Modelica.SIunits.Current Imp=7.61 "Maximum power current";
  parameter Modelica.SIunits.Voltage Vmp=26.3 "Maximum power voltage";
  parameter Modelica.SIunits.Current Iscn=8.21 "Short circuit current";
  parameter Modelica.SIunits.Voltage Vocn=32.9 "Open circuit voltage";
  parameter Real Kv=-0.123 "Voc temperature coefficient";
  parameter Real Ki=3.18e-3 "Isc temperature coefficient";
  // Basic model parameters
  parameter Real Ns=54 "Number of cells in series";
  parameter Real Np=1 "Number of cells in parallel";
  parameter Modelica.SIunits.Resistance Rs=0.221
    "Equivalent series resistance of array";
  parameter Modelica.SIunits.Resistance Rp=415.405
    "Equivalent parallel resistance of array";
  parameter Real a=1.3 "Diode ideality constant";
  // Derived model parameters
  parameter Modelica.SIunits.Current Ipvn=Iscn "Photovoltaic current at STC";
  // Variables
  Modelica.SIunits.Voltage Vt "Thermal voltage of the array";
  Modelica.SIunits.Current Ipv "Photovoltaic current of the cell";
  Modelica.SIunits.Current I0 "Saturation current of the cell";
  Modelica.SIunits.Current Id "Diode current";
  Modelica.SIunits.Current Ir "Rp current";
  Real v;
  Real i;
equation
  // Auxiliary variables
  Vt = Ns*Modelica.Constants.k*T/q;
  Ipv = (Ipvn + Ki*(T - Tn))*G/Gn;
  I0 = (Iscn + Ki*(T - Tn))/(exp((Vocn + Kv*(T - Tn))/a/Vt) - 1);
  Id = I0*(exp((v - Rs*i)/a/Vt) - 1);
  Ir = (v - Rs*i)/Rp;
  if v < 0 then
    i = v/((Rs + Rp)/Np);
  elseif v > Vocn then
    i = 0;
  else
    i = -Np*(Ipv - Id - Ir);
  end if;

end PV_VI;
