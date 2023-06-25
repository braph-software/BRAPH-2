%% ¡header!
MeasureEnsemble < ConcreteElement (me, graph ensemble measure) is a graph ensemble measure.

%%% ¡description!
MeasureEnsemble provides the methods necessary for a graph ensemble measure.

%%% ¡seealso!
AnalyzeEnsemble, CompareEnsemble

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the graph ensemble measure.
%%%% ¡default!
'MeasureEnsemble'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph ensemble measure.
%%%% ¡default!
'MeasureEnsemble provides the methods necessary for a graph ensemble measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph ensemble measure.
%%%% ¡settings!
'MeasureEnsemble'

%%% ¡prop!
ID (data, string) is a few-letter code for the graph ensemble measure.
%%%% ¡default!
'MeasureEnsemble ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph ensemble measure.
%%%% ¡default!
'MeasureEnsemble label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph ensemble measure.
%%%% ¡default!
'MeasureEnsemble notes'

%% ¡props!

%%% ¡prop!
MEASURE (data, class) is the measure class.
%%%% ¡settings!
'Measure'

%%% ¡_prop!
% % % MEASURE_TEMPLATE (parameter, item) provides the measure parameters. 
% % % %%%% ¡settings!
% % % 'Measure'

%%% ¡prop!
A (data, item) is the ensemble-based graph analysis.
%%%% ¡settings!
'AnalyzeEnsemble'

%%% ¡prop!
M (result, cell) is the measure group-average result.
%%%% ¡calculate!
m_list = cellfun(@(x) x.get('MEASURE', me.get('MEASURE')).get('M'), me.get('A').get('G_DICT').get('IT_LIST'), 'UniformOutput', false);

if isempty(m_list)
    m_av = {};
else
    m_av = cell(size(m_list{1}));
    for i = 1:1:size(m_list{1}, 1)
        for j = 1:1:size(m_list{1}, 2)
            m_ij_list = cellfun(@(x) x{i, j}, m_list, 'UniformOutput', false);
            m_av{i, j} = mean(cat(ndims(m_ij_list{1}) + 1, m_ij_list{:}), ndims(m_ij_list{1}) + 1);
        end
    end
end

