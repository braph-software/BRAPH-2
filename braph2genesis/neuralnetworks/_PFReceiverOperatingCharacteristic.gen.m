%% ¡header!
PFReceiverOperatingCharacteristic < PanelFig (pf, panel figure receiver operating characteristic) is a plot of receiver operating charateristic.

%%% ¡description!
% % % PFReceiverOperatingCharacteristic manages the plot of the nne choosen by the user. 

%%% ¡seealso!
PanelFig, NNEvaluator

%% ¡properties!
p  % handle for panel
h_axes % handle for the axes

toolbar
tool_axis
tool_grid

h_line % data line
h_xlabel
h_ylabel

%% ¡props!

%%% ¡prop!
NNE (metadata, item) is the NN evaluator.
%%%% ¡settings!
'NNEvaluator'

%%% ¡prop!
ST_AXIS (figure, item) determines the axis settings.
%%%% ¡settings!
'SettingsAxis'
%%%% ¡default!
SettingsAxis('GRID', false, 'EQUAL', false)
%%%% ¡postprocessing!
if (isempty(varargin) || nne.prop_set('ST_AXIS', varargin)) && check_graphics(pf.h_axes, 'axes')
    % update state of toggle tool
    set(nne.tool_grid, 'State', nne.get('ST_AXIS').get('GRID'))

    % update state of toggle tool
    set(nne.tool_axis, 'State', nne.get('ST_AXIS').get('AXIS'))
end
%%%% ¡gui!
pr = SettingsAxisPP('EL', nne, 'PROP', PFReceiverOperatingCharacteristic.ST_AXIS, varargin{:});

%%% ¡prop!
ST_LINE (figure, item) determines the line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡postprocessing!
if check_graphics(nne.h_line, 'line')
    nne.get('ST_LINE').set( ...
        'X', 'X', ...
        'Y', 'Y', ...
        'VISIBLE', true ...
        )
end
%%%% ¡gui!
pr = SettingsPPTable('EL', nne, 'PROP', PFMeasureGU.ST_LINE, ...
    'COLS', [SettingsLine.VISIBLE, SettingsLine.LINESTYLE, SettingsLine.LINEWIDTH, SettingsLine.LINECOLOR, SettingsLine.SYMBOL, SettingsLine.SYMBOLSIZE, SettingsLine.EDGECOLOR, SettingsLine.FACECOLOR], ...
    varargin{:});

%%% ¡prop!
ST_XLABEL (figure, item) determines the xlabel settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if check_graphics(nne.h_ylabel, 'text')
    st = nne.get('ST_XLABEL');
    if isa(st.getr('TXT'), 'NoValue')
        st.set( ...
            'TXT', nne.get('M').get('G').get('ID'), ...
            'FONTSIZE', s(2), ...
            'HORIZONTALALIGNMENT', 'center', ...
            'X', mean(get(nne.h_axes, 'XLim')), ...
            'VERTICALALIGNMENT', 'middle', ...
            'Y', (1 + s(5)/h(nne.h_axes, 'pixels')) * min(get(nne.h_axes, 'YLim')) - s(5)/h(nne.h_axes, 'pixels') * max(get(nne.h_axes, 'YLim')), ...
            'Z', .5, ...
            'VISIBLE', true ...
            )
    end
end
%%%% ¡gui!
pr = SettingsPPTable('EL', nne, 'PROP', PFMeasureGU.ST_XLABEL, ...
    'COLS', [SettingsText.VISIBLE, SettingsText.TXT, SettingsText.X, SettingsText.Y, SettingsText.ROTATION, SettingsText.HORIZONTALALIGNMENT, SettingsText.VERTICALALIGNMENT, SettingsText.FONTSIZE, SettingsText.FONTNAME, SettingsText.FONTCOLOR, SettingsText.INTERPRETER], ...
    varargin{:});

%%% ¡prop!
ST_YLABEL (figure, item) determines the ylabel settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if check_graphics(nne.h_ylabel, 'text')
    st = nne.get('ST_YLABEL');
    if isa(st.getr('TXT'), 'NoValue')
        st.set( ...
            'TXT', nne.get('M').get('ID'), ...
            'FONTSIZE', s(2), ...
            'ROTATION', 90, ...
            'HORIZONTALALIGNMENT', 'center', ...
            'X', (1 + s(5)/w(nne.h_axes, 'pixels')) * min(get(nne.h_axes, 'XLim')) - s(5)/w(nne.h_axes, 'pixels') * max(get(nne.h_axes, 'XLim')), ...
            'VERTICALALIGNMENT', 'middle', ...
            'Y', mean(get(nne.h_axes, 'YLim')), ...
            'Z', .5, ...
            'VISIBLE', true ...
            )
    end
