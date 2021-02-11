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
% Only for graphs:
%  <strong>%%% ¡ensemble!</strong>
%   Whether graph is ensemble graph (false or true).
%  <strong>%%% ¡graph!</strong>
%   Graph type (GRAPH, MULTIGRAPH, ORDERED_MULTIPLEX, MULTIPLEX, ORDERED_MULTILAYER, MULTILAYER).
%  <strong>%%% ¡connectivity!</strong>
%   Graph connectivity (WEIGHTED, BINARY).
%  <strong>%%% ¡directionality!</strong>
%   Graph directionality (DIRECTED, UNDIRECTED).
%  <strong>%%% ¡selfconnectivity!</strong>
%   Graph self-connectivity (NONSELFCONNECTED, SELFCONNECTED).
%  <strong>%%% ¡negativity!</strong>
%   Graph negativity (NONNEGATIVE, NEGATIVE).
%
% Only for measures:
%  <strong>%%% ¡shape!</strong>
%   Measure shape (GLOBAL, NODAL, BINODAL).
%  <strong>%%% ¡scope!</strong>
%   Measure scope (SUPERGLOBAL, UNILAYER, BILAYER).
%  <strong>%%% ¡parametricity!</strong>
%   Measure parametricity (PARAMETRIC, NONPARAMETRIC).
%  <strong>%%% ¡compatible_graphs!</strong>
%  Lis of compatible graphs with the measure.
% 
%<strong>%% ¡props!</strong>
% <strong>%%% ¡prop!</strong>
%  <tag1> (<category>, <format>) <description>.
%  <strong>%%%% ¡settings!</strong>
%   Prop settings, depending on format.
%  <strong>%%%% ¡conditioning!</strong>
%   Code to condition value (before checks and calculation).
%   Can be on multiple lines.
%   The prop value is in the variable 'value', 
%   where also the modified prop value is returned.
%   The conditioned value should be in variable 'value'.
%  <strong>%%%% ¡postprocessing!</strong>
%   Postprocessign code (executed after setting, but before checking, value).
%   Can be on multiple lines.
%   Does not return anything.
%  <strong>%%%% ¡check_prop!</strong>
%   Code to check prop format (before calculation).
%   Can be on multiple lines.
%   The prop value is in the variable 'value'.
%   The outcome should be in variable 'check'.
%  <strong>%%%% ¡check_value!</strong>
%   Code to check prop value (after calculation).
%   Can be on multiple lines.
%   The prop value is in the variable 'value'.
%   The outcome should be in variable 'check' and the message in 'msg'.
%  <strong>%%%% ¡default!</strong>
%   Prop default value (seldom needed).
%  <strong>%%%% ¡calculate!</strong>
%   Code to calculate prop results (only for category RESULT).
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
%  <strong>%%%% ¡conditioning!</strong>
%   Update value conditioning (before checks and calculation).
%  <strong>%%%% ¡postprocessing!</strong>
%   Update value postprocessing (after setting, bur before checking, value).
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
%<strong>%% ¡constants!</strong>
% Constants.
% 
%<strong>%% ¡properties!</strong>
% Properties (private).
% 
%<strong>%% ¡staticmethods!</strong>
% Static methods written as functions including the relative documentation.
% 
%<strong>%% ¡methods!</strong>
% Class methods written as functions including the relative documentation.
%
%<strong>%% ¡tests!</strong>
% <strong>%%% ¡test!</strong>
%  <strong>%%%% ¡name!</strong>
%  Name of the text on a single line.
%  <strong>%%%% ¡code!</strong>
%  Code of the text.
%  Can be on multiple lines.
% <strong>%%% ¡test!</strong>
%  ...
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

[ensemble, graph, connectivity, directionality, selfconnectivity, negativity] = analyze_header_graph(); % only for graphs
    function [ensemble, graph, connectivity, directionality, selfconnectivity, negativity] = analyze_header_graph()
        ensemble = getToken(txt, 'header', 'ensemble');
        graph = getToken(txt, 'header', 'graph');
        connectivity = splitlines(getToken(txt, 'header', 'connectivity'));
        directionality = splitlines(getToken(txt, 'header', 'directionality'));
        selfconnectivity = splitlines(getToken(txt, 'header', 'selfconnectivity'));
        negativity = splitlines(getToken(txt, 'header', 'negativity'));
    end

