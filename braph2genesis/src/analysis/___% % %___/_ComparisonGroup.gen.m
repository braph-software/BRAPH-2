%% ¡header!
ComparisonGroup < Element (cp, group-based comparison results) contains the results of a group-based comparison.

%%% ¡description!
ComparisonGroup contains the results of a group-based comparison for a given measure.
Specifically, it contains the one-tailed and two-tailed p-values 
and the 95%% confidence interval.

%%% ¡seealso!
CompareGroup, AnalyzeGroup

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based comparison results.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based comparison results.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based comparison results.
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', cp, 'PROP', ComparisonGroup.NOTES, varargin{:});

%%% ¡prop!
MEASURE (data, string) is the measure class.

%%% ¡prop!
MEASURE_TEMPLATE (data, item) provides the measure parameters. 
%%%% ¡settings!
'Measure'

%%% ¡prop!
C (data, item) is the group-based comparison.
%%%% ¡settings!
'CompareGroup'

%%% ¡prop!
DIFF (result, cell) is the group comparison value.
%%%% ¡calculate!
if isempty(cp.diff)
    [cp.diff, cp.p1, cp.p2, cp.ci_lower, cp.ci_upper] = calculate_results(cp);
end
value = cp.diff;
%%%% ¡gui!
g = cp.get('C').get('A1').get('G');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.DIFF, varargin{:});

if Measure.is_global(measure)
    pr.set( ...
        'TAB_H', 3, ...
        'ROWNAME', '[]', ...
        'COLUMNNAME', '[]' ...
        )
elseif Measure.is_nodal(measure)
    bas = g.get('BAS');
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
    
    pr.set( ...
        'TAB_H', 40, ...
        'ROWNAME', rowname, ...
        'COLUMNNAME', '[]' ...
        )
elseif Measure.is_binodal(measure)
    bas = g.get('BAS');
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
    
    pr.set( ...
        'TAB_H', 40, ...
        'ROWNAME', rowname, ...
        'COLUMNNAME', rowname ...
        )
end

if g.layernumber() == 1
    pr.set( ...
        'XSLIDER', false, ...
        'YSLIDER', false ...
        )
else % multilayer
    if  Measure.is_superglobal(measure)
        if Graph.is_weighted(g)
            pr.set( ...
                'XSLIDER', false, ...
                'YSLIDER', false ...
                )
        else
            if isempty(g.get('LAYERTICKS'))
                ylayerlabels = PanelPropCell.getPropDefault('LAYERTICKS');
            else
                layerlabels = num2cell(g.get('LAYERTICKS'));
                if isa(g, "MultiplexBUD")
                    ylayerlabels = ['{' sprintf('''%d'' ', layerlabels{end:-1:1}) '}'];
                else
                    ylayerlabels = ['{' sprintf('''%.2f'' ', layerlabels{end:-1:1}) '}'];
                end
            end
            
            pr.set( ...
                'TAB_H', max(pr.get('TAB_H'), length(layerlabels)), ...
                'XSLIDER', false, ...
                'YSLIDER', true, ...
                'YSLIDERLABELS', ylayerlabels, ...
                'YSLIDERWIDTH', 5 ...
                )
        end
    elseif Measure.is_unilayer(measure)
        if isempty(g.get('LAYERLABELS'))
            % xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            % xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(pr.get('TAB_H'), g.layernumber()), ...
            'XSLIDER', false, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    elseif Measure.is_bilayer(measure)
        if isempty(g.get('LAYERLABELS'))
            xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(3 + pr.get('TAB_H'), 3 + g.layernumber()), ...
            'XSLIDER', true, ...
            'XSLIDERLABELS', xlayerlabels, ...
            'XSLIDERHEIGHT', 3, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    end
end

%%% ¡prop!
P1 (result, cell) is the one-tailed p-value.
%%%% ¡calculate!
if isempty(cp.p1)
    [cp.diff, cp.p1, cp.p2, cp.ci_lower, cp.ci_upper] = calculate_results(cp);
end
value = cp.p1;
%%%% ¡gui!
g = cp.get('C').get('A1').get('G');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.P1, varargin{:});

if Measure.is_global(measure)
    pr.set( ...
        'TAB_H', 3, ...
        'ROWNAME', '[]', ...
        'COLUMNNAME', '[]' ...
        )