end
%%%% ¡gui!
pr = SettingsPPTable('EL', nne, 'PROP', PFMeasureGU.ST_YLABEL, ...
    'COLS', [SettingsText.VISIBLE, SettingsText.TXT, SettingsText.X, SettingsText.Y, SettingsText.ROTATION, SettingsText.HORIZONTALALIGNMENT, SettingsText.VERTICALALIGNMENT, SettingsText.FONTSIZE, SettingsText.FONTNAME, SettingsText.FONTCOLOR, SettingsText.INTERPRETER], ...
    varargin{:});

%% ¡methods!
function p_out = draw(nne, varargin)
    %DRAW draws the measure graphical panel.
    %
    % DRAW(NNE) draws the measure graphical panel.
    %
    % P = DRAW(NNE) returns a handle to the measure graphical panel.
    %
    % DRAW(NNE, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain atlas graphical panel P.
    %
    % see also settings, uipanel.

    nne.p = draw@PanelFig(nne, varargin{:});

    % axes
    if ~check_graphics(nne.h_axes, 'axes')
        nne.h_axes = uiaxes( ...
            'Parent', nne.p, ...
            'Tag', 'h_axes', ...
            'Units', 'normalized', ...
            'OuterPosition', [0 0 1 1] ...
            );
        nne.h_axes.Toolbar.Visible = 'off';
        nne.h_axes.Interactions = [];
    end
        
    nne.memorize('ST_AXIS').h(nne.h_axes).set('PANEL', nne, 'UITAG', 'h_axes')
    listener(nne.get('ST_AXIS'), 'PropSet', @cb_st_axis);
    function cb_st_axis(~, ~) % (src, event)
        set(nne.tool_axis, 'State', nne.get('ST_AXIS').get('AXIS'))
        set(nne.tool_grid, 'State', nne.get('ST_AXIS').get('GRID'))
    end

    % Toolbar
    if ~check_graphics(nne.toolbar, 'uitoolbar')
        nne.toolbar = findobj(ancestor(nne.p, 'Figure'), 'Tag', 'ToolBar');
    end
    
    if check_graphics(nne.toolbar, 'uitoolbar') && ~check_graphics(nne.tool_axis, 'uitoggletool') % implies that also the other tools are not defined
        
        uipushtool(nne.toolbar, 'Separator', 'on', 'Visible', 'off')

        % Axis
        nne.tool_axis = uitoggletool(nne.toolbar, ...
            'Tag', 'tool_axis', ...
            'State', nne.get('ST_AXIS').get('AXIS'), ...
            'Tooltip', 'Show axis', ...
            'CData', imread('icon_axis.png'), ...
            'OnCallback', {@cb_axis, true}, ...
            'OffCallback', {@cb_axis, false});
        
        % Grid
        nne.tool_grid = uitoggletool(nne.toolbar, ...
            'Tag', 'tool_grid', ...
            'State', nne.get('ST_AXIS').get('GRID'), ...
            'Tooltip', 'Show grid', ...
            'CData', imread('icon_grid.png'), ...
            'OnCallback', {@cb_grid, true}, ...
            'OffCallback', {@cb_grid, false});
    end
    function cb_axis(~, ~, axis) % (src, event)
        nne.get('ST_AXIS').set('AXIS', axis);
    end
    function cb_grid(~, ~, grid) % (src, event)
        nne.get('ST_AXIS').set('GRID', grid);
    end

    % line stuff
    
    % output
    if nargout > 0
        p_out = nne.p;
    end
end
function str = tostring(nne, varargin)
    %TOSTRING string with information about the measure.
    %
    % STR = TOSTRING(PF) returns a string with information about the measure.
    %
    % STR = TOSTRING(PF, N) trims the string to the first N characters.
    %
    % STR = TOSTRING(PF, N, ENDING) ends the string with ENDING if it has
    %  been trimmed.
    %
    % See also disp, tree.

    str = ['Plot ' nne.get('NNE').get('ID')];
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end