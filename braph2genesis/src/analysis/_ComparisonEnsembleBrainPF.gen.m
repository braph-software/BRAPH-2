%% ¡header!
ComparisonEnsembleBrainPF < BrainAtlasPF (pf, panel ensemble-based comparison figure on brain surface figure) is the base element to plot an ensemble-based comparison on brain surface figure.

%%% ¡description!
ComparisonEnsembleBrainPF manages the basic functionalities to plot of an ensemble-based comparison on brain surface figure.

%%% ¡seealso!
ComparisonEnsemble

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_LINE_DIFF
%%%% ¡title!
DIFFERENCE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_AREA
%%%% ¡title!
CONFIDENCE AREA (95%)

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_LINE_CIL
%%%% ¡title!
LOWER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_LINE_CIU
%%%% ¡title!
UPPER CONFIDENCE LINE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_TITLE
%%%% ¡title!
TITLE

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_XLABEL
%%%% ¡title!
X-LABEL

%%% ¡prop!
%%%% ¡id!
ComparisonEnsembleBrainPF.ST_YLABEL
%%%% ¡title!
Y-LABEL

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'ComparisonEnsembleBrainPF'

%%% ¡prop!
NAME (constant, string) is the name of the panel ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF manages the basic functionalities to plot of an ensemble-based comparison on brain surface.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure on brain surface.
%%%% ¡settings!
'ComparisonEnsembleBrainPF'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure on brain surface.
%%%% ¡default!
'ComparisonEnsembleBrainPF notes'

%%% ¡prop!
DRAW (query, logical) draws the figure comparison figure on brain surface.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
if value
    pf.memorize('H_AXES')
    
    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', ComparisonEnsembleBrainPF.H_AXES).get('SETUP')
    pf.memorize('LISTENER_ST_AXIS');
    
    pf.memorize('H_AREA')
    pf.memorize('ST_AREA').set('PANEL', pf, 'PROP', ComparisonEnsembleBrainPF.H_AREA).get('SETUP')
    pf.memorize('LISTENER_ST_AREA');

    pf.memorize('H_LINE_DIFF')
    pf.memorize('ST_LINE_DIFF').set('PANEL', pf, 'PROP', ComparisonEnsembleBrainPF.H_LINE_DIFF).get('SETUP')
	pf.memorize('LISTENER_ST_LINE_DIFF');
    
    pf.memorize('H_LINE_CIL')
    pf.memorize('ST_LINE_CIL').set('PANEL', pf, 'PROP', ComparisonEnsembleBrainPF.H_LINE_CIL).get('SETUP')
	pf.memorize('LISTENER_ST_LINE_CIL');

    pf.memorize('H_LINE_CIU')
    pf.memorize('ST_LINE_CIU').set('PANEL', pf, 'PROP', ComparisonEnsembleBrainPF.H_LINE_CIU).get('SETUP')
	pf.memorize('LISTENER_ST_LINE_CIU');

    pf.memorize('H_TITLE')
    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', ComparisonEnsembleBrainPF.H_TITLE).get('SETUP')

    pf.memorize('H_XLABEL')
    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', ComparisonEnsembleBrainPF.H_XLABEL).get('SETUP')
    
    pf.memorize('H_YLABEL')
    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', ComparisonEnsembleBrainPF.H_YLABEL).get('SETUP')

    pf.get('SETUP')
end

%%% ¡prop!
DELETE (query, logical) resets the handles when the panel figure graph is deleted.
%%%% ¡calculate!
value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
if value
    pf.set('H_AXES', Element.getNoValue())

    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
    
    pf.set('H_AREA', Element.getNoValue())
    pf.set('LISTENER_ST_AREA', Element.getNoValue())
 
    pf.set('H_LINE_DIFF', Element.getNoValue())
    pf.set('LISTENER_ST_LINE_DIFF', Element.getNoValue())

    pf.set('H_LINE_CIL', Element.getNoValue())
    pf.set('LISTENER_ST_LINE_CIL', Element.getNoValue())

    pf.set('H_LINE_CIU', Element.getNoValue())
    pf.set('LISTENER_ST_LINE_CIU', Element.getNoValue())

    pf.set('H_TITLE', Element.getNoValue())

    pf.set('H_XLABEL', Element.getNoValue())
    
    pf.set('H_YLABEL', Element.getNoValue())
