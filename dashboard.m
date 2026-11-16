function dashboard
% DASHBOARD  Fourcast - yield curve analytics, one tab per section.
%   Control panel (opens first): maturities and PCA settings for the whole
%     dashboard; Apply redraws every section with them.
%   Section 1: Data Analysis, with two sub-tabs:
%     Today    today's U.S. Treasury yield curve and its key numbers
%     History  the curve moving through time over a chosen period
%   Data: daily FRED history since 1962, saved in data/ and brought up to
%   date every time the dashboard opens (fred_yield_history.m).
%   Maturities shown: 1M ... 20Y. The 30Y is left out; the 15Y is not
%   published by the Treasury and is interpolated between 10Y and 20Y.
%   Section 2: PCA - principal components of the yield levels (level, slope,
%     curvature) over the period and frequency of the Control panel; engine
%     in pca_curva.m. Maturities fixed as in Mele p. 91 without the 30Y
%     (1Y ... 20Y, 15Y interpolated). Two views: Loadings and Factors.
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
tabCtl  = uitab(tabs, 'Title', 'Control panel', 'BackgroundColor', col.bg);
tabData = uitab(tabs, 'Title', 'Data Analysis', 'BackgroundColor', col.bg);
tabPCA  = uitab(tabs, 'Title', 'PCA', 'BackgroundColor', col.bg);

% --- Shared state ----------------------------------------------------------
% settings: the choices applied from the Control panel (maturities, PCA periods...)
% onApply:  what every section does when new settings are applied
% onMove:   mouse moves, sent to every chart (each reacts only when visible)
[~, ~, curveLabels] = prepareCurve(T, maturities, labels);
complete = all(~isnan(T{:, labels ~= "30Y"}), 2);
lastDay  = T.Time(find(complete, 1, 'last'));
fig.UserData.settings = defaultSettings(curveLabels, lastDay);
fig.UserData.onApply  = {};
fig.UserData.onMove   = {};
fig.WindowButtonMotionFcn = @(src, ~) cellfun(@(f) f(), src.UserData.onMove);

buildDataAnalysisTab(fig, tabData, col, T, maturities, labels);
buildPCATab(fig, tabPCA, col, T, maturities, labels);   % fixed maturities, as in Mele
buildControlPanel(fig, tabCtl, col, curveLabels, T.Time(1), lastDay);
tabs.SelectedTab = tabCtl;                                  % always open on the panel

end


function s = defaultSettings(labels, lastDay)
% The settings the dashboard opens with
s.maturities = labels;                                      % every maturity on
s.A = struct('from', datetime(2004, 1, 1), 'to', lastDay, 'freq', 'Monthly');   % PCA period
end


% ==========================================================================
function buildControlPanel(fig, tab, col, labels, firstDay, lastDay)
% Control panel: the choices that apply to every section, in two cards
% (maturities, PCA). Nothing changes until Apply is pressed; then Today,
% History and PCA are redrawn.

s = fig.UserData.settings;

page = uigridlayout(tab, [4 1]);
page.RowHeight       = {56, 400, 52, '1x'};
page.Padding         = [28 20 28 10];
page.RowSpacing      = 24;
page.BackgroundColor = col.bg;

buildHeader(page, col, 'Control panel', 'Choices applied to every section of the dashboard');

cardsRow = uigridlayout(page, [1 2]);
cardsRow.ColumnWidth     = {'3x', '2x'};
cardsRow.ColumnSpacing   = 24;
cardsRow.Padding         = [0 0 0 0];
cardsRow.BackgroundColor = col.bg;

% --- Card 1: maturities, in three groups along the curve -------------------
body = card(cardsRow, 'Maturities', 'Shown on the curves of Today and History');
body.RowHeight = {'1x', 34, 20};
groups = uigridlayout(body, [1 3]);
groups.ColumnSpacing   = 24;
groups.Padding         = [0 0 0 0];
groups.BackgroundColor = col.surface;
segment = {'SHORT END', ["1M" "3M" "6M" "1Y"];
           'BELLY',     ["2Y" "3Y" "5Y" "7Y"];
           'LONG END',  ["10Y" "15Y" "20Y"]};
