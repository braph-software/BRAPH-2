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
syms

h_sphs % handle for the spheres 
sphs

h_ids % handle for the id 
ids

h_labs % handle for the labs 
labs 

%% ¡props!

%%% ¡prop!
BA (metadata, item) is the brain atlas with the brain regions.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
SYM_DICT (figure, idict) contains the symbols of the brain regions.
%%%% ¡settings!
'SettingsSymbol'
%%%% ¡postprocessing!
if ~isa(pf.getr('BA'), 'NoValue') && ~isa(pf.getr('SYM_DICT'), 'NoValue') && pf.get('SYM_DICT').length() == 0
    
    br_dict = pf.get('BA').get('BR_DICT');
    for i = 1:1:br_dict.length()
        br = br_dict.getItem(i);
        
        pf.h_syms{i} = plot3(0, 0, 0, ...
            'Parent', pf.h_axes, ...
            'Tag', ['h_syms{' int2str(i) '}'] ... % same as below
            );

        syms{i} = SettingsSymbol( ...
            'ID', Callback('EL', br, 'TAG', 'ID'), ...
            'PANEL', pf, ...
            'UITAG', ['h_syms{' int2str(i) '}'], ... % same as above
            'VISIBLE', true, ...
            'X', Callback('EL', br, 'TAG', 'X'), ...
            'Y', Callback('EL', br, 'TAG', 'Y'), ...
            'Z', Callback('EL', br, 'TAG', 'Z') ...
            );
    end
    
    pf.get('SYM_DICT').set('IT_LIST', syms)
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.SYM_DICT, ...
    'COLS', [SettingsSymbol.VISIBLE SettingsSymbol.X SettingsSymbol.Y SettingsSymbol.Z SettingsSymbol.SYMBOL SettingsSymbol.SYMBOLSIZE], ...
    varargin{:});

%%% ¡prop!
SPH_DICT (figure, idict) contains the spheres of the brain regions.
%%%% ¡settings!
'SettingsSphere'
%%%% ¡postprocessing!
if ~isa(pf.getr('BA'), 'NoValue') && ~isa(pf.getr('SPH_DICT'), 'NoValue') && pf.get('SPH_DICT').length() == 0
    
    br_dict = pf.get('BA').get('BR_DICT');
    for i = 1:1:br_dict.length()
        br = br_dict.getItem(i);
        
        pf.h_sphs{i} = surf([], [], [], ...
            'Parent', pf.h_axes, ...
            'Tag', ['h_sphs{' int2str(i) '}'], ... % same as below
            'Visible', false ...
            );

        sphs{i} = SettingsSphere( ...
            'ID', Callback('EL', br, 'TAG', 'ID'), ...
            'PANEL', pf, ...
            'UITAG', ['h_sphs{' int2str(i) '}'], ... % same as above
            'X', Callback('EL', br, 'TAG', 'X'), ...
            'Y', Callback('EL', br, 'TAG', 'Y'), ...
            'Z', Callback('EL', br, 'TAG', 'Z') ...
            );
    end
    
    pf.get('SPH_DICT').set('IT_LIST', sphs)
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.SPH_DICT, ...
    'COLS', [SettingsSphere.VISIBLE SettingsSphere.X SettingsSphere.Y SettingsSphere.Z SettingsSphere.SPHERESIZE SettingsSphere.FACEALPHA SettingsSphere.EDGEALPHA], ...
    varargin{:});

%%% ¡prop!
ID_DICT (figure, idict) contains the ids of the brain regions.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if ~isa(pf.getr('BA'), 'NoValue') && ~isa(pf.getr('ID_DICT'), 'NoValue') && pf.get('ID_DICT').length() == 0
    
    br_dict = pf.get('BA').get('BR_DICT');
    for i = 1:1:br_dict.length()
        br = br_dict.getItem(i);
        
        pf.h_ids{i} = text(0, 0, 0, '', ...
            'Parent', pf.h_axes, ...
            'Tag', ['h_ids{' int2str(i) '}'], ... % same as below
            'Visible', false ...
            );

        ids{i} = SettingsText( ...
            'ID', Callback('EL', br, 'TAG', 'ID'), ...
            'PANEL', pf, ...
            'UITAG', ['h_ids{' int2str(i) '}'], ... % same as above
            'X', Callback('EL', br, 'TAG', 'X'), ...
            'Y', Callback('EL', br, 'TAG', 'Y'), ...
            'Z', Callback('EL', br, 'TAG', 'Z'), ...
            'TXT', Callback('EL', br, 'TAG', 'ID') ...
            );
    end

    pf.get('ID_DICT').set('IT_LIST', ids)
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.ID_DICT, ...
    'COLS', [SettingsText.VISIBLE SettingsText.X SettingsText.Y SettingsText.Z SettingsText.TXT SettingsText.FONTNAME SettingsText.FONTSIZE SettingsText.INTERPRETER], ...
    varargin{:});

%%% ¡prop!
LAB_DICT (figure, idict) contains the labels of the brain regions.
%%%% ¡settings!
'SettingsText'
%%%% ¡postprocessing!
if ~isa(pf.getr('BA'), 'NoValue') && ~isa(pf.getr('LAB_DICT'), 'NoValue') && pf.get('LAB_DICT').length() == 0

    br_dict = pf.get('BA').get('BR_DICT');
    for i = 1:1:br_dict.length()
        br = br_dict.getItem(i);
        
        pf.h_labs{i} = text(0, 0, 0, '', ...
            'Parent', pf.h_axes, ...
            'Tag', ['h_labs{' int2str(i) '}'], ... % same as below
            'Visible', false ...
            );

        labs{i} = SettingsText( ...
            'ID', Callback('EL', br, 'TAG', 'ID'), ...
            'PANEL', pf, ...
            'UITAG', ['h_labs{' int2str(i) '}'], ... % same as above
            'X', Callback('EL', br, 'TAG', 'X'), ...
            'Y', Callback('EL', br, 'TAG', 'Y'), ...
            'Z', Callback('EL', br, 'TAG', 'Z'), ...
            'TXT', Callback('EL', br, 'TAG', 'ID') ...
            );
    end
    
    pf.get('LAB_DICT').set('IT_LIST', labs)
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.ID_DICT, ...
    'COLS', [SettingsText.VISIBLE SettingsText.X SettingsText.Y SettingsText.Z SettingsText.TXT SettingsText.FONTNAME SettingsText.FONTSIZE SettingsText.INTERPRETER], ...
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
        pf.h_axes = findall(pf.p, 'Tag', 'h_axes');
    end
    
    if isa(pf.getr('SYM_DICT'), 'NoValue')
        pf.memorize('SYM_DICT').set( ...
            'ID', 'Symbols', ...
            'IT_CLASS', 'SettingsSymbol', ...
            'IT_KEY', SettingsSymbol.ID ...
            )
    end

    if isa(pf.getr('SPH_DICT'), 'NoValue')
        pf.memorize('SPH_DICT').set( ...
            'ID', 'Spheres', ...
            'IT_CLASS', 'SettingsSphere', ...
            'IT_KEY', SettingsSphere.ID ...
            )
    end

    if isa(pf.getr('ID_DICT'), 'NoValue')
        pf.memorize('ID_DICT').set( ...
            'ID', 'IDs', ...
            'IT_CLASS', 'SettingsText', ...
            'IT_KEY', SettingsText.ID ...
            )
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