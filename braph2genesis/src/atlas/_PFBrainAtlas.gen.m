%% ¡header!
PFBrainAtlas < PFBrainSurface (pf, panel figure brain atlas) is a plot of a brain atlas.

%%% ¡description!
PFBrainAtlas manages the plot of the brain regions symbols,
spheres, ids and labels. PFBrainAtlas utilizes the surface created
from PFBrainSurface to integrate the regions to a brain surface.

%%% ¡seealso!
Plot, BrainSurface, PlotBrainSurface

%% ¡properties!
p  % handle for panel
h_axes

h_sphs % handle for the spheres 
h_syms % handle for the symbols 
h_ids % handle for the id 
h_labs % handle for the labs 

toolbar
tool_sphs
tool_syms
tool_ids
tool_labs

%% ¡props!

%%% ¡prop!
BA (metadata, item) is the brain atlas with the brain regions.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
SPHS (figure, logical) determines whether the spheres are shown.
%%%% ¡default!
true
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('SPHS', varargin)) && ~braph2_testing
    if ~pf.get('SPHS')
        for i = 1:1:length(pf.h_sphs)
            set(pf.h_sphs{i}, 'Visible', false)
        end        
    end
    
    % triggers the update of SPH_DICT
    pf.set('SPH_DICT', pf.get('SPH_DICT'))
    
    % update state of toggle tool
    set(pf.tool_sphs, 'State', pf.get('SPHS'))
end

%%% ¡prop!
SPH_DICT (figure, idict) contains the spheres of the brain regions.
%%%% ¡settings!
'SettingsSphere'
%%%% ¡postprocessing!
if pf.get('SPHS') && ~isa(pf.getr('BA'), 'NoValue')
    if ~isa(pf.getr('SPH_DICT'), 'NoValue')

        br_dict = pf.get('BA').get('BR_DICT');

        if pf.get('SPH_DICT').length() == 0 && br_dict.length()

            for i = 1:1:br_dict.length()
                br = br_dict.getItem(i);

                sphs{i} = SettingsSphere( ...
                    'VISIBLE', true, ...
                    'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
                    'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
                    'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
                    'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z') ...
                    'FACECOLOR', BRAPH2.COL, ...
                    'FACEALPHA', 1 ...
                    );
            end

            pf.get('SPH_DICT').set('IT_LIST', sphs)
        end
        
        if ~isempty(pf.h_sphs)
            for i = 1:1:br_dict.length()
                if pf.get('SPH_DICT').containsIndex(i) && check_graphics(pf.h_sphs{i}, 'surface')
                    pf.get('SPH_DICT').getItem(i).h(pf.h_sphs{i}).set( ...
                        'PANEL', pf, ...
                        'UITAG', ['h_sphs{' int2str(i) '}'] ... % same as in h_sphs{i}
                        );
                end
            end
        end
        
        % reset the ambient lighting
        pf.get('ST_AMBIENT').set()
    end
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.SPH_DICT, ...
    'COLS', [SettingsSphere.VISIBLE SettingsSphere.X SettingsSphere.Y SettingsSphere.Z SettingsSphere.SPHERESIZE SettingsSphere.FACECOLOR SettingsSphere.FACEALPHA SettingsSphere.EDGECOLOR SettingsSphere.EDGEALPHA], ...
    varargin{:});

%%% ¡prop!
SYMS (figure, logical) determines whether the symbols are shown.
%%%% ¡default!
false
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('SYMS', varargin)) && ~braph2_testing
    if ~pf.get('SYMS')
        for i = 1:1:length(pf.h_sphs)
            set(pf.h_syms{i}, 'Visible', false)
        end        
    end
    
    % triggers the update of SYM_DICT
    pf.set('SYM_DICT', pf.get('SYM_DICT'))

    % update state of toggle tool
    set(pf.tool_syms, 'State', pf.get('SYMS'))
end

