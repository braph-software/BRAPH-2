classdef MeasureGroupBrainPF_NS < MeasureGroupBrainPF
	%MeasureGroupBrainPF_NS is a plot of a nodal superglobal measure group brain.
	% It is a subclass of <a href="matlab:help MeasureGroupBrainPF">MeasureGroupBrainPF</a>.
	%
	% A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_NS) manages the plot of the nodal superglobal measure
	%  ploted over the brain.  
	% MeasureGroupBrainPF_NS utilizes the surface created from BrainAtlasPF to integrate 
	%  the nodal superglobal meaure into the brain regions.
	%
	% MeasureGroupBrainPF_NS methods (constructor):
	%  MeasureGroupBrainPF_NS - constructor
	%
	% MeasureGroupBrainPF_NS methods:
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
	% MeasureGroupBrainPF_NS methods (display):
	%  tostring - string with information about the panel figure for nodal superglobal measure group brain
	%  disp - displays information about the panel figure for nodal superglobal measure group brain
	%  tree - displays the tree of the panel figure for nodal superglobal measure group brain
	%
	% MeasureGroupBrainPF_NS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for nodal superglobal measure group brain are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for nodal superglobal measure group brain
	%
	% MeasureGroupBrainPF_NS methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for nodal superglobal measure group brain as b2 file
	%  load - loads a BRAPH2 panel figure for nodal superglobal measure group brain from a b2 file
	%
	% MeasureGroupBrainPF_NS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for nodal superglobal measure group brain
	%
	% MeasureGroupBrainPF_NS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for nodal superglobal measure group brain
	%
	% MeasureGroupBrainPF_NS methods (inspection, Static):
	%  getClass - returns the class of the panel figure for nodal superglobal measure group brain
	%  getSubclasses - returns all subclasses of MeasureGroupBrainPF_NS
	%  getProps - returns the property list of the panel figure for nodal superglobal measure group brain
	%  getPropNumber - returns the property number of the panel figure for nodal superglobal measure group brain
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
	% MeasureGroupBrainPF_NS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureGroupBrainPF_NS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureGroupBrainPF_NS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureGroupBrainPF_NS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureGroupBrainPF_NS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureGroupBrainPF_NS constants</a>.
	%
	%
	% See also BrainAtlas, BrainSurface, BrainAtlasPF.
	
	properties (Constant) % properties
		LAYER = MeasureGroupBrainPF.getPropNumber() + 1;
		LAYER_TAG = 'LAYER';
		LAYER_CATEGORY = Category.FIGURE;
		LAYER_FORMAT = Format.SCALAR;
		
		SIZE_DIFF = MeasureGroupBrainPF.getPropNumber() + 2;
		SIZE_DIFF_TAG = 'SIZE_DIFF';
		SIZE_DIFF_CATEGORY = Category.FIGURE;
		SIZE_DIFF_FORMAT = Format.OPTION;
		
		SIZE_SCALE = MeasureGroupBrainPF.getPropNumber() + 3;
		SIZE_SCALE_TAG = 'SIZE_SCALE';
		SIZE_SCALE_CATEGORY = Category.FIGURE;
		SIZE_SCALE_FORMAT = Format.SCALAR;
		
		COLOR_DIFF = MeasureGroupBrainPF.getPropNumber() + 4;
		COLOR_DIFF_TAG = 'COLOR_DIFF';
		COLOR_DIFF_CATEGORY = Category.FIGURE;
		COLOR_DIFF_FORMAT = Format.OPTION;
	end
	methods % constructor
		function pf = MeasureGroupBrainPF_NS(varargin)
			%MeasureGroupBrainPF_NS() creates a panel figure for nodal superglobal measure group brain.
			%
			% MeasureGroupBrainPF_NS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureGroupBrainPF_NS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@MeasureGroupBrainPF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for nodal superglobal measure group brain.
			%
			% CLASS = MeasureGroupBrainPF_NS.GETCLASS() returns the class 'MeasureGroupBrainPF_NS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for nodal superglobal measure group brain PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasureGroupBrainPF_NS') returns 'MeasureGroupBrainPF_NS'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			
			pf_class = 'MeasureGroupBrainPF_NS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for nodal superglobal measure group brain.
			%
			% LIST = MeasureGroupBrainPF_NS.GETSUBCLASSES() returns all subclasses of 'MeasureGroupBrainPF_NS'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for nodal superglobal measure group brain PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasureGroupBrainPF_NS') returns all subclasses of 'MeasureGroupBrainPF_NS'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasureGroupBrainPF_NS', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for nodal superglobal measure group brain.
			%
			% PROPS = MeasureGroupBrainPF_NS.GETPROPS() returns the property list of panel figure for nodal superglobal measure group brain
			%  as a row vector.
			%
			% PROPS = MeasureGroupBrainPF_NS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for nodal superglobal measure group brain PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasureGroupBrainPF_NS'[, CATEGORY]) returns the property list of 'MeasureGroupBrainPF_NS'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MeasureGroupBrainPF.getProps() ...
						MeasureGroupBrainPF_NS.LAYER ...
						MeasureGroupBrainPF_NS.SIZE_DIFF ...
						MeasureGroupBrainPF_NS.SIZE_SCALE ...
						MeasureGroupBrainPF_NS.COLOR_DIFF ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MeasureGroupBrainPF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.FIGURE) ...
						MeasureGroupBrainPF_NS.LAYER ...
						MeasureGroupBrainPF_NS.SIZE_DIFF ...
						MeasureGroupBrainPF_NS.SIZE_SCALE ...
						MeasureGroupBrainPF_NS.COLOR_DIFF ...
						];
				case Category.GUI
					prop_list = [ ...
						MeasureGroupBrainPF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for nodal superglobal measure group brain.
			%
			% N = MeasureGroupBrainPF_NS.GETPROPNUMBER() returns the property number of panel figure for nodal superglobal measure group brain.
			%
			% N = MeasureGroupBrainPF_NS.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for nodal superglobal measure group brain
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for nodal superglobal measure group brain PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasureGroupBrainPF_NS') returns the property number of 'MeasureGroupBrainPF_NS'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasureGroupBrainPF_NS.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for nodal superglobal measure group brain/error.
			%
			% CHECK = MeasureGroupBrainPF_NS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasureGroupBrainPF_NS, PROP) checks whether PROP exists for MeasureGroupBrainPF_NS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureGroupBrainPF_NS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_NS:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_NS:WrongInput]
			%  Element.EXISTSPROP(MeasureGroupBrainPF_NS, PROP) throws error if PROP does NOT exist for MeasureGroupBrainPF_NS.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_NS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasureGroupBrainPF_NS.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF_NS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF_NS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureGroupBrainPF_NS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for nodal superglobal measure group brain/error.
			%
			% CHECK = MeasureGroupBrainPF_NS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasureGroupBrainPF_NS, TAG) checks whether TAG exists for MeasureGroupBrainPF_NS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureGroupBrainPF_NS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_NS:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_NS:WrongInput]
			%  Element.EXISTSTAG(MeasureGroupBrainPF_NS, TAG) throws error if TAG does NOT exist for MeasureGroupBrainPF_NS.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_NS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measuregroupbrainpf_ns_tag_list = cellfun(@(x) MeasureGroupBrainPF_NS.getPropTag(x), num2cell(MeasureGroupBrainPF_NS.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measuregroupbrainpf_ns_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF_NS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF_NS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasureGroupBrainPF_NS.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureGroupBrainPF_NS, POINTER) returns property number of POINTER of MeasureGroupBrainPF_NS.
			%  PROPERTY = PF.GETPROPPROP(MeasureGroupBrainPF_NS, POINTER) returns property number of POINTER of MeasureGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measuregroupbrainpf_ns_tag_list = cellfun(@(x) MeasureGroupBrainPF_NS.getPropTag(x), num2cell(MeasureGroupBrainPF_NS.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measuregroupbrainpf_ns_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasureGroupBrainPF_NS, POINTER) returns tag of POINTER of MeasureGroupBrainPF_NS.
			%  TAG = PF.GETPROPTAG(MeasureGroupBrainPF_NS, POINTER) returns tag of POINTER of MeasureGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MeasureGroupBrainPF_NS.LAYER
						tag = MeasureGroupBrainPF_NS.LAYER_TAG;
					case MeasureGroupBrainPF_NS.SIZE_DIFF
						tag = MeasureGroupBrainPF_NS.SIZE_DIFF_TAG;
					case MeasureGroupBrainPF_NS.SIZE_SCALE
						tag = MeasureGroupBrainPF_NS.SIZE_SCALE_TAG;
					case MeasureGroupBrainPF_NS.COLOR_DIFF
						tag = MeasureGroupBrainPF_NS.COLOR_DIFF_TAG;
					otherwise
						tag = getPropTag@MeasureGroupBrainPF(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureGroupBrainPF_NS, POINTER) returns category of POINTER of MeasureGroupBrainPF_NS.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasureGroupBrainPF_NS, POINTER) returns category of POINTER of MeasureGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_NS.LAYER
					prop_category = MeasureGroupBrainPF_NS.LAYER_CATEGORY;
				case MeasureGroupBrainPF_NS.SIZE_DIFF
					prop_category = MeasureGroupBrainPF_NS.SIZE_DIFF_CATEGORY;
				case MeasureGroupBrainPF_NS.SIZE_SCALE
					prop_category = MeasureGroupBrainPF_NS.SIZE_SCALE_CATEGORY;
				case MeasureGroupBrainPF_NS.COLOR_DIFF
					prop_category = MeasureGroupBrainPF_NS.COLOR_DIFF_CATEGORY;
				otherwise
					prop_category = getPropCategory@MeasureGroupBrainPF(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureGroupBrainPF_NS, POINTER) returns format of POINTER of MeasureGroupBrainPF_NS.
			%  FORMAT = PF.GETPROPFORMAT(MeasureGroupBrainPF_NS, POINTER) returns format of POINTER of MeasureGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_NS.LAYER
					prop_format = MeasureGroupBrainPF_NS.LAYER_FORMAT;
				case MeasureGroupBrainPF_NS.SIZE_DIFF
					prop_format = MeasureGroupBrainPF_NS.SIZE_DIFF_FORMAT;
				case MeasureGroupBrainPF_NS.SIZE_SCALE
					prop_format = MeasureGroupBrainPF_NS.SIZE_SCALE_FORMAT;
				case MeasureGroupBrainPF_NS.COLOR_DIFF
					prop_format = MeasureGroupBrainPF_NS.COLOR_DIFF_FORMAT;
				otherwise
					prop_format = getPropFormat@MeasureGroupBrainPF(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureGroupBrainPF_NS, POINTER) returns description of POINTER of MeasureGroupBrainPF_NS.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasureGroupBrainPF_NS, POINTER) returns description of POINTER of MeasureGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_NS.LAYER
					prop_description = 'LAYER (figure, scalar) is the layer number of the nodal measure.';
				case MeasureGroupBrainPF_NS.SIZE_DIFF
					prop_description = 'SIZE_DIFF (figure, option) determines whether the difference is shown with size effect.';
				case MeasureGroupBrainPF_NS.SIZE_SCALE
					prop_description = 'SIZE_SCALE (figure, scalar) determines the scale of size effect.';
				case MeasureGroupBrainPF_NS.COLOR_DIFF
					prop_description = 'COLOR_DIFF (figure, option) determines whether the difference is shown with color effect.';
				case MeasureGroupBrainPF_NS.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % %.';
				case MeasureGroupBrainPF_NS.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for measure group brain.';
				case MeasureGroupBrainPF_NS.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.';
				case MeasureGroupBrainPF_NS.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.';
				case MeasureGroupBrainPF_NS.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for measure group brain.';
				case MeasureGroupBrainPF_NS.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for measure group brain.';
				case MeasureGroupBrainPF_NS.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.';
				case MeasureGroupBrainPF_NS.SETUP
					prop_description = 'SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.';
				otherwise
					prop_description = getPropDescription@MeasureGroupBrainPF(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureGroupBrainPF_NS, POINTER) returns settings of POINTER of MeasureGroupBrainPF_NS.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasureGroupBrainPF_NS, POINTER) returns settings of POINTER of MeasureGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_NS.LAYER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MeasureGroupBrainPF_NS.SIZE_DIFF
					prop_settings = {'on' 'off' 'disable'};
				case MeasureGroupBrainPF_NS.SIZE_SCALE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MeasureGroupBrainPF_NS.COLOR_DIFF
					prop_settings = {'on' 'off' 'disable'};
				case MeasureGroupBrainPF_NS.TEMPLATE
					prop_settings = 'MeasureGroupBrainPF_NS';
				otherwise
					prop_settings = getPropSettings@MeasureGroupBrainPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureGroupBrainPF_NS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureGroupBrainPF_NS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureGroupBrainPF_NS, POINTER) returns the default value of POINTER of MeasureGroupBrainPF_NS.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasureGroupBrainPF_NS, POINTER) returns the default value of POINTER of MeasureGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_NS.LAYER
					prop_default = 1;
				case MeasureGroupBrainPF_NS.SIZE_DIFF
					prop_default = 'on';
				case MeasureGroupBrainPF_NS.SIZE_SCALE
					prop_default = 10;
				case MeasureGroupBrainPF_NS.COLOR_DIFF
					prop_default = 'on';
				case MeasureGroupBrainPF_NS.ELCLASS
					prop_default = 'MeasureGroupBrainPF_NS';
				case MeasureGroupBrainPF_NS.NAME
					prop_default = 'Panel Figure for Measure Group Brain';
				case MeasureGroupBrainPF_NS.DESCRIPTION
					prop_default = 'A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_NS ) manages the plot of the nodal superglobal measure ploted over the brain. MeasureGroupBrainPF_NS  utilizes the surface created from BrainAtlasPF to integrate the nodal superglobal meaure into the brain regions.';
				case MeasureGroupBrainPF_NS.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureGroupBrainPF_NS.getPropSettings(prop));
				case MeasureGroupBrainPF_NS.ID
					prop_default = 'MeasureGroupBrainPF_NS ID';
				case MeasureGroupBrainPF_NS.LABEL
					prop_default = 'MeasureGroupBrainPF_NS label';
				case MeasureGroupBrainPF_NS.NOTES
					prop_default = 'MeasureGroupBrainPF_NS notes';
				otherwise
					prop_default = getPropDefault@MeasureGroupBrainPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureGroupBrainPF_NS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureGroupBrainPF_NS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureGroupBrainPF_NS, POINTER) returns the conditioned default value of POINTER of MeasureGroupBrainPF_NS.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasureGroupBrainPF_NS, POINTER) returns the conditioned default value of POINTER of MeasureGroupBrainPF_NS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureGroupBrainPF_NS.getPropProp(pointer);
			
			prop_default = MeasureGroupBrainPF_NS.conditioning(prop, MeasureGroupBrainPF_NS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureGroupBrainPF_NS, PROP, VALUE) checks VALUE format for PROP of MeasureGroupBrainPF_NS.
			%  CHECK = PF.CHECKPROP(MeasureGroupBrainPF_NS, PROP, VALUE) checks VALUE format for PROP of MeasureGroupBrainPF_NS.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasureGroupBrainPF_NS:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF_NS:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasureGroupBrainPF_NS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureGroupBrainPF_NS.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF_NS:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasureGroupBrainPF_NS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureGroupBrainPF_NS.
			%   Error id: €BRAPH2.STR€:MeasureGroupBrainPF_NS:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasureGroupBrainPF_NS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureGroupBrainPF_NS.getPropProp(pointer);
			
			switch prop
				case MeasureGroupBrainPF_NS.LAYER % __MeasureGroupBrainPF_NS.LAYER__
					check = Format.checkFormat(Format.SCALAR, value, MeasureGroupBrainPF_NS.getPropSettings(prop));
				case MeasureGroupBrainPF_NS.SIZE_DIFF % __MeasureGroupBrainPF_NS.SIZE_DIFF__
					check = Format.checkFormat(Format.OPTION, value, MeasureGroupBrainPF_NS.getPropSettings(prop));
				case MeasureGroupBrainPF_NS.SIZE_SCALE % __MeasureGroupBrainPF_NS.SIZE_SCALE__
					check = Format.checkFormat(Format.SCALAR, value, MeasureGroupBrainPF_NS.getPropSettings(prop));
				case MeasureGroupBrainPF_NS.COLOR_DIFF % __MeasureGroupBrainPF_NS.COLOR_DIFF__
					check = Format.checkFormat(Format.OPTION, value, MeasureGroupBrainPF_NS.getPropSettings(prop));
				case MeasureGroupBrainPF_NS.TEMPLATE % __MeasureGroupBrainPF_NS.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasureGroupBrainPF_NS.getPropSettings(prop));
				otherwise
					if prop <= MeasureGroupBrainPF.getPropNumber()
						check = checkProp@MeasureGroupBrainPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureGroupBrainPF_NS:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureGroupBrainPF_NS:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureGroupBrainPF_NS.getPropTag(prop) ' (' MeasureGroupBrainPF_NS.getFormatTag(MeasureGroupBrainPF_NS.getPropFormat(prop)) ').'] ...
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
				case MeasureGroupBrainPF_NS.LAYER % __MeasureGroupBrainPF_NS.LAYER__
					pf.get('SETUP');
					
				case MeasureGroupBrainPF_NS.SIZE_DIFF % __MeasureGroupBrainPF_NS.SIZE_DIFF__
					pf.get('SETUP');
					
				case MeasureGroupBrainPF_NS.SIZE_SCALE % __MeasureGroupBrainPF_NS.SIZE_SCALE__
					pf.get('SETUP');
					
				case MeasureGroupBrainPF_NS.COLOR_DIFF % __MeasureGroupBrainPF_NS.COLOR_DIFF__
					pf.get('SETUP');
					
				otherwise
					if prop <= MeasureGroupBrainPF.getPropNumber()
						postset@MeasureGroupBrainPF(pf, prop);
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
				case MeasureGroupBrainPF_NS.SETUP % __MeasureGroupBrainPF_NS.SETUP__
					m = pf.get('M');
					g =  m.get('G');
					
					% get brain region related list
					sph_list = pf.get('SPH_DICT').get('IT_LIST');
					sym_list = pf.get('SYM_DICT').get('IT_LIST');
					id_list = pf.get('ID_DICT').get('IT_LIST');
					lab_list = pf.get('LAB_DICT').get('IT_LIST');
					
					% get the value to show on the surface
					layer = pf.get('LAYER');
					m_values = m.get('M');
					if isempty(m_values)
					    value = {};
					    return
					end
					m_value = m_values{layer};
					
					size_diff = pf.get('SIZE_DIFF');
					switch size_diff
					    case 'on'
					        % transfrom m value to appropriate size
					        % value ranching from 0.01 to 1
					        m_value(isnan(m_value)) = 0.1;
					        size_value = abs(m_value);
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
					        % transfrom m value to appropriate color
					        % RGB code ranching from 0 to 1
					        m_value(isnan(m_value)) = 0;
					        size_value = abs(m_value);
					        min_bound = 0.0;
					        max_bound = 1.0;
					        min_size_value = min(size_value);
					        max_size_value = max(size_value);
					        if max_size_value == min_size_value
					            normalized_size_value = ones(size(size_value)) * max_bound;
					        else
					            normalized_size_value = min_bound + (max_bound - min_bound) * (size_value - min_size_value) / (max_size_value - min_size_value);
					        end
					
					        % Map the normalized values to colors in the Jet colormap
					        cmap = jet(256);
					        color_indices = ceil(normalized_size_value * (size(cmap, 1) - 1)) + 1;
					
					        % Clip color_indices to valid range
					        color_indices = max(1, min(color_indices, size(cmap, 1)));
					
					        % Get the RGB colors for the indices
					        rgb_colors = cmap(color_indices, :);
					
					        % set color to sphs
					        for i = 1:1:length(sph_list)
					            set(sph_list{i}, 'FACECOLOR', rgb_colors(i, :));
					        end
					        
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
					if prop <= MeasureGroupBrainPF.getPropNumber()
						value = calculateValue@MeasureGroupBrainPF(pf, prop, varargin{:});
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
				case MeasureGroupBrainPF_NS.LAYER % __MeasureGroupBrainPF_NS.LAYER__
					pr = MeasureGroupBrainPF_xSPP_Layer('EL', pf, 'PROP', MeasureGroupBrainPF_NS.LAYER);
					
				otherwise
					pr = getPanelProp@MeasureGroupBrainPF(pf, prop, varargin{:});
					
			end
		end
	end
end
