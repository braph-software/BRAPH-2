%% ¡header!
PFComparisonGroupGU < PFComparisonGroup (pf, panel figure group comparison GU) is a plot of a global unilayer group comparison.

%%% ¡description!
% % % PFBrainSurface manages the plot of the brain surface choosen by the user. 
% % % A collection of brain surfaces in NV format can be found in the folder 
% % % ./braph2/brainsurfs/.
% % % This class provides the common methods needed to manage the plot of 
% % % the surface. In particualr, the user can change lighting, material, 
% % % camlight, shadning, colormap, facecolor, brain color, face color, 
% % % edge color, and background color. 

%%% ¡seealso!
PanelFig, Measure

%% ¡properties!
p  % handle for panel
h_axes % handle for the axes

h_line_diff % measure line
h_line_ciu % upper CI line
h_line_cil % lower CI line
h_area_ci % CI area
h_xlabel
h_ylabel

%% ¡props!

%%% ¡prop!
ST_LINE_DIFF (figure, item) determines the difference line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡postprocessing!
if check_graphics(pf.h_line_diff, 'line')
    
    pf.get('ST_LINE_DIFF').set( ...
        'X', pf.get('CP').get('MEASURE_TEMPLATE').get('G').get('LAYERTICKS'), ...
        'Y', cell2mat(pf.get('CP').get('DIFF')), ...
        'VISIBLE', true ...
        )
    pf.get('ST_AXIS').set('AXIS', true)
    set(pf.h_axes, 'InnerPosition', [s(6)/w(pf.h_axes, 'pixels') s(6)/h(pf.h_axes, 'pixels') max(.1, 1-s(8)/w(pf.h_axes, 'pixels')) max(.1, 1-s(8)/h(pf.h_axes, 'pixels'))])
end
%%%% ¡gui!
pr = SettingsPPTable('EL', pf, 'PROP', PFComparisonGroupGU.ST_LINE_DIFF, ...
    'COLS', [SettingsLine.VISIBLE, SettingsLine.LINESTYLE, SettingsLine.LINEWIDTH, SettingsLine.LINECOLOR, SettingsLine.SYMBOL, SettingsLine.SYMBOLSIZE, SettingsLine.EDGECOLOR, SettingsLine.FACECOLOR], ...
    varargin{:});

%%% ¡prop!
ST_LINE_CIU (figure, item) determines the upper-confidence-interval line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡default!
SettingsLine('SYMBOL', '.')
%%%% ¡postprocessing!
if check_graphics(pf.h_line_ciu, 'line')
    pf.get('ST_LINE_CIU').set( ...
        'X', pf.get('CP').get('MEASURE_TEMPLATE').get('G').get('LAYERTICKS'), ...
        'Y', cell2mat(pf.get('CP').get('CIU')), ...
        'VISIBLE', true ...
        )
    pf.get('ST_AXIS').set('AXIS', true)
    set(pf.h_axes, 'InnerPosition', [s(6)/w(pf.h_axes, 'pixels') s(6)/h(pf.h_axes, 'pixels') max(.1, 1-s(8)/w(pf.h_axes, 'pixels')) max(.1, 1-s(8)/h(pf.h_axes, 'pixels'))])
end
%%%% ¡gui!
pr = SettingsPPTable('EL', pf, 'PROP', PFComparisonGroupGU.ST_LINE_CIU, ...
    'COLS', [SettingsLine.VISIBLE, SettingsLine.LINESTYLE, SettingsLine.LINEWIDTH, SettingsLine.LINECOLOR, SettingsLine.SYMBOL, SettingsLine.SYMBOLSIZE, SettingsLine.EDGECOLOR, SettingsLine.FACECOLOR], ...
    varargin{:});

