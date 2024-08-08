classdef ComparisonGroupBrainPF_NS < ComparisonGroupBrainPF
	%ComparisonGroupBrainPF_NS is the base element to plot a nodal superglobal group comparison on brain surface figure.
	% It is a subclass of <a href="matlab:help ComparisonGroupBrainPF">ComparisonGroupBrainPF</a>.
	%
	% ComparisonGroupBrainPF_NS manages the basic functionalities to plot of a nodal superglobal group comparison on brain surface figure.
	%
	% ComparisonGroupBrainPF_NS methods (constructor):
	%  ComparisonGroupBrainPF_NS - constructor
	%
	% ComparisonGroupBrainPF_NS methods:
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
	% ComparisonGroupBrainPF_NS methods (display):
	%  tostring - string with information about the panel nodal superglobal group comparison on brain surface figure
	%  disp - displays information about the panel nodal superglobal group comparison on brain surface figure
	%  tree - displays the tree of the panel nodal superglobal group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF_NS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel nodal superglobal group comparison on brain surface figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel nodal superglobal group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF_NS methods (save/load, Static):
	%  save - saves BRAPH2 panel nodal superglobal group comparison on brain surface figure as b2 file
	%  load - loads a BRAPH2 panel nodal superglobal group comparison on brain surface figure from a b2 file
	%
	% ComparisonGroupBrainPF_NS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel nodal superglobal group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF_NS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel nodal superglobal group comparison on brain surface figure
	%
	% ComparisonGroupBrainPF_NS methods (inspection, Static):
	%  getClass - returns the class of the panel nodal superglobal group comparison on brain surface figure
	%  getSubclasses - returns all subclasses of ComparisonGroupBrainPF_NS
	%  getProps - returns the property list of the panel nodal superglobal group comparison on brain surface figure
	%  getPropNumber - returns the property number of the panel nodal superglobal group comparison on brain surface figure
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
	% ComparisonGroupBrainPF_NS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonGroupBrainPF_NS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonGroupBrainPF_NS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonGroupBrainPF_NS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonGroupBrainPF_NS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonGroupBrainPF_NS constants</a>.
	%
	%
	% See also ComparisonGroup.
	
	properties (Constant) % properties
		LAYER = ComparisonGroupBrainPF.getPropNumber() + 1;
		LAYER_TAG = 'LAYER';
		LAYER_CATEGORY = Category.FIGURE;
		LAYER_FORMAT = Format.SCALAR;
		
		SIZE_DIFF = ComparisonGroupBrainPF.getPropNumber() + 2;
		SIZE_DIFF_TAG = 'SIZE_DIFF';
		SIZE_DIFF_CATEGORY = Category.FIGURE;
		SIZE_DIFF_FORMAT = Format.OPTION;
		
		SIZE_SCALE = ComparisonGroupBrainPF.getPropNumber() + 3;
		SIZE_SCALE_TAG = 'SIZE_SCALE';
		SIZE_SCALE_CATEGORY = Category.FIGURE;
		SIZE_SCALE_FORMAT = Format.SCALAR;
		
		COLOR_DIFF = ComparisonGroupBrainPF.getPropNumber() + 4;
		COLOR_DIFF_TAG = 'COLOR_DIFF';
		COLOR_DIFF_CATEGORY = Category.FIGURE;
		COLOR_DIFF_FORMAT = Format.OPTION;
		
		FDR = ComparisonGroupBrainPF.getPropNumber() + 5;
		FDR_TAG = 'FDR';
		FDR_CATEGORY = Category.FIGURE;
		FDR_FORMAT = Format.OPTION;
		
		QVALUE = ComparisonGroupBrainPF.getPropNumber() + 6;
		QVALUE_TAG = 'QVALUE';
		QVALUE_CATEGORY = Category.FIGURE;
		QVALUE_FORMAT = Format.SCALAR;
	end
	methods % constructor
		function pf = ComparisonGroupBrainPF_NS(varargin)
			%ComparisonGroupBrainPF_NS() creates a panel nodal superglobal group comparison on brain surface figure.
			%
			% ComparisonGroupBrainPF_NS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonGroupBrainPF_NS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@ComparisonGroupBrainPF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel nodal superglobal group comparison on brain surface figure.
			%
			% CLASS = ComparisonGroupBrainPF_NS.GETCLASS() returns the class 'ComparisonGroupBrainPF_NS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel nodal superglobal group comparison on brain surface figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('ComparisonGroupBrainPF_NS') returns 'ComparisonGroupBrainPF_NS'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			
			pf_class = 'ComparisonGroupBrainPF_NS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel nodal superglobal group comparison on brain surface figure.
			%
			% LIST = ComparisonGroupBrainPF_NS.GETSUBCLASSES() returns all subclasses of 'ComparisonGroupBrainPF_NS'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel nodal superglobal group comparison on brain surface figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('ComparisonGroupBrainPF_NS') returns all subclasses of 'ComparisonGroupBrainPF_NS'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonGroupBrainPF_NS', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel nodal superglobal group comparison on brain surface figure.
			%
			% PROPS = ComparisonGroupBrainPF_NS.GETPROPS() returns the property list of panel nodal superglobal group comparison on brain surface figure
			%  as a row vector.
			%
			% PROPS = ComparisonGroupBrainPF_NS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel nodal superglobal group comparison on brain surface figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('ComparisonGroupBrainPF_NS'[, CATEGORY]) returns the property list of 'ComparisonGroupBrainPF_NS'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ComparisonGroupBrainPF.getProps() ...
						ComparisonGroupBrainPF_NS.LAYER ...
						ComparisonGroupBrainPF_NS.SIZE_DIFF ...
						ComparisonGroupBrainPF_NS.SIZE_SCALE ...
						ComparisonGroupBrainPF_NS.COLOR_DIFF ...
						ComparisonGroupBrainPF_NS.FDR ...
						ComparisonGroupBrainPF_NS.QVALUE ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						ComparisonGroupBrainPF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.FIGURE) ...
						ComparisonGroupBrainPF_NS.LAYER ...
						ComparisonGroupBrainPF_NS.SIZE_DIFF ...
						ComparisonGroupBrainPF_NS.SIZE_SCALE ...
						ComparisonGroupBrainPF_NS.COLOR_DIFF ...
						ComparisonGroupBrainPF_NS.FDR ...
						ComparisonGroupBrainPF_NS.QVALUE ...
						];
				case Category.GUI
					prop_list = [ ...
						ComparisonGroupBrainPF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel nodal superglobal group comparison on brain surface figure.
			%
			% N = ComparisonGroupBrainPF_NS.GETPROPNUMBER() returns the property number of panel nodal superglobal group comparison on brain surface figure.
			%
			% N = ComparisonGroupBrainPF_NS.GETPROPNUMBER(CATEGORY) returns the property number of panel nodal superglobal group comparison on brain surface figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel nodal superglobal group comparison on brain surface figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('ComparisonGroupBrainPF_NS') returns the property number of 'ComparisonGroupBrainPF_NS'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonGroupBrainPF_NS.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel nodal superglobal group comparison on brain surface figure/error.
			%
			% CHECK = ComparisonGroupBrainPF_NS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(ComparisonGroupBrainPF_NS, PROP) checks whether PROP exists for ComparisonGroupBrainPF_NS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupBrainPF_NS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_NS:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_NS:WrongInput]
			%  Element.EXISTSPROP(ComparisonGroupBrainPF_NS, PROP) throws error if PROP does NOT exist for ComparisonGroupBrainPF_NS.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_NS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonGroupBrainPF_NS.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_NS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_NS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonGroupBrainPF_NS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel nodal superglobal group comparison on brain surface figure/error.
			%
			% CHECK = ComparisonGroupBrainPF_NS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(ComparisonGroupBrainPF_NS, TAG) checks whether TAG exists for ComparisonGroupBrainPF_NS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupBrainPF_NS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_NS:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_NS:WrongInput]
			%  Element.EXISTSTAG(ComparisonGroupBrainPF_NS, TAG) throws error if TAG does NOT exist for ComparisonGroupBrainPF_NS.
			%   Error id: [BRAPH2:ComparisonGroupBrainPF_NS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisongroupbrainpf_ns_tag_list = cellfun(@(x) ComparisonGroupBrainPF_NS.getPropTag(x), num2cell(ComparisonGroupBrainPF_NS.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisongroupbrainpf_ns_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_NS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_NS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonGroupBrainPF_NS.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonGroupBrainPF_NS, POINTER) returns property number of POINTER of ComparisonGroupBrainPF_NS.
			%  PROPERTY = PF.GETPROPPROP(ComparisonGroupBrainPF_NS, POINTER) returns property number of POINTER of ComparisonGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisongroupbrainpf_ns_tag_list = cellfun(@(x) ComparisonGroupBrainPF_NS.getPropTag(x), num2cell(ComparisonGroupBrainPF_NS.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisongroupbrainpf_ns_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ComparisonGroupBrainPF_NS, POINTER) returns tag of POINTER of ComparisonGroupBrainPF_NS.
			%  TAG = PF.GETPROPTAG(ComparisonGroupBrainPF_NS, POINTER) returns tag of POINTER of ComparisonGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonGroupBrainPF_NS.LAYER
						tag = ComparisonGroupBrainPF_NS.LAYER_TAG;
					case ComparisonGroupBrainPF_NS.SIZE_DIFF
						tag = ComparisonGroupBrainPF_NS.SIZE_DIFF_TAG;
					case ComparisonGroupBrainPF_NS.SIZE_SCALE
						tag = ComparisonGroupBrainPF_NS.SIZE_SCALE_TAG;
					case ComparisonGroupBrainPF_NS.COLOR_DIFF
						tag = ComparisonGroupBrainPF_NS.COLOR_DIFF_TAG;
					case ComparisonGroupBrainPF_NS.FDR
						tag = ComparisonGroupBrainPF_NS.FDR_TAG;
					case ComparisonGroupBrainPF_NS.QVALUE
						tag = ComparisonGroupBrainPF_NS.QVALUE_TAG;
					otherwise
						tag = getPropTag@ComparisonGroupBrainPF(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonGroupBrainPF_NS, POINTER) returns category of POINTER of ComparisonGroupBrainPF_NS.
			%  CATEGORY = PF.GETPROPCATEGORY(ComparisonGroupBrainPF_NS, POINTER) returns category of POINTER of ComparisonGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_NS.LAYER
					prop_category = ComparisonGroupBrainPF_NS.LAYER_CATEGORY;
				case ComparisonGroupBrainPF_NS.SIZE_DIFF
					prop_category = ComparisonGroupBrainPF_NS.SIZE_DIFF_CATEGORY;
				case ComparisonGroupBrainPF_NS.SIZE_SCALE
					prop_category = ComparisonGroupBrainPF_NS.SIZE_SCALE_CATEGORY;
				case ComparisonGroupBrainPF_NS.COLOR_DIFF
					prop_category = ComparisonGroupBrainPF_NS.COLOR_DIFF_CATEGORY;
				case ComparisonGroupBrainPF_NS.FDR
					prop_category = ComparisonGroupBrainPF_NS.FDR_CATEGORY;
				case ComparisonGroupBrainPF_NS.QVALUE
					prop_category = ComparisonGroupBrainPF_NS.QVALUE_CATEGORY;
				otherwise
					prop_category = getPropCategory@ComparisonGroupBrainPF(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonGroupBrainPF_NS, POINTER) returns format of POINTER of ComparisonGroupBrainPF_NS.
			%  FORMAT = PF.GETPROPFORMAT(ComparisonGroupBrainPF_NS, POINTER) returns format of POINTER of ComparisonGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_NS.LAYER
					prop_format = ComparisonGroupBrainPF_NS.LAYER_FORMAT;
				case ComparisonGroupBrainPF_NS.SIZE_DIFF
					prop_format = ComparisonGroupBrainPF_NS.SIZE_DIFF_FORMAT;
				case ComparisonGroupBrainPF_NS.SIZE_SCALE
					prop_format = ComparisonGroupBrainPF_NS.SIZE_SCALE_FORMAT;
				case ComparisonGroupBrainPF_NS.COLOR_DIFF
					prop_format = ComparisonGroupBrainPF_NS.COLOR_DIFF_FORMAT;
				case ComparisonGroupBrainPF_NS.FDR
					prop_format = ComparisonGroupBrainPF_NS.FDR_FORMAT;
				case ComparisonGroupBrainPF_NS.QVALUE
					prop_format = ComparisonGroupBrainPF_NS.QVALUE_FORMAT;
				otherwise
					prop_format = getPropFormat@ComparisonGroupBrainPF(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonGroupBrainPF_NS, POINTER) returns description of POINTER of ComparisonGroupBrainPF_NS.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(ComparisonGroupBrainPF_NS, POINTER) returns description of POINTER of ComparisonGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_NS.LAYER
					prop_description = 'LAYER (figure, scalar) is the layer number of the nodal measure.';
				case ComparisonGroupBrainPF_NS.SIZE_DIFF
					prop_description = 'SIZE_DIFF (figure, option) determines whether the difference is shown with size effect.';
				case ComparisonGroupBrainPF_NS.SIZE_SCALE
					prop_description = 'SIZE_SCALE (figure, scalar) determines the scale of size effect.';
				case ComparisonGroupBrainPF_NS.COLOR_DIFF
					prop_description = 'COLOR_DIFF (figure, option) determines whether the difference is shown with color effect.';
				case ComparisonGroupBrainPF_NS.FDR
					prop_description = 'FDR (figure, option) determines whether the difference is shown with FDR correction.';
				case ComparisonGroupBrainPF_NS.QVALUE
					prop_description = 'QVALUE (figure, scalar) determines the QVALUE for FDR correction.';
				case ComparisonGroupBrainPF_NS.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ComparisonGroupBrainPF_NS.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure nodal superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_NS.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure nodal superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_NS.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure nodal superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_NS.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure nodal superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_NS.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure nodal superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_NS.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure nodal superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_NS.DRAW
					prop_description = 'DRAW (query, logical) draws the figure brain atlas.';
				case ComparisonGroupBrainPF_NS.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.';
				case ComparisonGroupBrainPF_NS.SETUP
					prop_description = 'SETUP (query, empty) calculates the group comparison figure value and stores it.';
				otherwise
					prop_description = getPropDescription@ComparisonGroupBrainPF(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonGroupBrainPF_NS, POINTER) returns settings of POINTER of ComparisonGroupBrainPF_NS.
			%  SETTINGS = PF.GETPROPSETTINGS(ComparisonGroupBrainPF_NS, POINTER) returns settings of POINTER of ComparisonGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_NS.LAYER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ComparisonGroupBrainPF_NS.SIZE_DIFF
					prop_settings = {'on' 'off' 'disable'};
				case ComparisonGroupBrainPF_NS.SIZE_SCALE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ComparisonGroupBrainPF_NS.COLOR_DIFF
					prop_settings = {'on' 'off' 'disable'};
				case ComparisonGroupBrainPF_NS.FDR
					prop_settings = {'on' 'off' 'disable'};
				case ComparisonGroupBrainPF_NS.QVALUE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ComparisonGroupBrainPF_NS.TEMPLATE
					prop_settings = 'ComparisonGroupBrainPF_NS';
				otherwise
					prop_settings = getPropSettings@ComparisonGroupBrainPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonGroupBrainPF_NS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupBrainPF_NS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonGroupBrainPF_NS, POINTER) returns the default value of POINTER of ComparisonGroupBrainPF_NS.
			%  DEFAULT = PF.GETPROPDEFAULT(ComparisonGroupBrainPF_NS, POINTER) returns the default value of POINTER of ComparisonGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_NS.LAYER
					prop_default = 1;
				case ComparisonGroupBrainPF_NS.SIZE_DIFF
					prop_default = 'on';
				case ComparisonGroupBrainPF_NS.SIZE_SCALE
					prop_default = 5;
				case ComparisonGroupBrainPF_NS.COLOR_DIFF
					prop_default = 'on';
				case ComparisonGroupBrainPF_NS.FDR
					prop_default = 'off';
				case ComparisonGroupBrainPF_NS.QVALUE
					prop_default = 0.05;
				case ComparisonGroupBrainPF_NS.ELCLASS
					prop_default = 'ComparisonGroupBrainPF_NS';
				case ComparisonGroupBrainPF_NS.NAME
					prop_default = 'ComparisonGroupBrainPF_NS';
				case ComparisonGroupBrainPF_NS.DESCRIPTION
					prop_default = 'ComparisonGroupBrainPF_NS manages the basic functionalities to plot of a nodal superglobal group comparison on brain surface figure.';
				case ComparisonGroupBrainPF_NS.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroupBrainPF_NS.getPropSettings(prop));
				case ComparisonGroupBrainPF_NS.ID
					prop_default = 'ComparisonGroupBrainPF_NS ID';
				case ComparisonGroupBrainPF_NS.LABEL
					prop_default = 'ComparisonGroupBrainPF_NS label';
				case ComparisonGroupBrainPF_NS.NOTES
					prop_default = 'ComparisonGroupBrainPF_NS notes';
				otherwise
					prop_default = getPropDefault@ComparisonGroupBrainPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonGroupBrainPF_NS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupBrainPF_NS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonGroupBrainPF_NS, POINTER) returns the conditioned default value of POINTER of ComparisonGroupBrainPF_NS.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(ComparisonGroupBrainPF_NS, POINTER) returns the conditioned default value of POINTER of ComparisonGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonGroupBrainPF_NS.getPropProp(pointer);
			
			prop_default = ComparisonGroupBrainPF_NS.conditioning(prop, ComparisonGroupBrainPF_NS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonGroupBrainPF_NS, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupBrainPF_NS.
			%  CHECK = PF.CHECKPROP(ComparisonGroupBrainPF_NS, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupBrainPF_NS.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonGroupBrainPF_NS:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:ComparisonGroupBrainPF_NS:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonGroupBrainPF_NS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupBrainPF_NS.
			%   Error id: €BRAPH2.STR€:ComparisonGroupBrainPF_NS:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(ComparisonGroupBrainPF_NS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupBrainPF_NS.
			%   Error id: €BRAPH2.STR€:ComparisonGroupBrainPF_NS:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('ComparisonGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupBrainPF_NS.LAYER % __ComparisonGroupBrainPF_NS.LAYER__
					check = Format.checkFormat(Format.SCALAR, value, ComparisonGroupBrainPF_NS.getPropSettings(prop));
				case ComparisonGroupBrainPF_NS.SIZE_DIFF % __ComparisonGroupBrainPF_NS.SIZE_DIFF__
					check = Format.checkFormat(Format.OPTION, value, ComparisonGroupBrainPF_NS.getPropSettings(prop));
				case ComparisonGroupBrainPF_NS.SIZE_SCALE % __ComparisonGroupBrainPF_NS.SIZE_SCALE__
					check = Format.checkFormat(Format.SCALAR, value, ComparisonGroupBrainPF_NS.getPropSettings(prop));
				case ComparisonGroupBrainPF_NS.COLOR_DIFF % __ComparisonGroupBrainPF_NS.COLOR_DIFF__
					check = Format.checkFormat(Format.OPTION, value, ComparisonGroupBrainPF_NS.getPropSettings(prop));
				case ComparisonGroupBrainPF_NS.FDR % __ComparisonGroupBrainPF_NS.FDR__
					check = Format.checkFormat(Format.OPTION, value, ComparisonGroupBrainPF_NS.getPropSettings(prop));
				case ComparisonGroupBrainPF_NS.QVALUE % __ComparisonGroupBrainPF_NS.QVALUE__
					check = Format.checkFormat(Format.SCALAR, value, ComparisonGroupBrainPF_NS.getPropSettings(prop));
				case ComparisonGroupBrainPF_NS.TEMPLATE % __ComparisonGroupBrainPF_NS.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupBrainPF_NS.getPropSettings(prop));
				otherwise
					if prop <= ComparisonGroupBrainPF.getPropNumber()
						check = checkProp@ComparisonGroupBrainPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_NS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupBrainPF_NS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonGroupBrainPF_NS.getPropTag(prop) ' (' ComparisonGroupBrainPF_NS.getFormatTag(ComparisonGroupBrainPF_NS.getPropFormat(prop)) ').'] ...
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
				case ComparisonGroupBrainPF_NS.LAYER % __ComparisonGroupBrainPF_NS.LAYER__
					pf.get('SETUP');
					
				case ComparisonGroupBrainPF_NS.SIZE_DIFF % __ComparisonGroupBrainPF_NS.SIZE_DIFF__
					pf.get('SETUP');
					
				case ComparisonGroupBrainPF_NS.SIZE_SCALE % __ComparisonGroupBrainPF_NS.SIZE_SCALE__
					pf.get('SETUP');
					
				case ComparisonGroupBrainPF_NS.COLOR_DIFF % __ComparisonGroupBrainPF_NS.COLOR_DIFF__
					pf.get('SETUP');
					
				case ComparisonGroupBrainPF_NS.FDR % __ComparisonGroupBrainPF_NS.FDR__
					pf.get('SETUP');
					
				case ComparisonGroupBrainPF_NS.QVALUE % __ComparisonGroupBrainPF_NS.QVALUE__
					pf.get('CP').set('QVALUE', pf.get('QVALUE'));
					pf.get('SETUP');
					
				otherwise
					if prop <= ComparisonGroupBrainPF.getPropNumber()
						postset@ComparisonGroupBrainPF(pf, prop);
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
				case ComparisonGroupBrainPF_NS.QVALUE % __ComparisonGroupBrainPF_NS.QVALUE__
					if isempty(pf.get('QVALUE'))
					    pf.set('QVALUE', pf.get('CP').get('QVALUE'));
					end
					
				otherwise
					if prop <= ComparisonGroupBrainPF.getPropNumber()
						postprocessing@ComparisonGroupBrainPF(pf, prop);
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
				case ComparisonGroupBrainPF_NS.DRAW % __ComparisonGroupBrainPF_NS.DRAW__
					value = calculateValue@ComparisonGroupBrainPF(pf, ComparisonGroupBrainPF.DRAW, varargin{:}); % also warning
					if value
					    % reset the ambient lighting
					    pf.get('ST_AMBIENT').get('SETUP')
					
					    % call setup
					    pf.get('SETUP');
					end
					
				case ComparisonGroupBrainPF_NS.DELETE % __ComparisonGroupBrainPF_NS.DELETE__
					value = calculateValue@ComparisonGroupBrainPF(pf, ComparisonGroupBrainPF.DELETE, varargin{:}); % also warning
					if value
					
					end
					
				case ComparisonGroupBrainPF_NS.SETUP % __ComparisonGroupBrainPF_NS.SETUP__
					cp = pf.get('CP');
					g = cp.get('C').get('A1').get('G');
					
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
					        diff(isinf(diff)) = 0.1;
					        size_value = abs(diff);
					        min_bound = 0.01;
					        max_bound = 1.0;
					        min_size_value = min(size_value);
					        max_size_value = max(size_value);
					        if isequal(max_size_value, min_size_value)
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
					
					value = [];
					
				otherwise
					if prop <= ComparisonGroupBrainPF.getPropNumber()
						value = calculateValue@ComparisonGroupBrainPF(pf, prop, varargin{:});
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
				case ComparisonGroupBrainPF_NS.LAYER % __ComparisonGroupBrainPF_NS.LAYER__
					pr = ComparisonGroupBrainPF_xSPP_Layer('EL', pf, 'PROP', ComparisonGroupBrainPF_NS.LAYER);
					
				otherwise
					pr = getPanelProp@ComparisonGroupBrainPF(pf, prop, varargin{:});
					
			end
		end
	end
end
