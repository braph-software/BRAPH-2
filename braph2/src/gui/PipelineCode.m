classdef PipelineCode < ConcreteElement
	%PipelineCode is an executable code line of a pipeline.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Pipeline Code Line (PipelineCode) represents a line of executable code in a pipeline.
	%
	% PipelineCode methods (constructor):
	%  PipelineCode - constructor
	%
	% PipelineCode methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% PipelineCode methods (display):
	%  tostring - string with information about the pipeline code line
	%  disp - displays information about the pipeline code line
	%  tree - displays the tree of the pipeline code line
	%
	% PipelineCode methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two pipeline code line are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the pipeline code line
	%
	% PipelineCode methods (save/load, Static):
	%  save - saves BRAPH2 pipeline code line as b2 file
	%  load - loads a BRAPH2 pipeline code line from a b2 file
	%
	% PipelineCode method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the pipeline code line
	%
	% PipelineCode method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the pipeline code line
	%
	% PipelineCode methods (inspection, Static):
	%  getClass - returns the class of the pipeline code line
	%  getSubclasses - returns all subclasses of PipelineCode
	%  getProps - returns the property list of the pipeline code line
	%  getPropNumber - returns the property number of the pipeline code line
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
	% PipelineCode methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PipelineCode methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PipelineCode methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PipelineCode methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?PipelineCode; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PipelineCode constants</a>.
	%
	%
	% See also PipelinePP_PSDict, Pipeline, PipelineSection.
	
	properties (Constant) % properties
		TEXT_BEFORE_EXEC = ConcreteElement.getPropNumber() + 1;
		TEXT_BEFORE_EXEC_TAG = 'TEXT_BEFORE_EXEC';
		TEXT_BEFORE_EXEC_CATEGORY = Category.METADATA;
		TEXT_BEFORE_EXEC_FORMAT = Format.STRING;
		
		TEXT_AFTER_EXEC = ConcreteElement.getPropNumber() + 2;
		TEXT_AFTER_EXEC_TAG = 'TEXT_AFTER_EXEC';
		TEXT_AFTER_EXEC_CATEGORY = Category.METADATA;
		TEXT_AFTER_EXEC_FORMAT = Format.STRING;
		
		MONIKER = ConcreteElement.getPropNumber() + 3;
		MONIKER_TAG = 'MONIKER';
		MONIKER_CATEGORY = Category.DATA;
		MONIKER_FORMAT = Format.STRING;
		
		CODE = ConcreteElement.getPropNumber() + 4;
		CODE_TAG = 'CODE';
		CODE_CATEGORY = Category.DATA;
		CODE_FORMAT = Format.STRING;
		
		EL = ConcreteElement.getPropNumber() + 5;
		EL_TAG = 'EL';
		EL_CATEGORY = Category.DATA;
		EL_FORMAT = Format.ITEM;
	end
	methods % constructor
		function pc = PipelineCode(varargin)
			%PipelineCode() creates a pipeline code line.
			%
			% PipelineCode(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PipelineCode(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pc = pc@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function pc_class = getClass()
			%GETCLASS returns the class of the pipeline code line.
			%
			% CLASS = PipelineCode.GETCLASS() returns the class 'PipelineCode'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PC.GETCLASS() returns the class of the pipeline code line PC.
			%  CLASS = Element.GETCLASS(PC) returns the class of 'PC'.
			%  CLASS = Element.GETCLASS('PipelineCode') returns 'PipelineCode'.
			%
			% Note that the Element.GETCLASS(PC) and Element.GETCLASS('PipelineCode')
			%  are less computationally efficient.
			
			pc_class = 'PipelineCode';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the pipeline code line.
			%
			% LIST = PipelineCode.GETSUBCLASSES() returns all subclasses of 'PipelineCode'.
			%
			% Alternative forms to call this method are:
			%  LIST = PC.GETSUBCLASSES() returns all subclasses of the pipeline code line PC.
			%  LIST = Element.GETSUBCLASSES(PC) returns all subclasses of 'PC'.
			%  LIST = Element.GETSUBCLASSES('PipelineCode') returns all subclasses of 'PipelineCode'.
			%
			% Note that the Element.GETSUBCLASSES(PC) and Element.GETSUBCLASSES('PipelineCode')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('PipelineCode', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of pipeline code line.
			%
			% PROPS = PipelineCode.GETPROPS() returns the property list of pipeline code line
			%  as a row vector.
			%
			% PROPS = PipelineCode.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PC.GETPROPS([CATEGORY]) returns the property list of the pipeline code line PC.
			%  PROPS = Element.GETPROPS(PC[, CATEGORY]) returns the property list of 'PC'.
			%  PROPS = Element.GETPROPS('PipelineCode'[, CATEGORY]) returns the property list of 'PipelineCode'.
			%
			% Note that the Element.GETPROPS(PC) and Element.GETPROPS('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						PipelineCode.TEXT_BEFORE_EXEC ...
						PipelineCode.TEXT_AFTER_EXEC ...
						PipelineCode.MONIKER ...
						PipelineCode.CODE ...
						PipelineCode.EL ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						PipelineCode.TEXT_BEFORE_EXEC ...
						PipelineCode.TEXT_AFTER_EXEC ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						PipelineCode.MONIKER ...
						PipelineCode.CODE ...
						PipelineCode.EL ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of pipeline code line.
			%
			% N = PipelineCode.GETPROPNUMBER() returns the property number of pipeline code line.
			%
			% N = PipelineCode.GETPROPNUMBER(CATEGORY) returns the property number of pipeline code line
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PC.GETPROPNUMBER([CATEGORY]) returns the property number of the pipeline code line PC.
			%  N = Element.GETPROPNUMBER(PC) returns the property number of 'PC'.
			%  N = Element.GETPROPNUMBER('PipelineCode') returns the property number of 'PipelineCode'.
			%
			% Note that the Element.GETPROPNUMBER(PC) and Element.GETPROPNUMBER('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(PipelineCode.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in pipeline code line/error.
			%
			% CHECK = PipelineCode.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PC.EXISTSPROP(PROP) checks whether PROP exists for PC.
			%  CHECK = Element.EXISTSPROP(PC, PROP) checks whether PROP exists for PC.
			%  CHECK = Element.EXISTSPROP(PipelineCode, PROP) checks whether PROP exists for PipelineCode.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PC.EXISTSPROP(PROP) throws error if PROP does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSPROP(PC, PROP) throws error if PROP does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSPROP(PipelineCode, PROP) throws error if PROP does NOT exist for PipelineCode.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PC) and Element.EXISTSPROP('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == PipelineCode.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PipelineCode.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in pipeline code line/error.
			%
			% CHECK = PipelineCode.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PC.EXISTSTAG(TAG) checks whether TAG exists for PC.
			%  CHECK = Element.EXISTSTAG(PC, TAG) checks whether TAG exists for PC.
			%  CHECK = Element.EXISTSTAG(PipelineCode, TAG) checks whether TAG exists for PipelineCode.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PC.EXISTSTAG(TAG) throws error if TAG does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSTAG(PC, TAG) throws error if TAG does NOT exist for PC.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%  Element.EXISTSTAG(PipelineCode, TAG) throws error if TAG does NOT exist for PipelineCode.
			%   Error id: [BRAPH2:PipelineCode:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PC) and Element.EXISTSTAG('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			pipelinecode_tag_list = cellfun(@(x) PipelineCode.getPropTag(x), num2cell(PipelineCode.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, pipelinecode_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for PipelineCode.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = PC.GETPROPPROP(POINTER) returns property number of POINTER of PC.
			%  PROPERTY = Element.GETPROPPROP(PipelineCode, POINTER) returns property number of POINTER of PipelineCode.
			%  PROPERTY = PC.GETPROPPROP(PipelineCode, POINTER) returns property number of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPPROP(PC) and Element.GETPROPPROP('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				pipelinecode_tag_list = cellfun(@(x) PipelineCode.getPropTag(x), num2cell(PipelineCode.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, pipelinecode_tag_list)); % tag = pointer
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = PC.GETPROPTAG(POINTER) returns tag of POINTER of PC.
			%  TAG = Element.GETPROPTAG(PipelineCode, POINTER) returns tag of POINTER of PipelineCode.
			%  TAG = PC.GETPROPTAG(PipelineCode, POINTER) returns tag of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPTAG(PC) and Element.GETPROPTAG('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case PipelineCode.TEXT_BEFORE_EXEC
						tag = PipelineCode.TEXT_BEFORE_EXEC_TAG;
					case PipelineCode.TEXT_AFTER_EXEC
						tag = PipelineCode.TEXT_AFTER_EXEC_TAG;
					case PipelineCode.MONIKER
						tag = PipelineCode.MONIKER_TAG;
					case PipelineCode.CODE
						tag = PipelineCode.CODE_TAG;
					case PipelineCode.EL
						tag = PipelineCode.EL_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = PC.GETPROPCATEGORY(POINTER) returns category of POINTER of PC.
			%  CATEGORY = Element.GETPROPCATEGORY(PipelineCode, POINTER) returns category of POINTER of PipelineCode.
			%  CATEGORY = PC.GETPROPCATEGORY(PipelineCode, POINTER) returns category of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPCATEGORY(PC) and Element.GETPROPCATEGORY('PipelineCode')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.TEXT_BEFORE_EXEC
					prop_category = PipelineCode.TEXT_BEFORE_EXEC_CATEGORY;
				case PipelineCode.TEXT_AFTER_EXEC
					prop_category = PipelineCode.TEXT_AFTER_EXEC_CATEGORY;
				case PipelineCode.MONIKER
					prop_category = PipelineCode.MONIKER_CATEGORY;
				case PipelineCode.CODE
					prop_category = PipelineCode.CODE_CATEGORY;
				case PipelineCode.EL
					prop_category = PipelineCode.EL_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
			end
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = PC.GETPROPFORMAT(POINTER) returns format of POINTER of PC.
			%  FORMAT = Element.GETPROPFORMAT(PipelineCode, POINTER) returns format of POINTER of PipelineCode.
			%  FORMAT = PC.GETPROPFORMAT(PipelineCode, POINTER) returns format of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPFORMAT(PC) and Element.GETPROPFORMAT('PipelineCode')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.TEXT_BEFORE_EXEC
					prop_format = PipelineCode.TEXT_BEFORE_EXEC_FORMAT;
				case PipelineCode.TEXT_AFTER_EXEC
					prop_format = PipelineCode.TEXT_AFTER_EXEC_FORMAT;
				case PipelineCode.MONIKER
					prop_format = PipelineCode.MONIKER_FORMAT;
				case PipelineCode.CODE
					prop_format = PipelineCode.CODE_FORMAT;
				case PipelineCode.EL
					prop_format = PipelineCode.EL_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
			end
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = PC.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PC.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PipelineCode, POINTER) returns description of POINTER of PipelineCode.
			%  DESCRIPTION = PC.GETPROPDESCRIPTION(PipelineCode, POINTER) returns description of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPDESCRIPTION(PC) and Element.GETPROPDESCRIPTION('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.TEXT_BEFORE_EXEC
					prop_description = 'TEXT_BEFORE_EXEC (metadata, string) is the text before the code line execution.';
				case PipelineCode.TEXT_AFTER_EXEC
					prop_description = 'TEXT_AFTER_EXEC (metadata, string) is the text after the code line execution.';
				case PipelineCode.MONIKER
					prop_description = 'MONIKER (data, string) is the moniker of the calculated element.';
				case PipelineCode.CODE
					prop_description = 'CODE (data, string) is the code line to calculate the element.';
				case PipelineCode.EL
					prop_description = 'EL (data, item) is the calculated element.';
				case PipelineCode.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the pipeline code line.';
				case PipelineCode.NAME
					prop_description = 'NAME (constant, string) is the name of the pipeline code line.';
				case PipelineCode.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the pipeline code line.';
				case PipelineCode.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the pipeline code line.';
				case PipelineCode.ID
					prop_description = 'ID (data, string) is a few-letter code for the pipeline code line.';
				case PipelineCode.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the pipeline code line.';
				case PipelineCode.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the pipeline code line.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
			end
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = PC.GETPROPSETTINGS(POINTER) returns settings of POINTER of PC.
			%  SETTINGS = Element.GETPROPSETTINGS(PipelineCode, POINTER) returns settings of POINTER of PipelineCode.
			%  SETTINGS = PC.GETPROPSETTINGS(PipelineCode, POINTER) returns settings of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPSETTINGS(PC) and Element.GETPROPSETTINGS('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.TEXT_BEFORE_EXEC
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineCode.TEXT_AFTER_EXEC
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineCode.MONIKER
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineCode.CODE
					prop_settings = Format.getFormatSettings(Format.STRING);
				case PipelineCode.EL
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case PipelineCode.TEMPLATE
					prop_settings = 'PipelineCode';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PC.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PC.
			%  DEFAULT = Element.GETPROPDEFAULT(PipelineCode, POINTER) returns the default value of POINTER of PipelineCode.
			%  DEFAULT = PC.GETPROPDEFAULT(PipelineCode, POINTER) returns the default value of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPDEFAULT(PC) and Element.GETPROPDEFAULT('PipelineCode')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.TEXT_BEFORE_EXEC
					prop_default = Format.getFormatDefault(Format.STRING, PipelineCode.getPropSettings(prop));
				case PipelineCode.TEXT_AFTER_EXEC
					prop_default = Format.getFormatDefault(Format.STRING, PipelineCode.getPropSettings(prop));
				case PipelineCode.MONIKER
					prop_default = Format.getFormatDefault(Format.STRING, PipelineCode.getPropSettings(prop));
				case PipelineCode.CODE
					prop_default = Format.getFormatDefault(Format.STRING, PipelineCode.getPropSettings(prop));
				case PipelineCode.EL
					prop_default = Format.getFormatDefault(Format.ITEM, PipelineCode.getPropSettings(prop));
				case PipelineCode.ELCLASS
					prop_default = 'PipelineCode';
				case PipelineCode.NAME
					prop_default = 'Pipeline Code Line';
				case PipelineCode.DESCRIPTION
					prop_default = 'A Pipeline Code Line (PipelineCode) represents a line of executable code in a pipeline.';
				case PipelineCode.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, PipelineCode.getPropSettings(prop));
				case PipelineCode.ID
					prop_default = 'PipelineCode ID';
				case PipelineCode.LABEL
					prop_default = 'PipelineCode label';
				case PipelineCode.NOTES
					prop_default = 'PipelineCode notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PipelineCode.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PC.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PC.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PipelineCode, POINTER) returns the conditioned default value of POINTER of PipelineCode.
			%  DEFAULT = PC.GETPROPDEFAULTCONDITIONED(PipelineCode, POINTER) returns the conditioned default value of POINTER of PipelineCode.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PC) and Element.GETPROPDEFAULTCONDITIONED('PipelineCode')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PipelineCode.getPropProp(pointer);
			
			prop_default = PipelineCode.conditioning(prop, PipelineCode.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PC.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PC.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PC.
			%  CHECK = Element.CHECKPROP(PipelineCode, PROP, VALUE) checks VALUE format for PROP of PipelineCode.
			%  CHECK = PC.CHECKPROP(PipelineCode, PROP, VALUE) checks VALUE format for PROP of PipelineCode.
			% 
			% PC.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:PipelineCode:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PC.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PC.
			%   Error id: €BRAPH2.STR€:PipelineCode:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(PipelineCode, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineCode.
			%   Error id: €BRAPH2.STR€:PipelineCode:€BRAPH2.WRONG_INPUT€
			%  PC.CHECKPROP(PipelineCode, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PipelineCode.
			%   Error id: €BRAPH2.STR€:PipelineCode:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PC) and Element.CHECKPROP('PipelineCode')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PipelineCode.getPropProp(pointer);
			
			switch prop
				case PipelineCode.TEXT_BEFORE_EXEC % __PipelineCode.TEXT_BEFORE_EXEC__
					check = Format.checkFormat(Format.STRING, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.TEXT_AFTER_EXEC % __PipelineCode.TEXT_AFTER_EXEC__
					check = Format.checkFormat(Format.STRING, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.MONIKER % __PipelineCode.MONIKER__
					check = Format.checkFormat(Format.STRING, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.CODE % __PipelineCode.CODE__
					check = Format.checkFormat(Format.STRING, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.EL % __PipelineCode.EL__
					check = Format.checkFormat(Format.ITEM, value, PipelineCode.getPropSettings(prop));
				case PipelineCode.TEMPLATE % __PipelineCode.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, PipelineCode.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':PipelineCode:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PipelineCode.getPropTag(prop) ' (' PipelineCode.getFormatTag(PipelineCode.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(pc, prop, value)
			%CHECKVALUE checks the value of a property after it is set/calculated.
			%
			% [CHECK, MSG] = CHECKVALUE(EL, PROP, VALUE) checks the value
			%  of the property PROP after it is set/calculated. This function by
			%  default returns a CHECK = true and MSG = '. It should be implemented in
			%  the subclasses of Element when needed.
			%
			% See also conditioning, preset, checkProp, postset, postprocessing,
			%  calculateValue.
			
			check = true;
			msg = ['Error while checking ' tostring(pc) ' ' pc.getPropTag(prop) '.'];
			
			switch prop
				case PipelineCode.MONIKER % __PipelineCode.MONIKER__
					check = ~iskeyword(value) && ~strcmp(value, 'varargin');
					if check 
					    msg = 'All ok!';
					else
					    msg = ['The MONIKER (' value ') cannot be a MatLab keyword ' ...
					        '(' char(join(cellfun(@(x) ['''' x ''''], iskeyword, 'UniformOutput', false))) ') ' ...
					        'or ''varargin''.'];
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						[check, msg] = checkValue@ConcreteElement(pc, prop, value);
					end
			end
		end
	end
end
