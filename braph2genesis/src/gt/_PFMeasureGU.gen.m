%% ¡header!
PFMeasureGU < PFMeasure (pf, panel figure measure GU) is a plot of a global unilayer measure.

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
        'X', pf.get('M').get('G').get('LAYERTICKS'), ...
        'Y', cell2mat(pf.get('M').get('M')), ...
        'VISIBLE', true ...
        )
    pf.get('ST_AXIS').set('AXIS', true)
end

%%% ¡prop!
ST_XLABEL (figure, item) determines the xlabel settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if check_graphics(pf.h_ylabel, 'text')
    st = pf.get('ST_XLABEL');
    if isa(st.getr('TXT'), 'NoValue')
        st.set( ...
            'TXT', pf.get('M').get('G').get('ID') ...
            )
    end
end

%%% ¡prop!
ST_YLABEL (figure, item) determines the ylabel settings.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if check_graphics(pf.h_ylabel, 'text')
    st = pf.get('ST_YLABEL');
    if isa(st.getr('TXT'), 'NoValue')
        st.set( ...
            'TXT', pf.get('M').get('ID'), ...
            'ROTATION', 90 ...
            )
    end
end

%% ¡methods!
function p_out = draw(pf, varargin)

    pf.p = draw@PFMeasure(pf, varargin{:});
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