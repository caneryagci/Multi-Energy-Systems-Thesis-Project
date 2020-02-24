model weibull_random_wind_speed_generator
// Mean windsp Calculation
  parameter Modelica.SIunits.Frequency f (start=0.3) "Base frequency";
  parameter Real x0=0 "Start value of integrator state";
  parameter Boolean yGreaterOrEqualZero=false
    "=true, if output y is guaranteed to be >= 0 for the exact solution"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  
  
// Global parameters
  parameter Modelica.SIunits.Period samplePeriod = 0.05
    "Sample period for the generation of random numbers";
  parameter Integer globalSeed = 30020
    "Global seed to initialize random number generator";
  parameter Real scale(min=0) = 11 "Scale parameter in m/s";
  parameter Real shape(min=0) = 2.02 "Shape parameter in p.u.";
  Real r "Weibull random wind speed"; 
  Real Mean_ws "Average of wind speed for a specified time period";
// Random number generators with exposed state
  parameter Integer localSeed = 614657
    "Local seed to initialize random number generator";
    
  output Real r64 "Random number generated with Xorshift64star";
  output Real r128 "Random number generated with Xorshift128plus";
  output Real r1024 "Random number generated with Xorshift1024star";
protected
  parameter Modelica.SIunits.Time t0(fixed=false) "Start time of simulation";
  Real x "Integrator state";
  discrete Integer state64[2](   each start=0, each fixed = true);
  discrete Integer state128[4](  each start=0, each fixed = true);
  discrete Integer state1024[33](each start=0, each fixed = true);
  
algorithm
  when initial() then
    // Generate initial state from localSeed and globalSeed
    state64   := Modelica.Math.Random.Generators.Xorshift64star.initialState(  localSeed, globalSeed);
    state128  := Modelica.Math.Random.Generators.Xorshift128plus.initialState( localSeed, globalSeed);
    state1024 := Modelica.Math.Random.Generators.Xorshift1024star.initialState(localSeed, globalSeed);
    r64       := 0.001;
    r128      := 0.001;
    r1024     := 0.001;
  elsewhen sample(0,samplePeriod) then
    (r64,  state64)   := Modelica.Math.Random.Generators.Xorshift64star.random(  pre(state64));
    (r128, state128)  := Modelica.Math.Random.Generators.Xorshift128plus.random( pre(state128));
    (r1024,state1024) := Modelica.Math.Random.Generators.Xorshift1024star.random(pre(state1024));
  end when;

// Impure random number generators with hidden state
public
  parameter Integer id = Modelica.Math.Random.Utilities.initializeImpureRandom(globalSeed) "A unique number used to sort equations correctly";
  discrete Real rImpure "Impure Real random number";
  Integer iImpure "Impure Integer random number";
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
  t0 = time;
  x = x0;
  Mean_ws = 0;
    
equation  
// Random wind speed
  r = scale .* (-log(r1024)) .^ (1./shape);
//Mean  
  der(x) = r;
  when sample(t0 + 1/f, 1/f) then
    Mean_ws = if not yGreaterOrEqualZero then f*pre(x) else max(0.0, f*pre(x));
    reinit(x, 0);
  end when;
  
end weibull_random_wind_speed_generator;
