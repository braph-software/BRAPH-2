%% ¡header!
SettingsAmbient < Settings (st, ambient settings) contains the ambient settings.

%%% ¡description!
SettingsAmbient provides the settings for the ambient lightning and material, 
including lighting, material, camlight, shading, and colormap.

%%% ¡seealso!
PanelFig, GUIFig, uiaxes

%% ¡properties!
light1 % cam light 1
light2 % cam light 2
light3 % cam light 3

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
{'none' 'headlight' 'headlight (x2)' 'headlight (x3)' 'right' 'right (x2)' 'right (x3)' 'left' 'left (x2)' 'left (x3)'}
%%%% ¡default!
'headlight (x2)'
%%%% ¡postprocessing!
a = st.h(); % axes
if check_graphics(a, 'axes')
    delete(st.light1)
    delete(st.light2)
    delete(st.light3)
    switch st.get('CAMLIGHT')
        case 'headlight' 
            st.light1 = camlight(a, 'headlight');
        case 'headlight (x2)'
            st.light1 = camlight(a, 'headlight');
            st.light2 = camlight(a, 'headlight');
        case 'headlight (x3)'
            st.light1 = camlight(a, 'headlight');
            st.light2 = camlight(a, 'headlight');
            st.light3 = camlight(a, 'headlight');
        case 'right'
            st.light1 = camlight(a, 'right');
        case 'right (x2)'
            st.light1 = camlight(a, 'right');
            st.light2 = camlight(a, 'right');
        case 'right (x3)'
            st.light1 = camlight(a, 'right');
            st.light2 = camlight(a, 'right');
            st.light3 = camlight(a, 'right');
        case 'left'
            st.light1 = camlight(a, 'left');
        case 'left (x2)'
            st.light1 = camlight(a, 'left');
            st.light2 = camlight(a, 'left');
        case 'left (x3)'
            st.light1 = camlight(a, 'left');
            st.light2 = camlight(a, 'left');
            st.light3 = camlight(a, 'left');
    end
end

%%% ¡prop!
SHADING (figure, option) is the shading value.
%%%% ¡settings!
{'none' 'interp' 'flat' 'faceted'}
%%%% ¡default!
'none'
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
{'none', 'white', 'parula', 'jet', 'hsv', 'hot', 'cool', 'spring', 'summer', 'autumn', 'winter', 'gray', 'bone', 'copper', 'pink', 'lines', 'colorcube', 'prism', 'flag'}
%%%% ¡default!
'none'
%%%% ¡postprocessing!
a = st.h(); % axes
if check_graphics(a, 'axes')
    if ~strcmpi(st.get('COLORMAP'), 'none')
        colormap(a, st.get('COLORMAP'))
    end
end