clear all
clc

% delete([fileparts(which('braph2')) '/src/ds/ETD2.m'])
% create_Element([fileparts(which('braph2genesis')) '/src/ds/_ETD2.gen.m'], [fileparts(which('braph2')) '/src/ds'])

% et1 = ETA({});
% for prop = 1:1:et1.getPropNumber()
%     assert(~et1.isEnsemble(prop))
% end
% 
% et2 = ETA({}, ...
%     'PROP_STRING_M', 'string1', 'PROP_SCALAR_M', 1, ...
%     'PROP_STRING_P', 'string2', 'PROP_SCALAR_P', 2, ...
%     'PROP_STRING_D', 'string3', 'PROP_SCALAR_D', 3 ...
%     );
% assert(strcmp(et2.get('PROP_STRING_M'), 'string1'))
% assert(strcmp(et2.get('PROP_STRING_P'), 'string2'))
% assert(strcmp(et2.get('PROP_STRING_D'), 'string3'))
% assert(et2.get('PROP_SCALAR_M') == 1)
% assert(et2.get('PROP_SCALAR_P') == 2)
% assert(et2.get('PROP_SCALAR_D') == 3)
% for prop = 1:1:et2.getPropNumber()
%     assert(~et2.isEnsemble(prop))
% end

% et3 = ETA({1:1:ETA.getPropNumber()});
% for prop = 1:1:et3.getPropNumber()
%     assert(et3.isEnsemble(prop))
% end
