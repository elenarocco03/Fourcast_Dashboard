function dashboard
% DASHBOARD  Fourcast - yield curve analytics, one tab per section.
%   Section 1: Data Analysis, with two sub-tabs:
%     Today    today's U.S. Treasury yield curve and its key numbers
%     History  the curve moving through time over a chosen period
%   Data: daily FRED history since 1962, saved in data/ and brought up to
%   date every time the dashboard opens (fred_yield_history.m).
%   Maturities shown: 1M ... 20Y. The 30Y is left out; the 15Y is not
%   published by the Treasury and is interpolated between 10Y and 20Y.
%   Style: deep navy background, soft blue accent.
%   Setup: see README.txt (each user needs a free FRED API key).

% Only one download at a time: a second Run while the first dashboard is still
% loading would make MATLAB refuse the web request
if isappdata(groot, 'FourcastLoading') && getappdata(groot, 'FourcastLoading')
    disp('Fourcast is already loading: wait for its window.');
    return
end
setappdata(groot, 'FourcastLoading', true);
loadingDone = onCleanup(@() setappdata(groot, 'FourcastLoading', false));

col = palette();

% --- Main window, opening on the Fourcast loading screen ------------------
fig = uifigure('Name', 'Fourcast', 'Position', [80 80 1280 800], 'Color', col.bg);
[splash, page] = showSplash(fig, col);

% Bring the saved history up to date (the first time: all of it); the bar
% advances one step per maturity downloaded
first = ~isfile(fullfile(fileparts(mfilename('fullpath')), 'data', 'treasury_history.mat'));
started = tic;
try
    [T, maturities, labels] = fred_yield_history(@(k, n, name) ...
        splashProgress(page, k, n, name, toc(started), first));
catch err
    page.Data = struct('p', 1, 'text', ['Download failed: ' err.message], 'error', true);
    return
end
pause(0.3);              % let the full bar be seen for a moment
delete(splash);
clear loadingDone        % download finished: another dashboard may start

% One cell that fills the whole window: the tabs take all the space
g = uigridlayout(fig, [1 1]);
g.BackgroundColor = col.bg;
g.Padding = [0 0 0 0];

% --- Sections: one tab each -----------------------------------------------
tabs    = uitabgroup(g);
tabData = uitab(tabs, 'Title', 'Data Analysis', 'BackgroundColor', col.bg);

buildDataAnalysisTab(fig, tabData, col, T, maturities, labels);

end


% ==========================================================================
function [splash, page] = showSplash(fig, col)
% Loading screen: the Fourcast logo, a progress bar and a status line, all
% centred. It is a small HTML page, so the layout is exact and the bar can
% move while MATLAB is busy downloading.
splash = uigridlayout(fig, [1 1]);
splash.Padding         = [0 0 0 0];
splash.BackgroundColor = col.bg;

c = @(rgb) cssColour(rgb);
html = sprintf([ ...
  '<!DOCTYPE html><html><head><meta charset="utf-8"><style>' ...
  'html,body{margin:0;height:100%%;background:%s;' ...
  'font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;-webkit-font-smoothing:antialiased}' ...
  '.wrap{height:100%%;display:flex;flex-direction:column;align-items:center;justify-content:center}' ...
  '.logo{display:flex;align-items:center;gap:30px}' ...
  '.word{font-size:76px;font-weight:700;letter-spacing:-1.5px;line-height:1;color:%s}' ...
  '.word span{color:%s}' ...
  '.tag{font-size:20px;color:%s;margin:10px 0 0 4px}' ...
  '.bar{width:440px;height:3px;background:%s;border-radius:2px;margin-top:64px;overflow:hidden}' ...
  '.fill{height:100%%;width:0;background:%s;border-radius:2px;transition:width .3s ease}' ...
  '.status{margin-top:14px;font-size:13px;color:%s;text-align:center;max-width:640px}' ...
  '</style></head><body><div class="wrap">' ...
  '<div class="logo">' ...
  '<svg width="118" height="140" viewBox="-6 -8 262 314">' ...
  '<g fill="%s"><rect x="0" y="216" width="45" height="84" rx="10"/>' ...
  '<rect x="65" y="146" width="45" height="154" rx="10"/>' ...
  '<rect x="130" y="91" width="45" height="209" rx="10"/>' ...
  '<rect x="195" y="51" width="45" height="249" rx="10"/></g>' ...
  '<path d="M22 181 C48 162 62 152 80 136 S120 100 140 82 S192 36 217 16" fill="none" ' ...
  'stroke="%s" stroke-width="13" stroke-linecap="round"/>' ...
  '<circle cx="217" cy="16" r="15" fill="%s"/></svg>' ...
  '<div><div class="word">Four<span>cast</span></div>' ...
  '<div class="tag">Yield curve analytics</div></div></div>' ...
  '<div class="bar"><div class="fill" id="fill"></div></div>' ...
  '<div class="status" id="status">Connecting to FRED&hellip;</div>' ...
  '</div><script>' ...
  'function setup(h){h.addEventListener("DataChanged",function(){var d=h.Data;' ...
  'document.getElementById("fill").style.width=(100*d.p)+"%%";' ...
  'document.getElementById("status").textContent=d.text;' ...
  'if(d.error){document.getElementById("status").style.color="%s";' ...
  'document.getElementById("fill").style.background="%s";}});' ...
  'h.sendEventToMATLAB("ready");}' ...
  '</script></body></html>'], ...
  c(col.bg), c(col.text), c(col.accent), c(col.muted), c(col.line), c(col.accent), ...
  c(col.dim), c(col.text), c(col.accent), c(col.accent), c(col.down), c(col.down));