end

%%% ¡prop!
H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
%%%% ¡calculate!
toolbar = pf.memorize('H_TOOLBAR');
if check_graphics(toolbar, 'uitoolbar')
    value = calculateValue@PanelFig(pf, PanelFig.H_TOOLS);
    
    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');

    % Axis
    tool_axis = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Axis', ...
        'Separator', 'on', ...
        'State', pf.get('ST_AXIS').get('AXIS'), ...
        'Tooltip', 'Show axis', ...
        'CData', imread('icon_axis.png'), ...
        'OnCallback', {@cb_axis, true}, ...
        'OffCallback', {@cb_axis, false});

    % Grid
    tool_grid = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Grid', ...
        'State', pf.get('ST_AXIS').get('GRID'), ...
        'Tooltip', 'Show grid', ...
        'CData', imread('icon_grid.png'), ...
        'OnCallback', {@cb_grid, true}, ...
        'OffCallback', {@cb_grid, false});

    tool_separator_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
    
    % Difference Line
    tool_line_diff = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Line_Diff', ...
        'State', pf.get('ST_LINE_DIFF').get('VISIBLE'), ...
        'Tooltip', 'Show difference line', ...
        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % make icon 16x16
        'OnCallback', {@cb_line_diff, true}, ...
        'OffCallback', {@cb_line_diff, false});

    % Difference Line
    tool_line_ci = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Line_CI', ...
        'State', pf.get('ST_LINE_DIFF').get('VISIBLE'), ...
        'Tooltip', 'Show confidence lines (95%)', ...
        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % imread('icon_lines_two.png'), ...
        'OnCallback', {@cb_line_ci, true}, ...
        'OffCallback', {@cb_line_ci, false});
    
    % Confidence Area
    tool_area = uitoggletool(toolbar, ...
        'Tag', 'TOOL.Area', ...
        'State', pf.get('ST_AREA').get('VISIBLE'), ...
        'Tooltip', 'Show confidence area (95%)', ...
        'CData', imresize(imread('icon_area.png'), [24 24]), ... % % % make icon 16x16
        'OnCallback', {@cb_area, true}, ...
        'OffCallback', {@cb_area, false});

    value = {value{:}, ...
        tool_separator_1, ...
        tool_axis, tool_grid, ... 
        tool_separator_2, ... 
        tool_line_diff, tool_line_ci, tool_area ...
        };
else
    value = {};
end
%%%% ¡calculate_callbacks!
function cb_axis(~, ~, axis) % (src, event)
    pf.get('ST_AXIS').set('AXIS', axis);
    
    % triggers the update of ST_AXIS
    pf.set('ST_AXIS', pf.get('ST_AXIS'))
end
function cb_grid(~, ~, grid) % (src, event)
    pf.get('ST_AXIS').set('GRID', grid);

    % triggers the update of ST_AXIS
    pf.set('ST_AXIS', pf.get('ST_AXIS'))
end
function cb_line_diff(~, ~, visible) % (src, event)
	pf.get('ST_LINE_DIFF').set('VISIBLE', visible)

    % triggers the update of ST_LINE_DIFF
    pf.set('ST_LINE_DIFF', pf.get('ST_LINE_DIFF'))
