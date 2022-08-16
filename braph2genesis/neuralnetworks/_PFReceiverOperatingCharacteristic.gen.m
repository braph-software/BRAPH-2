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
ROC_TMP (metadata, cell) 
%%%% ¡settings!
{}

%%% ¡prop!
ST_AXIS (figure, item) determines the axis settings.
%%%% ¡settings!
'SettingsAxis'
%%%% ¡default!
SettingsAxis('GRID', false, 'EQUAL', false)
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('ST_AXIS', varargin)) && check_graphics(pf.h_axes, 'axes')
    % update state of toggle tool
    set(pf.tool_grid, 'State', pf.get('ST_AXIS').get('GRID'))

    % update state of toggle tool
    set(pf.tool_axis, 'State', pf.get('ST_AXIS').get('AXIS'))
end
%%%% ¡gui!
pr = SettingsAxisPP('EL', pf, 'PROP', PFReceiverOperatingCharacteristic.ST_AXIS, varargin{:});

%%% ¡prop!
ST_LINE (figure, item) determines the line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡postprocessing!
if check_graphics(pf.h_line, 'line')
    tt =  pf.get('ROC_TMP');
    pf.get('ST_LINE').set( ...
        'X', tt{1}, ...
        'Y', tt{2}, ...
        'VISIBLE', true ...
        )
    pf.get('ST_AXIS').set('AXIS', true)
    set(pf.h_axes, 'InnerPosition', [s(6)/w(pf.h_axes, 'pixels') s(6)/h(pf.h_axes, 'pixels') max(.1, 1-s(8)/w(pf.h_axes, 'pixels')) max(.1, 1-s(8)/h(pf.h_axes, 'pixels'))])
end
%%%% ¡gui!
pr = SettingsPPTable('EL', pf, 'PROP', PFReceiverOperatingCharacteristic.ST_LINE, ...
    'COLS', [SettingsLine.VISIBLE, SettingsLine.LINESTYLE, SettingsLine.LINEWIDTH, SettingsLine.LINECOLOR, SettingsLine.SYMBOL, SettingsLine.SYMBOLSIZE, SettingsLine.EDGECOLOR, SettingsLine.FACECOLOR], ...
    varargin{:});

%%% ¡prop!
ST_XLABEL (figure, item) determines the xlabel settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if check_graphics(pf.h_xlabel, 'text')
    st = pf.get('ST_XLABEL');
    if isa(st.getr('TXT'), 'NoValue')
        st.set( ...
            'TXT', 'False positive ate', ...
            'FONTSIZE', s(2), ...
            'HORIZONTALALIGNMENT', 'center', ...
            'X', mean(get(pf.h_axes, 'XLim')), ...
            'VERTICALALIGNMENT', 'middle', ...
            'Y', (1 + s(5)/h(pf.h_axes, 'pixels')) * min(get(pf.h_axes, 'YLim')) - s(5)/h(pf.h_axes, 'pixels') * max(get(pf.h_axes, 'YLim')), ...
            'Z', .5, ...
            'VISIBLE', true ...
            )
    end
end
%%%% ¡gui!
pr = SettingsPPTable('EL', pf, 'PROP', PFReceiverOperatingCharacteristic.ST_XLABEL, ...
    'COLS', [SettingsText.VISIBLE, SettingsText.TXT, SettingsText.X, SettingsText.Y, SettingsText.ROTATION, SettingsText.HORIZONTALALIGNMENT, SettingsText.VERTICALALIGNMENT, SettingsText.FONTSIZE, SettingsText.FONTNAME, SettingsText.FONTCOLOR, SettingsText.INTERPRETER], ...
    varargin{:});

%%% ¡prop!
ST_YLABEL (figure, item) determines the ylabel settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if check_graphics(pf.h_ylabel, 'text')
    st = pf.get('ST_YLABEL');
    if isa(st.getr('TXT'), 'NoValue')
        st.set( ...
            'TXT', 'True positive ate', ...
            'FONTSIZE', s(2), ...
            'ROTATION', 90, ...
            'HORIZONTALALIGNMENT', 'center', ...
            'X', (1 + s(5)/w(pf.h_axes, 'pixels')) * min(get(pf.h_axes, 'XLim')) - s(5)/w(pf.h_axes, 'pixels') * max(get(pf.h_axes, 'XLim')), ...
            'VERTICALALIGNMENT', 'middle', ...
            'Y', mean(get(pf.h_axes, 'YLim')), ...
            'Z', .5, ...
            'VISIBLE', true ...
            )
    end
