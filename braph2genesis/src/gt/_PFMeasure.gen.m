%% ¡header!
PFMeasure < PanelFig (pf, panel figure measure) is a plot of a measure.

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

%% ¡props!

%%% ¡prop!
M (metadata, item) is the measure.
%%%% ¡settings!
'Measure'

%% ¡methods!
function p_out = draw(m, varargin)
    %DRAW draws the measure graphical panel.
    %
    % DRAW(PL) draws the measure graphical panel.
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

    m.p = draw@PanelFig(m, varargin{:});

% % % if Measure.is_global(m)
% % %     pr.set( ...
% % %         'TAB_H', 3, ...
% % %         'ROWNAME', '[]', ...
% % %         'COLUMNNAME', '[]' ...
% % %         )
% % % elseif Measure.is_nodal(m)
% % %     bas = g.get('BAS');
% % %     ba = bas{1};
% % %     br_ids = ba.get('BR_DICT').getKeys();
% % %     rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
% % %     
% % %     pr.set( ...
% % %         'TAB_H', 40, ...
% % %         'ROWNAME', rowname, ...
% % %         'COLUMNNAME', '[]' ...
% % %         )
% % % elseif Measure.is_binodal(m)
% % %     bas = m.get('G').get('BAS');
% % %     ba = bas{1};
% % %     br_ids = ba.get('BR_DICT').getKeys();
% % %     rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
% % %     
% % %     pr.set( ...
% % %         'TAB_H', 40, ...
% % %         'ROWNAME', rowname, ...
% % %         'COLUMNNAME', rowname ...
% % %         )
% % % end
% % % 
% % % if g.layernumber() == 1
% % %     pr.set( ...
% % %         'XSLIDER', false, ...
% % %         'YSLIDER', false ...
% % %         )
% % % else % multilayer
% % %     if  Measure.is_superglobal(m)
% % %         pr.set( ...
% % %             'XSLIDER', false, ...
% % %             'YSLIDER', false ...
% % %             )
% % %     elseif Measure.is_unilayer(m)
% % %         if isempty(g.get('LAYERLABELS'))
% % %             % xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
% % %             ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
% % %         else
% % %             layerlabels = str2cell(g.get('LAYERLABELS'));
% % %             % xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
% % %             ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
% % %         end
% % %         
% % %         pr.set( ...
% % %             'TAB_H', max(pr.get('TAB_H'), g.layernumber()), ...
% % %             'XSLIDER', false, ...
% % %             'YSLIDER', true, ...
% % %             'YSLIDERLABELS', ylayerlabels, ...
% % %             'YSLIDERWIDTH', 5 ...
% % %             )
% % %     elseif Measure.is_bilayer(m)
% % %         if isempty(g.get('LAYERLABELS'))
% % %             xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
% % %             ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
% % %         else
% % %             layerlabels = str2cell(g.get('LAYERLABELS'));
% % %             xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
% % %             ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
% % %         end
% % %         
% % %         pr.set( ...
% % %             'TAB_H', max(3 + pr.get('TAB_H'), 3 + g.layernumber()), ...
% % %             'XSLIDER', true, ...
% % %             'XSLIDERLABELS', xlayerlabels, ...
% % %             'XSLIDERHEIGHT', 3, ...
% % %             'YSLIDER', true, ...
% % %             'YSLIDERLABELS', ylayerlabels, ...
% % %             'YSLIDERWIDTH', 5 ...
% % %             )
% % %     end
% % % end
    
    % output
    if nargout > 0
        p_out = m.p;
    end
end
function str = tostring(m, varargin)
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

    str = ['Plot ' m.get('ID')];
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end