file = fullfile(tempdir, 'fourcast_splash.html');
fid  = fopen(file, 'w');
fwrite(fid, html, 'char');
fclose(fid);

page = uihtml(splash, 'HTMLSource', file);
page.HTMLEventReceivedFcn = @(src, ev) setappdata(src, 'ready', true);

% Wait (at most 5 s) until the page is drawn, or the logo may not show up
waitStart = tic;
while ~isappdata(page, 'ready') && toc(waitStart) < 5
    drawnow;
    pause(0.05);
end
end

function splashProgress(page, k, n, name, elapsed, first)
% Move the bar to k/n and say which maturity is being downloaded and how
% long is left (estimated from the time taken so far)
if k >= n
    text = 'Ready';
elseif k == 0
    text = 'Connecting to FRED...';
else
    name = regexprep(regexprep(name, '^DGS(\d+)MO$', '$1M'), '^DGS(\d+)$', '$1Y');  % DGS5 -> 5Y
    text = sprintf('Downloading the %s yield  %s  %d of %d  %s  about %d s left', name, ...
                   char(183), k + 1, n, char(183), ceil(elapsed/k*(n - k)));
end
if first && k < n
    text = [text '  ' char(183) '  first run: full history since 1962'];
end
page.Data = struct('p', k/n, 'text', text, 'error', false);
drawnow;
end