end
function cb_line_ci(~, ~, visible) % (src, event)
	pf.get('ST_LINE_CIL').set('VISIBLE', visible)
	pf.get('ST_LINE_CIU').set('VISIBLE', visible)

    % triggers the update of ST_LINE_CIL and ST_LINE_CIU
    pf.set('ST_LINE_CIL', pf.get('ST_LINE_CIL'))
    pf.set('ST_LINE_CIU', pf.get('ST_LINE_CIU'))
end
function cb_area(~, ~, visible) % (src, event)
    pf.get('ST_AREA').set('VISIBLE', visible)

    % triggers the update of ST_AREA
    pf.set('ST_AREA', pf.get('ST_AREA'))
end

%% ¡props!

%%%% ¡gui!
pr = SettingsAxisPP('EL', pf, 'PROP', ComparisonEnsembleBrainPF.ST_AXIS, varargin{:});

%%% ¡prop!
CP (metadata, item) is the ensemble-based comparison.
%%%% ¡settings!
'ComparisonEnsemble'

%%% ¡prop!
SETUP (query, empty) calculates the ensemble-based comparison value and stores it to be implemented in the subelements.
%%%% ¡calculate!
value = [];

%%% ¡prop!
H_AREA (evanescent, handle) is the handle for the ensemble-based comparison confidence area.
%%%% ¡calculate!
value = fill(pf.get('H_AXES'), [0], [0], 'k');

%%% ¡prop!
ST_AREA (figure, item) determines the area settings.
%%%% ¡settings!
'SettingsArea'
%%%% ¡gui!
pr = SettingsAreaPP('EL', pf, 'PROP', ComparisonEnsembleBrainPF.ST_AREA, varargin{:});

%%% ¡prop!
LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.
%%%% ¡calculate!
value = listener(pf.get('ST_AREA'), 'PropSet', @cb_listener_st_area); 
%%%% ¡calculate_callbacks!
function cb_listener_st_area(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Area'), 'State', pf.get('ST_AREA').get('VISIBLE'))
        end
    end
end

%%% ¡prop!
H_LINE_DIFF (evanescent, handle) is the handle for the ensemble-based comparison line.
%%%% ¡calculate!
value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);

%%% ¡prop!
ST_LINE_DIFF (figure, item) determines the line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡gui!
pr = SettingsLinePP('EL', pf, 'PROP', ComparisonEnsembleBrainPF.ST_LINE_DIFF, varargin{:});

