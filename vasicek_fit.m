function params = vasicek_fit(data, opts)
% VASICEK_FIT  Estimate the Vasicek model dr = kappa (rbar - r) dt + sigma dW.
%   params = vasicek_fit(data)
%   params = vasicek_fit(data, lambda=-0.2)          % lambda given, not estimated
%   params = vasicek_fit(data, lambdaDates="last")   % lambda on the last curve only
%
%   data  struct from yield_sample (uses data.r, data.dt, data.Y, data.tau)
%
%   Step 1 - dynamics (kappa, rbar, sigma): OLS on the exact discretisation,
%   an AR(1) of the short rate on itself:
%       r(t+dt) = a + b r(t) + e,   b = exp(-kappa dt),  a = rbar (1 - b),
%       var(e)  = sigma^2 (1 - b^2) / (2 kappa)
%   Step 2 - market price of risk lambda: least squares between model yields
%   and observed yields, given the parameters of step 1. The model yield is
%   linear in lambda, so the solution is in closed form.
%
%   Step 3 - persistence phi of the fit error e = observed - model, per
%   maturity (AR(1) through the origin), used to anchor the forecast.
%
%   params  kappa, rbar, sigma, lambda, plus a, b, halflife, se (standard
%           errors), rmse (fit error per maturity), phi and tau (error
%           persistence per step and its maturities), n, dt

arguments
    data struct
    opts.lambda (1,1) double = NaN          % NaN = estimate it
    opts.lambdaDates (1,1) string = "all"   % "all" dates pooled, or "last" date only
end

% ---- Step 1: AR(1) of the short rate --------------------------------------
r  = data.r;
dt = data.dt;
y  = r(2:end);
X  = [ones(numel(y), 1), r(1:end-1)];
n  = numel(y);

coef = X \ y;
e    = y - X * coef;
s2   = (e' * e) / (n - 2);                   % residual variance
V    = s2 * inv(X' * X);                     % covariance of [a; b]
a    = coef(1);
b    = coef(2);

if b >= 1
    error('vasicek_fit:noMeanReversion', ...
          ['AR(1) coefficient b = %.5f >= 1, i.e. kappa <= 0: the short rate ' ...
           'shows no mean reversion in this sample and the Vasicek formulas ' ...
           'do not apply. Try another sample or frequency.'], b);
end

% From (a, b, s2) to the continuous-time parameters
toParams = @(th) [ -log(th(2)) / dt;                                   % kappa
                    th(1) / (1 - th(2));                               % rbar
                    sqrt(th(3) * 2 * (-log(th(2)) / dt) / (1 - th(2)^2)) ]; % sigma
theta = [a; b; s2];
p     = toParams(theta);

% Standard errors by the delta method (var(s2) = 2 s2^2 / (n-2) under normality)
Vtheta = blkdiag(V, 2 * s2^2 / (n - 2));
G      = numericalJacobian(toParams, theta);
seP    = sqrt(diag(G * Vtheta * G'));

params.kappa    = p(1);
params.rbar     = p(2);
params.sigma    = p(3);
params.a        = a;
params.b        = b;
params.halflife = log(2) / p(1);
params.n        = n;
params.dt       = dt;
params.se = struct('a', sqrt(V(1,1)), 'b', sqrt(V(2,2)), 'kappa', seP(1), ...
                   'rbar', seP(2), 'sigma', seP(3), ...
                   'halflife', log(2) / p(1)^2 * seP(1));

% ---- Step 2: lambda -------------------------------------------------------
if isnan(opts.lambda)
    % observed curves used for the fit
    if opts.lambdaDates == "last"
        Yobs = data.Y(end, :);
        rObs = data.r(end);
    else
        Yobs = data.Y;
        rObs = data.r;
    end
    % R(lambda) = R0 + d * lambda, with d = R(1) - R(0) (exact: R is linear in lambda)
    params.lambda = 0;
    R0 = vasicek_yields(params, rObs, data.tau);
    params.lambda = 1;
    d  = vasicek_yields(params, rObs, data.tau) - R0;
    params.lambda = sum((Yobs - R0) .* d, 'all') / sum(d.^2, 'all');
    params.lambdaDates = opts.lambdaDates;
else
    params.lambda = opts.lambda;
    params.lambdaDates = "given";
end

% Fit error per maturity over the whole sample (root mean squared, decimals)
Rmodel      = vasicek_yields(params, data.r, data.tau);
E           = data.Y - Rmodel;               % fit error e(tau), one column per maturity
params.rmse = sqrt(mean(E.^2, 1));

% ---- Step 3: persistence of the fit error (used to anchor the forecast) ---
% AR(1) through the origin, per maturity: e(t+dt) = phi e(t) + noise.
% phi near 1: the error lasts; phi near 0: it disappears in one step.
x = E(1:end-1, :);
y = E(2:end, :);
params.phi = min(max(sum(x .* y, 1) ./ sum(x.^2, 1), 0), 1);   % kept in [0, 1]
params.tau = data.tau;                       % maturities phi refers to
end


function J = numericalJacobian(f, x)
% Central-difference Jacobian of f at x (small step: b is very close to 1)
fx = f(x);
J  = zeros(numel(fx), numel(x));
for j = 1:numel(x)
    step    = 1e-7 * abs(x(j));
    up      = x;  up(j)   = up(j) + step;
    down    = x;  down(j) = down(j) - step;
    J(:, j) = (f(up) - f(down)) / (2 * step);
end
end
