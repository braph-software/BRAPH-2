close all
clear all %#ok<CLALL>

el_class = 'SettingsGraph';
delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
test_code = ['test_' el_class]
eval(test_code)

% el_class = 'PlotElement';
% delete([fileparts(which('braph2')) '/src/gui/' el_class '.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% create_test_Element([fileparts(which('braph2genesis')) '/src/gui/_' el_class '.gen.m'], [fileparts(which('braph2')) '/src/gui'])
% test_code = ['test_' el_class]
% eval(test_code)


% create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% 
% pip = load('pip_tmp.b2', '-mat').el;
% gui = GUI('PE', pip, 'CLOSEREQ', false);
% gui.draw()
% 
% %% archived codes
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/PlotElement.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotElement.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotElement.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % create_test_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotElement.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % test_PlotElement
% 
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/PlotPropString.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropString.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropString.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% 
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/GUI.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_GUI.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_GUI.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% 
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/cohort/PPGroup_SUBDict.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/cohort/_PPGroup_SUBDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/cohort')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/cohort/_PPGroup_SUBDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/cohort')
% 
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/atlas/PPBrainAtlas_Surf.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/atlas/_PPBrainAtlas_Surf.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/atlas')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/atlas/_PPBrainAtlas_Surf.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/atlas')
% 
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/PPPipeline_PSDict.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% 
% % lf = load('pip_c.b2', '-mat');
% % pip = lf.el;
% 
% % gui = GUI( ...
% %     'PE', pip, ...
% %     'MENU_FILE', false, ...
% %     'MENU_IMPORT', false, ...
% %     'MENU_EXPORT', false, ...
% %     'MENU_PERSONALIZE', false, ...
% %     'MENU_ABOUT', false, ...
% %     'TOOL_FIG', true, ...
% %     'CLOSEREQ', false ...
% %     );
% % gui = GUI( ...
% %     'PE', pip, ...
% %     'CLOSEREQ', false ...
% %     );
% % gui.draw()
% 
% % % % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/PPPipeline_PSDict.m')
% % % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % 
% % % lf = load('pip_c.b2', '-mat');
% % % pip = lf.el;
% % % 
% % % % im = ImporterPipelineBRAPH2(...
% % % %     'FILE', [fileparts(which('SubjectST')) filesep 'pipeline_structural_comparison_wu.braph2'], ...
% % % %     'WAITBAR', false ...
% % % %     ); 
% % % % pip = im.get('PIP');
% % % 
% % % gui = GUI('PE', pip, 'CLOSEREQ', false);
% % % gui.draw()
% 
% % load('tmp_pip.mat')
% % 
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropString.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropText.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_Pipeline.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % im = ImporterPipelineBRAPH2(...
% % %     'FILE', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/structural/pipeline_structural_analysis_wu.braph2', ...
% % %     'WAITBAR', false ...
% % %     ); 
% % % im = ImporterPipelineBRAPH2(...
% % %     'FILE', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/structural/pipeline_structural_comparison_wu.braph2', ...
% % %     'WAITBAR', false ...
% % %     ); 
% % % pip = im.get('PIP');
% % 
% % GUI(pip)
% % 
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_Pipeline.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_ImporterPipelineBRAPH2.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_ExporterPipelineBRAPH2.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% 
% % im = ImporterPipelineBRAPH2(...
% %     'FILE', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/structural/pipeline_structural_comparison_wu.braph2', ...
% %     'WAITBAR', true ...
% %     ); 
% % pip = im.get('PIP');
% % % pip.tree(4)
% % 
% % ex= ExporterPipelineBRAPH2( ...
% %     'PIP', pip, ...
% %     'WAITBAR', true ...
% %     );
% % ex.get('SAVE');
% 
% % % braph2
% % % 
% % % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/connectivity/PPSubjectCON_CON.m')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/pipelines/connectivity/_PPSubjectCON_CON.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/connectivity')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/pipelines/connectivity/_PPSubjectCON_CON.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/connectivity')
% 
% % gui1 = GUI('PE', ba, 'CLOSEREQ', false);
% % gui1.draw()
% 
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/cohort/PPGroup_SUBDict.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/cohort/_PPGroup_SUBDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/cohort')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/cohort/_PPGroup_SUBDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/cohort')
% % 
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/structural/PPSubjectST_ST.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/pipelines/structural/_PPSubjectST_ST.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/structural')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/pipelines/structural/_PPSubjectST_ST.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/structural')
% 
% % braph2genesis
% % 
% % gr = ImporterGroupSubjectST_XLS( ...
% %     'FILE', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/pipelines/structural/example data ST (MRI)/xls/ST_group1.xlsx', ...
% %     'WAITBAR', true ...
% %     ).get('GR');
% % gui2 = GUI('PE', gr, 'CLOSEREQ', false);
% % gui2.draw();
% 
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/GUI.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_GUI.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_GUI.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % 
% % et = ETA();
% % gui = GUI('PE', et, 'CLOSEREQ', false);
% % gui.draw()
% % 
% % gui.set('NAME', 'new name', 'POSITION', [.5 .5 .5 .5]).draw()
% 
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/Plot.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_Plot.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/PlotProp.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotProp.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/PlotElement.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotElement.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% 
% % braph2genesis
% % 
% % et = ETA();
% % pe = PlotElement('EL', et);
% % pp = pe.draw();
% % 
% % get(pp, 'UserData')
% 
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropMatrix.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % 
% % figure('Units', 'normalized', 'Position', [0 .5 1 .5])
% % et = ETA( ...
% %     'PROP_MATRIX_M', rand(30, 5), ...
% %     'PROP_MATRIX_P', 3.14, ...
% %     'PROP_MATRIX_D', eye(6) ...
% %     );
% % props = [et.PROP_MATRIX_M et.PROP_MATRIX_P et.PROP_MATRIX_D et.PROP_MATRIX_R et.PROP_MATRIX_R_CALC];
% % for i = 1:1:length(props)
% %     pr{i} = PlotPropMatrix('EL', et, 'PROP', props(i));
% %     pr{i}.draw('BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)])
% %     pr{i}.update()
% %     pr{i}.redraw('X0', (i-1)/length(props) * Plot.w(gcf, 'characters'), ...
% %         'Width', 1/length(props) * Plot.w(gcf, 'characters'))
% % end
% % 
% % figure()
% % p = uipanel('Parent', gcf); % needed for the function refresh that is called when the result is calculated
% % set(gcf, 'SizeChangedFcn', 'pr_res.update(); pr_res.redraw();') % callback to update panel when figure is resized (in refresh)
% % et = ETA();
% % pr_res = PlotPropMatrix('EL', et, 'PROP', et.PROP_MATRIX_R_CALC);
% % pr_res.draw('Parent', p, 'BackgroundColor', [.8 .5 .2])
% % pr_res.update()
% % pr_res.redraw()
% 
% 
% % copydir('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/util', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/util')
% % 
% % test_get_and_remove_from_varargin
% 
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropScalar.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % 
% % % minimal working version for category RESULT
% % figure()
% % p = uipanel('Parent', gcf); % needed for the function refresh that is called when the result is calculated
% % set(gcf, 'SizeChangedFcn', 'pr_res.update()') % callback to update panel when figure is resized (in refresh)
% % et = ETA();
% % pr_res = PlotPropScalar('EL', et, 'PROP', et.PROP_SCALAR_R_CALC);
% % pr_res.draw('Parent', p, 'BackgroundColor', [.8 .5 .2])
% % pr_res.update()
% % pr_res.redraw()
% 
% % et = ETA();
% % props = [et.PROP_SCALAR_M et.PROP_SCALAR_P et.PROP_SCALAR_D et.PROP_SCALAR_R et.PROP_SCALAR_R_CALC];
% % for i = 1:1:length(props)
% %     pr{i} = PlotPropScalar('EL', et, 'PROP', props(i));
% %     pr{i}.draw('BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)])
% %     pr{i}.update()
% %     pr{i}.redraw('Y0', (length(props) - i)/length(props) * Plot.h(gcf, 'characters'))
% % end
% 
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_Plot.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % 
% % delete('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui/PlotProp.m')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotProp.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % 
% % % draws PlotProp's at once
% % figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
% % et1 = ETA();
% % for category = 1:1:Element.getCategoryNumber() + 1
% %     for format = 1:1:Element.getFormatNumber()
% %         prop = (category - 1) * Element.getFormatNumber() + format;
% %         pr{category, format} = PlotProp('EL', et1, 'PROP', prop);
% %         pr{category, format}.draw( ...
% %             'Units', 'normalized', ...
% %             'Position', [ ...
% %                 (category-1)/(Element.getCategoryNumber()+1) ...
% %                 1-format/Element.getFormatNumber() ...
% %                 .9/(Element.getCategoryNumber()+1) ...
% %                 .9/Element.getFormatNumber() ...
% %                 ], ...
% %             'BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1] ...
% %             )
% %         drawnow()
% %     end
% % end
% % close(gcf)
% % 
% % % draws PlotProp's with multiple calls to draw()
% % figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
% % et2 = ETA();
% % for category = 1:1:Element.getCategoryNumber() + 1
% %     for format = 1:1:Element.getFormatNumber()
% %         prop = (category - 1) * Element.getFormatNumber() + format;
% %         pr{category, format} = PlotProp('EL', et2, 'PROP', prop);
% %         pr{category, format}.draw()
% %         pr{category, format}.draw('Units', 'normalized')
% %         pr{category, format}.draw('Position', [ ...
% %                 (category-1)/(Element.getCategoryNumber()+1) ...
% %                 1-format/Element.getFormatNumber() ...
% %                 .9/(Element.getCategoryNumber()+1) ...
% %                 .9/Element.getFormatNumber() ...
% %                 ])
% %         pr{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])
% %         drawnow()
% %     end
% % end
% % close(gcf)
% % 
% % % calls redraw() to resize the property graphical panel and reposition its text
% % figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
% % drawnow() % to solve ensure the figure is stable under drawnow()
% % et3 = ETA();
% % for category = 1:1:Element.getCategoryNumber() + 1
% %     for format = 1:1:Element.getFormatNumber()
% %         prop = (category - 1) * Element.getFormatNumber() + format;
% %         pr{category, format} = PlotProp('EL', et3, 'PROP', prop);
% %         pr{category, format}.draw()
% %         pr{category, format}.draw('Units', 'normalized')
% %         pr{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])
% % 
% %         pr{category, format}.redraw( ...
% %             'X0', (category - 1) / (Element.getCategoryNumber() + 1) * Plot.w(gcf, 'characters'), ...
% %             'Y0', (1 - format / Element.getFormatNumber()) * Plot.h(gcf, 'characters'), ...
% %             'Width', .9 / (Element.getCategoryNumber() + 1) * Plot.w(gcf, 'characters'), ...
% %             'Height', .9 / Element.getFormatNumber() * Plot.h(gcf, 'characters') ...
% %             )
% %         drawnow()
% %     end
% % end
% % close(gcf)
% % 
% % % calls update() and redraw()
% % % note that it doesn't work because it needs to be used with PlotElement() and GUI()
% % figure('Color', 'w', 'Units', 'normalized', 'Position', [0 0 1 1])
% % drawnow() % to solve ensure the figure is stable under drawnow()
% % et3 = ETA();
% % for category = 1:1:Element.getCategoryNumber() + 1
% %     for format = 1:1:Element.getFormatNumber()
% %         prop = (category - 1) * Element.getFormatNumber() + format;
% %         pr{category, format} = PlotProp('EL', et3, 'PROP', prop);
% %         pr{category, format}.draw()
% %         pr{category, format}.draw('Units', 'normalized')
% %         pr{category, format}.draw('BackgroundColor', [format/Element.getFormatNumber() category/(Element.getCategoryNumber()+1)] * [1 .5 0; 0 .5 1])
% % 
% %         pr{category, format}.update()
% %         
% %         pr{category, format}.redraw( ...
% %             'X0', (category - 1) / (Element.getCategoryNumber() + 1) * Plot.w(gcf, 'characters'), ...
% %             'Y0', (1 - format / Element.getFormatNumber()) * Plot.h(gcf, 'characters'), ...
% %             'Width', .9 / (Element.getCategoryNumber() + 1) * Plot.w(gcf, 'characters'), ...
% %             'Height', .9 / Element.getFormatNumber() * Plot.h(gcf, 'characters') ...
% %             )
% %         drawnow()
% %     end
% % end
% % close(gcf)
% 
% 
% 
% % % figures occupying 4 quadrants of the screen
% % f_NW = figure( ...
% %     'Name', 'NW', ...
% %     'OuterPosition', [Plot.x0(0)+Plot.w(0)/4 Plot.h(0)/2 Plot.w(0)/4 Plot.h(0)/4] ...
% %     );
% % f_NE = figure( ...
% %     'Name', 'NE', ...
% %     'OuterPosition', [Plot.w(0)/2 Plot.h(0)/2 Plot.w(0)/4 Plot.h(0)/4] ...
% %     );
% % f_SW = figure( ...
% %     'Name', 'SW', ...
% %     'OuterPosition', [Plot.x0(0)+Plot.w(0)/4 Plot.y0(0)+Plot.h(0)/4 Plot.w(0)/4 Plot.h(0)/4] ...
% %     );
% % f_SE = figure( ...
% %     'Name', 'SE', ...
% %     'OuterPosition', [Plot.w(0)/2 Plot.y0(0)+Plot.h(0)/4 Plot.w(0)/4 Plot.h(0)/4] ...
% %     );
% % 
% % % panel in center of figure NW
% % pl_NW = Plot();
% % pl_NW.draw( ...
% %     'Parent', f_NW, ...
% %     'Units', 'normalized', ...
% %     'Position', [.25 .25 .50 .50], ...
% %     'BackgroundColor', [1 0 0] ...
% %     )
% % pl_NW.settings( ...
% %     'Color', [1 0 0] ...
% %     )
% % 
% % % panel in center of figure NE
% % % retrieving the panel and settings figure handles
% % pl_NE = Plot();
% % hp_NE = pl_NE.draw( ...
% %     'Parent', f_NE, ...
% %     'Units', 'normalized', ...
% %     'Position', [.25 .25 .50 .50], ...
% %     'BackgroundColor', [0 1 0] ...
% %     );
% % fs_NE = pl_NE.settings( ...
% %     'Color', [0 1 0], ...
% %     'Name', 'Renamed this settings figure', ...
% %     'Units', get(f_NE, 'Units'), ...
% %     'Position', [Plot.x0(f_NE) Plot.y0(f_NE) Plot.w(f_NE) Plot.h(f_NE)] ...
% %     );
% % 
% % % panel in center of figure SW
% % % note the misalignement of the settings figure
% % pl_SW = Plot();
% % pl_SW.draw( ...
% %     'Parent', f_SW, ...
% %     'Units', 'normalized', ...
% %     'Position', [.25 .25 .50 .50], ...
% %     'BackgroundColor', [0 0 1] ...
% %     );
% % pl_SW.settings( ...
% %     'Color', [0 0 1], ...
% %     'Position', [Plot.x0(f_SW, 'normalized')+Plot.w(f_SW, 'normalized')/4 Plot.y0(f_SW, 'normalized')+Plot.h(f_SW, 'normalized')/4 Plot.w(f_SW, 'normalized')/2 Plot.h(f_SW, 'normalized')/2] ...
% %     )
% % 
% % % panel in on top of figure SE
% % % note the alignement of the settings figure
% % pl_SE = Plot();
% % pl_SE.draw( ...
% %     'Parent', f_SE, ...
% %     'Units', 'normalized', ...
% %     'Position', [.25 .25 .50 .50], ...
% %     'BackgroundColor', 'w' ...
% %     );
% % pl_SE.settings( ...
% %     'Color', 'w', ...
% %     'OuterPosition', [Plot.x0(f_SE, 'normalized') Plot.y0(f_SE, 'normalized') Plot.w(f_SE, 'normalized') Plot.h(f_SE, 'normalized')] ...
% %     )
% % 
% % % close SE settings figure
% % pl_SE.cb_close_fs()
% % 
% % % bring to from NW settings figure
% % pl_NW.cb_bring_fs_to_front()
% % 
% % % close SE
% % close(f_SW)
% % 
% % % replot SW inside NW settings figure
% % pl_SW.draw( ...
% %     'Parent', pl_NW.settings(), ...
% %     'BackgroundColor', [0 0 1] ...
% %     )
% % pl_SW.settings()
% % 
% % close(f_NW)
% % close(f_NE)
% % close(f_SE)
% 
% 
% 
% 
% 
% 
% 
% 
% % load('tmp_pip.mat')
% % 
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropString.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PlotPropText.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_Pipeline.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_PPPipeline_PSDict.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % im = ImporterPipelineBRAPH2(...
% % %     'FILE', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/structural/pipeline_structural_analysis_wu.braph2', ...
% % %     'WAITBAR', false ...
% % %     ); 
% % % im = ImporterPipelineBRAPH2(...
% % %     'FILE', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/structural/pipeline_structural_comparison_wu.braph2', ...
% % %     'WAITBAR', false ...
% % %     ); 
% % % pip = im.get('PIP');
% % 
% % GUI(pip)
% % 
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_Pipeline.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_ImporterPipelineBRAPH2.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % create_Element('/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2genesis/src/gui/_ExporterPipelineBRAPH2.gen.m', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/src/gui')
% % % 
% % % im = ImporterPipelineBRAPH2(...
% % %     'FILE', '/Users/giovannivolpe/Documents/GitHub/Braph-2.0-Matlab/braph2/pipelines/structural/pipeline_structural_comparison_wu.braph2', ...
% % %     'WAITBAR', true ...
% % %     ); 
% % % pip = im.get('PIP');
% % % % pip.tree(4)
% % % 
% % % ex= ExporterPipelineBRAPH2( ...
% % %     'PL', pl, ...
% % %     'WAITBAR', true ...
% % %     );
% % % ex.get('SAVE');
% 
