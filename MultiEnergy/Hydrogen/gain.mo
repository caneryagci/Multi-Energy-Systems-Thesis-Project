within Hydrogen;

block gain

  parameter Real k(start=1)
    "Gain value multiplied with input signal";
public
  Modelica.Blocks.Interfaces.RealInput u "Input signal connector" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y "Output signal connector" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));

equation
  y = k*u;
  annotation (
    Documentation(info="<html>
<p>
This block computes output <em>y</em> as
<em>product</em> of gain <em>k</em> with the
input <em>u</em>:
</p>
<pre>
  y = k * u;
</pre>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{-100,-100},{-100,100},{100,0},{-100,-100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-140},{150,-100}},
          textString="k=%k"),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          lineColor={0,0,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
            points={{-100,-100},{-100,100},{100,0},{-100,-100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),Text(
            extent={{-76,38},{0,-34}},
            textString="k",
            lineColor={0,0,255})}));


end gain;
