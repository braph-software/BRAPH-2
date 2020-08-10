function GUIAnalysis(tmp, atlas)

%% General Constants
APPNAME = GUI.GA_NAME;
BUILD = BRAPH2.BUILD;

% Panels Dimensions
MARGIN_X = .01;
MARGIN_Y = .01;
LEFTCOLUMN_WIDTH = .19;
COHORT_HEIGHT = .12;
TAB_HEIGHT = .20;
FILENAME_HEIGHT = .02;

MAINPANEL_X0 = LEFTCOLUMN_WIDTH + 2 * MARGIN_X;
MAINPANEL_Y0 = FILENAME_HEIGHT + TAB_HEIGHT + 3 * MARGIN_Y;
MAINPANEL_WIDTH = 1 - LEFTCOLUMN_WIDTH - 3 * MARGIN_X;
MAINPANEL_HEIGHT = 1 - TAB_HEIGHT - FILENAME_HEIGHT - 4 * MARGIN_Y;
MAINPANEL_POSITION = [MAINPANEL_X0 MAINPANEL_Y0 MAINPANEL_WIDTH MAINPANEL_HEIGHT];

% Commands
OPEN_CMD = GUI.OPEN_CMD; 
OPEN_SC = GUI.OPEN_SC;
OPEN_TP = ['Open Analysis. Shortcut: ' GUI.ACCELERATOR '+' OPEN_SC];

SAVE_CMD = GUI.SAVE_CMD;
SAVE_SC = GUI.SAVE_SC;
SAVE_TP = ['Save current Analysis. Shortcut: ' GUI.ACCELERATOR '+' SAVE_SC];

SAVEAS_CMD = GUI.SAVEAS_CMD;

CLOSE_CMD = GUI.CLOSE_CMD;
CLOSE_SC = GUI.CLOSE_SC;

CLOSE_TP = ['Close ' APPNAME '. Shortcut: ' GUI.ACCELERATOR '+' CLOSE_SC];

%% Application Data
analysis_list = Analysis.getList();
if exist('tmp', 'var') && ismember(class(tmp), analysis_list) % pass an analysis
    ga = Analysis.getAnalysis(tmp);
    cohort = ga.getCohort();
elseif exist('tmp', 'var') && isa(tmp, 'Cohort') % pass a cohort
    % defaul will be WU
    subject_type = tmp.getSubjectClass();
    for i = 1:1:length(analysis_list)
        analysis = analysis_list{i};
        if isequal(Analysis.getSubjectClass(analysis), subject_type) && isequal(Analysis.getGraphType(analysis), 'GraphWU')
            ga = Analysis.getAnalysis(analysis, 'Empty GA', '', '', tmp, {}, {}, {});
        end        
    end    
    cohort = ga.getCohort();
else % string of analysis class
    % this is missing BUD and BUT options from start
     assert(ismember(tmp, analysis_list));
     assert(isa(atlas, 'BrainAtlas'));
     subject_type = Analysis.getSubjectClass(tmp);    
     for i = 1:1:length(analysis_list)
        analysis = analysis_list{i};
        if isequal(Analysis.getSubjectClass(analysis), subject_type) && isequal(Analysis.getGraphType(analysis), 'GraphWU')
            cohort = Cohort('Empty Cohort', 'cohort label', 'cohort notes', subject_type, atlas, {});
            ga = Analysis.getAnalysis(analysis, 'Empty GA', '', '', cohort, {}, {}, {}); %#ok<NASGU>
        end        
    end        
end

