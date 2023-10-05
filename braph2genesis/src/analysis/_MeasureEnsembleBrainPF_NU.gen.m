%% ¡header!
MeasureEnsembleBrainPF_NU < MeasureEnsembleBrainPF (pf, panel figure for nodal unilayer measure group brain) is a plot of a nodal unilayer measure group brain.

%%% ¡description!
A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF_NU ) manages the plot of the nodal unilayer measure
 ploted over the brain.  
MeasureEnsembleBrainPF_NU utilizes the surface created from BrainAtlasPF to integrate 
 the nodal unilayer meaure into the brain regions.

%%% ¡seealso!
BrainAtlas, BrainSurface, BrainAtlasPF

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.LAYER
%%%% ¡title!
Graph LAYER

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.SPHS
%%%% ¡title!
Brain Region SPHERES ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.SPH_DICT
%%%% ¡title!
Brain Region SPHERES PROPERTIES

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.SIZE_DIFF
%%%% ¡title!
Show Measure Value with SPHERES SIZE

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.SIZE_SCALE
%%%% ¡title!
Size SCALE

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.COLOR_DIFF
%%%% ¡title!
Show Measure Value with SPHERES COLOR

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.ID
%%%% ¡title!
Brain Atlas Figure ID

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.LABEL
%%%% ¡title!
Brain Atlas Figure NAME

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.WAITBAR
%%%% ¡title!
WAITBAR ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.NOTES
%%%% ¡title!
Brain Atlas NOTES

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.BKGCOLOR
%%%% ¡title!
BACKGROUND COLOR

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.ST_POSITION
%%%% ¡title!
PANEL POSITION

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.VIEW
%%%% ¡title!
3D VIEW

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.ST_AXIS
%%%% ¡title!
AXIS

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.BRAIN
%%%% ¡title!
BRAIN ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.SURFFILE
%%%% ¡title!
BRAIN SURFACE

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.ST_SURFACE
%%%% ¡title!
BRAIN COLOR

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.ST_AMBIENT
%%%% ¡title!
MATERIAL & LIGHTNING

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.SYMS
%%%% ¡title!
Brain Region SYMBOLS ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.SYM_DICT
%%%% ¡title!
Brain Region SYMBOLS PROPERTIES

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.IDS
%%%% ¡title!
Brain Region IDs ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.ID_DICT
%%%% ¡title!
Brain Region IDs PROPERTIES

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.LABS
%%%% ¡title!
Brain Region LABELS ON/OFF

%%% ¡prop!
%%%% ¡id!
MeasureEnsembleBrainPF_NU.LAB_DICT
%%%% ¡title!
Brain Region LABELS PROPERTIES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % %.
%%%% ¡default!
'MeasureEnsembleBrainPF_NU'

%%% ¡prop!
NAME (constant, string) is the name of the panel figure for measure group brain.
%%%% ¡default!
'Panel Figure for Measure Group Brain'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
%%%% ¡default!
'A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF_NU) manages the plot of the nodal unilayer measure ploted over the brain. MeasureEnsembleBrainPF_NU  utilizes the surface created from BrainAtlasPF to integrate the nodal unilayer meaure into the brain regions.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
%%%% ¡settings!
'MeasureEnsembleBrainPF_NU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF_NU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF_NU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
%%%% ¡default!
'MeasureEnsembleBrainPF_NU notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.
%%%% ¡calculate!
me = pf.get('ME');

% get brain region related list
sph_list = pf.get('SPH_DICT').get('IT_LIST');
sym_list = pf.get('SYM_DICT').get('IT_LIST');
id_list = pf.get('ID_DICT').get('IT_LIST');
lab_list = pf.get('LAB_DICT').get('IT_LIST');

% get the value to show on the surface
layer = pf.get('LAYER');
m_values = me.get('M');
if isempty(m_values)
    value = {};
    return
end
m_value = m_values{layer};
if isempty(m_value)
    value = {};
    return
end

