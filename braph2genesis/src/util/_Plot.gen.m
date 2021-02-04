%% ¡header!
Plot < Element (pl, plot) is a plot.

%%% ¡description!
...

%%% ¡seealso!
uipanel, ishandle

%% ¡properties!
h % panel graphical handle

%% ¡methods!
function setPanel(pl, h)
    %SETPANEL sets graphic panel.
    %
    % SETPANEL(PL, H) sets the graphic panel to H. 
    %  If H is not a uipanel, it throws an error.
    %  Error id: [BRAPH2:<element class>:WrongInput]
    %
    % See also getPanel, uipanel.

    if nargin < 2 || ~isgraphics(h, 'uipanel')
        h = uipanel('Units', 'normalized', 'Position', [0 0 1 1]);
    end

    pl.h = h;
end
function h = getPanel(pl)
    %GETPANEL gets graphic panel.
    %
    % H = GETPANEL(PL) returns a handle to the graphic panel used to plot.
    %  If the panel has not been inizialized it returns an empty vector.
    %  If the panel has been cancelled, it returns a handle to a deleted
    %  panel.
    %
    % See also setPanel, uipanel.

    h = pl.h;
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Close figure
%%%% ¡code!
close(gcf)

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
fig = figure();

pl1 = Plot();
pl1.setPanel();
h1 = pl1.getPanel();

pl2 = Plot();
pl2.setPanel(uipanel('Units', 'normalized', 'Position', [.25 .25 .50 .50]));
h2 = pl2.getPanel();

close(fig)