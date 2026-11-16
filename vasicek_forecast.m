function [mu, sd, muModel, Er, sdr] = vasicek_forecast(params, r0, tau, h, opts)
% VASICEK_FORECAST  Forecast of the yield curve h years ahead (Mele p. 123).
%   [mu, sd] = vasicek_forecast(params, r0, tau, h, Yobs=Ytoday)
%   [mu, sd] = vasicek_forecast(params, r0, tau, h, anchor="none")
%
%   params  struct from vasicek_fit (kappa, rbar, sigma, lambda; phi for "decay")
%   r0      short rate today (decimals)
%   tau     maturities in years (row vector)
%   h       horizon in years, e.g. 3/12 for three months
%
%   Options
%   anchor  how today's fit error e = observed - model is carried forward:
%             "decay" (default) e shrinks at its estimated speed: e * phi^(h/dt)
%             "full"            e stays constant (today's curve + model change)
%             "none"            pure model forecast, e is dropped
%   Yobs    observed curve today at the maturities tau (needed unless "none")
%
%   mu       forecast mean of each yield, after anchoring (1 x numel(tau))
%   sd       standard deviation of each yield (the same for every anchor)
%   muModel  pure model forecast mean (= mu with anchor "none")
%   Er, sdr  conditional mean and standard deviation of the short rate

arguments
    params struct
    r0 (1,1) double
    tau (1,:) double
    h (1,1) double
    opts.anchor (1,1) string {mustBeMember(opts.anchor, ["decay" "full" "none"])} = "decay"
    opts.Yobs (1,:) double = []
end

k = params.kappa;

% 1. Short rate: conditional mean and variance (exact, normal)
Er  = params.rbar + exp(-k * h) * (r0 - params.rbar);
sdr = sqrt(params.sigma^2 / (2 * k) * (1 - exp(-2 * k * h)));

% 2. Map to yields: R is linear in r with slope B/tau
[muModel, ~, B] = vasicek_yields(params, Er, tau);
sd = (B ./ tau) * sdr;

% 3. Anchoring to today's observed curve
if opts.anchor == "none"
    mu = muModel;
    return
end
if numel(opts.Yobs) ~= numel(tau)
    error('vasicek_forecast:Yobs', ...
          'anchor "%s" needs Yobs, the observed curve today at the maturities tau.', ...
          opts.anchor);
end
e = opts.Yobs - vasicek_yields(params, r0, tau);        % fit error today

if opts.anchor == "full"
    keep = ones(size(tau));
else
    % "decay": phi is per estimation step (dt), so h/dt steps ahead
    if ~isequal(params.tau, tau)
        error('vasicek_forecast:tau', ...
              'anchor "decay" needs the same maturities used in vasicek_fit.');
    end
    keep = params.phi .^ (h / params.dt);
end
mu = muModel + e .* keep;
end
