classdef Exporter < ConcreteElement
	%Exporter exports a concrete element to a file.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% An Exporter is the base class for the exporter of an element (ConcreteElement) to a file.
	%
	% Exporter methods (constructor):
	%  Exporter - constructor
	%
	% Exporter methods:
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
	% Exporter methods (display):
	%  tostring - string with information about the exporter to a file
	%  disp - displays information about the exporter to a file
	%  tree - displays the tree of the exporter to a file
	%
	% Exporter methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two exporter to a file are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the exporter to a file
	%
	% Exporter methods (save/load, Static):
	%  save - saves BRAPH2 exporter to a file as b2 file
	%  load - loads a BRAPH2 exporter to a file from a b2 file
	%
	% Exporter method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the exporter to a file
	%
	% Exporter method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the exporter to a file
	%
	% Exporter methods (inspection, Static):
	%  getClass - returns the class of the exporter to a file
	%  getSubclasses - returns all subclasses of Exporter
	%  getProps - returns the property list of the exporter to a file
	%  getPropNumber - returns the property number of the exporter to a file
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
	% Exporter methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Exporter methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Exporter methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Exporter methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Exporter; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Exporter constants</a>.
	%
	%
	% See also ConcreteElement, Importer.
	
	properties (Constant) % properties
		WAITBAR = ConcreteElement.getPropNumber() + 1;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
	end
	methods % constructor
		function ex = Exporter(varargin)
			%Exporter() creates a exporter to a file.
			%
			% Exporter(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Exporter(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			ex = ex@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function ex_class = getClass()
			%GETCLASS returns the class of the exporter to a file.
			%
			% CLASS = Exporter.GETCLASS() returns the class 'Exporter'.
			%
			% Alternative forms to call this method are:
			%  CLASS = EX.GETCLASS() returns the class of the exporter to a file EX.
			%  CLASS = Element.GETCLASS(EX) returns the class of 'EX'.
			%  CLASS = Element.GETCLASS('Exporter') returns 'Exporter'.
			%
			% Note that the Element.GETCLASS(EX) and Element.GETCLASS('Exporter')
			%  are less computationally efficient.
			
			ex_class = 'Exporter';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the exporter to a file.
			%
			% LIST = Exporter.GETSUBCLASSES() returns all subclasses of 'Exporter'.
			%
			% Alternative forms to call this method are:
			%  LIST = EX.GETSUBCLASSES() returns all subclasses of the exporter to a file EX.
			%  LIST = Element.GETSUBCLASSES(EX) returns all subclasses of 'EX'.
			%  LIST = Element.GETSUBCLASSES('Exporter') returns all subclasses of 'Exporter'.
			%
			% Note that the Element.GETSUBCLASSES(EX) and Element.GETSUBCLASSES('Exporter')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Exporter', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of exporter to a file.
			%
			% PROPS = Exporter.GETPROPS() returns the property list of exporter to a file
			%  as a row vector.
			%
			% PROPS = Exporter.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = EX.GETPROPS([CATEGORY]) returns the property list of the exporter to a file EX.
			%  PROPS = Element.GETPROPS(EX[, CATEGORY]) returns the property list of 'EX'.
			%  PROPS = Element.GETPROPS('Exporter'[, CATEGORY]) returns the property list of 'Exporter'.
			%
			% Note that the Element.GETPROPS(EX) and Element.GETPROPS('Exporter')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						Exporter.WAITBAR ...
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
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
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
						Exporter.WAITBAR ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of exporter to a file.
			%
			% N = Exporter.GETPROPNUMBER() returns the property number of exporter to a file.
			%
			% N = Exporter.GETPROPNUMBER(CATEGORY) returns the property number of exporter to a file
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = EX.GETPROPNUMBER([CATEGORY]) returns the property number of the exporter to a file EX.
			%  N = Element.GETPROPNUMBER(EX) returns the property number of 'EX'.
			%  N = Element.GETPROPNUMBER('Exporter') returns the property number of 'Exporter'.
			%
			% Note that the Element.GETPROPNUMBER(EX) and Element.GETPROPNUMBER('Exporter')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Exporter.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in exporter to a file/error.
			%
			% CHECK = Exporter.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSPROP(PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(EX, PROP) checks whether PROP exists for EX.
			%  CHECK = Element.EXISTSPROP(Exporter, PROP) checks whether PROP exists for Exporter.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Exporter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSPROP(PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%  Element.EXISTSPROP(EX, PROP) throws error if PROP does NOT exist for EX.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%  Element.EXISTSPROP(Exporter, PROP) throws error if PROP does NOT exist for Exporter.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%
			% Note that the Element.EXISTSPROP(EX) and Element.EXISTSPROP('Exporter')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Exporter.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Exporter.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in exporter to a file/error.
			%
			% CHECK = Exporter.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = EX.EXISTSTAG(TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(EX, TAG) checks whether TAG exists for EX.
			%  CHECK = Element.EXISTSTAG(Exporter, TAG) checks whether TAG exists for Exporter.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Exporter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  EX.EXISTSTAG(TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%  Element.EXISTSTAG(EX, TAG) throws error if TAG does NOT exist for EX.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%  Element.EXISTSTAG(Exporter, TAG) throws error if TAG does NOT exist for Exporter.
			%   Error id: [BRAPH2:Exporter:WrongInput]
			%
			% Note that the Element.EXISTSTAG(EX) and Element.EXISTSTAG('Exporter')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			exporter_tag_list = cellfun(@(x) Exporter.getPropTag(x), num2cell(Exporter.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, exporter_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Exporter.'] ...
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
			%  PROPERTY = EX.GETPROPPROP(POINTER) returns property number of POINTER of EX.
			%  PROPERTY = Element.GETPROPPROP(Exporter, POINTER) returns property number of POINTER of Exporter.
			%  PROPERTY = EX.GETPROPPROP(Exporter, POINTER) returns property number of POINTER of Exporter.
			%
			% Note that the Element.GETPROPPROP(EX) and Element.GETPROPPROP('Exporter')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				exporter_tag_list = cellfun(@(x) Exporter.getPropTag(x), num2cell(Exporter.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, exporter_tag_list)); % tag = pointer
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
			%  TAG = EX.GETPROPTAG(POINTER) returns tag of POINTER of EX.
			%  TAG = Element.GETPROPTAG(Exporter, POINTER) returns tag of POINTER of Exporter.
			%  TAG = EX.GETPROPTAG(Exporter, POINTER) returns tag of POINTER of Exporter.
			%
			% Note that the Element.GETPROPTAG(EX) and Element.GETPROPTAG('Exporter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Exporter.WAITBAR
						tag = Exporter.WAITBAR_TAG;
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
			%  CATEGORY = EX.GETPROPCATEGORY(POINTER) returns category of POINTER of EX.
			%  CATEGORY = Element.GETPROPCATEGORY(Exporter, POINTER) returns category of POINTER of Exporter.
			%  CATEGORY = EX.GETPROPCATEGORY(Exporter, POINTER) returns category of POINTER of Exporter.
			%
			% Note that the Element.GETPROPCATEGORY(EX) and Element.GETPROPCATEGORY('Exporter')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.WAITBAR
					prop_category = Exporter.WAITBAR_CATEGORY;
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
			%  FORMAT = EX.GETPROPFORMAT(POINTER) returns format of POINTER of EX.
			%  FORMAT = Element.GETPROPFORMAT(Exporter, POINTER) returns format of POINTER of Exporter.
			%  FORMAT = EX.GETPROPFORMAT(Exporter, POINTER) returns format of POINTER of Exporter.
			%
			% Note that the Element.GETPROPFORMAT(EX) and Element.GETPROPFORMAT('Exporter')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.WAITBAR
					prop_format = Exporter.WAITBAR_FORMAT;
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
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(POINTER) returns description of POINTER of EX.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Exporter, POINTER) returns description of POINTER of Exporter.
			%  DESCRIPTION = EX.GETPROPDESCRIPTION(Exporter, POINTER) returns description of POINTER of Exporter.
			%
			% Note that the Element.GETPROPDESCRIPTION(EX) and Element.GETPROPDESCRIPTION('Exporter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.WAITBAR
					prop_description = 'WAITBAR (gui, logical) detemines whether to show the waitbar.';
				case Exporter.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the exporter.';
				case Exporter.NAME
					prop_description = 'NAME (constant, string) is the name of the exporter.';
				case Exporter.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the exporter.';
				case Exporter.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the exporter.';
				case Exporter.ID
					prop_description = 'ID (data, string) is a few-letter code for the exporter.';
				case Exporter.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the exporter.';
				case Exporter.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the exporter.';
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
			%  SETTINGS = EX.GETPROPSETTINGS(POINTER) returns settings of POINTER of EX.
			%  SETTINGS = Element.GETPROPSETTINGS(Exporter, POINTER) returns settings of POINTER of Exporter.
			%  SETTINGS = EX.GETPROPSETTINGS(Exporter, POINTER) returns settings of POINTER of Exporter.
			%
			% Note that the Element.GETPROPSETTINGS(EX) and Element.GETPROPSETTINGS('Exporter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case Exporter.TEMPLATE
					prop_settings = 'Exporter';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Exporter.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Exporter.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULT(POINTER) returns the default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULT(Exporter, POINTER) returns the default value of POINTER of Exporter.
			%  DEFAULT = EX.GETPROPDEFAULT(Exporter, POINTER) returns the default value of POINTER of Exporter.
			%
			% Note that the Element.GETPROPDEFAULT(EX) and Element.GETPROPDEFAULT('Exporter')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, Exporter.getPropSettings(prop));
				case Exporter.ELCLASS
					prop_default = 'Exporter';
				case Exporter.NAME
					prop_default = 'Exporter';
				case Exporter.DESCRIPTION
					prop_default = 'An Exporter is the base class for the exporter of an element (ConcreteElement) to a file.';
				case Exporter.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Exporter.getPropSettings(prop));
				case Exporter.ID
					prop_default = 'Exporter ID';
				case Exporter.LABEL
					prop_default = 'Exporter label';
				case Exporter.NOTES
					prop_default = 'Exporter notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Exporter.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Exporter.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of EX.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Exporter, POINTER) returns the conditioned default value of POINTER of Exporter.
			%  DEFAULT = EX.GETPROPDEFAULTCONDITIONED(Exporter, POINTER) returns the conditioned default value of POINTER of Exporter.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(EX) and Element.GETPROPDEFAULTCONDITIONED('Exporter')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Exporter.getPropProp(pointer);
			
			prop_default = Exporter.conditioning(prop, Exporter.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = EX.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = EX.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of EX.
			%  CHECK = Element.CHECKPROP(Exporter, PROP, VALUE) checks VALUE format for PROP of Exporter.
			%  CHECK = EX.CHECKPROP(Exporter, PROP, VALUE) checks VALUE format for PROP of Exporter.
			% 
			% EX.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Exporter:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  EX.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of EX.
			%   Error id: €BRAPH2.STR€:Exporter:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Exporter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Exporter.
			%   Error id: €BRAPH2.STR€:Exporter:€BRAPH2.WRONG_INPUT€
			%  EX.CHECKPROP(Exporter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Exporter.
			%   Error id: €BRAPH2.STR€:Exporter:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(EX) and Element.CHECKPROP('Exporter')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Exporter.getPropProp(pointer);
			
			switch prop
				case Exporter.WAITBAR % __Exporter.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, Exporter.getPropSettings(prop));
				case Exporter.TEMPLATE % __Exporter.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Exporter.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Exporter:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Exporter.getPropTag(prop) ' (' Exporter.getFormatTag(Exporter.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