function s = cssColour(rgb)
% [r g b] between 0 and 1 -> 'rgb(R,G,B)', for the coloured word mark
% (the label's HTML ignores '#RRGGBB' colours inside <span>)
s = sprintf('rgb(%d,%d,%d)', round(255*rgb));
end


% ==========================================================================
function buildDataAnalysisTab(fig, tab, col, T, maturities, labels)
% Data Analysis: two sub-tabs that share the same data.

% 2. The maturities the dashboard shows: no 30Y, an interpolated 15Y
[T, maturities, labels] = prepareCurve(T, maturities, labels);

% 3. Sub-tabs
g = uigridlayout(tab, [1 1]);
g.BackgroundColor = col.bg;
g.Padding = [0 0 0 0];
sub        = uitabgroup(g);
tabToday   = uitab(sub, 'Title', 'Today',   'BackgroundColor', col.bg);
tabHistory = uitab(sub, 'Title', 'History', 'BackgroundColor', col.bg);

% Mouse moves are sent to every chart; each one reacts only when visible
fig.UserData.onMove = {};
fig.WindowButtonMotionFcn = @(src, ~) cellfun(@(f) f(), src.UserData.onMove);

buildTodayTab(fig, tabToday, col, T, maturities, labels);
buildHistoryTab(fig, tabHistory, col, T, maturities, labels);
sub.SelectedTab = tabToday;          % always open on Today
end


function [T, maturities, labels] = prepareCurve(T, maturities, labels)
% Drop the 30Y and add a 15Y, interpolated linearly between 10Y and 20Y
% (15 is halfway between 10 and 20, so the interpolation is the average).
keep = labels ~= "30Y";
T = T(:, keep);  maturities = maturities(keep);  labels = labels(keep);

T.DGS15 = (T.DGS10 + T.DGS20) / 2;
i10 = find(labels == "10Y");
T = T(:, [1:i10, width(T), i10+1:width(T)-1]);      % 15Y right after 10Y
maturities = [maturities(1:i10) 15    maturities(i10+1:end)];
labels     = [labels(1:i10)     "15Y" labels(i10+1:end)];
end


% ==========================================================================
function buildTodayTab(fig, tab, col, T, maturities, labels)
% Today: header, four key numbers, maturity buttons, chart.

% 1. Latest day with every maturity, and the complete day before it
%    (holidays are empty rows)
complete = find(all(~isnan(T.Variables), 2));
if numel(complete) < 2
    showMessage(tab, col, 'FRED returned too few complete days.');
    return
end
asOf      = T.Time(complete(end));
yields    = T{complete(end), :};
yieldsPrv = T{complete(end-1), :};

% 2. Page layout, top to bottom: header, key numbers, buttons, chart, source
page = uigridlayout(tab, [5 1]);
page.RowHeight       = {56, 92, 34, '1x', 30};
page.Padding         = [28 20 28 10];
page.RowSpacing      = 16;
page.BackgroundColor = col.bg;

dot = ['  ' char(183) '  '];
buildHeader(page, col, 'Yield Curve US', ['U.S. Treasury constant maturity' dot ...
            'as of ' char(asOf, 'dd MMM yyyy') dot 'updated on opening from FRED']);
buildKeyNumbers(page, col, labels, yields, yieldsPrv);

% Maturity buttons: lit = shown on the chart, dark = hidden
bar = uigridlayout(page, [1 16]);
bar.ColumnWidth     = [repmat({56}, 1, 11), {'1x', 74, 76, 90, 70}];
bar.ColumnSpacing   = 6;
bar.Padding         = [0 0 0 0];
bar.BackgroundColor = col.bg;
n   = numel(labels);
btn = gobjects(1, n);
for k = 1:n
    btn(k) = uibutton(bar, 'state', 'Text', char(labels(k)), 'Value', true, ...
                      'FontName', col.font, 'FontSize', 12, 'FontWeight', 'bold', ...
                      'ValueChangedFcn', @(~, ~) redraw());
end
btn(labels == "15Y").Tooltip = 'Interpolated between 10Y and 20Y';
uilabel(bar, 'Text', '');
ref = addReference(bar, col, @() redraw());
uibutton(bar, 'Text', 'Select all', 'FontName', col.font, 'BackgroundColor', col.surface, ...
         'FontColor', col.text2, 'ButtonPushedFcn', @(~, ~) setAll(true));
uibutton(bar, 'Text', 'Clear', 'FontName', col.font, 'BackgroundColor', col.surface, ...
         'FontColor', col.text2, 'ButtonPushedFcn', @(~, ~) setAll(false));

ax = makeAxes(page, col);
sourceNote(page, col);

% Hover: value of the maturity nearest to the mouse
hov = [];  shownX = [];  shownY = [];  shownNames = strings(0);
fig.UserData.onMove{end+1} = @onMove;

drawnow;          % let the layout settle before the first chart, or the axes come out clipped
redraw();

    function setAll(value)
        set(btn, 'Value', value);
        redraw();
    end

    function redraw()
        sel = [btn.Value];
        styleButtons(btn, col);
        shownX = maturities(sel);  shownY = yields(sel);  shownNames = labels(sel);

        cla(ax);
        if ~any(sel)
            text(ax, 0.5, 0.5, 'Select at least one maturity', 'Units', 'normalized', ...
                 'Color', col.muted, 'HorizontalAlignment', 'center', ...
                 'FontName', col.font, 'FontSize', 14);
            styleAxes(ax, col, [0 1], [0 1], [], {});
            return
        end

        % The chart fits the curve of the maturities that are switched on, so
        % small differences between them are visible; the reference line
        % shows only when its level falls inside that range
        x = maturities(sel);  y = yields(sel);
        [xr, yr] = fitRange(x, y);
        hold(ax, 'on');
        drawCurve(ax, col, x, y, yr(1), 1);
        drawReference(ax, col, ref);
        hov = makeHover(ax, col);
        hold(ax, 'off');
        [tk, tl] = maturityTicks(xr, x, labels(sel));
        styleAxes(ax, col, xr, yr, tk, tl);
    end

    function onMove()
        if tab.Parent.SelectedTab ~= tab || isempty(hov), return, end
        updateHover(hov, ax, shownX, shownY, shownNames);
    end
end


% ==========================================================================
function buildHistoryTab(fig, tab, col, T, maturities, labels)
% History: the curve moving through time over a chosen period.

trailLength = 3;                  % past curves left on screen as a fading trail
firstDay = T.Time(1);
lastDay  = T.Time(end);

page = uigridlayout(tab, [6 1]);
page.RowHeight       = {56, 34, 62, '1x', 28, 30};
page.Padding         = [28 20 28 10];
page.RowSpacing      = 12;
page.BackgroundColor = col.bg;

buildHeader(page, col, 'Yield Curve US  |  History', ...
            ['How the curve has moved, period of your choice' '  ' char(183) '  ' ...
             'daily FRED data since ' char(firstDay, 'yyyy')]);

% --- Controls: period, step, play, speed ----------------------------------
ctl = uigridlayout(page, [1 13]);
ctl.ColumnWidth     = {40, 140, 24, 140, 36, 110, 74, 76, '1x', 90, 46, 160, 50};
ctl.ColumnSpacing   = 8;
ctl.Padding         = [0 0 0 0];
ctl.BackgroundColor = col.bg;
smallLabel(ctl, col, 'From');
dpFrom = uidatepicker(ctl, 'Value', max(datetime(2000, 1, 1), firstDay), ...
                      'Limits', [firstDay lastDay], 'DisplayFormat', 'dd MMM yyyy', ...
                      'BackgroundColor', col.surface, 'FontColor', col.text, 'FontName', col.font);
smallLabel(ctl, col, 'To');
dpTo = uidatepicker(ctl, 'Value', lastDay, 'Limits', [firstDay lastDay], ...
                    'DisplayFormat', 'dd MMM yyyy', 'BackgroundColor', col.surface, ...
                    'FontColor', col.text, 'FontName', col.font);
smallLabel(ctl, col, 'Step');
ddStep = uidropdown(ctl, 'Items', {'Monthly', 'Weekly', 'Daily'}, 'Value', 'Monthly', ...
                    'BackgroundColor', col.surface, 'FontColor', col.text, 'FontName', col.font);
ref = addReference(ctl, col, @refChanged);
uilabel(ctl, 'Text', '');
btnPlay = uibutton(ctl, 'Text', 'Play', 'FontName', col.font, 'FontWeight', 'bold', ...
                   'BackgroundColor', col.accentSoft, 'FontColor', col.text);
smallLabel(ctl, col, 'Speed');
slSpeed = uislider(ctl, 'Limits', [2 30], 'Value', 2, 'MajorTicks', [], 'MinorTicks', []);
lbSpeed = smallLabel(ctl, col, '2 /s');

% --- Big date on the left, 1Y / 2Y / 10Y yields of that day on the right ---
top = uigridlayout(page, [1 2]);
top.ColumnWidth     = {'1x', 420};
top.Padding         = [0 0 0 0];
top.BackgroundColor = col.bg;
left = uigridlayout(top, [2 1]);
left.RowHeight       = {36, 20};
left.RowSpacing      = 2;
left.Padding         = [0 0 0 0];
left.BackgroundColor = col.bg;
lbDate = uilabel(left, 'Text', '', 'FontName', col.font, 'FontSize', 28, ...
                 'FontWeight', 'bold', 'FontColor', col.text);
lbTrail = uilabel(left, 'Interpreter', 'html', 'FontName', col.font, 'FontSize', 12, ...
                  'FontColor', col.dim);
cardNames = ["1Y" "2Y" "10Y"];
cardValue = yieldCards(top, col, cardNames);

ax = makeAxes(page, col);

% --- Timeline: drag to any frame ------------------------------------------
tl = uigridlayout(page, [1 3]);
tl.ColumnWidth     = {90, '1x', 90};
tl.Padding         = [0 0 0 0];
tl.BackgroundColor = col.bg;
lbStart = smallLabel(tl, col, '');
slTime  = uislider(tl, 'Limits', [1 2], 'Value', 1, 'MajorTicks', [], 'MinorTicks', []);
lbEnd   = smallLabel(tl, col, '');
lbEnd.HorizontalAlignment = 'right';

sourceNote(page, col);

% --- Animation state --------------------------------------------------------
frames = [];  iFrame = 1;  yr = [0 1];
hov = [];  frameX = [];  frameY = [];  frameNames = strings(0);  mouseIn = false;
fig.UserData.onMove{end+1} = @onMove;
tmr = timer('ExecutionMode', 'fixedSpacing', 'BusyMode', 'drop', ...
            'Period', round(1/2, 3), 'TimerFcn', @(~, ~) tick());
addlistener(fig, 'ObjectBeingDestroyed', @(~, ~) cleanup());

dpFrom.ValueChangedFcn = @(~, ~) rebuild();
dpTo.ValueChangedFcn   = @(~, ~) rebuild();
ddStep.ValueChangedFcn = @(~, ~) rebuild();
btnPlay.ButtonPushedFcn = @(~, ~) togglePlay();
slSpeed.ValueChangedFcn = @(~, ~) setSpeed();
slTime.ValueChangingFcn = @(~, ev) scrub(ev.Value);
slTime.ValueChangedFcn  = @(src, ~) scrub(src.Value);

drawnow;
rebuild();

    function rebuild()
        % Frames of the chosen period: the last day of each month (or week)
        stopPlay();
        if dpTo.Value <= dpFrom.Value
            dpTo.Value = min(lastDay, dpFrom.Value + calmonths(12));
        end
        inPeriod = T.Time >= dpFrom.Value & T.Time <= dpTo.Value + days(1);
        enough   = sum(~isnan(T.Variables), 2) >= 3;       % skip empty holidays
        rows = find(inPeriod & enough);
        t = T.Time(rows);
        switch ddStep.Value
            case 'Monthly', key = year(t)*12 + month(t);
            case 'Weekly',  key = floor(days(t - datetime(1962, 1, 1)) / 7);
            otherwise,      key = (1:numel(t))';
        end
        [~, last] = unique(key, 'last');
        frames = rows(last);

        yr = [];          % the vertical range follows the curve (see showFrame)
        lbTrail.Text = trailLegend(col, trailLength, ddStep.Value);

        slTime.Limits = [1 max(2, numel(frames))];
        lbStart.Text  = char(T.Time(frames(1)),   'MMM yyyy');
        lbEnd.Text    = char(T.Time(frames(end)), 'MMM yyyy');

        showFrame(1);
    end

    function showFrame(i)
        % Each frame redraws the curve of that day and, fading behind it,
        % the curves of the frames just before
        prev = iFrame;
        iFrame = i;
        followLevel(i, prev);
        cla(ax);
        hold(ax, 'on');
        [x, y, names] = curveAt(frames(i));
        hLine = drawCurve(ax, col, x, y, yr(1), 1);

        % Past curves over the shaded area, the curve of the day on top of all
        for k = trailLength:-1:1
            j = i - k;
            if j >= 1
                [xj, yj] = curveAt(frames(j));
                plot(ax, smoothX(xj), smoothY(xj, yj), '-', 'LineWidth', 1, ...
                     'Color', trailColour(col, k, trailLength));
            end
        end
        uistack(hLine, 'top');
        drawReference(ax, col, ref);
        hov = makeHover(ax, col);
        hold(ax, 'off');
        [tk, tlb] = maturityTicks([0 20.5], maturities, labels);
        styleAxes(ax, col, [0 20.5], yr, tk, tlb);
        frameX = x;  frameY = y;  frameNames = names;
        if mouseIn                                          % keep it while playing
            updateHover(hov, ax, frameX, frameY, frameNames);
        end

        day = T.Time(frames(i));
        if strcmp(ddStep.Value, 'Monthly')
            lbDate.Text = char(day, 'MMMM yyyy');
        else
            lbDate.Text = char(day, 'dd MMMM yyyy');
        end
        yDay = T{frames(i), :};
        for c = 1:numel(cardNames)
            v = yDay(labels == cardNames(c));
            if isnan(v)
                cardValue(c).Text = char(8211);           % maturity not yet issued
            else
                cardValue(c).Text = sprintf('%.2f%%', v);
            end
        end
        slTime.Value = i;
    end

    function refChanged()
        showFrame(iFrame);               % same frame, axis refitted at once
    end

    function followLevel(i, prev)
        % Vertical range that follows the level of the rates: it fits the
        % curve of the day and its trail, and glides towards the new range
        % while playing (a jump on the timeline or a new period moves it at once)
        lo = inf;  hi = -inf;
        for j = max(1, i - trailLength):i
            [~, yj] = curveAt(frames(j));
            lo = min([lo yj]);  hi = max([hi yj]);
        end
        lo = min([lo referenceLevel(ref)]);  hi = max([hi referenceLevel(ref)]);
        span   = max(hi - lo, 1.0);              % never zoom in below 1 point
        target = (lo + hi)/2 + [-0.5 0.5]*1.25*span;
        if isempty(yr) || i ~= prev + 1
            yr = target;
        else
            yr = yr + 0.3*(target - yr);
        end

        % While gliding, never cut the curve of the day
        [~, y] = curveAt(frames(i));
        yr = [min(yr(1), min(y) - 0.05*span), max(yr(2), max(y) + 0.05*span)];

        % Rates near zero: do not open a large negative band that no rate reaches
        if lo >= 0
            yr(1) = max(yr(1), -0.25);
        end
    end

    function [x, y, names] = curveAt(row)
        y  = T{row, :};
        ok = ~isnan(y);
        x  = maturities(ok);  y = y(ok);  names = labels(ok);
    end

    function onMove()
        if tab.Parent.SelectedTab ~= tab || isempty(hov), return, end
        mouseIn = updateHover(hov, ax, frameX, frameY, frameNames);
    end

    function tick()
        if ~isvalid(ax), return, end
        if iFrame >= numel(frames)
            stopPlay();
            return
        end
        showFrame(iFrame + 1);
        drawnow limitrate;
    end

    function togglePlay()
        if strcmp(tmr.Running, 'on')
            stopPlay();
        else
            if iFrame >= numel(frames)
                showFrame(1);                 % at the end: start again
            end
            btnPlay.Text = 'Pause';
            start(tmr);
        end
    end

    function stopPlay()
        if isvalid(tmr) && strcmp(tmr.Running, 'on')
            stop(tmr);
        end
        if isvalid(btnPlay)
            btnPlay.Text = 'Play';
        end
    end

    function setSpeed()
        fps = round(slSpeed.Value);
        lbSpeed.Text = sprintf('%d /s', fps);
        running = strcmp(tmr.Running, 'on');
        if running, stop(tmr); end
        tmr.Period = round(1/fps, 3);
        if running, start(tmr); end
    end

    function scrub(value)
        stopPlay();
        showFrame(min(max(round(value), 1), numel(frames)));
    end

    function cleanup()
        if isvalid(tmr)
            stop(tmr);
            delete(tmr);
        end
    end
end


% ==========================================================================
function buildHeader(parent, col, titleText, subText)
% Page title and, below it, one line on what the page shows
h = uigridlayout(parent, [2 1]);
h.RowHeight       = {32, 20};
h.RowSpacing      = 2;
h.Padding         = [0 0 0 0];
h.BackgroundColor = col.bg;
uilabel(h, 'Text', titleText, 'FontName', col.font, 'FontSize', 26, ...
        'FontWeight', 'bold', 'FontColor', col.text);
uilabel(h, 'Text', subText, 'FontName', col.font, 'FontSize', 13, 'FontColor', col.muted);
end


function buildKeyNumbers(parent, col, labels, y, yPrev)
% Four cards: 10Y yield, 2s10s and 3m10y spreads, 20Y yield
at  = @(name) y(labels == name);
chg = @(name) sprintf('%+.0f bp on the day', 100*(at(name) - yPrev(labels == name)));
cards = {'10Y yield',    sprintf('%.2f%%', at("10Y")),                    chg("10Y");
         '2s10s spread', sprintf('%+.0f bp', 100*(at("10Y") - at("2Y"))), '10Y minus 2Y';
         '3m10y spread', sprintf('%+.0f bp', 100*(at("10Y") - at("3M"))), '10Y minus 3M';
         '20Y yield',    sprintf('%.2f%%', at("20Y")),                    chg("20Y")};

row = uigridlayout(parent, [1 4]);
row.ColumnSpacing   = 14;
row.Padding         = [0 0 0 0];
row.BackgroundColor = col.bg;
for k = 1:size(cards, 1)
    p = uipanel(row, 'BackgroundColor', col.surface, 'BorderType', 'line', ...
                'BorderColor', col.line);
    q = uigridlayout(p, [3 1]);
    q.RowHeight       = {16, 34, 18};
    q.RowSpacing      = 2;
    q.Padding         = [16 10 16 8];
    q.BackgroundColor = col.surface;
    uilabel(q, 'Text', upper(cards{k, 1}), 'FontName', col.mono, 'FontSize', 10, ...
            'FontColor', col.dim);
    uilabel(q, 'Text', cards{k, 2}, 'FontName', col.font, 'FontSize', 28, ...
            'FontWeight', 'bold', 'FontColor', col.text);

    % Third line: green if the yield went up on the day, red if it went down
    note = cards{k, 3};
    fc = col.muted;
    if contains(note, 'day') && startsWith(note, '+')
        fc = col.up;
    elseif contains(note, 'day') && startsWith(note, '-')
        fc = col.down;
    end
    uilabel(q, 'Text', note, 'FontName', col.font, 'FontSize', 12, 'FontColor', fc);
end
end


% ==========================================================================
% Shared building blocks
% ==========================================================================
function col = palette()
% Colour scheme of the whole dashboard
col.bg         = hex('030A13');   % page background
col.surface    = hex('0A1119');   % cards and inactive buttons
col.line       = hex('15212D');   % card borders and grid lines
col.text       = hex('EAF2FB');
col.text2      = hex('CDD8E6');   % labels on the chart
col.muted      = hex('8499AD');   % secondary text, axis numbers
col.dim        = hex('687E95');   % small captions
col.accent     = hex('4A8FE7');   % the curve
col.accentSoft = hex('1E4E7E');   % lit buttons
col.trailNew   = hex('3DC9B0');   % trail of past curves: teal for the most recent...
col.trailOld   = hex('8E7CC3');   % ...soft violet for the oldest
col.up         = hex('3FD693');   % yield up on the day
col.down       = hex('E04F55');   % yield down on the day
col.font       = 'Helvetica Neue';
col.mono       = 'Menlo';
end

function rgb = hex(h)
% 'RRGGBB' -> [r g b] between 0 and 1
rgb = hex2dec({h(1:2), h(3:4), h(5:6)})' / 255;
end

function c = blend(c0, c1, a)
% Colour a of the way from c0 to c1 (a = 0 gives c0, a = 1 gives c1)
c = (1 - a)*c0 + a*c1;
end

function ax = makeAxes(parent, col)
% Chart drawn straight on the page background, without frame or toolbar
ax = uiaxes(parent);
ax.Color = col.bg;
ax.Toolbar.Visible = 'off';
disableDefaultInteractivity(ax);
end

function hLine = drawCurve(ax, col, x, y, base, strength)
% Thin smooth curve through the observed points, with a fading blue area below it.
% The smoothing (pchip) passes exactly through every point and never
% overshoots between them.
xs = smoothX(x);
ys = smoothY(x, y);
if numel(x) >= 2
    % Area: each point of the curve is blue-tinted, the base is the background,
    % and MATLAB shades the colours in between
    nPts  = numel(xs);
    verts = [xs(:) ys(:); flipud(xs(:)) repmat(base, nPts, 1)];
    top   = repmat(blend(col.bg, col.accent, 0.30*strength), nPts, 1);
    bot   = repmat(col.bg, nPts, 1);
    patch(ax, 'Vertices', verts, 'Faces', 1:2*nPts, 'FaceVertexCData', [top; bot], ...
          'FaceColor', 'interp', 'EdgeColor', 'none');
end
hLine = plot(ax, xs, ys, '-', 'Color', col.accent, 'LineWidth', 1.6);
end

function h = makeHover(ax, col)
% Hover marker, hidden at start: thin vertical guide, dot on the curve, value box
h.guide = plot(ax, NaN, NaN, '-', 'Color', blend(col.bg, col.text, 0.25), 'LineWidth', 1);
h.dot   = plot(ax, NaN, NaN, 'o', 'MarkerSize', 7, 'MarkerFaceColor', col.accent, ...
               'MarkerEdgeColor', col.bg, 'LineWidth', 1.5);
h.box   = text(ax, NaN, NaN, '', 'Color', col.text, 'BackgroundColor', col.surface, ...
               'EdgeColor', col.line, 'Margin', 7, 'FontName', col.font, 'FontSize', 13, ...
               'VerticalAlignment', 'bottom', 'Visible', 'off');
end

function inside = updateHover(h, ax, x, y, names)
% Show the observed maturity nearest to the mouse, or hide when it is outside
cp = ax.CurrentPoint;
xl = xlim(ax);  yl = ylim(ax);
inside = ~isempty(x) && cp(1,1) >= xl(1) && cp(1,1) <= xl(2) && ...
         cp(1,2) >= yl(1) && cp(1,2) <= yl(2);
if ~inside
    set([h.guide h.dot], 'XData', NaN, 'YData', NaN);
    h.box.Visible = 'off';
    return
end
[~, j] = min(abs(x - cp(1,1)));
set(h.guide, 'XData', [x(j) x(j)], 'YData', [yl(1) y(j)]);
set(h.dot,   'XData', x(j),        'YData', y(j));

% Keep the box inside the chart near the left and right edges
where = (x(j) - xl(1)) / diff(xl);
align = 'center';
if where > 0.88, align = 'right'; elseif where < 0.08, align = 'left'; end
set(h.box, 'Position', [x(j), y(j) + 0.04*diff(yl), 0], 'HorizontalAlignment', align, ...
    'String', sprintf('\\bf%s\\rm   %.2f%%', names(j), y(j)), 'Visible', 'on');
end

function xs = smoothX(x)
if numel(x) < 2
    xs = x;
else
    xs = linspace(x(1), x(end), 200);
end
end

function ys = smoothY(x, y)
if numel(x) < 2
    ys = y;
else
    ys = pchip(x, y, linspace(x(1), x(end), 200));
end
end

function [xr, yr] = fitRange(x, y)
% Axis limits that fit the points shown, with a small margin
if numel(x) == 1
    xr = [x - 1, x + 1];
else
    xr = [min(x), max(x)] + [-1 1]*0.03*(max(x) - min(x));
end
pad = max(0.12*(max(y) - min(y)), 0.05);
yr  = [min(y) - pad, max(y) + pad];
end

function [tk, tl] = maturityTicks(xr, x, names)
% Tick marks at the usual maturities inside the visible range; when only the
% short end is shown, at the maturities themselves
usual = [1 2 3 5 7 10 15 20];
if xr(2) <= 1.5 || numel(x) == 1
    tk = x;  tl = cellstr(names);
else
    tk = usual(usual >= xr(1) & usual <= xr(2));
    tl = arrayfun(@(v) sprintf('%dY', v), tk, 'UniformOutput', false);
end
end

function styleAxes(ax, col, xr, yr, tk, tl)
% Chart look: horizontal hairlines only, no axis lines, soft numbers
ax.Color     = col.bg;
ax.XColor    = col.muted;
ax.YColor    = col.muted;
ax.GridColor = col.line;
ax.GridAlpha = 1;
ax.FontName  = col.font;
ax.FontSize  = 12;
ax.Box       = 'off';
ax.TickLength = [0 0];
ax.XGrid     = 'off';
ax.YGrid     = 'on';
xlim(ax, xr);
ylim(ax, yr);
xticks(ax, tk);
xticklabels(ax, tl);
if diff(yr) < 0.6
    ytickformat(ax, '%.2f%%');
else
    ytickformat(ax, '%.1f%%');
end
try                                   % hide the axis lines, keep the numbers
    ax.XRuler.Axle.Visible = 'off';
    ax.YRuler.Axle.Visible = 'off';
catch
end
end

function styleButtons(btn, col)
% Lit buttons in blue, the others dark
for j = 1:numel(btn)
    if btn(j).Value
        btn(j).BackgroundColor = col.accentSoft;  btn(j).FontColor = col.text;
    else
        btn(j).BackgroundColor = col.surface;     btn(j).FontColor = col.dim;
    end
end
end

function c = trailColour(col, k, n)
% Colour of the past curve k frames back (k = 1 the most recent, n the oldest):
% from teal to soft violet, and fainter the older it is
t = (k - 1) / max(n - 1, 1);
c = blend(col.trailNew, col.trailOld, t);
c = blend(col.bg, c, 0.85 - 0.5*t);
end

function s = trailLegend(col, n, step)
% One short dash per past curve, oldest on the left, and what they are
units = struct('Monthly', 'months', 'Weekly', 'weeks', 'Daily', 'days');
dashes = '';
for k = n:-1:1
    dashes = [dashes sprintf('<b style="color:%s">&#9644;</b> ', ...
                             cssColour(trailColour(col, k, n)))]; %#ok<AGROW>
end
s = sprintf('%s&nbsp; previous %d %s', dashes, n, units.(step));
end

function ref = addReference(parent, col, onChange)
% Check box and level (%) of the Fed reference line (thin red dashes)
ref.on = uicheckbox(parent, 'Text', 'Fed ref.', 'Value', true, 'FontName', col.font, ...
                    'FontColor', col.text2, 'ValueChangedFcn', @(~, ~) onChange());
ref.level = uieditfield(parent, 'numeric', 'Value', 2, 'Limits', [-5 25], ...
                        'ValueDisplayFormat', '%.2f%%', 'FontName', col.font, ...
                        'BackgroundColor', col.surface, 'FontColor', col.text, ...
                        'Tooltip', 'Reference level for the Fed, in percent', ...
                        'ValueChangedFcn', @(~, ~) onChange());
end

function v = referenceLevel(ref)
% The reference level, or empty when the line is switched off
v = [];
if ref.on.Value
    v = ref.level.Value;
end
end

function drawReference(ax, col, ref)
% Thin, soft red dashed line at the reference level, without labels
v = referenceLevel(ref);
if isempty(v), return, end
yline(ax, v, '--', 'Color', blend(col.bg, col.down, 0.85), 'LineWidth', 0.75);
end

function value = yieldCards(parent, col, names)
% Small cards side by side, one per maturity; returns the value labels
g = uigridlayout(parent, [1 numel(names)]);
g.ColumnSpacing   = 10;
g.Padding         = [0 0 0 0];
g.BackgroundColor = col.bg;
value = gobjects(1, numel(names));
for k = 1:numel(names)
    p = uipanel(g, 'BackgroundColor', col.surface, 'BorderType', 'line', ...
                'BorderColor', col.line);
    q = uigridlayout(p, [2 1]);
    q.RowHeight       = {14, 26};
    q.RowSpacing      = 2;
    q.Padding         = [14 6 14 6];
    q.BackgroundColor = col.surface;
    uilabel(q, 'Text', [char(names(k)) ' YIELD'], 'FontName', col.mono, 'FontSize', 10, ...
            'FontColor', col.dim);
    value(k) = uilabel(q, 'Text', '', 'FontName', col.font, 'FontSize', 22, ...
                       'FontWeight', 'bold', 'FontColor', col.text);
end
end

function lb = smallLabel(parent, col, txt)
lb = uilabel(parent, 'Text', txt, 'FontName', col.font, 'FontSize', 12, 'FontColor', col.muted);
end

function sourceNote(parent, col)
% Source and the notice required by FRED's terms of use
uilabel(parent, 'FontName', col.font, 'FontSize', 10, 'FontColor', col.dim, 'WordWrap', 'on', ...
    'Text', ['Source: Board of Governors of the Federal Reserve System (H.15), via FRED. ' ...
             '15Y interpolated between 10Y and 20Y (not published by the Treasury). ' ...
             'This product uses the FRED' char(174) ' API but is not endorsed or ' ...
             'certified by the Federal Reserve Bank of St. Louis.']);
end

function showMessage(tab, col, message)
% Full-tab message, used when the data cannot be shown
g = uigridlayout(tab, [1 1]);
g.BackgroundColor = col.bg;
uilabel(g, 'Text', message, 'FontName', col.font, 'FontSize', 16, 'FontColor', col.muted, ...
        'WordWrap', 'on', 'HorizontalAlignment', 'center');
end