box = gobjects(1, numel(labels));
for iSeg = 1:size(segment, 1)
    names  = segment{iSeg, 2};
    column = uigridlayout(groups, [5 1]);
    column.RowHeight       = {22, 30, 30, 30, 30};
    column.RowSpacing      = 6;
    column.Padding         = [0 0 0 0];
    column.BackgroundColor = col.surface;
    uilabel(column, 'Text', segment{iSeg, 1}, 'FontName', col.mono, 'FontSize', 11, ...
            'FontColor', col.dim);
    for name = names
        k = find(labels == name);
        caption = char(name);
        if name == "15Y", caption = '15Y  (interpolated)'; end
        box(k) = uicheckbox(column, 'Text', caption, 'Value', ismember(name, s.maturities), ...
                            'FontName', col.font, 'FontSize', 15, 'FontColor', col.text, ...
                            'ValueChangedFcn', @(~, ~) changed());
    end
end
box(labels == "15Y").Tooltip = 'Not published by the Treasury: interpolated between 10Y and 20Y';

presets = uigridlayout(body, [1 4]);
presets.ColumnWidth     = {110, 130, 90, '1x'};
presets.ColumnSpacing   = 10;
presets.Padding         = [0 0 0 0];
presets.BackgroundColor = col.surface;
presetButton(presets, 'Select all',   @() setBoxes(true(1, numel(labels))));
presetButton(presets, 'Without bills', @() setBoxes(~ismember(labels, ["1M" "3M" "6M"])));
presetButton(presets, 'Clear',        @() setBoxes(false(1, numel(labels))));
uilabel(body, 'Text', ['The 15Y is not published by the Treasury: it is interpolated ' ...
        'between 10Y and 20Y. The 30Y is not used.'], ...
        'FontName', col.font, 'FontSize', 12, 'FontColor', col.dim);

% --- Card 2: PCA period and frequency ---------------------------------------
body = card(cardsRow, 'PCA', 'Principal components of the yield levels (Mele, eq. 1)');
body.RowHeight = {'fit', '1x'};
form = uigridlayout(body, [3 2]);
form.ColumnWidth     = {100, '1x'};
form.RowHeight       = {34, 34, 34};
form.RowSpacing      = 14;
form.Padding         = [0 6 0 0];
form.BackgroundColor = col.surface;
formLabel('From');
dpFrom = uidatepicker(form, 'Value', s.A.from, 'Limits', [firstDay lastDay], ...
                      'DisplayFormat', 'dd MMM yyyy', 'FontSize', 14, ...
                      'BackgroundColor', col.bg, 'FontColor', col.text, 'FontName', col.font, ...
                      'ValueChangedFcn', @(~, ~) changed());
formLabel('To');
dpTo = uidatepicker(form, 'Value', s.A.to, 'Limits', [firstDay lastDay], ...
                    'DisplayFormat', 'dd MMM yyyy', 'FontSize', 14, ...
                    'BackgroundColor', col.bg, 'FontColor', col.text, 'FontName', col.font, ...
                    'ValueChangedFcn', @(~, ~) changed());
formLabel('Frequency');
ddFreq = uidropdown(form, 'Items', {'Daily', 'Weekly', 'Monthly'}, 'Value', s.A.freq, ...
                    'FontSize', 14, 'BackgroundColor', col.bg, 'FontColor', col.text, ...
                    'FontName', col.font, 'ValueChangedFcn', @(~, ~) changed());
uilabel(body, 'Text', ['Maturities fixed as in Mele p. 91, without the 30Y: 1Y 2Y 3Y 5Y ' ...
        '7Y 10Y 15Y 20Y (the 15Y interpolated). Used by both views, Loadings and Factors.'], ...
        'FontName', col.font, 'FontSize', 12, 'FontColor', col.dim, 'WordWrap', 'on', ...
        'VerticalAlignment', 'bottom');

