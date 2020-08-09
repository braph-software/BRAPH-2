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

MAINPANEL_X0 = LEFTCOLUMN_WIDTH+2*MARGIN_X;
MAINPANEL_Y0 = FILENAME_HEIGHT+TAB_HEIGHT+3*MARGIN_Y;
MAINPANEL_WIDTH = 1-LEFTCOLUMN_WIDTH-3*MARGIN_X;
MAINPANEL_HEIGHT = 1-TAB_HEIGHT-FILENAME_HEIGHT-4*MARGIN_Y;
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

analysis_list = Analysis.getList();
if exist('tmp', 'var') && ismember(tmp.getClass(), analysis_list) % pass an analysis
    ga = Analysis.getAnalysis(tmp);
    cohort = ga.getCohort();
elseif exist('tmp', 'var') && isa(tmp, 'Cohort') % pass a cohort
    % defaul will be WU
    subject_type = tmp.getSubjectClass();
    for i = 1:1:length(analysis_list)
        analysis = analysis_list{i};
        if isequal(analysis.getSubjectClass(), subject_type) && isequal(analysis.getGraphType(), 'GraphWU')
            ga = Analysis.getAnalysis(analysis, 'Empty GA', '', '', tmp, {}, {}, {}); %#ok<NASGU>
        end        
    end    
    cohort = ga.getCohort();
else % string of analysis class
     assert(ismember(tmp, analysis_list));
     assert(isa(atlas, 'BrainAtlas'));
     subject_type = Analysis.getSubjectClass(tmp);    
     for i = 1:1:length(analysis_list)
        analysis = analysis_list{i};
        if isequal(analysis.getSubjectClass(), subject_type) && isequal(analysis.getGraphType(), 'GraphWU')
            cohort = Cohort('cohort id', 'cohort label', 'cohort notes', subject_type, atlas, {});
            ga = Analysis.getAnalysis(analysis, 'Empty GA', '', '', cohort, {}, {}, {}); %#ok<NASGU>
        end        
    end        
end


f = GUI.init_figure(APPNAME, .8, .9, 'center');
end