ui_popups_grouplists = [];

    function cb_open(~, ~)
        % select file
         [file,path,filterindex] = uigetfile(GUI.GA_EXTENSION, GUI.GA_MSG_GETFILE);
        % load file
        if filterindex
            filename = fullfile(path, file);
            temp = load(filename, '-mat', 'ga', 'BUILD');
            if isfield(temp, 'BUILD') && temp.BUILD >= 2020 && ...
                   isfield(temp, 'ga') && ...
                   ismember(temp.getClass(), analysis_list)
                ga = temp.ga;
                GUIAnalysis(ga)
            end
        end
    end
    function cb_save(~, ~)
        filename = get(ui_text_filename, 'String');
        if isempty(filename)
            cb_saveas();
        else
            save(filename, 'ga', 'cohort', 'BUILD');  % prob not cohort
        end
    end
    function cb_saveas(~, ~)
        % select file
        [file, path, filterindex] = uiputfile(GUI.GA_EXTENSION, GUI.GA_MSG_PUTFILE);
        % save file
        if filterindex
            filename = fullfile(path, file);
            save(filename, 'ga', 'BUILD');
            update_filename(filename)
        end
    end
    function update_popups_grouplist()
        if ga.getCohort().getGroups().length() > 0
            group_list = {};
            for g = 1:1:ga.getCohort().getGroups().length()
                group_list{g} = ga.getCohort().getGroups().getValue(g).getID(); %#ok<AGROW>
            end
        else
            group_list = {''};
        end
        set(ui_popups_grouplists, 'String', group_list)
    end

%% GUI Init
f = GUI.init_figure(APPNAME, .9, .9, 'center');
    function init_disable()
    end
    function init_enable()
    end

%% Text File Name
FILENAME_WIDTH = 1 - 2 * MARGIN_X;
FILENAME_POSITION = [MARGIN_X MARGIN_Y FILENAME_WIDTH FILENAME_HEIGHT];

ui_text_filename = uicontrol('Style', 'text');
init_filename()
    function init_filename()
        GUI.setUnits(ui_text_filename)
        GUI.setBackgroundColor(ui_text_filename)
        
        set(ui_text_filename, 'Position', FILENAME_POSITION)
        set(ui_text_filename, 'HorizontalAlignment', 'left')
    end
    function update_filename(filename)
        set(ui_text_filename, 'String', filename)
    end

%% Panel Cohort
COHORT_NAME = 'Cohort';
COHORT_WIDTH = LEFTCOLUMN_WIDTH;
COHORT_X0 = MARGIN_X;
COHORT_Y0 = 1 - MARGIN_Y - COHORT_HEIGHT;
COHORT_POSITION = [COHORT_X0 COHORT_Y0 COHORT_WIDTH COHORT_HEIGHT];

COHORT_BUTTON_SELECT_CMD = 'Select Cohort';
COHORT_BUTTON_SELECT_TP = 'Select file (*.cohort) from where to load a Cohort';

COHORT_BUTTON_VIEW_CMD = 'View Cohort';
COHORT_BUTTON_VIEW_TP = ['Open Cohort with ' GUI.CE_NAME '.'];