% --- Apply, with one line on the state of the dashboard --------------------
foot = uigridlayout(page, [1 2]);
foot.ColumnWidth     = {'1x', 180};
foot.ColumnSpacing   = 18;
foot.Padding         = [0 0 0 0];
foot.BackgroundColor = col.bg;
lbState = uilabel(foot, 'Text', '', 'FontName', col.font, 'FontSize', 13, ...
                  'HorizontalAlignment', 'right');
btnApply = uibutton(foot, 'Text', 'Apply', 'FontName', col.font, 'FontSize', 15, ...
                    'FontWeight', 'bold', 'ButtonPushedFcn', @(~, ~) apply());
setPending(false);

    function inner = card(parent, title, subtitle)
        % A surface panel with a title and one line under it; returns the body
        p = uipanel(parent, 'BackgroundColor', col.surface, 'BorderType', 'line', ...
                    'BorderColor', col.line);
        grid = uigridlayout(p, [3 1]);
        grid.RowHeight       = {30, 20, '1x'};
        grid.RowSpacing      = 4;
        grid.Padding         = [28 24 28 22];
        grid.BackgroundColor = col.surface;
        uilabel(grid, 'Text', title, 'FontName', col.font, 'FontSize', 22, ...
                'FontWeight', 'bold', 'FontColor', col.text);
        uilabel(grid, 'Text', subtitle, 'FontName', col.font, 'FontSize', 13, 'FontColor', col.muted);
        inner = uigridlayout(grid, [3 1]);
        inner.Padding         = [0 0 0 22];          % [left bottom right top]: air under the subtitle
        inner.RowSpacing      = 14;
        inner.BackgroundColor = col.surface;
    end

    function presetButton(parent, txt, action)
        uibutton(parent, 'Text', txt, 'FontName', col.font, 'FontSize', 13, ...
                 'BackgroundColor', col.bg, 'FontColor', col.text2, ...
                 'ButtonPushedFcn', @(~, ~) action());
    end

    function formLabel(txt)
        uilabel(form, 'Text', txt, 'FontName', col.font, 'FontSize', 14, 'FontColor', col.muted);
    end

    function setBoxes(values)
        for j = 1:numel(box)
            box(j).Value = values(j);
        end
        changed();
    end

    function changed()
        setPending(true);
    end

    function setPending(on)
        % Apply lights up while there are choices not applied yet
        if on
            btnApply.BackgroundColor = col.accent;      btnApply.FontColor = col.text;
            lbState.FontColor = col.text2;
            lbState.Text = 'Changes not applied yet';
        else
            btnApply.BackgroundColor = col.accentSoft;  btnApply.FontColor = col.text2;
            lbState.FontColor = col.dim;
            lbState.Text = 'Every section is up to date';
        end
    end

    function apply()
        % Check the choices, store them, and redraw every section
        sel = labels([box.Value]);
        msg = '';
        if isempty(sel)
            msg = 'Choose at least one maturity.';
        elseif dpTo.Value <= dpFrom.Value
            msg = 'PCA: "To" must come after "From".';
        end
        if ~isempty(msg)
            lbState.FontColor = col.down;
            lbState.Text = msg;
            return
        end

        new.maturities = sel;
        new.A = struct('from', dpFrom.Value, 'to', dpTo.Value, 'freq', ddFreq.Value);
        fig.UserData.settings = new;

        lbState.FontColor = col.muted;
        lbState.Text = 'Applying...';
        drawnow;
        cellfun(@(f) f(), fig.UserData.onApply);
        setPending(false);
    end
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
% Today: header, four key numbers, Fed reference, chart of the maturities
% chosen in the Control panel.

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

% Maturities shown: set in the Control panel; here only the Fed reference
bar = uigridlayout(page, [1 3]);
bar.ColumnWidth     = {'1x', 74, 76};
bar.ColumnSpacing   = 6;
bar.Padding         = [0 0 0 0];
bar.BackgroundColor = col.bg;
smallLabel(bar, col, 'Maturities: set in the Control panel');
ref = addReference(bar, col, @() redraw());

ax = makeAxes(page, col);
sourceNote(page, col);