end
%%%% ¡gui!
pr = SettingsPPTable('EL', pf, 'PROP', PFReceiverOperatingCharacteristic.ST_YLABEL, ...
    'COLS', [SettingsText.VISIBLE, SettingsText.TXT, SettingsText.X, SettingsText.Y, SettingsText.ROTATION, SettingsText.HORIZONTALALIGNMENT, SettingsText.VERTICALALIGNMENT, SettingsText.FONTSIZE, SettingsText.FONTNAME, SettingsText.FONTCOLOR, SettingsText.INTERPRETER], ...
    varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)
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

    pf.p = draw@PanelFig(pf, varargin{:});
    
    pf.set('ROC_TMP', pf.memorize('NNE').memorize('ROC'));

    % axes
    if ~check_graphics(pf.h_axes, 'axes')
        pf.h_axes = uiaxes( ...
            'Parent', pf.p, ...
            'Tag', 'h_axes', ...
            'Units', 'normalized', ...
            'OuterPosition', [0 0 1 1] ...
            );
        pf.h_axes.Toolbar.Visible = 'off';
        pf.h_axes.Interactions = [];
    end
        
    pf.memorize('ST_AXIS').h(pf.h_axes).set('PANEL', pf, 'UITAG', 'h_axes')
    listener(pf.get('ST_AXIS'), 'PropSet', @cb_st_axis);
    function cb_st_axis(~, ~) % (src, event)
        set(pf.tool_axis, 'State', pf.get('ST_AXIS').get('AXIS'))
        set(pf.tool_grid, 'State', pf.get('ST_AXIS').get('GRID'))
    end

    % Toolbar
    if ~check_graphics(pf.toolbar, 'uitoolbar')
        pf.toolbar = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'ToolBar');
    end
    
    if check_graphics(pf.toolbar, 'uitoolbar') && ~check_graphics(pf.tool_axis, 'uitoggletool') % implies that also the other tools are not defined
        
        uipushtool(pf.toolbar, 'Separator', 'on', 'Visible', 'off')

        % Axis
        pf.tool_axis = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_axis', ...
            'State', pf.get('ST_AXIS').get('AXIS'), ...
            'Tooltip', 'Show axis', ...
            'CData', imread('icon_axis.png'), ...
            'OnCallback', {@cb_axis, true}, ...
            'OffCallback', {@cb_axis, false});
        
        % Grid
        pf.tool_grid = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_grid', ...
            'State', pf.get('ST_AXIS').get('GRID'), ...
            'Tooltip', 'Show grid', ...
            'CData', imread('icon_grid.png'), ...
            'OnCallback', {@cb_grid, true}, ...
            'OffCallback', {@cb_grid, false});
    end
    function cb_axis(~, ~, axis) % (src, event)
        pf.get('ST_AXIS').set('AXIS', axis);
    end
    function cb_grid(~, ~, grid) % (src, event)
        pf.get('ST_AXIS').set('GRID', grid);
    end

    % data line
    if ~check_graphics(pf.h_line, 'line')
        roc = pf.get('ROC_TMP');
        x = roc{1};
        y = roc{2};
        if length(roc) == 3
            std = roc{3}; % TODO: plot the +- std with shaded color
        end
        
        pf.h_line = plot(x, y, ...
            'Parent', pf.h_axes, ...
            'Tag', 'h_line' ...
            );
    end
    
    pf.memorize('ST_LINE').h(pf.h_line).set('PANEL', pf, 'UITAG', 'h_line')
     if ~check_graphics(pf.h_xlabel, 'text')
        pf.h_xlabel = xlabel('X', ...
            'Parent', pf.h_axes, ...
            'Tag', 'h_xlabel' ...
            );
     end
    
    pf.memorize('ST_XLABEL').h(pf.h_xlabel).set('PANEL', pf, 'UITAG', 'h_xlabel')

    if ~check_graphics(pf.h_ylabel, 'text')
        pf.h_ylabel = ylabel('Y', ...
            'Parent', pf.h_axes, ...
            'Tag', 'h_ylabel' ...
            );
    end
    
    pf.memorize('ST_YLABEL').h(pf.h_ylabel).set('PANEL', pf, 'UITAG', 'h_ylabel')
    
    % output
    if nargout > 0
        p_out = pf.p;
    end
end
function str = tostring(pf, varargin)
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

    str = ['Plot ' pf.get('NNE').get('ID')];
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end