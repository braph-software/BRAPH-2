%% ¡header!
Subject < ConcreteElement (sub, subject) is a subject.

%%% ¡description!
Subject provides the methods necessary for all subjects. 
Instances of this element should not be created. 
Use one of its subelements instead.

%%% ¡seealso!
Group

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'Subject'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject provides the methods necessary for all subjects. Instances of this element should not be created. Use one of its subelements instead.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'Subject'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'Subject ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'Subject label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'Subject notes'

%% ¡_methods! %TBE
% % % function str = tostring(sub, varargin)
% % %     %TOSTRING string with information about the subject.
% % %     %
% % %     % STR = TOSTRING(SUB) returns a string with information about the subject.
% % %     %
% % %     % STR = TOSTRING(SUB, N) trims the string to the first N characters.
% % %     %
% % %     % STR = TOSTRING(SUB, N, ENDING) ends the string with ENDING if it has
% % %     %  been trimmed.
% % %     %
% % %     % See also disp, tree.
% % % 
% % %     str = [class(sub) ' ' sub.getPropTag(1) ' = ' tostring(sub.get(1)) '.'];
% % % 
% % %     str = tostring(str, varargin{:});
% % %     str = str(2:1:end-1);
% % % end