% Hover: value of the maturity nearest to the mouse
hov = [];  shownX = [];  shownY = [];  shownNames = strings(0);
fig.UserData.onMove{end+1}  = @onMove;
fig.UserData.onApply{end+1} = @redraw;      % new maturities from the Control panel

drawnow;          % let the layout settle before the first chart, or the axes come out clipped
redraw();

    function redraw()
        sel = ismember(labels, fig.UserData.settings.maturities);
        shownX = maturities(sel);  shownY = yields(sel);  shownNames = labels(sel);

        cla(ax);
        if ~any(sel)
            text(ax, 0.5, 0.5, 'Select at least one maturity in the Control panel', 'Units', 'normalized', ...
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
fig.UserData.onMove{end+1}  = @onMove;
fig.UserData.onApply{end+1} = @rebuild;     % new maturities from the Control panel
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
        sel      = ismember(labels, fig.UserData.settings.maturities);
        inPeriod = T.Time >= dpFrom.Value & T.Time <= dpTo.Value + days(1);
        enough   = sum(~isnan(T{:, sel}), 2) >= min(3, nnz(sel));   % skip empty holidays
        rows = find(inPeriod & enough);
        t = T.Time(rows);
        switch ddStep.Value
            case 'Monthly', key = year(t)*12 + month(t);
            case 'Weekly',  key = floor(days(t - datetime(1962, 1, 1)) / 7);
            otherwise,      key = (1:numel(t))';
        end
        [~, last] = unique(key, 'last');
        frames = rows(last);
        if isempty(frames)
            cla(ax);
            text(ax, 0.5, 0.5, 'No data for the chosen maturities in this period', ...
                 'Units', 'normalized', 'Color', col.muted, 'HorizontalAlignment', 'center', ...
                 'FontName', col.font, 'FontSize', 14);
            styleAxes(ax, col, [0 1], [0 1], [], {});
            lbDate.Text = '';  lbStart.Text = '';  lbEnd.Text = '';
            return
        end

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
        ok = ~isnan(y) & ismember(labels, fig.UserData.settings.maturities);
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
function buildPCATab(fig, tab, col, T, maturities, labels)
% PCA: principal components of the yield LEVELS (Mele, eq. 1) over the period
% and frequency chosen in the Control panel. Maturities are fixed, those of
% Mele p. 91 without the 30Y: 1Y ... 20Y, the 15Y interpolated between 10Y
% and 20Y. Two sub-tabs, like Data Analysis: Loadings (the three shapes
% against maturity, in years) and Factors (the value of each factor over
% time). Computed again whenever settings are applied.

pc  = pcaColours(col);
dot = ['  ' char(183) '  '];
[T, maturities, labels] = prepareCurve(T, maturities, labels);   % no 30Y, 15Y added
pcaSet = ["1Y" "2Y" "3Y" "5Y" "7Y" "10Y" "15Y" "20Y"];            % as in Mele, without the 30Y
note = ['Source: Federal Reserve H.15 via FRED. PCA on the yield levels of 1Y-20Y, as in Mele ' ...
        'p. 91 without the 30Y; the 15Y is not published and is interpolated between 10Y and ' ...
        '20Y, so it adds no information of its own. Each period represented by its last day ' ...
        'with every maturity. Loadings have unit length; ' ...
        'their sign is a convention, as in Mele p. 91 (PC1 positive, PC2 positive at the ' ...
        'short end, PC3 positive at both ends). Factor values F = (R - mean R) w, in percentage points.'];

% --- Two sub-tabs filling the section ---------------------------------------
outer = uigridlayout(tab, [1 1]);
outer.BackgroundColor = col.bg;
outer.Padding = [0 0 0 0];
views   = uitabgroup(outer);
tabLoad = uitab(views, 'Title', 'Loadings', 'BackgroundColor', col.bg);
tabFac  = uitab(views, 'Title', 'Factors',  'BackgroundColor', col.bg);

% --- Loadings: header, status, four cards, one chart across the page -------
loadPage = uigridlayout(tabLoad, [5 1]);
loadPage.RowHeight       = {56, 20, 92, '1x', 28};
loadPage.Padding         = [28 20 28 10];
loadPage.RowSpacing      = 14;
loadPage.BackgroundColor = col.bg;
buildHeader(loadPage, col, 'Yield Curve US  |  PCA loadings', ['How each maturity responds ' ...
            'to the level, slope and curvature factors' dot 'settings from the Control panel']);
lbStatus(1) = statusLine(loadPage);

cardNames = {'PC1  LEVEL', 'PC2  SLOPE', 'PC3  CURVATURE', 'FIRST THREE'};
cards = uigridlayout(loadPage, [1 4]);
cards.ColumnSpacing   = 14;
cards.Padding         = [0 0 0 0];
cards.BackgroundColor = col.bg;
cardValue = gobjects(1, 4);  cardNote = gobjects(1, 4);
for iCard = 1:4
    p = uipanel(cards, 'BackgroundColor', col.surface, 'BorderType', 'line', ...
                'BorderColor', col.line);
    q = uigridlayout(p, [3 1]);
    q.RowHeight       = {16, 34, 18};
    q.RowSpacing      = 2;
    q.Padding         = [16 10 16 8];
    q.BackgroundColor = col.surface;
    uilabel(q, 'Text', cardNames{iCard}, 'FontName', col.mono, 'FontSize', 10, 'FontColor', col.dim);
    cardValue(iCard) = uilabel(q, 'Text', '', 'FontName', col.font, 'FontSize', 28, ...
                               'FontWeight', 'bold', 'FontColor', col.text);
    cardNote(iCard)  = uilabel(q, 'Text', '', 'FontName', col.font, 'FontSize', 12, ...
                               'FontColor', col.muted);
end
charts = uigridlayout(loadPage, [1 1]);
charts.Padding         = [0 0 0 0];
charts.BackgroundColor = col.bg;
noteLine(loadPage);

% --- Factors: header, status, three charts stacked, using all the height ----
facOuter = uigridlayout(tabFac, [4 1]);
facOuter.RowHeight       = {56, 20, '1x', 28};
facOuter.Padding         = [28 20 28 10];
facOuter.RowSpacing      = 14;
facOuter.BackgroundColor = col.bg;
buildHeader(facOuter, col, 'Yield Curve US  |  PCA factors', ['Value of the level, slope and ' ...
            'curvature factors over time' dot 'settings from the Control panel']);
lbStatus(2) = statusLine(facOuter);
facPage = uigridlayout(facOuter, [1 1]);
facPage.Padding         = [0 0 0 0];
facPage.BackgroundColor = col.bg;
noteLine(facOuter);

% --- Behaviour ------------------------------------------------------------
hovers = {};
fig.UserData.onMove{end+1}  = @onMove;
fig.UserData.onApply{end+1} = @run;          % new settings from the Control panel
drawnow;
run();

    function run()
        s    = fig.UserData.settings;
        keep = ismember(labels, pcaSet);

        shown = views.SelectedTab;                    % stay on the view being looked at
        restoreView = onCleanup(@() showView(shown));
        delete(charts.Children);
        delete(facPage.Children);
        hovers = {};
        set(cardValue, 'Text', char(8211));  set(cardNote, 'Text', '');

        % Data: yield levels of the chosen maturities, one row per period
        [X, info, dates] = pcaSample(T, keep, s.A.from, s.A.to, s.A.freq, true);
        set(lbStatus, 'Text', sprintf('<b>%s</b>%s%s %s %s%s%s levels%s%d observations', ...
                                strjoin(labels(keep), ' '), dot, char(s.A.from, 'dd MMM yyyy'), ...
                                char(8211), char(s.A.to, 'dd MMM yyyy'), dot, lower(s.A.freq), ...
                                dot, info.n));
        if info.n < nnz(keep) + 1
            msg = sprintf(['Only %d observations for %d maturities: widen the period ' ...
                           'or choose a higher frequency in the Control panel.'], info.n, nnz(keep));
        else
            msg = '';
        end
        if ~isempty(msg)
            showError(charts, msg);
            showError(facPage, msg);
            return
        end

        [W, lambda, share, F] = pca_curva(X);
        fillCards(lambda, share, info.n);
        drawLoadings(chartCell(charts, loadingsTitle()), maturities(keep), labels(keep), W);
        drawFactors(F / 100, share, dates);           % bp -> percentage points
    end

    function fillCards(lambda, share, n)
        % Share of each component, its size in bp, and the total of the first three
        for k = 1:3
            cardValue(k).Text = sprintf('%.1f%%', 100*share(k));
            cardNote(k).Text  = sprintf('sd %.0f bp', sqrt(lambda(k)));
        end
        cardValue(4).Text = sprintf('%.1f%%', 100*sum(share(1:3)));
        cardNote(4).Text  = sprintf('%d observations', n);
    end

    function showView(t)
        % Redrawing a view can leave the window showing the first sub-tab while
        % the other one is selected: select the other one, then the right one
        if ~isvalid(views), return, end
        other = tabLoad;
        if t == tabLoad, other = tabFac; end
        views.SelectedTab = other;  drawnow;
        views.SelectedTab = t;      drawnow;
    end

    function showError(parent, msg)
        uilabel(parent, 'Text', msg, 'FontName', col.font, 'FontSize', 15, ...
                'FontColor', col.down, 'HorizontalAlignment', 'center', 'WordWrap', 'on');
    end

    function lb = statusLine(parent)
        lb = uilabel(parent, 'Text', '', 'Interpreter', 'html', 'FontName', col.font, ...
                     'FontSize', 12, 'FontColor', col.muted);
    end

    function noteLine(parent)
        uilabel(parent, 'Text', note, 'FontName', col.font, 'FontSize', 10, ...
                'FontColor', col.dim, 'WordWrap', 'on');
    end

    function ax = chartCell(parent, titleHtml)
        % Title line (with its own colour key) above a chart
        g = uigridlayout(parent, [2 1]);
        g.RowHeight       = {22, '1x'};
        g.RowSpacing      = 4;
        g.Padding         = [0 0 0 0];
        g.BackgroundColor = col.bg;
        uilabel(g, 'Text', titleHtml, 'Interpreter', 'html', 'FontName', col.font, ...
                'FontSize', 12, 'FontColor', col.text2);
        ax = makeAxes(g, col);
    end

    function s = loadingsTitle()
        % "Factor loadings" + key of the three colours
        s = sprintf(['<b>Factor loadings</b>&nbsp;&nbsp;&nbsp; <b style="color:%s">&#9644;</b> level' ...
                     '&nbsp; <b style="color:%s">&#9644;</b> slope&nbsp; ' ...
                     '<b style="color:%s">&#9644;</b> curvature'], ...
                    cssColour(pc.lev), cssColour(pc.slo), cssColour(pc.cur));
    end

    function drawLoadings(ax, x, names, W)
        % The first three loadings against maturity in years, one colour per
        % component; fixed axis 0-20 years, a tick every 5, as in Mele p. 91
        hold(ax, 'on');
        yline(ax, 0, '-', 'Color', blend(col.bg, col.text, 0.25), 'LineWidth', 0.75);
        colours = {pc.lev, pc.slo, pc.cur};
        for k = 1:3
            plot(ax, x, W(:, k), '-', 'Color', colours{k}, 'LineWidth', 2, ...
                 'Marker', 'o', 'MarkerSize', 6, 'MarkerFaceColor', colours{k});
        end
        h.ax    = ax;  h.x = x;  h.names = names;  h.W = W;
        h.guide = plot(ax, NaN, NaN, '-', 'Color', blend(col.bg, col.text, 0.25), 'LineWidth', 1);
        h.box   = text(ax, NaN, NaN, '', 'Color', col.text, 'BackgroundColor', col.surface, ...
                       'EdgeColor', col.line, 'Margin', 7, 'FontName', col.mono, 'FontSize', 11, ...
                       'VerticalAlignment', 'top', 'Interpreter', 'none', 'Visible', 'off');
        hold(ax, 'off');

        lim = max(abs(W(:, 1:3)), [], 'all');
        yl  = [-1 1] * min(1, ceil((lim + 0.05)*10)/10);
        tk  = 0:5:20;
        styleAxes(ax, col, [0 20.5], yl, tk, arrayfun(@(v) sprintf('%d', v), tk, 'UniformOutput', false));
        xlabel(ax, 'Maturity (years)', 'Color', col.muted, 'FontName', col.font, 'FontSize', 12);
        yticks(ax, yl(1):0.1:yl(2));
        ytickformat(ax, '%.1f');
        hovers{end+1} = h;
    end

    function drawFactors(F, share, dates)
        % Factors over time: the value of each of the first three factors on
        % every date, F = (R - mean R) * w, in percentage points
        g = uigridlayout(facPage, [3 1]);
        g.RowSpacing      = 10;
        g.Padding         = [0 0 0 0];
        g.BackgroundColor = col.bg;
        names   = {'level', 'slope', 'curvature'};
        colours = {pc.lev, pc.slo, pc.cur};
        [tk, tl] = yearTicks(dates(1), dates(end));
        for k = 1:3
            ax = chartCell(g, sprintf(['<b style="color:%s">PC%d</b>&nbsp; <b>%s</b>' ...
                           '&nbsp;&nbsp; %.1f%% of the variance'], ...
                           cssColour(colours{k}), k, names{k}, 100*share(k)));
            plot(ax, dates, F(:, k), '-', 'Color', colours{k}, 'LineWidth', 1.4);  % sets a date axis
            hold(ax, 'on');
            yline(ax, 0, '-', 'Color', blend(col.bg, col.text, 0.25), 'LineWidth', 0.75);
            h.ax    = ax;  h.dates = dates;  h.y = F(:, k);
            h.guide = plot(ax, dates([1 1]), [NaN NaN], '-', 'Color', blend(col.bg, col.text, 0.25), ...
                           'LineWidth', 1);
            h.dot   = plot(ax, dates(1), NaN, 'o', 'MarkerSize', 6, 'MarkerFaceColor', colours{k}, ...
                           'MarkerEdgeColor', col.bg);
            h.box   = text(ax, dates(1), NaN, '', 'Color', col.text, 'BackgroundColor', col.surface, ...
                           'EdgeColor', col.line, 'Margin', 5, 'FontName', col.font, 'FontSize', 11, ...
                           'VerticalAlignment', 'top', 'Visible', 'off');
            hold(ax, 'off');
            lo = min(F(:, k));  hi = max(F(:, k));  pad = 0.04*max(hi - lo, 0.1);
            styleAxes(ax, col, [dates(1) dates(end)], [lo - pad, hi + pad], tk, tl);
            [yt, fmt] = fineTicks(lo - pad, hi + pad);    % dense grid: read the values
            yticks(ax, yt);
            ytickformat(ax, fmt);            hovers{end+1} = h;
        end
    end

    function onMove()
        % Hover: loadings at the nearest maturity, or factor value at the nearest date
        if tab.Parent.SelectedTab ~= tab, return, end
        for i = 1:numel(hovers)
            h = hovers{i};
            if ~isvalid(h.ax), continue, end
            if isfield(h, 'dates')
                seriesHover(h);
            else
                loadingsHover(h);
            end
        end
    end

    function loadingsHover(h)
        cp = h.ax.CurrentPoint;
        xl = xlim(h.ax);  yl = ylim(h.ax);
        if cp(1,1) < xl(1) || cp(1,1) > xl(2) || cp(1,2) < yl(1) || cp(1,2) > yl(2)
            set(h.guide, 'XData', NaN, 'YData', NaN);
            h.box.Visible = 'off';
            return
        end
        [~, j] = min(abs(h.x - cp(1,1)));
        set(h.guide, 'XData', [h.x(j) h.x(j)], 'YData', yl);
        rows = {sprintf('%-4s  level  slope   curv.', char(h.names(j))), ...
                sprintf('     %+6.2f %+6.2f %+6.2f', h.W(j, 1:3))};
        align = 'left';
        if (h.x(j) - xl(1)) / diff(xl) > 0.6, align = 'right'; end
        set(h.box, 'Position', [h.x(j), yl(2) - 0.03*diff(yl), 0], ...
            'HorizontalAlignment', align, 'String', rows, 'Visible', 'on');
    end

    function seriesHover(h)
        cp = h.ax.CurrentPoint;
        x  = num2ruler(cp(1,1), h.ax.XAxis);
        xl = xlim(h.ax);  yl = ylim(h.ax);
        if x < xl(1) || x > xl(2) || cp(1,2) < yl(1) || cp(1,2) > yl(2)
            set(h.guide, 'YData', [NaN NaN]);  set(h.dot, 'YData', NaN);
            h.box.Visible = 'off';
            return
        end
        [~, j] = min(abs(h.dates - x));
        set(h.guide, 'XData', h.dates([j j]), 'YData', yl);
        set(h.dot,   'XData', h.dates(j),     'YData', h.y(j));
        align = 'left';
        if (h.dates(j) - xl(1)) / (xl(2) - xl(1)) > 0.75, align = 'right'; end
        set(h.box, 'Position', [ruler2num(h.dates(j), h.ax.XAxis), yl(2) - 0.04*diff(yl), 0], ...
            'HorizontalAlignment', align, 'Visible', 'on', ...
            'String', sprintf(' %s   %+.2f ', char(h.dates(j), 'dd MMM yyyy'), h.y(j)));
    end
end

function [yt, fmt] = fineTicks(lo, hi)
% About ten round ticks between lo and hi, and the number format that suits them
steps = [0.1 0.2 0.25 0.5 1 2 2.5 5 10];
step  = steps(find((hi - lo) ./ steps <= 12, 1));
if isempty(step), step = 20; end
yt = (ceil(lo/step)*step):step:hi;
if step < 1, fmt = '%.1f%%'; else, fmt = '%.0f%%'; end
if step == 0.25, fmt = '%.2f%%'; end
end

function [tk, tl] = yearTicks(t0, t1)
% Ticks on 1 January, every 1, 2, 5 or 10 years so that there are at most ten
span = year(t1) - year(t0) + 1;
step = [1 2 5 10];
step = step(find(span ./ step <= 10, 1));
if isempty(step), step = 20; end
yrs = (ceil(year(t0)/step)*step):step:year(t1);
tk  = datetime(yrs, 1, 1);
tk  = tk(tk >= t0 & tk <= t1);
tl  = cellstr(string(year(tk)));
end

function pc = pcaColours(col)
% Colours of the PCA section: one per component
pc.lev = col.accent;          % level: the blue of the curve
pc.slo = col.trailNew;        % slope: teal
pc.cur = col.trailOld;        % curvature: soft violet
end

function [X, info, dates] = pcaSample(T, keep, from, to, freq, levels)
% Data for the PCA: the chosen maturities between from and to, one row per
% period (its last day with every maturity), in bp. With levels = false, the
% changes between consecutive periods only (a gap in the data is skipped).
% dates: the date of each row of X (for a change, the day it ends).
in = T.Time >= from & T.Time <= to;
V  = T{in, keep};
t  = T.Time(in);
ok = all(~isnan(V), 2);
V  = V(ok, :);  t = t(ok);
info = struct('n', 0, 'first', NaT, 'last', NaT);
dates = t([]);
if isempty(t)
    X = zeros(0, nnz(keep));
    return
end

origin = datetime(1962, 1, 1);               % a Monday: weeks run Monday-Sunday
switch freq
    case 'Daily',  key = days(t - origin);   maxStep = 5;   % weekend + a holiday
    case 'Weekly', key = floor(days(t - origin) / 7);  maxStep = 1;
    otherwise,     key = year(t)*12 + month(t);        maxStep = 1;
end
[key, last] = unique(key, 'last');
V = V(last, :);  t = t(last);

if levels
    X = 100 * V;
    dates = t;
    info.first = t(1);
else
    X    = 100 * diff(V);
    good = diff(key) <= maxStep;
    X    = X(good, :);
    ends = t(2:end);
    dates = ends(good);
    if numel(t) > 1
        info.first = t(1);
    end
end
info.last = t(end);
info.n    = size(X, 1);
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
