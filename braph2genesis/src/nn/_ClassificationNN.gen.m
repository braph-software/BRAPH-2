%% ¡header!
ClassificationNN < Element (nn, classification neural network) is a classification neural network.

%%% ¡description!
ClassificationNN provides the methods necessary for all classification neural networks.
Instances of this class should not be created. 
Use one of its subclasses instead.

%%% ¡seealso!
Regression

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the classification.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the classification.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the classification.

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class.
%%%% ¡settings!
'Group'

%%% ¡prop!
A (result, scalar) is the accuracy obtained from this classification.
%%%% ¡calculate!
value = 0;