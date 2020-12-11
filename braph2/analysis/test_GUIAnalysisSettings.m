% test GUIAnalysisSettings

%% Pass type of analysis
GUIAnalysisSettings('AnalysisCON_WU')

set(gcf, 'CloseRequestFcn', 'closereq')
close(gcf)