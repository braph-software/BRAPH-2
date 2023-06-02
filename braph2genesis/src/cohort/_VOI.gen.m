%% ¡header!
VOI < ConcreteElement (voi, variable of interest) is the base element for the variables of interest.

%%% ¡description!
VOI is the base element for a variable of interest.
 Instances of this class should not be created. 
 Use one of its subclasses instead.

 %%% ¡seealso!
 VOINumeric, VOICategoric
 
 %% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the variable of interest.
%%%% ¡default!
'VOI'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the variable of interest.
%%%% ¡default!
'VOI is the base element for a variable of interest. Instances of this class should not be created. Use one of its subclasses instead.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the variable of interest.

%%% ¡prop!
ID (data, string) is a few-letter code for the variable of interest.
%%%% ¡default!
'VOI ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the variable of interest.
%%%% ¡default!
'VOI label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the variable of interest.
%%%% ¡default!
'VOI notes'

%% ¡props!

%%% ¡prop!
V (data, scalar) is the value of the variable of interest.