[shape, scope, parametricity, compatible_graphs] = analyze_header_measure(); % only for measures
    function [shape, scope, parametricity, compatible_graphs] = analyze_header_measure()
        shape = getToken(txt, 'header', 'shape');
        scope = getToken(txt, 'header', 'scope');
        parametricity = getToken(txt, 'header', 'parametricity');
        compatible_graphs = getToken(txt, 'header', 'compatible_graphs');
    end

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
            props{i}.conditioning = splitlines(getToken(props{i}.token, 'conditioning'));
            props{i}.postprocessing = splitlines(getToken(props{i}.token, 'postprocessing'));
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
            props_update{i}.conditioning = splitlines(getToken(props_update{i}.token, 'conditioning'));
            props_update{i}.postprocessing = splitlines(getToken(props_update{i}.token, 'postprocessing'));
            props_update{i}.check_prop = splitlines(getToken(props_update{i}.token, 'check_prop'));
            props_update{i}.check_value = splitlines(getToken(props_update{i}.token, 'check_value'));
            props_update{i}.default = getToken(props_update{i}.token, 'default');
            props_update{i}.calculate = splitlines(getToken(props_update{i}.token, 'calculate'));
        end
    end

constants = splitlines(getToken(txt, 'constants'));

properties = splitlines(getToken(txt, 'properties'));

staticmethods = splitlines(getToken(txt, 'staticmethods'));

methods = splitlines(getToken(txt, 'methods'));

