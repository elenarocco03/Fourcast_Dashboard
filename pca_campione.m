% PCA_CAMPIONE  PCA of the U.S. Treasury curve on the whole available sample.
%   1. Check of pca_curva on the 2x2 example of Tutorial 4 (slides 13-18)
%   2. Sample: days with all 11 maturities (1M ... 30Y)
%   3. PCA on daily changes (bp), as in the tutorial; levels for comparison (Mele eq. 1)
%   4. Figure: loadings by maturity (as Mele p. 91, top) and variance shares

clear; clc;

% --- 1. Check on the tutorial example -------------------------------------
% Sigma = [4 3; 3 4] -> lambda = 7, 1; PC1 = (1,1)/sqrt2 explains 87.5%
Sigma = [4 3; 3 4];
rng(1);
Xtest = randn(1e6, 2) * chol(Sigma);          % many draws: sample cov ~ Sigma
[Wt, lt, st] = pca_curva(Xtest);
fprintf('Check tutorial: lambda = %.2f, %.2f  (expected 7, 1)\n', lt);
fprintf('                PC1 = (%.3f, %.3f) (expected 0.707, 0.707), share %.1f%% (87.5%%)\n\n', ...
        Wt(:, 1), 100*st(1));

% --- 2. Sample --------------------------------------------------------------
file = fullfile(fileparts(mfilename('fullpath')), 'data', 'treasury_history.mat');
if isfile(file)
    S = load(file, 'T');  T = S.T;
else
    T = fred_yield_history();
end
maturities = [1/12 3/12 6/12 1 2 3 5 7 10 20 30];
labels     = ["1M" "3M" "6M" "1Y" "2Y" "3Y" "5Y" "7Y" "10Y" "20Y" "30Y"];

full = all(~isnan(T.Variables), 2);           % days with every maturity
R    = T{full, :};                            % yields in %
days_ = T.Time(full);
fprintf('Sample: %s -> %s, %d days, %d maturities\n\n', ...
        days_(1), days_(end), numel(days_), numel(maturities));

% --- 3. PCA ------------------------------------------------------------------
dR = 100 * diff(R);                           % daily changes in bp
[W, lambda, share] = pca_curva(dR);
[~, ~, shareLev] = pca_curva(R);              % levels, for comparison only

fprintf('Variance explained (daily changes | levels):\n');
cum = cumsum(share);  cumLev = cumsum(shareLev);
for j = 1:5
    fprintf('  PC%d  %5.1f%%  (cum. %5.1f%%)   |   %5.1f%%  (cum. %5.1f%%)\n', ...
            j, 100*share(j), 100*cum(j), 100*shareLev(j), 100*cumLev(j));
end
fprintf('\nLoadings, daily changes (columns = directions):\n');
fprintf('  %-4s %8s %8s %8s\n', '', 'PC1', 'PC2', 'PC3');
for i = 1:numel(labels)
    fprintf('  %-4s %8.3f %8.3f %8.3f\n', labels(i), W(i, 1:3));
end
fprintf('\nStd. dev. of the daily scores (bp): %.1f, %.1f, %.1f\n', sqrt(lambda(1:3)));

% --- 4. Figure ----------------------------------------------------------------
fig = figure('Position', [100 100 1100 420]);
theme(fig, 'light');                          % readable also with MATLAB in dark mode
subplot(1, 2, 1);
plot(maturities, W(:, 1:3), '-o', 'LineWidth', 1.5);
yline(0, ':');
xlabel('Maturity (years)');  ylabel('Loading');
legend(sprintf('level (%.0f%%)', 100*share(1)), sprintf('slope (%.0f%%)', 100*share(2)), ...
       sprintf('curvature (%.0f%%)', 100*share(3)), 'Location', 'best');
title(sprintf('Factor loadings, daily changes %s-%s', ...
              char(days_(1), 'yyyy'), char(days_(end), 'yyyy')));
grid on;

subplot(1, 2, 2);
bar(100*share(1:6));
hold on;
plot(1:6, 100*cum(1:6), '-o', 'LineWidth', 1.5);
hold off;
xlabel('Principal component');  ylabel('% of total variance');
legend('single', 'cumulative', 'Location', 'east');
title('Variance explained');
ylim([0 100]);  grid on;

exportgraphics(fig, fullfile(fileparts(mfilename('fullpath')), 'pca_campione.png'));
