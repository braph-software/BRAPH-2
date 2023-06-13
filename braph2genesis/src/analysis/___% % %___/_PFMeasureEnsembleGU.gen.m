%% ¡header!
PFMeasureEnsembleGU < PFMeasureEnsemble (pf, panel figure measure GU) is a plot of a global unilayer/superglobal measure.

%%% ¡description!
% % % PFBrainSurface manages the plot of the brain surface choosen by the user. 
% % % A collection of brain surfaces in NV format can be found in the folder 
% % % ./braph2/brainsurfs/.
% % % This class provides the common methods needed to manage the plot of 
% % % the surface. In particualr, the user can change lighting, material, 
% % % camlight, shadning, colormap, facecolor, brain color, face color, 
% % % edge color, and background color. 

%%% ¡seealso!
PanelFig, MeasureEnsemble

%% ¡properties!
p  % handle for panel
h_axes % handle for the axes

h_line % data line
h_xlabel
h_ylabel

%% ¡props!

%%% ¡prop!
ST_LINE (figure, item) determines the line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡postprocessing!
if check_graphics(pf.h_line, 'line')
    pf.get('ST_LINE').set( ...
        'X', pf.get('ME').get('A').get('GRAPH_TEMPLATE').get('LAYERTICKS'), ...
        'Y', cell2mat(pf.get('ME').get('M')), ...
        'VISIBLE', true ...
        )
    pf.get('ST_AXIS').set('AXIS', true)
    set(pf.h_axes, 'InnerPosition', [s(6)/w(pf.h_axes, 'pixels') s(6)/h(pf.h_axes, 'pixels') max(.1, 1-s(8)/w(pf.h_axes, 'pixels')) max(.1, 1-s(8)/h(pf.h_axes, 'pixels'))])
end
%%%% ¡gui!
pr = SettingsPPTable('EL', pf, 'PROP', PFMeasureEnsembleGU.ST_LINE, ...
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
            'TXT', pf.get('ME').get('A').get('ID'), ...
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
pr = SettingsPPTable('EL', pf, 'PROP', PFMeasureEnsembleGU.ST_XLABEL, ...
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
            'TXT', pf.get('ME').get('ID'), ...
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
pr = SettingsPPTable('EL', pf, 'PROP', PFMeasureEnsembleGU.ST_YLABEL, ...
    'COLS', [SettingsText.VISIBLE, SettingsText.TXT, SettingsText.X, SettingsText.Y, SettingsText.ROTATION, SettingsText.HORIZONTALALIGNMENT, SettingsText.VERTICALALIGNMENT, SettingsText.FONTSIZE, SettingsText.FONTNAME, SettingsText.FONTCOLOR, SettingsText.INTERPRETER], ...
    varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)

    pf.p = draw@PFMeasureEnsemble(pf, varargin{:});
    pf.h_axes = pf.get('ST_AXIS').h();
    
    % data line
    if ~check_graphics(pf.h_line, 'line')
        pf.h_line = plot([0 1], [0 1], ...
            'Parent', pf.h_axes, ...
            'Tag', 'h_line' ...
            );
    end
    
    pf.memorize('ST_LINE').h(pf.h_line).set('PANEL', pf, 'UITAG', 'h_line')
    
    if ~check_graphics(pf.h_xlabel, 'text')
        pf.h_xlabel = xlabel(' ', ...
            'Parent', pf.h_axes, ...
            'Tag', 'h_xlabel' ...
            );
    end
    pf.memorize('ST_XLABEL').h(pf.h_xlabel).set('PANEL', pf, 'UITAG', 'h_xlabel')

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