ui_panel_cohort = uipanel();
ui_text_cohort_name = uicontrol(ui_panel_cohort, 'Style', 'text');
ui_text_cohort_subjectnumber = uicontrol(ui_panel_cohort, 'Style', 'text');
ui_text_cohort_groupnumber = uicontrol(ui_panel_cohort, 'Style', 'text');
ui_button_cohort = uicontrol(ui_panel_cohort, 'Style', 'pushbutton');
init_cohort()
    function init_cohort()
        GUI.setUnits(ui_panel_cohort)
        GUI.setBackgroundColor(ui_panel_cohort)
        
        set(ui_panel_cohort, 'Position', COHORT_POSITION)
        set(ui_panel_cohort, 'Title', COHORT_NAME)
        
        set(ui_text_cohort_name, 'Position', [.05 .60 .50 .20])
        set(ui_text_cohort_name, 'HorizontalAlignment', 'left')
        set(ui_text_cohort_name, 'FontWeight', 'bold')
        
        set(ui_text_cohort_subjectnumber, 'Position', [.05 .40 .50 .20])
        set(ui_text_cohort_subjectnumber, 'HorizontalAlignment', 'left')
        
        set(ui_text_cohort_groupnumber, 'Position', [.05 .20 .50 .20])
        set(ui_text_cohort_groupnumber, 'HorizontalAlignment', 'left')
        
        set(ui_button_cohort, 'Position', [.55 .30 .40 .40])
        set(ui_button_cohort, 'Callback', {@cb_cohort})
    end
    function update_cohort()
        update_popups_grouplist()
        
        if ~isempty(cohort) && ~isequal(cohort.getID(), 'Empty Cohort')
            set(ui_text_cohort_name, 'String', cohort.getID())
            set(ui_text_cohort_subjectnumber, 'String', ['subject number = ' num2str(cohort.getSubjects().length())])
            set(ui_text_cohort_groupnumber, 'String', ['group number = ' num2str(cohort.getGroups().length())])
            set(ui_button_cohort, 'String', COHORT_BUTTON_VIEW_CMD)
            set(ui_button_cohort, 'TooltipString', COHORT_BUTTON_VIEW_TP);
            init_enable()
        else
            set(ui_text_cohort_name, 'String', '- - -')
            set(ui_text_cohort_subjectnumber, 'String', 'subject number = 0')
            set(ui_text_cohort_groupnumber, 'String', 'group number = 0')
            set(ui_button_cohort, 'String', COHORT_BUTTON_SELECT_CMD)
            set(ui_button_cohort, 'TooltipString', COHORT_BUTTON_SELECT_TP);
            init_disable()
        end
    end
    function cb_cohort(src, ~)  % (src,event)
        % missing BUD and BUT compatibility
        if strcmp(get(src, 'String'), COHORT_BUTTON_VIEW_CMD)
            GUICohort(ga.getCohort(), true)  % open atlas with restricted permissions
        else
            try
                % select file
                [file,path,filterindex] = uigetfile(GUI.CE_EXTENSION, GUI.CE_MSG_GETFILE);
                % load file
                if filterindex
                    filename = fullfile(path, file);
                    temp = load(filename, '-mat', 'cohort', 'selected_group', 'selected_subjects', 'BUILD');
                    if isfield(temp, 'BUILD') && temp.BUILD >= 2020 && ...
                            isfield(temp, 'cohort') && isa(temp.cohort, 'Cohort') && ...
                            isfield(temp, 'selected_group') && isfield(temp, 'selected_subjects')
                        cohort = temp.cohort;
                        for j = 1:1:length(analysis_list)
                            analysis = analysis_list{j};
                            if isequal(Analysis.getSubjectClass(analysis), subject_type) && isequal(Analysis.getGraphType(analysis), 'GraphWU')
                                ga = Analysis.getAnalysis(analysis, 'Empty GA', '', '', cohort, {}, {}, {}); 
                            end
                        end
                        setup()
                    end
                end
            catch
                errordlg('The file is not a valid Cohort file. Please load a valid .cohort file');
            end
        end
    end

%% Panel - Calc
CALC_WIDTH = LEFTCOLUMN_WIDTH;
CALC_HEIGHT = MAINPANEL_HEIGHT - COHORT_HEIGHT - MARGIN_Y;
CALC_X0 = MARGIN_X;
CALC_Y0 = FILENAME_HEIGHT + TAB_HEIGHT + 3 * MARGIN_Y;
CALC_POSITION = [CALC_X0 CALC_Y0 CALC_WIDTH CALC_HEIGHT];

CALC_BUTTON_CMD = 'Start analysis';
CALC_BUTTON_TP = 'Sets the correlation matrix and starts an analysis';
SBG_BUTTON_CMD = 'Subgraph analysis';
SBG_BUTTON_TP = 'Creates a subgraph for analysis';

EDIT_COMM_BUTTON_CMD = 'Edit';
EDIT_COMM_BUTTON_TP = 'Edit the community structure defined for a graph';
DEFAULT_COMM_BUTTON_CMD = 'Default';
DEFAULT_COMM_BUTTON_TP = 'Default/Discard community structure defined for a graph';

ui_panel_calc = uipanel();
ui_edit_calc_ganame = uicontrol(ui_panel_calc, 'Style', 'edit');

ui_popup_calc_corr = uicontrol(ui_panel_calc, 'Style', 'popup', 'String', {''});
ui_text_calc_corr = uicontrol(ui_panel_calc, 'Style', 'text');
ui_popup_calc_graph = uicontrol(ui_panel_calc, 'Style', 'popup', 'String', {''});
ui_text_calc_graph = uicontrol(ui_panel_calc, 'Style', 'text');
ui_popup_calc_neg = uicontrol(ui_panel_calc, 'Style', 'popup', 'String', {''});
ui_text_calc_neg = uicontrol(ui_panel_calc, 'Style', 'text');
ui_button_calc_set = uicontrol(ui_panel_calc, 'Style', 'pushbutton');
ui_button_calc_sub = uicontrol(ui_panel_calc, 'Style', 'pushbutton');

