model async_gen_dfig "Doubly fed induction generator, 3-phase dq0"
  extends PowerSystems.AC3ph.Machines.Partials.AsynchronBase(v_rd = term_r.v[1]*ones(n_r), v_rq = term_r.v[2]*ones(n_r));
  Modelica.Blocks.Interfaces.RealOutput phiRotor "rotor angle"
    annotation (Placement(transformation(
        origin={100,100},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  PowerSystems.AC3ph.Ports.ACdq0_p term_r annotation(
    Placement(visible = true, transformation(origin = {-102, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-102, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2})),
    uses(PowerSystems(version = "1.0.0")));
end async_gen_dfig;
