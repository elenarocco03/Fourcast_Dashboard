function [mu, sd, Er, sdr] = vasicek_forecast(params, r0, tau, h)
% VASICEK_FORECAST  Forecast of the yield curve h years ahead (Mele p. 123).
%   [mu, sd, Er, sdr] = vasicek_forecast(params, r0, tau, h)
%
%   params  struct with kappa, rbar, sigma, lambda
%   r0      short rate today (decimals)
%   tau     maturities in years (row vector)
%   h       horizon in years, e.g. 3/12 for three months
%
%   mu, sd   conditional mean and standard deviation of each yield (1 x numel(tau))
%   Er, sdr  conditional mean and standard deviation of the short rate
%
%   Pure model forecast: the curve moves onto the model curve. (An option to
%   anchor it to today's observed curve may be added later.)

k = params.kappa;

% 1. Short rate: conditional mean and variance (exact, normal)
Er  = params.rbar + exp(-k * h) * (r0 - params.rbar);
sdr = sqrt(params.sigma^2 / (2 * k) * (1 - exp(-2 * k * h)));

% 2. Map to yields: R is linear in r with slope B/tau
[mu, ~, B] = vasicek_yields(params, Er, tau);
sd = (B ./ tau(:)') * sdr;
end
