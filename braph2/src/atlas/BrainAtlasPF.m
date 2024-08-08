classdef BrainAtlasPF < BrainSurfacePF
	%BrainAtlasPF is a panel to manage the plot of a brain atlas.
	% It is a subclass of <a href="matlab:help BrainSurfacePF">BrainSurfacePF</a>.
	%
	% A Panel Figure for Brain Atlas (BrainAtlasPF) manages the plot of the brain 
	%  regions symbols, spheres, ids and labels. 
	% BrainAtlasPF utilizes the surface created from BrainSurfacePF to integrate 
	%  the regions to a brain surface.
	%
	% BrainAtlasPF methods (constructor):
	%  BrainAtlasPF - constructor
	%
	% BrainAtlasPF methods:
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
	% BrainAtlasPF methods (display):
	%  tostring - string with information about the panel figure for brain atlas
	%  disp - displays information about the panel figure for brain atlas
	%  tree - displays the tree of the panel figure for brain atlas
	%
	% BrainAtlasPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for brain atlas are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for brain atlas
	%
	% BrainAtlasPF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for brain atlas as b2 file
	%  load - loads a BRAPH2 panel figure for brain atlas from a b2 file
	%
	% BrainAtlasPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for brain atlas
	%
	% BrainAtlasPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for brain atlas
	%
	% BrainAtlasPF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for brain atlas
	%  getSubclasses - returns all subclasses of BrainAtlasPF
	%  getProps - returns the property list of the panel figure for brain atlas
	%  getPropNumber - returns the property number of the panel figure for brain atlas
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
	% BrainAtlasPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BrainAtlasPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BrainAtlasPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BrainAtlasPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BrainAtlasPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BrainAtlasPF constants</a>.
	%
	%
	% See also BrainAtlas, BrainSurface.
	
	properties (Constant) % properties
		BA = BrainSurfacePF.getPropNumber() + 1;
		BA_TAG = 'BA';
		BA_CATEGORY = Category.METADATA;
		BA_FORMAT = Format.ITEM;
		
		H_SPHS = BrainSurfacePF.getPropNumber() + 2;
		H_SPHS_TAG = 'H_SPHS';
		H_SPHS_CATEGORY = Category.EVANESCENT;
		H_SPHS_FORMAT = Format.HANDLELIST;
		
		SPHS = BrainSurfacePF.getPropNumber() + 3;
		SPHS_TAG = 'SPHS';
		SPHS_CATEGORY = Category.FIGURE;
		SPHS_FORMAT = Format.LOGICAL;
		
		SPH_DICT = BrainSurfacePF.getPropNumber() + 4;
		SPH_DICT_TAG = 'SPH_DICT';
		SPH_DICT_CATEGORY = Category.FIGURE;
		SPH_DICT_FORMAT = Format.IDICT;
		
		H_SYMS = BrainSurfacePF.getPropNumber() + 5;
		H_SYMS_TAG = 'H_SYMS';
		H_SYMS_CATEGORY = Category.EVANESCENT;
		H_SYMS_FORMAT = Format.HANDLELIST;
		
		SYMS = BrainSurfacePF.getPropNumber() + 6;
		SYMS_TAG = 'SYMS';
		SYMS_CATEGORY = Category.FIGURE;
		SYMS_FORMAT = Format.LOGICAL;
		
		SYM_DICT = BrainSurfacePF.getPropNumber() + 7;
		SYM_DICT_TAG = 'SYM_DICT';
		SYM_DICT_CATEGORY = Category.FIGURE;
		SYM_DICT_FORMAT = Format.IDICT;
		
		H_IDS = BrainSurfacePF.getPropNumber() + 8;
		H_IDS_TAG = 'H_IDS';
		H_IDS_CATEGORY = Category.EVANESCENT;
		H_IDS_FORMAT = Format.HANDLELIST;
		
		IDS = BrainSurfacePF.getPropNumber() + 9;
		IDS_TAG = 'IDS';
		IDS_CATEGORY = Category.FIGURE;
		IDS_FORMAT = Format.LOGICAL;
		
		ID_DICT = BrainSurfacePF.getPropNumber() + 10;
		ID_DICT_TAG = 'ID_DICT';
		ID_DICT_CATEGORY = Category.FIGURE;
		ID_DICT_FORMAT = Format.IDICT;
		
		H_LABS = BrainSurfacePF.getPropNumber() + 11;
		H_LABS_TAG = 'H_LABS';
		H_LABS_CATEGORY = Category.EVANESCENT;
		H_LABS_FORMAT = Format.HANDLELIST;
		
		LABS = BrainSurfacePF.getPropNumber() + 12;
		LABS_TAG = 'LABS';
		LABS_CATEGORY = Category.FIGURE;
		LABS_FORMAT = Format.LOGICAL;
		
		LAB_DICT = BrainSurfacePF.getPropNumber() + 13;
		LAB_DICT_TAG = 'LAB_DICT';
		LAB_DICT_CATEGORY = Category.FIGURE;
		LAB_DICT_FORMAT = Format.IDICT;
	end
	methods % constructor
		function pf = BrainAtlasPF(varargin)
			%BrainAtlasPF() creates a panel figure for brain atlas.
			%
			% BrainAtlasPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BrainAtlasPF(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@BrainSurfacePF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for brain atlas.
			%
			% CLASS = BrainAtlasPF.GETCLASS() returns the class 'BrainAtlasPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for brain atlas PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('BrainAtlasPF') returns 'BrainAtlasPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('BrainAtlasPF')
			%  are less computationally efficient.
			
			pf_class = 'BrainAtlasPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for brain atlas.
			%
			% LIST = BrainAtlasPF.GETSUBCLASSES() returns all subclasses of 'BrainAtlasPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for brain atlas PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('BrainAtlasPF') returns all subclasses of 'BrainAtlasPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('BrainAtlasPF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for brain atlas.
			%
			% PROPS = BrainAtlasPF.GETPROPS() returns the property list of panel figure for brain atlas
			%  as a row vector.
			%
			% PROPS = BrainAtlasPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for brain atlas PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('BrainAtlasPF'[, CATEGORY]) returns the property list of 'BrainAtlasPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					BrainSurfacePF.getProps() ...
						BrainAtlasPF.BA ...
						BrainAtlasPF.H_SPHS ...
						BrainAtlasPF.SPHS ...
						BrainAtlasPF.SPH_DICT ...
						BrainAtlasPF.H_SYMS ...
						BrainAtlasPF.SYMS ...
						BrainAtlasPF.SYM_DICT ...
						BrainAtlasPF.H_IDS ...
						BrainAtlasPF.IDS ...
						BrainAtlasPF.ID_DICT ...
						BrainAtlasPF.H_LABS ...
						BrainAtlasPF.LABS ...
						BrainAtlasPF.LAB_DICT ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						BrainSurfacePF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						BrainSurfacePF.getProps(Category.METADATA) ...
						BrainAtlasPF.BA ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						BrainSurfacePF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						BrainSurfacePF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						BrainSurfacePF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						BrainSurfacePF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						BrainSurfacePF.getProps(Category.EVANESCENT) ...
						BrainAtlasPF.H_SPHS ...
						BrainAtlasPF.H_SYMS ...
						BrainAtlasPF.H_IDS ...
						BrainAtlasPF.H_LABS ...
						];
				case Category.FIGURE
					prop_list = [ ...
						BrainSurfacePF.getProps(Category.FIGURE) ...
						BrainAtlasPF.SPHS ...
						BrainAtlasPF.SPH_DICT ...
						BrainAtlasPF.SYMS ...
						BrainAtlasPF.SYM_DICT ...
						BrainAtlasPF.IDS ...
						BrainAtlasPF.ID_DICT ...
						BrainAtlasPF.LABS ...
						BrainAtlasPF.LAB_DICT ...
						];
				case Category.GUI
					prop_list = [ ...
						BrainSurfacePF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for brain atlas.
			%
			% N = BrainAtlasPF.GETPROPNUMBER() returns the property number of panel figure for brain atlas.
			%
			% N = BrainAtlasPF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for brain atlas
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for brain atlas PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('BrainAtlasPF') returns the property number of 'BrainAtlasPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(BrainAtlasPF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for brain atlas/error.
			%
			% CHECK = BrainAtlasPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(BrainAtlasPF, PROP) checks whether PROP exists for BrainAtlasPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%  Element.EXISTSPROP(BrainAtlasPF, PROP) throws error if PROP does NOT exist for BrainAtlasPF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == BrainAtlasPF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainAtlasPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainAtlasPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BrainAtlasPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for brain atlas/error.
			%
			% CHECK = BrainAtlasPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(BrainAtlasPF, TAG) checks whether TAG exists for BrainAtlasPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%  Element.EXISTSTAG(BrainAtlasPF, TAG) throws error if TAG does NOT exist for BrainAtlasPF.
			%   Error id: [BRAPH2:BrainAtlasPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			brainatlaspf_tag_list = cellfun(@(x) BrainAtlasPF.getPropTag(x), num2cell(BrainAtlasPF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, brainatlaspf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainAtlasPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainAtlasPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for BrainAtlasPF.'] ...
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
			%  PROPERTY = PF.GETPROPPROP(POINTER) returns property number of POINTER of PF.
			%  PROPERTY = Element.GETPROPPROP(BrainAtlasPF, POINTER) returns property number of POINTER of BrainAtlasPF.
			%  PROPERTY = PF.GETPROPPROP(BrainAtlasPF, POINTER) returns property number of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				brainatlaspf_tag_list = cellfun(@(x) BrainAtlasPF.getPropTag(x), num2cell(BrainAtlasPF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, brainatlaspf_tag_list)); % tag = pointer
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
			%  TAG = PF.GETPROPTAG(POINTER) returns tag of POINTER of PF.
			%  TAG = Element.GETPROPTAG(BrainAtlasPF, POINTER) returns tag of POINTER of BrainAtlasPF.
			%  TAG = PF.GETPROPTAG(BrainAtlasPF, POINTER) returns tag of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case BrainAtlasPF.BA
						tag = BrainAtlasPF.BA_TAG;
					case BrainAtlasPF.H_SPHS
						tag = BrainAtlasPF.H_SPHS_TAG;
					case BrainAtlasPF.SPHS
						tag = BrainAtlasPF.SPHS_TAG;
					case BrainAtlasPF.SPH_DICT
						tag = BrainAtlasPF.SPH_DICT_TAG;
					case BrainAtlasPF.H_SYMS
						tag = BrainAtlasPF.H_SYMS_TAG;
					case BrainAtlasPF.SYMS
						tag = BrainAtlasPF.SYMS_TAG;
					case BrainAtlasPF.SYM_DICT
						tag = BrainAtlasPF.SYM_DICT_TAG;
					case BrainAtlasPF.H_IDS
						tag = BrainAtlasPF.H_IDS_TAG;
					case BrainAtlasPF.IDS
						tag = BrainAtlasPF.IDS_TAG;
					case BrainAtlasPF.ID_DICT
						tag = BrainAtlasPF.ID_DICT_TAG;
					case BrainAtlasPF.H_LABS
						tag = BrainAtlasPF.H_LABS_TAG;
					case BrainAtlasPF.LABS
						tag = BrainAtlasPF.LABS_TAG;
					case BrainAtlasPF.LAB_DICT
						tag = BrainAtlasPF.LAB_DICT_TAG;
					otherwise
						tag = getPropTag@BrainSurfacePF(prop);
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
			%  CATEGORY = PF.GETPROPCATEGORY(POINTER) returns category of POINTER of PF.
			%  CATEGORY = Element.GETPROPCATEGORY(BrainAtlasPF, POINTER) returns category of POINTER of BrainAtlasPF.
			%  CATEGORY = PF.GETPROPCATEGORY(BrainAtlasPF, POINTER) returns category of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			switch prop
				case BrainAtlasPF.BA
					prop_category = BrainAtlasPF.BA_CATEGORY;
				case BrainAtlasPF.H_SPHS
					prop_category = BrainAtlasPF.H_SPHS_CATEGORY;
				case BrainAtlasPF.SPHS
					prop_category = BrainAtlasPF.SPHS_CATEGORY;
				case BrainAtlasPF.SPH_DICT
					prop_category = BrainAtlasPF.SPH_DICT_CATEGORY;
				case BrainAtlasPF.H_SYMS
					prop_category = BrainAtlasPF.H_SYMS_CATEGORY;
				case BrainAtlasPF.SYMS
					prop_category = BrainAtlasPF.SYMS_CATEGORY;
				case BrainAtlasPF.SYM_DICT
					prop_category = BrainAtlasPF.SYM_DICT_CATEGORY;
				case BrainAtlasPF.H_IDS
					prop_category = BrainAtlasPF.H_IDS_CATEGORY;
				case BrainAtlasPF.IDS
					prop_category = BrainAtlasPF.IDS_CATEGORY;
				case BrainAtlasPF.ID_DICT
					prop_category = BrainAtlasPF.ID_DICT_CATEGORY;
				case BrainAtlasPF.H_LABS
					prop_category = BrainAtlasPF.H_LABS_CATEGORY;
				case BrainAtlasPF.LABS
					prop_category = BrainAtlasPF.LABS_CATEGORY;
				case BrainAtlasPF.LAB_DICT
					prop_category = BrainAtlasPF.LAB_DICT_CATEGORY;
				otherwise
					prop_category = getPropCategory@BrainSurfacePF(prop);
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
			%  FORMAT = PF.GETPROPFORMAT(POINTER) returns format of POINTER of PF.
			%  FORMAT = Element.GETPROPFORMAT(BrainAtlasPF, POINTER) returns format of POINTER of BrainAtlasPF.
			%  FORMAT = PF.GETPROPFORMAT(BrainAtlasPF, POINTER) returns format of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			switch prop
				case BrainAtlasPF.BA
					prop_format = BrainAtlasPF.BA_FORMAT;
				case BrainAtlasPF.H_SPHS
					prop_format = BrainAtlasPF.H_SPHS_FORMAT;
				case BrainAtlasPF.SPHS
					prop_format = BrainAtlasPF.SPHS_FORMAT;
				case BrainAtlasPF.SPH_DICT
					prop_format = BrainAtlasPF.SPH_DICT_FORMAT;
				case BrainAtlasPF.H_SYMS
					prop_format = BrainAtlasPF.H_SYMS_FORMAT;
				case BrainAtlasPF.SYMS
					prop_format = BrainAtlasPF.SYMS_FORMAT;
				case BrainAtlasPF.SYM_DICT
					prop_format = BrainAtlasPF.SYM_DICT_FORMAT;
				case BrainAtlasPF.H_IDS
					prop_format = BrainAtlasPF.H_IDS_FORMAT;
				case BrainAtlasPF.IDS
					prop_format = BrainAtlasPF.IDS_FORMAT;
				case BrainAtlasPF.ID_DICT
					prop_format = BrainAtlasPF.ID_DICT_FORMAT;
				case BrainAtlasPF.H_LABS
					prop_format = BrainAtlasPF.H_LABS_FORMAT;
				case BrainAtlasPF.LABS
					prop_format = BrainAtlasPF.LABS_FORMAT;
				case BrainAtlasPF.LAB_DICT
					prop_format = BrainAtlasPF.LAB_DICT_FORMAT;
				otherwise
					prop_format = getPropFormat@BrainSurfacePF(prop);
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
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BrainAtlasPF, POINTER) returns description of POINTER of BrainAtlasPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(BrainAtlasPF, POINTER) returns description of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			switch prop
				case BrainAtlasPF.BA
					prop_description = 'BA (metadata, item) is the brain atlas with the brain regions.';
				case BrainAtlasPF.H_SPHS
					prop_description = 'H_SPHS (evanescent, handlelist) is the set of handles for the spheres.';
				case BrainAtlasPF.SPHS
					prop_description = 'SPHS (figure, logical) determines whether the spheres are shown.';
				case BrainAtlasPF.SPH_DICT
					prop_description = 'SPH_DICT (figure, idict) contains the spheres of the brain regions.';
				case BrainAtlasPF.H_SYMS
					prop_description = 'H_SYMS (evanescent, handlelist) is the set of handles for the symbols.';
				case BrainAtlasPF.SYMS
					prop_description = 'SYMS (figure, logical) determines whether the symbols are shown.';
				case BrainAtlasPF.SYM_DICT
					prop_description = 'SYM_DICT (figure, idict) contains the symbols of the brain regions.';
				case BrainAtlasPF.H_IDS
					prop_description = 'H_IDS (evanescent, handlelist) is the set of handles for the ids.';
				case BrainAtlasPF.IDS
					prop_description = 'IDS (figure, logical) determines whether the ids are shown.';
				case BrainAtlasPF.ID_DICT
					prop_description = 'ID_DICT (figure, idict) contains the ids of the brain regions.';
				case BrainAtlasPF.H_LABS
					prop_description = 'H_LABS (evanescent, handlelist) is the set of handles for the labels.';
				case BrainAtlasPF.LABS
					prop_description = 'LABS (figure, logical) determines whether the labels are shown.';
				case BrainAtlasPF.LAB_DICT
					prop_description = 'LAB_DICT (figure, idict) contains the labels of the brain regions.';
				case BrainAtlasPF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel figure for brain atlas.';
				case BrainAtlasPF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for brain atlas.';
				case BrainAtlasPF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for brain atlas.';
				case BrainAtlasPF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for brain atlas.';
				case BrainAtlasPF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for brain atlas.';
				case BrainAtlasPF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for brain atlas.';
				case BrainAtlasPF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for brain atlas.';
				case BrainAtlasPF.DRAW
					prop_description = 'DRAW (query, logical) draws the panel figure for brain atlas.';
				case BrainAtlasPF.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure for brain atlas is deleted.';
				case BrainAtlasPF.H_TOOLS
					prop_description = 'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the panel figure for brain atlas.';
				otherwise
					prop_description = getPropDescription@BrainSurfacePF(prop);
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
			%  SETTINGS = PF.GETPROPSETTINGS(POINTER) returns settings of POINTER of PF.
			%  SETTINGS = Element.GETPROPSETTINGS(BrainAtlasPF, POINTER) returns settings of POINTER of BrainAtlasPF.
			%  SETTINGS = PF.GETPROPSETTINGS(BrainAtlasPF, POINTER) returns settings of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			switch prop
				case BrainAtlasPF.BA
					prop_settings = 'BrainAtlas';
				case BrainAtlasPF.H_SPHS
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case BrainAtlasPF.SPHS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case BrainAtlasPF.SPH_DICT
					prop_settings = 'SettingsSphere';
				case BrainAtlasPF.H_SYMS
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case BrainAtlasPF.SYMS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case BrainAtlasPF.SYM_DICT
					prop_settings = 'SettingsSymbol';
				case BrainAtlasPF.H_IDS
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case BrainAtlasPF.IDS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case BrainAtlasPF.ID_DICT
					prop_settings = 'SettingsText';
				case BrainAtlasPF.H_LABS
					prop_settings = Format.getFormatSettings(Format.HANDLELIST);
				case BrainAtlasPF.LABS
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case BrainAtlasPF.LAB_DICT
					prop_settings = 'SettingsText';
				case BrainAtlasPF.TEMPLATE
					prop_settings = 'BrainAtlasPF';
				otherwise
					prop_settings = getPropSettings@BrainSurfacePF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BrainAtlasPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainAtlasPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(BrainAtlasPF, POINTER) returns the default value of POINTER of BrainAtlasPF.
			%  DEFAULT = PF.GETPROPDEFAULT(BrainAtlasPF, POINTER) returns the default value of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			switch prop
				case BrainAtlasPF.BA
					prop_default = Format.getFormatDefault(Format.ITEM, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.H_SPHS
					prop_default = Format.getFormatDefault(Format.HANDLELIST, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.SPHS
					prop_default = true;
				case BrainAtlasPF.SPH_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.H_SYMS
					prop_default = Format.getFormatDefault(Format.HANDLELIST, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.SYMS
					prop_default = false;
				case BrainAtlasPF.SYM_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.H_IDS
					prop_default = Format.getFormatDefault(Format.HANDLELIST, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.IDS
					prop_default = false;
				case BrainAtlasPF.ID_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.H_LABS
					prop_default = Format.getFormatDefault(Format.HANDLELIST, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.LABS
					prop_default = false;
				case BrainAtlasPF.LAB_DICT
					prop_default = Format.getFormatDefault(Format.IDICT, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.ELCLASS
					prop_default = 'BrainAtlasPF';
				case BrainAtlasPF.NAME
					prop_default = 'Panel Figure for Brain Atlas';
				case BrainAtlasPF.DESCRIPTION
					prop_default = 'A Panel Figure for Brain Atlas (BrainAtlasPF) manages the plot of the brain regions symbols, spheres, ids and labels. BrainAtlasPF utilizes the surface created from BrainSurfacePF to integrate the regions to a brain surface.';
				case BrainAtlasPF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.ID
					prop_default = 'BrainAtlasPF ID';
				case BrainAtlasPF.LABEL
					prop_default = 'BrainAtlasPF label';
				case BrainAtlasPF.NOTES
					prop_default = 'BrainAtlasPF notes';
				otherwise
					prop_default = getPropDefault@BrainSurfacePF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BrainAtlasPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainAtlasPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BrainAtlasPF, POINTER) returns the conditioned default value of POINTER of BrainAtlasPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(BrainAtlasPF, POINTER) returns the conditioned default value of POINTER of BrainAtlasPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			prop_default = BrainAtlasPF.conditioning(prop, BrainAtlasPF.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PF.
			%  CHECK = Element.CHECKPROP(BrainAtlasPF, PROP, VALUE) checks VALUE format for PROP of BrainAtlasPF.
			%  CHECK = PF.CHECKPROP(BrainAtlasPF, PROP, VALUE) checks VALUE format for PROP of BrainAtlasPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:BrainAtlasPF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:BrainAtlasPF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(BrainAtlasPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainAtlasPF.
			%   Error id: €BRAPH2.STR€:BrainAtlasPF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(BrainAtlasPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainAtlasPF.
			%   Error id: €BRAPH2.STR€:BrainAtlasPF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('BrainAtlasPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BrainAtlasPF.getPropProp(pointer);
			
			switch prop
				case BrainAtlasPF.BA % __BrainAtlasPF.BA__
					check = Format.checkFormat(Format.ITEM, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.H_SPHS % __BrainAtlasPF.H_SPHS__
					check = Format.checkFormat(Format.HANDLELIST, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.SPHS % __BrainAtlasPF.SPHS__
					check = Format.checkFormat(Format.LOGICAL, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.SPH_DICT % __BrainAtlasPF.SPH_DICT__
					check = Format.checkFormat(Format.IDICT, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.H_SYMS % __BrainAtlasPF.H_SYMS__
					check = Format.checkFormat(Format.HANDLELIST, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.SYMS % __BrainAtlasPF.SYMS__
					check = Format.checkFormat(Format.LOGICAL, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.SYM_DICT % __BrainAtlasPF.SYM_DICT__
					check = Format.checkFormat(Format.IDICT, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.H_IDS % __BrainAtlasPF.H_IDS__
					check = Format.checkFormat(Format.HANDLELIST, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.IDS % __BrainAtlasPF.IDS__
					check = Format.checkFormat(Format.LOGICAL, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.ID_DICT % __BrainAtlasPF.ID_DICT__
					check = Format.checkFormat(Format.IDICT, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.H_LABS % __BrainAtlasPF.H_LABS__
					check = Format.checkFormat(Format.HANDLELIST, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.LABS % __BrainAtlasPF.LABS__
					check = Format.checkFormat(Format.LOGICAL, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.LAB_DICT % __BrainAtlasPF.LAB_DICT__
					check = Format.checkFormat(Format.IDICT, value, BrainAtlasPF.getPropSettings(prop));
				case BrainAtlasPF.TEMPLATE % __BrainAtlasPF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, BrainAtlasPF.getPropSettings(prop));
				otherwise
					if prop <= BrainSurfacePF.getPropNumber()
						check = checkProp@BrainSurfacePF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainAtlasPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainAtlasPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BrainAtlasPF.getPropTag(prop) ' (' BrainAtlasPF.getFormatTag(BrainAtlasPF.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pf, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case BrainAtlasPF.SPHS % __BrainAtlasPF.SPHS__
					if ~pf.get('SPHS') % false
					    h_sphs = pf.get('H_SPHS');
					    for i = 1:1:length(h_sphs)
					        set(h_sphs{i}, 'Visible', false)
					    end
					else % true
					    % triggers the update of SPH_DICT
					    pf.set('SPH_DICT', pf.get('SPH_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.Sphs'), 'State', pf.get('SPHS'))
					end
					
				case BrainAtlasPF.SPH_DICT % __BrainAtlasPF.SPH_DICT__
					if pf.get('SPHS') && ~isa(pf.getr('BA'), 'NoValue')
					    
					    br_dict = pf.get('BA').get('BR_DICT');
					    
					    if pf.get('SPH_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
					        for i = 1:1:br_dict.get('LENGTH')
					            br = br_dict.get('IT', i);
					            sphs{i} = SettingsSphere( ...
					                'PANEL', pf, ...
					                'PROP', BrainAtlasPF.H_SPHS, ...
					                'I', i, ...
					                'VISIBLE', true, ...
					                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
					                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
					                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
					                'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z') ...
					                'FACECOLOR', BRAPH2.COL, ...
					                'FACEALPHA', 1 ...
					                );
					        end
					        pf.get('SPH_DICT').set('IT_LIST', sphs)
					    end
					    
					    for i = 1:1:br_dict.get('LENGTH')
					        pf.get('SPH_DICT').get('IT', i).get('SETUP')
					    end
					    
					    % reset the ambient lighting
					    pf.get('ST_AMBIENT').get('SETUP')
					end
					
				case BrainAtlasPF.SYMS % __BrainAtlasPF.SYMS__
					if ~pf.get('SYMS') % false
					    h_syms = pf.get('H_SYMS');
					    for i = 1:1:length(h_syms)
					        set(h_syms{i}, 'Visible', false)
					    end        
					else % true
					    % triggers the update of SYM_DICT
					    pf.set('SYM_DICT', pf.get('SYM_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.Syms'), 'State', pf.get('SYMS'))
					end
					
				case BrainAtlasPF.SYM_DICT % __BrainAtlasPF.SYM_DICT__
					if pf.get('SYMS') && ~isa(pf.getr('BA'), 'NoValue')
					    
					    br_dict = pf.get('BA').get('BR_DICT');
					
						if pf.get('SYM_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
					        for i = 1:1:br_dict.get('LENGTH')
					            br = br_dict.get('IT', i);
					            syms{i} = SettingsSymbol( ...
					                'PANEL', pf, ...
					                'PROP', BrainAtlasPF.H_SYMS, ...
					                'I', i, ...
					                'VISIBLE', true, ...
					                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
					                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
					                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
					                'Z', br.get('Z') ... % Callback('EL', br, 'TAG', 'Z') ...
					                );
					        end
					        pf.get('SYM_DICT').set('IT_LIST', syms)
					    end
					    
					    for i = 1:1:br_dict.get('LENGTH')
					        pf.get('SYM_DICT').get('IT', i).get('SETUP')
					    end
					end
					
				case BrainAtlasPF.IDS % __BrainAtlasPF.IDS__
					if ~pf.get('IDS') % false
					    h_ids = pf.get('H_IDS');
					    for i = 1:1:length(h_ids)
					        set(h_ids{i}, 'Visible', false)
					    end        
					else % true
					    % triggers the update of ID_DICT
					    pf.set('ID_DICT', pf.get('ID_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.Ids'), 'State', pf.get('IDS'))
					end
					
				case BrainAtlasPF.ID_DICT % __BrainAtlasPF.ID_DICT__
					if pf.get('IDS') && ~isa(pf.getr('BA'), 'NoValue')
					
					    br_dict = pf.get('BA').get('BR_DICT');
					
					    if pf.get('ID_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
					        for i = 1:1:br_dict.get('LENGTH')
					            br = br_dict.get('IT', i);
					            ids{i} = SettingsText( ...
					                'PANEL', pf, ...
					                'PROP', BrainAtlasPF.H_IDS, ...
					                'I', i, ...
					                'VISIBLE', true, ...
					                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
					                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
					                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
					                'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z'), ...
					                'TXT', br.get('ID') ... % Callback('EL', br, 'TAG', 'ID') ...
					                );
					        end
					        pf.get('ID_DICT').set('IT_LIST', ids)
					    end
					    
					    for i = 1:1:br_dict.get('LENGTH')
					        pf.get('ID_DICT').get('IT', i).get('SETUP')
					    end
					end
					
				case BrainAtlasPF.LABS % __BrainAtlasPF.LABS__
					if ~pf.get('LABS') % false
					    h_labs = pf.get('H_LABS');
					    for i = 1:1:length(h_labs)
					        set(h_labs{i}, 'Visible', false)
					    end        
					else % true
						% triggers the update of LAB_DICT
						pf.set('LAB_DICT', pf.get('LAB_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.Labs'), 'State', pf.get('LABS'))
					end
					
				case BrainAtlasPF.LAB_DICT % __BrainAtlasPF.LAB_DICT__
					if pf.get('LABS') && ~isa(pf.getr('BA'), 'NoValue')
					
					    br_dict = pf.get('BA').get('BR_DICT');
					
					    if pf.get('LAB_DICT').get('LENGTH') == 0 && br_dict.get('LENGTH')
					        for i = 1:1:br_dict.get('LENGTH')
					            br = br_dict.get('IT', i);
					            labs{i} = SettingsText( ...
					                'PANEL', pf, ...
					                'PROP', BrainAtlasPF.H_LABS, ...
					                'I', i, ...
					                'VISIBLE', true, ...
					                'ID', br.get('ID'), ... % Callback('EL', br, 'TAG', 'ID'), ...
					                'X', br.get('X'), ... % Callback('EL', br, 'TAG', 'X'), ...
					                'Y', br.get('Y'), ... % Callback('EL', br, 'TAG', 'Y'), ...
					                'Z', br.get('Z'), ... % Callback('EL', br, 'TAG', 'Z'), ...
					                'TXT', br.get('LABEL') ... % Callback('EL', br, 'TAG', 'LABEL') ...
					                );
					        end
					        pf.get('LAB_DICT').set('IT_LIST', labs)
					    end
					    
					    for i = 1:1:br_dict.get('LENGTH')
					        pf.get('LAB_DICT').get('IT', i).get('SETUP')
					    end
					end
					
				otherwise
					if prop <= BrainSurfacePF.getPropNumber()
						postset@BrainSurfacePF(pf, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with Category.RESULT,
			%  Category.QUERY, and Category.EVANESCENT. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  Category.QUERY.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case BrainAtlasPF.H_SPHS % __BrainAtlasPF.H_SPHS__
					L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
					h_sphs = cell(1, L);
					for i = 1:1:L
					    h_sphs{i} = surf([], [], [], ...
					        'Parent', pf.memorize('H_AXES'), ...
					        'Tag', ['H_SPHS{' int2str(i) '}'], ...
					        'Visible', false ...
					        );
					end
					value = h_sphs;
					
				case BrainAtlasPF.H_SYMS % __BrainAtlasPF.H_SYMS__
					L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
					h_syms = cell(1, L);
					for i = 1:1:L
					    h_syms{i} = plot3(0, 0, 0, ...
					        'Parent', pf.get('H_AXES'), ...
					        'Tag', ['H_SYMS{' int2str(i) '}'], ...
					        'Visible', false ...
					        );
					end
					value = h_syms;
					
				case BrainAtlasPF.H_IDS % __BrainAtlasPF.H_IDS__
					L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
					h_ids = cell(1, L);
					for i = 1:1:L
					    h_ids{i} = text(0, 0, 0, '', ...
					        'Parent', pf.get('H_AXES'), ...
					        'Tag', ['H_IDS{' int2str(i) '}'], ...
					        'Visible', false ...
					        );
					end
					value = h_ids;
					
				case BrainAtlasPF.H_LABS % __BrainAtlasPF.H_LABS__
					L = pf.memorize('BA').get('BR_DICT').get('LENGTH');
					h_labs = cell(1, L);
					for i = 1:1:L
					    h_labs{i} = text(0, 0, 0, '', ...
					        'Parent', pf.get('H_AXES'), ...
					        'Tag', ['H_LABS{' int2str(i) '}'], ...
					        'Visible', false ...
					        );
					end
					value = h_labs;
					
				case BrainAtlasPF.DRAW % __BrainAtlasPF.DRAW__
					value = calculateValue@BrainSurfacePF(pf, BrainSurfacePF.DRAW, varargin{:}); % also warning
					if value
					    pf.memorize('H_SPHS')
					    pf.set('SPHS', pf.get('SPHS')) % sets also   SPH_DICT  
					
					    pf.memorize('H_SYMS')
					    pf.set('SYMS', pf.get('SYMS')) % sets also   SYM_DICT  
					
					    pf.memorize('H_IDS')
					    pf.set('SPHS', pf.get('SPHS')) % sets also   ID_DICT  
					
					    pf.memorize('H_LABS')
					    pf.set('LABS', pf.get('LABS')) % sets also   LAB_DICT  
					
					    % reset the ambient lighting
					    pf.get('ST_AMBIENT').get('SETUP')
					end
					
				case BrainAtlasPF.DELETE % __BrainAtlasPF.DELETE__
					value = calculateValue@BrainSurfacePF(pf, BrainSurfacePF.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_SPHS', Element.getNoValue())
					    pf.set('H_SYMS', Element.getNoValue())
					    pf.set('H_IDS', Element.getNoValue())
					    pf.set('H_LABS', Element.getNoValue())
					end
					
				case BrainAtlasPF.H_TOOLS % __BrainAtlasPF.H_TOOLS__
					toolbar = pf.memorize(PanelFig.H_TOOLBAR);
					if check_graphics(toolbar, 'uitoolbar')
						value = calculateValue@BrainSurfacePF(pf, BrainSurfacePF.H_TOOLS);
					    
					    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Spheres
					    tool_sphs = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Sphs', ...
					        'Separator', 'on', ...
					        'State', pf.get('SPHS'), ...
					        'Tooltip', 'Show Spheres', ...
					        'CData', imread('icon_sphere.png'), ...
					        'OnCallback', {@cb_sphs, true}, ...
					        'OffCallback', {@cb_sphs, false});
					
					    % Symbols
					    tool_syms = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Syms', ...
					        'Separator', 'on', ...
					        'State', pf.get('SYMS'), ...
					        'Tooltip', 'Show Symbols', ...
					        'CData', imread('icon_symbol.png'), ...
					        'OnCallback', {@cb_syms, true}, ...
					        'OffCallback', {@cb_syms, false});
					
					    % IDs
					    tool_ids = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Ids', ...
					        'Separator', 'on', ...
					        'State', pf.get('IDS'), ...
					        'Tooltip', 'Show IDs', ...
					        'CData', imread('icon_id.png'), ...
					        'OnCallback', {@cb_ids, true}, ...
					        'OffCallback', {@cb_ids, false});
					
					    % Labels
					    tool_labs = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Labs', ...
					        'Separator', 'on', ...
					        'State', pf.get('LABS'), ...
					        'Tooltip', 'Show Labels', ...
					        'CData', imread('icon_label.png'), ...
					        'OnCallback', {@cb_labs, true}, ...
					        'OffCallback', {@cb_labs, false});
					    
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_sphs, tool_syms, tool_ids, tool_labs ...
					        };
					else
						value = {};
					end
					
				otherwise
					if prop <= BrainSurfacePF.getPropNumber()
						value = calculateValue@BrainSurfacePF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
			function cb_sphs(~, ~, sphs) % (src, event)
			    pf.set('SPHS', sphs)
			end
			function cb_syms(~, ~, syms) % (src, event)
			    pf.set('SYMS', syms)
			end
			function cb_ids(~, ~, ids) % (src, event)
			    pf.set('IDS', ids)
			end
			function cb_labs(~, ~, labs) % (src, event)
			    pf.set('LABS', labs)
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(pf, prop, varargin)
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
				case BrainAtlasPF.SPH_DICT % __BrainAtlasPF.SPH_DICT__
					pr = PanelPropIDictTable('EL', pf, 'PROP', BrainAtlasPF.SPH_DICT, ...
					    'COLS', [PanelPropIDictTable.SELECTOR SettingsSphere.VISIBLE SettingsSphere.X SettingsSphere.Y SettingsSphere.Z SettingsSphere.SPHERESIZE SettingsSphere.FACECOLOR SettingsSphere.FACEALPHA SettingsSphere.EDGECOLOR SettingsSphere.EDGEALPHA], ...
					    varargin{:});
					
				case BrainAtlasPF.SYM_DICT % __BrainAtlasPF.SYM_DICT__
					pr = PanelPropIDictTable('EL', pf, 'PROP', BrainAtlasPF.SYM_DICT, ...
					    'COLS', [PanelPropIDictTable.SELECTOR SettingsSymbol.VISIBLE SettingsSymbol.X SettingsSymbol.Y SettingsSymbol.Z SettingsSymbol.SYMBOL SettingsSymbol.SYMBOLSIZE SettingsSymbol.EDGECOLOR SettingsSymbol.FACECOLOR], ...
					    varargin{:});
					
				case BrainAtlasPF.ID_DICT % __BrainAtlasPF.ID_DICT__
					pr = PanelPropIDictTable('EL', pf, 'PROP', BrainAtlasPF.ID_DICT, ...
					    'COLS', [PanelPropIDictTable.SELECTOR SettingsText.VISIBLE SettingsText.X SettingsText.Y SettingsText.Z SettingsText.ROTATION SettingsText.TXT SettingsText.FONTNAME SettingsText.FONTSIZE SettingsText.FONTCOLOR SettingsText.INTERPRETER], ...
					    varargin{:});
					
				case BrainAtlasPF.LAB_DICT % __BrainAtlasPF.LAB_DICT__
					pr = PanelPropIDictTable('EL', pf, 'PROP', BrainAtlasPF.LAB_DICT, ...
					    'COLS', [PanelPropIDictTable.SELECTOR SettingsText.VISIBLE SettingsText.X SettingsText.Y SettingsText.Z SettingsText.ROTATION SettingsText.TXT SettingsText.FONTNAME SettingsText.FONTSIZE SettingsText.FONTCOLOR SettingsText.INTERPRETER], ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@BrainSurfacePF(pf, prop, varargin{:});
					
			end
		end
	end
end
