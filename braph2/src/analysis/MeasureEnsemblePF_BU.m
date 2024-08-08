classdef MeasureEnsemblePF_BU < MeasureEnsemblePF
	%MeasureEnsemblePF_BU is the base element to plot a binodal unilayer group comparison figure.
	% It is a subclass of <a href="matlab:help MeasureEnsemblePF">MeasureEnsemblePF</a>.
	%
	% MeasureEnsemblePF_BU manages the basic functionalities to plot of a binodal unilayer group comparison figure.
	%
	% MeasureEnsemblePF_BU methods (constructor):
	%  MeasureEnsemblePF_BU - constructor
	%
	% MeasureEnsemblePF_BU methods:
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
	% MeasureEnsemblePF_BU methods (display):
	%  tostring - string with information about the panel binodal unilayer group comparison figure
	%  disp - displays information about the panel binodal unilayer group comparison figure
	%  tree - displays the tree of the panel binodal unilayer group comparison figure
	%
	% MeasureEnsemblePF_BU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel binodal unilayer group comparison figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel binodal unilayer group comparison figure
	%
	% MeasureEnsemblePF_BU methods (save/load, Static):
	%  save - saves BRAPH2 panel binodal unilayer group comparison figure as b2 file
	%  load - loads a BRAPH2 panel binodal unilayer group comparison figure from a b2 file
	%
	% MeasureEnsemblePF_BU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel binodal unilayer group comparison figure
	%
	% MeasureEnsemblePF_BU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel binodal unilayer group comparison figure
	%
	% MeasureEnsemblePF_BU methods (inspection, Static):
	%  getClass - returns the class of the panel binodal unilayer group comparison figure
	%  getSubclasses - returns all subclasses of MeasureEnsemblePF_BU
	%  getProps - returns the property list of the panel binodal unilayer group comparison figure
	%  getPropNumber - returns the property number of the panel binodal unilayer group comparison figure
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
	% MeasureEnsemblePF_BU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureEnsemblePF_BU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureEnsemblePF_BU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureEnsemblePF_BU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureEnsemblePF_BU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureEnsemblePF_BU constants</a>.
	%
	%
	% See also MeasureEnsemble.
	
	properties (Constant) % properties
		NODES = MeasureEnsemblePF.getPropNumber() + 1;
		NODES_TAG = 'NODES';
		NODES_CATEGORY = Category.FIGURE;
		NODES_FORMAT = Format.RVECTOR;
		
		LAYER = MeasureEnsemblePF.getPropNumber() + 2;
		LAYER_TAG = 'LAYER';
		LAYER_CATEGORY = Category.FIGURE;
		LAYER_FORMAT = Format.SCALAR;
	end
	methods % constructor
		function pf = MeasureEnsemblePF_BU(varargin)
			%MeasureEnsemblePF_BU() creates a panel binodal unilayer group comparison figure.
			%
			% MeasureEnsemblePF_BU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureEnsemblePF_BU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@MeasureEnsemblePF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel binodal unilayer group comparison figure.
			%
			% CLASS = MeasureEnsemblePF_BU.GETCLASS() returns the class 'MeasureEnsemblePF_BU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel binodal unilayer group comparison figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasureEnsemblePF_BU') returns 'MeasureEnsemblePF_BU'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			
			pf_class = 'MeasureEnsemblePF_BU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel binodal unilayer group comparison figure.
			%
			% LIST = MeasureEnsemblePF_BU.GETSUBCLASSES() returns all subclasses of 'MeasureEnsemblePF_BU'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel binodal unilayer group comparison figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasureEnsemblePF_BU') returns all subclasses of 'MeasureEnsemblePF_BU'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasureEnsemblePF_BU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel binodal unilayer group comparison figure.
			%
			% PROPS = MeasureEnsemblePF_BU.GETPROPS() returns the property list of panel binodal unilayer group comparison figure
			%  as a row vector.
			%
			% PROPS = MeasureEnsemblePF_BU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel binodal unilayer group comparison figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasureEnsemblePF_BU'[, CATEGORY]) returns the property list of 'MeasureEnsemblePF_BU'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MeasureEnsemblePF.getProps() ...
						MeasureEnsemblePF_BU.NODES ...
						MeasureEnsemblePF_BU.LAYER ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MeasureEnsemblePF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MeasureEnsemblePF.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MeasureEnsemblePF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						MeasureEnsemblePF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MeasureEnsemblePF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MeasureEnsemblePF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MeasureEnsemblePF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MeasureEnsemblePF.getProps(Category.FIGURE) ...
						MeasureEnsemblePF_BU.NODES ...
						MeasureEnsemblePF_BU.LAYER ...
						];
				case Category.GUI
					prop_list = [ ...
						MeasureEnsemblePF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel binodal unilayer group comparison figure.
			%
			% N = MeasureEnsemblePF_BU.GETPROPNUMBER() returns the property number of panel binodal unilayer group comparison figure.
			%
			% N = MeasureEnsemblePF_BU.GETPROPNUMBER(CATEGORY) returns the property number of panel binodal unilayer group comparison figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel binodal unilayer group comparison figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasureEnsemblePF_BU') returns the property number of 'MeasureEnsemblePF_BU'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasureEnsemblePF_BU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel binodal unilayer group comparison figure/error.
			%
			% CHECK = MeasureEnsemblePF_BU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasureEnsemblePF_BU, PROP) checks whether PROP exists for MeasureEnsemblePF_BU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemblePF_BU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BU:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BU:WrongInput]
			%  Element.EXISTSPROP(MeasureEnsemblePF_BU, PROP) throws error if PROP does NOT exist for MeasureEnsemblePF_BU.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasureEnsemblePF_BU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsemblePF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemblePF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureEnsemblePF_BU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel binodal unilayer group comparison figure/error.
			%
			% CHECK = MeasureEnsemblePF_BU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasureEnsemblePF_BU, TAG) checks whether TAG exists for MeasureEnsemblePF_BU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemblePF_BU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BU:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BU:WrongInput]
			%  Element.EXISTSTAG(MeasureEnsemblePF_BU, TAG) throws error if TAG does NOT exist for MeasureEnsemblePF_BU.
			%   Error id: [BRAPH2:MeasureEnsemblePF_BU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measureensemblepf_bu_tag_list = cellfun(@(x) MeasureEnsemblePF_BU.getPropTag(x), num2cell(MeasureEnsemblePF_BU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measureensemblepf_bu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsemblePF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemblePF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasureEnsemblePF_BU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureEnsemblePF_BU, POINTER) returns property number of POINTER of MeasureEnsemblePF_BU.
			%  PROPERTY = PF.GETPROPPROP(MeasureEnsemblePF_BU, POINTER) returns property number of POINTER of MeasureEnsemblePF_BU.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measureensemblepf_bu_tag_list = cellfun(@(x) MeasureEnsemblePF_BU.getPropTag(x), num2cell(MeasureEnsemblePF_BU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measureensemblepf_bu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasureEnsemblePF_BU, POINTER) returns tag of POINTER of MeasureEnsemblePF_BU.
			%  TAG = PF.GETPROPTAG(MeasureEnsemblePF_BU, POINTER) returns tag of POINTER of MeasureEnsemblePF_BU.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MeasureEnsemblePF_BU.NODES
						tag = MeasureEnsemblePF_BU.NODES_TAG;
					case MeasureEnsemblePF_BU.LAYER
						tag = MeasureEnsemblePF_BU.LAYER_TAG;
					otherwise
						tag = getPropTag@MeasureEnsemblePF(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureEnsemblePF_BU, POINTER) returns category of POINTER of MeasureEnsemblePF_BU.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasureEnsemblePF_BU, POINTER) returns category of POINTER of MeasureEnsemblePF_BU.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_BU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF_BU.NODES
					prop_category = MeasureEnsemblePF_BU.NODES_CATEGORY;
				case MeasureEnsemblePF_BU.LAYER
					prop_category = MeasureEnsemblePF_BU.LAYER_CATEGORY;
				otherwise
					prop_category = getPropCategory@MeasureEnsemblePF(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureEnsemblePF_BU, POINTER) returns format of POINTER of MeasureEnsemblePF_BU.
			%  FORMAT = PF.GETPROPFORMAT(MeasureEnsemblePF_BU, POINTER) returns format of POINTER of MeasureEnsemblePF_BU.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_BU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF_BU.NODES
					prop_format = MeasureEnsemblePF_BU.NODES_FORMAT;
				case MeasureEnsemblePF_BU.LAYER
					prop_format = MeasureEnsemblePF_BU.LAYER_FORMAT;
				otherwise
					prop_format = getPropFormat@MeasureEnsemblePF(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureEnsemblePF_BU, POINTER) returns description of POINTER of MeasureEnsemblePF_BU.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasureEnsemblePF_BU, POINTER) returns description of POINTER of MeasureEnsemblePF_BU.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_BU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF_BU.NODES
					prop_description = 'NODES (figure, rvector) are the node numbers of the binodal group comparison figure.';
				case MeasureEnsemblePF_BU.LAYER
					prop_description = 'LAYER (figure, scalar) is the layer number of the binodal measure.';
				case MeasureEnsemblePF_BU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the MeasureEnsemblePF_BU.';
				case MeasureEnsemblePF_BU.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure binodal unilayer group comparison figure.';
				case MeasureEnsemblePF_BU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure binodal unilayer group comparison figure.';
				case MeasureEnsemblePF_BU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure binodal unilayer group comparison figure.';
				case MeasureEnsemblePF_BU.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure binodal unilayer group comparison figure.';
				case MeasureEnsemblePF_BU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure binodal unilayer group comparison figure.';
				case MeasureEnsemblePF_BU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure binodal unilayer group comparison figure.';
				case MeasureEnsemblePF_BU.SETUP
					prop_description = 'SETUP (query, empty) calculates the group comparison figure value and stores it.';
				otherwise
					prop_description = getPropDescription@MeasureEnsemblePF(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureEnsemblePF_BU, POINTER) returns settings of POINTER of MeasureEnsemblePF_BU.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasureEnsemblePF_BU, POINTER) returns settings of POINTER of MeasureEnsemblePF_BU.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF_BU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF_BU.NODES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case MeasureEnsemblePF_BU.LAYER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MeasureEnsemblePF_BU.TEMPLATE
					prop_settings = 'MeasureEnsemblePF_BU';
				otherwise
					prop_settings = getPropSettings@MeasureEnsemblePF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureEnsemblePF_BU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemblePF_BU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureEnsemblePF_BU, POINTER) returns the default value of POINTER of MeasureEnsemblePF_BU.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasureEnsemblePF_BU, POINTER) returns the default value of POINTER of MeasureEnsemblePF_BU.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsemblePF_BU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF_BU.NODES
					prop_default = [1 1];
				case MeasureEnsemblePF_BU.LAYER
					prop_default = 1;
				case MeasureEnsemblePF_BU.ELCLASS
					prop_default = 'MeasureEnsemblePF_BU';
				case MeasureEnsemblePF_BU.NAME
					prop_default = 'MeasureEnsemblePF_BU';
				case MeasureEnsemblePF_BU.DESCRIPTION
					prop_default = 'MeasureEnsemblePF_BU manages the basic functionalities to plot of a binodal unilayer group comparison figure.';
				case MeasureEnsemblePF_BU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsemblePF_BU.getPropSettings(prop));
				case MeasureEnsemblePF_BU.ID
					prop_default = 'MeasureEnsemblePF_BU ID';
				case MeasureEnsemblePF_BU.LABEL
					prop_default = 'MeasureEnsemblePF_BU label';
				case MeasureEnsemblePF_BU.NOTES
					prop_default = 'MeasureEnsemblePF_BU notes';
				otherwise
					prop_default = getPropDefault@MeasureEnsemblePF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureEnsemblePF_BU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemblePF_BU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureEnsemblePF_BU, POINTER) returns the conditioned default value of POINTER of MeasureEnsemblePF_BU.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasureEnsemblePF_BU, POINTER) returns the conditioned default value of POINTER of MeasureEnsemblePF_BU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureEnsemblePF_BU.getPropProp(pointer);
			
			prop_default = MeasureEnsemblePF_BU.conditioning(prop, MeasureEnsemblePF_BU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureEnsemblePF_BU, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemblePF_BU.
			%  CHECK = PF.CHECKPROP(MeasureEnsemblePF_BU, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemblePF_BU.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasureEnsemblePF_BU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasureEnsemblePF_BU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasureEnsemblePF_BU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemblePF_BU.
			%   Error id: €BRAPH2.STR€:MeasureEnsemblePF_BU:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasureEnsemblePF_BU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemblePF_BU.
			%   Error id: €BRAPH2.STR€:MeasureEnsemblePF_BU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasureEnsemblePF_BU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureEnsemblePF_BU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF_BU.NODES % __MeasureEnsemblePF_BU.NODES__
					check = Format.checkFormat(Format.RVECTOR, value, MeasureEnsemblePF_BU.getPropSettings(prop));
				case MeasureEnsemblePF_BU.LAYER % __MeasureEnsemblePF_BU.LAYER__
					check = Format.checkFormat(Format.SCALAR, value, MeasureEnsemblePF_BU.getPropSettings(prop));
				case MeasureEnsemblePF_BU.TEMPLATE % __MeasureEnsemblePF_BU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemblePF_BU.getPropSettings(prop));
				otherwise
					if prop <= MeasureEnsemblePF.getPropNumber()
						check = checkProp@MeasureEnsemblePF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsemblePF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemblePF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureEnsemblePF_BU.getPropTag(prop) ' (' MeasureEnsemblePF_BU.getFormatTag(MeasureEnsemblePF_BU.getPropFormat(prop)) ').'] ...
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
				case MeasureEnsemblePF_BU.NODES % __MeasureEnsemblePF_BU.NODES__
					pf.get('SETUP')
					
				case MeasureEnsemblePF_BU.LAYER % __MeasureEnsemblePF_BU.LAYER__
					pf.get('SETUP');
					
				otherwise
					if prop <= MeasureEnsemblePF.getPropNumber()
						postset@MeasureEnsemblePF(pf, prop);
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
				case MeasureEnsemblePF_BU.SETUP % __MeasureEnsemblePF_BU.SETUP__
					me = pf.get('ME');
					if me.get('A').get('G_DICT').get('LENGTH')
					    g = me.get('A').get('G_DICT').get('IT', 1);
					else
					    g = me.get('A').get('GRAPH_TEMPLATE');
					end
					
					x = g.get('APARTITIONTICKS');
					
					nodes = pf.get('NODES');
					layer = pf.get('LAYER');
					m = cellfun(@(x) x(nodes(1), nodes(2)), me.get('M'))';
					layers_num = length(g.get('ALAYERTICKS'));
					m2 = zeros(1, length(x));
					count=1;
					for i=layer:layers_num:g.get('LAYERNUMBER')
					    m2(count) = m(i);
					    count = count + 1;
					end
					pf.memorize('ST_LINE_M').set('X', x, 'Y', m2)
					
					xlim = pf.get('H_AXES').get('XLim');
					ylim = pf.get('H_AXES').get('YLim');
					anodelabels = g.get('ANODELABELS');
					if isequal(anodelabels, {'numbered'})
					    title = [me.get('LABEL') ' ' int2str(nodes(1)) ' ' int2str(nodes(2))];
					else
					    title = [me.get('LABEL') ' ' anodelabels{nodes(1)} ' ' anodelabels{nodes(2)}];
					end
					pf.get('ST_TITLE').set( ...
					    'TXT', title, ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_XLABEL').set( ...
					    'TXT', 'Partition', ...
					    'X', .5 * (xlim(2) + xlim(1)), ...
					    'Y', ylim(1) - .07 * (ylim(2) - ylim(1)), ...
					    'Z', 0 ...
					    )
					pf.get('ST_YLABEL').set( ...
						'TXT', 'Measure Value', ...
					    'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
					    'Y', .5 * (ylim(2) + ylim(1)), ...
					    'Z', 0 ...
					    )
					
					value = [];
					
				otherwise
					if prop <= MeasureEnsemblePF.getPropNumber()
						value = calculateValue@MeasureEnsemblePF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
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
				case MeasureEnsemblePF_BU.NODES % __MeasureEnsemblePF_BU.NODES__
					pr = MeasureEnsemblePF_BxPP_Nodes('EL', pf, 'PROP', MeasureEnsemblePF_BU.NODES);
					
				case MeasureEnsemblePF_BU.LAYER % __MeasureEnsemblePF_BU.LAYER__
					pr = MeasureEnsemblePF_xUPP_Layer('EL', pf, 'PROP', MeasureEnsemblePF_BU.LAYER);
					
				otherwise
					pr = getPanelProp@MeasureEnsemblePF(pf, prop, varargin{:});
					
			end
		end
	end
end
