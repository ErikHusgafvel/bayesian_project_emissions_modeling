data {
    int<lower=0> N;            // Number of observations
    int<lower=0> N_c;          // Number of countries
    vector[N_c] y[N];               // Observations
}

parameters {
    vector[N_c] mu; // group means
    real hyper_mu;             // prior mean
    real<lower=0> hyper_sigma; // prior std constrained to be positive
    real<lower=0> sigma;  // COMMON std constrained to be positive
    
}

model {
    hyper_mu ~ lognormal(2.58, 0.5);     // weakly informative hyper-prior
    hyper_sigma ~ gamma(2.5,0.8);   // weakly informative hyper-prior
    
    mu ~ normal(hyper_mu, hyper_sigma); // population prior with unknown parameters   
    sigma ~ inv_chi_square(2.5); // weakly informative prior for group (common) std
    
    for (j in 1:N_c) {
          y[ ,j] ~ normal(mu[j], sigma); // likelihood
    }
    
}

generated  quantities {
    real y_pred;
    vector[N_c] log_lik[N];
    
    
    y_pred = normal_rng(hyper_mu, sigma);
    
    for (j in 1:N_c) {
        for (i in 1:N) {
            log_lik[i, j] = normal_lpdf(y[i,j] | mu[j], sigma);
        }
    }
}
