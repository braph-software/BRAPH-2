classdef Importer < ConcreteElement
	%Importer imports an element from a file.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% An Importer is the base class for the importer of an element (ConcreteElement) from a file.
	%
	% Importer methods (constructor):
	%  Importer - constructor
	%
	% Importer methods:
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
	% Importer methods (display):
	%  tostring - string with information about the importer from a file
	%  disp - displays information about the importer from a file
	%  tree - displays the tree of the importer from a file
	%
	% Importer methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer from a file are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer from a file
	%
	% Importer methods (save/load, Static):
	%  save - saves BRAPH2 importer from a file as b2 file
	%  load - loads a BRAPH2 importer from a file from a b2 file
	%
	% Importer method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer from a file
	%
	% Importer method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer from a file
	%
	% Importer methods (inspection, Static):
	%  getClass - returns the class of the importer from a file
	%  getSubclasses - returns all subclasses of Importer
	%  getProps - returns the property list of the importer from a file
	%  getPropNumber - returns the property number of the importer from a file
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
	% Importer methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Importer methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Importer methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Importer methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Importer; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Importer constants</a>.
	%
	%
	% See also ConcreteElement, Exporter.
	
	properties (Constant) % properties
		WAITBAR = ConcreteElement.getPropNumber() + 1;
		WAITBAR_TAG = 'WAITBAR';
		WAITBAR_CATEGORY = Category.GUI;
		WAITBAR_FORMAT = Format.LOGICAL;
	end
	methods % constructor
		function im = Importer(varargin)
			%Importer() creates a importer from a file.
			%
			% Importer(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Importer(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			im = im@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function im_class = getClass()
			%GETCLASS returns the class of the importer from a file.
			%
			% CLASS = Importer.GETCLASS() returns the class 'Importer'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer from a file IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('Importer') returns 'Importer'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('Importer')
			%  are less computationally efficient.
			
			im_class = 'Importer';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer from a file.
			%
			% LIST = Importer.GETSUBCLASSES() returns all subclasses of 'Importer'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer from a file IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('Importer') returns all subclasses of 'Importer'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('Importer')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('Importer', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer from a file.
			%
			% PROPS = Importer.GETPROPS() returns the property list of importer from a file
			%  as a row vector.
			%
			% PROPS = Importer.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer from a file IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('Importer'[, CATEGORY]) returns the property list of 'Importer'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('Importer')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						Importer.WAITBAR ...
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
						Importer.WAITBAR ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of importer from a file.
			%
			% N = Importer.GETPROPNUMBER() returns the property number of importer from a file.
			%
			% N = Importer.GETPROPNUMBER(CATEGORY) returns the property number of importer from a file
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer from a file IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('Importer') returns the property number of 'Importer'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('Importer')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(Importer.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer from a file/error.
			%
			% CHECK = Importer.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(Importer, PROP) checks whether PROP exists for Importer.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Importer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSPROP(Importer, PROP) throws error if PROP does NOT exist for Importer.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('Importer')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == Importer.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Importer.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer from a file/error.
			%
			% CHECK = Importer.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(Importer, TAG) checks whether TAG exists for Importer.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Importer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%  Element.EXISTSTAG(Importer, TAG) throws error if TAG does NOT exist for Importer.
			%   Error id: [BRAPH2:Importer:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('Importer')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			importer_tag_list = cellfun(@(x) Importer.getPropTag(x), num2cell(Importer.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, importer_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for Importer.'] ...
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
			%  PROPERTY = IM.GETPROPPROP(POINTER) returns property number of POINTER of IM.
			%  PROPERTY = Element.GETPROPPROP(Importer, POINTER) returns property number of POINTER of Importer.
			%  PROPERTY = IM.GETPROPPROP(Importer, POINTER) returns property number of POINTER of Importer.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('Importer')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				importer_tag_list = cellfun(@(x) Importer.getPropTag(x), num2cell(Importer.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, importer_tag_list)); % tag = pointer
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
			%  TAG = IM.GETPROPTAG(POINTER) returns tag of POINTER of IM.
			%  TAG = Element.GETPROPTAG(Importer, POINTER) returns tag of POINTER of Importer.
			%  TAG = IM.GETPROPTAG(Importer, POINTER) returns tag of POINTER of Importer.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('Importer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case Importer.WAITBAR
						tag = Importer.WAITBAR_TAG;
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
			%  CATEGORY = IM.GETPROPCATEGORY(POINTER) returns category of POINTER of IM.
			%  CATEGORY = Element.GETPROPCATEGORY(Importer, POINTER) returns category of POINTER of Importer.
			%  CATEGORY = IM.GETPROPCATEGORY(Importer, POINTER) returns category of POINTER of Importer.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('Importer')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.WAITBAR
					prop_category = Importer.WAITBAR_CATEGORY;
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
			%  FORMAT = IM.GETPROPFORMAT(POINTER) returns format of POINTER of IM.
			%  FORMAT = Element.GETPROPFORMAT(Importer, POINTER) returns format of POINTER of Importer.
			%  FORMAT = IM.GETPROPFORMAT(Importer, POINTER) returns format of POINTER of Importer.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('Importer')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.WAITBAR
					prop_format = Importer.WAITBAR_FORMAT;
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
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of IM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Importer, POINTER) returns description of POINTER of Importer.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(Importer, POINTER) returns description of POINTER of Importer.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('Importer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.WAITBAR
					prop_description = 'WAITBAR (gui, logical) detemines whether to show the waitbar.';
				case Importer.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the importer.';
				case Importer.NAME
					prop_description = 'NAME (constant, string) is the name of the importer.';
				case Importer.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the importer.';
				case Importer.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the importer.';
				case Importer.ID
					prop_description = 'ID (data, string) is a few-letter code for the importer.';
				case Importer.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the importer.';
				case Importer.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the importer.';
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
			%  SETTINGS = IM.GETPROPSETTINGS(POINTER) returns settings of POINTER of IM.
			%  SETTINGS = Element.GETPROPSETTINGS(Importer, POINTER) returns settings of POINTER of Importer.
			%  SETTINGS = IM.GETPROPSETTINGS(Importer, POINTER) returns settings of POINTER of Importer.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('Importer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.WAITBAR
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case Importer.TEMPLATE
					prop_settings = 'Importer';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Importer.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Importer.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(Importer, POINTER) returns the default value of POINTER of Importer.
			%  DEFAULT = IM.GETPROPDEFAULT(Importer, POINTER) returns the default value of POINTER of Importer.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('Importer')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.WAITBAR
					prop_default = Format.getFormatDefault(Format.LOGICAL, Importer.getPropSettings(prop));
				case Importer.ELCLASS
					prop_default = 'Importer';
				case Importer.NAME
					prop_default = 'Importer';
				case Importer.DESCRIPTION
					prop_default = 'Importer is the base class for the importer of an element (ConcreteElement) from a file.';
				case Importer.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, Importer.getPropSettings(prop));
				case Importer.ID
					prop_default = 'Importer ID';
				case Importer.LABEL
					prop_default = 'Importer label';
				case Importer.NOTES
					prop_default = 'Importer notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Importer.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Importer.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Importer, POINTER) returns the conditioned default value of POINTER of Importer.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(Importer, POINTER) returns the conditioned default value of POINTER of Importer.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('Importer')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Importer.getPropProp(pointer);
			
			prop_default = Importer.conditioning(prop, Importer.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = IM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = IM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of IM.
			%  CHECK = Element.CHECKPROP(Importer, PROP, VALUE) checks VALUE format for PROP of Importer.
			%  CHECK = IM.CHECKPROP(Importer, PROP, VALUE) checks VALUE format for PROP of Importer.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:Importer:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: €BRAPH2.STR€:Importer:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(Importer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Importer.
			%   Error id: €BRAPH2.STR€:Importer:€BRAPH2.WRONG_INPUT€
			%  IM.CHECKPROP(Importer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Importer.
			%   Error id: €BRAPH2.STR€:Importer:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('Importer')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Importer.getPropProp(pointer);
			
			switch prop
				case Importer.WAITBAR % __Importer.WAITBAR__
					check = Format.checkFormat(Format.LOGICAL, value, Importer.getPropSettings(prop));
				case Importer.TEMPLATE % __Importer.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, Importer.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':Importer:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Importer.getPropTag(prop) ' (' Importer.getFormatTag(Importer.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