elseif Measure.is_nodal(measure)
    bas = g.get('BAS');
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
    
    pr.set( ...
        'TAB_H', 40, ...
        'ROWNAME', rowname, ...
        'COLUMNNAME', '[]' ...
        )
elseif Measure.is_binodal(measure)
    bas = g.get('BAS');
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
    
    pr.set( ...
        'TAB_H', 40, ...
        'ROWNAME', rowname, ...
        'COLUMNNAME', rowname ...
        )
end

if g.layernumber() == 1
    pr.set( ...
        'XSLIDER', false, ...
        'YSLIDER', false ...
        )
else % multilayer
    if  Measure.is_superglobal(measure)
        if Graph.is_weighted(g)
            pr.set( ...
                'XSLIDER', false, ...
                'YSLIDER', false ...
                )
        else
            if isempty(g.get('LAYERTICKS'))
                ylayerlabels = PanelPropCell.getPropDefault('LAYERTICKS');
            else
                layerlabels = num2cell(g.get('LAYERTICKS'));
                if isa(g, "MultiplexBUD")
                    ylayerlabels = ['{' sprintf('''%d'' ', layerlabels{end:-1:1}) '}'];
                else
                    ylayerlabels = ['{' sprintf('''%.2f'' ', layerlabels{end:-1:1}) '}'];
                end
            end
            
            pr.set( ...
                'TAB_H', max(pr.get('TAB_H'), length(layerlabels)), ...
                'XSLIDER', false, ...
                'YSLIDER', true, ...
                'YSLIDERLABELS', ylayerlabels, ...
                'YSLIDERWIDTH', 5 ...
                )
        end
    elseif Measure.is_unilayer(measure)
        if isempty(g.get('LAYERLABELS'))
            % xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            % xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(pr.get('TAB_H'), g.layernumber()), ...
            'XSLIDER', false, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    elseif Measure.is_bilayer(measure)
        if isempty(g.get('LAYERLABELS'))
            xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(3 + pr.get('TAB_H'), 3 + g.layernumber()), ...
            'XSLIDER', true, ...
            'XSLIDERLABELS', xlayerlabels, ...
            'XSLIDERHEIGHT', 3, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    end
end

%%% ¡prop!
P2 (result, cell) is the two-tailed p-value.
%%%% ¡calculate!
if isempty(cp.p2)
    [cp.diff, cp.p1, cp.p2, cp.ci_lower, cp.ci_upper] = calculate_results(cp);
end
value = cp.p2;
%%%% ¡gui!
g = cp.get('C').get('A1').get('G');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.P2, varargin{:});

if Measure.is_global(measure)
    pr.set( ...
        'TAB_H', 3, ...
        'ROWNAME', '[]', ...
        'COLUMNNAME', '[]' ...
        )
elseif Measure.is_nodal(measure)
    bas = g.get('BAS');
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
    
    pr.set( ...
        'TAB_H', 40, ...
        'ROWNAME', rowname, ...
        'COLUMNNAME', '[]' ...
        )
elseif Measure.is_binodal(measure)
    bas = g.get('BAS');
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
    
    pr.set( ...
        'TAB_H', 40, ...
        'ROWNAME', rowname, ...
        'COLUMNNAME', rowname ...
        )
end

if g.layernumber() == 1
    pr.set( ...
        'XSLIDER', false, ...
        'YSLIDER', false ...
        )
else % multilayer
    if  Measure.is_superglobal(measure)
        if Graph.is_weighted(g)
            pr.set( ...
                'XSLIDER', false, ...
                'YSLIDER', false ...
                )
        else
            if isempty(g.get('LAYERTICKS'))
                ylayerlabels = PanelPropCell.getPropDefault('LAYERTICKS');
            else
                layerlabels = num2cell(g.get('LAYERTICKS'));
                if isa(g, "MultiplexBUD")
                    ylayerlabels = ['{' sprintf('''%d'' ', layerlabels{end:-1:1}) '}'];
                else
                    ylayerlabels = ['{' sprintf('''%.2f'' ', layerlabels{end:-1:1}) '}'];
                end
            end
            
            pr.set( ...
                'TAB_H', max(pr.get('TAB_H'), length(layerlabels)), ...
                'XSLIDER', false, ...
                'YSLIDER', true, ...
                'YSLIDERLABELS', ylayerlabels, ...
                'YSLIDERWIDTH', 5 ...
                )
        end
    elseif Measure.is_unilayer(measure)
        if isempty(g.get('LAYERLABELS'))
            % xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            % xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(pr.get('TAB_H'), g.layernumber()), ...
            'XSLIDER', false, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    elseif Measure.is_bilayer(measure)
        if isempty(g.get('LAYERLABELS'))
            xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(3 + pr.get('TAB_H'), 3 + g.layernumber()), ...
            'XSLIDER', true, ...
            'XSLIDERLABELS', xlayerlabels, ...
            'XSLIDERHEIGHT', 3, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    end
end

%%% ¡prop!
CIL (result, cell) is the lower value of the 95%% confidence interval.
%%%% ¡calculate!
if isempty(cp.ci_lower)
    [cp.diff, cp.p1, cp.p2, cp.ci_lower, cp.ci_upper] = calculate_results(cp);
end
value = cp.ci_lower;
%%%% ¡gui!
g = cp.get('C').get('A1').get('G');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.CIL, varargin{:});

