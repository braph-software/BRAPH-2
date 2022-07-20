%% ¡header!
PFConfusionMatrix < PanelFig (pf, panel figure confusion matrix) is a plot of a confusion matrix.

%%% ¡description!
% % % PFBrainSurface manages the plot of the brain surface choosen by the user. 
% % % A collection of brain surfaces in NV format can be found in the folder 
% % % ./braph2/brainsurfs/.
% % % This class provides the common methods needed to manage the plot of 
% % % the surface. In particualr, the user can change lighting, material, 
% % % camlight, shadning, colormap, facecolor, brain color, face color, 
% % % edge color, and background color. 

%%% ¡seealso!
PanelFig, NNEvaluator

%% ¡properties!
p  % handle for panel
h_heatmap % shown matrix

%% ¡props!

%%% ¡prop!
NNE (metadata, item) is the NN evaluator.
%%%% ¡settings!
'NNEvaluator'

%%% ¡prop!
CF (metadata, matrix) 

%% ¡methods!
function p_out = draw(pf, varargin)
    %DRAW draws the measure graphical panel.
    %
    % DRAW(NNE) draws the measure graphical panel.
    %
    % P = DRAW(NNE) returns a handle to the measure graphical panel.
    %
    % DRAW(NNE, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain atlas graphical panel P.
    %
    % see also settings, uipanel.

    pf.p = draw@PanelFig(pf, varargin{:});
    
    pf.set('CF', pf.memorize('NNE').memorize('CONFUSION_MATRIX'));

    % draw the heatmap
    if isempty(pf.h_heatmap) || ~check_graphics(pf.h_heatmap)
        cf = pf.get('CF');

        % get ground truth
        gr = pf.get('NNE').get('GR_PREDICTION');
        classes = categories(categorical(cellfun(@(x) x.get('TARGET_NAME'), gr.get('SUB_DICT').getItems(), 'UniformOutput', false)));

        pf.h_heatmap = heatmap(classes, classes, cf, ...
            'Parent', pf.p);
    end
    
    % output
    if nargout > 0
        p_out = pf.p;
    end
end
function str = tostring(pf, varargin)
    %TOSTRING string with information about the measure.
    %
    % STR = TOSTRING(PF) returns a string with information about the measure.
    %
    % STR = TOSTRING(PF, N) trims the string to the first N characters.
    %
    % STR = TOSTRING(PF, N, ENDING) ends the string with ENDING if it has
    %  been trimmed.
    %
    % See also disp, tree.

    str = ['Plot ' pf.get('NNE').get('ID')];
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end

