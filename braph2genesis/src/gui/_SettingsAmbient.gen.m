%% ¡header!
SettingsAmbient < Settings (st, ambient settings) contains the ambient settings.

%%% ¡description!
SettingsAmbient provides the settings for the ambient lightning and material, 
including lighting, material, camlight, shading, and colormap.

%%% ¡seealso!
PanelFig, GUIFig, uiaxes

%% ¡props!

%%% ¡prop!
LIGHTING (figure, option) is the lighting value.
%%%% ¡settings!
{'none' 'phong' 'flat' 'gouraud'}
%%%% ¡default!
'gouraud'
%%%% ¡postprocessing!
a = st.h(); % axes'
if check_graphics(a, 'axes')
    lighting(a, st.get('LIGHTING'))
end

%%% ¡prop!
MATERIAL (figure, option) is the material value.
%%%% ¡settings!
{'shiny' 'dull' 'metal'}
%%%% ¡default!
'shiny'
%%%% ¡postprocessing!
a = st.h(); % axes
if check_graphics(a, 'axes')
    material(a, st.get('MATERIAL'))
end

%%% ¡prop!
CAMLIGHT (figure, option) is the camlight value.
%%%% ¡settings!
{'none' 'headlight' 'right' 'left'}
%%%% ¡default!
'headlight'
%%%% ¡postprocessing!
a = st.h(); % axes
if check_graphics(a, 'axes')
    delete(findall(a, 'Type', 'light'));
    if ~strcmpi(st.get('CAMLIGHT'), 'none')
        camlight(a, st.get('CAMLIGHT'))
    end
end

%%% ¡prop!
SHADING (figure, option) is the shading value.
%%%% ¡settings!
{'none' 'interp' 'flat' 'faceted'}
%%%% ¡default!
'interp'
%%%% ¡postprocessing!
a = st.h(); % axes
if check_graphics(a, 'axes')
    if ~strcmpi(st.get('SHADING'), 'none')
        shading(a, st.get('SHADING'))
    end
end

%%% ¡prop!
COLORMAP (figure, option) is the colormap.
%%%% ¡settings!
{'white', 'parula', 'jet', 'hsv', 'hot', 'cool', 'spring', 'summer', 'autumn', 'winter', 'gray', 'bone', 'copper', 'pink', 'lines', 'colorcube', 'prism', 'flag'}
%%%% ¡postprocessing!
a = st.h(); % axes
if check_graphics(a, 'axes')
    if ~strcmpi(st.get('SHADING'), 'none')
        colormap(a, st.get('COLORMAP'))
    end
end