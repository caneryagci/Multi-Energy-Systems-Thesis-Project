within Wind;

model Asynchron_dfig_Can "Doubly fed induction generator, 3-phase dq0"
  extends PowerSystems.AC3ph.Machines.Partials.AsynchronBase(v_rd = term_r.v[1] * ones(n_r), v_rq = term_r.v[2] * ones(n_r), par.n_r = 2, par.neu_iso = false, par.pp = 4, par.x = 2.8, par.x_0 = 0.1, par.S_nom = 1.5e+06, par.V_nom = 3000, par.r_s = 0.02, par.transDat = true, par.xsig_s = 0.05);
  Modelica.Blocks.Interfaces.RealOutput phiRotor "rotor angle" annotation(
    Placement(transformation(origin = {100, 100}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  PowerSystems.AC3ph.Ports.ACdq0_p term_r "positive terminal" annotation(
    Placement(transformation(extent = {{-110, 50}, {-90, 70}}, rotation = 0)));
initial equation
  phi_el = phi_el_start;
  phiRotor = 0;
equation
  der(phiRotor) = w_el;
  term_r.i = {sum(i_rd), sum(i_rq), 0};
  annotation(
    defaultComponentName = "asynchron",
    Documentation(info = "<html>
<p>A doubly fed induction generator is has a second feed to the rotor windings (term_r).
A wide range of rotor speeds can be achieved by controlling the AC voltage of term_r.
Doubly fed induction generators are popular for wind turbines.
<p>For more information see Partials.AsynchronBase.</p>
</html>
    "),
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-90, 112}, {90, 88}}, lineColor = {0, 0, 127}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2})));
end Asynchron_dfig_Can;