if Measure.is_global(measure)
    pr.set( ...
        'TAB_H', 3, ...
        'ROWNAME', '[]', ...
        'COLUMNNAME', '[]' ...
        )
elseif Measure.is_nodal(measure)
    bas = g.get('BAS');
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
    
    pr.set( ...
        'TAB_H', 40, ...
        'ROWNAME', rowname, ...
        'COLUMNNAME', '[]' ...
        )
elseif Measure.is_binodal(measure)
    bas = g.get('BAS');
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
    
    pr.set( ...
        'TAB_H', 40, ...
        'ROWNAME', rowname, ...
        'COLUMNNAME', rowname ...
        )
end

if g.layernumber() == 1
    pr.set( ...
        'XSLIDER', false, ...
        'YSLIDER', false ...
        )
else % multilayer
    if  Measure.is_superglobal(measure)
        if Graph.is_weighted(g)
            pr.set( ...
                'XSLIDER', false, ...
                'YSLIDER', false ...
                )
        else
            if isempty(g.get('LAYERTICKS'))
                ylayerlabels = PanelPropCell.getPropDefault('LAYERTICKS');
            else
                layerlabels = num2cell(g.get('LAYERTICKS'));
                if isa(g, "MultiplexBUD")
                    ylayerlabels = ['{' sprintf('''%d'' ', layerlabels{end:-1:1}) '}'];
                else
                    ylayerlabels = ['{' sprintf('''%.2f'' ', layerlabels{end:-1:1}) '}'];
                end
            end
            
            pr.set( ...
                'TAB_H', max(pr.get('TAB_H'), length(layerlabels)), ...
                'XSLIDER', false, ...
                'YSLIDER', true, ...
                'YSLIDERLABELS', ylayerlabels, ...
                'YSLIDERWIDTH', 5 ...
                )
        end
    elseif Measure.is_unilayer(measure)
        if isempty(g.get('LAYERLABELS'))
            % xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            % xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(pr.get('TAB_H'), g.layernumber()), ...
            'XSLIDER', false, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    elseif Measure.is_bilayer(measure)
        if isempty(g.get('LAYERLABELS'))
            xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(3 + pr.get('TAB_H'), 3 + g.layernumber()), ...
            'XSLIDER', true, ...
            'XSLIDERLABELS', xlayerlabels, ...
            'XSLIDERHEIGHT', 3, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    end
end

%%% ¡prop!
CIU (result, cell) is the upper value of the 95%% confidence interval.
%%%% ¡calculate!
if isempty(cp.ci_upper)
    [cp.diff, cp.p1, cp.p2, cp.ci_lower, cp.ci_upper] = calculate_results(cp);
end
value = cp.ci_upper;
%%%% ¡gui!
g = cp.get('C').get('A1').get('G');
measure = cp.get('MEASURE');

pr = PanelPropCell('EL', cp, 'PROP', ComparisonGroup.CIU, varargin{:});

if Measure.is_global(measure)
    pr.set( ...
        'TAB_H', 3, ...
        'ROWNAME', '[]', ...
        'COLUMNNAME', '[]' ...
        )
elseif Measure.is_nodal(measure)
    bas = g.get('BAS');
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
    
    pr.set( ...
        'TAB_H', 40, ...
        'ROWNAME', rowname, ...
        'COLUMNNAME', '[]' ...
        )
elseif Measure.is_binodal(measure)
    bas = g.get('BAS');
    ba = bas{1};
    br_ids = ba.get('BR_DICT').getKeys();
    rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
    
    pr.set( ...
        'TAB_H', 40, ...
        'ROWNAME', rowname, ...
        'COLUMNNAME', rowname ...
        )
end

if g.layernumber() == 1
    pr.set( ...
        'XSLIDER', false, ...
        'YSLIDER', false ...
        )
else % multilayer
    if  Measure.is_superglobal(measure)
        if Graph.is_weighted(g)
            pr.set( ...
                'XSLIDER', false, ...
                'YSLIDER', false ...
                )
        else
            if isempty(g.get('LAYERTICKS'))
                ylayerlabels = PanelPropCell.getPropDefault('LAYERTICKS');
            else
                layerlabels = num2cell(g.get('LAYERTICKS'));
                if isa(g, "MultiplexBUD")
                    ylayerlabels = ['{' sprintf('''%d'' ', layerlabels{end:-1:1}) '}'];
                else
                    ylayerlabels = ['{' sprintf('''%.2f'' ', layerlabels{end:-1:1}) '}'];
                end
            end
            
            pr.set( ...
                'TAB_H', max(pr.get('TAB_H'), length(layerlabels)), ...
                'XSLIDER', false, ...
                'YSLIDER', true, ...
                'YSLIDERLABELS', ylayerlabels, ...
                'YSLIDERWIDTH', 5 ...
                )
        end
    elseif Measure.is_unilayer(measure)
        if isempty(g.get('LAYERLABELS'))
            % xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            % xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(pr.get('TAB_H'), g.layernumber()), ...
            'XSLIDER', false, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    elseif Measure.is_bilayer(measure)
        if isempty(g.get('LAYERLABELS'))
            xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(3 + pr.get('TAB_H'), 3 + g.layernumber()), ...
            'XSLIDER', true, ...
            'XSLIDERLABELS', xlayerlabels, ...
            'XSLIDERHEIGHT', 3, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    end
end

%%% ¡prop!
QVALUE (metadata, scalar) is the selected qvalue threshold.
%%%% ¡default!
0.05
%%%% ¡gui!
pr = PPQValue('EL', cp, 'PROP', ComparisonGroup.QVALUE, varargin{:});

%%% ¡prop!
PFC (gui, item) contains the panel figure of the comparison.
%%%% ¡settings!
'PFComparisonGroup'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    if isa(cp.getr('PFC'), 'NoValue')
        measure = cp.get('MEASURE');
        g = cp.get('C').get('A1').get('G');
        
        if ~isempty(measure) && Measure.is_global(measure) && ...
                (Measure.is_unilayer(measure) || Measure.is_superglobal(measure))
            if (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Measure.is_unilayer(measure)
                cp.set('PFC', PFComparisonGroupMultiplexGU('CP', cp))
            else
                cp.set('PFC', PFComparisonGroupGU('CP', cp))
            end
        elseif ~isempty(measure) && Measure.is_nodal(measure) && ...
                (Measure.is_unilayer(measure) || Measure.is_superglobal(measure))
            if (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Measure.is_unilayer(measure)
                cp.set('PFC', PFComparisonGroupMultiplexNU('CP', cp))
            else
                cp.set('PFC', PFComparisonGroupNU('CP', cp))
            end
        elseif ~isempty(measure) && Measure.is_binodal(measure) && ...
                (Measure.is_unilayer(measure) || Measure.is_superglobal(measure))
            if (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Measure.is_unilayer(measure)
                cp.set('PFC', PFComparisonGroupMultiplexBU('CP', cp))
            else
                cp.set('PFC', PFComparisonGroupBU('CP', cp))
            end
        else
            cp.memorize('PFC').set('CP', cp)
        end
    end
end
%%%% ¡gui!
pr = PanelPropItem('EL', cp, 'PROP', ComparisonGroup.PFC, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

%%% ¡prop!
PFBG (gui, item) contains the panel figure of the brain graph.
%%%% ¡settings!
'PFBrainGraphComparison'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    if isa(cp.getr('PFBG'), 'NoValue')
        c = cp.get('C');
        g = c.get('A1').get('G');
        if ~isempty(g) && ~isa(g, 'NoValue')
            if Graph.is_graph(g) % graph
                ba_list = g.get('BAS');
                if ~isempty(ba_list)
                    cp.memorize('PFBG').set('ME', cp, 'BA', ba_list{1})
                else
                    cp.memorize('PFBG').set('ME', cp);
                end
                
            elseif Graph.is_multigraph(g) % multigraph BUD BUT
                ba_list = g.get('BAS');
                if ~isempty(ba_list)
                    cp.set('PFBG', PFBrainBinaryGraphComparison('ME', cp, 'BA', ba_list{1}));
                else
                    cp.set('PFBG', PFBrainBinaryGraphComparison('ME', cp));
                end
            elseif (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Graph.is_weighted(g) % multiplexWU
                ba_list = g.get('BAS');
                if ~isempty(ba_list)
                    cp.set('PFBG', PFBrainMultiplexGraphComparison('ME', cp, 'BA', ba_list{1}));
                else
                    cp.set('PFBG', PFBrainMultiplexGraphComparison('ME', cp));
                end
            elseif (Graph.is_multiplex(g) || Graph.is_ordered_multiplex(g)) && Graph.is_binary(g)
                ba_list = g.get('BAS');
                if ~isempty(ba_list)
                    cp.set('PFBG', PFBrainMultiplexBinaryGraphComparison('ME', cp, 'BA', ba_list{1}));
                else
                    cp.set('PFBG', PFBrainMultiplexBinaryGraphComparison('ME', cp));
                end
            end
                
        else
            m.memorize('PFBG').set('ME', m)
        end
    end
end
%%%% ¡gui!
pr = PanelPropItem('EL', cp, 'PROP', ComparisonGroup.PFBG, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

%% ¡properties!
diff
p1
p2
ci_lower
ci_upper

%% ¡methods!
function [diff, p1, p2, ci_lower, ci_upper] = calculate_results(cp)
    %CALCULATE_RESULTS calculates the comparison results.
    %
    % [DIFF, P1, P2, CIL, CIU] = CALCULATE_RESULTS(CP) calcultes the
    %  difference, the one-tailed p-value P1, the two-tailed p-value P2,
    %  the lower bound of the confidence interval CIL, and the the upper
    %  bound of the confidence interval. 
    %  Typically, this method is only called internally.

    measure_class = cp.get('MEASURE');
    if isempty(cp.get('MEASURE'))
        diff = {};
        p1 = {};
        p2 = {};
        ci_lower = {};
        ci_upper = {};
        return
    end
    
	% get parameters from example measure
    core_measure = cp.get('MEASURE_TEMPLATE');
    j = 1;
    varargin = {};
    if Measure.getPropNumber() ~= core_measure.getPropNumber()
        for i = Measure.getPropNumber() + 1:core_measure.getPropNumber()
            if ~isa(core_measure.getr(i), 'NoValue')
                varargin{j} = core_measure.getPropTag(i);
                varargin{j + 1} = Callback('EL', core_measure, 'PROP', i); % % % core_measure.getr(j);
            end
            j = j + 2;
        end
        varargin = varargin(~cellfun('isempty', varargin));
    end
    
    c = cp.get('C');

    wb = braph2waitbar(c.get('WAITBAR'), 0, ['Comparing group ' cp.get('MEASURE') '...']);

    % Measure for groups 1 and 2, and their difference
    m1 = c.get('A1').get('G').getMeasure(measure_class, varargin{:}).memorize('M');
    m2 = c.get('A2').get('G').getMeasure(measure_class, varargin{:}).memorize('M');
    diff = cellfun(@(x, y) y - x, m1, m2, 'UniformOutput', false);

    % Permutations
    P = c.get('P'); %#ok<*PROPLC>

    m1_perms = cell(1, P);
    m2_perms = cell(1, P);
    diff_perms = cell(1, P);

    start = tic;
    for j = 1:20:P
        parfor i = j:min(j+20, P)
            [a1_perm, a2_perm] = c.getPerm(i, c.get('MEMORIZE'));

            m1_perms{1, i} = a1_perm.memorize('G').getMeasure(measure_class).memorize('M');
            m2_perms{1, i} = a2_perm.memorize('G').getMeasure(measure_class).memorize('M');
            diff_perms{1, i} = cellfun(@(x, y) y - x, m1_perms{1, i}, m2_perms{1, i}, 'UniformOutput', false);
        end

        braph2waitbar(wb, j / P, ['Comparing group ' cp.get('MEASURE') '. Permutation ' num2str(j) ' of ' num2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's ...'])
        if c.get('VERBOSE')
            disp(['** PERMUTATION TEST - sampling #' int2str(j) '/' int2str(P) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start), 1) * 10) 's'])
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
end