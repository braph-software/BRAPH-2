%% ¡header!
PipelineSection < Element (ps, pipeline section) is a pipeline code section.

%%% ¡description!
PipelineCode represents a section of executable code in a pipeline.

%%% ¡seealso!
PipelineGUI, Pipeline, PipelineSection.

%% ¡props!

%%% ¡prop!
ID (data, string) is a numeric code for the pipeline code section.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the pipeline code section.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the pipeline code section.

%%% ¡prop!
PC_DICT (data, idict) is an indexed dictionary with the executable code lines.
%%%% ¡settings!
'PipelineCode'
