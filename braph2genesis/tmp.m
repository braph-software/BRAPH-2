close all
clear all
clc

braph_path = [pwd '\braph2']
genesis_path = [pwd '\braph2genesis']

delete([braph_path '\src\nn\NNBase.m'])
create_Element([genesis_path '\src\nn\_NNBase.gen.m'], [braph_path '\src\nn'])
create_test_Element([genesis_path '\src\nn\_NNBase.gen.m'], [braph_path '\src\nn'])

delete([braph_path '\src\nn\NNData.m'])
create_Element([genesis_path '\src\nn\_NNData.gen.m'], [braph_path '\src\nn'])
create_test_Element([genesis_path '\src\nn\_NNData.gen.m'], [braph_path '\src\nn'])

delete([braph_path '\src\nn\NNEvaluator.m'])
create_Element([genesis_path '\src\nn\_NNEvaluator.gen.m'], [braph_path '\src\nn'])
create_test_Element([genesis_path '\src\nn\_NNEvaluator.gen.m'], [braph_path '\src\nn'])

delete([braph_path '\neuralnetworks\NNClassifierDNN.m'])
create_Element([genesis_path '\neuralnetworks\_NNClassifierDNN.gen.m'], [braph_path '\neuralnetworks'])
create_test_Element([genesis_path '\neuralnetworks\_NNClassifierDNN.gen.m'], [braph_path '\neuralnetworks'])

delete([braph_path '\neuralnetworks\NNRegressorDNN.m'])
create_Element([genesis_path '\neuralnetworks\_NNRegressorDNN.gen.m'], [braph_path '\neuralnetworks'])
create_test_Element([genesis_path '\neuralnetworks\_NNRegressorDNN.gen.m'], [braph_path '\neuralnetworks'])

delete([braph_path '\neuralnetworks\NNClassifierData.m'])
create_Element([genesis_path '\neuralnetworks\_NNClassifierData.gen.m'], [braph_path '\neuralnetworks'])
create_test_Element([genesis_path '\neuralnetworks\_NNClassifierData.gen.m'], [braph_path '\neuralnetworks'])

delete([braph_path '\neuralnetworks\NNRegressorData.m'])
create_Element([genesis_path '\neuralnetworks\_NNRegressorData.gen.m'], [braph_path '\neuralnetworks'])
create_test_Element([genesis_path '\neuralnetworks\_NNRegressorData.gen.m'], [braph_path '\neuralnetworks'])

delete([braph_path '\neuralnetworks\NNClassifierEvaluator.m'])
create_Element([genesis_path '\neuralnetworks\_NNClassifierEvaluator.gen.m'], [braph_path '\neuralnetworks'])
create_test_Element([genesis_path '\neuralnetworks\_NNClassifierEvaluator.gen.m'], [braph_path '\neuralnetworks'])

delete([braph_path '\neuralnetworks\NNRegressorEvaluator.m'])
create_Element([genesis_path '\neuralnetworks\_NNRegressorEvaluator.gen.m'], [braph_path '\neuralnetworks'])
create_test_Element([genesis_path '\neuralnetworks\_NNRegressorEvaluator.gen.m'], [braph_path '\neuralnetworks'])

delete([braph_path '\neuralnetworks\NNClassifierCrossValidation.m'])
create_Element([genesis_path '\neuralnetworks\_NNClassifierCrossValidation.gen.m'], [braph_path '\neuralnetworks'])
create_test_Element([genesis_path '\neuralnetworks\_NNClassifierCrossValidation.gen.m'], [braph_path '\neuralnetworks'])

delete([braph_path '\pipelines\connectivity NN\NNClassifierData_CON_WU.m'])
create_Element([genesis_path '\pipelines\connectivity NN\_NNClassifierData_CON_WU.gen.m'], [braph_path '\pipelines\connectivity NN'])
create_test_Element([genesis_path '\pipelines\connectivity NN\_NNClassifierData_CON_WU.gen.m'], [braph_path '\pipelines\connectivity NN'])

delete([braph_path '\pipelines\connectivity NN\NNRegressorData_CON_WU.m'])
create_Element([genesis_path '\pipelines\connectivity NN\_NNRegressorData_CON_WU.gen.m'], [braph_path '\pipelines\connectivity NN'])
create_test_Element([genesis_path '\pipelines\connectivity NN\_NNRegressorData_CON_WU.gen.m'], [braph_path '\pipelines\connectivity NN'])

delete([braph_path '\pipelines\connectivity NN\NNClassifierCrossValidation_CON_WU.m'])
create_Element([genesis_path '\pipelines\connectivity NN\_NNClassifierCrossValidation_CON_WU.gen.m'], [braph_path '\pipelines\connectivity NN'])
create_test_Element([genesis_path '\pipelines\connectivity NN\_NNClassifierCrossValidation_CON_WU.gen.m'], [braph_path '\pipelines\connectivity NN'])

delete([braph_path '\pipelines\functional NN\NNClassifierData_FUN_WU.m'])
create_Element([genesis_path '\pipelines\functional NN\_NNClassifierData_FUN_WU.gen.m'], [braph_path '\pipelines\functional NN'])
create_test_Element([genesis_path '\pipelines\functional NN\_NNClassifierData_FUN_WU.gen.m'], [braph_path '\pipelines\functional NN'])

delete([braph_path '\pipelines\functional NN\NNRegressorData_FUN_WU.m'])
create_Element([genesis_path '\pipelines\functional NN\_NNRegressorData_FUN_WU.gen.m'], [braph_path '\pipelines\functional NN'])
create_test_Element([genesis_path '\pipelines\functional NN\_NNRegressorData_FUN_WU.gen.m'], [braph_path '\pipelines\functional NN'])

delete([braph_path '\pipelines\functional NN\NNClassifierCrossValidation_FUN_WU.m'])
create_Element([genesis_path '\pipelines\functional NN\_NNClassifierCrossValidation_FUN_WU.gen.m'], [braph_path '\pipelines\functional NN'])
create_test_Element([genesis_path '\pipelines\functional NN\_NNClassifierCrossValidation_FUN_WU.gen.m'], [braph_path '\pipelines\functional NN'])

delete([braph_path '\pipelines\structural NN\NNRegressorData_ST.m'])
create_Element([genesis_path '\pipelines\structural NN\_NNRegressorData_ST.gen.m'], [braph_path '\pipelines\structural NN'])
create_test_Element([genesis_path '\pipelines\structural NN\_NNRegressorData_ST.gen.m'], [braph_path '\pipelines\structural NN'])

delete([braph_path '\pipelines\structural NN\NNClassifierData_ST.m'])
create_Element([genesis_path '\pipelines\structural NN\_NNClassifierData_ST.gen.m'], [braph_path '\pipelines\structural NN'])
create_test_Element([genesis_path '\pipelines\structural NN\_NNClassifierData_ST.gen.m'], [braph_path '\pipelines\structural NN'])

delete([braph_path '\pipelines\structural NN\NNClassifierCrossValidation_ST.m'])
create_Element([genesis_path '\pipelines\structural NN\_NNClassifierCrossValidation_ST.gen.m'], [braph_path '\pipelines\structural NN'])
create_test_Element([genesis_path '\pipelines\structural NN\_NNClassifierCrossValidation_ST.gen.m'], [braph_path '\pipelines\structural NN'])