% ui_panel_community = uipanel(ui_panel_calc);
% ui_text_community_property = uicontrol(ui_panel_community, 'Style', 'text');
% ui_text_community_algorithm = uicontrol(ui_panel_community, 'Style', 'text');
% ui_text_community_gamma = uicontrol(ui_panel_community, 'Style', 'text');
% ui_text_community_number = uicontrol(ui_panel_community, 'Style', 'text');
% ui_button_community_edit = uicontrol(ui_panel_community, 'Style', 'pushbutton');
% ui_button_community_default = uicontrol(ui_panel_community, 'Style', 'pushbutton');

init_calc()
    function init_calc()
        GUI.setUnits(ui_panel_calc)
        GUI.setBackgroundColor(ui_panel_calc)
        
        set(ui_panel_calc, 'Position', CALC_POSITION)
        set(ui_panel_calc, 'BorderType', 'none')
        
        set(ui_edit_calc_ganame, 'Position', [.02 .95 .96 .04])
        set(ui_edit_calc_ganame, 'HorizontalAlignment', 'left')
        set(ui_edit_calc_ganame, 'FontWeight', 'bold')
        set(ui_edit_calc_ganame, 'Callback', {@cb_calc_ganame})
                
        set(ui_text_calc_graph, 'Position', [.02 .850 .30 .04])
        set(ui_text_calc_graph, 'String', 'Graph')
        set(ui_text_calc_graph, 'HorizontalAlignment', 'left')
        set(ui_text_calc_graph, 'FontWeight', 'bold')
        
        set(ui_popup_calc_graph, 'String', MRIGraphAnalysis.GRAPH_OPTIONS)
        set(ui_popup_calc_graph, 'Position', [.40 .860 .56 .04])
        set(ui_popup_calc_graph, 'TooltipString', 'Select a graph type');
        set(ui_popup_calc_graph, 'Callback', {@cb_calc_graph});
        
        set(ui_text_calc_corr, 'Position', [.02 .780 .30 .04])
        set(ui_text_calc_corr, 'String', 'Correlation')
        set(ui_text_calc_corr, 'HorizontalAlignment', 'left')
        set(ui_text_calc_corr, 'FontWeight', 'bold')
        
        set(ui_popup_calc_corr, 'String', MRIGraphAnalysis.CORR_OPTIONS)
        set(ui_popup_calc_corr, 'Position', [.40 .790 .56 .04])
        set(ui_popup_calc_corr, 'TooltipString', 'Select a matrix correlation');
        set(ui_popup_calc_corr, 'Callback', {@cb_calc_corr});
        
        set(ui_text_calc_neg, 'Position', [.02 .710 .30 .04])
        set(ui_text_calc_neg, 'String', 'Negative corrs.')
        set(ui_text_calc_neg, 'HorizontalAlignment', 'left')
        set(ui_text_calc_neg, 'FontWeight', 'bold')
        
        set(ui_popup_calc_neg, 'String', MRIGraphAnalysis.NEG_OPTIONS)
        set(ui_popup_calc_neg, 'Position', [.40 .720 .56 .04])
        set(ui_popup_calc_neg, 'TooltipString', 'Select a negative correlations handling');
        set(ui_popup_calc_neg, 'Callback', {@cb_calc_neg});
        
        set(ui_button_calc_set, 'Position', [.20 .02 .60 .08])
        set(ui_button_calc_set, 'String', CALC_BUTTON_CMD)
        set(ui_button_calc_set, 'TooltipString', CALC_BUTTON_TP)
        set(ui_button_calc_set, 'Callback', {@cb_calc_set})
        
        set(ui_button_calc_sub, 'Position', [.20 .12 .60 .08])
        set(ui_button_calc_sub, 'String', SBG_BUTTON_CMD)
        set(ui_button_calc_sub, 'TooltipString', SBG_BUTTON_TP)
        set(ui_button_calc_sub, 'Callback', {@cb_calc_sub})