%% Load info from already generated file [fc = from class]
element_class_created = exist(class_name, 'class') == 8;
[fc_prop_list_txt, fc_prop_list, fc_prop_tag_list] = load_from_class_prop();
    function [fc_prop_list_txt, fc_prop_list, fc_prop_tag_list] = load_from_class_prop()
        fc_prop_list_txt = {};
        fc_prop_list = '';
        fc_prop_tag_list = '';
        if element_class_created
            fc_prop_list_txt = cell(Element.getPropNumber(class_name), 1);
            for prop = 1:1:Element.getPropNumber(class_name)
                fc_prop_list_txt{prop} = ['<strong>' int2str(prop) '</strong> <strong>' Element.getPropTag(class_name, prop) '</strong> \t' Element.getPropDescription(class_name, prop)];
                fc_prop_list = [fc_prop_list ' ' int2str(prop) ' ']; %#ok<AGROW>
                fc_prop_tag_list = [fc_prop_tag_list ' ''' Element.getPropTag(class_name, prop) ''' ']; %#ok<AGROW>
            end
        end
    end

CET = '% COMPUTATIONAL EFFICIENCY TRICK';

%% Generate file
file_str = [];

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
        if element_class_created
% element-specific constants
        end       
        gs(1, {
             '%'
            ['% The list of ' class_name ' properties is:']
            })
        gs(1, cellfun(@(x) ['%  ' x], fc_prop_list_txt, 'UniformOutput', false))
        gs(1, {
             '%'
            ['% ' class_name ' constructor:']
            ['%  ' class_name ' - constructor']
            })
        if element_class_created
% class-specific methods
% m = methods('Element')
% m = methods('Element', '-full')
% txt = help('Plot.set')
% class-specific static methods
        end
        gs(1, {
             '%'
            ['% ' class_name ' methods:']
             '%  set - sets the value of a property'
             '%  check - checks the values of all properties'
             '%  getr - returns the raw value of a property'
             '%  get - returns the value of a property'
             '%  memorize - returns and memorizes the value of a property'
             '%  getPropSeed - returns the seed of a property'
             '%  isLocked - returns whether a property is locked'
             '%  lock - locks unreversibly a property'
             '%  isChecked - returns whether a property is checked'
             '%  checked - sets a property to checked'
             '%  unchecked - sets a property to NOT checked'
             '%'
            ['% ' class_name ' methods (operators):']
            ['%  isequal - determines whether two ' class_name ' are equal (values, locked)']
             '%'
            ['% ' class_name ' methods (display):']
            ['%  tostring - string with information about the ' class_name]
            ['%  disp - displays information about the ' class_name]
            ['%  tree - displays the element of ' class_name]
             '%'
            ['% ' class_name ' method (element list):']
            ['%  getElementList - returns a list with all subelements of ' class_name]
             '%'
            ['% ' class_name ' method (JSON encode):']
            ['%  encodeJSON - returns a JSON string encoding the ' class_name]
             '%'
            ['% ' class_name ' method (JSON decode, Static):']
            ['%  decodeJSON - returns a JSON string encoding the ' class_name]
             '%'
            ['% ' class_name ' methods (copy):']
            ['%  copy - copies the ' class_name]
            ['%  clone - clones the ' class_name]
            '%'
            ['% ' class_name ' methods (inspection, Static):']
            ['%  getClass - returns ' class_name]
            ['%  getName - returns the name of ' class_name]
            ['%  getDescription - returns the description of ' class_name]
            ['%  getProps - returns the property list of ' class_name]
            ['%  getPropNumber - returns the property number of ' class_name]
             '%  existsProp - checks whether property exists/error'
             '%  existsTag - checks whether tag exists/error'
             '%  getPropProp - returns the property number of a property'
             '%  getPropTag - returns the tag of a property'
             '%  getPropCategory - returns the category of a property'
             '%  getPropFormat - returns the format of a property'
             '%  getPropDescription - returns the description of a property'
             '%  getPropSettings - returns the settings of a property'
             '%  getPropDefault - returns the default value of a property'
             '%  checkProp - checks whether a value has the correct format/error'
             '%'
            ['% ' class_name ' methods (category, Static):']
             '%  getCategories - returns the list of categories'
             '%  getCategoryNumber - returns the number of categories'
             '%  existsCategory - returns whether a category exists/error'
             '%  getCategoryName - returns the name of a category'
             '%  getCategoryDescription - returns the description of a category'
             '%'
            ['% ' class_name ' methods (format, Static):']
             '%  getFormats - returns the list of formats'
             '%  getFormatNumber - returns the number of formats'
             '%  existsFormat - returns whether a format exists/error'
             '%  getFormatName - returns the name of a format'
             '%  getFormatDescription - returns the description of a format'
             '%  getFormatSettings - returns the settings for a format'
             '%  getFormatDefault - returns the default value for a format'
             '%  checkFormat - returns whether a value format is correct/error'
            })
        if ~isempty(seealso)
            gs(1, {
                 '%'
                ['% See also ' seealso '.']
                })
        end
        g(1, '')
    end

generate_constants()
    function generate_constants()
        if numel(constants) == 1 && isempty(constants{1})
            return
        end
        g(1, 'properties (Constant) % constants')
            gs(2, constants)
        g(1, 'end')
    end

generate_properties()
    function generate_properties()
        if numel(properties) == 1 && isempty(properties{1})
            return
        end
        g(1, 'properties (Access = private) % element properties')
            gs(2, properties)
        g(1, 'end')
    end

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
                if ~element_class_created
                    g(3, [moniker '_name = regexprep(''' descriptive_name ''', ''(\\<[a-z])'', ''${upper($1)}'');']) % note use of "\\<" instead of "\<" to deal with special character
                else
                    gs(3, {
                         CET
                        [moniker '_name = ''' Element.getName(class_name) ''';']
                        })
                end
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
                if ~element_class_created
                    g(3, ['prop_number = numel(' class_name '.getProps());'])
                else
                    gs(3, { 
                         CET
                        ['prop_number = ' int2str(Element.getPropNumber(class_name)) ';']
                        })
                end
            g(2, 'end')

            % existsProp(prop)
            g(2, 'function check = existsProp(prop)')
                gs(3, {
                    ['%EXISTSPROP checks whether property exists in ' descriptive_name '/error.']
                     '%'
                     ['% CHECK = ' class_name '.EXISTSPROP(PROP) checks whether the property PROP exists.']
                     '%'                    
                     '% Alternative forms to call this method are:'
                    ['%  CHECK = ' upper(moniker) '.EXISTSPROP(PROP) checks whether PROP exists for ' upper(moniker) '.']
                    ['%  CHECK = Element.EXISTSPROP(' upper(moniker) ', PROP) checks whether PROP exists for ' upper(moniker) '.']
                    ['%  CHECK = Element.EXISTSPROP(' class_name ', PROP) checks whether PROP exists for ' class_name '.']
                     '%'
                     '% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.'
                    ['%  Error id: [BRAPH2:' class_name ':WrongInput]']
                     '%'
                     '% Alternative forms to call this method are:'
                    ['%  ' upper(moniker) '.EXISTSPROP(PROP) throws error if PROP does NOT exist for ' upper(moniker) '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                    ['%  Element.EXISTSPROP(' upper(moniker) ', PROP) throws error if PROP does NOT exist for ' upper(moniker) '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                    ['%  Element.EXISTSPROP(' class_name ', PROP) throws error if PROP does NOT exist for ' class_name '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                     '%'
                     '% See also getProps, existsTag.'
                     ''
                    })
                g(3, 'if nargout == 1')
                    if isempty(fc_prop_list)
                        g(4, ['check = any(prop == ' class_name '.getProps());'])
                    else
                        gs(4, {
                             CET
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
                gs(3, {
                    ['%EXISTSTAG checks whether tag exists in ' descriptive_name '/error.']
                     '%'
                     ['% CHECK = ' class_name '.EXISTSTAG(TAG) checks whether a property with tag TAG exists.']
                     '%'                    
                     '% Alternative forms to call this method are:'
                    ['%  CHECK = ' upper(moniker) '.EXISTSTAG(TAG) checks whether TAG exists for ' upper(moniker) '.']
                    ['%  CHECK = Element.EXISTSTAG(' upper(moniker) ', TAG) checks whether TAG exists for ' upper(moniker) '.']
                    ['%  CHECK = Element.EXISTSTAG(' class_name ', TAG) checks whether TAG exists for ' class_name '.']
                     '%'
                     '% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.'
                    ['%  Error id: [BRAPH2:' class_name ':WrongInput]']
                     '%'
                     '% Alternative forms to call this method are:'
                    ['%  ' upper(moniker) '.EXISTSTAG(TAG) throws error if TAG does NOT exist for ' upper(moniker) '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                    ['%  Element.EXISTSTAG(' upper(moniker) ', TAG) throws error if TAG does NOT exist for ' upper(moniker) '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                    ['%  Element.EXISTSTAG(' class_name ', TAG) throws error if TAG does NOT exist for ' class_name '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                     '%'
                     '% See also getProps, existsTag.'
                     ''
                     })
                if isempty(fc_prop_tag_list)
                    gs(3, {
                         CET
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
                             CET
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
            gs(3, {
                '%GETPROPPROP returns the property number of a property.'
                '%'
                '% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the '
                '%  property number of the property PROP.'
                '%'
                '% PROP = Element.GETPROPPROP(TAG) returns the property number '
                '%  of the property with tag TAG.'
                '%'
                '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  PROPERTY = ' upper(moniker) '.GETPROPPROP(POINTER) returns property number of POINTER of ' upper(moniker) '.']
                ['%  PROPERTY = Element.GETPROPPROP(' class_name ', POINTER) returns property number of POINTER of ' class_name '.']
                ['%  PROPERTY = ' upper(moniker) '.GETPROPPROP(' class_name ', POINTER) returns property number of POINTER of ' class_name '.']
                '%'
                '% See also getPropFormat, getPropTag, getPropCategory,'
                '% getPropDescription, getPropSettings, getPropDefault,'
                '% checkProp.'
                ''
                })
                if isempty(fc_prop_tag_list)
                    gs(3, {
                         CET
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
                             CET
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
            gs(3, {
                '%GETPROPTAG returns the tag of a property.'
                '%'
                '% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the '
                '%  property PROP.'
                '%'
                '% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of '
                '%  the property with tag TAG.'
                '%'
                '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  TAG = ' upper(moniker) '.GETPROPTAG(POINTER) returns tag of POINTER of ' upper(moniker) '.']
                ['%  TAG = Element.GETPROPTAG(' class_name ', POINTER) returns tag of POINTER of ' class_name '.']
                ['%  TAG = ' upper(moniker) '.GETPROPTAG(' class_name ', POINTER) returns tag of POINTER of ' class_name '.']
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
                '%GETPROPCATEGORY returns the category of a property.'
                '%'
                '% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the'
                '%  category of the property PROP.'
                '%'
                '% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the'
                '%  category of the property with tag TAG.'
                '%'
                '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  CATEGORY = ' upper(moniker) '.GETPROPCATEGORY(POINTER) returns category of POINTER of ' upper(moniker) '.']
                ['%  CATEGORY = Element.GETPROPCATEGORY(' class_name ', POINTER) returns category of POINTER of ' class_name '.']
                ['%  CATEGORY = ' upper(moniker) '.GETPROPCATEGORY(' class_name ', POINTER) returns category of POINTER of ' class_name '.']
                '%'
                '% See also Category, getPropProp, getPropTag, getPropSettings,'
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
                '%  format of the property PROP.'
                '%'
                '% FORMAT = Element.GETPROPFORMAT(TAG) returns the'
                '%  format of the property with tag TAG.'
                '%'
                '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  FORMAT = ' upper(moniker) '.GETPROPFORMAT(POINTER) returns format of POINTER of ' upper(moniker) '.']
                ['%  FORMAT = Element.GETPROPFORMAT(' class_name ', POINTER) returns format of POINTER of ' class_name '.']
                ['%  FORMAT = ' upper(moniker) '.GETPROPFORMAT(' class_name ', POINTER) returns format of POINTER of ' class_name '.']
                '%'
                '% See also Format, getPropProp, getPropTag, getPropCategory,'
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
                '%GETPROPDESCRIPTION returns the description of a property.'
                '%'
                '% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the'
                '%  description of the property PROP.'
                '%'
                '% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the'
                '%  description of the property with tag TAG.'
                '%'
                '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                ['%  DESCRIPTION = ' upper(moniker) '.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ' upper(moniker) '.']
                ['%  DESCRIPTION = Element.GETPROPDESCRIPTION(' class_name ', POINTER) returns description of POINTER of ' class_name '.']
                ['%  DESCRIPTION = ' upper(moniker) '.GETPROPDESCRIPTION(' class_name ', POINTER) returns description of POINTER of ' class_name '.']
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
                ['%  SETTINGS = ' upper(moniker) '.GETPROPSETTINGS(POINTER) returns settings of POINTER of ' upper(moniker) '.']
                ['%  SETTINGS = Element.GETPROPSETTINGS(' class_name ', POINTER) returns settings of POINTER of ' class_name '.']
                ['%  SETTINGS = ' upper(moniker) '.GETPROPSETTINGS(' class_name ', POINTER) returns settings of POINTER of ' class_name '.']
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
                     '%GETPROPDEFAULT returns the default value of a property.'
                     '%'
                    ['% DEFAULT = ' class_name '.GETPROPDEFAULT(PROP) returns the default ']
                     '%  value of the property PROP.'
                     '%'
                    ['% DEFAULT = ' class_name '.GETPROPDEFAULT(TAG) returns the default ']
                     '%  value of the property with tag TAG.'
                     '%'
                     '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                    ['%  DEFAULT = ' upper(moniker) '.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ' upper(moniker) '.']
                    ['%  DEFAULT = Element.GETPROPDEFAULT(' class_name ', POINTER) returns the default value of POINTER of ' class_name '.']
                    ['%  DEFAULT = ' upper(moniker) '.GETPROPDEFAULT(' class_name ', POINTER) returns the default value of POINTER of ' class_name '.']
                     '%'
                     '% See also getPropProp, getPropTag, getPropSettings, '
                     '% getPropCategory, getPropFormat, getPropDescription, '
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
                     '%CHECKPROP checks whether a value has the correct format/error.'
                     '%'
                    ['% CHECK = ' upper(moniker) '.CHECKPROP(POINTER, VALUE) checks whether']
                     '%  VALUE is an acceptable value for the format of the property'
                     '%  POINTER (POINTER = PROP or TAG).'
                     '% '
                     '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                    ['%  CHECK = ' upper(moniker) '.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ' upper(moniker) '.']
                    ['%  CHECK = Element.CHECKPROP(' class_name ', PROP, VALUE) checks VALUE format for PROP of ' class_name '.']
                    ['%  CHECK = ' upper(moniker) '.CHECKPROP(' class_name ', PROP, VALUE) checks VALUE format for PROP of ' class_name '.']
                     '% ' 
                    ['% ' upper(moniker) '.CHECKPROP(POINTER, VALUE) throws an error if VALUE is']
                     '%  NOT an acceptable value for the format of the property POINTER.'
                    ['%  Error id: [BRAPH2:' class_name ':WrongInput]']
                     '% '
                     '% Alternative forms to call this method are (POINTER = PROP or TAG):'
                    ['%  ' upper(moniker) '.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ' upper(moniker) '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                    ['%  Element.CHECKPROP(' class_name ', PROP, VALUE) throws error if VALUE has not a valid format for PROP of ' class_name '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                    ['%  ' upper(moniker) '.CHECKPROP(' class_name ', PROP, VALUE) throws error if VALUE has not a valid format for PROP of ' class_name '.']
                    ['%   Error id: [BRAPH2:' class_name ':WrongInput]']
                     '% '
                     '% See also Format, getPropProp, getPropTag, getPropSettings,'
                     '% getPropCategory, getPropFormat, getPropDescription,'
                     '% getPropDefault.'
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

generate_header_graph() % only for graphs
    function generate_header_graph()
        get_layernumber = { ''
            'if isempty(varargin)'
            '\tlayernumber = 1;'
            'else'
            '\tlayernumber = varargin{1};'
            'end'
            ''};
        if ~isempty(ensemble) || ...
                ~isempty(graph) || ...
                ~(numel(connectivity) == 1 && isempty(connectivity{1})) || ...
                ~(numel(directionality) == 1 && isempty(directionality{1})) || ...
                ~(numel(selfconnectivity) == 1 && isempty(selfconnectivity{1})) || ...
                ~(numel(negativity) == 1 && isempty(negativity{1}))
            g(1, 'methods (Static) %% graph methods')
                if ~isempty(ensemble)
                    g(2, 'function bool = is_ensemble()')
                        g(3, ['bool = ' ensemble ';'])
                    g(2, 'end')
                end
                if ~isempty(graph)
                    g(2, 'function graph = getGraphType()')
                        g(3, graph)
                    g(2, 'end')
                end
                if ~(numel(connectivity) == 1 && isempty(connectivity{1}))
                    g(2, 'function connectivity = getConnectivityType(varargin)')
                        gs(3, get_layernumber)
                        gs(3, connectivity)
                    g(2, 'end')
                end
                if ~(numel(directionality) == 1 && isempty(directionality{1}))
                    g(2, 'function directionality = getDirectionalityType(varargin)')
                        gs(3, get_layernumber)
                        gs(3, directionality)
                    g(2, 'end')
                end
                if ~(numel(selfconnectivity) == 1 && isempty(selfconnectivity{1}))
                    g(2, 'function selfconnectivity = getSelfConnectivityType(varargin)')
                        gs(3, get_layernumber)
                        gs(3, selfconnectivity)
                    g(2, 'end')
                end
                if ~(numel(negativity) == 1 && isempty(negativity{1}))
                    g(2, 'function negativity = getNegativityType(varargin)')
                        gs(3, get_layernumber)
                        gs(3, negativity)
                    g(2, 'end')
                end
            g(1, 'end')
        end
    end

generate_header_measure() % only for measures
    function generate_header_measure()
        if ~isempty(shape) || ...
                ~isempty(scope) || ...
                ~isempty(parametricity) || ...
                ~isempty(compatible_graphs)
            g(1, 'methods (Static) %% graph methods')
                if ~isempty(shape)
                    g(2, 'function shape = getMeasureShape()')
                        g(3, shape)
                    g(2, 'end')
                end
                if ~isempty(scope)
                    g(2, 'function scope = getMeasureScope()')
                        g(3, scope)
                    g(2, 'end')
                end
                if ~isempty(parametricity)
                    g(2, 'function parametricity = getMeasureParametricity()')
                        g(3, parametricity)
                    g(2, 'end')
                end
                if ~isempty(compatible_graphs)
                    g(2, 'function list = getCompatibleGraphList()')
                        g(3, 'list = { ...');
                            lines = splitlines(compatible_graphs);
                            for i = 1:1:length(lines)
                                g(4, ['' lines{i} ''', ...'])
                            end
                            g(4, '};')
                    g(2, 'end')
                    g(2, 'function n = getCompatibleGraphNumber()')
                        g(3, ['n = Measure.getCompatibleGraphNumber(''' class_name ''');'])
                    g(2, 'end')
                end
            g(1, 'end')
        end
    end

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

generate_conditioning()
    function generate_conditioning()
        if all(cellfun(@(x) numel(x.conditioning) == 1 && isempty(x.conditioning{1}), props)) && all(cellfun(@(x) numel(x.conditioning) == 1 && isempty(x.conditioning{1}), props_update))
            return
        end
        g(1, 'methods (Access=protected) % conditioning')
            g(2, ['function value = conditioning(' moniker ', prop, value)'])
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        if numel(props{i}.conditioning) > 1 || ~isempty(props{i}.conditioning{1})
                            g(4, ['case ' class_name '.' props{i}.TAG])
                                gs(5, props{i}.conditioning)
                                g(5, '')
                        end
                    end
                    for i = 1:1:numel(props_update)
                        if numel(props_update{i}.conditioning) > 1 || ~isempty(props_update{i}.conditioning{1})
                            g(4, ['case ' class_name '.' props_update{i}.TAG])
                                gs(5, props_update{i}.conditioning)
                                g(5, '')
                        end
                    end
                    g(4, 'otherwise')
                        gs(5, {['value = conditioning@' superclass_name '(' moniker ', prop, value);'], ''})
                g(3, 'end')
            g(2, 'end')
        g(1, 'end')
    end

generate_postprocessing()
    function generate_postprocessing()
        if all(cellfun(@(x) numel(x.postprocessing) == 1 && isempty(x.postprocessing{1}), props)) && all(cellfun(@(x) numel(x.postprocessing) == 1 && isempty(x.postprocessing{1}), props_update))
            return
        end
        g(1, 'methods (Access=protected) % postprocessing')
            g(2, ['function postprocessing(' moniker ', prop)'])
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        if numel(props{i}.postprocessing) > 1 || ~isempty(props{i}.postprocessing{1})
                            g(4, ['case ' class_name '.' props{i}.TAG])
                                gs(5, props{i}.postprocessing)
                                g(5, '')
                        end
                    end
                    for i = 1:1:numel(props_update)
                        if numel(props_update{i}.postprocessing) > 1 || ~isempty(props_update{i}.postprocessing{1})
                            g(4, ['case ' class_name '.' props_update{i}.TAG])
                                gs(5, props_update{i}.postprocessing)
                                g(5, '')
                        end
                    end
                    g(4, 'otherwise')
                        gs(5, {['postprocessing@' superclass_name '(' moniker ', prop);'], ''})
                g(3, 'end')
            g(2, 'end')
        g(1, 'end')
    end

generate_checkValue()
    function generate_checkValue()
        if all(cellfun(@(x) numel(x.check_value) == 1 && isempty(x.check_value{1}), props)) && all(cellfun(@(x) numel(x.check_value) == 1 && isempty(x.check_value{1}), props_update))
            return
        end
        g(1, 'methods (Access=protected) % check value')
            g(2, ['function [check, msg] = checkValue(' moniker ', prop, value)'])
                gs(3, {
                     'check = true;'
                    ['msg = [''Error while checking'' tostring(' moniker ') '' '' ' moniker '.getPropTag(prop) ''.''];']
                     ''
                     })
                g(3, 'switch prop')
                    for i = 1:1:numel(props)
                        if numel(props{i}.check_value) > 1 || ~isempty(props{i}.check_value{1})
                            g(4, ['case ' class_name '.' props{i}.TAG])
                                gs(5, props{i}.check_value)
                                g(5, '')
                        end
                    end
                    for i = 1:1:numel(props_update)
                        if numel(props_update{i}.check_value) > 1 || ~isempty(props_update{i}.check_value{1})
                            g(4, ['case ' class_name '.' props_update{i}.TAG])
                                gs(5, props_update{i}.check_value)
                                g(5, '')
                        end
                    end
                    g(4, 'otherwise')
                        gs(5, {['[check, msg] = checkValue@' superclass_name '(' moniker ', prop, value);'], ''})
                g(3, 'end')
            g(2, 'end')
        g(1, 'end')
    end

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

generate_methods()
    function generate_methods()
        if numel(methods) == 1 && isempty(methods{1})
            return
        end
        g(1, 'methods % methods')
            gs(2, methods)
        g(1, 'end')
    end

generate_footer()
    function generate_footer()
        g(0, 'end')
    end

%% Save file
target_file = [target_dir filesep() class_name '.m'];
object_file = fopen(target_file, 'w');
fprintf(object_file, file_str);
fclose(object_file);

disp(['¡! saved file: ' target_file])
disp(' ')

%% Help functions
    function g(tabs, str)
        str = regexprep(str, '%', '%%');
        file_str = [file_str repmat('\t', 1, tabs) str '\n'];
    end
    function gs(tabs, lines)
        for i = 1:1:length(lines)
            g(tabs, lines{i})
        end
    end
end
