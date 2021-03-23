% test GUIAnalysisSettings

%% Pass type of analysis
GUIAnalysisSettings('AnalysisST_WU')

set(gcf, 'CloseRequestFcn', 'closereq')
close(gcf)