function setup_fred_key(key)
% SETUP_FRED_KEY  Save your personal FRED API key once, so the dashboard can use it.
%   setup_fred_key('your32characterkey')
%
%   The key is written to the file .fred_api_key in your home folder and is
%   never stored in the dashboard code. Get a free key at
%   https://fredaccount.stlouisfed.org/apikeys (create an account, then
%   "Request API Key").

key = strtrim(char(key));
if ~isempty(regexp(key, '[^a-z0-9]', 'once')) || numel(key) ~= 32
    error('setup_fred_key:format', ...
          'A FRED API key is 32 lowercase letters and digits. Check what you pasted.');
end

home = getenv('HOME');                 % macOS / Linux
if isempty(home)
    home = getenv('USERPROFILE');      % Windows
end
file = fullfile(home, '.fred_api_key');

fid = fopen(file, 'w');
if fid < 0
    error('setup_fred_key:write', 'Cannot write %s', file);
end
fwrite(fid, key, 'char');
fclose(fid);
fprintf('FRED API key saved in %s\nNow run:  dashboard\n', file);
end
