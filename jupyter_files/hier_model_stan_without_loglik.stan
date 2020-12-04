data {
    int<lower=0> N;            // Number of observations
    int<lower=0> N_c;          // Number of countries
    vector[N_c] y[N];               // Observations
    real hyper_mu_in_mu;        // Prior for hyper_mu mu
    real hyper_mu_in_sigma;     // Prior for hyper_mu sigma
    real hyper_sigma_in_alpha;  // Prior for hyper_sigma alpha
    real hyper_sigma_in_beta;   // Prior for hyper_sigma beta
    real common_sigma_in;       // Prior for common sigma
}

parameters {
    vector[N_c] mu; // group means
    real hyper_mu;             // prior mean
    real<lower=0> hyper_sigma; // prior std constrained to be positive
    real<lower=0> sigma;  // COMMON std constrained to be positive
    
}

model {
    hyper_mu ~ lognormal(hyper_mu_in_mu, hyper_mu_in_sigma);     // weakly informative hyper-prior
    hyper_sigma ~ gamma(hyper_sigma_in_alpha, hyper_sigma_in_beta);   // weakly informative hyper-prior
    
    mu ~ normal(hyper_mu, hyper_sigma); // population prior with unknown parameters   
    sigma ~ inv_chi_square(common_sigma_in); // weakly informative prior for group (common) std
    
    for (j in 1:N_c) {
          y[ ,j] ~ normal(mu[j], sigma); // likelihood
    }
    
}

generated  quantities {
    real y_pred_new_country;
    real y_pred_SAU;
    real y_pred_FIN;
    
    y_pred_new_country = normal_rng(hyper_mu, hyper_sigma);
    y_pred_SAU = normal_rng(mu[12], sigma);
    y_pred_FIN = normal_rng(mu[6], sigma);
    
}

