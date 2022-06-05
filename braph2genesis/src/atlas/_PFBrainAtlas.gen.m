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

h_syms % handle for the symbols 
h_sphs % handle for the spheres 
h_ids % handle for the id 
h_labs % handle for the labs 

%% ¡props!

%%% ¡prop!
BA (metadata, item) is the brain atlas with the brain regions.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
SYM_ON (figure, logical) whether to show the symbols of the brain regions.
%%%% ¡default!
true

%%% ¡prop!
SYM_DICT (figure, idict) contains the symbols of the brain regions.
%%%% ¡settings!
'SettingsSymbol'
%%%% ¡postprocessing!
if pf.get('SYM_ON')
    if ~isa(pf.getr('BA'), 'NoValue')
        if ~isa(pf.getr('SYM_DICT'), 'NoValue')
            
            br_dict = pf.get('BA').get('BR_DICT');
            
            if pf.get('SYM_DICT').length() == 0
                for i = 1:1:br_dict.length()
                    br = br_dict.getItem(i);
                    
                    syms{i} = SettingsSymbol( ...
                        'ID', Callback('EL', br, 'TAG', 'ID'), ...
                        'VISIBLE', true, ...
                        'X', Callback('EL', br, 'TAG', 'X'), ...
                        'Y', Callback('EL', br, 'TAG', 'Y'), ...
                        'Z', Callback('EL', br, 'TAG', 'Z') ...
                        );
                end
                
                pf.get('SYM_DICT').set('IT_LIST', syms)
            else
                for i = 1:1:br_dict.length()
                    if pf.get('SYM_DICT').containsIndex(i)
                        pf.get('SYM_DICT').getItem(i).h(pf.h_syms{i}).set( ...
                            'PANEL', pf, ...
                            'UITAG', ['h_syms{' int2str(i) '}'] ... % same as in h_syms{i}
                            );
                    end
                end
            end
        end
    end
else
    for i = 1:1:length(pf.h_syms)
        if check_graphics(pf.h_syms{i}, 'line')
            set(pf.h_syms{i}, 'Visible', false)
        end
    end
end
% % % %%%% ¡gui!
% % % pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.SYM_DICT, ...
% % %     'COLS', [SettingsSymbol.VISIBLE SettingsSymbol.X SettingsSymbol.Y SettingsSymbol.Z SettingsSymbol.SYMBOL SettingsSymbol.SYMBOLSIZE], ...
% % %     varargin{:});

%%% ¡prop!
SPH_ON (figure, logical) whether to show the spheres of the brain regions.
%%%% ¡default!
false

%%% ¡prop!
SPH_DICT (figure, idict) contains the spheres of the brain regions.
%%%% ¡settings!
'SettingsSphere'
%%%% ¡postprocessing!
if pf.get('SPH_ON')
    if ~isa(pf.getr('BA'), 'NoValue')
        if ~isa(pf.getr('SPH_DICT'), 'NoValue')
            
            br_dict = pf.get('BA').get('BR_DICT');
            
            if pf.get('SPH_DICT').length() == 0
                for i = 1:1:br_dict.length()
                    br = br_dict.getItem(i);
                    
                    sphs{i} = SettingsSphere( ...
                        'ID', Callback('EL', br, 'TAG', 'ID'), ...
                        'X', Callback('EL', br, 'TAG', 'X'), ...
                        'Y', Callback('EL', br, 'TAG', 'Y'), ...
                        'Z', Callback('EL', br, 'TAG', 'Z') ...
                        );
                end
                
                pf.get('SPH_DICT').set('IT_LIST', sphs)
            else
                for i = 1:1:br_dict.length()
                    if pf.get('SPH_DICT').containsIndex(i)
                        pf.get('SPH_DICT').getItem(i).h(pf.h_sphs{i}).set( ...
                            'PANEL', pf, ...
                            'UITAG', ['h_sphs{' int2str(i) '}'] ... % same as in h_sphs{i}
                            );
                    end
                end
            end
        end
    end
else
    for i = 1:1:length(pf.h_sphs)
        if check_graphics(pf.h_sphs{i}, 'line')
            set(pf.h_sphs{i}, 'Visible', false)
        end
    end
end
% % % %%%% ¡gui!
% % % pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.SPH_DICT, ...
% % %     'COLS', [SettingsSphere.VISIBLE SettingsSphere.X SettingsSphere.Y SettingsSphere.Z SettingsSphere.SPHERESIZE SettingsSphere.FACEALPHA SettingsSphere.EDGEALPHA], ...
% % %     varargin{:});

