%% ¡header!
SettingsROIS < SettingsSurface (st, rois settings) contains the rois settings.

%%% ¡description!
SettingsROIS provides the settings for a rois, 
including visibility, face color and alpha, edge color and alpha.

%%% ¡seealso!
PanelFig, GUIFig, patch

%% ¡props!

%%% ¡prop!
VISIBLE (figure, logical) determines whether the roi is visible.
%%%% ¡defaul!
false
%%%% ¡postprocessing!
h = st.h(); % patch
if check_graphics(h, 'surface') && get(h, 'Visible') ~= st.get('VISIBLE') 
    if st.get('VISIBLE')        
        set(h, 'Visible', true);
    else
        set(h, 'Visible', false)
    end
end