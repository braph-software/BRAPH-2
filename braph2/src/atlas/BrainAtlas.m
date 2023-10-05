classdef BrainAtlas < ConcreteElement
	%BrainAtlas is a brain atlas.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Brain Atlas (BrainAtlas) represents a brain atlas, constituted 
	%  by a collection of brain regions.
	% BrainAtlas contains and manages brain regions inside an IndexedDictionary; 
	%  thus, it has access to all IndexedDictionary methods.
	% BrainAtlas can be imported/exported to .txt, .xls and .json files.
	%
	% BrainAtlas methods (constructor):
	%  BrainAtlas - constructor
	%
	% BrainAtlas methods:
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
	% BrainAtlas methods (display):
	%  tostring - string with information about the brain atlas
	%  disp - displays information about the brain atlas
	%  tree - displays the tree of the brain atlas
	%
	% BrainAtlas methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two brain atlas are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the brain atlas
	%
	% BrainAtlas methods (save/load, Static):
	%  save - saves BRAPH2 brain atlas as b2 file
	%  load - loads a BRAPH2 brain atlas from a b2 file
	%
	% BrainAtlas method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the brain atlas
	%
	% BrainAtlas method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the brain atlas
	%
	% BrainAtlas methods (inspection, Static):
	%  getClass - returns the class of the brain atlas
	%  getSubclasses - returns all subclasses of BrainAtlas
	%  getProps - returns the property list of the brain atlas
	%  getPropNumber - returns the property number of the brain atlas
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
	% BrainAtlas methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BrainAtlas methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BrainAtlas methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BrainAtlas methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BrainAtlas; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BrainAtlas constants</a>.
	%
	%
	% See also BrainRegion, BrainSurface, ImporterBrainAtlasXLS, ImporterBrainAtlasTXT, ExporterBrainAtlasXLS, ExporterBrainAtlasTXT.
	
	properties (Constant) % properties
		BR_DICT = ConcreteElement.getPropNumber() + 1;
		BR_DICT_TAG = 'BR_DICT';
		BR_DICT_CATEGORY = Category.DATA;
		BR_DICT_FORMAT = Format.IDICT;
		
		PFBA = ConcreteElement.getPropNumber() + 2;
		PFBA_TAG = 'PFBA';
		PFBA_CATEGORY = Category.GUI;
		PFBA_FORMAT = Format.ITEM;
	end
	methods % constructor
		function ba = BrainAtlas(varargin)
			%BrainAtlas() creates a brain atlas.
			%
			% BrainAtlas(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BrainAtlas(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			ba = ba@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function ba_class = getClass()
			%GETCLASS returns the class of the brain atlas.
			%
			% CLASS = BrainAtlas.GETCLASS() returns the class 'BrainAtlas'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BA.GETCLASS() returns the class of the brain atlas BA.
			%  CLASS = Element.GETCLASS(BA) returns the class of 'BA'.
			%  CLASS = Element.GETCLASS('BrainAtlas') returns 'BrainAtlas'.
			%
			% Note that the Element.GETCLASS(BA) and Element.GETCLASS('BrainAtlas')
			%  are less computationally efficient.
			
			ba_class = 'BrainAtlas';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the brain atlas.
			%
			% LIST = BrainAtlas.GETSUBCLASSES() returns all subclasses of 'BrainAtlas'.
			%
			% Alternative forms to call this method are:
			%  LIST = BA.GETSUBCLASSES() returns all subclasses of the brain atlas BA.
			%  LIST = Element.GETSUBCLASSES(BA) returns all subclasses of 'BA'.
			%  LIST = Element.GETSUBCLASSES('BrainAtlas') returns all subclasses of 'BrainAtlas'.
			%
			% Note that the Element.GETSUBCLASSES(BA) and Element.GETSUBCLASSES('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('BrainAtlas', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of brain atlas.
			%
			% PROPS = BrainAtlas.GETPROPS() returns the property list of brain atlas
			%  as a row vector.
			%
			% PROPS = BrainAtlas.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BA.GETPROPS([CATEGORY]) returns the property list of the brain atlas BA.
			%  PROPS = Element.GETPROPS(BA[, CATEGORY]) returns the property list of 'BA'.
			%  PROPS = Element.GETPROPS('BrainAtlas'[, CATEGORY]) returns the property list of 'BrainAtlas'.
			%
			% Note that the Element.GETPROPS(BA) and Element.GETPROPS('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						BrainAtlas.BR_DICT ...
						BrainAtlas.PFBA ...
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
						BrainAtlas.BR_DICT ...
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
						BrainAtlas.PFBA ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of brain atlas.
			%
			% N = BrainAtlas.GETPROPNUMBER() returns the property number of brain atlas.
			%
			% N = BrainAtlas.GETPROPNUMBER(CATEGORY) returns the property number of brain atlas
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = BA.GETPROPNUMBER([CATEGORY]) returns the property number of the brain atlas BA.
			%  N = Element.GETPROPNUMBER(BA) returns the property number of 'BA'.
			%  N = Element.GETPROPNUMBER('BrainAtlas') returns the property number of 'BrainAtlas'.
			%
			% Note that the Element.GETPROPNUMBER(BA) and Element.GETPROPNUMBER('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(BrainAtlas.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in brain atlas/error.
			%
			% CHECK = BrainAtlas.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BA.EXISTSPROP(PROP) checks whether PROP exists for BA.
			%  CHECK = Element.EXISTSPROP(BA, PROP) checks whether PROP exists for BA.
			%  CHECK = Element.EXISTSPROP(BrainAtlas, PROP) checks whether PROP exists for BrainAtlas.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BA.EXISTSPROP(PROP) throws error if PROP does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSPROP(BA, PROP) throws error if PROP does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSPROP(BrainAtlas, PROP) throws error if PROP does NOT exist for BrainAtlas.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% Note that the Element.EXISTSPROP(BA) and Element.EXISTSPROP('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == BrainAtlas.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BrainAtlas.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in brain atlas/error.
			%
			% CHECK = BrainAtlas.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BA.EXISTSTAG(TAG) checks whether TAG exists for BA.
			%  CHECK = Element.EXISTSTAG(BA, TAG) checks whether TAG exists for BA.
			%  CHECK = Element.EXISTSTAG(BrainAtlas, TAG) checks whether TAG exists for BrainAtlas.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BA.EXISTSTAG(TAG) throws error if TAG does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSTAG(BA, TAG) throws error if TAG does NOT exist for BA.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%  Element.EXISTSTAG(BrainAtlas, TAG) throws error if TAG does NOT exist for BrainAtlas.
			%   Error id: [BRAPH2:BrainAtlas:WrongInput]
			%
			% Note that the Element.EXISTSTAG(BA) and Element.EXISTSTAG('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			brainatlas_tag_list = cellfun(@(x) BrainAtlas.getPropTag(x), num2cell(BrainAtlas.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, brainatlas_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for BrainAtlas.'] ...
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
			%  PROPERTY = BA.GETPROPPROP(POINTER) returns property number of POINTER of BA.
			%  PROPERTY = Element.GETPROPPROP(BrainAtlas, POINTER) returns property number of POINTER of BrainAtlas.
			%  PROPERTY = BA.GETPROPPROP(BrainAtlas, POINTER) returns property number of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPPROP(BA) and Element.GETPROPPROP('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				brainatlas_tag_list = cellfun(@(x) BrainAtlas.getPropTag(x), num2cell(BrainAtlas.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, brainatlas_tag_list)); % tag = pointer
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
			%  TAG = BA.GETPROPTAG(POINTER) returns tag of POINTER of BA.
			%  TAG = Element.GETPROPTAG(BrainAtlas, POINTER) returns tag of POINTER of BrainAtlas.
			%  TAG = BA.GETPROPTAG(BrainAtlas, POINTER) returns tag of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPTAG(BA) and Element.GETPROPTAG('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case BrainAtlas.BR_DICT
						tag = BrainAtlas.BR_DICT_TAG;
					case BrainAtlas.PFBA
						tag = BrainAtlas.PFBA_TAG;
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
			%  CATEGORY = BA.GETPROPCATEGORY(POINTER) returns category of POINTER of BA.
			%  CATEGORY = Element.GETPROPCATEGORY(BrainAtlas, POINTER) returns category of POINTER of BrainAtlas.
			%  CATEGORY = BA.GETPROPCATEGORY(BrainAtlas, POINTER) returns category of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPCATEGORY(BA) and Element.GETPROPCATEGORY('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.BR_DICT
					prop_category = BrainAtlas.BR_DICT_CATEGORY;
				case BrainAtlas.PFBA
					prop_category = BrainAtlas.PFBA_CATEGORY;
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
			%  FORMAT = BA.GETPROPFORMAT(POINTER) returns format of POINTER of BA.
			%  FORMAT = Element.GETPROPFORMAT(BrainAtlas, POINTER) returns format of POINTER of BrainAtlas.
			%  FORMAT = BA.GETPROPFORMAT(BrainAtlas, POINTER) returns format of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPFORMAT(BA) and Element.GETPROPFORMAT('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.BR_DICT
					prop_format = BrainAtlas.BR_DICT_FORMAT;
				case BrainAtlas.PFBA
					prop_format = BrainAtlas.PFBA_FORMAT;
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
			%  DESCRIPTION = BA.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BA.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BrainAtlas, POINTER) returns description of POINTER of BrainAtlas.
			%  DESCRIPTION = BA.GETPROPDESCRIPTION(BrainAtlas, POINTER) returns description of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPDESCRIPTION(BA) and Element.GETPROPDESCRIPTION('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.BR_DICT
					prop_description = 'BR_DICT (data, idict) contains the brain regions of the brain atlas.';
				case BrainAtlas.PFBA
					prop_description = 'PFBA (gui, item) contains the panel figure of the brain atlas.';
				case BrainAtlas.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the concrete element.';
				case BrainAtlas.NAME
					prop_description = 'NAME (constant, string) is the name of the brain atlas.';
				case BrainAtlas.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the brain atlas.';
				case BrainAtlas.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the brain atlas.';
				case BrainAtlas.ID
					prop_description = 'ID (data, string) is a few-letter code for the brain atlas.';
				case BrainAtlas.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the brain atlas.';
				case BrainAtlas.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the brain atlas.';
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
			%  SETTINGS = BA.GETPROPSETTINGS(POINTER) returns settings of POINTER of BA.
			%  SETTINGS = Element.GETPROPSETTINGS(BrainAtlas, POINTER) returns settings of POINTER of BrainAtlas.
			%  SETTINGS = BA.GETPROPSETTINGS(BrainAtlas, POINTER) returns settings of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPSETTINGS(BA) and Element.GETPROPSETTINGS('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.BR_DICT
					prop_settings = 'BrainRegion';
				case BrainAtlas.PFBA
					prop_settings = 'BrainAtlasPF';
				case BrainAtlas.TEMPLATE
					prop_settings = 'BrainAtlas';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BA.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BA.
			%  DEFAULT = Element.GETPROPDEFAULT(BrainAtlas, POINTER) returns the default value of POINTER of BrainAtlas.
			%  DEFAULT = BA.GETPROPDEFAULT(BrainAtlas, POINTER) returns the default value of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPDEFAULT(BA) and Element.GETPROPDEFAULT('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.BR_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.PFBA
					prop_default = Format.getFormatDefault(Format.ITEM, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.ELCLASS
					prop_default = 'BrainAtlas';
				case BrainAtlas.NAME
					prop_default = 'Brain Atlas';
				case BrainAtlas.DESCRIPTION
					prop_default = 'A Brain Atlas (BrainAtlas) represents a brain atlas, constituted by a collection of brain regions. BrainAtlas contains and manages brain regions inside an IndexedDictionary; thus, it has access to all IndexedDictionary methods. BrainAtlas can be imported/exported to .txt, .xls and .json files.';
				case BrainAtlas.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.ID
					prop_default = 'BrainAtlas ID';
				case BrainAtlas.LABEL
					prop_default = 'BrainAtlas label';
				case BrainAtlas.NOTES
					prop_default = 'BrainAtlas notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainAtlas.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BA.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BA.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BrainAtlas, POINTER) returns the conditioned default value of POINTER of BrainAtlas.
			%  DEFAULT = BA.GETPROPDEFAULTCONDITIONED(BrainAtlas, POINTER) returns the conditioned default value of POINTER of BrainAtlas.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(BA) and Element.GETPROPDEFAULTCONDITIONED('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			prop_default = BrainAtlas.conditioning(prop, BrainAtlas.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BA.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BA.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BA.
			%  CHECK = Element.CHECKPROP(BrainAtlas, PROP, VALUE) checks VALUE format for PROP of BrainAtlas.
			%  CHECK = BA.CHECKPROP(BrainAtlas, PROP, VALUE) checks VALUE format for PROP of BrainAtlas.
			% 
			% BA.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:BrainAtlas:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BA.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BA.
			%   Error id: €BRAPH2.STR€:BrainAtlas:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(BrainAtlas, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainAtlas.
			%   Error id: €BRAPH2.STR€:BrainAtlas:€BRAPH2.WRONG_INPUT€
			%  BA.CHECKPROP(BrainAtlas, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainAtlas.
			%   Error id: €BRAPH2.STR€:BrainAtlas:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(BA) and Element.CHECKPROP('BrainAtlas')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BrainAtlas.getPropProp(pointer);
			
			switch prop
				case BrainAtlas.BR_DICT % __BrainAtlas.BR_DICT__
					check = Format.checkFormat(Format.IDICT, value, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.PFBA % __BrainAtlas.PFBA__
					check = Format.checkFormat(Format.ITEM, value, BrainAtlas.getPropSettings(prop));
				case BrainAtlas.TEMPLATE % __BrainAtlas.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, BrainAtlas.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BrainAtlas.getPropTag(prop) ' (' BrainAtlas.getFormatTag(BrainAtlas.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(ba, prop)
			%POSTPROCESSING postprocessesing after setting.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing of PROP after setting. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% The postprocessing of all properties occurs each time set is called.
			%
			% See also conditioning, preset, checkProp, postset, calculateValue,
			%  checkValue.
			
			switch prop
				case BrainAtlas.PFBA % __BrainAtlas.PFBA__
					if isa(ba.getr('PFBA'), 'NoValue')
					    ba.memorize('PFBA').set('BA', ba)
					end
					
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						postprocessing@ConcreteElement(ba, prop);
					end
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(ba, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case BrainAtlas.BR_DICT % __BrainAtlas.BR_DICT__
					% % example code to use CB_TAB_EDIT
					% cb_tab_edit_code = {
					%     'switch col'
					%         'case BrainRegion.ID'
					%             'if ~dict.get('CONTAINS_KEY', newdata)'
					%                 '' % change brain region id
					%                 'dict.get('IT', i).set(''ID'', newdata)'
					%                 '' % change brain region key in idict
					%                 'dict.get('REPLACE_KEY', dict.get('KEY', i), newdata);' % oldkey = dict.get('KEY', i)
					%             'end'
					%     'otherwise'
					%         'cb_table_edit_default()'
					%     'end'
					%     };
					pr = PanelPropIDictTable('EL', ba, 'PROP', BrainAtlas.BR_DICT, ... 
						'COLS', [PanelPropIDictTable.SELECTOR BrainRegion.ID BrainRegion.LABEL BrainRegion.X BrainRegion.Y BrainRegion.Z BrainRegion.NOTES], ...
						'ROWNAME', 'numbered', ... % 'CB_TAB_EDIT', cb_tab_edit_code, ... % example code to use CB_TAB_EDIT
						varargin{:});
					
				case BrainAtlas.PFBA % __BrainAtlas.PFBA__
					pr = PanelPropItem('EL', ba, 'PROP', BrainAtlas.PFBA, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot Brain Atlas', ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(ba, prop, varargin{:});
					
			end
		end
	end
	methods (Static) % GUI static methods
		function getGUIMenuImport(el, menu_import, pe)
			%GETGUIMENUIMPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu import
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuExporter, PlotElement.
			
			Element.getGUIMenuImport(el, menu_import, pe);
			
			uimenu(menu_import, ...
			    'Tag', 'MENU.Import.TXT', ...
			    'Label', 'Import TXT ...', ...
			    'Callback', {@cb_importer_TXT});
			function cb_importer_TXT(~, ~)
			    try
			        im = ImporterBrainAtlasTXT( ...
			            'ID', 'Import Brain Atlas from TXT', ...
			            'WAITBAR', true ...
			            ).get('GET_FILE');
			        if ~isa(im.getr('FILE'), 'NoValue')
			            ba = im.get('BA');
			            gui = GUIElement('PE', ba);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input BrainAtlas in TXT format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
			uimenu(menu_import, ...
			    'Tag', 'MENU.Import.XLS', ...
			    'Label', 'Import XLS ...', ...
			    'Callback', {@cb_importer_XLS});
			function cb_importer_XLS(~, ~)
			    try
			        im = ImporterBrainAtlasXLS( ...
			            'ID', 'Import Brain Atlas from XLS', ...
			            'WAITBAR', true ...
			            ).get('GET_FILE');
			        if ~isa(im.getr('FILE'), 'NoValue')
			            ba = im.get('BA');
			            gui = GUIElement('PE', ba);
			            gui.get('DRAW')
			            gui.get('SHOW')
			        end
			    catch e
			        %TODO implement and use braph2msgbox instead of warndlg
			        warndlg(['Please, select a valid input BrainAtlas in XLS format. ' newline() ...
			            newline() ...
			            'Error message:' newline() ...
			            newline() ...
			            e.message newline()], 'Warning');
			    end
			end
			
		end
		function getGUIMenuExport(el, menu_export, pe)
			%GETGUIMENUEXPORT sets a figure menu.
			%
			% GETGUIMENUIMPORT(EL, MENU, PE) sets the figure menu export
			%  which operates on the element EL in the plot element PE.
			%
			% See also getGUIMenuImporter, PlotElement.
			
			Element.getGUIMenuExport(el, menu_export, pe);
			
			uimenu(menu_export, ...
			    'Tag', 'MENU.Export.TXT', ...
			    'Label', 'Export TXT ...', ...
			    'Callback', {@cb_exporter_TXT});
			function cb_exporter_TXT(~, ~)
			    ex = ExporterBrainAtlasTXT( ...
			        'ID', 'Export Brain Atlas to TXT', ...
			        'BA', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_FILE');
			    if ~isa(ex.getr('FILE'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
			uimenu(menu_export, ...
			    'Tag', 'MENU.Export.XLS', ...
			    'Label', 'Export XLS ...', ...
			    'Callback', {@cb_exporter_XLS});
			function cb_exporter_XLS(~, ~)
			    ex = ExporterBrainAtlasXLS( ...
			        'ID', 'Export Brain Atlas to XLS', ...
			        'BA', el, ...
			        'WAITBAR', true ...
			        ).get('PUT_FILE');
			    if ~isa(ex.getr('FILE'), 'NoValue')
			        ex.get('SAVE');
			    end
			end
			
		end
	end
end
