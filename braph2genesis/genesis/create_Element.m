function create_Element(generator_file, target_dir)
%CREATE_ELEMENT creates an element.
%
% CREATE_ELEMENT(FILE, DIR) creates the m-file of an Element from its
%  generator file FILE (with ending '.gen.m') and saves it in the target
%  directory DIR.
%
% A generator file (whose name must have ending '.gen.m', and tipically
%  starts with "_") has the following structure (the token ¡header! is
%  required, while the rest is optional):
%
% ----------
%
%<strong>%% ¡header!</strong>
% <class_name> < <superclass_name> (<moniker>, <descriptive_name>) <header_description>.
% <strong>%%% ¡class_attributes!</strong>
%  Class attributes is a single line, e.g. Abstract = true, Sealed = true.
% <strong>%%% ¡description!</strong>
%  This is a plain description of the element.
%  It can occupy several lines.
% <strong>%%% ¡seealso!</strong>
%  Related functions and classes is a single line.
% 
%<strong>%% ¡props!</strong>
% <strong>%%% ¡prop!</strong>
%  <tag1> (<category>, <format>) <description>.
%  <strong>%%%% ¡settings!</strong>
%   Prop settings, depending on format.
%  <strong>%%%% ¡check_prop!</strong>
%   Code to check prop format (before calculation).
%   Can be on multiple lines.
%   The outcome should be in variable 'check'.
%  <strong>%%%% ¡check_value!</strong>
%   Code to check prop value (after calculation).
%   Can be on multiple lines.
%   The outcome should be in variable 'check'.
%  <strong>%%%% ¡default!</strong>
%   Prop default value (seldom needed).
%  <strong>%%%% ¡calculate!</strong>
%   Code to calcualte prop results (only for category RESULT).
%   Can be on multiple lines.
%   The result should be in variable 'value'.
% <strong>%%% ¡prop!</strong>
%   <tag2> ...
% 
%<strong>%% ¡props_update!</strong>
% <strong>%%% ¡prop!</strong>
%  <tag1> (<category>, <format>) <description>. [Only description can be different from original prop]
%  <strong>%%%% ¡settings!</strong>
%   Updated settings.
%  <strong>%%%% ¡check_prop!</strong>
%   Updated check prop format (before calculation).
%  <strong>%%%% ¡check_value!</strong>
%   Updated check prop value (after calculation).
%  <strong>%%%% ¡default!</strong>
%   Updated default.
%  <strong>%%%% ¡calculate!</strong>
%   Updated calculation.
% <strong>%%% ¡prop!</strong>
%  <tag2> ...
% 
%<strong>%% ¡staticmethods!</strong>
% Static methods written as functions including the relative documentation.
% 
% ----------
% 
% See also genesis, create_test_Element.

disp(['¡ source file: ' generator_file])
disp(['¡ target dir: ' target_dir])

txt = fileread(generator_file);

disp('¡! generator file read')

%% Analysis
[class_name, superclass_name, moniker, descriptive_name, header_description, class_attributes, description, seealso] = analyze_header();
    function [class_name, superclass_name, moniker, descriptive_name, header_description, class_attributes, description, seealso] = analyze_header()
        header = getToken(txt, 'header');
        res = regexp(header, '^\s*(?<class_name>\w*)\s*<\s*(?<superclass_name>\w*)\s*\(\s*(?<moniker>\w*)\s*,\s*(?<descriptive_name>[^)]*)\)\s*(?<header_description>[^.]*)\.', 'names');
        class_name = res.class_name;
        superclass_name = res.superclass_name;
        moniker = res.moniker;
        descriptive_name = res.descriptive_name;
        header_description = res.header_description;
        
        class_attributes = getToken(txt, 'header', 'class_attributes');

        description = splitlines(getToken(txt, 'header', 'description'));
        
        seealso = getToken(txt, 'header', 'seealso');        
    end

% [ensemble, graph, connectivity, directionality, selfconnectivity, negativity] = analyze_header_graph(); % only for graphs
%     function [ensemble, graph, connectivity, directionality, selfconnectivity, negativity] = analyze_header_graph()
%         ensemble = getToken(txt, 'header', 'ensemble');
%         graph = getToken(txt, 'header', 'graph');
%         connectivity = splitlines(getToken(txt, 'header', 'connectivity'));
%         directionality = splitlines(getToken(txt, 'header', 'directionality'));
%         selfconnectivity = splitlines(getToken(txt, 'header', 'selfconnectivity'));
%         negativity = splitlines(getToken(txt, 'header', 'negativity'));
%     end
% 
% [shape, scope, parametricity, compatible_graphs] = analyze_header_measure(); % only for measures
%     function [shape, scope, parametricity, compatible_graphs] = analyze_header_measure()
%         shape = getToken(txt, 'header', 'shape');
%         scope = getToken(txt, 'header', 'scope');
%         parametricity = getToken(txt, 'header', 'parametricity');
%         compatible_graphs = getToken(txt, 'header', 'compatible_graphs');
%     end

