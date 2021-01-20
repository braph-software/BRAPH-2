function create_Element(generator_file, target_dir)
%CREATE_ELEMENT creates an element.
%
% CREATE_ELEMENT(FILE, DIR) creates the m-file of an Element from its
%  generator file FILE (with ending '.gen.m') and saves it in the target
%  directory DIR.
%
% A generator file (whose name must have ending '.gen.m', and tipically
%  starts with "_") has the following structure (the token ¡header! is
%  required, while the rest is mostly optional, unless otherwise stated):
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

%% Load info from already generated file [fc = from class]
[fc_prop_number, fc_prop_list_txt, fc_prop_list, fc_prop_tag_list] = load_from_class_prop();
    function [fc_prop_number, fc_prop_list_txt, fc_prop_list, fc_prop_tag_list] = load_from_class_prop()
        fc_prop_number = [];
        fc_prop_list_txt = {};
        fc_prop_list = '';
        fc_prop_tag_list = '';
        
        if exist(class_name, 'class') == 8
            fc_prop_number = Element.getPropNumber(class_name);

            fc_prop_list_txt = cell(Element.getPropNumber(class_name), 1);
            for prop = 1:1:Element.getPropNumber(class_name)
                fc_prop_list_txt{prop} = ['<strong>' int2str(prop) '</strong> <strong>' Element.getPropTag(class_name, prop) '</strong> \t' Element.getPropDescription(class_name, prop)];
                fc_prop_list = [fc_prop_list ' ' int2str(prop) ' ']; %#ok<AGROW>
                fc_prop_tag_list = [fc_prop_tag_list ' ''' Element.getPropTag(class_name, prop) ''' ']; %#ok<AGROW>
            end
        end
    end

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
        gs(1, {
            ['% ' class_name ' ' header_description '.']
            ['% It is a subclass of <a href="matlab:help ' superclass_name '">' superclass_name '</a>.']
             '%'
            })
        gs(1, cellfun(@(x) ['% ' x], description, 'UniformOutput', false))
        gs(1, {
             '%'
            ['% The list of ' class_name ' properties is:']
            })
        gs(1, cellfun(@(x) ['%  ' x], fc_prop_list_txt, 'UniformOutput', false))
        if ~isempty(seealso)
            gs(1, {
                 '%'
                ['% See also ' seealso '.']
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
                if isempty(fc_prop_number)
                    g(3, ['prop_number = numel(' class_name '.getProps());'])
                else
                    gs(3, { 
                         '% hardcoded for computational efficiency'
                        ['prop_number = ' int2str(fc_prop_number) ';']
                        })
                end
            g(2, 'end')

            % existsProp(prop)
            g(2, 'function check = existsProp(prop)')
                g(3, 'if nargout == 1')
                    if isempty(fc_prop_list)
                        g(4, ['check = any(prop == ' class_name '.getProps());'])
                    else
                        gs(4, {
                             '% hardcoded for computational efficiency'
                            ['check = any(prop == [' fc_prop_list ']);']
                            })
                    end
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
                if isempty(fc_prop_tag_list)
                    gs(3, {
                         '% persistent variable for computational efficiency'
                        ['persistent ' lower(class_name) '_tag_list']
                        ['if isempty(' lower(class_name) '_tag_list)']
                        ['\t' lower(class_name) '_tag_list = cellfun(@(x) ' class_name '.getPropTag(x), num2cell(' class_name '.getProps()), ''UniformOutput'', false);']
                         'end'
                         ''
                        })
                    g(3, 'if nargout == 1')
                        g(4, ['check = any(strcmpi(tag, ' lower(class_name) '_tag_list));'])
                else
                    g(3, 'if nargout == 1')
                        gs(4, {
                             '% hardcoded for computational efficiency'
                            [lower(class_name) '_tag_list = {' fc_prop_tag_list '};']
                             ''
                            })
                        g(4, ['check = any(strcmpi(tag, ' lower(class_name) '_tag_list));'])
                end
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
                if isempty(fc_prop_tag_list)
                    gs(3, {
                         '% persistent variable for computational efficiency'
                        ['persistent ' lower(class_name) '_tag_list']
                        ['if isempty(' lower(class_name) '_tag_list)']
                        ['\t' lower(class_name) '_tag_list = cellfun(@(x) ' class_name '.getPropTag(x), num2cell(' class_name '.getProps()), ''UniformOutput'', false);']
                         'end'
                         ''
                        })
                    g(3, 'if ischar(pointer)')
                        gs(4, {
                             'tag = pointer;'
                            [class_name '.existsTag(tag);']
                             ''
                            ['prop = find(strcmpi(tag, ' lower(class_name) '_tag_list));']
                             })
                else
                    g(3, 'if ischar(pointer)')
                        gs(4, {
                             '% hardcoded for computational efficiency'
                            [lower(class_name) '_tag_list = {' fc_prop_tag_list '};']
                             ''
                            })
                        gs(4, {
                             'tag = pointer;'
                            [class_name '.existsTag(tag);']
                             ''
                            ['prop = find(strcmpi(tag, ' lower(class_name) '_tag_list));']
                             })
                end                
                g(3, 'else % numeric')
                    gs(4, {
                         'prop = pointer;'
                        [class_name '.existsProp(prop);']
                        })
                g(3, 'end')
            g(2, 'end')

            % getPropTag(pointer)
            g(2, 'function tag = getPropTag(pointer)')
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
                    ['prop = ' class_name '.getPropProp(pointer);']
                     ''
                	 'switch prop'
                     })
                    for i = 1:1:numel(props)
                        g(4, ['case ' class_name '.' props{i}.TAG])
                            if ~isempty(props{i}.default)
                                g(5, ['prop_default = ' props{i}.default ';'])
                            else
                                g(5, ['prop_default = Format.getFormatDefault(Format.' props{i}.FORMAT ', ' class_name '.getPropSettings(prop));'])
                            end                            
                    end
                    for i = 1:1:numel(props_update)
                        if ~isempty(props_update{i}.default)
                            g(4, ['case ' class_name '.' props_update{i}.TAG])
                                g(5, ['prop_default = ' props_update{i}.default ';'])
                        end                            
                    end
                    if ~strcmp(superclass_name, 'Element')
                        g(4, 'otherwise');
                            g(5, [ 'prop_default = getPropDefault@' superclass_name '(prop);']);
                    end
                g(3, 'end')
            g(2, 'end')

            % checkProp(pointer, value)
            g(2, 'function prop_check = checkProp(pointer, value)')
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
                gs(3, {
                    ['% ' class_name '() creates a ' descriptive_name '.']
                     '%'
                    ['% ' class_name '(PROP, VALUE, ...) with property PROP initialized to VALUE.']
                     '%'
                    ['% ' class_name '(TAG, VALUE, ...) with property with tag TAG set to VALUE.']
                     '%'
                    '% Multiple properties can be initialized at once identifying'
                    '%  them with either property numbers (PROP) or tags (TAG).'
                    '%'
                    ['% The list of ' class_name ' properties is:']
                    })
                gs(3, cellfun(@(x) ['%  ' x], fc_prop_list_txt, 'UniformOutput', false))
                gs(3, {
                    '%'
                    '% See also Category, Format, set, check.'
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

generate_calculateValue()
    function generate_calculateValue()
        if sum(cellfun(@(x) strcmpi(x.category, 'RESULT'), props)) == 0 && sum(cellfun(@(x) strcmpi(x.category, 'RESULT'), props_update)) == 0
            return
        end
        g(1, 'methods (Access=protected) % calculate value')
            gs(2, {['function value = calculateValue(' moniker ', prop)']; ''})
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        if strcmpi(props{i}.category, 'RESULT')
                            if ~(numel(props{i}.calculate) == 1 && isempty(props{i}.calculate{1}))
                                g(4, ['case ' class_name '.' props{i}.TAG])
                                    g(5, ['rng(' moniker '.getPropSeed(' class_name '.' props{i}.TAG '), ''twister'')'])
                                    g(5, '')
                                    gs(5, props{i}.calculate)
                                    g(5, '')
                            end
                        end
                    end
                    for i = 1:1:numel(props_update)
                        if strcmpi(props_update{i}.category, 'RESULT')
                            if ~(numel(props_update{i}.calculate) == 1 && isempty(props_update{i}.calculate{1}))
                                g(4, ['case ' class_name '.' props_update{i}.TAG])
                                    gs(5, props_update{i}.calculate)
                                    g(5, '')
                            end
                        end
                    end
                    g(4, 'otherwise')
                        gs(5, {['value = calculateValue@' superclass_name '(' moniker ', prop);']; ''})
                g(3, 'end')
            g(2, 'end')
        g(1, 'end')
    end

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