data {
  int <lower=0> N; // number of observation
  vector[N] y; // observations
}

parameters {
  real mu;
  real<lower=0> sigma;
}

model {
    mu ~ lognormal(1.9, 0.7); // prior
    sigma ~ inv_chi_square(2.5); // prior

  // pooled model likelihood, common mu and sigma for all observations
    y ~ normal(mu, sigma);
}


generated quantities {
  real ypred;
  //predictive distribution for any machine
  ypred = normal_rng(mu, sigma);
  
}
