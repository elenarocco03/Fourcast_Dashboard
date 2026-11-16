function [R, A, B] = vasicek_yields(params, r, tau)
% VASICEK_YIELDS  Yield curve implied by the Vasicek model (Mele eq. 10, p. 121).
%   [R, A, B] = vasicek_yields(params, r, tau)
%
%   params  struct with kappa, rbar, sigma, lambda
%   r       short rate (decimals); a column vector gives one curve per row
%   tau     maturities in years (row vector)
%
%   R       model yields, R = -A/tau + (B/tau) r   (numel(r) x numel(tau))
%   A, B    the bond-price coefficients, P = exp(A - B r)   (1 x numel(tau))

k     = params.kappa;
sigma = params.sigma;
tau   = tau(:)';            % row
r     = r(:);               % column

% Long-maturity yield r_inf, with the risk-adjusted mean r* (Mele p. 121)
rstar = params.rbar - params.lambda * sigma / k;
rinf  = rstar - 0.5 * (sigma / k)^2;

B = (1 - exp(-k * tau)) / k;
A = (B - tau) * rinf - sigma^2 / (4 * k) * B.^2;

R = -A ./ tau + (B ./ tau) .* r;     % one row per value of r
end