[props, props_update] = analyze_props();
    function [props, props_update] = analyze_props()
        props = getTokens(txt, 'props', 'prop');
        for i = 1:1:numel(props)
            res = regexp(props{i}.token, '^(\s*)(?<tag>\w*)\s*\((?<category>\w*),\s*(?<format>\w*)\)\.*', 'names');
            props{i}.TAG = upper(res.tag);
            props{i}.tag = lower(res.tag);
            props{i}.CATEGORY = upper(res.category);
            props{i}.category = lower(res.category);
            props{i}.FORMAT = upper(res.format);
            props{i}.format = lower(res.format);

            lines = splitlines(props{i}.token);
            props{i}.description = lines{1};

            props{i}.settings = getToken(props{i}.token, 'settings');
            props{i}.check_prop = splitlines(getToken(props{i}.token, 'check_prop'));
            props{i}.check_value = splitlines(getToken(props{i}.token, 'check_value'));
            props{i}.default = getToken(props{i}.token, 'default');
            props{i}.calculate = splitlines(getToken(props{i}.token, 'calculate'));
        end
        props_update = getTokens(txt, 'props_update', 'prop');
        for i = 1:1:numel(props_update)
            res = regexp(props_update{i}.token, '^(\s*)(?<tag>\w*)\s*\((?<category>\w*),\s*(?<format>\w*)\)\.*', 'names');
            props_update{i}.TAG = upper(res.tag);
            props_update{i}.tag = lower(res.tag);
            props_update{i}.CATEGORY = upper(res.category);
            props_update{i}.category = lower(res.category);
            props_update{i}.FORMAT = upper(res.format);
            props_update{i}.format = lower(res.format);

            lines = splitlines(props_update{i}.token);
            props_update{i}.description = lines{1};

            props_update{i}.settings = getToken(props_update{i}.token, 'settings');
            props_update{i}.check_prop = splitlines(getToken(props_update{i}.token, 'check_prop'));
            props_update{i}.check_value = splitlines(getToken(props_update{i}.token, 'check_value'));
            props_update{i}.default = getToken(props_update{i}.token, 'default');
            props_update{i}.calculate = splitlines(getToken(props_update{i}.token, 'calculate'));
        end
    end

% constants = splitlines(getToken(txt, 'constants'));

staticmethods = splitlines(getToken(txt, 'staticmethods'));

% methods = splitlines(getToken(txt, 'methods'));

%% Generate and save file
target_file = [target_dir filesep() class_name '.m'];
object_file = fopen(target_file, 'w');

generate_header()
    function generate_header()
        if isempty(class_attributes)
            g(0, ['classdef ' class_name ' < ' superclass_name])
        else
            g(0, ['classdef (' class_attributes ') ' class_name ' < ' superclass_name])
        end
        gs(1, {...
            ['% ' class_name ' ' header_description '.'], ...
            ['% It is a subclass of <a href="matlab:help ' superclass_name '">' superclass_name '</a>.'], ...
            '%' ...
            })
        gs(1, cellfun(@(x) ['% ' x], description, 'UniformOutput', false))
        if ~isempty(seealso)
            gs(1, {...
                '%', ...
                ['% See also ' seealso '.'], ...
                })
        end
        g(1, '')
    end

% generate_constants()
%     function generate_constants()
%         if numel(constants) == 1 && isempty(constants{1})
%             return
%         end
%         g(1, 'properties (Constant) % constants')
%             gs(2, constants)
%         g(1, 'end')
%     end

generate_staticmethods()
    function generate_staticmethods()
        if numel(staticmethods) == 1 && isempty(staticmethods{1})
            return
        end
        g(1, 'methods (Static) % static methods')
            gs(2, staticmethods)
        g(1, 'end')
    end