%%% ¡prop!
ST_LINE_CIL (figure, item) determines the lower-confidence-interval line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡default!
SettingsLine('SYMBOL', '.')
%%%% ¡postprocessing!
if check_graphics(pf.h_line_cil, 'line')
    pf.get('ST_LINE_CIL').set( ...
        'X', pf.get('CP').get('MEASURE_TEMPLATE').get('G').get('LAYERTICKS'), ...
        'Y', cell2mat(pf.get('CP').get('CIL')), ...
        'VISIBLE', true ...
        )
    pf.get('ST_AXIS').set('AXIS', true)
    set(pf.h_axes, 'InnerPosition', [s(6)/w(pf.h_axes, 'pixels') s(6)/h(pf.h_axes, 'pixels') max(.1, 1-s(8)/w(pf.h_axes, 'pixels')) max(.1, 1-s(8)/h(pf.h_axes, 'pixels'))])
end
%%%% ¡gui!
pr = SettingsPPTable('EL', pf, 'PROP', PFComparisonGroupGU.ST_LINE_CIL, ...
    'COLS', [SettingsLine.VISIBLE, SettingsLine.LINESTYLE, SettingsLine.LINEWIDTH, SettingsLine.LINECOLOR, SettingsLine.SYMBOL, SettingsLine.SYMBOLSIZE, SettingsLine.EDGECOLOR, SettingsLine.FACECOLOR], ...
    varargin{:});

%%% ¡prop!
ST_XLABEL (figure, item) determines the xlabel settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if check_graphics(pf.h_ylabel, 'text')
    st = pf.get('ST_XLABEL');
    if isa(st.getr('TXT'), 'NoValue')
        st.set( ...
            'TXT', pf.get('CP').get('MEASURE_TEMPLATE').get('G').get('ID'), ...
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
pr = SettingsPPTable('EL', pf, 'PROP', PFComparisonGroupGU.ST_XLABEL, ...
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
            'TXT', pf.get('CP').get('ID'), ...
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
pr = SettingsPPTable('EL', pf, 'PROP', PFComparisonGroupGU.ST_YLABEL, ...
    'COLS', [SettingsText.VISIBLE, SettingsText.TXT, SettingsText.X, SettingsText.Y, SettingsText.ROTATION, SettingsText.HORIZONTALALIGNMENT, SettingsText.VERTICALALIGNMENT, SettingsText.FONTSIZE, SettingsText.FONTNAME, SettingsText.FONTCOLOR, SettingsText.INTERPRETER], ...
    varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)

    pf.p = draw@PFComparisonGroup(pf, varargin{:});
    pf.h_axes = pf.get('ST_AXIS').h();
    
    % difference line
    if ~check_graphics(pf.h_line_diff, 'line')
        pf.h_line_diff = plot([0 1], [0 1], ...
            'Parent', pf.h_axes, ...
            'Tag', 'h_line' ...
            );
    end
    pf.memorize('ST_LINE_DIFF').h(pf.h_line_diff).set('PANEL', pf, 'UITAG', 'h_line_diff')
    
    % upper-confidence-interval line
    if ~check_graphics(pf.h_line_ciu, 'line')
        pf.h_line_ciu = plot([0 1], [0 1], ...
            'Parent', pf.h_axes, ...
            'Tag', 'h_line_ciu' ...
            );
    end
    pf.memorize('ST_LINE_CIU').h(pf.h_line_ciu).set('PANEL', pf, 'UITAG', 'h_line_ciu')

    % lower-confidence-interval line
    if ~check_graphics(pf.h_line_cil, 'line')
        pf.h_line_cil = plot([0 1], [0 1], ...
            'Parent', pf.h_axes, ...
            'Tag', 'h_line_cil' ...
            );
    end
    pf.memorize('ST_LINE_CIL').h(pf.h_line_cil).set('PANEL', pf, 'UITAG', 'h_line_cil')

    % reorders lines
    set(pf.h_axes, 'Children', flipud(pf.h_axes.Children))
    
    % x-label
    if ~check_graphics(pf.h_xlabel, 'text')
        pf.h_xlabel = xlabel(' ', ...
            'Parent', pf.h_axes, ...
            'Tag', 'h_xlabel' ...
            );
    end
    pf.memorize('ST_XLABEL').h(pf.h_xlabel).set('PANEL', pf, 'UITAG', 'h_xlabel')

    % y-label
    if ~check_graphics(pf.h_ylabel, 'text')
        pf.h_ylabel = ylabel(' ', ...
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