%%% ¡prop!
SYM_DICT (figure, idict) contains the symbols of the brain regions.
%%%% ¡settings!
'SettingsSymbol'
%%%% ¡postprocessing!
if pf.get('SYMS') && ~isa(pf.getr('BA'), 'NoValue')
    if ~isa(pf.getr('SYM_DICT'), 'NoValue')

        br_dict = pf.get('BA').get('BR_DICT');

        if pf.get('SYM_DICT').length() == 0 && br_dict.length()

            for i = 1:1:br_dict.length()
                br = br_dict.getItem(i);

                syms{i} = SettingsSymbol( ...
                    'VISIBLE', true, ...
                    'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
                    'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
                    'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
                    'Z', br.get('Z') ... % Callback('EL', br, 'TAG', 'Z') ...
                    );
            end

            pf.get('SYM_DICT').set('IT_LIST', syms)
        end
        
        if ~isempty(pf.h_syms)
            for i = 1:1:br_dict.length()
                if pf.get('SYM_DICT').containsIndex(i) && check_graphics(pf.h_syms{i}, 'line')
                    pf.get('SYM_DICT').getItem(i).h(pf.h_syms{i}).set( ...
                        'PANEL', pf, ...
                        'UITAG', ['h_syms{' int2str(i) '}'] ... % same as in h_syms{i}
                        );
                end
            end
        end
    end
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.SYM_DICT, ...
    'COLS', [SettingsSymbol.VISIBLE SettingsSymbol.X SettingsSymbol.Y SettingsSymbol.Z SettingsSymbol.SYMBOL SettingsSymbol.SYMBOLSIZE SettingsSymbol.EDGECOLOR SettingsSymbol.FACECOLOR], ...
    varargin{:});

%%% ¡prop!
IDS (figure, logical) determines whether the ids are shown.
%%%% ¡default!
false
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('IDS', varargin)) && ~braph2_testing
    if ~pf.get('IDS')
        for i = 1:1:length(pf.h_sphs)
            set(pf.h_ids{i}, 'Visible', false)
        end        
    end
    
    % triggers the update of ID_DICT
    pf.set('ID_DICT', pf.get('ID_DICT'))

    % update state of toggle tool
    set(pf.tool_ids, 'State', pf.get('IDS'))
end

%%% ¡prop!
ID_DICT (figure, idict) contains the ids of the brain regions.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if pf.get('IDS') && ~isa(pf.getr('BA'), 'NoValue')
    if ~isa(pf.getr('ID_DICT'), 'NoValue')

        br_dict = pf.get('BA').get('BR_DICT');

        if pf.get('ID_DICT').length() == 0 && br_dict.length()

            for i = 1:1:br_dict.length()
                br = br_dict.getItem(i);

                ids{i} = SettingsText( ...
                    'VISIBLE', true, ...
                    'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
                    'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
                    'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
                    'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z'), ...
                    'TXT', br.get('ID') ... % Callback('EL', br, 'TAG', 'ID') ...
                    );
            end

            pf.get('ID_DICT').set('IT_LIST', ids)
        end
        
        if ~isempty(pf.h_ids)
            for i = 1:1:br_dict.length()
                if pf.get('ID_DICT').containsIndex(i) && check_graphics(pf.h_ids{i}, 'text')
                    pf.get('ID_DICT').getItem(i).h(pf.h_ids{i}).set( ...
                        'PANEL', pf, ...
                        'UITAG', ['h_ids{' int2str(i) '}'] ... % same as in h_ids{i}
                        );
                end
            end
        end
    end
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.ID_DICT, ...
    'COLS', [SettingsText.VISIBLE SettingsText.X SettingsText.Y SettingsText.Z SettingsText.TXT SettingsText.FONTNAME SettingsText.FONTSIZE SettingsText.FONTCOLOR SettingsText.INTERPRETER], ...
    varargin{:});

%%% ¡prop!
LABS (figure, logical) determines whether the labels are shown.
%%%% ¡default!
false
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('LABS', varargin)) && ~braph2_testing
    if ~pf.get('LABS')
        for i = 1:1:length(pf.h_sphs)
            set(pf.h_labs{i}, 'Visible', false)
        end        
    end
    
    % triggers the update of LAB_DICT
    pf.set('LAB_DICT', pf.get('LAB_DICT'))

    % update state of toggle tool
    set(pf.tool_labs, 'State', pf.get('LABS'))
end

