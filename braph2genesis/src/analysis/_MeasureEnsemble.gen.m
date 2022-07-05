%% ¡header!
MeasureEnsemble < Element (me, graph ensemble measure) is a graph ensemble measure.

%%% ¡description!
Measure provides the methods necessary for a graph ensemble measure.

%%% ¡seealso!
AnalyzeEnsemble, CompareEnsemble

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the graph ensemble measure.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph ensemble measure.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph ensemble measure.
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', me, 'PROP', MeasureEnsemble.NOTES, varargin{:});

%%% ¡prop!
MEASURE (data, string) is the measure class.

%%% ¡prop!
MEASURE_TEMPLATE (data, item) provides the measure parameters. 
%%%% ¡settings!
'Measure'

%%% ¡prop!
A (data, item) is the ensemble-based graph analysis.
%%%% ¡settings!
'AnalyzeEnsemble'

%%% ¡prop!
M (result, cell) is the measure result.
%%%% ¡calculate!
core_measure = me.get('MEASURE_TEMPLATE');
% get parameters from core measure
j = 1;
varargin = {};
if Measure.getPropNumber() ~= core_measure.getPropNumber()
    for i = Measure.getPropNumber() + 1:core_measure.getPropNumber()
        if ~isa(core_measure.getr(i), 'NoValue')
            varargin{j} = core_measure.getPropTag(i);
            varargin{j + 1} = core_measure.getr(i);
        end
        j = j + 2;
    end
    varargin = varargin(~cellfun('isempty', varargin));
end

m_list = cellfun(@(x) x.getMeasure(me.get('MEASURE'), varargin{:}).get('M'), me.get('A').get('G_DICT').getItems, 'UniformOutput', false);

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
%%%% ¡gui_!
% % % g = m.get('G');
% % % 
% % % pr = PanelPropCell('EL', m, 'PROP', Measure.M, varargin{:});
% % % 
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

%%% ¡prop!
PFM (gui, item) contains the panel figure of the measure.
%%%% ¡settings_!
'PFMeasureEnsemble'
%%%% ¡postprocessing_!
% % % if ~braph2_testing % to avoid problems with isqual when the element is recursive
% % %     if isa(m.getr('PFM'), 'NoValue')
% % %         if Measure.is_global(m) && Measure.is_unilayer(m)
% % %             m.set('PFM', PFMeasureGU('M', m))
% % %         elseif Measure.is_nodal(m) && Measure.is_unilayer(m)
% % %             m.set('PFM', PFMeasureNU('M', m))
% % %         elseif Measure.is_binodal(m) && Measure.is_unilayer(m)
% % %             m.set('PFM', PFMeasureBU('M', m))
% % %         else
% % %             m.memorize('PFM').set('M', m)
% % %         end
% % %     end
% % % end
% % % %%%% ¡gui!
% % % pr = PanelPropItem('EL', m, 'PROP', Measure.PFM, ...
% % %     'GUICLASS', 'GUIFig', ...
% % %     varargin{:});