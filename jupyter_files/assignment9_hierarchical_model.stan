data {
  int<lower=0> N; // number of observations
  int<lower=0> J; // number of groups
  vector[J] y[N]; // real valued observations
}

parameters {
  vector[J] mu; // group means
  real<lower=0> sigma; // commond sd
  real mu0;
  real<lower=0> sigma0;
}

model {
  mu0 ~ normal(0,100); // hyper prior mean
  sigma0 ~ inv_chi_square(1); // hyper prior sd
  
  mu ~ normal(mu0, sigma0);
  sigma ~ inv_chi_square(1);
  
  for (j in 1:J) {
    y[ ,j] ~ normal(mu[j], sigma); // likelihood
  }
}

generated quantities {
  vector[7] ypred;
  // Compute predictive distributions for each machines 1-6:
  for (i in 1:6) {
    ypred[i] = normal_rng(mu[i], sigma);
  }
  // Compute predictive distribution for the seventh machine
  ypred[7] = normal_rng(mu0, sigma);
}
