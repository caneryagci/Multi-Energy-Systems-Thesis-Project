within Wind;

model weibull_random_wind_speed_generator/*
      // Random number generators with exposed state
        parameter Integer localSeed = 614657
          "Local seed to initialize random number generator";
          
        output Real r64 "Random number generated with Xorshift64star";
        //output Real r128 "Random number generated with Xorshift128plus";
        //output Real r1024 "Random number generated with Xorshift1024star";
        parameter Integer id = Modelica.Math.Random.Utilities.initializeImpureRandom(globalSeed) "A unique number used to sort equations correctly";
        discrete Real rImpure "Impure Real random number";
        Integer iImpure "Impure Integer random number";
        
      protected
        //parameter Modelica.SIunits.Time t0(fixed=false) "Start time of simulation";
        //Real x "Integrator state";
        discrete Integer state64[2](   each start=0, each fixed = true);
        //discrete Integer state128[4](  each start=0, each fixed = true);
        //discrete Integer state1024[33](each start=0, each fixed = true);
        
      algorithm
        when initial() then
          // Generate initial state from localSeed and globalSeed
          state64   := Modelica.Math.Random.Generators.Xorshift64star.initialState(  localSeed, globalSeed);
          //state128  := Modelica.Math.Random.Generators.Xorshift128plus.initialState( localSeed, globalSeed);
          //state1024 := Modelica.Math.Random.Generators.Xorshift1024star.initialState(localSeed, globalSeed);
          r64       := 0.97;
          //r128      := 0.001;
          //r1024     := 0.001;
        elsewhen sample(0,samplePeriod) then
          (r64,  state64)   := Modelica.Math.Random.Generators.Xorshift64star.random(  pre(state64));
          //(r128, state128)  := Modelica.Math.Random.Generators.Xorshift128plus.random( pre(state128));
          //(r1024,state1024) := Modelica.Math.Random.Generators.Xorshift1024star.random(pre(state1024));
        end when;
      
      // Impure random number generators with hidden state
      algorithm
        when initial() then
          rImpure := 0.000001;
          iImpure := 1;
        elsewhen sample(0,samplePeriod) then
          rImpure := Modelica.Math.Random.Utilities.impureRandom(id=id);
          iImpure := Modelica.Math.Random.Utilities.impureRandomInteger(
                id=id,
                imin=-1234,
                imax=2345);
        end when;
        
      initial equation
        //t0 = time;
       // x = x0;
        //Mean_ws = 0;
         */
  Modelica.Blocks.Interfaces.RealInput scale(min = 0) annotation(
    Placement(visible = true, transformation(origin = {-42, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput shape(min = 0) annotation(
    Placement(visible = true, transformation(origin = {-40, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Modelica.SIunits.Velocity vMax = 25 "Maximum velocity (v<=vMax)";
  parameter Integer n = 25 "Number of intervals";
  final parameter Modelica.SIunits.Velocity dv = vMax / n "Velocity increment";
  final parameter Modelica.SIunits.Velocity vDiscrete[n] = array(k * dv for k in 1:n) "Discrete velocities";
  Real weibull[n] = array(shape / scale * (vDiscrete[k] / (scale * 48)) ^ (shape - 1) * exp(-(vDiscrete[k] / (scale * 48)) ^ shape) for k in 1:n) "Weibull probaility";
  Real total[n];
  // Real Avg_windspeed;
  Real total_prob;
  // Mean windsp Calculation
  // parameter Modelica.SIunits.Frequency f = 1 "Base frequency";
  //parameter Real x0=0 "Start value of integrator state";
  // parameter Boolean yGreaterOrEqualZero=false
  //"=true, if output y is guaranteed to be >= 0 for the exact solution"
  // annotation (Evaluate=true, Dialog(tab="Advanced"));
  // Global parameters
  // parameter Modelica.SIunits.Period samplePeriod = 0.05
  //   "Sample period for the generation of random numbers";
  // parameter Integer globalSeed = 30020
  //   "Global seed to initialize random number generator";
  //parameter Real scale(min=0)=11 "Scale parameter in m/s";
  //parameter Real shape(min=0)=2.02 "Shape parameter in p.u.";
  Modelica.Blocks.Interfaces.RealOutput windspeed "Weibull random wind speed" annotation(
    Placement(visible = true, transformation(origin = {98, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  Real Mean_ws "Average of wind speed for a specified time period";
  
equation
// Random wind speed generator
//windspeed = scale .* (-log(r64)) .^ (1./shape);
  total_prob = sum(weibull);
// Hourly avg wind speed(scale,shape parameters should be updated every hour)
  total = weibull .* vDiscrete / total_prob;
  windspeed = sum(total);
//Mean with frequency
/*
  der(x) = windspeed;
  when sample(t0 + 1/f, 1/f) then
    Mean_ws = if not yGreaterOrEqualZero then f*pre(x) else max(0.0, f*pre(x));
    reinit(x, 0);
  end when;
*/
//simulate(ModelName, startTime = 0, stopTime = 3, numberOfIntervals=1000);
  annotation(
    uses(Modelica(version = "3.2.3")),
    Icon(graphics = {Text(origin = {-79, 40}, extent = {{-3, 4}, {3, -4}}, textString = "scale"), Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {41, -28}, lineColor = {0, 0, 255}, extent = {{13, -6}, {-87, 68}}, textString = "Weibull WS"), Text(origin = {-82, -60}, extent = {{-4, 0}, {2, 0}}, textString = "shape"), Text(origin = {90, -12}, extent = {{-4, 0}, {2, 0}}, textString = "ws")}, coordinateSystem(initialScale = 0.1)));
end weibull_random_wind_speed_generator;
