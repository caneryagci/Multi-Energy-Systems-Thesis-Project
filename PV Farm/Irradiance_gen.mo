model Irradiance_gen
  import Modelica.Math.Matrices.integralExpT;
  parameter Real mean = 700;
  parameter Real standard_deviation = 1;
  parameter Real alfa = 2;
  parameter Real beta = 5;
  parameter Real refIrradiance = 500;//W/m2
  
  Real gamma_ab(fixed = false, start = 0);
  Real gamma_a(fixed = false, start = 0.1);
  Real gamma_b(fixed = false, start = 0.1);
  Real pdf_beta;
  
    Modelica.Blocks.Interfaces.RealOutput Irradiance annotation(
    Placement(visible = true, transformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //protected
  //  parameter Modelica.SIunits.Time t(fixed=false) "Start time of simulation";
  /*
  algorithm
    when initial() then
        // Generate initial state
        gamma_ab := 0;
        gamma_a := 0;
        gamma_b := 0;
    end when;
  */
equation
  der(gamma_ab) = time ^ (alfa + beta - 1) * exp(-time);
  der(gamma_a) = time ^ (alfa - 1) * exp(-time);
  der(gamma_b) = time ^ (beta - 1) * exp(-time);
//beta =(1-mean)*(mean*(1+mean)/standard_deviation^2)-1;
//alfa=(mean*beta)/(1-mean);
algorithm
  pdf_beta := gamma_ab / (gamma_a * gamma_b) * refIrradiance ^ (alfa - 1);
  Irradiance:=pdf_beta;
 
  annotation(
    uses(Modelica(version = "3.2.3")));
end Irradiance_gen;