generate_props()
    function generate_props()
        if isempty(props)
            return
        end
        g(1, 'properties (Constant) % properties')

        for i = 1:1:numel(props)
            if strcmp(superclass_name, 'Element')
                g(2, [props{i}.TAG ' = ' int2str(i) ';'])
            else
                g(2, [props{i}.TAG ' = ' superclass_name '.getPropNumber() + ' int2str(i) ';'])
            end
            g(2, [props{i}.TAG '_TAG = ''' props{i}.tag ''';'])
            g(2, [props{i}.TAG '_CATEGORY = Category.' props{i}.CATEGORY ';'])
            g(2, [props{i}.TAG '_FORMAT = Format.' props{i}.FORMAT ';'])
            if i ~= numel(props)
                g(2, '')
            end
        end

        g(1, 'end');
    end

generate_inspection()
    function generate_inspection()
        g(1, 'methods (Static) % inspection methods')

            % getClass()
            g(2, ['function ' moniker '_class = getClass()'])
                gs(3, {
                    ['%GETCLASS returns the class of the ' descriptive_name '.']
                     '%'
                    ['% CLASS = ' class_name '.GETCLASS() returns the class ''' class_name '''.']
                     '%'
                     '% Alternative forms to call this method are:'
                    ['%  CLASS = ' upper(moniker) '.GETCLASS() returns the class of the ' descriptive_name ' ' upper(moniker) '.']
                    ['%  CLASS = Element.GETCLASS(' upper(moniker) ') returns the class of ''' upper(moniker) '''.']
                    ['%  CLASS = Element.GETCLASS(''' class_name ''') returns ''' class_name '''.']
                     '%'
                     '% See also getName, getDescription.'
                     ''
                    })
               g(3, [moniker '_class = ''' class_name ''';'])
            g(2, 'end')

            % getName()
            g(2, ['function ' moniker '_name = getName()'])
                gs(3, {
                    ['%GETNAME returns the name of the ' descriptive_name '.']
                     '%'
                    ['% NAME = ' class_name '.GETNAME() returns the name of the ''' descriptive_name '''.']
                    ['%  ' regexprep(descriptive_name, '(\<[a-z])', '${upper($1)}') '.']
                     '%'
                     '% Alternative forms to call this method are:'
                    ['%  NAME = ' upper(moniker) '.GETNAME() returns the name of the ' descriptive_name ' ' upper(moniker) '.']
                    ['%  NAME = Element.GETNAME(' upper(moniker) ') returns the name of ''' upper(moniker) '''.']
                    ['%  NAME = Element.GETNAME(''' class_name ''') returns the name of ''' class_name '''.']
                     '%'
                     '% See also getClass, getDescription.'
                     ''
                    })
                g(3, [moniker '_name = regexprep(''' descriptive_name ''', ''(\\<[a-z])'', ''${upper($1)}'');']) % note use of "\\<" instead of "\<" to deal with special character
            g(2, 'end')

            % getDescription()
            g(2, ['function ' moniker '_description = getDescription()'])
                gs(3, {
                    ['%GETDESCRIPTION returns the description of the ' descriptive_name '.']
                     '%'
                    ['% STR = ' class_name '.GETDESCRIPTION() returns the description of the ''' descriptive_name '''.']
                     '%  which is:'
                     '%'
                    })
                gs(3, cellfun(@(x) ['%  ' x], description, 'UniformOutput', false))
                gs(3, {
                     '%'
                     '% Alternative forms to call this method are:'
                    ['%  STR = ' upper(moniker) '.GETDESCRIPTION() returns the description of the ' descriptive_name ' ' upper(moniker) '.']
                    ['%  STR = Element.GETDESCRIPTION(' upper(moniker) ') returns the description of ''' upper(moniker) '''.']
                    ['%  STR = Element.GETDESCRIPTION(''' class_name ''') returns the description of ''' class_name '''.']
                     '%'
                     '% See also getClass, getName.'
                     ''
                    })
                g(3, [moniker '_description = ['])
                    gs(4, cellfun(@(x) ['''' x ''' ...'], description, 'UniformOutput', false))
                    g(4, '];')
            g(2, 'end')

            % getProps(category)
            g(2, 'function prop_list = getProps(category)')
                gs(3, {
                    ['%GETPROPS returns the property list of ' descriptive_name '.']
                     '%'
                    ['% PROPS = ' class_name '.GETPROPS() returns the property list of ' descriptive_name '.']
                     '%'
                    ['% PROPS = ' class_name '.GETPROPS(CATEGORY) returns the property list ']
                     '%  of category CATEGORY.'
                     '%'
                     '% Alternative forms to call this method are:'
                    ['%  PROPS = ' upper(moniker) '.GETPROPS([CATEGORY]) returns the property list of the ' descriptive_name ' ' upper(moniker) '.']
                    ['%  PROPS = Element.GETPROPS(' upper(moniker) '[, CATEGORY]) returns the property list of ''' upper(moniker) '''.']
                    ['%  PROPS = Element.GETPROPS(''' class_name '''[, CATEGORY]) returns the property list of ''' class_name '''.']
                     '%'
                     '% See also getPropNumber.'
                     ''
                    })
                g(3, 'if nargin < 1')
                    g(4, 'category = ''all'';')
                g(3, 'end')
                g(3, '')
                g(3, 'switch category')
                    g(4, 'case Category.METADATA')
                        g(5, 'prop_list = [')
                            if ~strcmp(superclass_name, 'Element')
                                g(6, [superclass_name '.getProps(Category.METADATA)'])
                            end
                            for i = 1:1:numel(props)
                                if strcmp(props{i}.CATEGORY, 'METADATA')
                                    g(6, [class_name '.' props{i}.TAG])
                                end
                            end
                            g(6, '];')
                    g(4, 'case Category.PARAMETER')
                        g(5, 'prop_list = [')
                            if ~strcmp(superclass_name, 'Element')
                                g(6, [superclass_name '.getProps(Category.PARAMETER)'])
                            end
                            for i = 1:1:numel(props)
                                if strcmp(props{i}.CATEGORY, 'PARAMETER')
                                    g(6, [class_name '.' props{i}.TAG])
                                end
                            end
                            g(6, '];')
                    g(4, 'case Category.DATA')
                        g(5, 'prop_list = [');
                            if ~strcmp(superclass_name, 'Element')
                                g(6, [superclass_name '.getProps(Category.DATA)'])
                            end
                            for i = 1:1:numel(props)
                                if strcmp(props{i}.CATEGORY, 'DATA')
                                    g(6, [class_name '.' props{i}.TAG])
                                end
                            end
                            g(6, '];')
                    g(4, 'case Category.RESULT')
                        g(5, 'prop_list = [')
                            if ~strcmp(superclass_name, 'Element')
                                g(6, [superclass_name '.getProps(Category.RESULT)'])
                            end
                            for i = 1:1:numel(props)
                                if strcmp(props{i}.CATEGORY, 'RESULT')
                                    g(6, [class_name '.' props{i}.TAG])
                                end
                            end
                            g(6, '];')
                    g(4, 'otherwise')
                        g(5, 'prop_list = [')
                            if ~strcmp(superclass_name, 'Element')
                                g(6, [superclass_name '.getProps()'])
                            end
                            for i = 1:1:numel(props)
                                g(6, [class_name '.' props{i}.TAG])
                            end
                            g(6, '];')
                g(3, 'end')
            g(2, 'end')

            % getPropNumber()
            g(2, 'function prop_number = getPropNumber()')
                gs(3, {
                    ['%GETPROPNUMBER returns the property number of ' descriptive_name '.']
                     '%'
                    ['% N = ' class_name '.GETPROPNUMBER() returns the property number of ' descriptive_name '.']
                     '%'
                     '% Alternative forms to call this method are:'
                    ['%  N = ' upper(moniker) '.GETPROPNUMBER() returns the property number of the ' descriptive_name ' ' upper(moniker) '.']
                    ['%  N = Element.GETPROPNUMBER(' upper(moniker) ') returns the property number of ''' upper(moniker) '''.']
                    ['%  N = Element.GETPROPNUMBER(''' class_name ''') returns the property number of ''' class_name '''.']
                     '%'
                     '% See also getProps.'
                     ''
                    })
                g(3, ['prop_number = numel(' class_name '.getProps());'])
            g(2, 'end')

            % existsProp(prop)
            g(2, 'function check = existsProp(prop)')
                gs(3, {
                    ['%EXISTSPROP checks whether property exists/error in ' descriptive_name '.']
                     '%'
                     '% CHECK = Element.EXISTPROP(PROP) checks whether the property'
                     '%  PROP exists.'
                     '%'                    
                     '% Alternative forms to call this method are:'
                    ['%  CHECK = EXISTSPROP(' upper(moniker) ', PROP) checks PROP for ' class_name '.']
                    ['%  CHECK = ' upper(moniker) '.EXISTSPROP(PROP) checks PROP for ' class_name '.']
                    ['%  CHECK = Element.EXISTSPROP(' class_name ', PROP) checks PROP for CLASS.']
                    ['%  CHECK = ' upper(moniker) '.EXISTSPROP(' class_name ', PROP) checks PROP for CLASS.']
                     '%'
                     '% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT'
                     '%  exist.'
                    ['%  Error id: [BRAPH2:' class_name ':WrongInput]']
                     '%'
                     '% Alternative forms to call this method are:'
                    ['%  EXISTSPROP(' upper(moniker) ', PROP) throws error if PROP does NOT exist for ' class_name '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                    ['%  ' upper(moniker) '.EXISTSPROP(PROP) throws error if PROP does NOT exist for ' class_name '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                    ['%  ' upper(moniker) '.EXISTSPROP(CLASS, PROP) throws error if PROP does NOT exist for ' class_name '.']
                    ['%   Error id: [BRAPH2:CLASS:WrongInput]']
                    ['%  ' upper(moniker) '.EXISTSPROP(CLASS, PROP) throws error if PROP does NOT exist for ' class_name '.']
                    ['%   Error id: [BRAPH2:CLASS:WrongInput]']
                     '%'
                     '% See also getProps, existTag.'
                     ''
                    })
                g(3, 'if nargout == 1')
                    g(4, ['check = any(prop == ' class_name '.getProps());'])
                g(3, 'else')
                    g(4, 'assert( ...')
                        gs(5, {
                            [class_name '.existsProp(prop), ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT '' '' ...']
                            ['''The value '' tostring(prop, 100, '' ...'') '' is not a valid prop for ' class_name '''] ...']
                             ')'
                             })
                g(3, 'end')
            g(2, 'end')

            % existsTag(prop)
            g(2, 'function check = existsTag(tag)')
                gs(3, {
                    ['%EXISTSTAG checks whether tag exists/error in ' descriptive_name '.']
                     '%'
                     '% CHECK = Element.EXISTPROP(PROP) checks whether tag TAG exists.'
                     '%'                    
                     '% Alternative forms to call this method are:'
                    ['%  CHECK = EXISTSTAG(' upper(moniker) ', PROP) checks tag TAG for ' class_name '.']
                    ['%  CHECK = ' upper(moniker) '.EXISTSTAG(PROP) checks tag TAG for ' class_name '.']
                    ['%  CHECK = Element.EXISTSTAG(' class_name ', PROP) checks tag TAG for CLASS.']
                    ['%  CHECK = ' upper(moniker) '.EXISTSTAG(' class_name ', PROP) checks tag TAG for CLASS.']
                     '%'
                     '% Element.EXISTSTAG(PROP) throws an error if the TAG NOT exist.'
                    ['%  Error id: [BRAPH2:' class_name ':WrongInput]']
                     '%'
                     '% Alternative forms to call this method are:'
                    ['%  EXISTSTAG(' upper(moniker) ', PROP) throws error if TAG does NOT exist for ' class_name '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                    ['%  ' upper(moniker) '.EXISTSTAG(PROP) throws error if TAG does NOT exist for ' class_name '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                    ['%  ' upper(moniker) '.EXISTSTAG(CLASS, PROP) throws error if TAG does NOT exist for ' class_name '.']
                    ['%   Error id: [BRAPH2:CLASS:WrongInput]']
                    ['%  ' upper(moniker) '.EXISTSTAG(CLASS, PROP) throws error if TAG does NOT exist for ' class_name '.']
                    ['%   Error id: [BRAPH2:CLASS:WrongInput]']
                     '%'
                     '% See also getProps, existsProp.'
                     ''
                    })
                g(3, 'if nargout == 1')
                    gs(4, {
                        ['tag_list = cellfun(@(x) ' class_name '.getPropTag(x), num2cell(' class_name '.getProps()), ''UniformOutput'', false);']
                         'check = any(strcmpi(tag, tag_list));'
                         })
                g(3, 'else')
                    g(4, 'assert( ...')
                        gs(5, {
                            [class_name '.existsTag(tag), ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], ...']
                            ['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT '' '' ...']
                        	['''The value '' tag '' is not a valid tag for ' class_name '''] ...']
                            ')'
                            })
                g(3, 'end')
            g(2, 'end')

            % getPropProp(pointer)
            g(2, 'function prop = getPropProp(pointer)')
            gs(3, {
                '%GETPROPPROP returns the property of a property.'
                '%'
                '% PROPERTY = Element.GETPROPPROP(PROP) returns the'
                '%  property of property PROP.'
                '%'
                '% PROPERTY = Element.GETPROPPROP(TAG) returns the'
                '%  property of the property with tag TAG.'
                '%'
                '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  PROPERTY = GETPROPPROP(' upper(moniker) ', POINTER) returns property of POINTER of ' class_name '.']
                ['%  PROPERTY = ' upper(moniker) '.GETPROPPROP(POINTER) returns property of POINTER of ' class_name '.']
                ['%  PROPERTY = Element.GETPROPPROP(' class_name ', POINTER) returns property of POINTER of CLASS.']
                ['%  PROPERTY = ' upper(moniker) '.GETPROPPROP(' class_name ', POINTER) returns property of POINTER of CLASS.']
                '%'
                '% See also getPropFormat, getPropTag, getPropCategory,'
                '% getPropDescription, getPropSettings, getPropDefault,'
                '% checkProp.'
                ''
                })
                g(3, 'if ischar(pointer)')
                    gs(4, {
                         'tag = pointer;'
                        [class_name '.existsTag(tag);']
                    	 ''
                        ['tag_list = cellfun(@(x) ' class_name '.getPropTag(x), num2cell(' class_name '.getProps()''), ''UniformOutput'', false);']
                    	 'prop = find(strcmpi(tag, tag_list));'
                         })
                g(3, 'else % numeric')
                    gs(4, {
                         'prop = pointer;'
                        [class_name '.existsProp(prop);']
                        })
                g(3, 'end')
            g(2, 'end')

            % getPropTag(pointer)
            g(2, 'function tag = getPropTag(pointer)')
            gs(3, {
                '%GETPROPTAG returns the tag of a property.'
                '%'
                '% TAG = Element.GETPROPTAG(PROP) returns the'
                '%  tag of property PROP.'
                '%'
                '% TAG = Element.GETPROPTAG(TAG) returns the'
                '%  tag of the property with tag TAG.'
                '%'
                '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  TAG = GETPROPTAG(' upper(moniker) ', POINTER) returns tag of POINTER of ' class_name '.']
                ['%  TAG = ' upper(moniker) '.GETPROPTAG(POINTER) returns tag of POINTER of ' class_name '.']
                ['%  TAG = Element.GETPROPTAG(' class_name ', POINTER) returns tag of POINTER of CLASS.']
                ['%  TAG = ' upper(moniker) '.GETPROPTAG(' class_name ', POINTER) returns tag of POINTER of CLASS.']
                '%'
                '% See also getPropProp, getPropSettings, getPropCategory,'
                '% getPropFormat, getPropDescription, getPropDefault,'
                '% checkProp.'
                ''
                })
                g(3, 'if ischar(pointer)')
                    gs(4, {
                         'tag = pointer;'
                    	[class_name '.existsTag(tag);']
                        })
                g(3, 'else % numeric')
                    gs(4, {
                         'prop = pointer;'
                    	[class_name '.existsProp(prop);']
                    	 ''
                         'switch prop'
                         })
                        for i = 1:1:numel(props)
                            g(5, ['case ' class_name '.' props{i}.TAG])
                                g(6, ['tag = ' class_name '.' props{i}.TAG '_TAG;'])
                        end
                        if ~strcmp(superclass_name, 'Element')
                            g(5, 'otherwise')
                                g(6, ['tag = getPropTag@' superclass_name '(prop);'])
                        end
                    g(4, 'end')
                g(3, 'end')
            g(2, 'end')

            % getPropCategory(pointer)
            g(2, 'function prop_category = getPropCategory(pointer)')
            gs(3, {
                '%GETPROPCATEGORY returns the tag of a property.'
                '%'
                '% TAG = Element.GETPROPCATEGORY(PROP) returns the'
                '%  tag of property PROP.'
                '%'
                '% TAG = Element.GETPROPCATEGORY(TAG) returns the'
                '%  tag of the property with tag TAG.'
                '%'
                '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  TAG = GETPROPCATEGORY(' upper(moniker) ', POINTER) returns tag of POINTER of ' class_name '.']
                ['%  TAG = ' upper(moniker) '.GETPROPCATEGORY(POINTER) returns tag of POINTER of ' class_name '.']
                ['%  TAG = Element.GETPROPCATEGORY(' class_name ', POINTER) returns tag of POINTER of CLASS.']
                ['%  TAG = ' upper(moniker) '.GETPROPCATEGORY(' class_name ', POINTER) returns tag of POINTER of CLASS.']
                '%'
                '% See also getPropProp, getPropTag, getPropSettings,'
                '% getPropFormat, getPropDescription, getPropDefault,'
                '% checkProp.'
                ''
                })
                gs(3, {
                    ['prop = ' class_name '.getPropProp(pointer);']
                	 ''
                     'switch prop'
                     })
                for i = 1:1:numel(props)
                    g(4, ['case ' class_name '.' props{i}.TAG])
                        g(5, ['prop_category = ' class_name '.' props{i}.TAG '_CATEGORY;'])
                end
                if ~strcmp(superclass_name, 'Element')
                    g(4, 'otherwise')
                        g(5, ['prop_category = getPropCategory@' superclass_name '(prop);'])
                end
                g(3, 'end')
            g(2, 'end')

            % getPropFormat(pointer)
            g(2, 'function prop_format = getPropFormat(pointer)')
            gs(3, {
                '%GETPROPFORMAT returns the format of a property.'
                '%'
                '% FORMAT = Element.GETPROPFORMAT(PROP) returns the'
                '%  format of property PROP.'
                '%'
                '% FORMAT = Element.GETPROPFORMAT(TAG) returns the'
                '%  format of the property with tag TAG.'
                '%'
                '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  FORMAT = GETPROPFORMAT(' upper(moniker) ', POINTER) returns format of POINTER of ' class_name '.']
                ['%  FORMAT = ' upper(moniker) '.GETPROPFORMAT(POINTER) returns format of POINTER of ' class_name '.']
                ['%  FORMAT = Element.GETPROPFORMAT(' class_name ', POINTER) returns format of POINTER of CLASS.']
                ['%  FORMAT = ' upper(moniker) '.GETPROPFORMAT(' class_name ', POINTER) returns format of POINTER of CLASS.']
                '%'
                '% See also getPropProp, getPropTag, getPropCategory,'
                '% getPropDescription, getPropSettings, getPropDefault,'
                '% checkProp.'
                ''
                })
                gs(3, {
                    ['prop = ' class_name '.getPropProp(pointer);']
                	 ''
                	 'switch prop'
                     })
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG])
                            g(5, ['prop_format = ' class_name '.' props{i}.TAG '_FORMAT;'])
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['prop_format = getPropFormat@' superclass_name '(prop);'])
                    end
                g(3, 'end')
            g(2, 'end')

            % getPropDescription(pointer)
            g(2, 'function prop_description = getPropDescription(pointer)')
            gs(3, {
                '%GETPROPDESCRIPTION returns the format of a property.'
                '%'
                '% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the'
                '%  description of the property PROP.'
                '%'
                '% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the'
                '%  description of the property with tag TAG.'
                '%'
                '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  DESCRIPTION = GETPROPDESCRIPTION(' upper(moniker) ', POINTER) returns description of POINTER of ' class_name '.']
                ['%  DESCRIPTION = ' upper(moniker) '.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ' class_name '.']
                ['%  DESCRIPTION = Element.GETPROPDESCRIPTION(' class_name ', POINTER) returns description of POINTER of CLASS.']
                ['%  DESCRIPTION = ' upper(moniker) '.GETPROPDESCRIPTION(' class_name ', POINTER) returns description of POINTER of CLASS.']
                '%'
                '% See also getPropProp, getPropTag, getPropCategory,'
                '% getPropFormat, getPropSettings, getPropDefault,'
                '% checkProp.'
                ''
                })
                gs(3, {
                    ['prop = ' class_name '.getPropProp(pointer);']
                	 ''
                     'switch prop'
                    })
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG])
                            g(5, ['prop_description = ''' props{i}.description ''';'])
                    end
                    for i = 1:1:numel(props_update)
                        g(4, ['case ' class_name '.' props_update{i}.TAG])
                            g(5, ['prop_description = ''' props_update{i}.description ''';'])
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['prop_description = getPropDescription@' superclass_name '(prop);'])
                    end
                g(3, 'end')
            g(2, 'end')

            % getPropSettings(pointer)
            g(2, 'function prop_settings = getPropSettings(pointer)')
            gs(3, {
                '%GETPROPSETTINGS returns the settings of a property.'
                '%'
                '% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the'
                '%  settings of the property PROP.'
                '%'
                '% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the'
                '%  settings of the property with tag TAG.'
                '%'
                '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  SETTINGS = GETPROPSETTINGS(' upper(moniker) ', POINTER) returns settings of POINTER of ' class_name '.']
                ['%  SETTINGS = ' upper(moniker) '.GETPROPSETTINGS(POINTER) returns settings of POINTER of ' class_name '.']
                ['%  SETTINGS = Element.GETPROPSETTINGS(' class_name ', POINTER) returns settings of POINTER of CLASS.']
                ['%  SETTINGS = ' upper(moniker) '.GETPROPSETTINGS(' class_name ', POINTER) returns settings of POINTER of CLASS.']
                '%'
                '% See also getPropProp, getPropTag, getPropCategory,'
                '% getPropFormat, getPropDescription, getPropDefault,'
                '% checkProp.'
                ''
                })
                gs(3, {
                    ['prop = ' class_name '.getPropProp(pointer);']
                	 ''
                	 'switch prop'
                     })
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG])
                            if isempty(props{i}.settings)
                                g(5, ['prop_settings = Format.getFormatSettings(Format.' props{i}.FORMAT ');'])
                            else
                                g(5, ['prop_settings = ' props{i}.settings ';'])
                            end
                    end
                    for i = 1:1:numel(props_update)
                        if ~isempty(props_update{i}.settings)
                            g(4, ['case ' class_name '.' props_update{i}.TAG])
                                g(5, ['prop_settings = ' props_update{i}.settings ';'])
                        end
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['prop_settings = getPropSettings@' superclass_name '(prop);'])
                    end
                g(3, 'end')
            g(2, 'end')

            % getPropDefault(pointer)
            g(2, 'function prop_default = getPropDefault(pointer)')
              gs(3, {
                  '%GETPROPDEFAULT returns the default value of a property/tag.'
                  '%'
                 ['% PROPDEFAULT = ' class_name '.GETPROPDEFAULT(POINTER) returns the default ']
                  '%  value of Element.'
                  '%'
                 ['% PROPDEFAULT = ' class_name '.GETPROPDEFAULT(EL, POINTER) returns the default ']
                  '%  value of a property/tag.'
                  '%'
                  '% Alternative forms to call this method are:'
                 ['%  PROPDEFAULT = ' upper(moniker) '.GETPROPDEFAULT(POINTER) returns the default value of a property/tag.']
                 ['%  PROPDEFAULT = ' upper(moniker) '.GETPROPDEFAULT(CLASS, POINTER) returns the default value of a property/tag.']
                  '%'
                  '% See also getPropSettings, getPropDescription.'
                  ''
                    })
                gs(3, {
                    ['prop = ' class_name '.getPropProp(pointer);']
                     ''
                	 'switch prop'
                     })
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG])
                            if ~isempty(props{i}.default)
                                g(5, ['prop_default = ' props{i}.default ';'])
                            else
                                g(5, ['prop_default = Format.getFormatDefault(Format.' props{i}.FORMAT ');'])
                            end                            
                    end
                    for i = 1:1:numel(props_update)
                        if ~isempty(props_update{i}.default)
                            g(4, ['case ' class_name '.' props_update{i}.TAG])
                                g(5, ['prop_default = ' props_update{i}.default ';'])
                        end                            
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, [ 'otherwise']);
                            g(5, [ 'prop_default = getPropDefault@' superclass_name '(prop);']);
                    end
                g(3, 'end')
            g(2, 'end')

            % checkProp(pointer, value)
            g(2, 'function prop_check = checkProp(pointer, value)')
              gs(3, {
                   '%CHECKPROP returns whether the property/tag is in the correct format.'
                   '%'
                  ['% PROPCHECK = ' class_name '.GETPROPDEFAULT(EL, POINTER, VALUE) returns']
                   '%  whether the property/tag is in the correct format.'
                   '%'
                   '% Alternative forms to call this method are:'
                  ['%  PROPCHECK = ' upper(moniker) '.GETPROPDEFAULT(POINTER, VALUE) returns whether  the property/tag is in the correct format.']
                   '%'
                   '% See also getPropSettings, getPropDefault.'
                   ''
                  })
                gs(3, {
                    ['prop = ' class_name '.getPropProp(pointer);']
                	 ''
                	 'switch prop'
                    })
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG]);
                            g(5, ['check = Format.checkFormat(Format.' props{i}.FORMAT ', value, ' class_name '.getPropSettings(prop));'])
                            if numel(props{i}.check_prop) > 1 || ~isempty(props{i}.check_prop{1})
                                g(5, 'if check')
                                    gs(6, props{i}.check_prop)
                                g(5, 'end')
                            end                        
                    end
                    for i = 1:1:numel(props_update)
                        if ~isempty(props_update{i}.settings) || numel(props_update{i}.check_prop) > 1 || ~isempty(props_update{i}.check_prop{1})
                            g(4, ['case ' class_name '.' props_update{i}.TAG]);
                                g(5, ['check = Format.checkFormat(Format.' props_update{i}.FORMAT ', value, ' class_name '.getPropSettings(prop));'])
                                if numel(props_update{i}.check_prop) > 1 || ~isempty(props_update{i}.check_prop{1})
                                    g(5, 'if check')
                                        gs(6, props_update{i}.check_prop)
                                    g(5, 'end')
                                end
                        end
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise')
                            g(5, ['check = checkProp@' superclass_name '(prop, value);'])
                    end
                g(3, 'end')
                g(3, '')
                g(3, 'if nargout == 1')
                    g(4, 'prop_check = check;')
                g(3, 'else')
                    g(4, 'assert( ...')
                        gs(5, {
                             'check, ...'
                        	['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT], ...']
                        	['[BRAPH2.STR '':' class_name ':'' BRAPH2.WRONG_INPUT '' '' ...']
                        	['''The value '' tostring(value, 100, '' ...'') '' is not a valid property '' ' class_name '.getPropTag(prop) '' ('' ' class_name '.getPropFormat(prop) '').''] ...']
                        	 ')'
                             })
                g(3, 'end')
            g(2, 'end')

        g(1, 'end')
    end