%%% ¡prop!
LAB_DICT (figure, idict) contains the labels of the brain regions.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if pf.get('LABS') && ~isa(pf.getr('BA'), 'NoValue')
    if ~isa(pf.getr('LAB_DICT'), 'NoValue')

        br_dict = pf.get('BA').get('BR_DICT');

        if pf.get('LAB_DICT').length() == 0 && br_dict.length()

            for i = 1:1:br_dict.length()
                br = br_dict.getItem(i);

                labs{i} = SettingsText( ...
                    'VISIBLE', true, ...
                    'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
                    'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
                    'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
                    'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z'), ...
                    'TXT', br.get('LABEL') ... % Callback('EL', br, 'TAG', 'LABEL') ...
                    );
            end

            pf.get('LAB_DICT').set('IT_LIST', labs)
        end
        
        if ~isempty(pf.h_labs)
            for i = 1:1:br_dict.length()
                if pf.get('LAB_DICT').containsIndex(i) && check_graphics(pf.h_labs{i}, 'text')
                    pf.get('LAB_DICT').getItem(i).h(pf.h_labs{i}).set( ...
                        'PANEL', pf, ...
                        'UITAG', ['h_labs{' int2str(i) '}'] ... % same as in h_labs{i}
                        );
                end
            end
        end
    end
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.LAB_DICT, ...
    'COLS', [SettingsText.VISIBLE SettingsText.X SettingsText.Y SettingsText.Z SettingsText.TXT SettingsText.FONTNAME SettingsText.FONTSIZE SettingsText.FONTCOLOR SettingsText.INTERPRETER], ...
    varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)
    %DRAW draws the brain atlas graphical panel.
    %
    % DRAW(PL) draws the brain atlas graphical panel.
    %
    % P = DRAW(PF) returns a handle to the brain atlas graphical panel.
    %
    % DRAW(PF, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain atlas graphical panel P.
    %
    % see also settings, uipanel.

    pf.p = draw@PFBrainSurface(pf, varargin{:});
    
    if ~check_graphics(pf.h_axes, 'axes')
        pf.h_axes = pf.p.Children(1); % findobj(pf.p, 'Tag', 'h_axes');
    end
    
    if isempty(pf.h_sphs) || any(cellfun(@(h_sph) ~check_graphics(h_sph, 'surface'), pf.h_sphs))
        L = pf.memorize('BA').get('BR_DICT').length();
        pf.h_sphs = cell(1, L);
        for i = 1:1:L
            pf.h_sphs{i} = surf([], [], [], ...
                'Parent', pf.h_axes, ...
                'Tag', ['h_sphs{' int2str(i) '}'], ... % same as in sphs{i}
                'Visible', false ...
                );
        end
    end
    if isa(pf.getr('SPH_DICT'), 'NoValue')
        pf.memorize('SPH_DICT').set( ...
            'ID', 'Spheres', ...
            'IT_CLASS', 'SettingsSphere', ...
            'IT_KEY', SettingsSphere.ID ...
            )
    end
    
    if isempty(pf.h_syms) || any(cellfun(@(h_sym) ~check_graphics(h_sym, 'line'), pf.h_syms))
        L = pf.memorize('BA').get('BR_DICT').length();
        pf.h_syms = cell(1, L);
        for i = 1:1:L
            pf.h_syms{i} = plot3(0, 0, 0, ...
                'Parent', pf.h_axes, ...
                'Tag', ['h_syms{' int2str(i) '}'], ... % same as in syms{i}
                'Visible', false ...
                );
        end
    end
    if isa(pf.getr('SYM_DICT'), 'NoValue')
        pf.memorize('SYM_DICT').set( ...
            'ID', 'Symbols', ...
            'IT_CLASS', 'SettingsSymbol', ...
            'IT_KEY', SettingsSymbol.ID ...
            )
    end    
    
    if isempty(pf.h_ids) || any(cellfun(@(h_id) ~check_graphics(h_id, 'surface'), pf.h_ids))
        L = pf.memorize('BA').get('BR_DICT').length();
        pf.h_ids = cell(1, L);
        for i = 1:1:L
            pf.h_ids{i} = text(0, 0, 0, '', ...
                'Parent', pf.h_axes, ...
                'Tag', ['h_ids{' int2str(i) '}'], ... % same as in ids{i}
                'Visible', false ...
                );
        end
    end
    if isa(pf.getr('ID_DICT'), 'NoValue')
        pf.memorize('ID_DICT').set( ...
            'ID', 'IDs', ...
            'IT_CLASS', 'SettingsText', ...
            'IT_KEY', SettingsText.ID ...
            )
    end

    if isempty(pf.h_labs) || any(cellfun(@(h_lab) ~check_graphics(h_lab, 'surface'), pf.h_labs))
        L = pf.memorize('BA').get('BR_DICT').length();
        pf.h_labs = cell(1, L);
        for i = 1:1:L
            pf.h_labs{i} = text(0, 0, 0, '', ...
                'Parent', pf.h_axes, ...
                'Tag', ['h_labs{' int2str(i) '}'], ... % same as in labs{i}
                'Visible', false ...
                );
        end
    end
    if isa(pf.getr('LAB_DICT'), 'NoValue')
        pf.memorize('LAB_DICT').set( ...
            'ID', 'Labels', ...
            'IT_CLASS', 'SettingsText', ...
            'IT_KEY', SettingsText.ID ...
            )
    end
    
    % reset the ambient lighting
    pf.get('ST_AMBIENT').set()
    
    % Toolbar
    if ~check_graphics(pf.toolbar, 'uitoolbar')
        pf.toolbar = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'ToolBar');
    end
    
    if check_graphics(pf.toolbar, 'uitoolbar') && ~check_graphics(pf.tool_sphs, 'uitoggletool') % implies that also the other tools are not defined
        
        uipushtool(pf.toolbar, 'Separator', 'on', 'Visible', 'off')

        % Spheres
        pf.tool_sphs = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_sphs', ...
            'Separator', 'on', ...
            'State', pf.get('SPHS'), ...
            'Tooltip', 'Show Spheres', ...
            'CData', imread('icon_sphere.png'), ...
            'OnCallback', {@cb_sphs, true}, ...
            'OffCallback', {@cb_sphs, false});

        % Symbols
        pf.tool_syms = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_syms', ...
            'Separator', 'on', ...
            'State', pf.get('SYMS'), ...
            'Tooltip', 'Show Symbols', ...
            'CData', imread('icon_symbol.png'), ...
            'OnCallback', {@cb_syms, true}, ...
            'OffCallback', {@cb_syms, false});

        % IDs
        pf.tool_ids = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_ids', ...
            'Separator', 'on', ...
            'State', pf.get('IDS'), ...
            'Tooltip', 'Show IDs', ...
            'CData', imread('icon_id.png'), ...
            'OnCallback', {@cb_ids, true}, ...
            'OffCallback', {@cb_ids, false});

        % Labels
        pf.tool_labs = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_labs', ...
            'Separator', 'on', ...
            'State', pf.get('LABS'), ...
            'Tooltip', 'Show Labels', ...
            'CData', imread('icon_label.png'), ...
            'OnCallback', {@cb_labs, true}, ...
            'OffCallback', {@cb_labs, false});
    end
    function cb_sphs(~, ~, sphs) % (src, event)
        pf.set('SPHS', sphs)
    end
    function cb_syms(~, ~, syms) % (src, event)
        pf.set('SYMS', syms)
    end
    function cb_ids(~, ~, ids) % (src, event)
        pf.set('IDS', ids)
    end
    function cb_labs(~, ~, labs) % (src, event)
        pf.set('LABS', labs)
    end
    
    % output
    if nargout > 0
        p_out = pf.p;
    end
