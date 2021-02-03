%% ¡header!
Plot < Element (pl, plot) is a plot.

%%% ¡description!
Base element to the uipanel that contains all graphical elements. 
Basic commands:
pl = Plot(''PLOT'', h) to create a plot for uipanel h.
pl.set(''PLOT'', h) to change the uipanel. 
pl.get(''PLOT'') to visualize the uipanel.

%%% ¡seealso!
uipanel, ishandle

%% ¡properties!
h % panel graphical handle

%% ¡props!

%%% ¡prop!
PLOT (result, empty) is an empty property to plot.
%%%% ¡conditioning!
if isgraphics(value, 'uipanel')
    pl.h = value;
end

value = NoValue.getNoValue();
%%%% ¡calculate!
if isempty(pl.h) || ~isgraphics(pl.h, 'uipanel')
    pl.h = uipanel();
end

value = [];

%% ¡methods!
% function setPanel(pl, h)
%     %SETPANEL sets graphic panel.
%     %
%     % SETPANEL(PL, H) sets the graphic panel to H. 
%     %  If H is not a uipanel, it throws an error.
%     %  Error id: [BRAPH2:<element class>:WrongInput]
%     %
%     % See also getPanel, uipanel.
% 
%     assert(isgraphics(h, 'uipanel'), ...
%         [BRAPH2.STR ':' pl.getClass() ':' BRAPH2.WRONG_INPUT], ...
%         [BRAPH2.STR ':' pl.getClass() ':' BRAPH2.WRONG_INPUT ' ' ...
%         'The value of the handle must be a handle of an active uipanel.'])
% 
%     pl.h = h;
% end
% function h = getPanel(pl)
%     %GETPANEL gets graphic panel.
%     %
%     % H = GETPANEL(PL) returns a handle to the graphic panel used to plot.
%     %  If the panel has not been inizialized it returns an empty vector.
%     %  If the panel has been cancelled, it returns a handle to a deleted
%     %  panel.
%     %
%     % See also setPanel, uipanel.
% 
%     h = pl.h;
% end

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
pl1.get('PLOT');

pl2 = Plot('PLOT', uipanel('Units', 'normalized', 'Position', [.25 .25 .50 .50]));

close(fig)