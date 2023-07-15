%% ¡header!
ComparisonGroupPF_BU < ComparisonGroupPF (pf, panel binodal unilayer group comparison figure) is the base element to plot a binodal unilayer group comparison figure.

%%% ¡description!
ComparisonGroupPF_BU manages the basic functionalities to plot of a binodal unilayer group comparison figure.

%%% ¡seealso!
ComparisonGroup

%% ¡_layout!

% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.ID
% % % %%%% ¡title!
% % % Brain Atlas Figure ID
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.LABEL
% % % %%%% ¡title!
% % % Brain Atlas Figure NAME
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.WAITBAR
% % % %%%% ¡title!
% % % WAITBAR ON/OFF
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.NOTES
% % % %%%% ¡title!
% % % Brain Atlas NOTES
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.BKGCOLOR
% % % %%%% ¡title!
% % % BACKGROUND COLOR
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.ST_POSITION
% % % %%%% ¡title!
% % % PANEL POSITION
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.ST_AXIS
% % % %%%% ¡title!
% % % AXIS
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.ST_AREA
% % % %%%% ¡title!
% % % FILLED AREA
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.ST_LINE
% % % %%%% ¡title!
% % % MEASURE LINE
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.ST_TITLE
% % % %%%% ¡title!
% % % TITLE
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.ST_XLABEL
% % % %%%% ¡title!
% % % X-LABEL
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.ST_YLABEL
% % % %%%% ¡title!
% % % Y-LABEL
% % % 
% % % %%% ¡prop!
% % % %%%% ¡id!
% % % ComparisonGroupPF_BU.NODES
% % % %%%% ¡title!
% % % NODES SELECTION

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal unilayer group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_BU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal unilayer group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_BU manages the basic functionalities to plot of a binodal unilayer group comparison figure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal unilayer group comparison figure.
%%%% ¡settings!
'ComparisonGroupPF_BU'

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal unilayer group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_BU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal unilayer group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_BU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal unilayer group comparison figure.
%%%% ¡default!
'ComparisonGroupPF_BU notes'

%%% ¡prop!
SETUP (query, empty) calculates the group comparison figure value and stores it.
%%%% ¡calculate!
x = pf.get('M').get('G').get('ALAYERTICKS');

nodes = pf.get('NODES');
y = cellfun(@(x) x(nodes(1), nodes(2)), pf.get('M').get('M'))';

pf.memorize('ST_LINE').set('X', x, 'Y', y)

if ~isempty(y)
    if isempty(x) 
        pf.memorize('ST_AREA').set('X', [1 1:1:length(y) length(y)], 'Y', [0 y 0])
    else
        pf.memorize('ST_AREA').set('X', [x(1) x x(end)], 'Y', [0 y 0])
    end
end

xlim = pf.get('H_AXES').get('XLim');
ylim = pf.get('H_AXES').get('YLim');
anodelabels = pf.get('M').get('G').get('ANODELABELS');
pf.get('ST_TITLE').set( ...
    'TXT', [pf.get('M').get('LABEL') ' ' anodelabels{nodes(1)} ' ' anodelabels{nodes(2)}], ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_XLABEL').set( ...
    'TXT', 'Layer', ...
    'X', .5 * (xlim(2) + xlim(1)), ...
    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
    'Z', 0 ...
    )
pf.get('ST_YLABEL').set( ...
	'TXT', 'Measure Value', ...
    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
    'Y', .5 * (ylim(2) + ylim(1)), ...
    'Z', 0 ...
    )

value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the binodal group comparison figure.
%%%% ¡default!
[1 1]
%%%% ¡postset!
pf.get('SETUP')
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[ComparisonGroupPF_BU.PARENT ComparisonGroupPF_BU.H ComparisonGroupPF_BU.ST_POSITION ComparisonGroupPF_BU.ST_AXIS ComparisonGroupPF_BU.M ComparisonGroupPF_BU.ST_AREA ComparisonGroupPF_BU.ST_LINE ComparisonGroupPF_BU.ST_TITLE ComparisonGroupPF_BU.ST_XLABEL ComparisonGroupPF_BU.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡parallel!
false
%%%% ¡code!
warning('off', [BRAPH2.STR ':ComparisonGroupPF_BU'])
assert(length(findall(0, 'type', 'figure')) == 5)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':ComparisonGroupPF_BU'])
