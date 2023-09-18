%% ¡header!
ComparisonEnsemble < ConcreteElement (cp, ensemble-based comparison results) contains the results of an ensemble-based comparison.

%%% ¡description!
ComparisonEnsemble contains the results of an ensemble-based comparison for a given measure.
Specifically, it contains the one-tailed and two-tailed p-values 
and the 95%% confidence interval.

%%% ¡seealso!
CompareEnsemble, AnalyzeEnsemble

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the results of an ensemble-based comparison.
%%%% ¡default!
'ComparisonEnsemble'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the results of an ensemble-based comparison.
%%%% ¡default!
'ComparisonEnsemble contains the results of an ensemble-based comparison for a given measure. Specifically, it contains the one-tailed and two-tailed p-values and the 95%% confidence interval.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the results of an ensemble-based comparison.
%%%% ¡settings!
'ComparisonEnsemble'

%%% ¡prop!
ID (data, string) is a few-letter code for the results of an ensemble-based comparison.
%%%% ¡default!
'ComparisonEnsemble ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the results of an ensemble-based comparison.
%%%% ¡default!
'ComparisonEnsemble label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the results of an ensemble-based comparison.
%%%% ¡default!
'ComparisonEnsemble notes'

%% ¡props!

%%% ¡prop!
MEASURE (parameter, class) is the measure class.
%%%% ¡settings!
'Measure'

%%% ¡_prop!
% % % MEASURE_TEMPLATE (data, item) provides the measure parameters.
% % % %%%% ¡_settings!
% % % 'Measure'

%%% ¡prop!
C (data, item) is the ensemble-based comparison.
%%%% ¡settings!
'CompareEnsemble'

