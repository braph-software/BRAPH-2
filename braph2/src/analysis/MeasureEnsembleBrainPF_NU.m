classdef MeasureEnsembleBrainPF_NU < MeasureEnsembleBrainPF
	%MeasureEnsembleBrainPF_NU is a plot of a nodal unilayer measure group brain.
	% It is a subclass of <a href="matlab:help MeasureEnsembleBrainPF">MeasureEnsembleBrainPF</a>.
	%
	% A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF_NU ) manages the plot of the nodal unilayer measure
	%  ploted over the brain.  
	% MeasureEnsembleBrainPF_NU utilizes the surface created from BrainAtlasPF to integrate 
	%  the nodal unilayer meaure into the brain regions.
	%
	% MeasureEnsembleBrainPF_NU methods (constructor):
	%  MeasureEnsembleBrainPF_NU - constructor
	%
	% MeasureEnsembleBrainPF_NU methods:
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
	% MeasureEnsembleBrainPF_NU methods (display):
	%  tostring - string with information about the panel figure for nodal unilayer measure group brain
	%  disp - displays information about the panel figure for nodal unilayer measure group brain
	%  tree - displays the tree of the panel figure for nodal unilayer measure group brain
	%
	% MeasureEnsembleBrainPF_NU methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for nodal unilayer measure group brain are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for nodal unilayer measure group brain
	%
	% MeasureEnsembleBrainPF_NU methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for nodal unilayer measure group brain as b2 file
	%  load - loads a BRAPH2 panel figure for nodal unilayer measure group brain from a b2 file
	%
	% MeasureEnsembleBrainPF_NU method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for nodal unilayer measure group brain
	%
	% MeasureEnsembleBrainPF_NU method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for nodal unilayer measure group brain
	%
	% MeasureEnsembleBrainPF_NU methods (inspection, Static):
	%  getClass - returns the class of the panel figure for nodal unilayer measure group brain
	%  getSubclasses - returns all subclasses of MeasureEnsembleBrainPF_NU
	%  getProps - returns the property list of the panel figure for nodal unilayer measure group brain
	%  getPropNumber - returns the property number of the panel figure for nodal unilayer measure group brain
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
	% MeasureEnsembleBrainPF_NU methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureEnsembleBrainPF_NU methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureEnsembleBrainPF_NU methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureEnsembleBrainPF_NU methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureEnsembleBrainPF_NU; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureEnsembleBrainPF_NU constants</a>.
	%
	%
	% See also BrainAtlas, BrainSurface, BrainAtlasPF.
	
	properties (Constant) % properties
		LAYER = MeasureEnsembleBrainPF.getPropNumber() + 1;
		LAYER_TAG = 'LAYER';
		LAYER_CATEGORY = Category.FIGURE;
		LAYER_FORMAT = Format.SCALAR;
		
		SIZE_DIFF = MeasureEnsembleBrainPF.getPropNumber() + 2;
		SIZE_DIFF_TAG = 'SIZE_DIFF';
		SIZE_DIFF_CATEGORY = Category.FIGURE;
		SIZE_DIFF_FORMAT = Format.OPTION;
		
		SIZE_SCALE = MeasureEnsembleBrainPF.getPropNumber() + 3;
		SIZE_SCALE_TAG = 'SIZE_SCALE';
		SIZE_SCALE_CATEGORY = Category.FIGURE;
		SIZE_SCALE_FORMAT = Format.SCALAR;
		
		COLOR_DIFF = MeasureEnsembleBrainPF.getPropNumber() + 4;
		COLOR_DIFF_TAG = 'COLOR_DIFF';
		COLOR_DIFF_CATEGORY = Category.FIGURE;
		COLOR_DIFF_FORMAT = Format.OPTION;
	end
	methods % constructor
		function pf = MeasureEnsembleBrainPF_NU(varargin)
			%MeasureEnsembleBrainPF_NU() creates a panel figure for nodal unilayer measure group brain.
			%
			% MeasureEnsembleBrainPF_NU(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureEnsembleBrainPF_NU(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@MeasureEnsembleBrainPF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for nodal unilayer measure group brain.
			%
			% CLASS = MeasureEnsembleBrainPF_NU.GETCLASS() returns the class 'MeasureEnsembleBrainPF_NU'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for nodal unilayer measure group brain PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasureEnsembleBrainPF_NU') returns 'MeasureEnsembleBrainPF_NU'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			
			pf_class = 'MeasureEnsembleBrainPF_NU';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for nodal unilayer measure group brain.
			%
			% LIST = MeasureEnsembleBrainPF_NU.GETSUBCLASSES() returns all subclasses of 'MeasureEnsembleBrainPF_NU'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for nodal unilayer measure group brain PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasureEnsembleBrainPF_NU') returns all subclasses of 'MeasureEnsembleBrainPF_NU'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasureEnsembleBrainPF_NU', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for nodal unilayer measure group brain.
			%
			% PROPS = MeasureEnsembleBrainPF_NU.GETPROPS() returns the property list of panel figure for nodal unilayer measure group brain
			%  as a row vector.
			%
			% PROPS = MeasureEnsembleBrainPF_NU.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for nodal unilayer measure group brain PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasureEnsembleBrainPF_NU'[, CATEGORY]) returns the property list of 'MeasureEnsembleBrainPF_NU'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MeasureEnsembleBrainPF.getProps() ...
						MeasureEnsembleBrainPF_NU.LAYER ...
						MeasureEnsembleBrainPF_NU.SIZE_DIFF ...
						MeasureEnsembleBrainPF_NU.SIZE_SCALE ...
						MeasureEnsembleBrainPF_NU.COLOR_DIFF ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						MeasureEnsembleBrainPF.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						MeasureEnsembleBrainPF.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						MeasureEnsembleBrainPF.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						MeasureEnsembleBrainPF.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						MeasureEnsembleBrainPF.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						MeasureEnsembleBrainPF.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						MeasureEnsembleBrainPF.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						MeasureEnsembleBrainPF.getProps(Category.FIGURE) ...
						MeasureEnsembleBrainPF_NU.LAYER ...
						MeasureEnsembleBrainPF_NU.SIZE_DIFF ...
						MeasureEnsembleBrainPF_NU.SIZE_SCALE ...
						MeasureEnsembleBrainPF_NU.COLOR_DIFF ...
						];
				case Category.GUI
					prop_list = [ ...
						MeasureEnsembleBrainPF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for nodal unilayer measure group brain.
			%
			% N = MeasureEnsembleBrainPF_NU.GETPROPNUMBER() returns the property number of panel figure for nodal unilayer measure group brain.
			%
			% N = MeasureEnsembleBrainPF_NU.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for nodal unilayer measure group brain
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for nodal unilayer measure group brain PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasureEnsembleBrainPF_NU') returns the property number of 'MeasureEnsembleBrainPF_NU'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasureEnsembleBrainPF_NU.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for nodal unilayer measure group brain/error.
			%
			% CHECK = MeasureEnsembleBrainPF_NU.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasureEnsembleBrainPF_NU, PROP) checks whether PROP exists for MeasureEnsembleBrainPF_NU.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsembleBrainPF_NU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NU:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NU:WrongInput]
			%  Element.EXISTSPROP(MeasureEnsembleBrainPF_NU, PROP) throws error if PROP does NOT exist for MeasureEnsembleBrainPF_NU.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NU:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasureEnsembleBrainPF_NU.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureEnsembleBrainPF_NU.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for nodal unilayer measure group brain/error.
			%
			% CHECK = MeasureEnsembleBrainPF_NU.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasureEnsembleBrainPF_NU, TAG) checks whether TAG exists for MeasureEnsembleBrainPF_NU.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsembleBrainPF_NU:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NU:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NU:WrongInput]
			%  Element.EXISTSTAG(MeasureEnsembleBrainPF_NU, TAG) throws error if TAG does NOT exist for MeasureEnsembleBrainPF_NU.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NU:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measureensemblebrainpf_nu_tag_list = cellfun(@(x) MeasureEnsembleBrainPF_NU.getPropTag(x), num2cell(MeasureEnsembleBrainPF_NU.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measureensemblebrainpf_nu_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasureEnsembleBrainPF_NU.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureEnsembleBrainPF_NU, POINTER) returns property number of POINTER of MeasureEnsembleBrainPF_NU.
			%  PROPERTY = PF.GETPROPPROP(MeasureEnsembleBrainPF_NU, POINTER) returns property number of POINTER of MeasureEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measureensemblebrainpf_nu_tag_list = cellfun(@(x) MeasureEnsembleBrainPF_NU.getPropTag(x), num2cell(MeasureEnsembleBrainPF_NU.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measureensemblebrainpf_nu_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasureEnsembleBrainPF_NU, POINTER) returns tag of POINTER of MeasureEnsembleBrainPF_NU.
			%  TAG = PF.GETPROPTAG(MeasureEnsembleBrainPF_NU, POINTER) returns tag of POINTER of MeasureEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MeasureEnsembleBrainPF_NU.LAYER
						tag = MeasureEnsembleBrainPF_NU.LAYER_TAG;
					case MeasureEnsembleBrainPF_NU.SIZE_DIFF
						tag = MeasureEnsembleBrainPF_NU.SIZE_DIFF_TAG;
					case MeasureEnsembleBrainPF_NU.SIZE_SCALE
						tag = MeasureEnsembleBrainPF_NU.SIZE_SCALE_TAG;
					case MeasureEnsembleBrainPF_NU.COLOR_DIFF
						tag = MeasureEnsembleBrainPF_NU.COLOR_DIFF_TAG;
					otherwise
						tag = getPropTag@MeasureEnsembleBrainPF(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureEnsembleBrainPF_NU, POINTER) returns category of POINTER of MeasureEnsembleBrainPF_NU.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasureEnsembleBrainPF_NU, POINTER) returns category of POINTER of MeasureEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_NU.LAYER
					prop_category = MeasureEnsembleBrainPF_NU.LAYER_CATEGORY;
				case MeasureEnsembleBrainPF_NU.SIZE_DIFF
					prop_category = MeasureEnsembleBrainPF_NU.SIZE_DIFF_CATEGORY;
				case MeasureEnsembleBrainPF_NU.SIZE_SCALE
					prop_category = MeasureEnsembleBrainPF_NU.SIZE_SCALE_CATEGORY;
				case MeasureEnsembleBrainPF_NU.COLOR_DIFF
					prop_category = MeasureEnsembleBrainPF_NU.COLOR_DIFF_CATEGORY;
				otherwise
					prop_category = getPropCategory@MeasureEnsembleBrainPF(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureEnsembleBrainPF_NU, POINTER) returns format of POINTER of MeasureEnsembleBrainPF_NU.
			%  FORMAT = PF.GETPROPFORMAT(MeasureEnsembleBrainPF_NU, POINTER) returns format of POINTER of MeasureEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_NU.LAYER
					prop_format = MeasureEnsembleBrainPF_NU.LAYER_FORMAT;
				case MeasureEnsembleBrainPF_NU.SIZE_DIFF
					prop_format = MeasureEnsembleBrainPF_NU.SIZE_DIFF_FORMAT;
				case MeasureEnsembleBrainPF_NU.SIZE_SCALE
					prop_format = MeasureEnsembleBrainPF_NU.SIZE_SCALE_FORMAT;
				case MeasureEnsembleBrainPF_NU.COLOR_DIFF
					prop_format = MeasureEnsembleBrainPF_NU.COLOR_DIFF_FORMAT;
				otherwise
					prop_format = getPropFormat@MeasureEnsembleBrainPF(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureEnsembleBrainPF_NU, POINTER) returns description of POINTER of MeasureEnsembleBrainPF_NU.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasureEnsembleBrainPF_NU, POINTER) returns description of POINTER of MeasureEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_NU.LAYER
					prop_description = 'LAYER (figure, scalar) is the layer number of the nodal measure.';
				case MeasureEnsembleBrainPF_NU.SIZE_DIFF
					prop_description = 'SIZE_DIFF (figure, option) determines whether the difference is shown with size effect.';
				case MeasureEnsembleBrainPF_NU.SIZE_SCALE
					prop_description = 'SIZE_SCALE (figure, scalar) determines the scale of size effect.';
				case MeasureEnsembleBrainPF_NU.COLOR_DIFF
					prop_description = 'COLOR_DIFF (figure, option) determines whether the difference is shown with color effect.';
				case MeasureEnsembleBrainPF_NU.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % %.';
				case MeasureEnsembleBrainPF_NU.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NU.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NU.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NU.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NU.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NU.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NU.SETUP
					prop_description = 'SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.';
				otherwise
					prop_description = getPropDescription@MeasureEnsembleBrainPF(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureEnsembleBrainPF_NU, POINTER) returns settings of POINTER of MeasureEnsembleBrainPF_NU.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasureEnsembleBrainPF_NU, POINTER) returns settings of POINTER of MeasureEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_NU.LAYER
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MeasureEnsembleBrainPF_NU.SIZE_DIFF
					prop_settings = {'on' 'off' 'disable'};
				case MeasureEnsembleBrainPF_NU.SIZE_SCALE
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case MeasureEnsembleBrainPF_NU.COLOR_DIFF
					prop_settings = {'on' 'off' 'disable'};
				case MeasureEnsembleBrainPF_NU.TEMPLATE
					prop_settings = 'MeasureEnsembleBrainPF_NU';
				otherwise
					prop_settings = getPropSettings@MeasureEnsembleBrainPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureEnsembleBrainPF_NU.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsembleBrainPF_NU.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureEnsembleBrainPF_NU, POINTER) returns the default value of POINTER of MeasureEnsembleBrainPF_NU.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasureEnsembleBrainPF_NU, POINTER) returns the default value of POINTER of MeasureEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_NU.LAYER
					prop_default = 1;
				case MeasureEnsembleBrainPF_NU.SIZE_DIFF
					prop_default = 'on';
				case MeasureEnsembleBrainPF_NU.SIZE_SCALE
					prop_default = 10;
				case MeasureEnsembleBrainPF_NU.COLOR_DIFF
					prop_default = 'on';
				case MeasureEnsembleBrainPF_NU.ELCLASS
					prop_default = 'MeasureEnsembleBrainPF_NU';
				case MeasureEnsembleBrainPF_NU.NAME
					prop_default = 'Panel Figure for Measure Group Brain';
				case MeasureEnsembleBrainPF_NU.DESCRIPTION
					prop_default = 'A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF_NU) manages the plot of the nodal unilayer measure ploted over the brain. MeasureEnsembleBrainPF_NU  utilizes the surface created from BrainAtlasPF to integrate the nodal unilayer meaure into the brain regions.';
				case MeasureEnsembleBrainPF_NU.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsembleBrainPF_NU.getPropSettings(prop));
				case MeasureEnsembleBrainPF_NU.ID
					prop_default = 'MeasureEnsembleBrainPF_NU ID';
				case MeasureEnsembleBrainPF_NU.LABEL
					prop_default = 'MeasureEnsembleBrainPF_NU label';
				case MeasureEnsembleBrainPF_NU.NOTES
					prop_default = 'MeasureEnsembleBrainPF_NU notes';
				otherwise
					prop_default = getPropDefault@MeasureEnsembleBrainPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureEnsembleBrainPF_NU.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsembleBrainPF_NU.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureEnsembleBrainPF_NU, POINTER) returns the conditioned default value of POINTER of MeasureEnsembleBrainPF_NU.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasureEnsembleBrainPF_NU, POINTER) returns the conditioned default value of POINTER of MeasureEnsembleBrainPF_NU.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureEnsembleBrainPF_NU.getPropProp(pointer);
			
			prop_default = MeasureEnsembleBrainPF_NU.conditioning(prop, MeasureEnsembleBrainPF_NU.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureEnsembleBrainPF_NU, PROP, VALUE) checks VALUE format for PROP of MeasureEnsembleBrainPF_NU.
			%  CHECK = PF.CHECKPROP(MeasureEnsembleBrainPF_NU, PROP, VALUE) checks VALUE format for PROP of MeasureEnsembleBrainPF_NU.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_NU:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_NU:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasureEnsembleBrainPF_NU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsembleBrainPF_NU.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_NU:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasureEnsembleBrainPF_NU, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsembleBrainPF_NU.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_NU:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasureEnsembleBrainPF_NU')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureEnsembleBrainPF_NU.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_NU.LAYER % __MeasureEnsembleBrainPF_NU.LAYER__
					check = Format.checkFormat(Format.SCALAR, value, MeasureEnsembleBrainPF_NU.getPropSettings(prop));
				case MeasureEnsembleBrainPF_NU.SIZE_DIFF % __MeasureEnsembleBrainPF_NU.SIZE_DIFF__
					check = Format.checkFormat(Format.OPTION, value, MeasureEnsembleBrainPF_NU.getPropSettings(prop));
				case MeasureEnsembleBrainPF_NU.SIZE_SCALE % __MeasureEnsembleBrainPF_NU.SIZE_SCALE__
					check = Format.checkFormat(Format.SCALAR, value, MeasureEnsembleBrainPF_NU.getPropSettings(prop));
				case MeasureEnsembleBrainPF_NU.COLOR_DIFF % __MeasureEnsembleBrainPF_NU.COLOR_DIFF__
					check = Format.checkFormat(Format.OPTION, value, MeasureEnsembleBrainPF_NU.getPropSettings(prop));
				case MeasureEnsembleBrainPF_NU.TEMPLATE % __MeasureEnsembleBrainPF_NU.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsembleBrainPF_NU.getPropSettings(prop));
				otherwise
					if prop <= MeasureEnsembleBrainPF.getPropNumber()
						check = checkProp@MeasureEnsembleBrainPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NU:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureEnsembleBrainPF_NU.getPropTag(prop) ' (' MeasureEnsembleBrainPF_NU.getFormatTag(MeasureEnsembleBrainPF_NU.getPropFormat(prop)) ').'] ...
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
				case MeasureEnsembleBrainPF_NU.LAYER % __MeasureEnsembleBrainPF_NU.LAYER__
					pf.get('SETUP');
					
				case MeasureEnsembleBrainPF_NU.SIZE_DIFF % __MeasureEnsembleBrainPF_NU.SIZE_DIFF__
					pf.get('SETUP');
					
				case MeasureEnsembleBrainPF_NU.SIZE_SCALE % __MeasureEnsembleBrainPF_NU.SIZE_SCALE__
					pf.get('SETUP');
					
				case MeasureEnsembleBrainPF_NU.COLOR_DIFF % __MeasureEnsembleBrainPF_NU.COLOR_DIFF__
					pf.get('SETUP');
					
				otherwise
					if prop <= MeasureEnsembleBrainPF.getPropNumber()
						postset@MeasureEnsembleBrainPF(pf, prop);
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
				case MeasureEnsembleBrainPF_NU.SETUP % __MeasureEnsembleBrainPF_NU.SETUP__
					me = pf.get('ME');
					
					% get brain region related list
					sph_list = pf.get('SPH_DICT').get('IT_LIST');
					sym_list = pf.get('SYM_DICT').get('IT_LIST');
					id_list = pf.get('ID_DICT').get('IT_LIST');
					lab_list = pf.get('LAB_DICT').get('IT_LIST');
					
					% get the value to show on the surface
					layer = pf.get('LAYER');
					m_values = me.get('M');
					if isempty(m_values)
					    value = {};
					    return
					end
					m_value = m_values{layer};
					if isempty(m_value)
					    value = {};
					    return
					end
					
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
					if prop <= MeasureEnsembleBrainPF.getPropNumber()
						value = calculateValue@MeasureEnsembleBrainPF(pf, prop, varargin{:});
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
				case MeasureEnsembleBrainPF_NU.LAYER % __MeasureEnsembleBrainPF_NU.LAYER__
					pr = MeasureEnsembleBrainPF_xUPP_Layer('EL', pf, 'PROP', MeasureEnsembleBrainPF_NU.LAYER);
					
				otherwise
					pr = getPanelProp@MeasureEnsembleBrainPF(pf, prop, varargin{:});
					
			end
		end
	end
end