%         set(ui_panel_community, 'Position',[.02 .30 0.96 0.30])
%         set(ui_panel_community, 'Title', 'Community structure')
%         GUI.setUnits(ui_panel_community)
%         GUI.setBackgroundColor(ui_panel_community)
%         
%         set(ui_text_community_property, 'Position',[.05 .75 .95 .20])
%         set(ui_text_community_property, 'HorizontalAlignment', 'left')
%         
%         set(ui_text_community_algorithm, 'Position',[.05 .65 .60 .10])
%         set(ui_text_community_algorithm, 'HorizontalAlignment', 'left')
%         
%         set(ui_text_community_gamma, 'Position',[.05 .5 .60 .10])
%         set(ui_text_community_gamma, 'HorizontalAlignment', 'left')
%         
%         set(ui_text_community_number, 'Position',[.05 .35 .60 .10])
%         set(ui_text_community_number, 'HorizontalAlignment', 'left')
%         
%         set(ui_button_community_edit, 'Position',[.05 .10 .40 .20])
%         set(ui_button_community_edit, 'Callback', {@cb_comm_edit})
%         set(ui_button_community_edit, 'String',EDIT_COMM_BUTTON_CMD)
%         set(ui_button_community_edit, 'TooltipString',EDIT_COMM_BUTTON_TP)
%         
%         set(ui_button_community_default, 'Position',[.55 .10 .40 .20])
%         set(ui_button_community_default, 'Callback', {@cb_comm_default})
%         set(ui_button_community_default, 'String',DEFAULT_COMM_BUTTON_CMD)
%         set(ui_button_community_default, 'TooltipString',DEFAULT_COMM_BUTTON_TP)
    end
    function update_calc_ganame()
        ganame = ga.getProp(MRICohort.NAME);
        if isempty(ganame)
            set(f, 'Name',[GUI.MGA_NAME ' - ' BNC.VERSION])
        else
            set(f, 'Name',[GUI.MGA_NAME ' - ' BNC.VERSION ' - ' ganame])
        end
        set(ui_edit_calc_ganame, 'String',ganame)
    end
    function update_calc()
        graph = get(ui_popup_calc_graph, 'Value');
        corr = get(ui_popup_calc_corr, 'Value');
        neg = get(ui_popup_calc_neg, 'Value');
        switch graph
            case 1  % weighted undirected
                ga = MRIGraphAnalysisWU(cohort,cs, ...
                    MRIGraphAnalysis.CORR, MRIGraphAnalysis.CORR_OPTIONS{corr}, ...
                    MRIGraphAnalysis.NEG, MRIGraphAnalysis.NEG_OPTIONS{neg} ...
                    );
            case 2  % binary undirected (fix threshold)
                ga = MRIGraphAnalysisBUT(cohort,cs, ...
                    MRIGraphAnalysis.CORR, MRIGraphAnalysis.CORR_OPTIONS{corr}, ...
                    MRIGraphAnalysis.NEG, MRIGraphAnalysis.NEG_OPTIONS{neg} ...
                    );
            otherwise  % binary undirected (fix density)
                ga = MRIGraphAnalysisBUD(cohort,cs, ...
                    MRIGraphAnalysis.CORR, MRIGraphAnalysis.CORR_OPTIONS{corr}, ...
                    MRIGraphAnalysis.NEG, MRIGraphAnalysis.NEG_OPTIONS{neg} ...
                    );
        end
    end
    function cb_calc_ganame(~,~)  % (src,event)
        ga.setProp(MRIGraphAnalysis.NAME,get(ui_edit_calc_ganame, 'String'));
        update_calc_ganame()
    end
    function cb_calc_graph(~,~)  %  (src,event)
        update_calc()
        update_tab()
        update_matrix()
    end
    function cb_calc_corr(~,~)  %  (src,event)
        update_calc()
        update_tab()
        update_matrix()
    end
    function cb_calc_neg(~,~)  %  (src,event)
        update_calc()
        update_tab()
        update_matrix()
    end
    function cb_comm_edit(src,~)  % (src,event)
        if ~isempty(cohort.getProps(MRISubject.DATA))

            fig_structure = GUIMRIGraphAnalysisStructure(fig_structure,ga);
            waitfor(fig_structure);

            update_community_info()
        else
            errordlg('Select a non-empty cohort in order to define community structure',...
                'Select a cohort', 'modal');
        end
    end
    function cb_comm_default(~,~)  % (src,event)

            cs.setCi(ones(1,cohort.getBrainAtlas.length()))
            cs.setAlgorithm(Structure.ALGORITHM_LOUVAIN)
            cs.setGamma(1)
            cs.setNotes('dynamic community structure')
            
            update_community_info()
            update_matrix()
    end
    function cb_calc_set(~,~)  % (src,event)
        if ga.getCohort().groupnumber()>0
            if isa(ga, 'MRIGraphAnalysisWU')
                GUIMRIGraphAnalysisWU(copy(ga))
            elseif isa(ga, 'MRIGraphAnalysisBUT')
                GUIMRIGraphAnalysisBUT(copy(ga))
            elseif isa(ga, 'MRIGraphAnalysisBUD')
                GUIMRIGraphAnalysisBUD(copy(ga))
            end
        end
    end
    function cb_calc_sub(~,~)  % (src,event)
        if ~isempty(cohort.getProps(MRISubject.DATA))

            fig_structure = GUIMRIGraphAnalysisSubgraph(fig_structure,ga);
            waitfor(fig_structure);

        else
            errordlg('Select a non-empty cohort in order to define a subgraph',...
                'Select a cohort', 'modal');
        end
    end
    function update_community_info()
        set(ui_text_community_property, 'String',['structure = ' cs.getNotes()])
        set(ui_text_community_algorithm, 'String',['algorithm = ' cs.getAlgorithm()])
        set(ui_text_community_gamma, 'String',['gamma = ' num2str(cs.getGamma())])
        set(ui_text_community_number, 'String',['community number = ' int2str(numel(unique(cs.getCi)))])
    end

