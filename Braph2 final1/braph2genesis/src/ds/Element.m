classdef Element < Category & Format & matlab.mixin.Copyable
    %TODO: revise docs
    %Element is the base class for all elements.
    % Element provides the infrastructure necessary for all elements. Even
    %  though it is possible to create instances of Element, typically 
    %  one uses its subclasses. It is a subclass of Category, Format,
    %  handle, and matlab.mixin.Copyable.
    %
    % Each element is essentially a container for a series of properties.
    %  Each propery has a category (see <a href="matlab:help Category">Category</a>) and a format (see <a href="matlab:help Format">Format</a>).
    %  Each subelement can implement the following protected methods:
    %   conditioning - conditions a value before setting a property
    %   calculateValue - calculates the value of a property
    %   checkValue - checks the value of a property after it is calculated
    %   postprocessing - postprocesses the value of a prop after it has been set
    %
    % Element constructor:
    %  Element - constructor
    %  
    % Element methods:
    %  isEnsemble - returns whether a property is ensemble
    %  getEnsembleNumber - returns ensemble cardinality
    %  set - sets the value of a property
    %  check - checks the values of all properties
    %  getr - returns the raw value of a property
    %  get - returns the value of a property
    %  memorize - returns and memorizes the value of a property
    %  getPropSeed - returns the seed of a property
    %  isLocked - returns whether a property is locked
    %  lock - locks unreversibly a property
    %  isChecked - returns whether a property is checked
    %  checked - sets a property to checked
    %  unchecked - sets a property to NOT checked
    %  
    % Element methods (operators):
    %  isequal - determines whether two elements are equal (values, locked)
    %  
    % Element methods (display):
    %  tostring - string with information about the element
    %  disp - displays information about the element
    %  tree - displays the element tree
    %  
    % Element method (element list):
    %  getElementList - returns a list with all subelements
    %  
    % Element method (JSON encode):
    %  encodeJSON - returns a JSON string encoding the element
    %  
    % Element method (JSON decode, Static):
    %  decodeJSON - returns a JSON string encoding the element
    %
    % Element methods (copy):
    %  copy - copies the element
    %  deepclone - deep-clones the element
    %  clone - clones the element
    %
    % Element methods (inspection, Static):
    %  getClass - returns the class of the element
    %  getName - returns the name of the element
    %  getDescription - returns the description of the element
    %  getProps - returns the property list of an element
    %  getPropNumber - returns the property number of an element
    %  existsProp - checks whether property exists/error
    %  existsTag - checks whether tag exists/error
    %  getPropProp - returns the property number of a property
    %  getPropTag - returns the tag of a property
    %  getPropCategory - returns the category of a property
    %  getPropFormat - returns the format of a property
    %  getPropDescription - returns the description of a property
    %  getPropSettings - returns the settings of a property
    %  getPropDefault - returns the default value of a property
    %  getPropDefaultConditioned - returns the conditioned default value of a property
    %  checkProp - checks whether a value has the correct format/error
    %
    % Element methods (category, Static):
    %  getCategories - returns the list of categories
    %  getCategoryNumber - returns the number of categories
    %  existsCategory - returns whether a category exists/error
    %  getCategoryName - returns the name of a category
    %  getCategoryDescription - returns the description of a category
    %
    % Element methods (format, Static):
    %  getFormats - returns the list of formats
    %  getFormatNumber - returns the number of formats
    %  existsFormat - returns whether a format exists/error
    %  getFormatName - returns the name of a format
    %  getFormatDescription - returns the description of a format
    %  getFormatSettings - returns the settings for a format
    %  getFormatDefault - returns the default value for a format
    %  checkFormat - returns whether a value format is correct/error
    %
    % Element methods (GUI):
    %  getGUI - returns figure with element GUI
    %  getPlotElement - returns the element plot
    %  getPlotProp - returns a prop plot
    %
    % Element methods (GUI, Static):
    %  getGUIMenuImport - returns a basic import menu
    %  getGUIMenuExport - returns a basic export menu
    %
    % See also Category, Format, NoValue, Callback, IndexedDictionary, handle, matlab.mixin.Copyable.    
    
    properties (Access=private)
        %TODO: check that the comments are correct
        % props is a private struct containing the element properties whose
        % details depend on the property category (YOCO, YADIR):
        %
        % METADATA:
        %  props{prop}.ensemble  - false/true
        %  props{prop}.value(s)  - NoValue() or value(s)
        %  props{prop}.seed      - seed for rng
        %  props{prop}.checked 	 - true/false
        %  props{prop}.locked    - false/true
        %
        % PARAMETER, DATA, GUI, FIGURE:
        %  props{prop}.ensemble  - false/true
        %  props{prop}.value(s)  - NoValue() or Callback() or value(s)
        %  props{prop}.seed      - seed for rng
        %  props{prop}.checked   - true/false
        %  props{prop}.locked    - false/true
        %
        % RESULT:
        %  props{prop}.ensemble  - false/true
        %  props{prop}.value(s)  - NoValue() or value(s)
        %  props{prop}.seed      - seed for rng
        %  props{prop}.checked 	 - true/false
        %  props{prop}.locked    - false/true
        %
        % The PARAMETER and DATA properties of the element get locked the
        %  first time a result is successfully calculated.
        %
        % For single-valued elements, the value is retrieved as
        %   props{prop}.value
        %
        % For ensemble elements, the values are retrieved as
        %   props{prop}.values{n}
        %  with n = 1, ..., N, where N is the ensemble cardinality, for
        %  properties of formats ST, LO, OP, NN, NR, NC, NM, NS, LL,
        %  and as 
        %   props{prop}.value
        %  for properties of formats EM, CA, CL, IT, IL, DI, OX,
        %  whose corresponding props are then iterativelly made ensemble.
        %
        % The ensemble information can only be set at when an element is instanced.

        props
    end
    methods (Static) % inspection
        function el_class = getClass(el)
            %GETCLASS returns the class of the element.
            %
            % CLASS = Element.GETCLASS() returns the class 'Element'.
            %
            % Alternative forms to call this method are:
            %  CLASS = EL.GETCLASS() returns the class of the element EL.
            %  CLASS = Element.GETCLASS(CLASS) returns CLASS.
            %  CLASS = EL.GETCLASS(CLASS) returns CLASS.
            %
            % See also getName, getDescription.
            
            % calls from Element
            if nargin < 1
                el_class = 'Element';
                return
            end
            
            % calls from subclasses of Element
            if isa(el, 'Element')
                el_class = class(el);
            else % el should be a string with the element class
                el_class = el;
                assert( ...
                    exist(el_class, 'class') == 8, ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT ' ' ...
                    'The value ' tostring(el, 100, '...') ' is not a valid class name.'] ...
                    )
            end
        end
        function el_name = getName(el)
            %GETNAME returns the name of the element.
            %
            % NAME = Element.GETNAME() returns the name of the element,
            %  which in this case is 'Base class for all elements.'
            %
            % Alternative forms to call this method are:
            %  NAME = EL.GETNAME() returns the name of the element EL.
            %  NAME = Element.GETNAME(CLASS) returns the name of CLASS.
            %  NAME = EL.GETNAME(CLASS) returns the name of CLASS.
            %
            % See also getClass, getDescription.
            
            % calls from Element
            if nargin < 1
                el_name = 'Base class for all elements.';
                return
            end
            
            % calls from subclasses of Element
            el_name = eval([Element.getClass(el) '.getName()']);
        end
        function el_description = getDescription(el)
            %GETNAME returns the description of the element.
            %
            % STR = Element.GETDESCRIPTION() returns the description of the element,
            %  which in this case is:
            %
            %  Element is the base class for all elements.
            %  Even though it is possible to create instances of Element,
            %  typically one uses its subclasses.
            %
            % Alternative forms to call this method are:
            %  STR = EL.GETDESCRIPTION() returns the description of the element EL.
            %  STR = Element.GETDESCRIPTION(CLASS) returns the description of CLASS.
            %  STR = EL.GETDESCRIPTION(CLASS) returns the description of CLASS.
            %
            % See also getClass, getName.
            
            % calls from Element
            if nargin < 1
                el_description = [ ...
                    'Element is the base class for all elements. ' ...
                    'Even though it is possible to create instances of Element, ' ...
                    'typically one uses its subclasses.' ...
                    ];
                return
            end
            
            % calls from subclasses of Element
            el_description = eval([Element.getClass(el) '.getDescription()']);
        end
        function prop_list = getProps(el, category)
            %GETPROPS returns the property list of an element.
            %
            % PROPS = Element.GETPROPS() returns the property list of Element.
            %
            % PROPS = Element.GETPROPS(CATEGORY) returns the property list
            %  of category CATEGORY.
            %
            % Alternative forms to call this method are:
            %  PROPS = EL.GETPROPS([CATEGORY]) returns the property list of element EL.
            %  PROPS = Element.GETPROPS(CLASS[, CATEGORY]) returns the property list of CLASS.
            %  PROPS = EL.GETPROPS(CLASS[, CATEGORY]) returns the property list of CLASS.
            %
            % See also getPropNumber, Category.
            
            % calls from Element
            if nargin < 1 % no arguments
                prop_list = [];
                return
            elseif nargin == 1 && Category.existsCategory(el) % el = category argument
                prop_list = [];
                return
            end
            
            % calls from subclasses of Element
            if nargin < 2
                prop_list = eval([Element.getClass(el) '.getProps()']);
            else
                Category.existsCategory(category);
                
                prop_list = eval([Element.getClass(el) '.getProps(category)']);
            end
        end
        function prop_number = getPropNumber(el)
            %GETPROPNUMBER returns the property number of an element.
            %
            % N = Element.GETPROPNUMBER() returns the number of properties in Element.
            %
            % Alternative forms to call this method are:
            %  N = EL.GETPROPNUMBER() returns the property number of element EL.
            %  N = Element.GETPROPNUMBER(CLASS) returns the property number of CLASS.
            %  N = EL.GETPROPNUMBER(CLASS) returns the property number of CLASS.
            %
            % See also getProps.
            
            % calls from Element
            if nargin < 1
                prop_number = 0;
                return
            end
            
            % calls from subclasses of Element
            prop_number = eval([Element.getClass(el) '.getPropNumber()']);
        end
        function check = existsProp(el, prop)
            %EXISTSPROP checks whether property exists/error.
            %
            % CHECK = Element.EXISTSPROP(PROP) checks whether the property
            %  PROP exists.
            %
            % Alternative forms to call this method are:
            %  CHECK = EL.EXISTSPROP(PROP) checks PROP for EL.
            %  CHECK = Element.EXISTSPROP(CLASS, PROP) checks PROP for CLASS.
            %  CHECK = EL.EXISTSPROP(CLASS, PROP) checks PROP for CLASS.
            %
            % Element.EXISTSPROP(PROP) throws an error if the PROP does NOT
            %  exist.
            %  Error id: [BRAPH2:Element:WrongInput]
            %
            % Alternative forms to call this method are:
            %  EL.EXISTSPROP(PROP) throws error if PROP does NOT exist for EL.
            %   Error id: [BRAPH2:Element:WrongInput]
            %  Element.EXISTSPROP(CLASS, PROP) throws error if PROP does NOT exist for EL.
            %   Error id: [BRAPH2:CLASS:WrongInput]
            %  EL.EXISTSPROP(CLASS, PROP) throws error if PROP does NOT exist for EL.
            %   Error id: [BRAPH2:CLASS:WrongInput]
            %
            % See also getProps, existsTag.
            
            % calls from Element
            if nargin < 2
                prop = el;
                el = 'Element';
            end
            
            % calls from subclasses of Element
            if nargout == 1
                check = any(prop == Element.getProps(el));
            else
                assert( ...
                    Element.existsProp(el, prop), ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT ' ' ...
                    'The value ' tostring(prop) ' is not a valid prop for ' Element.getClass(el) '.'] ...
                    )
            end
        end
        function check = existsTag(el, tag)
            %EXISTSTAG checks whether tag exists/error.
            %
            % CHECK = Element.EXISTSTAG(TAG) checks whether tag TAG exists.
            %
            % Alternative forms to call this method are:
            %  CHECK = EL.EXISTSTAG(TAG) checks tag TAG for EL.
            %  CHECK = Element.EXISTSTAG(CLASS, TAG) checks tag TAG for EL.
            %  CHECK = EL.EXISTSTAG(CLASS, TAG) checks tag TAG for EL.
            %
            % Element.EXISTSTAG(TAG) throws an error if the TAG NOT exist.
            %  Error id: [BRAPH2:Element:WrongInput]
            %
            % Alternative forms to call this method are:
            %  EL.EXISTSTAG(TAG) throws error if TAG does NOT exist for EL.
            %   Error id: [BRAPH2:Element:WrongInput]
            %  Element.EXISTSTAG(CLASS, TAG) throws error if TAG does NOT
            %   exist for EL. Error id: [BRAPH2:Element:WrongInput]
            %  Element.EXISTSTAG(CLASS, TAG) throws error if TAG does NOT
            %   exist for EL. Error id: [BRAPH2:Element:WrongInput]
            %
            % See also getProps, existsProp.
            
            % calls from Element
            if nargin < 2
                tag = el;
                el = 'Element';
            end
            
            % calls from subclasses of Element
            if nargout == 1
                tag_list = cellfun(@(x) Element.getPropTag(el, x), num2cell(Element.getProps(el)'), 'UniformOutput', false);
                check = any(strcmpi(tag, tag_list));
            else
                assert( ...
                    Element.existsTag(el, tag), ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT], ...
                    [BRAPH2.STR ':Element:' BRAPH2.WRONG_INPUT ' ' ...
                    'The value ''' tag ''' is not a valid tag for ' Element.getClass(el) '.'] ...
                    )
            end
        end
        function prop_prop = getPropProp(el, pointer)
            % GETPROPPROP returns the property number of a property.
            %
            % PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the
            %  property number of the property PROP.
            %
            % PROP = Element.GETPROPPROP(TAG) returns the property number
            %  of the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  PROP = EL.GETPROPPROP(POINTER) returns property number of POINTER of EL.
            %  PROP = Element.GETPROPPROP(CLASS, POINTER) returns property number of POINTER of CLASS.
            %  PROP = EL.GETPROPPROP(CLASS, POINTER) returns property number of POINTER of CLASS.
            %
            % See also getPropFormat, getPropTag, getPropCategory,
            % getPropDescription, getPropSettings, getPropDefault,
            % checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_prop = eval([Element.getClass(el) '.getPropProp(pointer)']);
        end
        function prop_tag = getPropTag(el, pointer)
            % GETPROPTAG returns the tag of a property.
            %
            % TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the
            %  property PROP.
            %
            % TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of
            %  the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  TAG = EL.GETPROPTAG(POINTER) returns tag of POINTER of EL.
            %  TAG = Element.GETPROPTAG(CLASS, POINTER) returns tag of POINTER of CLASS.
            %  TAG = EL.GETPROPTAG(CLASS, POINTER) returns tag of POINTER of CLASS.
            %
            % See also getPropProp, getPropSettings, getPropCategory,
            % getPropFormat, getPropDescription, getPropDefault,
            % checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_tag = eval([Element.getClass(el) '.getPropTag(pointer)']);
        end
        function prop_category = getPropCategory(el, pointer)
            % GETPROPCATEGORY returns the category of a property.
            %
            % CATEGORY = Element.GETPROPCATEGORY(PROP) returns the
            %  category of the property PROP.
            %
            % CATEGORY = Element.GETPROPCATEGORY(TAG) returns the
            %  category of the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  CATEGORY = EL.GETPROPCATEGORY(POINTER) returns category of POINTER of EL.
            %  CATEGORY = Element.GETPROPCATEGORY(CLASS, POINTER) returns category of POINTER of CLASS.
            %  CATEGORY = EL.GETPROPCATEGORY(CLASS, POINTER) returns category of POINTER of CLASS.
            %
            % See also Category, getPropProp, getPropTag, getPropSettings,
            % getPropFormat, getPropDescription, getPropDefault,
            % checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_category = eval([Element.getClass(el) '.getPropCategory(pointer)']);
        end
        function prop_format = getPropFormat(el, pointer)
            % GETPROPFORMAT returns the format of a property.
            %
            % FORMAT = Element.GETPROPFORMAT(PROP) returns the format of
            %  property PROP.
            %
            % FORMAT = Element.GETPROPFORMAT(TAG) returns the format of
            %  the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  FORMAT = EL.GETPROPFORMAT(POINTER) returns format of POINTER of EL.
            %  FORMAT = Element.GETPROPFORMAT(CLASS, POINTER) returns format of POINTER of CLASS.
            %  FORMAT = EL.GETPROPFORMAT(CLASS, POINTER) returns format of POINTER of CLASS.
            %
            % See also Format, getPropProp, getPropTag, getPropCategory,
            % getPropDescription, getPropSettings, getPropDefault,
            % checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_format = eval([Element.getClass(el) '.getPropFormat(pointer)']);
        end
        function prop_description = getPropDescription(el, pointer)
            % GETPROPDESCRIPTION returns the description of a property.
            %
            % DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
            %  description of the property PROP.
            %
            % DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
            %  description of the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  DESCRIPTION = EL.GETPROPDESCRIPTION(POINTER) returns description of POINTER of EL.
            %  DESCRIPTION = Element.GETPROPDESCRIPTION(CLASS, POINTER) returns description of POINTER of CLASS.
            %  DESCRIPTION = EL.GETPROPDESCRIPTION(CLASS, POINTER) returns description of POINTER of CLASS.
            %
            % See also getPropProp, getPropTag, getPropCategory,
            % getPropFormat, getPropSettings, getPropDefault,
            % checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_description = eval([Element.getClass(el) '.getPropDescription(pointer)']);
        end
        function prop_settings = getPropSettings(el, pointer)
            % GETPROPSETTINGS returns the settings of a property.
            %
            % SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
            %  settings of the property PROP.
            %
            % SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
            %  settings of the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  SETTINGS = EL.GETPROPSETTINGS(POINTER) returns settings of POINTER of EL.
            %  SETTINGS = Element.GETPROPSETTINGS(CLASS, POINTER) returns settings of POINTER of CLASS.
            %  SETTINGS = EL.GETPROPSETTINGS(CLASS, POINTER) returns settings of POINTER of CLASS.
            %
            % See also getPropProp, getPropTag, getPropCategory,
            % getPropFormat, getPropDescription, getPropDefault,
            % checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_settings = eval([Element.getClass(el) '.getPropSettings(pointer)']);
        end
        function prop_default = getPropDefault(el, pointer)
            %GETPROPDEFAULT returns the default value of a property.
            %
            % DEFAULT = Element.GETPROPDEFAULT(PROP) returns the default
            %   value of the property PROP.
            %
            % DEFAULT = Element.GETPROPDEFAULT(TAG) returns the default
            %   value of the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  TAG = EL.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EL.
            %  TAG = Element.GETPROPDEFAULT(CLASS, POINTER) returns the default value of POINTER of CLASS.
            %  TAG = EL.GETPROPDEFAULT(CLASS, POINTER) returns the default value of POINTER of CLASS.
            %
            % See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings,
            % getPropCategory, getPropFormat, getPropDescription, checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_default = eval([Element.getClass(el) '.getPropDefault(pointer)']);
        end
        function prop_default = getPropDefaultConditioned(el, pointer)
            %GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
            %
            % DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default
            %   value of the property PROP.
            %
            % DEFAULT = Element.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default
            %   value of the property with tag TAG.
            %
            % Alternative forms to call this method are (POINTER = PROP or TAG):
            %  TAG = EL.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EL.
            %  TAG = Element.GETPROPDEFAULTCONDITIONED(CLASS, POINTER) returns the conditioned default value of POINTER of CLASS.
            %  TAG = EL.GETPROPDEFAULTCONDITIONED(CLASS, POINTER) returns the conditioned default value of POINTER of CLASS.
            %
            % See also getPropDefault, getPropProp, getPropTag, getPropSettings,
            % getPropCategory, getPropFormat, getPropDescription, checkProp.
            
            % calls from Element
            if nargin < 2
                pointer = el; %#ok<NASGU>
                el = 'Element';
            end
            
            % calls from subclasses of Element
            prop_default = eval([Element.getClass(el) '.getPropDefaultConditioned(pointer)']);
        end
        function prop_check = checkProp(el, pointer, value)
            %CHECKPROP checks whether a value has the correct format/error.
            %
            % CHECK = Element.CHECKPROP(POINTER, VALUE) checks whether
            %  VALUE is an acceptable value for the format of the property
            %  POINTER (POINTER = PROP or TAG).
            %
            % Alternative forms to call this method are:
            %  CHECK = EL.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of EL.
            %  CHECK = Element.CHECKPROP(CLASS, PROP, VALUE) checks VALUE format for PROP of CLASS.
            %  CHECK = EL.CHECKPROP(CLASS, PROP, VALUE) checks VALUE format for PROP of CLASS.
            %
            % Element.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
            %  NOT an acceptable value for the format of the property POINTER.
            %  Error id: [BRAPH2:Element:WrongInput]
            %
            % Alternative forms to call this method are:
            %  EL.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EL.
            %   Error id: [BRAPH2:Element:WrongInput]
            %  Element.CHECKPROP(CLASS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CLASS.
            %   Error id: [BRAPH2:CLASS:WrongInput]
            %  EL.CHECKPROP(CLASS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CLASS.
            %   Error id: [BRAPH2:CLASS:WrongInput]
            %
            % See also Format, getPropProp, getPropTag, getPropSettings,
            % getPropCategory, getPropFormat, getPropDescription,
            % getPropDefault.
            
            if nargout == 1
                prop_check = eval([Element.getClass(el) '.checkProp(pointer, value)']);
            else
                eval([Element.getClass(el) '.checkProp(pointer, value)']);
            end
        end
    end
    methods % constructor
        function el = Element(varargin)
            % ELEMENT() creates an Element.
            %
            % ELEMENT(PROP, VALUE, ...) with property PROP initialized to VALUE.
            %
            % ELEMENT(TAG, VALUE, ...) with property with tag TAG set to VALUE.
            %
            % Multiple properties can be initialized at once identifying
            %  them with either property numbers (PROP) or tags (TAG).
            %
            % ELEMENT(ENSEMBLE_PROPS, ...) initializes ENSEMBLE_PROPS to ensemble.
            %  ENSEMBLE_PROPS = {POINTER1, POINTER2, ...} where POINTER1,
            %  POINTER2 are prop pointers.
            %
            % See also Category, Format, set, check.

            %CET: COMPUTATIONAL EFFICIENCY TRICK
            % undocumented trick to avoid inizialization of props
            % by having a single value (42) in the varargin (e.g. when deep-copying)
            if length(varargin) == 1 && isequal(varargin{1}, 42)
                return
            end
            
            % input ensemble_props
            if nargin >= 1 && iscell(varargin{1})
                ensemble_props = varargin{1};
                for i = 1:1:length(ensemble_props)
                    ensemble_props{i} = el.getPropProp(ensemble_props{i});
                end
                ensemble_props = cell2mat(ensemble_props);
                
                varargin = varargin(2:end);
            else
                ensemble_props = [];
            end

            %NOTE:
            % the shuffle of the rng (rng('shuffle', 'twister'))
            % should be done before creating the element 
            % to ensure reproducibitlity of the random numbers
            for prop = 1:1:el.getPropNumber()
                if any(ensemble_props == prop)
                    el.props{prop}.ensemble = true;
                    el.props{prop}.values = NoValue.getNoValue();
                else
                    el.props{prop}.ensemble = false;
                    el.props{prop}.value = NoValue.getNoValue();
                end
                el.props{prop}.seed = randi(intmax('uint32'));
                el.props{prop}.checked = true;
                el.props{prop}.locked = false;
            end

            el.set(varargin{:})
        end
    end
	methods % set/check/get/seed/locked/checked
        function ensemble = isEnsemble(el, pointer)
            %ISENSEMBLE returns whether a property is ensemble.
            %
            % ENSEMBLE = ISENSEMBLE(EL) returns whether EL is ensemble.
            %  By definition, EL is ensemble if at least one of its
            %  properties is ensemble.
            %
            % ENSEMBLE = ISENSEMBLE(EL, POINTER) returns whether the property POINTER of
            %  element EL is ensemble. POINTER can be either a property number (PROP) or
            %  tag (TAG).
            %
            % Properties are defined as ensemble when an element is
            %  instantiated and their ensemble property cannot be changed.

            if nargin < 2
                ensemble = any(cellfun(@(x) x.ensemble, el.props));
            else
                prop = el.getPropProp(pointer);
                
                ensemble = el.props{prop}.ensemble;
            end
        end
        function N = getEnsembleNumber(el)
            %GETENSEMBLENUMBER returns ensemble cardinality.
            %
            % N = GETENSEMBLENUMBER(EL) returns the ensemble cardinality.

            N = 0;
            for prop = 1:1:el.getPropNumber()
                if el.isEnsemble(prop)
                    values = el.getr(prop);
                    if ~isa(values, 'NoValue')
                        N = max(N, length(values));
                    end
                end
            end
        end
        function el_out = set(el, varargin)
            %TODO: check docs
            %SET sets the value of a property.
            %
            % SET(EL, POINTER1, VALUE1, POINTER2, VALUE2, ...) sets the value of
            %  POINTER1 to VALUE1, POINTER2 to VALUE2, ... where the pointers can be
            %  either property numbers or property tags.
            %
            % Each property is conditioned before being set (by calling the protected
            %  function <a href="matlab:help Element.conditioning">conditioning</a>, which is defined in each subelement) and all
            %  properties are postprocessed after being set (by calling the protected
            %  function <a href="matlab:help Element.postprocessing">postprocessing</a>, which is defined in each subelement).
            %
            % If a property is checked, its format is checked before proceeding to its
            %  setting by calling <a href="matlab:help Format.checkFormat">Format.checkFormat</a>. 
            %  If the check fails, the property is not set and an error is thrown.
            %  Error id: [BRAPH2:<Element Class>:WrongInput]
            %
            % If any property is checked, the method Element.check() is called after
            %  all settings are made and the consistency of the values of all
            %  properties is checked. If the check fails an error is thrown.
            %  Error id: [BRAPH2:<Element Class>:WrongInput]
            %
            % It the property is Category.PARAMETER or Category.DATA, the value is set
            %  only if the property is unlocked. If an attempt is made to set a locked
            %  property, no setting occurs and a warning is thrown.
            %  Warning id: [BRAPH2:<Element Class>]
            % If the value is a Callback, a warning is thrown if the element,
            %  property number and/or settings of the callback do not coincide with
            %  those of the property.
            %  Warning id: [BRAPH2:<Element Class>]
            %
            % If the property is Category.RESULT, the value can only be set to
            %  NoValue().
            %
            % EL = SET(EL, POINTER1, VALUE1, ...) returns the element.
            %
            % See also get, getr, memorize, check, isChecked, checked, unchecked,
            % isLocked, lock, Callback.

            % backup properties (if any prop is checked)
            checked = el.getPropNumber() && any(cellfun(@(x) x.checked, el.props));
            if checked
                props_backup = el.props; % props backup
            end

            % set
            for i = 1:2:length(varargin)
                prop = el.getPropProp(varargin{i}); % also Element.existsProp(el, prop)
                value = varargin{i+1};
                
                if ~isa(value, 'Callback') && el.getPropCategory(prop) ~= Category.RESULT
                    value = el.conditioning(prop, value);
                end

                switch el.getPropCategory(prop)
                    case Category.METADATA
                        if el.isChecked(prop)
                            el.checkProp(prop, value) % check value format
                        end

                        if el.isEnsemble(prop)
                            el.props{prop}.values = value;
                        else
                            el.props{prop}.value = value;
                        end

                    case {Category.PARAMETER, Category.DATA, Category.GUI, Category.FIGURE} %TODO: check that categories GUI and Figure belong here
                        if ~el.isLocked(prop)
                            if isa(value, 'Callback')
                                if ~isequal(el.getPropFormat(prop), value.get('EL').getPropFormat(value.get('PROP')))
                                    warning( ...
                                        [BRAPH2.STR ':' class(el)], ...
                                        [BRAPH2.STR ':' class(el) ': Different formats for a prop (' el.getPropFormat(prop) ') ' ...
                                        'and a callback (' value.get('EL').getPropFormat(value.get('PROP')) '). ' ...
                                        'This is not necessarily an problem.'] ...
                                        )
                                elseif  ~isequal(el.getPropSettings(prop), value.get('EL').getPropSettings(value.get('PROP')))
                                    warning( ...
                                        [BRAPH2.STR ':' class(el)], ...
                                        [BRAPH2.STR ':' class(el) ': Different format settings for a prop (' el.getPropFormat(prop) ', ' tostring(el.getPropSettings(prop)) ') ' ...
                                        'and a callback (' value.get('EL').getPropFormat(value.get('PROP')) ', ' tostring(value.get('EL').getPropSettings(value.get('PROP'))) '). ' ...
                                        'This is not necessarily an problem.'] ...
                                        )                                
                                end

                                if el.isEnsemble(prop)
                                    el.props{prop}.values = value;
                                else
                                    el.props{prop}.value = value;
                                end
                            else
                                if el.isChecked(prop)
                                    el.checkProp(prop, value) % check value format
                                end

                                if el.isEnsemble(prop)
                                    el.props{prop}.values = value;
                                else
                                    el.props{prop}.value = value;
                                end
                            end
                        else
                            warning( ...
                                [BRAPH2.STR ':' class(el)], ...
                                [BRAPH2.STR ':' class(el) ' ' ... 
                                'Attempt to set the values of a LOCKED property (' el.getPropTag(prop) '), which was obviously not done. ' ...
                                'Hopefully this won''t create problems, but your code shouldn''t let this happen!'] ...
                                )                            
                        end

                    case Category.RESULT
                        if isa(value, 'NoValue')
                            if el.isEnsemble(prop)
                                el.props{prop}.values = NoValue.getNoValue();
                            else
                                el.props{prop}.value = NoValue.getNoValue();
                            end
                        else
                            warning( ...
                                [BRAPH2.STR ':' class(el)], ...
                                [BRAPH2.STR ':' class(el) ' ' ...
                                'Rightfully unsuccessful attempt to set result (' el.getPropTag(prop) ') to a value. ' ...
                                'Probably not a problem, but shouldn''t happen with well-written code!'] ...
                                )
                        end
                end
            end

            for prop = 1:1:el.getPropNumber()
                if ~el.isLocked(prop)
                    el.postprocessing(prop)
                end
            end

            % check values and restore (if any prop is checked)
            if checked
                [check, msg] = el.check();
                if ~check
                    el.props = props_backup; % restore props backup
                    error( ...
                        [BRAPH2.STR ':' class(el) ':' BRAPH2.WRONG_INPUT], ...
                        [BRAPH2.STR ':' class(el) ':' BRAPH2.WRONG_INPUT ' ' ...
                        msg '\n' ...
                        'The value of this ' class(el) ' has been restored, \n' ...
                        'so you can keep on working if you are using command line. \n' ...
                        'Nevertheless, there might be problems, so better you check your code!'] ...
                        )
                end
            end

            % output
            if nargout > 0
                el_out = el;
            end
        end
        function [element_check, element_msg] = check(el)
            %CHECK checks the values of all properties.
            %
            % [CHECK, MSG] = CHECK(EL) checks the values of all properties of element
            %  EL. It returns a flag CHECK (true = passed check; false = failed check)
            %  and a message MSG. The check is performed by calling the protected
            %  function <a href="matlab:help Element.checkValue">checkValue</a>, which is defined in each subclass. By default
            %  checkValue does not make any check.
            %
            % CHECK(EL) checks the values of all properties of element EL and thorws an
            %  error if the check fails.
            %  Error id: [BRAPH2:<Element Class>:BugErr]
            %
            % See also isChecked, checked, unchecked, set, get, getr, memorize.

            value_checks = ones(el.getPropNumber(), true);
            value_msgs = repmat({''}, el.getPropNumber(), 1);
            for prop = 1:1:el.getPropNumber()
                if el.isChecked(prop)
                    value = el.getr(prop);
                    switch el.getPropCategory(prop)
                        case Category.METADATA
                            if ~isa(value, 'NoValue')
                                [value_check, value_msg] = el.checkValue(prop, value);
                            else % NoValue
                                value_check = true;
                                value_msg = '';
                            end

                        case {Category.PARAMETER, Category.DATA, Category.GUI, Category.FIGURE} %TODO: check that categories GUI and Figure belong here
                            while isa(value, 'Callback')
                                value = value.get('EL').get(value.get('PROP'));
                            end
                            if ~isa(value, 'NoValue')
                                [value_check, value_msg] = el.checkValue(prop, value);
                            else % NoValue
                                value_check = true;
                                value_msg = '';
                            end

                        case Category.RESULT
                            if ~isa(value, 'NoValue')
                                [value_check, value_msg] = el.checkValue(prop, value);
                            else % NoValue
                                value_check = true;
                                value_msg = '';
                            end
                    end
                    value_checks(prop) = value_check;
                    if ~value_check
                        value_msgs{prop} = value_msg;
                    end
                end
            end
            check = all(value_checks);
            msg = join(value_msgs);
            msg = strtrim(msg{1});

            if nargout >= 1
                element_check = check;
                element_msg = msg;
            else
                assert( ...
                    check, ...
                    [BRAPH2.STR ':' el.getClass() ':' BRAPH2.BUG_ERR], ...
                    [BRAPH2.STR ':' el.getClass() ':' BRAPH2.BUG_ERR ' ' ...
                    msg] ...
                    )
            end
        end
        function value = getr(el, pointer)
            %GETR returns the raw value of a property.
            %
            % VALUE = GETR(EL, POINTER) returns the raw value of property POINTER of
            %  element EL. POINTER can be either a property number (PROP) or tag (TAG).
            %
            % See also get, memorize, set, check.

            prop = el.getPropProp(pointer); % also Element.existsProp(el, prop)

            if el.isEnsemble(prop)
                value = el.props{prop}.values; % raw element value
            else
                value = el.props{prop}.value; % raw element value
            end
        end
        function value = get(el, pointer)
            %GET returns the value of a property.
            %
            % VALUE = GET(EL, POINTER) returns the value of property POINTER of element
            %  EL. POINTER can be either a property number (PROP) or tag (TAG).
            %
            % If the raw value of the property is a NoValue, it proceed to return the
            %  default property value (for Category.METADATA, Category.PARAMETER, and
            %  Category.DATA).
            %
            % If the raw value of the property is a Callback, it retrieves the value of
            %  the linked property (for Category.PARAMETER, and
            %  Category.DATA).
            %
            % If a result is not calculated (i.e., its raw value is NoValue), it
            %  proceeds to calculate it (but NOT memorize it). After the calculation
            %  all properties of Category.PARAMETER, and Category.DATA are irreversibly
            %  locked. 
            % If the property is checked, it proceeds to check all properties
            %  after the calculation calling the function <a href="matlab:help Element.check">check</a>.
            %  if the check fails, it resets the property to NoValue, returns NoValue,
            %  does not lockthe property, and throws an warning.
            %  Warning id: [BRAPH2:<Element Class>]
            % 
            % See also getr, memorize, set, check, NoValue, Callback, getPropDefault, lock.

            prop = el.getPropProp(pointer);

            value = el.getr(prop);

            switch el.getPropCategory(prop)
                case Category.METADATA
                    if isa(value, 'NoValue')
                        value = el.getPropDefaultConditioned(prop);
                    end

                case {Category.PARAMETER, Category.DATA, Category.GUI, Category.FIGURE} %TODO: check that categories GUI and Figure belong here
                    if isa(value, 'NoValue')
                        value = el.getPropDefaultConditioned(prop);
                    elseif isa(value, 'Callback')
                        value = value.get(Callback.EL).get(value.get(Callback.PROP));
                    end

                case Category.RESULT
                    if isa(value, 'NoValue')

                        % backup properties (if prop is checked)
                        if el.isChecked(prop)
                            props_backup = el.props; % props backup
                        end                        

                        value = el.calculateValue(prop);

                        if ~el.isChecked(prop)
                            el.lock()
                        else
                            % check values and restore (if prop is checked)
                            [check, msg] = el.check();
                            if check
                                el.lock()
                            else
                                el.props = props_backup; % restore props backup
                                if el.isEnsemble(prop)
                                    value = el.props{prop}.values; % values is also set to the original NoValue()
                                else
                                    value = el.props{prop}.value; % value is also set to the original NoValue()
                                end
                                warning( ...
                                    [BRAPH2.STR ':' class(el)], ...
                                    [BRAPH2.STR ':' class(el) msg '\n' ...
                                    'The value of this ' class(el) ' has been restored,\n' ...
                                    'but there might be problems, so better you check your code!'] ...
                                    )
                            end
                        end
                    end
            end
        end
        function value = memorize(el, pointer)
            %MEMORIZE returns and memorizes the value of a property.
            %
            % VALUE = MEMORIZE(EL, POINTER) returns and memorize the value of property POINTER of
            %  element EL. POINTER can be either a property number (PROP) or tag (TAG).
            % 
            % It calls the function <a href="matlab:help Element.check">check</a> and
            %  proceed to save the result if the property is Category.RESULT.
            %
            % See also get, getr, set, check.

            prop = el.getPropProp(pointer);

            value = el.get(prop);

            if isequal(el.getPropCategory(prop), Category.RESULT)
                if el.isEnsemble(prop)
                    el.props{prop}.values = value;
                else
                    el.props{prop}.value = value;
                end                    
            end
        end
        function seed = getPropSeed(el, pointer)
            %GETPROPSEED returns the seed of a property.
            %
            % SEED = GETPROPSEED(EL, POINTER) returns the seed of property POINTER of
            %  element EL. POINTER can be either a property number (PROP) or tag (TAG).
            %
            % The seed of each property is a 32-bit unsigned integer and is initialized
            %  when an element is constructed by calling randi(intmax('uint32')).
            % 
            % See also randi.

            prop = el.getPropProp(pointer);

            seed = el.props{prop}.seed;
        end
        function locked = isLocked(el, pointer)
            %ISLOCKED returns whether a property is locked.
            %
            % LOCKED = ISLOCKED(EL, POINTER) returns whether the property POINTER of
            %  element EL is locked. POINTER can be either a property number (PROP) or
            %  tag (TAG).
            %
            % Properties can be locked by the user using the function <a href="matalb:help Element.lock">lock</a>.
            % All properties with Category.PARAMETER and Category.DATA are
            %  automatically locked as soon as the first result is calculated.
            %  Afterwards they cannot be unlocked. 
            % If an element with unlocked properties is needed, it it possible 
            %  to clone the element using the function <a href="matalb:help Element.clone">clone</a>.
            %
            % See also lock, clone.

            prop = el.getPropProp(pointer);

            locked = el.props{prop}.locked;
        end
        function lock(el, pointer)
            %LOCK locks unreversibly a property.
            %
            % LOCK(EL) locks unreversibly all properties of Category.PARAMETER or Category.DATA 
            %  of element EL. 
            %
            % LOCK(EL, POINTER) locks unreversibly the property POINTER of element EL.
            %  POINTER can be either a property number (PROP) or tag (TAG).
            %
            % See also isLocked.

            if nargin < 2
                for prop = 1:1:el.getPropNumber()
                    if any(strcmp(el.getPropCategory(prop), {Category.PARAMETER, Category.DATA}))
                        el.lock(prop)
                    end
                end
            else
                if ~el.isLocked(pointer) % This condition is for computational efficiency 
                    prop = el.getPropProp(pointer);

                    el.props{prop}.locked = true;

                    value = el.getr(prop);
                    if isa(value, 'Element')
                        value.lock();
                    elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                        cellfun(@(x) x.lock(), value)
                    end
                end
            end
        end
        function checked = isChecked(el, pointer)
            %ISCHECKED returns whether a property is checked.
            %
            % CHECKED = ISCHECKED(EL, POINTER) returns whether the property POINTER of
            %  element EL is checked. POINTER can be either a property number (PROP) or
            %  tag (TAG).
            %
            % Checked properties are checked:
            %  1. for format when they are set (<a href="matalb:help Element.set">set</a>).
            %  2. for value when they are calculated (<a href="matalb:help Element.get">get</a>).
            %
            % See also checked, unchecked.

            prop = el.getPropProp(pointer);

            checked = el.props{prop}.checked;
        end
        function checked(el, pointer)
            %CHECKED sets a property to checked.
            %
            % CHECKED(EL) sets al properties of element EL to checked.
            %
            % CHECKED(EL, POINTER) sets the property POINTER of element EL to checked.
            %  POINTER can be either a property number (PROP) or tag (TAG).
            %
            % See also unchecked, isChecked.

            if nargin < 2
                for prop = 1:1:el.getPropNumber()
                    el.checked(prop)
                end
            else
                if ~el.isChecked(pointer) % This condition is for computational efficiency 
                    prop = el.getPropProp(pointer);

                    el.props{prop}.checked = true;

                    value = el.getr(prop);
                    if isa(value, 'Element')
                        value.checked();
                    elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                        cellfun(@(x) x.checked(), value)
                    end
                end
            end
        end
        function unchecked(el, pointer)
            %UNCHECKED sets a property to NOT checked.
            %
            % UNCHECKED(EL) sets all properties of element EL to NOT checked.
            %
            % UNCHECKED(EL, POINTER) sets the property POINTER of element EL to NOT checked.
            %  POINTER can be either a property number (PROP) or tag (TAG).
            %
            % See also checked, isChecked.

            if nargin < 2
                for prop = 1:1:el.getPropNumber()
                    el.unchecked(prop)
                end
            else
                if el.isChecked(pointer) % This condition is for computational efficiency 
                    prop = el.getPropProp(pointer);

                    el.props{prop}.checked = false;

                    value = el.getr(prop);
                    if isa(value, 'Element')
                        value.unchecked();
                    elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                        cellfun(@(x) x.unchecked(), value)
                    end
                end
            end
        end     
    end
    methods % operators
        function check = isequal(el1, el2)
            %ISEQUAL determines whether two elements are equal (values, locked).
            %
            % CHECK = ISEQUAL(EL1, EL2) determines whether elements EL1 and EL2 are
            %  equal in terms of values and locked status.
            %  POINTER can be either a property number (PROP) or tag (TAG).
            %
            % Note that, instead, EL1 == EL2 detemines whether the two handles 
            %  EL1 and EL2 refer to the very same element.
            
            check = isa(el2, el1.getClass());
            
            if check
                for prop = 1:1:el1.getPropNumber()
                    check = check && isequal(el1.getr(prop), el2.getr(prop)) && (el1.isLocked(prop) == el2.isLocked(prop));
                end
            end
        end
    end
    methods (Static, Access=protected) % conditioning
        function value = conditioning(el, pointer, value)
            %CONDITIONING conditions a value before setting a property.
            %
            % VALUE = CONDITIONING(EL, PROP, VALUE) conditions the value VALUE before
            %  it is set as the value of the property PROP. 
            %  By default, this function does not do anything, so it should
            %  be implemented in the subclasses of Element when needed.
            %
            % See also set, postprocessing, calculateValue, checkValue.
            
            % calls from Element
            if nargin < 3
                value = pointer;
                % pointer = el; %#ok<NASGU>
                % el = 'Element'; %#ok<NASGU>
                return
            end
            
            % calls from subclasses of Element
            value = eval([Element.getClass(el) '.conditioning(pointer, value)']);
        end
    end
    methods (Access=protected) % postprocessing
        function postprocessing(el, prop) %#ok<*INUSD>
            %POSTPROCESSING postprocesses the value of a prop after it has been set.
            %
            % POSTPROCESSING(EL, PROP) post processes the value of the
            %  property PROP after it has been set.
            %  By default, this function does not do anything, so it should
            %  be implemented in the subclasses of Element when needed.
            %
            % The postprocessign is applied to all props that are unlocked
            %  after any value is set.
            %
            % See also set, conditioning, calculateValue, checkValue.
        end
    end
    methods (Access=protected) % check value
        function [value_check, value_msg] = checkValue(el, prop, value)
            %CHECKVALUE checks the value of a property after it is calculated.
            %
            % [CHECK, MSG] = CONDITCHECKVALUEIONING(EL, PROP, VALUE) checks the value
            %  of the property PROP after it is calculated. This function by default
            %  returns a CHECK = true and MSG = ''. It should be implemented in the
            %  subclasses of Element when needed.
            %
            % See also check, set, conditioning, postprocessing, checkValue.

            value_check = true;
            value_msg = '';
        end
    end
    methods (Access=protected) % calculate value
        function value = calculateValue(el, prop)
            %CALCULATEVALUE calculates the value of a property.
            %
            % VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
            %  PROP. It works only with properties with Category.RESULT. By default
            %  this function returns the default value for the prop and should be
            %  implemented in the subclasses of Element when needed.
            %
            % See also getDefault, set, conditioning, postprocessing, checkValue.

            value = el.getPropDefaultConditioned(prop);
        end
    end    
    methods % display
        function str = tostring(el, varargin)
            %TOSTRING string with information about the element.
            %
            % STR = TOSTRING(EL) returns a string with information about the element.
            %
            % STR = TOSTRING(EL, N) trims the string to the first N characters.
            %
            % STR = TOSTRING(EL, N, ENDING) ends the string with ENDING if it has
            %  been trimmed.
            %
            % See also disp, tree.

            if el.getPropNumber() > 0
                % str = char(join([class(el) 'with properties' cellfun(@(prod) el.getPropTag(prod), num2cell(Element.getProps(el)'), 'UniformOutput', false)]));
                str = [class(el) ' with ' int2str(el.getPropNumber()) ' properties ' el.getPropTag(1) ' = ' tostring(el.get(1)) '.'];
            else
                str = [class(el) ' without properties.'];
            end
            str = tostring(str, varargin{:});
            str = str(2:1:end-1);
        end
        function disp(el)
            % DISP displays information about the element.
            %
            % DISP(EL) displays information about the element.
            %
            % See also tostring, tree.

            disp(['<a href="matlab:help ' class(el) '">' class(el) '</a>']);
            el.tree(0)
        end
        function txt_output = tree(el, level, prop_list, n, ending)
            %TODO: revise this function
            %TREE displays the element tree.
            %
            % TREE(EL) displays the first level of the element tree.
            %
            % TREE(EL, LEVEL) displays a number LEVEL of the levels of the element tree.
            %
            % TREE(EL, [], PROPS) displays only PROPS at the first level.
            %
            % TREE(EL, [], [], N[, ENDING]) trims the string of each property to the
            %  first N characters and, optionally, ends the string with ENDING if it
            %  has been trimmed.
            %
            % STR = TREE(EL) returns the element tree as a string.
            %
            % See also tostring, tree.  
                        
            if nargin < 5
                ending = ' ...';
            end

            if nargin < 4 || isempty(n)
                n = 100;
            end

            if nargin < 3 || isempty(prop_list)
                prop_list = 1:1:el.getPropNumber();
            end
            
            if nargin < 2 || isempty(level)
                level = 0;
            end
            
            txt_el = sprintf(['<strong>' class(el) '</strong>\n']);
            
            for prop = prop_list
                category = el.getPropCategory(prop);
                format = el.getPropFormat(prop);
                value = el.getr(prop);
                
                % \U scape bug - warning fix
                if ischar(value) && contains(value, '\')
                    value = insertAfter(value, '\', '\');                    
                end
                
                if el.isLocked(prop)
                    txt_locked = ['<strong>' char(254) '</strong>'];
                else
                    txt_locked = ' ';
                end
                
                if el.isChecked(prop)
                    txt_checked = ['<strong>' char(391) '</strong> '];
                else
                    txt_checked = '  ';
                end
                
                txt_el = [txt_el ...
                    sprintf([ ...
                    int2str(prop) ' ' ...
                    category ' ' ...
                    format ...
                    '\t' upper(el.getPropTag(prop)) ...
                    '\t' txt_locked txt_checked ...
                    '\t' int2str(el.getPropSeed(prop)) ...
                    '\t' tostring(value, n, ending) ...
                    '\n'])]; %#ok<AGROW>
                
                if level > 0
                    if isa(value, 'Callback')
                        cb = value;
                        cb_element = cb.get('el');
                        cb_prop = cb.get('prop');
                        txt_cd = cb_element.tree(level - 1, cb_prop, n, ending);
                        lines = splitlines(txt_cd);
                        for i = 1:1:length(lines)
                            txt_el = [txt_el ...
                                sprintf(['  ' lines{i} '\n']) ... % indent
                                ]; %#ok<AGROW>
                        end
                    elseif isa(value, 'Element')
                        value_el = value;
                        txt_value_el = value_el.tree(level - 1, [], n, ending);
                        lines = splitlines(txt_value_el);
                        for i = 1:1:length(lines)
                            txt_el = [txt_el ...
                                sprintf(['  ' lines{i} '\n']) ... % indent
                                ]; %#ok<AGROW>
                        end                    
                    elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                        for i = 1:1:length(value)
                            txt_el = [txt_el ...
                                sprintf(['  index:<strong>' int2str(i) '</strong> item:']) ... % indent
                                ]; %#ok<AGROW>
                            txt_value_dict_i = value{i}.tree(level - 1, [], n, ending);
                            lines = splitlines(txt_value_dict_i);
                            txt_el = [txt_el ...
                                sprintf([lines{1} '\n']) ...
                                ]; %#ok<AGROW>
                            for j = 2:1:length(lines)
                                txt_el = [txt_el ...
                                    sprintf(['  ' lines{j} '\n']) ... % indent
                                    ]; %#ok<AGROW>
                            end
                        end
                    end
                end
            end
            
            txt_el = txt_el(1:end - 1); % eliminates last carriage return

            if nargout == 1
                txt_output = txt_el;
            else
                disp(txt_el)
            end
        end
    end
    methods % el_list
        function el_list = getElementList(el, el_list)
            %GETELEMETLIST returns a list with all subelements.
            %
            % LIST = GETELEMETLIST(EL) returns a list with all subelements of element
            %  EL (including EL itself).
            %
            % LIST = GETELEMETLIST(EL, LIST) appends the subelements of element EL
            %  (including EL itself) to LIST. This form of the function is mainly used
            %  internally within the class Element.
            %
            % See also encodeJSON, decodeJSON, copy, clone.

            if nargin < 2
                el_list = {};
            end
            
            if all(cellfun(@(x) el ~= x, el_list))
                el_list = [el_list(:); {el}];
            end
            
            for prop = 1:1:el.getPropNumber()
                value = el.getr(prop);
                
                if isa(value, 'Element')
                    el_list = value.getElementList(el_list);
                elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                    for i = 1:1:length(value)
                        el_list = value{i}.getElementList(el_list);
                    end
                end
            end
        end        
    end
    methods % encodeJSON
        function [json, struct, el_list] = encodeJSON(el)
            %ENCODEJSON returns a JSON string encoding the element.
            %
            % JSON = ENCODEJSON(EL) returns a JSON string encoding the element EL.
            %
            % See also decodeJSON.
            
            el_list = el.getElementList();
            
            for i = 1:1:length(el_list)
                el = el_list{i};
                
                struct{i}.class = el.getClass(); %#ok<AGROW>
                
                for prop = 1:1:el.getPropNumber()
                    value = el.getr(prop);

                    struct{i}.props{prop}.prop = prop;
                    struct{i}.props{prop}.tag = el.getPropTag(prop);
                    
                    if isa(value, 'NoValue')
                        struct{i}.props{prop}.value = find(cellfun(@(x) value == x, el_list));
                    else
                        switch el.getPropFormat(prop)
                            case Format.EMPTY
                                struct{i}.props{prop}.value = regexprep(tostring(value), '''', '''''');
                            case {Format.STRING, Format.OPTION, Format.CLASS}
                                struct{i}.props{prop}.value = regexprep(tostring(value), '''', '''''');
                            case {Format.LOGICAL, Format.SCALAR, Format.RVECTOR, Format.CVECTOR, Format.MATRIX, Format.SMATRIX}
                                struct{i}.props{prop}.value = mat2str(value);
                            case Format.CLASSLIST
                                json_str = '{';
                                for j = 1:1:length(value)
                                    json_str = [json_str ' ''' value{j} ''' ']; %#ok<AGROW>
                                end
                                json_str = [json_str '}']; %#ok<AGROW>
                                struct{i}.props{prop}.value = json_str;
                            case {Format.ITEM, Format.IDICT}
                                struct{i}.props{prop}.value = find(cellfun(@(x) value == x, el_list));
                            case Format.ITEMLIST
                                indices = zeros(1, length(value));
                                for j = 1:1:length(value)
                                    indices(j) = find(cellfun(@(x) value{j} == x, el_list));
                                end
                                struct{i}.props{prop}.value = indices;
                            case Format.CELL
                                json_str = '{';
                                for j = 1:1:size(value, 1)
                                    for k = 1:1:size(value, 2)
                                        if k < size(value, 2)
                                            json_str = [json_str mat2str(value{j, k}) ', ']; %#ok<AGROW>
                                        elseif j < size(value, 1)
                                            json_str = [json_str mat2str(value{j, k}) '; ']; %#ok<AGROW>
                                        else
                                            json_str = [json_str mat2str(value{j, k})]; %#ok<AGROW>
                                        end
                                    end
                                end
                                json_str = [json_str '}']; %#ok<AGROW>
                                struct{i}.props{prop}.value = json_str;
                        end
                    end
                    struct{i}.props{prop}.seed = el.getPropSeed(prop);
                    struct{i}.props{prop}.locked = el.isLocked(prop);
                    struct{i}.props{prop}.checked = el.isChecked(prop);
                end
            end

            json = jsonencode(struct);
        end
    end
    methods (Static) % decodeJSON
        function [el, struct, el_list] = decodeJSON(json)
            %DECODEJSON returns a JSON string encoding the element.
            %
            % EL = DECODEJSON(JSON) returns the element EL decoding the a JSON string.
            %
            % See also encodeJSON.
            
            struct = jsondecode(json);
            
            % manages special case when only one element
            if length(struct) == 1
                struct_tmp{1}.class = struct.class;
                if isfield(struct, 'prop')
                    struct_tmp{1}.props = struct.props;
                end
                struct = struct_tmp;
                clear struct_tmp
            end

            % creates empty elements
            el_list = cell(length(struct), 1);
            for i = 1:1:length(struct)
                el_class = struct{i}.class;
                if strcmp(el_class, 'NoValue')
                    el_list{i} = NoValue.getNoValue();
                else
                    el_list{i} = eval([el_class '()']);
                end
            end
            
            % fills in props
            for i = 1:1:length(el_list)
                el = el_list{i};

                for prop = 1:1:el.getPropNumber()
                    value = struct{i}.props(prop).value;
                    if isnumeric(value)
                        if ~isequal(el.getPropFormat(prop), Format.ITEMLIST) || (numel(value) == 1 && isa(el_list{value}, 'NoValue'))
                            el.props{prop}.value = el_list{value};
                        else % case Format.ITEMLIST
                            indices = value;
                            el.props{prop}.value = el_list(indices)';
                        end
                    else
                        switch el.getPropFormat(prop)
                            case Format.EMPTY
                                el.props{prop}.value = eval(value);
                            case {Format.STRING, Format.OPTION, Format.CLASS}
                                el.props{prop}.value = eval(value(2:end-1));
                            case {Format.LOGICAL, Format.SCALAR, Format.RVECTOR, Format.CVECTOR, Format.MATRIX, Format.SMATRIX}
                                el.props{prop}.value = eval(value);
                            case Format.CLASSLIST
                                el.props{prop}.value = eval(value);
                                % case {Format.ITEM, Format.IDICT}
                                %     el.props{prop}.value = el_list{value};
                                % case Format.ITEMLIST
                                %     indices = value;
                                %     el.props{prop}.value = el_list(indices);
                            case Format.CELL
                                el.props{prop}.value = eval(value);
                        end
                    end
                    el.props{prop}.seed = uint32(struct{i}.props(prop).seed);
                    el.props{prop}.locked = struct{i}.props(prop).locked;
                    el.props{prop}.checked = struct{i}.props(prop).checked;
                end
            end
            
            el = el_list{1};
        end
    end    
    methods (Access=protected) % deep copy
        %TODO: revise copy
        function el_copy = copyElement(el)
            %COPYELEMENT copies the element.
            %
            % EL_COPY = COPYELEMENT(EL) copies the element EL making a deep copy of all
            %  its properties.
            %
            % See also copy, clone, deepclone.

            el_list = el.getElementList();
            
            % creates empty elements
            % fills them with shallow copies of props
            el_copy_list = cell(size(el_list));
            for i = 1:1:length(el_list)
                el_class = el_list{i}.getClass();
                if strcmp(el_class, 'NoValue')
                    el_copy_list{i} = NoValue.getNoValue();
                else
                    el_copy_list{i} = eval([el_class '(42)']);
                    el_copy_list{i}.props = el_list{i}.props;
                end
            end

            % fills in handle props
            for i = 1:1:length(el_list)
                el = el_list{i};
                
                for prop = 1:1:el.getPropNumber()
                    value = el.getr(prop);

                    if isa(value, 'Element')
                        el_copy_list{i}.props{prop}.value = el_copy_list{cellfun(@(x) x == value, el_list)};
                    elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                        for j = 1:1:length(value)
                            el_copy_list{i}.props{prop}.value{j} = el_copy_list{cellfun(@(x) x == value{j}, el_list)};
                        end
                    end
                end
            end
            
            el_copy = el_copy_list{1};
        end
    end
    methods % clone
        %TODO: revise clone
        function el_clone = clone(el)
            %CLONE clones the element.
            %
            % EL_COPY = CLONE(EL) clones the element EL. The cloning operation makes a
            %  deep copy of the element including all properties with Category.METADATA
            %  and Category.PARAMETER and the checked status.
            %  The properties with Category.DATA and Category.RESULT are set to
            %  NoValue, the seeds are randomized, and all properties are unlocked.
            %
            % See also deepclone, copy.
            
            % el_clone = el.copy();
            % 
            % el_list = el_clone.getElementList();
            % for i = 1:1:length(el_list)
            %     el = el_list{i};
            %     for prop = 1:1:el.getPropNumber()
            %         switch el.getPropCategory(prop)
            %             case {Category.METADATA, Category.PARAMETER}
            %             case {Category.DATA, Category.RESULT}
            %                 el.props{prop}.value = NoValue.getNoValue();
            %         end
            %         el.props{prop}.seed = randi(intmax('uint32'));
            %         el.props{prop}.locked = false;
            %     end
            % end
            
            if isa(el, 'NoValue')
                el_clone = NoValue.getNoValue();
                return
            end
            
            el_clone = eval(el.getClass());
            
            for prop = 1:1:el_clone.getPropNumber()
                switch el_clone.getPropCategory(prop)
                    case {Category.METADATA, Category.PARAMETER}
                        value = el.getr(prop);
                        
                        if isa(value, 'Element')
                            el_clone.props{prop}.value = value.clone();
                        elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                            el_clone.props{prop}.value = cellfun(@(x) x.clone(), value, 'UniformOutput', false);
                        else
                            el_clone.props{prop}.value = value;
                        end
                    case {Category.DATA, Category.RESULT}
                        el_clone.props{prop}.value = NoValue.getNoValue();
                end
            end
        end
        function el_clone = deepclone(el)
            %DEEPCLONE deep-clones the element.
            %
            % EL_COPY = DEEPCLONE(EL) deep-clones the element EL. The deep-cloning
            %  operation makes a deep copy of the element including all properties with
            %  Category.METADATA, Category.PARAMETER, and Category.DATA and the checked status.
            %  The properties with Category.RESULT are set to NoValue, the seeds are
            %  randomized, and all properties are unlocked.
            %
            % See also clone, copy.
            
            if isa(el, 'NoValue')
                el_clone = NoValue.getNoValue();
                return
            end
            
            el_clone = eval(el.getClass());
            
            for prop = 1:1:el_clone.getPropNumber()
                switch el_clone.getPropCategory(prop)
                    case {Category.METADATA, Category.PARAMETER, Category.DATA}
                        value = el.getr(prop);
                        
                        if isa(value, 'Element')
                            el_clone.props{prop}.value = value.clone();
                        elseif iscell(value) && all(all(cellfun(@(x) isa(x, 'Element'), value)))
                            el_clone.props{prop}.value = cellfun(@(x) x.clone(), value, 'UniformOutput', false);
                        else
                            el_clone.props{prop}.value = value;
                        end
                    case Category.RESULT
                        el_clone.props{prop}.value = NoValue.getNoValue();
                end
            end
        end
    end
    methods % GUI
% FIXME: gui = GUI ...
        function fig = getGUI(el, varargin)
            %GETGUI returns figure with element GUI.
            %
            % GETGUI(EL) opens figure with GUI for element EL.
            %
            % GETGUI(EL, 'Name', Value, ...) sets the settings of GUI.
            %
            % FIG = GETGUI(EL) returns handle with figure with GUI for element EL.
            %
            % See also GUI.
            
            GUI(el, varargin{:});
            
            if nargout == 1
                fig = gcf();
            end
        end
        function pe = getPlotElement(el, varargin) 
            %GETPLOTELEMENT returns the element plot.
            %
            % PL = GETPLOTELEMENT(EL) returns the plot of element EL.
            %
            % PL = GETPLOTELEMENT(EL, 'Name', Value, ...) sets the settings of PlotElement.
            %
            % See also PlotElement.
            
            pe = PlotElement('EL', el, varargin{:});
        end
        function pr = getPlotProp(el, prop, varargin)
            %GETPLOTPROP returns a prop plot.
            %
            % PL = GETPLOTPROP(EL, PROP) returns the plot of prop PROP.
            %
            % PL = GETPLOTPROP(EL, PROP, 'Name', Value, ...) sets the settings.
            %
            % See also PlotProp, PlotPropCell, PlotPropClass, PlotPropClassList,
            %  PlotPropIDict, PlotPropItem, PlotPropItemList, PlotPropLogical,
            %  PlotPropMatrix, PlotPropOption, PlotPropScalar, PlotPropString.

            switch el.getPropFormat(prop)
                case Format.EMPTY
                    pr = PlotProp( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.STRING
                    pr = PlotPropString( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.LOGICAL
                    pr = PlotPropLogical( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.OPTION
                    pr = PlotPropOption( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.CLASS
                    pr = PlotPropClass( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.CLASSLIST
                    pr = PlotPropClassList( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.ITEM
                    pr = PlotPropItem( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.ITEMLIST
                    pr = PlotPropItemList( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.IDICT
                    pr = PlotPropIDict( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.SCALAR
                    pr = PlotPropScalar( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.RVECTOR
                    pr = PlotPropMatrix( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.CVECTOR
                    pr = PlotPropMatrix( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.MATRIX
                    pr = PlotPropMatrix( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.SMATRIX
                    pr = PlotPropMatrix( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                case Format.CELL
                    pr = PlotPropCell( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
                otherwise
                    pr = PlotProp( ...
                        'ID', el.getPropTag(prop), ...
                        'EL', el, ...
                        'PROP', prop, ...
                        varargin{:});
            end
        end
    end
    methods (Static) % GUI Static
        function getGUIMenuImport(el, menu_import, pl)
            %GETGUIMENUIMPORT sets the import submenu gui json.
            % 
            % GETGUIMENUIMPORT(EL, UI_MENU, PL) sets the import submenu
            %  json for the menu UI_MENU for the plot element PL.
            % 
            % See also getGUI, getGUIMenuExport, PLotElement.
            
            uimenu(menu_import, ...
                'Label', 'Import JSON ...', ...
                'Callback', {@cb_import_json})
                 
            function cb_import_json(~,~)
                [file, path, filterindex] = uigetfile('.json', ['Select ' el.getName() ' file location.']);
                if filterindex
                    filename = fullfile(path, file);
                    fid = fopen(filename);
                    raw = fread(fid, inf);
                    str = char(raw');
                    fclose(fid);

                    pl.set('EL', Element.decodeJSON(str)); 
                    pl.reinit();
                end
            end
        end
        function getGUIMenuExport(el, menu_export, plot_element)
            %GETGUIMENUEXPORT sets the export submenu gui json.
            % 
            % GETGUIMENUEXPORT(EL, UI_MENU) sets the export submenu for the ui menu UI_MENU.
            % 
            % See also getGUI, getGUIMenuImport.
                     
            uimenu(menu_export, ...
                'Label', 'Export JSON ...', ...
                'Callback', {@cb_export_json})
          
            function cb_export_json(~,~)
                [file, path, filterindex] = uiputfile({'*.json', '*.json'}, ['Select ' el.getName  ' file location.']);
                if filterindex
                    filename = fullfile(path, file);
                    [json, ~, ~] = encodeJSON(plot_element.get('EL'));
                    fid = fopen(filename, 'w');
                    fprintf(fid, json);
                    fclose(fid);
                end
            end
        end
    end
end