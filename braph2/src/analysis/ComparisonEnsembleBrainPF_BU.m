classdef ComparisonEnsembleBrainPF_BU < ComparisonEnsembleBrainPF
	%ComparisonEnsembleBrainPF_BU is the base element to plot a binodal unilayer ensemble-based comparison figure on brain surface figure.
	% It is a subclass of <a href="matlab:help ComparisonEnsembleBrainPF">ComparisonEnsembleBrainPF</a>.
	%
	% ComparisonEnsembleBrainPF_BU manages the basic functionalities to plot of a binodal unilayer ensemble-based comparison figure on brain surface figure.
	%
	% ComparisonEnsembleBrainPF_BU methods (constructor):
	%  ComparisonEnsembleBrainPF_BU - constructor
	%
	% ComparisonEnsembleBrainPF_BU methods:
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
	% ComparisonEnsembleBrainPF_BU methods (display):
	%  tostring - string with information about the panel binodal unilayer ensemble-based comparison figure on brain surface figure
	%  disp - displays information about the panel binodal unilayer ensemble-based comparison figure on brain surface figure
	%  tree - displays the tree of the panel binodal unilayer ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF_BU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel binodal unilayer ensemble-based comparison figure on brain surface figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel binodal unilayer ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF_BU methods (save/load, Static):
	%  save - saves BRAPH2 panel binodal unilayer ensemble-based comparison figure on brain surface figure as b2 file
	%  load - loads a BRAPH2 panel binodal unilayer ensemble-based comparison figure on brain surface figure from a b2 file
	%
	% ComparisonEnsembleBrainPF_BU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel binodal unilayer ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF_BU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel binodal unilayer ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF_BU methods (inspection, Static):
	%  getClass - returns the class of the panel binodal unilayer ensemble-based comparison figure on brain surface figure
	%  getSubclasses - returns all subclasses of ComparisonEnsembleBrainPF_BU
	%  getProps - returns the property list of the panel binodal unilayer ensemble-based comparison figure on brain surface figure
	%  getPropNumber - returns the property number of the panel binodal unilayer ensemble-based comparison figure on brain surface figure
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
	% ComparisonEnsembleBrainPF_BU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonEnsembleBrainPF_BU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonEnsembleBrainPF_BU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonEnsembleBrainPF_BU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonEnsembleBrainPF_BU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonEnsembleBrainPF_BU constants</a>.
	%
	%
	% See also ComparisonEnsemble.
	
	properties (Constant) % properties
		NODES = ComparisonEnsembleBrainPF.getPropNumber() + 1;
		NODES_TAG = 'NODES';
		NODES_CATEGORY = Category.FIGURE;
		NODES_FORMAT = Format.RVECTOR;
	end
	methods % constructor
		function pf = ComparisonEnsembleBrainPF_BU(varargin)
			%ComparisonEnsembleBrainPF_BU() creates a panel binodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% ComparisonEnsembleBrainPF_BU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonEnsembleBrainPF_BU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@ComparisonEnsembleBrainPF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel binodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% CLASS = ComparisonEnsembleBrainPF_BU.GETCLASS() returns the class 'ComparisonEnsembleBrainPF_BU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel binodal unilayer ensemble-based comparison figure on brain surface figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('ComparisonEnsembleBrainPF_BU') returns 'ComparisonEnsembleBrainPF_BU'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			
			pf_class = 'ComparisonEnsembleBrainPF_BU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel binodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% LIST = ComparisonEnsembleBrainPF_BU.GETSUBCLASSES() returns all subclasses of 'ComparisonEnsembleBrainPF_BU'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel binodal unilayer ensemble-based comparison figure on brain surface figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('ComparisonEnsembleBrainPF_BU') returns all subclasses of 'ComparisonEnsembleBrainPF_BU'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonEnsembleBrainPF_BU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel binodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% PROPS = ComparisonEnsembleBrainPF_BU.GETPROPS() returns the property list of panel binodal unilayer ensemble-based comparison figure on brain surface figure
			%  as a row vector.
			%
			% PROPS = ComparisonEnsembleBrainPF_BU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel binodal unilayer ensemble-based comparison figure on brain surface figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('ComparisonEnsembleBrainPF_BU'[, CATEGORY]) returns the property list of 'ComparisonEnsembleBrainPF_BU'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ComparisonEnsembleBrainPF.getProps() ...
						ComparisonEnsembleBrainPF_BU.NODES ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ComparisonEnsembleBrainPF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ComparisonEnsembleBrainPF.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ComparisonEnsembleBrainPF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ComparisonEnsembleBrainPF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						ComparisonEnsembleBrainPF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ComparisonEnsembleBrainPF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ComparisonEnsembleBrainPF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ComparisonEnsembleBrainPF.getProps(Category.FIGURE) ...
						ComparisonEnsembleBrainPF_BU.NODES ...
						];
				case Category.GUI
					prop_list = [ ...
						ComparisonEnsembleBrainPF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel binodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% N = ComparisonEnsembleBrainPF_BU.GETPROPNUMBER() returns the property number of panel binodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% N = ComparisonEnsembleBrainPF_BU.GETPROPNUMBER(CATEGORY) returns the property number of panel binodal unilayer ensemble-based comparison figure on brain surface figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel binodal unilayer ensemble-based comparison figure on brain surface figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('ComparisonEnsembleBrainPF_BU') returns the property number of 'ComparisonEnsembleBrainPF_BU'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonEnsembleBrainPF_BU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel binodal unilayer ensemble-based comparison figure on brain surface figure/error.
			%
			% CHECK = ComparisonEnsembleBrainPF_BU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(ComparisonEnsembleBrainPF_BU, PROP) checks whether PROP exists for ComparisonEnsembleBrainPF_BU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsembleBrainPF_BU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_BU:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_BU:WrongInput]
			%  Element.EXISTSPROP(ComparisonEnsembleBrainPF_BU, PROP) throws error if PROP does NOT exist for ComparisonEnsembleBrainPF_BU.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_BU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonEnsembleBrainPF_BU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonEnsembleBrainPF_BU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel binodal unilayer ensemble-based comparison figure on brain surface figure/error.
			%
			% CHECK = ComparisonEnsembleBrainPF_BU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(ComparisonEnsembleBrainPF_BU, TAG) checks whether TAG exists for ComparisonEnsembleBrainPF_BU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsembleBrainPF_BU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_BU:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_BU:WrongInput]
			%  Element.EXISTSTAG(ComparisonEnsembleBrainPF_BU, TAG) throws error if TAG does NOT exist for ComparisonEnsembleBrainPF_BU.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_BU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisonensemblebrainpf_bu_tag_list = cellfun(@(x) ComparisonEnsembleBrainPF_BU.getPropTag(x), num2cell(ComparisonEnsembleBrainPF_BU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisonensemblebrainpf_bu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonEnsembleBrainPF_BU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonEnsembleBrainPF_BU, POINTER) returns property number of POINTER of ComparisonEnsembleBrainPF_BU.
			%  PROPERTY = PF.GETPROPPROP(ComparisonEnsembleBrainPF_BU, POINTER) returns property number of POINTER of ComparisonEnsembleBrainPF_BU.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisonensemblebrainpf_bu_tag_list = cellfun(@(x) ComparisonEnsembleBrainPF_BU.getPropTag(x), num2cell(ComparisonEnsembleBrainPF_BU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisonensemblebrainpf_bu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ComparisonEnsembleBrainPF_BU, POINTER) returns tag of POINTER of ComparisonEnsembleBrainPF_BU.
			%  TAG = PF.GETPROPTAG(ComparisonEnsembleBrainPF_BU, POINTER) returns tag of POINTER of ComparisonEnsembleBrainPF_BU.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonEnsembleBrainPF_BU.NODES
						tag = ComparisonEnsembleBrainPF_BU.NODES_TAG;
					otherwise
						tag = getPropTag@ComparisonEnsembleBrainPF(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonEnsembleBrainPF_BU, POINTER) returns category of POINTER of ComparisonEnsembleBrainPF_BU.
			%  CATEGORY = PF.GETPROPCATEGORY(ComparisonEnsembleBrainPF_BU, POINTER) returns category of POINTER of ComparisonEnsembleBrainPF_BU.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_BU.NODES
					prop_category = ComparisonEnsembleBrainPF_BU.NODES_CATEGORY;
				otherwise
					prop_category = getPropCategory@ComparisonEnsembleBrainPF(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonEnsembleBrainPF_BU, POINTER) returns format of POINTER of ComparisonEnsembleBrainPF_BU.
			%  FORMAT = PF.GETPROPFORMAT(ComparisonEnsembleBrainPF_BU, POINTER) returns format of POINTER of ComparisonEnsembleBrainPF_BU.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_BU.NODES
					prop_format = ComparisonEnsembleBrainPF_BU.NODES_FORMAT;
				otherwise
					prop_format = getPropFormat@ComparisonEnsembleBrainPF(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonEnsembleBrainPF_BU, POINTER) returns description of POINTER of ComparisonEnsembleBrainPF_BU.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(ComparisonEnsembleBrainPF_BU, POINTER) returns description of POINTER of ComparisonEnsembleBrainPF_BU.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_BU.NODES
					prop_description = 'NODES (figure, rvector) are the node numbers of the binodal group comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_BU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ComparisonEnsembleBrainPF_BU.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure binodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_BU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure binodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_BU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure binodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_BU.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure binodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_BU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure binodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_BU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure binodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_BU.SETUP
					prop_description = 'SETUP (query, empty) calculates the group comparison figure value and stores it.';
				otherwise
					prop_description = getPropDescription@ComparisonEnsembleBrainPF(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonEnsembleBrainPF_BU, POINTER) returns settings of POINTER of ComparisonEnsembleBrainPF_BU.
			%  SETTINGS = PF.GETPROPSETTINGS(ComparisonEnsembleBrainPF_BU, POINTER) returns settings of POINTER of ComparisonEnsembleBrainPF_BU.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_BU.NODES
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ComparisonEnsembleBrainPF_BU.TEMPLATE
					prop_settings = 'ComparisonEnsembleBrainPF_BU';
				otherwise
					prop_settings = getPropSettings@ComparisonEnsembleBrainPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonEnsembleBrainPF_BU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsembleBrainPF_BU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonEnsembleBrainPF_BU, POINTER) returns the default value of POINTER of ComparisonEnsembleBrainPF_BU.
			%  DEFAULT = PF.GETPROPDEFAULT(ComparisonEnsembleBrainPF_BU, POINTER) returns the default value of POINTER of ComparisonEnsembleBrainPF_BU.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonEnsembleBrainPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_BU.NODES
					prop_default = Format.getFormatDefault(Format.RVECTOR, ComparisonEnsembleBrainPF_BU.getPropSettings(prop));
				case ComparisonEnsembleBrainPF_BU.ELCLASS
					prop_default = 'ComparisonEnsembleBrainPF_BU';
				case ComparisonEnsembleBrainPF_BU.NAME
					prop_default = 'ComparisonEnsembleBrainPF_BU';
				case ComparisonEnsembleBrainPF_BU.DESCRIPTION
					prop_default = 'ComparisonEnsembleBrainPF_BU manages the basic functionalities to plot of a binodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_BU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsembleBrainPF_BU.getPropSettings(prop));
				case ComparisonEnsembleBrainPF_BU.ID
					prop_default = 'ComparisonEnsembleBrainPF_BU ID';
				case ComparisonEnsembleBrainPF_BU.LABEL
					prop_default = 'ComparisonEnsembleBrainPF_BU label';
				case ComparisonEnsembleBrainPF_BU.NOTES
					prop_default = 'ComparisonEnsembleBrainPF_BU notes';
				otherwise
					prop_default = getPropDefault@ComparisonEnsembleBrainPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonEnsembleBrainPF_BU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsembleBrainPF_BU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonEnsembleBrainPF_BU, POINTER) returns the conditioned default value of POINTER of ComparisonEnsembleBrainPF_BU.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(ComparisonEnsembleBrainPF_BU, POINTER) returns the conditioned default value of POINTER of ComparisonEnsembleBrainPF_BU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonEnsembleBrainPF_BU.getPropProp(pointer);
			
			prop_default = ComparisonEnsembleBrainPF_BU.conditioning(prop, ComparisonEnsembleBrainPF_BU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonEnsembleBrainPF_BU, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsembleBrainPF_BU.
			%  CHECK = PF.CHECKPROP(ComparisonEnsembleBrainPF_BU, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsembleBrainPF_BU.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF_BU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF_BU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonEnsembleBrainPF_BU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsembleBrainPF_BU.
			%   Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF_BU:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(ComparisonEnsembleBrainPF_BU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsembleBrainPF_BU.
			%   Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF_BU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('ComparisonEnsembleBrainPF_BU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonEnsembleBrainPF_BU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_BU.NODES % __ComparisonEnsembleBrainPF_BU.NODES__
					check = Format.checkFormat(Format.RVECTOR, value, ComparisonEnsembleBrainPF_BU.getPropSettings(prop));
				case ComparisonEnsembleBrainPF_BU.TEMPLATE % __ComparisonEnsembleBrainPF_BU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsembleBrainPF_BU.getPropSettings(prop));
				otherwise
					if prop <= ComparisonEnsembleBrainPF.getPropNumber()
						check = checkProp@ComparisonEnsembleBrainPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_BU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_BU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonEnsembleBrainPF_BU.getPropTag(prop) ' (' ComparisonEnsembleBrainPF_BU.getFormatTag(ComparisonEnsembleBrainPF_BU.getPropFormat(prop)) ').'] ...
					)
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
				case ComparisonEnsembleBrainPF_BU.SETUP % __ComparisonEnsembleBrainPF_BU.SETUP__
					%%%__WARN_TBI__
					value = [];
					
				otherwise
					if prop <= ComparisonEnsembleBrainPF.getPropNumber()
						value = calculateValue@ComparisonEnsembleBrainPF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
end
