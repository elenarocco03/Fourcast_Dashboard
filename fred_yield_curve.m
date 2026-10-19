function [T, maturities, labels] = fred_yield_curve(startDate, onProgress)
% FRED_YIELD_CURVE  Download U.S. Treasury constant-maturity yields from FRED.
%   [T, maturities, labels] = fred_yield_curve(startDate, onProgress)
%
%   startDate   first day to download (datetime); default: 30 days ago
%   onProgress  optional function called before each series as
%               onProgress(done, total, name), and once at the end
%   T           timetable, one row per day, one column per maturity, yields in %
%               (NaN where FRED has no value, e.g. on holidays)
%   maturities  maturity of each column, in years
%   labels      short name of each maturity ("1M", ..., "30Y"), for the chart
%
%   Source: Board of Governors of the Federal Reserve, H.15, via the FRED API.
%   The API key is never written in the code: it is read from the environment
%   variable FRED_API_KEY or, if that is empty, from the file ~/.fred_api_key.

if nargin < 1 || isempty(startDate)
    startDate = datetime('today') - days(30);
end
if nargin < 2
    onProgress = @(~, ~, ~) [];
end

% 1. The eleven series of the Treasury curve and their maturities in years
series     = ["DGS1MO" "DGS3MO" "DGS6MO" "DGS1" "DGS2" "DGS3" ...
              "DGS5" "DGS7" "DGS10" "DGS20" "DGS30"];
maturities = [1/12 3/12 6/12 1 2 3 5 7 10 20 30];
labels     = ["1M" "3M" "6M" "1Y" "2Y" "3Y" "5Y" "7Y" "10Y" "20Y" "30Y"];

% 2. The personal API key
key = readKey();

% 3. One request per series; each answer becomes one column
url  = 'https://api.stlouisfed.org/fred/series/observations';
opts = weboptions('Timeout', 20);
cols = cell(1, numel(series));
for k = 1:numel(series)
    onProgress(k - 1, numel(series), series(k));
    try
        data = webread(url, 'series_id', char(series(k)), 'api_key', key, ...
                       'file_type', 'json', ...
                       'observation_start', char(startDate, 'yyyy-MM-dd'), opts);
    catch err
        % MATLAB's message contains the full URL: hide the key before showing it
        error('fred_yield_curve:download', 'Download of %s failed: %s', ...
              series(k), strrep(err.message, key, '***'));
    end
    obs   = data.observations;
    dates = datetime({obs.date}, 'InputFormat', 'yyyy-MM-dd');
    vals  = str2double({obs.value});     % FRED writes "." for a missing day -> NaN
    cols{k} = timetable(dates(:), vals(:), 'VariableNames', series(k));
end
onProgress(numel(series), numel(series), "");

% 4. Put the columns side by side, matching the dates
T = synchronize(cols{:});
end


function key = readKey()
% FRED API key: environment variable first, then the file in the home folder
key = strtrim(getenv('FRED_API_KEY'));
if isempty(key)
    home = getenv('HOME');                 % macOS / Linux
    if isempty(home)
        home = getenv('USERPROFILE');      % Windows
    end
    file = fullfile(home, '.fred_api_key');
    if ~isfile(file)
        error('fred_yield_curve:noKey', ...
              'FRED API key not found: set FRED_API_KEY or create the file %s', file);
    end
    key = strtrim(fileread(file));
end
end
