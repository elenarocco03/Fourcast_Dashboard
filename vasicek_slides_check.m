% VASICEK_SLIDES_CHECK  Replicate the Vasicek examples of the course slides.
%   Checks that vasicek_yields reproduces the numbers given in the theory
%   material, before estimating the model on real data.

tol = 1e-6;

%% 1. Mele p. 122: asymptotic yield r_inf = 5.10%
p = struct('kappa', 0.2, 'rbar', 0.06, 'sigma', 0.03, 'lambda', -0.015);
R = vasicek_yields(p, 0.06, 1e5);             % a very long maturity -> r_inf
fprintf('Mele p.122   r_inf = %.4f%%   (slide: 5.10%%)\n', 100 * R);
assert(abs(R - 0.0510) < 1e-4, 'Mele p.122 example not replicated');

% Curves for a few starting short rates, as in the slide figure
tau = linspace(0.1, 30, 200);
figure('Name', 'Vasicek - Mele p.122');
plot(tau, 100 * vasicek_yields(p, [0.02; 0.04; 0.06; 0.08], tau), 'LineWidth', 1.5);
hold on
yline(100 * 0.0510, '--', 'r_\infty = 5.10%');
xlabel('Maturity (years)'); ylabel('Yield (%)');
legend('r = 2%', 'r = 4%', 'r = 6%', 'r = 8%', 'Location', 'southeast');
title('Vasicek yield curves, \kappa=0.2, r̄=6%, \sigma=0.03, \lambda=-0.015');
grid on

%% 2. Tutorial 4 (Jamshidian exercise): zero-coupon bond prices
% Risk-neutral parameters (theta under Q), so lambda = 0
p = struct('kappa', 0.2, 'rbar', 0.05, 'sigma', 0.01, 'lambda', 0);
[~, A, B] = vasicek_yields(p, 0.04, [1 2 3]);
P = exp(A - B * 0.04);
Pslide = [0.959904 0.919968 0.880605];
fprintf('Tutorial 4   P(0,1..3) = %.6f %.6f %.6f\n', P);
fprintf('             slide     = %.6f %.6f %.6f\n', Pslide);
assert(all(abs(P - Pslide) < tol), 'Tutorial 4 example not replicated');

disp('All slide examples replicated.')