end
function str = tostring(pf, varargin)
    %TOSTRING string with information about the brain atlas.
    %
    % STR = TOSTRING(PF) returns a string with information about the brain atlas.
    %
    % STR = TOSTRING(PF, N) trims the string to the first N characters.
    %
    % STR = TOSTRING(PF, N, ENDING) ends the string with ENDING if it has
    %  been trimmed.
    %
    % See also disp, tree.

    str = 'Plot Brain Atlas';
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);
items = {br1, br2, br3, br4, br5, br6};
idict = IndexedDictionary( ...
    'id', 'idict', ...
    'it_class', 'BrainRegion', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', items ...
    );
ba0 = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'Notes', 'Notes on brain atlas.', 'br_dict', idict);
pf0 = PFBrainAtlas(...
    'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'), ...
    'BA', ba0 ...
    );
gui0 = GUIFig('PF', pf0, 'FILE', 'xxx sss', 'WAITBAR', true, 'CLOSEREQ', false);
f0 = gui0.draw('Units', 'normalized', 'Position', [.1 .1 .4 .8]);
close(f0)

ba1 = ImporterBrainAtlasXLS('FILE', [fileparts(which('braph2')) filesep() 'atlases' filesep() 'aal90_atlas.xlsx']).get('BA');
pf1 = PFBrainAtlas(...
    'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'), ...
    'BA', ba1 ...
    );
gui1 = GUIFig('PF', pf1, 'FILE', 'xxx sss', 'WAITBAR', false, 'CLOSEREQ', false);
f1 = gui1.draw('Units', 'normalized', 'Position', [.1 .1 .4 .8]);
close(f1)