% 
% generate_header_graph() % only for graphs
%     function generate_header_graph()
%         get_layernumber = { ''
%             'if isempty(varargin)'
%             '\tlayernumber = 1;'
%             'else'
%             '\tlayernumber = varargin{1};'
%             'end'
%             ''};
%         if ~isempty(ensemble) || ...
%                 ~isempty(graph) || ...
%                 ~(numel(connectivity) == 1 && isempty(connectivity{1})) || ...
%                 ~(numel(directionality) == 1 && isempty(directionality{1})) || ...
%                 ~(numel(selfconnectivity) == 1 && isempty(selfconnectivity{1})) || ...
%                 ~(numel(negativity) == 1 && isempty(negativity{1}))
%             g(1, 'methods (Static) %% graph methods')
%                 if ~isempty(ensemble)
%                     g(2, 'function bool = is_ensemble()')
%                         g(3, ['bool = ' ensemble ';'])
%                     g(2, 'end')
%                 end
%                 if ~isempty(graph)
%                     g(2, 'function graph = getGraphType()')
%                         g(3, graph)
%                     g(2, 'end')
%                 end
%                 if ~(numel(connectivity) == 1 && isempty(connectivity{1}))
%                     g(2, 'function connectivity = getConnectivityType(varargin)')
%                         gs(3, get_layernumber)
%                         gs(3, connectivity)
%                     g(2, 'end')
%                 end
%                 if ~(numel(directionality) == 1 && isempty(directionality{1}))
%                     g(2, 'function directionality = getDirectionalityType(varargin)')
%                         gs(3, get_layernumber)
%                         gs(3, directionality)
%                     g(2, 'end')
%                 end
%                 if ~(numel(selfconnectivity) == 1 && isempty(selfconnectivity{1}))
%                     g(2, 'function selfconnectivity = getSelfConnectivityType(varargin)')
%                         gs(3, get_layernumber)
%                         gs(3, selfconnectivity)
%                     g(2, 'end')
%                 end
%                 if ~(numel(negativity) == 1 && isempty(negativity{1}))
%                     g(2, 'function negativity = getNegativityType(varargin)')
%                         gs(3, get_layernumber)
%                         gs(3, negativity)
%                     g(2, 'end')
%                 end
%             g(1, 'end')
%         end
%     end
% 
% generate_header_measure() % only for measures
%     function generate_header_measure()
%         if ~isempty(shape) || ...
%                 ~isempty(scope) || ...
%                 ~isempty(parametricity) || ...
%                 ~isempty(compatible_graphs)
%             g(1, 'methods (Static) %% graph methods')
%                 if ~isempty(shape)
%                     g(2, 'function shape = getMeasureShape()')
%                         g(3, shape)
%                     g(2, 'end')
%                 end
%                 if ~isempty(scope)
%                     g(2, 'function scope = getMeasureScope()')
%                         g(3, scope)
%                     g(2, 'end')
%                 end
%                 if ~isempty(parametricity)
%                     g(2, 'function parametricity = getMeasureParametricity()')
%                         g(3, parametricity)
%                     g(2, 'end')
%                 end
%                 if ~isempty(compatible_graphs)
%                     g(2, 'function list = getCompatibleGraphList()')
%                         g(3, 'list = { ...');
%                             lines = splitlines(compatible_graphs);
%                             for i = 1:1:length(lines)
%                                 g(4, ['' lines{i} ''', ...'])
%                             end
%                             g(4, '};')
%                     g(2, 'end')
%                     g(2, 'function n = getCompatibleGraphNumber()')
%                         g(3, ['n = Measure.getCompatibleGraphNumber(''' class_name ''');'])
%                     g(2, 'end')
%                 end
%             g(1, 'end')
%         end
%     end

generate_constructor()
    function generate_constructor()
        g(1, 'methods % constructor')
            g(2, ['function ' moniker ' = ' class_name '(varargin)'])
                gs(3, { ...
                    ['% ' class_name '() creates a ' descriptive_name '.'], ...
                    ''
                    })
                g(3, [moniker ' = ' moniker '@' superclass_name '(varargin{:});'])
            g(2, 'end')
        g(1, 'end')
    end

% generate_checkValue()
%     function generate_checkValue()
%         if all(cellfun(@(x) numel(x.check_value) == 1 && isempty(x.check_value{1}), props)) && all(cellfun(@(x) numel(x.check_value) == 1 && isempty(x.check_value{1}), props_update))
%             return
%         end
%         g(1, 'methods (Access=protected) % check value')
%             g(2, ['function [check, msg] = checkValue(' moniker ', prop, value)'])
%                 gs(3, {'check = true;', 'msg = '''';', ''})
%                 g(3, 'switch prop')
%                     for i = 1:1:numel(props)
%                         if numel(props{i}.check_value) > 1 || ~isempty(props{i}.check_value{1})
%                             g(4, ['case ' class_name '.' props{i}.TAG])
%                                 gs(5, props{i}.check_value)
%                                 g(5, '')
%                         end
%                     end
%                     for i = 1:1:numel(props_update)
%                         if numel(props_update{i}.check_value) > 1 || ~isempty(props_update{i}.check_value{1})
%                             g(4, ['case ' class_name '.' props_update{i}.TAG])
%                                 gs(5, props_update{i}.check_value)
%                                 g(5, '')
%                         end
%                     end
%                     g(4, 'otherwise')
%                         gs(5, {['[check, msg] = checkValue@' superclass_name '(' moniker ', prop, value);'], ''})
%                 g(3, 'end')
%             g(2, 'end')
%         g(1, 'end')
%     end
% 
% generate_calculateValue()
%     function generate_calculateValue()
%         if sum(cellfun(@(x) strcmpi(x.category, 'RESULT'), props)) == 0 && sum(cellfun(@(x) strcmpi(x.category, 'RESULT'), props_update)) == 0
%             return
%         end
%         g(1, 'methods (Access=protected) % calculate value')
%             gs(2, {['function value = calculateValue(' moniker ', prop)']; ''})
%                 g(3, 'switch prop')
%                     for i = 1:1:numel(props)
%                         if strcmpi(props{i}.category, 'RESULT')
%                             g(4, ['case ' class_name '.' props{i}.TAG])
%                                 g(5, ['rng(' moniker '.getPropSeed(' class_name '.' props{i}.TAG '), ''twister'')'])
%                                 g(5, '')
%                                 gs(5, props{i}.calculate)
%                                 g(5, '')
%                         end
%                     end
%                     for i = 1:1:numel(props_update)
%                         if strcmpi(props_update{i}.category, 'RESULT')
%                             g(4, ['case ' class_name '.' props_update{i}.TAG])
%                                 gs(5, props_update{i}.calculate)
%                                 g(5, '')
%                         end
%                     end
%                     g(4, 'otherwise')
%                         gs(5, {['value = calculateValue@' superclass_name '(' moniker ', prop);']; ''})
%                 g(3, 'end')
%             g(2, 'end')
%         g(1, 'end')
%     end
% 
% generate_methods()
%     function generate_methods()
%         if numel(methods) == 1 && isempty(methods{1})
%             return
%         end
%         g(1, 'methods % methods')
%             gs(2, methods)
%         g(1, 'end')
%     end

generate_footer()
    function generate_footer()
        g(0, 'end')
    end

fclose(object_file);    

disp(['¡! saved file: ' target_file])
disp(' ')

%% Help functions
    function g(tabs, str)
        str = regexprep(str, '%', '%%');
        fprintf(object_file, [repmat('\t', 1, tabs) str '\n']);
    end
    function gs(tabs, lines)
        for i = 1:1:length(lines)
            g(tabs, lines{i})
        end
    end
end