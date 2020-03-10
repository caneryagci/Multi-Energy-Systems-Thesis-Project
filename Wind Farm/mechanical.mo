model mechanical
  Modelica.Blocks.Interfaces.RealInput Tm "engine shaft torque" annotation (
      Placement(
      transformation(
        extent={{-102.0,54.0},{-62.0,94.0}},
        origin={-43.0,7.7602},
        rotation=0),
      visible=true,
      iconTransformation(
        origin={2.0,-24.0},
        extent={{-102.0,54.0},{-62.0,94.0}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput omega_m "engine shaft angular velocity"
    annotation (Placement(
      transformation(
        extent={{102.0,54.0},{62.0,94.0}},
        origin={43.0,-74.0},
        rotation=0),
      visible=true,
      iconTransformation(
        origin={-2.0,-74.0},
        extent={{102.0,54.0},{62.0,94.0}},
        rotation=0)));
  parameter Real Sbase=100 "Power Rating [Normalization Factor] (MVA)";
  parameter Real Pnom=10 "Nominal Power (MVA)";
  parameter Real Hm=0.3 "inertia (pu)";
  parameter Real Pc=0.016 "p.u. Input, PowerFlow";
  Real Tel=Tm;
initial equation
  if Pc < Pnom/Sbase and Pc > 0 then
    omega_m = 0.5*Pc*Sbase/Pnom + 0.5;
  elseif Pc*Sbase >= Pnom then
    omega_m = 1;
  else
    omega_m = 0.5;
  end if;
  Tel = Tm;
equation
  der(omega_m) = (Tm - Tel)/(2*Hm);
end mechanical;