value = m_av;
%%%% ¡_gui!
% % % g = me.get('A').get('GRAPH_TEMPLATE');
% % % 
% % % pr = PanelPropCell('EL', me, 'PROP', MeasureEnsemble.M, varargin{:});
% % % 
% % % if Measure.is_global(me.get('MEASURE'))
% % %     pr.set( ...
% % %         'TAB_H', 3, ...
% % %         'ROWNAME', '[]', ...
% % %         'COLUMNNAME', '[]' ...
% % %         )
% % % elseif Measure.is_nodal(me.get('MEASURE'))
% % %     bas = g.get('BAS');
% % %     if ~isempty(bas)
% % %         ba = bas{1};
% % %         br_ids = ba.get('BR_DICT').getKeys();
% % %         rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
% % %         
% % %         pr.set( ...
% % %             'TAB_H', 40, ...
% % %             'ROWNAME', rowname, ...
% % %             'COLUMNNAME', '[]' ...
% % %             )
% % %     end
% % % elseif Measure.is_binodal(me.get('MEASURE'))
% % %     bas = g.get('BAS');
% % %     if ~isempty(bas)
% % %         ba = bas{1};
% % %         br_ids = ba.get('BR_DICT').getKeys();
% % %         rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
% % %         
% % %         pr.set( ...
% % %             'TAB_H', 40, ...
% % %             'ROWNAME', rowname, ...
% % %             'COLUMNNAME', rowname ...
% % %             )
% % %     end
% % % end
% % % 
% % % if g.layernumber() == 1
% % %     pr.set( ...
% % %         'XSLIDER', false, ...
% % %         'YSLIDER', false ...
% % %         )
% % % else % multilayer
% % %     if  Measure.is_superglobal(me.get('MEASURE'))
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
% % %     elseif Measure.is_unilayer(me.get('MEASURE'))
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
% % %     elseif Measure.is_bilayer(me.get('MEASURE'))
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
PFME (gui, item) contains the panel figure of the measure.
%%%% ¡_settings!
% % % 'PFMeasureEnsemble'
%%%% ¡_postprocessing!
% % % if ~braph2_testing % to avoid problems with isqual when the element is recursive
% % %     if isa(me.getr('PFME'), 'NoValue')
% % %         g_dict = me.memorize('a').memorize('g_dict');
% % %         if ~isempty(me.get('MEASURE')) && Measure.is_global(me.get('MEASURE')) && ...
% % %                 (Measure.is_unilayer(me.get('MEASURE')) || Measure.is_superglobal(me.get('MEASURE')))
% % %             g = g_dict.getItem(1);
% % %             if (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Measure.is_unilayer(me.get('MEASURE')) 
% % %                 me.set('PFME', PFMeasureEnsembleMultiplexGU('ME', me))
% % %             else
% % %                 me.set('PFME', PFMeasureEnsembleGU('ME', me))
% % %             end
% % %         elseif ~isempty(me.get('MEASURE')) && Measure.is_nodal(me.get('MEASURE')) && ...
% % %                 (Measure.is_unilayer(me.get('MEASURE')) || Measure.is_superglobal(me.get('MEASURE')))
% % %             g = g_dict.getItem(1);
% % %             if (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Measure.is_unilayer(me.get('MEASURE'))
% % %                 me.set('PFME', PFMeasureEnsembleMultiplexNU('ME', me))
% % %             else
% % %                 me.set('PFME', PFMeasureEnsembleNU('ME', me))
% % %             end
% % %         elseif ~isempty(me.get('MEASURE')) && Measure.is_binodal(me.get('MEASURE')) && ...
% % %                 (Measure.is_unilayer(me.get('MEASURE')) || Measure.is_superglobal(me.get('MEASURE')))
% % %             g = g_dict.getItem(1);
% % %             if (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Measure.is_unilayer(me.get('MEASURE'))
% % %                 me.set('PFME', PFMeasureEnsembleMultiplexBU('ME', me))
% % %             else
% % %                 me.set('PFME', PFMeasureEnsembleBU('ME', me))
% % %             end
% % %         else
% % %             me.memorize('PFME').set('ME', me)
% % %         end
% % %     end
% % % end
%%%% ¡_gui!
% % % pr = PanelPropItem('EL', me, 'PROP', MeasureEnsemble.PFME, ...
% % %     'GUICLASS', 'GUIFig', ...
% % %     varargin{:});

%%% ¡prop!
PFBG (gui, item) contains the panel figure of the brain graph.
%%%% ¡_settings!
% % % 'PFBrainGraph'
%%%% ¡_postprocessing!
% % % if ~braph2_testing % to avoid problems with isqual when the element is recursive
% % %     if isa(me.getr('PFBG'), 'NoValue')
% % %         g_dict = me.memorize('a').memorize('g_dict');
% % %         if ~isempty(g_dict) && ~isa(g_dict, 'NoValue') && g_dict.length >= 1
% % %             
% % %             g = g_dict.getItem(1);
% % %             if Graph.is_graph(g) % graph
% % %                 ba_list = g.memorize('BAS');
% % %                 if ~isempty(ba_list)
% % %                     me.memorize('PFBG').set('ME', me, 'BA', ba_list{1})
% % %                 else
% % %                     me.memorize('PFBG').set('ME', me);
% % %                 end
% % %                 
% % %             elseif Graph.is_multigraph(g) % multigraph BUD BUT
% % %                 ba_list = g.memorize('BAS');
% % %                 if ~isempty(ba_list)
% % %                     me.set('PFBG', PFBrainMultiGraph('ME', me, 'BA', ba_list{1}));
% % %                 else
% % %                     me.set('PFBG', PFBrainMultiGraph('ME', me));
% % %                 end
% % %             elseif (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Graph.is_weighted(g) % multiplexWU
% % %                 ba_list = g.memorize('BAS');
% % %                 if ~isempty(ba_list)
% % %                     me.set('PFBG', PFBrainMultiplexGraph('ME', me, 'BA', ba_list{1}));
% % %                 else
% % %                     me.set('PFBG', PFBrainMultiplexGraph('ME', me));
% % %                 end
% % %             elseif (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Graph.is_binary(g)
% % %                 ba_list = g.memorize('BAS');
% % %                 if ~isempty(ba_list)
% % %                     me.set('PFBG', PFBrainMultiplexBinaryGraph('ME', me, 'BA', ba_list{1}));
% % %                 else
% % %                     me.set('PFBG', PFBrainMultiplexBinaryGraph('ME', me));
% % %                 end
% % %             end
% % %                 
% % %         else
% % %             me.memorize('PFBG').set('ME', me)
% % %         end
% % %     end
% % % end
%%%% ¡_gui!
% % % pr = PanelPropItem('EL', me, 'PROP', MeasureEnsemble.PFBG, ...
% % %     'GUICLASS', 'GUIFig', ...
% % %     varargin{:});