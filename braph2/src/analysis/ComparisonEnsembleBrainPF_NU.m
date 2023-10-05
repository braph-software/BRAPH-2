classdef ComparisonEnsembleBrainPF_NU < ComparisonEnsembleBrainPF
	%ComparisonEnsembleBrainPF_NU is the base element to plot a nodal unilayer ensemble-based comparison figure on brain surface figure.
	% It is a subclass of <a href="matlab:help ComparisonEnsembleBrainPF">ComparisonEnsembleBrainPF</a>.
	%
	% ComparisonEnsembleBrainPF_NU manages the basic functionalities to plot of a nodal unilayer ensemble-based comparison figure on brain surface figure.
	%
	% ComparisonEnsembleBrainPF_NU methods (constructor):
	%  ComparisonEnsembleBrainPF_NU - constructor
	%
	% ComparisonEnsembleBrainPF_NU methods:
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
	% ComparisonEnsembleBrainPF_NU methods (display):
	%  tostring - string with information about the panel nodal unilayer ensemble-based comparison figure on brain surface figure
	%  disp - displays information about the panel nodal unilayer ensemble-based comparison figure on brain surface figure
	%  tree - displays the tree of the panel nodal unilayer ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF_NU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel nodal unilayer ensemble-based comparison figure on brain surface figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel nodal unilayer ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF_NU methods (save/load, Static):
	%  save - saves BRAPH2 panel nodal unilayer ensemble-based comparison figure on brain surface figure as b2 file
	%  load - loads a BRAPH2 panel nodal unilayer ensemble-based comparison figure on brain surface figure from a b2 file
	%
	% ComparisonEnsembleBrainPF_NU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel nodal unilayer ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF_NU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel nodal unilayer ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF_NU methods (inspection, Static):
	%  getClass - returns the class of the panel nodal unilayer ensemble-based comparison figure on brain surface figure
	%  getSubclasses - returns all subclasses of ComparisonEnsembleBrainPF_NU
	%  getProps - returns the property list of the panel nodal unilayer ensemble-based comparison figure on brain surface figure
	%  getPropNumber - returns the property number of the panel nodal unilayer ensemble-based comparison figure on brain surface figure
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
	% ComparisonEnsembleBrainPF_NU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonEnsembleBrainPF_NU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonEnsembleBrainPF_NU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonEnsembleBrainPF_NU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonEnsembleBrainPF_NU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonEnsembleBrainPF_NU constants</a>.
	%
	%
	% See also ComparisonEnsemble.
	
	properties (Constant) % properties
		LAYER = ComparisonEnsembleBrainPF.getPropNumber() + 1;
		LAYER_TAG = 'LAYER';
		LAYER_CATEGORY = Category.FIGURE;
		LAYER_FORMAT = Format.SCALAR;
		
		SIZE_DIFF = ComparisonEnsembleBrainPF.getPropNumber() + 2;
		SIZE_DIFF_TAG = 'SIZE_DIFF';
		SIZE_DIFF_CATEGORY = Category.FIGURE;
		SIZE_DIFF_FORMAT = Format.OPTION;
		
		SIZE_SCALE = ComparisonEnsembleBrainPF.getPropNumber() + 3;
		SIZE_SCALE_TAG = 'SIZE_SCALE';
		SIZE_SCALE_CATEGORY = Category.FIGURE;
		SIZE_SCALE_FORMAT = Format.SCALAR;
		
		COLOR_DIFF = ComparisonEnsembleBrainPF.getPropNumber() + 4;
		COLOR_DIFF_TAG = 'COLOR_DIFF';
		COLOR_DIFF_CATEGORY = Category.FIGURE;
		COLOR_DIFF_FORMAT = Format.OPTION;
		
		FDR = ComparisonEnsembleBrainPF.getPropNumber() + 5;
		FDR_TAG = 'FDR';
		FDR_CATEGORY = Category.FIGURE;
		FDR_FORMAT = Format.OPTION;
		
		QVALUE = ComparisonEnsembleBrainPF.getPropNumber() + 6;
		QVALUE_TAG = 'QVALUE';
		QVALUE_CATEGORY = Category.FIGURE;
		QVALUE_FORMAT = Format.SCALAR;
	end
	methods % constructor
		function pf = ComparisonEnsembleBrainPF_NU(varargin)
			%ComparisonEnsembleBrainPF_NU() creates a panel nodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% ComparisonEnsembleBrainPF_NU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonEnsembleBrainPF_NU(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel nodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% CLASS = ComparisonEnsembleBrainPF_NU.GETCLASS() returns the class 'ComparisonEnsembleBrainPF_NU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel nodal unilayer ensemble-based comparison figure on brain surface figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('ComparisonEnsembleBrainPF_NU') returns 'ComparisonEnsembleBrainPF_NU'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			
			pf_class = 'ComparisonEnsembleBrainPF_NU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel nodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% LIST = ComparisonEnsembleBrainPF_NU.GETSUBCLASSES() returns all subclasses of 'ComparisonEnsembleBrainPF_NU'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel nodal unilayer ensemble-based comparison figure on brain surface figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('ComparisonEnsembleBrainPF_NU') returns all subclasses of 'ComparisonEnsembleBrainPF_NU'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonEnsembleBrainPF_NU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel nodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% PROPS = ComparisonEnsembleBrainPF_NU.GETPROPS() returns the property list of panel nodal unilayer ensemble-based comparison figure on brain surface figure
			%  as a row vector.
			%
			% PROPS = ComparisonEnsembleBrainPF_NU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel nodal unilayer ensemble-based comparison figure on brain surface figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('ComparisonEnsembleBrainPF_NU'[, CATEGORY]) returns the property list of 'ComparisonEnsembleBrainPF_NU'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ComparisonEnsembleBrainPF.getProps() ...
						ComparisonEnsembleBrainPF_NU.LAYER ...
						ComparisonEnsembleBrainPF_NU.SIZE_DIFF ...
						ComparisonEnsembleBrainPF_NU.SIZE_SCALE ...
						ComparisonEnsembleBrainPF_NU.COLOR_DIFF ...
						ComparisonEnsembleBrainPF_NU.FDR ...
						ComparisonEnsembleBrainPF_NU.QVALUE ...
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
						ComparisonEnsembleBrainPF_NU.LAYER ...
						ComparisonEnsembleBrainPF_NU.SIZE_DIFF ...
						ComparisonEnsembleBrainPF_NU.SIZE_SCALE ...
						ComparisonEnsembleBrainPF_NU.COLOR_DIFF ...
						ComparisonEnsembleBrainPF_NU.FDR ...
						ComparisonEnsembleBrainPF_NU.QVALUE ...
						];
				case Category.GUI
					prop_list = [ ...
						ComparisonEnsembleBrainPF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel nodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% N = ComparisonEnsembleBrainPF_NU.GETPROPNUMBER() returns the property number of panel nodal unilayer ensemble-based comparison figure on brain surface figure.
			%
			% N = ComparisonEnsembleBrainPF_NU.GETPROPNUMBER(CATEGORY) returns the property number of panel nodal unilayer ensemble-based comparison figure on brain surface figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel nodal unilayer ensemble-based comparison figure on brain surface figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('ComparisonEnsembleBrainPF_NU') returns the property number of 'ComparisonEnsembleBrainPF_NU'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonEnsembleBrainPF_NU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel nodal unilayer ensemble-based comparison figure on brain surface figure/error.
			%
			% CHECK = ComparisonEnsembleBrainPF_NU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(ComparisonEnsembleBrainPF_NU, PROP) checks whether PROP exists for ComparisonEnsembleBrainPF_NU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsembleBrainPF_NU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_NU:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_NU:WrongInput]
			%  Element.EXISTSPROP(ComparisonEnsembleBrainPF_NU, PROP) throws error if PROP does NOT exist for ComparisonEnsembleBrainPF_NU.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_NU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonEnsembleBrainPF_NU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonEnsembleBrainPF_NU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel nodal unilayer ensemble-based comparison figure on brain surface figure/error.
			%
			% CHECK = ComparisonEnsembleBrainPF_NU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(ComparisonEnsembleBrainPF_NU, TAG) checks whether TAG exists for ComparisonEnsembleBrainPF_NU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsembleBrainPF_NU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_NU:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_NU:WrongInput]
			%  Element.EXISTSTAG(ComparisonEnsembleBrainPF_NU, TAG) throws error if TAG does NOT exist for ComparisonEnsembleBrainPF_NU.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF_NU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisonensemblebrainpf_nu_tag_list = cellfun(@(x) ComparisonEnsembleBrainPF_NU.getPropTag(x), num2cell(ComparisonEnsembleBrainPF_NU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisonensemblebrainpf_nu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonEnsembleBrainPF_NU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonEnsembleBrainPF_NU, POINTER) returns property number of POINTER of ComparisonEnsembleBrainPF_NU.
			%  PROPERTY = PF.GETPROPPROP(ComparisonEnsembleBrainPF_NU, POINTER) returns property number of POINTER of ComparisonEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisonensemblebrainpf_nu_tag_list = cellfun(@(x) ComparisonEnsembleBrainPF_NU.getPropTag(x), num2cell(ComparisonEnsembleBrainPF_NU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisonensemblebrainpf_nu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ComparisonEnsembleBrainPF_NU, POINTER) returns tag of POINTER of ComparisonEnsembleBrainPF_NU.
			%  TAG = PF.GETPROPTAG(ComparisonEnsembleBrainPF_NU, POINTER) returns tag of POINTER of ComparisonEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonEnsembleBrainPF_NU.LAYER
						tag = ComparisonEnsembleBrainPF_NU.LAYER_TAG;
					case ComparisonEnsembleBrainPF_NU.SIZE_DIFF
						tag = ComparisonEnsembleBrainPF_NU.SIZE_DIFF_TAG;
					case ComparisonEnsembleBrainPF_NU.SIZE_SCALE
						tag = ComparisonEnsembleBrainPF_NU.SIZE_SCALE_TAG;
					case ComparisonEnsembleBrainPF_NU.COLOR_DIFF
						tag = ComparisonEnsembleBrainPF_NU.COLOR_DIFF_TAG;
					case ComparisonEnsembleBrainPF_NU.FDR
						tag = ComparisonEnsembleBrainPF_NU.FDR_TAG;
					case ComparisonEnsembleBrainPF_NU.QVALUE
						tag = ComparisonEnsembleBrainPF_NU.QVALUE_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonEnsembleBrainPF_NU, POINTER) returns category of POINTER of ComparisonEnsembleBrainPF_NU.
			%  CATEGORY = PF.GETPROPCATEGORY(ComparisonEnsembleBrainPF_NU, POINTER) returns category of POINTER of ComparisonEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_NU.LAYER
					prop_category = ComparisonEnsembleBrainPF_NU.LAYER_CATEGORY;
				case ComparisonEnsembleBrainPF_NU.SIZE_DIFF
					prop_category = ComparisonEnsembleBrainPF_NU.SIZE_DIFF_CATEGORY;
				case ComparisonEnsembleBrainPF_NU.SIZE_SCALE
					prop_category = ComparisonEnsembleBrainPF_NU.SIZE_SCALE_CATEGORY;
				case ComparisonEnsembleBrainPF_NU.COLOR_DIFF
					prop_category = ComparisonEnsembleBrainPF_NU.COLOR_DIFF_CATEGORY;
				case ComparisonEnsembleBrainPF_NU.FDR
					prop_category = ComparisonEnsembleBrainPF_NU.FDR_CATEGORY;
				case ComparisonEnsembleBrainPF_NU.QVALUE
					prop_category = ComparisonEnsembleBrainPF_NU.QVALUE_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonEnsembleBrainPF_NU, POINTER) returns format of POINTER of ComparisonEnsembleBrainPF_NU.
			%  FORMAT = PF.GETPROPFORMAT(ComparisonEnsembleBrainPF_NU, POINTER) returns format of POINTER of ComparisonEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_NU.LAYER
					prop_format = ComparisonEnsembleBrainPF_NU.LAYER_FORMAT;
				case ComparisonEnsembleBrainPF_NU.SIZE_DIFF
					prop_format = ComparisonEnsembleBrainPF_NU.SIZE_DIFF_FORMAT;
				case ComparisonEnsembleBrainPF_NU.SIZE_SCALE
					prop_format = ComparisonEnsembleBrainPF_NU.SIZE_SCALE_FORMAT;
				case ComparisonEnsembleBrainPF_NU.COLOR_DIFF
					prop_format = ComparisonEnsembleBrainPF_NU.COLOR_DIFF_FORMAT;
				case ComparisonEnsembleBrainPF_NU.FDR
					prop_format = ComparisonEnsembleBrainPF_NU.FDR_FORMAT;
				case ComparisonEnsembleBrainPF_NU.QVALUE
					prop_format = ComparisonEnsembleBrainPF_NU.QVALUE_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonEnsembleBrainPF_NU, POINTER) returns description of POINTER of ComparisonEnsembleBrainPF_NU.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(ComparisonEnsembleBrainPF_NU, POINTER) returns description of POINTER of ComparisonEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_NU.LAYER
					prop_description = 'LAYER (figure, scalar) is the layer number of the nodal measure.';
				case ComparisonEnsembleBrainPF_NU.SIZE_DIFF
					prop_description = 'SIZE_DIFF (figure, option) determines whether the difference is shown with size effect.';
				case ComparisonEnsembleBrainPF_NU.SIZE_SCALE
					prop_description = 'SIZE_SCALE (figure, scalar) determines the scale of size effect.';
				case ComparisonEnsembleBrainPF_NU.COLOR_DIFF
					prop_description = 'COLOR_DIFF (figure, option) determines whether the difference is shown with color effect.';
				case ComparisonEnsembleBrainPF_NU.FDR
					prop_description = 'FDR (figure, option) determines whether the difference is shown with FDR correction.';
				case ComparisonEnsembleBrainPF_NU.QVALUE
					prop_description = 'QVALUE (figure, scalar) determines the QVALUE for FDR correction.';
				case ComparisonEnsembleBrainPF_NU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of % % % .';
				case ComparisonEnsembleBrainPF_NU.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure nodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_NU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure nodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_NU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure nodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_NU.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure nodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_NU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure nodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_NU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure nodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_NU.SETUP
					prop_description = 'SETUP (query, empty) calculates the diff value and stores it to be implemented in the subelements.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonEnsembleBrainPF_NU, POINTER) returns settings of POINTER of ComparisonEnsembleBrainPF_NU.
			%  SETTINGS = PF.GETPROPSETTINGS(ComparisonEnsembleBrainPF_NU, POINTER) returns settings of POINTER of ComparisonEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_NU.LAYER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ComparisonEnsembleBrainPF_NU.SIZE_DIFF
					prop_settings = {'on' 'off' 'disable'};
				case ComparisonEnsembleBrainPF_NU.SIZE_SCALE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ComparisonEnsembleBrainPF_NU.COLOR_DIFF
					prop_settings = {'on' 'off' 'disable'};
				case ComparisonEnsembleBrainPF_NU.FDR
					prop_settings = {'on' 'off' 'disable'};
				case ComparisonEnsembleBrainPF_NU.QVALUE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ComparisonEnsembleBrainPF_NU.TEMPLATE
					prop_settings = 'ComparisonEnsembleBrainPF_NU';
				otherwise
					prop_settings = getPropSettings@ComparisonEnsembleBrainPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonEnsembleBrainPF_NU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsembleBrainPF_NU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonEnsembleBrainPF_NU, POINTER) returns the default value of POINTER of ComparisonEnsembleBrainPF_NU.
			%  DEFAULT = PF.GETPROPDEFAULT(ComparisonEnsembleBrainPF_NU, POINTER) returns the default value of POINTER of ComparisonEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_NU.LAYER
					prop_default = 1;
				case ComparisonEnsembleBrainPF_NU.SIZE_DIFF
					prop_default = 'on';
				case ComparisonEnsembleBrainPF_NU.SIZE_SCALE
					prop_default = 10;
				case ComparisonEnsembleBrainPF_NU.COLOR_DIFF
					prop_default = 'on';
				case ComparisonEnsembleBrainPF_NU.FDR
					prop_default = 'off';
				case ComparisonEnsembleBrainPF_NU.QVALUE
					prop_default = 0.05;
				case ComparisonEnsembleBrainPF_NU.ELCLASS
					prop_default = 'ComparisonEnsembleBrainPF_NU';
				case ComparisonEnsembleBrainPF_NU.NAME
					prop_default = 'ComparisonEnsembleBrainPF_NU';
				case ComparisonEnsembleBrainPF_NU.DESCRIPTION
					prop_default = 'ComparisonEnsembleBrainPF_NU manages the basic functionalities to plot of a nodal unilayer ensemble-based comparison figure on brain surface.';
				case ComparisonEnsembleBrainPF_NU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonEnsembleBrainPF_NU.getPropSettings(prop));
				case ComparisonEnsembleBrainPF_NU.ID
					prop_default = 'ComparisonEnsembleBrainPF_NU ID';
				case ComparisonEnsembleBrainPF_NU.LABEL
					prop_default = 'ComparisonEnsembleBrainPF_NU label';
				case ComparisonEnsembleBrainPF_NU.NOTES
					prop_default = 'ComparisonEnsembleBrainPF_NU notes';
				otherwise
					prop_default = getPropDefault@ComparisonEnsembleBrainPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonEnsembleBrainPF_NU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsembleBrainPF_NU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonEnsembleBrainPF_NU, POINTER) returns the conditioned default value of POINTER of ComparisonEnsembleBrainPF_NU.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(ComparisonEnsembleBrainPF_NU, POINTER) returns the conditioned default value of POINTER of ComparisonEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonEnsembleBrainPF_NU.getPropProp(pointer);
			
			prop_default = ComparisonEnsembleBrainPF_NU.conditioning(prop, ComparisonEnsembleBrainPF_NU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonEnsembleBrainPF_NU, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsembleBrainPF_NU.
			%  CHECK = PF.CHECKPROP(ComparisonEnsembleBrainPF_NU, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsembleBrainPF_NU.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF_NU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF_NU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonEnsembleBrainPF_NU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsembleBrainPF_NU.
			%   Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF_NU:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(ComparisonEnsembleBrainPF_NU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsembleBrainPF_NU.
			%   Error id: €BRAPH2.STR€:ComparisonEnsembleBrainPF_NU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('ComparisonEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case ComparisonEnsembleBrainPF_NU.LAYER % __ComparisonEnsembleBrainPF_NU.LAYER__
					check = Format.checkFormat(Format.SCALAR, value, ComparisonEnsembleBrainPF_NU.getPropSettings(prop));
				case ComparisonEnsembleBrainPF_NU.SIZE_DIFF % __ComparisonEnsembleBrainPF_NU.SIZE_DIFF__
					check = Format.checkFormat(Format.OPTION, value, ComparisonEnsembleBrainPF_NU.getPropSettings(prop));
				case ComparisonEnsembleBrainPF_NU.SIZE_SCALE % __ComparisonEnsembleBrainPF_NU.SIZE_SCALE__
					check = Format.checkFormat(Format.SCALAR, value, ComparisonEnsembleBrainPF_NU.getPropSettings(prop));
				case ComparisonEnsembleBrainPF_NU.COLOR_DIFF % __ComparisonEnsembleBrainPF_NU.COLOR_DIFF__
					check = Format.checkFormat(Format.OPTION, value, ComparisonEnsembleBrainPF_NU.getPropSettings(prop));
				case ComparisonEnsembleBrainPF_NU.FDR % __ComparisonEnsembleBrainPF_NU.FDR__
					check = Format.checkFormat(Format.OPTION, value, ComparisonEnsembleBrainPF_NU.getPropSettings(prop));
				case ComparisonEnsembleBrainPF_NU.QVALUE % __ComparisonEnsembleBrainPF_NU.QVALUE__
					check = Format.checkFormat(Format.SCALAR, value, ComparisonEnsembleBrainPF_NU.getPropSettings(prop));
				case ComparisonEnsembleBrainPF_NU.TEMPLATE % __ComparisonEnsembleBrainPF_NU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonEnsembleBrainPF_NU.getPropSettings(prop));
				otherwise
					if prop <= ComparisonEnsembleBrainPF.getPropNumber()
						check = checkProp@ComparisonEnsembleBrainPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonEnsembleBrainPF_NU.getPropTag(prop) ' (' ComparisonEnsembleBrainPF_NU.getFormatTag(ComparisonEnsembleBrainPF_NU.getPropFormat(prop)) ').'] ...
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
				case ComparisonEnsembleBrainPF_NU.LAYER % __ComparisonEnsembleBrainPF_NU.LAYER__
					pf.get('SETUP');
					
				case ComparisonEnsembleBrainPF_NU.SIZE_DIFF % __ComparisonEnsembleBrainPF_NU.SIZE_DIFF__
					pf.get('SETUP');
					
				case ComparisonEnsembleBrainPF_NU.SIZE_SCALE % __ComparisonEnsembleBrainPF_NU.SIZE_SCALE__
					pf.get('SETUP');
					
				case ComparisonEnsembleBrainPF_NU.COLOR_DIFF % __ComparisonEnsembleBrainPF_NU.COLOR_DIFF__
					pf.get('SETUP');
					
				case ComparisonEnsembleBrainPF_NU.FDR % __ComparisonEnsembleBrainPF_NU.FDR__
					pf.get('SETUP');
					
				case ComparisonEnsembleBrainPF_NU.QVALUE % __ComparisonEnsembleBrainPF_NU.QVALUE__
					pf.get('CP').set('QVALUE', pf.get('QVALUE'));
					pf.get('SETUP');
					
				otherwise
					if prop <= ComparisonEnsembleBrainPF.getPropNumber()
						postset@ComparisonEnsembleBrainPF(pf, prop);
					end
			end
		end
	end
	methods (Access=protected) % postprocessing
		function postprocessing(pf, prop)
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
				case ComparisonEnsembleBrainPF_NU.QVALUE % __ComparisonEnsembleBrainPF_NU.QVALUE__
					if isempty(pf.get('QVALUE'))
					    pf.set('QVALUE', pf.get('CP').get('QVALUE'));
					end
					
				otherwise
					if prop <= ComparisonEnsembleBrainPF.getPropNumber()
						postprocessing@ComparisonEnsembleBrainPF(pf, prop);
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
				case ComparisonEnsembleBrainPF_NU.SETUP % __ComparisonEnsembleBrainPF_NU.SETUP__
					cp = pf.get('CP');
					g = cp.get('C').get('A1').get('GRAPH_TEMPLATE');
					
					% get brain region related list
					sph_list = pf.get('SPH_DICT').get('IT_LIST');
					sym_list = pf.get('SYM_DICT').get('IT_LIST');
					id_list = pf.get('ID_DICT').get('IT_LIST');
					lab_list = pf.get('LAB_DICT').get('IT_LIST');
					
					% get the value to show on the surface
					layer = pf.get('LAYER');
					diffs = cp.get('DIFF');
					if isempty(diffs)
					    value = {};
					    return
					end
					diff = diffs{layer};
					if isempty(diff)
					    value = {};
					    return
					end
					p2s = cp.get('P2');
					p2 = p2s{layer};
					
					% apply FDR to spheres, symbols, ids, and labels
					fdr_diff = pf.get('FDR');
					switch fdr_diff
					    case 'on'
					        [~, mask] = fdr(p2', pf.get('QVALUE'));
					        for i = 1:1:length(sph_list)
					            set(sph_list{i}, 'VISIBLE', mask(i));
					        end
					        for i = 1:1:length(sym_list)
					            set(sym_list{i}, 'VISIBLE', mask(i));
					        end
					        for i = 1:1:length(id_list)
					            set(id_list{i}, 'VISIBLE', mask(i));
					        end
					        for i = 1:1:length(lab_list)
					            set(lab_list{i}, 'VISIBLE', mask(i));
					        end
					    case 'off'
					        if pf.get('SPHS')
					            for i = 1:1:length(sph_list)
					                set(sph_list{i}, 'VISIBLE', true);
					            end
					        end
					        if pf.get('SYMS')
					            for i = 1:1:length(sym_list)
					                set(sym_list{i}, 'VISIBLE', true);
					            end
					        end
					        if pf.get('IDS')
					            for i = 1:1:length(id_list)
					                set(id_list{i}, 'VISIBLE', true);
					            end
					        end
					        if pf.get('LABS')
					            for i = 1:1:length(lab_list)
					                set(lab_list{i}, 'VISIBLE', true);
					            end
					        end
					    case 'disable'
					end
					
					size_diff = pf.get('SIZE_DIFF');
					switch size_diff
					    case 'on'
					        % transfrom diff value to appropriate size
					        % value ranching from 0.01 to 1
					        diff(isnan(diff)) = 0.1;
					        size_value = abs(diff);
					        min_bound = 0.01;
					        max_bound = 1.0;
					        min_size_value = min(size_value);
					        max_size_value = max(size_value);
					        if max_size_value == min_size_value
					            normalized_size_value = ones(size(size_value)) * max_bound;
					        else
					            normalized_size_value = min_bound + (max_bound - min_bound) * (size_value - min_size_value) / (max_size_value - min_size_value);
					        end
					        size_scale = pf.get('SIZE_SCALE');
					        scaled_size_value = normalized_size_value * size_scale;
					
					        % set size to sphs
					        for i = 1:1:length(sph_list)
					            set(sph_list{i}, 'SPHERESIZE', scaled_size_value(i));
					        end
					    case 'off'
					        if pf.get('SPHS')
					            for i = 1:1:length(sph_list)
					                set(sph_list{i}, 'SPHERESIZE', SettingsSphere.getPropDefault('SPHERESIZE'));
					            end
					        end
					    case 'disable'
					end
					
					color_diff = pf.get('COLOR_DIFF');
					switch color_diff
					    case 'on'
					        % transfrom diff value to appropriate color
					        % code
					        color_code_list = cell(size(diff));
					
					        for i = 1:numel(color_code_list)
					            if diff(i) > 0
					                color_code_list{i} = [1 0 0]; % Red
					            elseif diff(i) < 0
					                color_code_list{i} = [0 0 1]; % Blue
					            else
					                color_code_list{i} = [0 0 0]; % Black (or any other color for zero)
					            end
					        end
					
					        % set color to sphs
					        cellfun(@(sph, color_code) set(sph, 'FACECOLOR', color_code), sph_list, color_code_list', 'UniformOutput', false);
					    case 'off'
					        if pf.get('SPHS')
					            for i = 1:1:length(sph_list)
					                set(sph_list{i}, 'FACECOLOR', SettingsSphere.getPropDefault('FACECOLOR'));
					            end
					        end
					    case 'disable'
					end
					
					value = {};
					
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
