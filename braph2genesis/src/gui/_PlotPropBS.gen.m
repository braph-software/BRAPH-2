%% ¡header!
PlotPropBS < PlotProp (pl, plot property of brain atlas surface) is a plot of brain atlas surface.

%%% ¡description!
PlotPropBS plots for Brain Atlas surface.

%%% ¡seealso!
GUI, PlotElement, PlotProp, BrainAtlas

%% ¡properties!
pp
plot_brain_atlas


%% ¡methods!
function h_panel = draw(pl, varargin)
%DRAW draws the idict for brain atlas property graphical panel.
%
% DRAW(PL) draws the idict property graphical panel.
%
% H = DRAW(PL) returns a handle to the idict property graphical panel.
%
% DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
%  panel with custom property-value couples.
%  All standard plot properties of uipanel can be used.
%
% It is possible to access the properties of the various graphical
%  objects from the handle to the brain surface graphical panel H.
%
% see also update, redraw, refresh, settings, uipanel, isgraphics.

el = pl.get('EL');
pl.pp = draw@PlotProp(pl, varargin{:});
plba = [];

if isempty(pl.plot_brain_atlas) || ~isgraphics(pl.plot_brain_atlas, 'edit')
    if isempty(el.get('surf').get('id'))
        surf = ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF');
    end
    plba =  PlotBrainAtlas('ATLAS', el, 'Surf', surf);
    
    pl.plot_brain_atlas = uicontrol(...
        'Style', 'pushbutton', ...
        'Parent', pl.pp, ...
        'Units', 'normalized', ...
        'String', 'Plot Brain Atlas', ...
        'Position', [.01 .10 .98 .45], ...
        'Callback', {@cb_pushbutton_brain_atlas} ...
        );
end

    function cb_pushbutton_brain_atlas(~, ~)
        second_figure =  figure( ...
            'Visible', 'on', ...
            'NumberTitle', 'off', ...
            'Name', ['Brain Atlas - ' BRAPH2.STR], ...
            'Units', 'normalized', ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'Color', [.98 .95 .95] ...
            );
        
        plba.draw('Parent', second_figure);
        plba.settings();
    end

% output
if nargout > 0
    h_panel = pl.pp;
end
end
function update(pl)
%UPDATE updates the content of the property graphical panel.
%
% UPDATE(PL) updates the content of the property graphical panel.
%
% See also draw, redraw, refresh.

update@PlotProp(pl)
    
end
function redraw(pl, varargin)
%REDRAW redraws the element graphical panel.
%
% REDRAW(PL) redraws the plot PL.
%
% REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=3.3).
%
% See also draw, update, refresh.

pl.redraw@PlotProp('Height', 20, varargin{:});
end