size_diff = pf.get('SIZE_DIFF');
switch size_diff
    case 'on'
        % transfrom m value to appropriate size
        % value ranching from 0.01 to 1
        m_value(isnan(m_value)) = 0.1;
        size_value = abs(m_value);
        min_bound = 0.01;
        max_bound = 1.0;
        min_size_value = min(size_value);
        max_size_value = max(size_value);
        if max_size_value == min_size_value
            normalized_size_value = ones(size(size_value)) * max_bound;
        else
            normalized_size_value = min_bound + (max_bound - min_bound) * (size_value - min_size_value) / (max_size_value - min_size_value);
        end
        size_scale = pf.get('SIZE_SCALE');
        scaled_size_value = normalized_size_value * size_scale;

        % set size to sphs
        for i = 1:1:length(sph_list)
            set(sph_list{i}, 'SPHERESIZE', scaled_size_value(i));
        end
    case 'off'
        if pf.get('SPHS')
            for i = 1:1:length(sph_list)
                set(sph_list{i}, 'SPHERESIZE', SettingsSphere.getPropDefault('SPHERESIZE'));
            end
        end
    case 'disable'
end

color_diff = pf.get('COLOR_DIFF');
switch color_diff
    case 'on'
        % transfrom m value to appropriate color
        % RGB code ranching from 0 to 1
        m_value(isnan(m_value)) = 0;
        size_value = abs(m_value);
        min_bound = 0.0;
        max_bound = 1.0;
        min_size_value = min(size_value);
        max_size_value = max(size_value);
        if max_size_value == min_size_value
            normalized_size_value = ones(size(size_value)) * max_bound;
        else
            normalized_size_value = min_bound + (max_bound - min_bound) * (size_value - min_size_value) / (max_size_value - min_size_value);
        end

        % Map the normalized values to colors in the Jet colormap
        cmap = jet(256);
        color_indices = ceil(normalized_size_value * (size(cmap, 1) - 1)) + 1;

        % Clip color_indices to valid range
        color_indices = max(1, min(color_indices, size(cmap, 1)));

        % Get the RGB colors for the indices
        rgb_colors = cmap(color_indices, :);

        % set color to sphs
        for i = 1:1:length(sph_list)
            set(sph_list{i}, 'FACECOLOR', rgb_colors(i, :));
        end
        
    case 'off'
        if pf.get('SPHS')
            for i = 1:1:length(sph_list)
                set(sph_list{i}, 'FACECOLOR', SettingsSphere.getPropDefault('FACECOLOR'));
            end
        end
    case 'disable'
end

value = {};

%% ¡props!

%%% ¡prop!
LAYER (figure, scalar) is the layer number of the nodal measure.
%%%% ¡default!
1
%%%% ¡postset!
pf.get('SETUP');
%%%% ¡gui!
pr = MeasureEnsembleBrainPF_Layer_NU('EL', pf, 'PROP', MeasureEnsembleBrainPF_NU.LAYER);

%%% ¡prop!
SIZE_DIFF (figure, option) determines whether the difference is shown with size effect.
%%%% ¡settings!
{'on' 'off' 'disable'}
%%%% ¡default!
'on'
%%%% ¡postset!
pf.get('SETUP');

%%% ¡prop!
SIZE_SCALE (figure, scalar) determines the scale of size effect.
%%%% ¡default!
10
%%%% ¡postset!
pf.get('SETUP');

%%% ¡prop!
COLOR_DIFF (figure, option) determines whether the difference is shown with color effect.
%%%% ¡settings!
{'on' 'off' 'disable'}
%%%% ¡default!
'on'
%%%% ¡postset!
pf.get('SETUP');

%% ¡tests!

%%% ¡excluded_props!
[MeasureEnsembleBrainPF_NU.PARENT MeasureEnsembleBrainPF_NU.H MeasureEnsembleBrainPF_NU.ST_POSITION MeasureEnsembleBrainPF_NU.ST_AXIS MeasureEnsembleBrainPF_NU.ST_SURFACE MeasureEnsembleBrainPF_NU.ST_AMBIENT MeasureEnsembleBrainPF_NU.ME]

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasureEnsembleBrainPF_NU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasureEnsembleBrainPF_NU'])
