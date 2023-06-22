%% ¡header!
Importer < ConcreteElement (im, importer from a file) imports an element from a file.

%%% ¡description!
Importer is the base class for the importer of an element (ConcreteElement) from a file.

%%% ¡seealso!
ConcreteElement, Exporter

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the importer.
%%%% ¡default!
'Importer'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the importer.
%%%% ¡default!
'Importer is the base class for the importer of an element (ConcreteElement) from a file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the importer.
%%%% ¡settings!
'Importer'

%%% ¡prop!
ID (data, string) is a few-letter code for the importer.
%%%% ¡default!
'Importer ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the importer.
%%%% ¡default!
'Importer label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the importer.
%%%% ¡default!
'Importer notes'

%% ¡props!

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.