%% Panel - Measure Table
TAB_NAME_COL = 1;
TAB_NODAL_COL = 2;
TAB_NODAL = 'Global';
TAB_GLOBAL = 'Nodal';
TAB_BINODAL = 'Binodal';
TAB_LAYER_COL = 3;
TAB_UNILAYER = 'Unilayer';
TAB_BILAYER = 'Bilayer';
TAB_SUPERGLOBAL = 'Super Global';
TAB_TXT_COL = 4;

TAB_WIDTH = 1 - 2 * MARGIN_X;
TAB_X0 = MARGIN_X;
TAB_Y0 = 2 * MARGIN_Y + FILENAME_HEIGHT;
TAB_POSITION = [TAB_X0 TAB_Y0 TAB_WIDTH TAB_HEIGHT];

ui_table_calc = uitable(f);
init_measures_table()
    function init_measures_table()
        GUI.setUnits(ui_table_calc)
        GUI.setBackgroundColor(ui_table_calc)
       
        set(ui_table_calc, 'Position', TAB_POSITION)
        set(ui_table_calc, 'ColumnName', {'   Brain Measure   ', ' global/nodal/binodal ', ' unilayer/bilayer/superglobal ' , '   notes   '})
        set(ui_table_calc, 'ColumnFormat', {'char', {TAB_NODAL TAB_GLOBAL TAB_BINODAL}, {TAB_UNILAYER TAB_BILAYER TAB_SUPERGLOBAL} , 'char'})
        set(ui_table_calc, 'ColumnEditable', [false false false false])
        set(ui_table_calc, 'ColumnWidth', {GUI.width(f, .15 * TAB_WIDTH), GUI.width(f, .07 * TAB_WIDTH), GUI.width(f, .07 * TAB_WIDTH), GUI.width(f, .70 * TAB_WIDTH)})
    end
    function update_tab()        
        update_popups_grouplist()
        
        mlist = measurelist();
        
        data = cell(length(mlist), 3);
        for mi = 1:1:length(mlist)
            data{mi, TAB_NAME_COL} = Measure.getName(mlist{mi});
            if Measure.is_nodal(mlist{mi})
                data{mi, TAB_NODAL_COL} = TAB_NODAL;               
            elseif Measure.is_global(mlist{mi})
                data{mi, TAB_NODAL_COL} = TAB_GLOBAL;
            else
                data{mi, TAB_NODAL_COL} = TAB_BINODAL;
            end
            
            if Measure.is_superglobal(mlist{mi})
                data{mi, TAB_LAYER_COL} = TAB_SUPERGLOBAL;
            elseif Measure.is_unilayer(mlist{mi})
                data{mi, TAB_LAYER_COL} = TAB_UNILAYER;
            else
                data{mi, TAB_LAYER_COL} = TAB_BILAYER;
            end
            
            data{mi, TAB_TXT_COL} = Measure.getDescription(mlist{mi});
        end
        set(ui_table_calc, 'Data', data)
    end
    function mlist = measurelist()
        a = 1;
        switch  a %get(ui_popup_calc_graph, 'Value')
            case 1  % weighted undirected               
                mlist = Graph.getCompatibleMeasureList('GraphWU');
            otherwise
                % binary undirected (fix threshold) & binary undirected (fix density)
                mlist = Graph.getCompatibleMeasureList('GraphBU');
        end
    end