%%% ¡prop!
DIFF (result, cell) is the ensemble comparison value.
%%%% ¡calculate!
results = cp.memorize('CALCULATE_RESULTS');
value = results{1}; % diff
%%%% ¡_gui!
% % % g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
% % % measure = cp.get('MEASURE');
% % % 
% % % pr = PanelPropCell('EL', cp, 'PROP', ComparisonEnsemble.DIFF, varargin{:});
% % % 
% % % if Measure.is_global(measure)
% % %     pr.set( ...
% % %         'TAB_H', 3, ...
% % %         'ROWNAME', '[]', ...
% % %         'COLUMNNAME', '[]' ...
% % %         )
% % % elseif Measure.is_nodal(measure)
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
% % % elseif Measure.is_binodal(measure)
% % %     bas = g.get('BAS');
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
% % %     if  Measure.is_superglobal(measure)
% % %         if Graph.is_weighted(g)
% % %             pr.set( ...
% % %                 'XSLIDER', false, ...
% % %                 'YSLIDER', false ...
% % %                 )
% % %         else
% % %             if isempty(g.get('LAYERTICKS'))
% % %                 ylayerlabels = PanelPropCell.getPropDefault('LAYERTICKS');
% % %             else
% % %                 layerlabels = num2cell(g.get('LAYERTICKS'));
% % %                 if isa(g, "MultiplexBUD")
% % %                     ylayerlabels = ['{' sprintf('''%d'' ', layerlabels{end:-1:1}) '}'];
% % %                 else
% % %                     ylayerlabels = ['{' sprintf('''%.2f'' ', layerlabels{end:-1:1}) '}'];
% % %                 end
% % %             end
% % %             
% % %             pr.set( ...
% % %                 'TAB_H', max(pr.get('TAB_H'), length(layerlabels)), ...
% % %                 'XSLIDER', false, ...
% % %                 'YSLIDER', true, ...
% % %                 'YSLIDERLABELS', ylayerlabels, ...
% % %                 'YSLIDERWIDTH', 5 ...
% % %                 )
% % %         end
% % %     elseif Measure.is_unilayer(measure)
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
% % %     elseif Measure.is_bilayer(measure)
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

%%% ¡prop!
P1 (result, cell) is the one-tailed p-value.
%%%% ¡calculate!
results = cp.memorize('CALCULATE_RESULTS');
value = results{2}; % p1
%%%% ¡_gui!
% % % g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
% % % measure = cp.get('MEASURE');
% % % 
% % % pr = PanelPropCell('EL', cp, 'PROP', ComparisonEnsemble.P1, varargin{:});
% % % 
% % % if Measure.is_global(measure)
% % %     pr.set( ...
% % %         'TAB_H', 3, ...
% % %         'ROWNAME', '[]', ...
% % %         'COLUMNNAME', '[]' ...
% % %         )
% % % elseif Measure.is_nodal(measure)
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
% % % elseif Measure.is_binodal(measure)
% % %     bas = g.get('BAS');
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
% % %     if  Measure.is_superglobal(measure)
% % %         if Graph.is_weighted(g)
% % %             pr.set( ...
% % %                 'XSLIDER', false, ...
% % %                 'YSLIDER', false ...
% % %                 )
% % %         else
% % %             if isempty(g.get('LAYERTICKS'))
% % %                 ylayerlabels = PanelPropCell.getPropDefault('LAYERTICKS');
% % %             else
% % %                 layerlabels = num2cell(g.get('LAYERTICKS'));
% % %                 if isa(g, "MultiplexBUD")
% % %                     ylayerlabels = ['{' sprintf('''%d'' ', layerlabels{end:-1:1}) '}'];
% % %                 else
% % %                     ylayerlabels = ['{' sprintf('''%.2f'' ', layerlabels{end:-1:1}) '}'];
% % %                 end
% % %             end
% % %             
% % %             pr.set( ...
% % %                 'TAB_H', max(pr.get('TAB_H'), length(layerlabels)), ...
% % %                 'XSLIDER', false, ...
% % %                 'YSLIDER', true, ...
% % %                 'YSLIDERLABELS', ylayerlabels, ...
% % %                 'YSLIDERWIDTH', 5 ...
% % %                 )
% % %         end
% % %     elseif Measure.is_unilayer(measure)
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
% % %     elseif Measure.is_bilayer(measure)
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

%%% ¡prop!
P2 (result, cell) is the two-tailed p-value.
%%%% ¡calculate!
results = cp.memorize('CALCULATE_RESULTS');
value = results{3}; % p2
%%%% ¡_gui!
% % % g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
% % % measure = cp.get('MEASURE');
% % % 
% % % pr = PanelPropCell('EL', cp, 'PROP', ComparisonEnsemble.P2, varargin{:});
% % % 
% % % if Measure.is_global(measure)
% % %     pr.set( ...
% % %         'TAB_H', 3, ...
% % %         'ROWNAME', '[]', ...
% % %         'COLUMNNAME', '[]' ...
% % %         )
% % % elseif Measure.is_nodal(measure)
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
% % % elseif Measure.is_binodal(measure)
% % %     bas = g.get('BAS');
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
% % %     if  Measure.is_superglobal(measure)
% % %         if Graph.is_weighted(g)
% % %             pr.set( ...
% % %                 'XSLIDER', false, ...
% % %                 'YSLIDER', false ...
% % %                 )
% % %         else
% % %             if isempty(g.get('LAYERTICKS'))
% % %                 ylayerlabels = PanelPropCell.getPropDefault('LAYERTICKS');
% % %             else
% % %                 layerlabels = num2cell(g.get('LAYERTICKS'));
% % %                 if isa(g, "MultiplexBUD")
% % %                     ylayerlabels = ['{' sprintf('''%d'' ', layerlabels{end:-1:1}) '}'];
% % %                 else
% % %                     ylayerlabels = ['{' sprintf('''%.2f'' ', layerlabels{end:-1:1}) '}'];
% % %                 end
% % %             end
% % %             
% % %             pr.set( ...
% % %                 'TAB_H', max(pr.get('TAB_H'), length(layerlabels)), ...
% % %                 'XSLIDER', false, ...
% % %                 'YSLIDER', true, ...
% % %                 'YSLIDERLABELS', ylayerlabels, ...
% % %                 'YSLIDERWIDTH', 5 ...
% % %                 )
% % %         end
% % %     elseif Measure.is_unilayer(measure)
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
% % %     elseif Measure.is_bilayer(measure)
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

%%% ¡prop!
CIL (result, cell) is the lower value of the 95%% confidence interval.
%%%% ¡calculate!
results = cp.memorize('CALCULATE_RESULTS');
value = results{4}; % ci_lower
%%%% ¡_gui!
% % % g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
% % % measure = cp.get('MEASURE');
% % % 
% % % pr = PanelPropCell('EL', cp, 'PROP', ComparisonEnsemble.CIL, varargin{:});
% % % 
% % % if Measure.is_global(measure)
% % %     pr.set( ...
% % %         'TAB_H', 3, ...
% % %         'ROWNAME', '[]', ...
% % %         'COLUMNNAME', '[]' ...
% % %         )
% % % elseif Measure.is_nodal(measure)
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
% % % elseif Measure.is_binodal(measure)
% % %     bas = g.get('BAS');
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
% % %     if  Measure.is_superglobal(measure)
% % %         if Graph.is_weighted(g)
% % %             pr.set( ...
% % %                 'XSLIDER', false, ...
% % %                 'YSLIDER', false ...
% % %                 )
% % %         else
% % %             if isempty(g.get('LAYERTICKS'))
% % %                 ylayerlabels = PanelPropCell.getPropDefault('LAYERTICKS');
% % %             else
% % %                 layerlabels = num2cell(g.get('LAYERTICKS'));
% % %                 if isa(g, "MultiplexBUD")
% % %                     ylayerlabels = ['{' sprintf('''%d'' ', layerlabels{end:-1:1}) '}'];
% % %                 else
% % %                     ylayerlabels = ['{' sprintf('''%.2f'' ', layerlabels{end:-1:1}) '}'];
% % %                 end
% % %             end
% % %             
% % %             pr.set( ...
% % %                 'TAB_H', max(pr.get('TAB_H'), length(layerlabels)), ...
% % %                 'XSLIDER', false, ...
% % %                 'YSLIDER', true, ...
% % %                 'YSLIDERLABELS', ylayerlabels, ...
% % %                 'YSLIDERWIDTH', 5 ...
% % %                 )
% % %         end
% % %     elseif Measure.is_unilayer(measure)
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
% % %     elseif Measure.is_bilayer(measure)
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

%%% ¡prop!
CIU (result, cell) is the upper value of the 95%% confidence interval.
%%%% ¡calculate!
results = cp.memorize('CALCULATE_RESULTS');
value = results{5}; % ci_upper
%%%% ¡_gui!
% % % g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
% % % measure = cp.get('MEASURE');
% % % 
% % % pr = PanelPropCell('EL', cp, 'PROP', ComparisonEnsemble.CIU, varargin{:});
% % % 
% % % if Measure.is_global(measure)
% % %     pr.set( ...
% % %         'TAB_H', 3, ...
% % %         'ROWNAME', '[]', ...
% % %         'COLUMNNAME', '[]' ...
% % %         )
% % % elseif Measure.is_nodal(measure)
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
% % % elseif Measure.is_binodal(measure)
% % %     bas = g.get('BAS');
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
% % %     if  Measure.is_superglobal(measure)
% % %         if Graph.is_weighted(g)
% % %             pr.set( ...
% % %                 'XSLIDER', false, ...
% % %                 'YSLIDER', false ...
% % %                 )
% % %         else
% % %             if isempty(g.get('LAYERTICKS'))
% % %                 ylayerlabels = PanelPropCell.getPropDefault('LAYERTICKS');
% % %             else
% % %                 layerlabels = num2cell(g.get('LAYERTICKS'));
% % %                 if isa(g, "MultiplexBUD")
% % %                     ylayerlabels = ['{' sprintf('''%d'' ', layerlabels{end:-1:1}) '}'];
% % %                 else
% % %                     ylayerlabels = ['{' sprintf('''%.2f'' ', layerlabels{end:-1:1}) '}'];
% % %                 end
% % %             end
% % %             
% % %             pr.set( ...
% % %                 'TAB_H', max(pr.get('TAB_H'), length(layerlabels)), ...
% % %                 'XSLIDER', false, ...
% % %                 'YSLIDER', true, ...
% % %                 'YSLIDERLABELS', ylayerlabels, ...
% % %                 'YSLIDERWIDTH', 5 ...
% % %                 )
% % %         end
% % %     elseif Measure.is_unilayer(measure)
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
% % %     elseif Measure.is_bilayer(measure)
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

%%% ¡prop!
QVALUE (metadata, scalar) is the selected qvalue threshold.
%%%% ¡default!
0.05
%%%% ¡_gui!
% % % pr = PPQValue('EL', cp, 'PROP', ComparisonEnsemble.QVALUE, varargin{:});

%%% ¡prop!
PFC (gui, item) contains the panel figure of the comparison.
%%%% ¡_settings!
% % % 'PFComparisonEnsemble'
%%%% ¡_postprocessing!
% % % if ~braph2_testing % to avoid problems with isqual when the element is recursive
% % %     if isa(cp.getr('PFC'), 'NoValue')
% % %         measure = cp.get('MEASURE');
% % %         g_dict = cp.get('C').get('A1').get('G_DICT');
% % %         
% % %         if ~isempty(measure) && ...
% % %                 ((Measure.is_global(measure) && Measure.is_unilayer(measure)) || ...
% % %                 (Measure.is_global(measure) && Measure.is_superglobal(measure)))
% % %             g = g_dict.getItem(1);
% % %             if (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Measure.is_unilayer(measure)
% % %                 cp.set('PFC', PFComparisonEnsembleMultiplexGU('CP', cp))
% % %             else
% % %                 cp.set('PFC', PFComparisonEnsembleGU('CP', cp))
% % %             end
% % %         elseif ~isempty(measure) && ...
% % %                 ((Measure.is_nodal(measure) && Measure.is_unilayer(measure)) || ...
% % %                 (Measure.is_nodal(measure) && Measure.is_superglobal(measure)))
% % %             g = g_dict.getItem(1);
% % %             if (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Measure.is_unilayer(measure)
% % %                 cp.set('PFC', PFComparisonEnsembleMultiplexNU('CP', cp))
% % %             else
% % %                 cp.set('PFC', PFComparisonEnsembleNU('CP', cp))
% % %             end
% % %         elseif ~isempty(measure) && ...
% % %                 ((Measure.is_binodal(measure) && Measure.is_unilayer(measure)) || ...
% % %                 (Measure.is_binodal(measure) && Measure.is_superglobal(measure)))
% % %             g = g_dict.getItem(1);
% % %             if (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Measure.is_unilayer(measure)
% % %                 cp.set('PFC', PFComparisonEnsembleMultiplexBU('CP', cp))
% % %             else
% % %                 cp.set('PFC', PFComparisonEnsembleBU('CP', cp))
% % %             end
% % %         else
% % %             cp.memorize('PFC').set('CP', cp)
% % %         end
% % %     end
% % % end
%%%% ¡_gui!
% % % pr = PanelPropItem('EL', cp, 'PROP', ComparisonEnsemble.PFC, ...
% % %     'GUICLASS', 'GUIFig', ...
% % %     varargin{:});

%%% ¡_prop!
PFBG (gui, item) contains the panel figure of the brain graph.
%%%% ¡_settings!
% % % 'PFBrainGraphComparison'
%%%% ¡_postprocessing!
% % % if ~braph2_testing % to avoid problems with isqual when the element is recursive
% % %     if isa(cp.getr('PFBG'), 'NoValue')
% % %         c = cp.get('C');
% % %         g_dict = c.get('A1').get('G_DICT');
% % %         if ~isempty(g_dict) && ~isa(g_dict, 'NoValue') && g_dict.length >= 1
% % %             g = g_dict.getItem(1);
% % %             if Graph.is_graph(g) % graph
% % %                 ba_list = g.get('BAS');
% % %                 if ~isempty(ba_list)
% % %                     cp.memorize('PFBG').set('ME', cp, 'BA', ba_list{1})
% % %                 else
% % %                     cp.memorize('PFBG').set('ME', cp);
% % %                 end
% % %                 
% % %             elseif Graph.is_multigraph(g) % multigraph BUD BUT
% % %                 ba_list = g.get('BAS');
% % %                 if ~isempty(ba_list)
% % %                     cp.set('PFBG', PFBrainBinaryGraphComparison('ME', cp, 'BA', ba_list{1}));
% % %                 else
% % %                     cp.set('PFBG', PFBrainBinaryGraphComparison('ME', cp));
% % %                 end
% % %             elseif (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Graph.is_weighted(g) % multiplexWU
% % %                 ba_list = g.get('BAS');
% % %                 if ~isempty(ba_list)
% % %                     cp.set('PFBG', PFBrainMultiplexGraphComparison('ME', cp, 'BA', ba_list{1}));
% % %                 else
% % %                     cp.set('PFBG', PFBrainMultiplexGraphComparison('ME', cp));
% % %                 end
% % %             elseif (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Graph.is_binary(g)
% % %                 ba_list = g.get('BAS');
% % %                 if ~isempty(ba_list)
% % %                     cp.set('PFBG', PFBrainMultiplexBinaryGraphComparison('ME', cp, 'BA', ba_list{1}));
% % %                 else
% % %                     cp.set('PFBG', PFBrainMultiplexBinaryGraphComparison('ME', cp));
% % %                 end
% % %             end 
% % %         else
% % %             m.memorize('PFBG').set('ME', m)
% % %         end
% % %     end
% % % end
%%%% ¡_gui!
% % % pr = PanelPropItem('EL', cp, 'PROP', ComparisonEnsemble.PFBG, ...
% % %     'GUICLASS', 'GUIFig', ...
% % %     varargin{:});

%%% ¡prop!
CALCULATE_RESULTS (evanescent, cell) calculates the comparison results {diff, p1, p2, ci_lower, ci_upper}.
%%%% ¡calculate!
% {DIFF, P1, P2, CIL, CIU} = cp.get('CALCULATE_RESULTS') calcultes the 
%  one-talied p-value P1, the two-tailed p-value P2, the lower bound of the 
%  confidence interval CIL, and the the upper bound of the confidence interval.
%  Typically, this methos is only called internally.

measure_class = cp.get('MEASURE');
if strcmpi(cp.get('MEASURE'), 'Measure')
    diff = {};
    p1 = {};
    p2 = {};
    ci_lower = {};
    ci_upper = {};
    value = {diff, p1, p2, ci_lower, ci_upper};
    return
end

c = cp.get('C');

wb = braph2waitbar(c.get('WAITBAR'), 0, ['Comparing ensemble ' cp.get('MEASURE') '...']);

% Pre-calculate and save measures of all subjects
ms1 = cellfun(@(x) x.get('MEASURE', measure_class, varargin{:}).memorize('M'), c.get('A1').memorize('G_DICT').get('IT_LIST'), 'UniformOutput', false);
ms2 = cellfun(@(x) x.get('MEASURE', measure_class, varargin{:}).memorize('M'), c.get('A2').memorize('G_DICT').get('IT_LIST'), 'UniformOutput', false);

% Measure for groups 1 and 2, and their difference
m1 = c.get('A1').get('MEASUREENSEMBLE', measure_class).memorize('M');
m2 = c.get('A2').get('MEASUREENSEMBLE', measure_class).memorize('M');
diff = cellfun(@(x, y) y - x, m1, m2, 'UniformOutput', false);

% Permutations
P = c.get('P'); %#ok<*PROPLC>

m1_perms = cell(1, P);
m2_perms = cell(1, P);
diff_perms = cell(1, P);

start = tic;
seeds = c.memorize('PERM_SEEDS');
for p = 1:20:P
    parfor q = p:min(p+20, P)
        % [a1_perm, a2_perm] = c.getPerm(i, memorize);
        % 
        % m1_perms{1, i} = a1_perm.getMeasureEnsemble(measure_class).memorize('M');
        % m2_perms{1, i} = a2_perm.getMeasureEnsemble(measure_class).memorize('M');
        % diff_perms{1, i} = cellfun(@(x, y) y - x, m1_perms{1, i}, m2_perms{1, i}, 'UniformOutput', false);

        rng(seeds(q), 'twister')

        [ms1_perm, ms2_perm] = permutation(ms1, ms2, c.get('LONGITUDINAL'));

        ms1_av = cell(size(ms1_perm{1}));
        ms2_av = cell(size(ms1_perm{1}));
        for i = 1:1:size(ms1_perm{1}, 1)
            for j = 1:1:size(ms1_perm{1}, 2)

                ms1_perm_ij = cellfun(@(x) x{i, j}, ms1_perm, 'UniformOutput', false);
                ms1_av{i, j} = mean(cat(ndims(ms1_perm_ij{1}) + 1, ms1_perm_ij{:}), ndims(ms1_perm_ij{1}) + 1);

                ms2_perm_ij = cellfun(@(x) x{i, j}, ms2_perm, 'UniformOutput', false);
                ms2_av{i, j} = mean(cat(ndims(ms2_perm_ij{1}) + 1, ms2_perm_ij{:}), ndims(ms2_perm_ij{1}) + 1);
            end
        end
        m1_perms{1, q} = ms1_av;
        m2_perms{1, q} = ms2_av;
        diff_perms{1, q} = cellfun(@(x, y) y - x, m1_perms{1, q}, m2_perms{1, q}, 'UniformOutput', false);
    end

    braph2waitbar(wb, p / P, ['Comparing group ' cp.get('MEASURE') '. Permutation ' num2str(p) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
    if c.get('VERBOSE')
        disp(['** PERMUTATION TEST - sampling #' int2str(p) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
    end
    if c.get('INTERRUPTIBLE')
        pause(c.get('INTERRUPTIBLE'))
    end
end

braph2waitbar(wb, 'close')

% Statistical analysis
p1 = cell(size(diff));
p2 = cell(size(diff));
ci_lower = cell(size(diff));
ci_upper = cell(size(diff));
for i = 1:1:size(diff, 1)
    for j = 1:1:size(diff, 2)
        p1(i, j) = pvalue1(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
        p2(i, j) = pvalue2(diff(i, j), cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false));
        qtl = quantiles(cellfun(@(x) x{i, j}, diff_perms, 'UniformOutput', false), 40);
        ci_lower(i, j) = {cellfun(@(x) x(2), qtl)};
        ci_upper(i, j) = {cellfun(@(x) x(40), qtl)};
	end
end

value = {diff, p1, p2, ci_lower, ci_upper};

%% ¡tests!

%%% ¡excluded_props!
[ComparisonEnsemble.CALCULATE_RESULTS]