%%% ¡prop!
ID_ON (figure, logical) whether to show the ids of the brain regions.
%%%% ¡default!
false

%%% ¡prop!
ID_DICT (figure, idict) contains the ids of the brain regions.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if pf.get('ID_ON')
    if ~isa(pf.getr('BA'), 'NoValue')
        if ~isa(pf.getr('ID_DICT'), 'NoValue')
            
            br_dict = pf.get('BA').get('BR_DICT');
            
            if pf.get('ID_DICT').length() == 0
                for i = 1:1:br_dict.length()
                    br = br_dict.getItem(i);
                    
                    ids{i} = SettingsText( ...
                        'ID', Callback('EL', br, 'TAG', 'ID'), ...
                        'X', Callback('EL', br, 'TAG', 'X'), ...
                        'Y', Callback('EL', br, 'TAG', 'Y'), ...
                        'Z', Callback('EL', br, 'TAG', 'Z'), ...
                        'TXT', Callback('EL', br, 'TAG', 'ID') ...
                        );
                end
                
                pf.get('ID_DICT').set('IT_LIST', ids)
            else
                for i = 1:1:br_dict.length()
                    if pf.get('ID_DICT').containsIndex(i)
                        pf.get('ID_DICT').getItem(i).h(pf.h_ids{i}).set( ...
                            'PANEL', pf, ...
                            'UITAG', ['h_ids{' int2str(i) '}'] ... % same as in h_ids{i}
                            );
                    end
                end
            end
        end
    end
else
    for i = 1:1:length(pf.h_ids)
        if check_graphics(pf.h_ids{i}, 'line')
            set(pf.h_ids{i}, 'Visible', false)
        end
    end
end
% % % %%%% ¡gui!
% % % pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.ID_DICT, ...
% % %     'COLS', [SettingsText.VISIBLE SettingsText.X SettingsText.Y SettingsText.Z SettingsText.TXT SettingsText.FONTNAME SettingsText.FONTSIZE SettingsText.INTERPRETER], ...
% % %     varargin{:});

%%% ¡prop!
LAB_ON (figure, logical) whether to show the labels of the brain regions.
%%%% ¡default!
false

%%% ¡prop!
LAB_DICT (figure, idict) contains the labels of the brain regions.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if pf.get('LAB_ON')
    if ~isa(pf.getr('BA'), 'NoValue')
        if ~isa(pf.getr('LAB_DICT'), 'NoValue')
            
            br_dict = pf.get('BA').get('BR_DICT');
            
            if pf.get('LAB_DICT').length() == 0
                for i = 1:1:br_dict.length()
                    br = br_dict.getItem(i);
                    
                    labs{i} = SettingsText( ...
                        'ID', Callback('EL', br, 'TAG', 'ID'), ...
                        'X', Callback('EL', br, 'TAG', 'X'), ...
                        'Y', Callback('EL', br, 'TAG', 'Y'), ...
                        'Z', Callback('EL', br, 'TAG', 'Z'), ...
                        'TXT', Callback('EL', br, 'TAG', 'LABEL') ...
                        );
                end
                
                pf.get('LAB_DICT').set('IT_LIST', labs)
            else
                for i = 1:1:br_dict.length()
                    if pf.get('LAB_DICT').containsIndex(i)
                        pf.get('LAB_DICT').getItem(i).h(pf.h_labs{i}).set( ...
                            'PANEL', pf, ...
                            'UITAG', ['h_labs{' int2str(i) '}'] ... % same as in h_labs{i}
                            );
                    end
                end
            end
        end
    end
else
    for i = 1:1:length(pf.h_labs)
        if check_graphics(pf.h_labs{i}, 'line')
            set(pf.h_labs{i}, 'Visible', false)
        end
    end
end
% % % %%%% ¡gui!
% % % pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.ID_DICT, ...
% % %     'COLS', [SettingsText.VISIBLE SettingsText.X SettingsText.Y SettingsText.Z SettingsText.TXT SettingsText.FONTNAME SettingsText.FONTSIZE SettingsText.INTERPRETER], ...
% % %     varargin{:});

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
    
    if isempty(pf.h_syms) || any(cellfun(@(h_sym) ~check_graphics(h_sym, 'line'), pf.h_syms))
        L = pf.memorize('BA').get('BR_DICT').length();
        pf.h_syms = cell(1, L);
        for i = 1:1:L
            pf.h_syms{i} = plot3(0, 0, 0, ...
                'Parent', pf.h_axes, ...
                'Tag', ['h_syms{' int2str(i) '}'] ... % same as in syms{i}
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
    
    % output
    if nargout > 0
        p_out = pf.p;
    end
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