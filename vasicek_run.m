% VASICEK_RUN  Estimate the Vasicek model on U.S. Treasury yields, 2000 - today.
%   Runs at daily and monthly frequency and shows, for each:
%     - the parameter table (with standard errors)
%     - the model curve vs the observed curve on the last date
%     - a forecast h months ahead with a +/- 1 s.d. band
%   Everything that can change (sample start, horizon) is set here, not inside
%   the model functions.

from     = datetime(2000, 1, 1);    % sample start (from 2010 the 3M shows no mean reversion: b >= 1)
hMonths  = 3;                       % forecast horizon in months
anchor   = "decay";                 % "decay", "full" or "none" (see vasicek_forecast)
freqs    = ["daily" "monthly"];

T = fred_yield_history();           % daily FRED history, yields in %

for freq = freqs
    data = yield_sample(T, from, freq);
    try
        params = vasicek_fit(data); % lambda estimated on all dates
    catch err
        % e.g. no mean reversion in this sample (b >= 1): report and go on
        fprintf('\n=== Vasicek, %s data: not estimated ===\n  %s\n', freq, err.message);
        continue
    end

    %% 1. Parameter table
    fprintf('\n=== Vasicek, %s data, %s to %s (%d obs) ===\n', freq, ...
            string(data.dates(1), 'yyyy-MM-dd'), string(data.dates(end), 'yyyy-MM-dd'), ...
            numel(data.r));
    se = params.se;
    fprintf('  b         %10.5f   (s.e. %.5f)\n', params.b, se.b);
    fprintf('  kappa     %10.4f   (s.e. %.4f)\n', params.kappa, se.kappa);
    fprintf('  half-life %10.2f   years (s.e. %.2f)\n', params.halflife, se.halflife);
    fprintf('  rbar      %9.2f%%   (s.e. %.2f%%)\n', 100 * params.rbar, 100 * se.rbar);
    fprintf('  sigma     %9.2f%%   (s.e. %.2f%%)\n', 100 * params.sigma, 100 * se.sigma);
    fprintf('  lambda    %10.4f   (least squares on yields, %s dates)\n', ...
            params.lambda, params.lambdaDates);
    fprintf('  fit error (RMSE, bp):');
    fprintf(' %s %s', [data.labels; compose('%.0f', 1e4 * params.rmse)]);
    fprintf('\n  error left after %d months (phi^h):', hMonths);
    fprintf(' %s %s', [data.labels; compose('%.0f%%', 100 * params.phi .^ (hMonths / 12 / data.dt))]);
    fprintf('\n');

    %% 2. Model vs observed curve, last date
    r0     = data.r(end);
    Yobs   = data.Y(end, :);
    Rmodel = vasicek_yields(params, r0, data.tau);

    %% 3. Forecast h months ahead
    % anchored to today's curve, the fit error decaying at its estimated speed
    [mu, sd, muModel] = vasicek_forecast(params, r0, data.tau, hMonths / 12, ...
                                         anchor=anchor, Yobs=Yobs);

    %% 4. Charts
    figure('Name', "Vasicek - " + freq, 'Position', [100 100 1100 420]);
    lastDay = string(data.dates(end), 'dd MMM yyyy');

    subplot(1, 2, 1)
    plot(data.tau, 100 * Yobs, 'ko-', 'LineWidth', 1.5); hold on
    plot(data.tau, 100 * Rmodel, 's-', 'LineWidth', 1.5);
    xlabel('Maturity (years)'); ylabel('Yield (%)'); grid on
    legend('Observed', 'Vasicek', 'Location', 'best');
    title("Observed vs model curve, " + lastDay);

    subplot(1, 2, 2)
    fill([data.tau, fliplr(data.tau)], 100 * [mu + sd, fliplr(mu - sd)], ...
         [0.8 0.85 1], 'EdgeColor', 'none'); hold on
    plot(data.tau, 100 * mu, 'b-', 'LineWidth', 1.5);
    plot(data.tau, 100 * muModel, 'b--', 'LineWidth', 1);
    plot(data.tau, 100 * Yobs, 'ko-', 'LineWidth', 1);
    xlabel('Maturity (years)'); ylabel('Yield (%)'); grid on
    legend('\pm 1 s.d.', sprintf('Forecast in %d months (anchor "%s")', hMonths, anchor), ...
           'Pure model forecast', "Observed " + lastDay, 'Location', 'best');
    title(sprintf('Vasicek forecast, %d months ahead (%s data)', hMonths, freq));
end
