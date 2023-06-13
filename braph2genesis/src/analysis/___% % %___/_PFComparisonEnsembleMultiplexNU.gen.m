%% ¡header!
PFComparisonEnsembleMultiplexNU < PFComparisonEnsembleGU (pf, panel figure group comparison multiplex GU) is a plot of a nodal unilayer group comparison for multiplex graphs.

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

%% ¡props_update!

%%% ¡prop!
ST_LINE_DIFF (figure, item) determines the difference line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡postprocessing!
if check_graphics(pf.h_line_diff, 'line')
    bas = pf.get('CP').get('MEASURE_TEMPLATE').get('G').get('BAS');
    ba = bas{1};

    if ~ba.get('BR_DICT').contains(pf.get('BR1_ID'))
        pf.set('BR1_ID', ba.get('BR_DICT').getItem(1).get('ID'))
    end
    br1_id = ba.get('BR_DICT').getIndex(pf.get('BR1_ID'));
    
    data = pf.get('CP').get('DIFF');
    [l, ls] = pf.get('CP').get('C').get('A1').get('G_DICT').getItem(1).layernumber();
    index_l = str2double(pf.get('LAYER'));
    total_l = ls(1);
    data_to_plot = data(index_l:total_l:end);
    
    pf.get('ST_LINE_DIFF').set( ...
        'X', pf.get('CP').get('MEASURE_TEMPLATE').get('G').get('LAYERTICKS'), ...
        'Y', cellfun(@(x) x(br1_id), data_to_plot), ...
        'VISIBLE', true ...
        )
    pf.get('ST_AXIS').set('AXIS', true)
    set(pf.h_axes, 'InnerPosition', [s(6)/w(pf.h_axes, 'pixels') s(6)/h(pf.h_axes, 'pixels') max(.1, 1-s(8)/w(pf.h_axes, 'pixels')) max(.1, 1-s(8)/h(pf.h_axes, 'pixels'))])
end

%%% ¡prop!
ST_LINE_CIU (figure, item) determines the upper-confidence-interval line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡default!
SettingsLine('SYMBOL', '.')
%%%% ¡postprocessing!
if check_graphics(pf.h_line_ciu, 'line')
    bas = pf.get('CP').get('MEASURE_TEMPLATE').get('G').get('BAS');
    ba = bas{1};

    if ~ba.get('BR_DICT').contains(pf.get('BR1_ID'))
        pf.set('BR1_ID', ba.get('BR_DICT').getItem(1).get('ID'))
    end
    br1_id = ba.get('BR_DICT').getIndex(pf.get('BR1_ID'));
    
    data = pf.get('CP').get('CIU');
    [l, ls] = pf.get('CP').get('C').get('A1').get('G_DICT').getItem(1).layernumber();
    index_l = str2double(pf.get('LAYER'));
    total_l = ls(1);
    data_to_plot = data(index_l:total_l:end);
    
    pf.get('ST_LINE_CIU').set( ...
        'X', pf.get('CP').get('MEASURE_TEMPLATE').get('G').get('LAYERTICKS'), ...
        'Y', cellfun(@(x) x(br1_id), data_to_plot), ...
        'VISIBLE', true ...
        )
    pf.get('ST_AXIS').set('AXIS', true)
    set(pf.h_axes, 'InnerPosition', [s(6)/w(pf.h_axes, 'pixels') s(6)/h(pf.h_axes, 'pixels') max(.1, 1-s(8)/w(pf.h_axes, 'pixels')) max(.1, 1-s(8)/h(pf.h_axes, 'pixels'))])
end

%%% ¡prop!
ST_LINE_CIL (figure, item) determines the lower-confidence-interval line settings.
%%%% ¡settings!
'SettingsLine'
%%%% ¡default!
SettingsLine('SYMBOL', '.')
%%%% ¡postprocessing!
if check_graphics(pf.h_line_cil, 'line')
    bas = pf.get('CP').get('MEASURE_TEMPLATE').get('G').get('BAS');
    ba = bas{1};

    if ~ba.get('BR_DICT').contains(pf.get('BR1_ID'))
        pf.set('BR1_ID', ba.get('BR_DICT').getItem(1).get('ID'))
    end
    br1_id = ba.get('BR_DICT').getIndex(pf.get('BR1_ID'));
    
    data = pf.get('CP').get('CIL');
    [l, ls] = pf.get('CP').get('C').get('A1').get('G_DICT').getItem(1).layernumber();
    index_l = str2double(pf.get('LAYER'));
    total_l = ls(1);
    data_to_plot = data(index_l:total_l:end);
    
    pf.get('ST_LINE_CIL').set( ...
        'X', pf.get('CP').get('MEASURE_TEMPLATE').get('G').get('LAYERTICKS'), ...
        'Y', cellfun(@(x) x(br1_id), data_to_plot), ...
        'VISIBLE', true ...
        )
    pf.get('ST_AXIS').set('AXIS', true)
    set(pf.h_axes, 'InnerPosition', [s(6)/w(pf.h_axes, 'pixels') s(6)/h(pf.h_axes, 'pixels') max(.1, 1-s(8)/w(pf.h_axes, 'pixels')) max(.1, 1-s(8)/h(pf.h_axes, 'pixels'))])
end

%% ¡props!

%%% ¡prop!
LAYER (figure, string) is the id of the selected layer.
%%%% ¡default!
'1'
%%%% ¡gui!
g =  pf.get('CP').get('C').get('A1').get('G_DICT').getItem(1);
pr = PP_LayerID('EL', pf, 'PROP', PFComparisonEnsembleMultiplexNU.LAYER, ...
    'G', g, ...
    varargin{:});

%%% ¡prop!
BR1_ID (figure, string) is the ID of the brain region of the nodal measure.
%%%% ¡gui!
bas = pf.get('CP').get('MEASURE_TEMPLATE').get('G').get('BAS');
ba = bas{1};

pr = PP_BrainRegion('EL', pf, 'PROP', PFComparisonEnsembleMultiplexNU.BR1_ID, ...
    'BA', ba, ...
    varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)

    pf.p = draw@PFComparisonEnsembleGU(pf, varargin{:});
    pf.h_axes = pf.get('ST_AXIS').h();
    pf.h_line_diff = pf.get('ST_LINE_DIFF').h();
    pf.h_line_ciu = pf.get('ST_LINE_CIU').h();
    pf.h_line_cil = pf.get('ST_LINE_CIL').h();
    
    % output
    if nargout > 0
        p_out = pf.p;
    end
end