%% Menus
MENU_FILE = GUI.MENU_FILE;
MENU_FIGURE = 'Figure';

ui_menu_file = uimenu(f, 'Label', MENU_FILE);
ui_menu_file_open = uimenu(ui_menu_file);
ui_menu_file_save = uimenu(ui_menu_file);
ui_menu_file_saveas = uimenu(ui_menu_file);
ui_menu_file_close = uimenu(ui_menu_file);
init_menu()
 function init_menu()
        set(ui_menu_file_open, 'Label', OPEN_CMD)
        set(ui_menu_file_open, 'Accelerator', OPEN_SC)
        set(ui_menu_file_open, 'Callback', {@cb_open})
        
        set(ui_menu_file_save, 'Separator', 'on')
        set(ui_menu_file_save, 'Label', SAVE_CMD)
        set(ui_menu_file_save, 'Accelerator', SAVE_SC)
        set(ui_menu_file_save, 'Callback', {@cb_save})
        
        set(ui_menu_file_saveas, 'Label', SAVEAS_CMD)
        set(ui_menu_file_saveas, 'Callback', {@cb_saveas});

        set(ui_menu_file_close, 'Separator', 'on')
        set(ui_menu_file_close, 'Label', CLOSE_CMD)
        set(ui_menu_file_close, 'Accelerator', CLOSE_SC);
        set(ui_menu_file_close, 'Callback', ['GUI.close(''' APPNAME ''', gcf)'])
           
 end
[ui_menu_about, ui_menu_about_about] = GUI.setMenuAbout(f, APPNAME);

%% Toolbar
set(f, 'Toolbar', 'figure')
ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
ui_toolbar_open = findall(ui_toolbar, 'Tag', 'Standard.FileOpen');
ui_toolbar_save = findall(ui_toolbar, 'Tag', 'Standard.SaveFigure');
init_toolbar()
    function init_toolbar()
        delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
        % delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
        % delete(findall(ui_toolbar, 'Tag', 'Standard.SaveFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.ZoomIn'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.ZoomOut'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.Pan'))
        delete(findall(ui_toolbar, 'Tag', 'Exploration.Rotate'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.DataCursor'))
        delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
        delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
        %delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertColorbar'))
        delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertLegend'))
        delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOff'))
        delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOn'))
        
        set(ui_toolbar_open, 'TooltipString', OPEN_TP);
        set(ui_toolbar_open, 'ClickedCallback', {@cb_open})
        set(ui_toolbar_save, 'TooltipString', SAVE_TP);
        set(ui_toolbar_save, 'ClickedCallback', {@cb_save})
    end

%% Make the GUI visible.
setup()
set(f, 'Visible', 'on');

%% Auxiliary functions
    function setup()
        
        % setup cohort
        update_cohort()
        
        % setup community panel
%         update_community_info()
        
        % setup graph analysis
%         update_calc()
        update_tab()
%         update_matrix()
        
        % setup data
%         update_calc_ganame()
    end
end