%%% ¡prop!
LISTENER_ST_LINE_DIFF (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
%%%% ¡calculate!
value = listener(pf.get('ST_LINE_DIFF'), 'PropSet', @cb_listener_st_line_diff); 
%%%% ¡calculate_callbacks!
function cb_listener_st_line_diff(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Line_DIff'), 'State', pf.get('ST_LINE_DIFF').get('VISIBLE'))
        end
    end
end

%%% ¡prop!
H_LINE_CIL (evanescent, handle) is the handle for the lower confidence interval of the ensemble-based comparison line.
%%%% ¡calculate!
value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);

%%% ¡prop!
ST_LINE_CIL (figure, item) determines the line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡default!
SettingsLine('SYMBOLSIZE', 6, 'FACECOLOR', [.5 .5 .5])
%%%% ¡gui!
pr = SettingsLinePP('EL', pf, 'PROP', ComparisonEnsembleBrainPF.ST_LINE_CIL, varargin{:});

%%% ¡prop!
LISTENER_ST_LINE_CIL (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
%%%% ¡calculate!
value = listener(pf.get('ST_LINE_DIFF'), 'PropSet', @cb_listener_st_line_cil); 
%%%% ¡calculate_callbacks!
function cb_listener_st_line_cil(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Line_CI'), 'State', pf.get('ST_LINE_CIL').get('VISIBLE'))
        end
    end
end

%%% ¡prop!
H_LINE_CIU (evanescent, handle) is the handle for the upper confidence interval of the ensemble-based comparison line.
%%%% ¡calculate!
value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);

%%% ¡prop!
ST_LINE_CIU (figure, item) determines the line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡default!
SettingsLine('SYMBOLSIZE', 6, 'FACECOLOR', [.5 .5 .5])
%%%% ¡gui!
pr = SettingsLinePP('EL', pf, 'PROP', ComparisonEnsembleBrainPF.ST_LINE_CIU, varargin{:});

%%% ¡prop!
LISTENER_ST_LINE_CIU (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.
%%%% ¡calculate!
value = listener(pf.get('ST_LINE_CIU'), 'PropSet', @cb_listener_st_line_ciu); 
%%%% ¡calculate_callbacks!
function cb_listener_st_line_ciu(~, ~)
    if pf.get('DRAWN')
        toolbar = pf.get('H_TOOLBAR');
        if check_graphics(toolbar, 'uitoolbar')
            set(findobj(toolbar, 'Tag', 'TOOL.Line_CI'), 'State', pf.get('ST_LINE_CIU').get('VISIBLE'))
        end
    end
end

%%% ¡prop!
H_TITLE (evanescent, handle) is the axis title.
%%%% ¡calculate!
value = title(pf.get('H_AXES'), '');

if isa(pf.getr('ST_TITLE'), 'NoValue')
    st = pf.memorize('ST_TITLE');
    
    position = get(value, 'Position');
    st.set( ...
        'TXT', pf.get('CP').get('LABEL'), ...
        'X', position(1), ...
        'Y', position(2), ...
        'Z', position(3) ...
        )
end

%%% ¡prop!
ST_TITLE (figure, item) determines the title settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡default!
SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle')
%%%% ¡gui!
pr = SettingsTextPP('EL', pf, 'PROP', ComparisonEnsembleBrainPF.ST_TITLE, varargin{:});

%%% ¡prop!
H_XLABEL (evanescent, handle) is the axis x-label.
%%%% ¡calculate!
value = xlabel(pf.get('H_AXES'), '');

if isa(pf.getr('ST_XLABEL'), 'NoValue')
    st = pf.memorize('ST_XLABEL');
    
    position = get(value, 'Position');
    st.set( ...
        'TXT', 'Layer', ...
        'X', position(1), ...
        'Y', position(2), ...
        'Z', position(3) ...
        )
end

%%% ¡prop!
ST_XLABEL (figure, item) determines the x-label settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡default!
SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle')
%%%% ¡gui!
pr = SettingsTextPP('EL', pf, 'PROP', ComparisonEnsembleBrainPF.ST_XLABEL, varargin{:});

%%% ¡prop!
H_YLABEL (evanescent, handle) is the axis y-label.
%%%% ¡calculate!
value = ylabel(pf.get('H_AXES'), '');

if isa(pf.getr('ST_YLABEL'), 'NoValue')
    st = pf.memorize('ST_YLABEL');
    
    position = get(value, 'Position');
    st.set( ...
        'TXT', 'Difference', ...
        'X', position(1), ...
        'Y', position(2), ...
        'Z', position(3) ...
        )
end

%%% ¡prop!
ST_YLABEL (figure, item) determines the y-label settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡default!
SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90)
%%%% ¡gui!
pr = SettingsTextPP('EL', pf, 'PROP', ComparisonEnsembleBrainPF.ST_YLABEL, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[ComparisonEnsembleBrainPF.PARENT ComparisonEnsembleBrainPF.H ComparisonEnsembleBrainPF.ST_POSITION ComparisonEnsembleBrainPF.ST_AXIS ComparisonEnsembleBrainPF.ST_AREA ComparisonEnsembleBrainPF.ST_LINE_DIFF ComparisonEnsembleBrainPF.ST_LINE_CIL ComparisonEnsembleBrainPF.ST_LINE_CIU ComparisonEnsembleBrainPF.ST_TITLE ComparisonEnsembleBrainPF.ST_XLABEL ComparisonEnsembleBrainPF.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonEnsembleBrainPF'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonEnsembleBrainPF'])