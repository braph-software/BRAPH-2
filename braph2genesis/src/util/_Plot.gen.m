%% ¡header!
Plot < Element (pl, plot) is a plot.

%%% ¡description!
Base element to manage graphic plots. It permits to manage the handle of 
a uipanel using the methods pl.setPanel(h) and h = getPanel(pl).

%%% ¡seealso!
uipanel, ishandle

%% ¡properties!
h % panel graphical handle

%% ¡props!

%%% ¡prop!
Plot (result, empty) is an empty property to plot.
%%%% ¡conditioning!
if isgraphics(value, 'uipanel')
    pl.h = h;
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
Basics
%%%% ¡code!
pl = Plot();
pl.get('PLOT');
