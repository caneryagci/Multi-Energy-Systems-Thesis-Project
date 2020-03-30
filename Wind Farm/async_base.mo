model async_base
  extends PowerSystems.AC3ph.ACmachine(final pp=par.pp, v(start={cos(system.alpha0),sin(system.alpha0),0}*par.V_nom));

  output Real slip "<0: motor, >0: generator";
  replaceable record Data =
    PowerSystems.AC3ph.Machines.Parameters.Asynchron(f_nom=system.f_nom)
    "machine parameters" annotation(choicesAllMatching=true);
  final parameter Data par "machine parameters"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
protected
  final parameter Integer n_r = par.n_r
    "number of rotor circuits d- and q-axis";
  final parameter Coefficients.Asynchron c = Utilities.Precalculation.machineAsyn(
                                                                              par, top.scale);
  parameter SI.Inductance L_m[n_r] = c.L_m;
  parameter SI.Resistance R_r[n_r] = c.R_r;
  parameter SI.Resistance R_m[n_r] = c.R_m;
  parameter SI.Inductance L_r[n_r,n_r] = c.L_r;

  parameter PS.Current[n_r] i_rd_start = zeros(n_r)
    "start value of rotor current d_axis"
    annotation(Dialog(tab="Initialization"));
  parameter PS.Current[n_r] i_rq_start = zeros(n_r)
    "start value of rotor current q_axis"
    annotation(Dialog(tab="Initialization"));

  PS.Voltage[n_r] v_rd=zeros(n_r) "rotor voltage d_axis, cage-rotor = 0";
  PS.Voltage[n_r] v_rq=zeros(n_r) "rotor voltage q_axis, cage-rotor = 0";
  PS.Current[n_r] i_rd(start = i_rd_start) "rotor current d_axis";
  PS.Current[n_r] i_rq(start = i_rq_start) "rotor current q_axis";
  SI.MagneticFlux[2] psi_s "magnetic flux stator dq";
  SI.MagneticFlux[n_r] psi_rd "magnetic flux rotor d";
  SI.MagneticFlux[n_r] psi_rq "magnetic fluxrotor q";

initial equation
  if dynType == Types.Dynamics.SteadyInitial then
    der(psi_s) = omega[1]*{-psi_s[2], psi_s[1]};
    der(i[3]) = 0;
    der(psi_rd) = omega[1]*(-psi_rq);
    der(psi_rq) = omega[1]*psi_rd;
  elseif dynType <> Types.Dynamics.SteadyState then
    der(psi_rd) = omega[1]*(-psi_rq);
    der(psi_rq) = omega[1]*psi_rd;
  end if;

equation
  psi_s = diagonal(c.L_s[1:2])*i[1:2] + {L_m*i_rd, L_m*i_rq};
  psi_rd = L_m*i[1] + L_r*i_rd;
  psi_rq = L_m*i[2] + L_r*i_rq;

  if dynType <> Types.Dynamics.SteadyState then
    der(psi_s) + omega[2]*{-psi_s[2], psi_s[1]} + c.R_s*i[1:2] = v[1:2];
    c.L_s[3]*der(i[3]) + c.R_s*i[3] = v[3];
    der(psi_rd) + (omega[2] - w_el)*(-psi_rq) + diagonal(R_r)*i_rd = v_rd;
    der(psi_rq) + (omega[2] - w_el)*psi_rd + diagonal(R_r)*i_rq = v_rq;
  else
    omega[2]*{-psi_s[2], psi_s[1]} + c.R_s*i[1:2] = v[1:2];
    c.R_s*i[3] = v[3];
    (omega[2] - w_el)*(-psi_rq) + diagonal(R_r)*i_rd = v_rd;
    (omega[2] - w_el)*psi_rd + diagonal(R_r)*i_rq = v_rq;
  end if;

  if par.neu_iso then
    i_n = zeros(top.n_n);
  else
    v_n = c.R_n*i_n "equation neutral to ground (relevant if Y-topology)";
  end if;

  slip = (w_el/sum(omega) - 1);
  tau_el = i[1:2]*{-psi_s[2], psi_s[1]};
  heat.ports.Q_flow = -{c.R_s*i*i, diagonal(R_r)*i_rd*i_rd + diagonal(R_r)*i_rq*i_rq};
annotation (
  defaultComponentName="asynchron",
    Documentation(
      info="<html>
<p>The stator contains one winding each in d-axis, q-axis, 0-axis.<br>
The rotor contains n_r windings each in d-axis and q-axis (at least one).<br>
See also equivalent circuit on 'Diagram layer' of
<a href=\"modelica://PowerSystems.AC3ph.Machines.Parameters.Asynchron\">Parameters.Asynchron</a> !</p>
<pre>
v, i:                  stator-voltage and -current dq0
v_rd[n_r], i_rd[n_r]:  rotor-voltage and -current d-axis
v_rq[n_r], i_rq[n_r]:  rotor-voltage and -current q-axis
</pre>
<p>The equations are valid for <i>all</i> dq0 reference systems with arbitrary angular orientation.<br>
Special choices are</p>
<pre>
omega[2] = omega  defines 'stator' system, rotating with stator frequency
omega[2] = w_el   defines 'rotor' system, rotating with rotor speed el (el = mec*pp)
omega[2] = 0      defines the inertial system, not rotating.
with
omega[2] = der(term.theta[2])
</pre></p>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(
          extent={{-100,10},{100,-10}},
          lineColor={255,255,255},
          textString="asyn")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-50,-58},{-30,-62}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,-58},{30,-62}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,-74},{-30,-78}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,-74},{30,-78}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,-67},{30,-69}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,-42},{-30,-46}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,-42},{30,-46}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,-29},{30,-31}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,-51},{30,-53}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,-83},{30,-85}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,-86},{-60,-86},{-60,-40},{-50,-40},{-50,-42}},
            color={0,0,255}),
        Line(points={{30,-86},{40,-86},{40,-40},{30,-40},{30,-42}}, color={
              0,0,255}),
        Line(
          points={{30,-42},{30,-86}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-50,-42},{-50,-86}},
          color={0,0,255},
          thickness=0.5)}));
end async_base;
