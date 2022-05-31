%% ¡header!
SettingsAxis < Settings (st, axis settings) contains the axis settings.

%%% ¡description!
SettingsAxis provides the settings for an axis, 
including axis color, hold on/off, axis on/off, equal on/off, and tight on/off.

%%% ¡seealso!
PanelFig, GUIFig, uiaxes

%% ¡props!

%%% ¡prop!
AXISCOLOR (figure, color) is the axis background color.
%%%% ¡default!
[1 1 1]
%%%% ¡postprocessing!
a = st.h(); % axes
if check_graphics(a, 'axes') && ~isequal(set(a, 'Color'), st.get('AXISCOLOR'))
    set(a, 'Color', st.get('AXISCOLOR'))
end

%%% ¡prop!
HOLD (figure, logical) determines whether hold is on or off.
%%%% ¡default!
true
%%%% ¡postprocessing!
a = st.h(); % axes
if check_graphics(a, 'axes')
    if st.get('HOLD')
        hold(a, 'on')
    else
        hold(a, 'off')
    end
end

%%% ¡prop!
GRID (figure, logical) determines whether the grid is shown.
%%%% ¡default!
false
%%%% ¡postprocessing!
a = st.h(); % axes
if check_graphics(a, 'axes')
    if st.get('GRID')
        grid(a, 'on')
    else
        grid(a, 'off')
    end
end

%%% ¡prop!
AXIS (figure, logical) determines whether the axis is shown.
%%%% ¡default!
false
%%%% ¡postprocessing!
a = st.h(); % axes
if check_graphics(a, 'axes')
    if st.get('AXIS')
        axis(a, 'on')
    else
        axis(a, 'off')
    end
end

%%% ¡prop!
EQUAL (figure, logical) determines whether the axis are equal.
%%%% ¡default!
true
%%%% ¡postprocessing!
a = st.h(); % axes
if check_graphics(a, 'axes')
    if st.get('EQUAL')
        daspect(a, [1 1 1])
    else
        daspect(a, 'auto')
    end
end

%%% ¡prop!
TIGHT (figure, logical) determines whether the axis are tight.
%%%% ¡default!
false
%%%% ¡postprocessing!
a = st.h(); % axes
if (isempty(varargin) || st.prop_set('TIGHT', varargin)) && check_graphics(a, 'axes')
    if st.get('TIGHT')
        axis(a, 'tight')
    end
end
