function [T, maturities, labels] = fred_yield_history(onProgress)
% FRED_YIELD_HISTORY  Full daily history of the U.S. Treasury curve, kept up to date.
%   [T, maturities, labels] = fred_yield_history(onProgress)
%
%   The history since 1962 is saved in data/treasury_history.mat next to this
%   file. The first call downloads everything (a few seconds); every later call
%   downloads only the last few weeks and adds them to the saved file.
%   Outputs as in fred_yield_curve: T is a timetable (one row per day, one
%   column per maturity, yields in %, NaN where a maturity did not exist).
%   onProgress (optional) is passed on to fred_yield_curve.

if nargin < 1
    onProgress = @(~, ~, ~) [];
end

folder = fullfile(fileparts(mfilename('fullpath')), 'data');
file   = fullfile(folder, 'treasury_history.mat');

if isfile(file)
    % 1. Saved history: download again the last 15 days (late or revised
    %    values) and everything after them
    saved = load(file, 'T');
    from  = saved.T.Time(end) - days(15);
    [recent, maturities, labels] = fred_yield_curve(from, onProgress);
    T = [saved.T(saved.T.Time < from, :); recent];
else
    % 2. First run: the whole history (the first series start in 1962)
    [T, maturities, labels] = fred_yield_curve(datetime(1962, 1, 1), onProgress);
    if ~isfolder(folder)
        mkdir(folder);
    end
end

save(file, 'T');
end
