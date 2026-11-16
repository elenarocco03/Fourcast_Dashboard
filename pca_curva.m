function [W, lambda, share, F, mu] = pca_curva(X)
% PCA_CURVA  Principal component analysis of the yield curve (Tutorial 4, part 1).
%   [W, lambda, share, F, mu] = pca_curva(X)
%
%   X       n x p data, one row per day, one column per maturity, no NaN
%           (e.g. daily yield changes in bp)
%   W       p x p loadings: column j is the direction of component j,
%           unit length (w'w = 1), ordered by decreasing variance
%   lambda  p x 1 eigenvalues = variance of each component's score
%   share   p x 1 share of total variance explained, lambda / sum(lambda)
%   F       n x p scores (factor values): F = (X - mu) * W
%   mu      1 x p mean of each column, removed before the analysis
%
%   Steps of the tutorial: maximise w' S w subject to w'w = 1  ->  S w = lambda w,
%   so the loadings are the eigenvectors of the covariance matrix S and the
%   score variances are its eigenvalues. Sign is arbitrary (w and -w explain the
%   same variance; flipping both loading and score leaves the curve move
%   unchanged, Tutorial 4 slide 18): fixed here as in Mele, p. 91 -
%     PC1 level      positive at every maturity
%     PC2 slope      positive at the short end, negative at the long end
%     PC3 curvature  positive at both ends, negative in the middle

% 1. Centre the data: each column minus its average
mu = mean(X, 1);
Xc = X - mu;

% 2. Covariance matrix of the maturities
S = cov(Xc);

% 3. Eigenvectors and eigenvalues, largest variance first
[V, D] = eig(S, 'vector');
[lambda, order] = sort(D, 'descend');
W = V(:, order);

% 4. Signs as in Mele p. 91: PC1 positive on average (rates up), PC2 higher
%    at the short end than at the long end, PC3 lower in the middle than at
%    the two ends
p = size(W, 2);
if p >= 1 && sum(W(:, 1)) < 0
    W(:, 1) = -W(:, 1);
end
if p >= 2 && W(1, 2) < W(end, 2)
    W(:, 2) = -W(:, 2);
end
if p >= 3
    middle = round(p/2);
    if W(middle, 3) > (W(1, 3) + W(end, 3))/2
        W(:, 3) = -W(:, 3);
    end
end

% 5. Variance shares and daily scores
share = lambda / sum(lambda);
F = Xc * W;
end
