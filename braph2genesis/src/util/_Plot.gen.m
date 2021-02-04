%% ¡header!
Plot < Element (pl, plot) is a plot.

%%% ¡description!
...

%%% ¡seealso!
uipanel, ishandle

%% ¡properties!
h_panel % panel graphical handle

%% ¡methods!
function h_panel = draw(pl, varargin)

    if isempty(pl.h_panel) || ~isgraphics(pl.h_panel, 'uipanel')
        pl.h_panel = uipanel(varargin{:});
    end
    
    if nargout > 0
        h_panel = pl.h_panel;
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
fig = figure();

pl1 = Plot();
pl1.draw()

pl2 = Plot();
h2 = pl2.draw('Units', 'normalized', 'Position', [.25 .25 .50 .50]);

close(fig)