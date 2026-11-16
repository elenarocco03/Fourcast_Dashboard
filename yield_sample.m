function data = yield_sample(T, from, freq)
% YIELD_SAMPLE  Prepare the yield data shared by all the models.
%   data = yield_sample(T, from, freq)
%
%   T     timetable from fred_yield_history (yields in %)
%   from  first date of the sample (datetime), e.g. datetime(2010,1,1)
%   freq  "daily" or "monthly" (last available day of each month)
%
%   data.dates   dates of the observations (n x 1)
%   data.tau     maturities in years (1 x p)
%   data.labels  maturity names, e.g. "3M" (1 x p)
%   data.Y       yields in DECIMALS (n x p); days with a missing maturity are dropped
%   data.r       short-rate proxy = 3M yield (n x 1)
%   data.dt      time step in years (1/252 daily, 1/12 monthly)
%   data.freq    the frequency used
%
%   The 10 maturities published by the Treasury, 1M to 20Y. The 30Y is left
%   out and the 15Y is not real data, so it is never used.
%   Note: FRED yields are par yields; the models treat them as zero-coupon yields.

if nargin < 3
    freq = "monthly";
end

series = ["DGS1MO" "DGS3MO" "DGS6MO" "DGS1" "DGS2" "DGS3" "DGS5" "DGS7" "DGS10" "DGS20"];
tau    = [1/12 3/12 6/12 1 2 3 5 7 10 20];
labels = ["1M" "3M" "6M" "1Y" "2Y" "3Y" "5Y" "7Y" "10Y" "20Y"];

% 1. Sample period and maturities; keep only days with all 10 yields
T = T(T.Properties.RowTimes >= from, series);
T = rmmissing(T);

% 2. Frequency
switch lower(string(freq))
    case "daily"
        dt = 1/252;
    case "monthly"
        % last available day of each month (keeps the true date)
        month = dateshift(T.Properties.RowTimes, 'start', 'month');
        [~, last] = unique(month, 'last');
        T  = T(last, :);
        dt = 1/12;
    otherwise
        error('yield_sample:freq', 'freq must be "daily" or "monthly"');
end

% 3. Output, in decimals
data.dates  = T.Properties.RowTimes;
data.tau    = tau;
data.labels = labels;
data.Y      = T.Variables / 100;
data.r      = data.Y(:, labels == "3M");
data.dt     = dt;
data.freq   = string(freq);
end
