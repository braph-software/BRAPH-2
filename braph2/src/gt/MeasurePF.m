classdef MeasurePF < PanelFig
	%MeasurePF is the base element to plot a measure.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% A Panel Figure for Measure (MeasurePF) manages the basic functionalities to plot of a measure.
	%
	% MeasurePF methods (constructor):
	%  MeasurePF - constructor
	%
	% MeasurePF methods:
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
	% MeasurePF methods (display):
	%  tostring - string with information about the panel figure for measure
	%  disp - displays information about the panel figure for measure
	%  tree - displays the tree of the panel figure for measure
	%
	% MeasurePF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for measure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for measure
	%
	% MeasurePF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for measure as b2 file
	%  load - loads a BRAPH2 panel figure for measure from a b2 file
	%
	% MeasurePF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for measure
	%
	% MeasurePF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for measure
	%
	% MeasurePF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for measure
	%  getSubclasses - returns all subclasses of MeasurePF
	%  getProps - returns the property list of the panel figure for measure
	%  getPropNumber - returns the property number of the panel figure for measure
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
	% MeasurePF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasurePF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasurePF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasurePF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasurePF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasurePF constants</a>.
	%
	%
	% See also Measure.
	
	properties (Constant) % properties
		H_AXES = PanelFig.getPropNumber() + 1;
		H_AXES_TAG = 'H_AXES';
		H_AXES_CATEGORY = Category.EVANESCENT;
		H_AXES_FORMAT = Format.HANDLE;
		
		ST_AXIS = PanelFig.getPropNumber() + 2;
		ST_AXIS_TAG = 'ST_AXIS';
		ST_AXIS_CATEGORY = Category.FIGURE;
		ST_AXIS_FORMAT = Format.ITEM;
		
		LISTENER_ST_AXIS = PanelFig.getPropNumber() + 3;
		LISTENER_ST_AXIS_TAG = 'LISTENER_ST_AXIS';
		LISTENER_ST_AXIS_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_AXIS_FORMAT = Format.HANDLE;
		
		M = PanelFig.getPropNumber() + 4;
		M_TAG = 'M';
		M_CATEGORY = Category.METADATA;
		M_FORMAT = Format.ITEM;
		
		SETUP = PanelFig.getPropNumber() + 5;
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = Category.QUERY;
		SETUP_FORMAT = Format.EMPTY;
		
		H_AREA = PanelFig.getPropNumber() + 6;
		H_AREA_TAG = 'H_AREA';
		H_AREA_CATEGORY = Category.EVANESCENT;
		H_AREA_FORMAT = Format.HANDLE;
		
		ST_AREA = PanelFig.getPropNumber() + 7;
		ST_AREA_TAG = 'ST_AREA';
		ST_AREA_CATEGORY = Category.FIGURE;
		ST_AREA_FORMAT = Format.ITEM;
		
		LISTENER_ST_AREA = PanelFig.getPropNumber() + 8;
		LISTENER_ST_AREA_TAG = 'LISTENER_ST_AREA';
		LISTENER_ST_AREA_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_AREA_FORMAT = Format.HANDLE;
		
		H_LINE = PanelFig.getPropNumber() + 9;
		H_LINE_TAG = 'H_LINE';
		H_LINE_CATEGORY = Category.EVANESCENT;
		H_LINE_FORMAT = Format.HANDLE;
		
		ST_LINE = PanelFig.getPropNumber() + 10;
		ST_LINE_TAG = 'ST_LINE';
		ST_LINE_CATEGORY = Category.FIGURE;
		ST_LINE_FORMAT = Format.ITEM;
		
		LISTENER_ST_LINE = PanelFig.getPropNumber() + 11;
		LISTENER_ST_LINE_TAG = 'LISTENER_ST_LINE';
		LISTENER_ST_LINE_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_LINE_FORMAT = Format.HANDLE;
		
		H_TITLE = PanelFig.getPropNumber() + 12;
		H_TITLE_TAG = 'H_TITLE';
		H_TITLE_CATEGORY = Category.EVANESCENT;
		H_TITLE_FORMAT = Format.HANDLE;
		
		ST_TITLE = PanelFig.getPropNumber() + 13;
		ST_TITLE_TAG = 'ST_TITLE';
		ST_TITLE_CATEGORY = Category.FIGURE;
		ST_TITLE_FORMAT = Format.ITEM;
		
		H_XLABEL = PanelFig.getPropNumber() + 14;
		H_XLABEL_TAG = 'H_XLABEL';
		H_XLABEL_CATEGORY = Category.EVANESCENT;
		H_XLABEL_FORMAT = Format.HANDLE;
		
		ST_XLABEL = PanelFig.getPropNumber() + 15;
		ST_XLABEL_TAG = 'ST_XLABEL';
		ST_XLABEL_CATEGORY = Category.FIGURE;
		ST_XLABEL_FORMAT = Format.ITEM;
		
		H_YLABEL = PanelFig.getPropNumber() + 16;
		H_YLABEL_TAG = 'H_YLABEL';
		H_YLABEL_CATEGORY = Category.EVANESCENT;
		H_YLABEL_FORMAT = Format.HANDLE;
		
		ST_YLABEL = PanelFig.getPropNumber() + 17;
		ST_YLABEL_TAG = 'ST_YLABEL';
		ST_YLABEL_CATEGORY = Category.FIGURE;
		ST_YLABEL_FORMAT = Format.ITEM;
	end
	methods % constructor
		function pf = MeasurePF(varargin)
			%MeasurePF() creates a panel figure for measure.
			%
			% MeasurePF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasurePF(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			pf = pf@PanelFig(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for measure.
			%
			% CLASS = MeasurePF.GETCLASS() returns the class 'MeasurePF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for measure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasurePF') returns 'MeasurePF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasurePF')
			%  are less computationally efficient.
			
			pf_class = 'MeasurePF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for measure.
			%
			% LIST = MeasurePF.GETSUBCLASSES() returns all subclasses of 'MeasurePF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for measure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasurePF') returns all subclasses of 'MeasurePF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasurePF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasurePF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for measure.
			%
			% PROPS = MeasurePF.GETPROPS() returns the property list of panel figure for measure
			%  as a row vector.
			%
			% PROPS = MeasurePF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for measure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasurePF'[, CATEGORY]) returns the property list of 'MeasurePF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelFig.getProps() ...
						MeasurePF.H_AXES ...
						MeasurePF.ST_AXIS ...
						MeasurePF.LISTENER_ST_AXIS ...
						MeasurePF.M ...
						MeasurePF.SETUP ...
						MeasurePF.H_AREA ...
						MeasurePF.ST_AREA ...
						MeasurePF.LISTENER_ST_AREA ...
						MeasurePF.H_LINE ...
						MeasurePF.ST_LINE ...
						MeasurePF.LISTENER_ST_LINE ...
						MeasurePF.H_TITLE ...
						MeasurePF.ST_TITLE ...
						MeasurePF.H_XLABEL ...
						MeasurePF.ST_XLABEL ...
						MeasurePF.H_YLABEL ...
						MeasurePF.ST_YLABEL ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						PanelFig.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						PanelFig.getProps(Category.METADATA) ...
						MeasurePF.M ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						PanelFig.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						PanelFig.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						PanelFig.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						PanelFig.getProps(Category.QUERY) ...
						MeasurePF.SETUP ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelFig.getProps(Category.EVANESCENT) ...
						MeasurePF.H_AXES ...
						MeasurePF.LISTENER_ST_AXIS ...
						MeasurePF.H_AREA ...
						MeasurePF.LISTENER_ST_AREA ...
						MeasurePF.H_LINE ...
						MeasurePF.LISTENER_ST_LINE ...
						MeasurePF.H_TITLE ...
						MeasurePF.H_XLABEL ...
						MeasurePF.H_YLABEL ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelFig.getProps(Category.FIGURE) ...
						MeasurePF.ST_AXIS ...
						MeasurePF.ST_AREA ...
						MeasurePF.ST_LINE ...
						MeasurePF.ST_TITLE ...
						MeasurePF.ST_XLABEL ...
						MeasurePF.ST_YLABEL ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelFig.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for measure.
			%
			% N = MeasurePF.GETPROPNUMBER() returns the property number of panel figure for measure.
			%
			% N = MeasurePF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for measure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for measure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasurePF') returns the property number of 'MeasurePF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasurePF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for measure/error.
			%
			% CHECK = MeasurePF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasurePF, PROP) checks whether PROP exists for MeasurePF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasurePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%  Element.EXISTSPROP(MeasurePF, PROP) throws error if PROP does NOT exist for MeasurePF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasurePF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasurePF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for measure/error.
			%
			% CHECK = MeasurePF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasurePF, TAG) checks whether TAG exists for MeasurePF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasurePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%  Element.EXISTSTAG(MeasurePF, TAG) throws error if TAG does NOT exist for MeasurePF.
			%   Error id: [BRAPH2:MeasurePF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measurepf_tag_list = cellfun(@(x) MeasurePF.getPropTag(x), num2cell(MeasurePF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measurepf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasurePF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasurePF, POINTER) returns property number of POINTER of MeasurePF.
			%  PROPERTY = PF.GETPROPPROP(MeasurePF, POINTER) returns property number of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measurepf_tag_list = cellfun(@(x) MeasurePF.getPropTag(x), num2cell(MeasurePF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measurepf_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasurePF, POINTER) returns tag of POINTER of MeasurePF.
			%  TAG = PF.GETPROPTAG(MeasurePF, POINTER) returns tag of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MeasurePF.H_AXES
						tag = MeasurePF.H_AXES_TAG;
					case MeasurePF.ST_AXIS
						tag = MeasurePF.ST_AXIS_TAG;
					case MeasurePF.LISTENER_ST_AXIS
						tag = MeasurePF.LISTENER_ST_AXIS_TAG;
					case MeasurePF.M
						tag = MeasurePF.M_TAG;
					case MeasurePF.SETUP
						tag = MeasurePF.SETUP_TAG;
					case MeasurePF.H_AREA
						tag = MeasurePF.H_AREA_TAG;
					case MeasurePF.ST_AREA
						tag = MeasurePF.ST_AREA_TAG;
					case MeasurePF.LISTENER_ST_AREA
						tag = MeasurePF.LISTENER_ST_AREA_TAG;
					case MeasurePF.H_LINE
						tag = MeasurePF.H_LINE_TAG;
					case MeasurePF.ST_LINE
						tag = MeasurePF.ST_LINE_TAG;
					case MeasurePF.LISTENER_ST_LINE
						tag = MeasurePF.LISTENER_ST_LINE_TAG;
					case MeasurePF.H_TITLE
						tag = MeasurePF.H_TITLE_TAG;
					case MeasurePF.ST_TITLE
						tag = MeasurePF.ST_TITLE_TAG;
					case MeasurePF.H_XLABEL
						tag = MeasurePF.H_XLABEL_TAG;
					case MeasurePF.ST_XLABEL
						tag = MeasurePF.ST_XLABEL_TAG;
					case MeasurePF.H_YLABEL
						tag = MeasurePF.H_YLABEL_TAG;
					case MeasurePF.ST_YLABEL
						tag = MeasurePF.ST_YLABEL_TAG;
					otherwise
						tag = getPropTag@PanelFig(prop);
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasurePF, POINTER) returns category of POINTER of MeasurePF.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasurePF, POINTER) returns category of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasurePF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			switch prop
				case MeasurePF.H_AXES
					prop_category = MeasurePF.H_AXES_CATEGORY;
				case MeasurePF.ST_AXIS
					prop_category = MeasurePF.ST_AXIS_CATEGORY;
				case MeasurePF.LISTENER_ST_AXIS
					prop_category = MeasurePF.LISTENER_ST_AXIS_CATEGORY;
				case MeasurePF.M
					prop_category = MeasurePF.M_CATEGORY;
				case MeasurePF.SETUP
					prop_category = MeasurePF.SETUP_CATEGORY;
				case MeasurePF.H_AREA
					prop_category = MeasurePF.H_AREA_CATEGORY;
				case MeasurePF.ST_AREA
					prop_category = MeasurePF.ST_AREA_CATEGORY;
				case MeasurePF.LISTENER_ST_AREA
					prop_category = MeasurePF.LISTENER_ST_AREA_CATEGORY;
				case MeasurePF.H_LINE
					prop_category = MeasurePF.H_LINE_CATEGORY;
				case MeasurePF.ST_LINE
					prop_category = MeasurePF.ST_LINE_CATEGORY;
				case MeasurePF.LISTENER_ST_LINE
					prop_category = MeasurePF.LISTENER_ST_LINE_CATEGORY;
				case MeasurePF.H_TITLE
					prop_category = MeasurePF.H_TITLE_CATEGORY;
				case MeasurePF.ST_TITLE
					prop_category = MeasurePF.ST_TITLE_CATEGORY;
				case MeasurePF.H_XLABEL
					prop_category = MeasurePF.H_XLABEL_CATEGORY;
				case MeasurePF.ST_XLABEL
					prop_category = MeasurePF.ST_XLABEL_CATEGORY;
				case MeasurePF.H_YLABEL
					prop_category = MeasurePF.H_YLABEL_CATEGORY;
				case MeasurePF.ST_YLABEL
					prop_category = MeasurePF.ST_YLABEL_CATEGORY;
				otherwise
					prop_category = getPropCategory@PanelFig(prop);
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
			%  FORMAT = Element.GETPROPFORMAT(MeasurePF, POINTER) returns format of POINTER of MeasurePF.
			%  FORMAT = PF.GETPROPFORMAT(MeasurePF, POINTER) returns format of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasurePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			switch prop
				case MeasurePF.H_AXES
					prop_format = MeasurePF.H_AXES_FORMAT;
				case MeasurePF.ST_AXIS
					prop_format = MeasurePF.ST_AXIS_FORMAT;
				case MeasurePF.LISTENER_ST_AXIS
					prop_format = MeasurePF.LISTENER_ST_AXIS_FORMAT;
				case MeasurePF.M
					prop_format = MeasurePF.M_FORMAT;
				case MeasurePF.SETUP
					prop_format = MeasurePF.SETUP_FORMAT;
				case MeasurePF.H_AREA
					prop_format = MeasurePF.H_AREA_FORMAT;
				case MeasurePF.ST_AREA
					prop_format = MeasurePF.ST_AREA_FORMAT;
				case MeasurePF.LISTENER_ST_AREA
					prop_format = MeasurePF.LISTENER_ST_AREA_FORMAT;
				case MeasurePF.H_LINE
					prop_format = MeasurePF.H_LINE_FORMAT;
				case MeasurePF.ST_LINE
					prop_format = MeasurePF.ST_LINE_FORMAT;
				case MeasurePF.LISTENER_ST_LINE
					prop_format = MeasurePF.LISTENER_ST_LINE_FORMAT;
				case MeasurePF.H_TITLE
					prop_format = MeasurePF.H_TITLE_FORMAT;
				case MeasurePF.ST_TITLE
					prop_format = MeasurePF.ST_TITLE_FORMAT;
				case MeasurePF.H_XLABEL
					prop_format = MeasurePF.H_XLABEL_FORMAT;
				case MeasurePF.ST_XLABEL
					prop_format = MeasurePF.ST_XLABEL_FORMAT;
				case MeasurePF.H_YLABEL
					prop_format = MeasurePF.H_YLABEL_FORMAT;
				case MeasurePF.ST_YLABEL
					prop_format = MeasurePF.ST_YLABEL_FORMAT;
				otherwise
					prop_format = getPropFormat@PanelFig(prop);
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasurePF, POINTER) returns description of POINTER of MeasurePF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasurePF, POINTER) returns description of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			switch prop
				case MeasurePF.H_AXES
					prop_description = 'H_AXES (evanescent, handle) is the handle for the axes.';
				case MeasurePF.ST_AXIS
					prop_description = 'ST_AXIS (figure, item) determines the axis settings.';
				case MeasurePF.LISTENER_ST_AXIS
					prop_description = 'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.';
				case MeasurePF.M
					prop_description = 'M (metadata, item) is the measure.';
				case MeasurePF.SETUP
					prop_description = 'SETUP (query, empty) calculates the measure value and stores it to be implemented in the subelements.';
				case MeasurePF.H_AREA
					prop_description = 'H_AREA (evanescent, handle) is the handle for the measure area.';
				case MeasurePF.ST_AREA
					prop_description = 'ST_AREA (figure, item) determines the area settings.';
				case MeasurePF.LISTENER_ST_AREA
					prop_description = 'LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.';
				case MeasurePF.H_LINE
					prop_description = 'H_LINE (evanescent, handle) is the handle for the measure line.';
				case MeasurePF.ST_LINE
					prop_description = 'ST_LINE (figure, item) determines the line settings.';
				case MeasurePF.LISTENER_ST_LINE
					prop_description = 'LISTENER_ST_LINE (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.';
				case MeasurePF.H_TITLE
					prop_description = 'H_TITLE (evanescent, handle) is the axis title.';
				case MeasurePF.ST_TITLE
					prop_description = 'ST_TITLE (figure, item) determines the title settings.';
				case MeasurePF.H_XLABEL
					prop_description = 'H_XLABEL (evanescent, handle) is the axis x-label.';
				case MeasurePF.ST_XLABEL
					prop_description = 'ST_XLABEL (figure, item) determines the x-label settings.';
				case MeasurePF.H_YLABEL
					prop_description = 'H_YLABEL (evanescent, handle) is the axis y-label.';
				case MeasurePF.ST_YLABEL
					prop_description = 'ST_YLABEL (figure, item) determines the y-label settings.';
				case MeasurePF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel figure for measure.';
				case MeasurePF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for measure.';
				case MeasurePF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for measure.';
				case MeasurePF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for measure.';
				case MeasurePF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for measure.';
				case MeasurePF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for measure.';
				case MeasurePF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for measure.';
				case MeasurePF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure measure.';
				case MeasurePF.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure graph is deleted.';
				case MeasurePF.H_TOOLS
					prop_description = 'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.';
				otherwise
					prop_description = getPropDescription@PanelFig(prop);
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasurePF, POINTER) returns settings of POINTER of MeasurePF.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasurePF, POINTER) returns settings of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			switch prop
				case MeasurePF.H_AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasurePF.ST_AXIS
					prop_settings = 'SettingsAxis';
				case MeasurePF.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasurePF.M
					prop_settings = 'Measure';
				case MeasurePF.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case MeasurePF.H_AREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasurePF.ST_AREA
					prop_settings = 'SettingsArea';
				case MeasurePF.LISTENER_ST_AREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasurePF.H_LINE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasurePF.ST_LINE
					prop_settings = 'SettingsLine';
				case MeasurePF.LISTENER_ST_LINE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasurePF.H_TITLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasurePF.ST_TITLE
					prop_settings = 'SettingsText';
				case MeasurePF.H_XLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasurePF.ST_XLABEL
					prop_settings = 'SettingsText';
				case MeasurePF.H_YLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasurePF.ST_YLABEL
					prop_settings = 'SettingsText';
				case MeasurePF.TEMPLATE
					prop_settings = 'MeasurePF';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasurePF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasurePF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasurePF, POINTER) returns the default value of POINTER of MeasurePF.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasurePF, POINTER) returns the default value of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasurePF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			switch prop
				case MeasurePF.H_AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case MeasurePF.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasurePF.getPropSettings(prop));
				case MeasurePF.M
					prop_default = Format.getFormatDefault(Format.ITEM, MeasurePF.getPropSettings(prop));
				case MeasurePF.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, MeasurePF.getPropSettings(prop));
				case MeasurePF.H_AREA
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_AREA
					prop_default = Format.getFormatDefault(Format.ITEM, MeasurePF.getPropSettings(prop));
				case MeasurePF.LISTENER_ST_AREA
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasurePF.getPropSettings(prop));
				case MeasurePF.H_LINE
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_LINE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasurePF.getPropSettings(prop));
				case MeasurePF.LISTENER_ST_LINE
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasurePF.getPropSettings(prop));
				case MeasurePF.H_TITLE
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_TITLE
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case MeasurePF.H_XLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_XLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case MeasurePF.H_YLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_YLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90);
				case MeasurePF.ELCLASS
					prop_default = 'MeasurePF';
				case MeasurePF.NAME
					prop_default = 'Panel Figure for Measure';
				case MeasurePF.DESCRIPTION
					prop_default = 'A Panel Figure for Measure (MeasurePF) manages the basic functionalities to plot of a measure.';
				case MeasurePF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasurePF.getPropSettings(prop));
				case MeasurePF.ID
					prop_default = 'MeasurePF ID';
				case MeasurePF.LABEL
					prop_default = 'MeasurePF label';
				case MeasurePF.NOTES
					prop_default = 'MeasurePF notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasurePF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasurePF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasurePF, POINTER) returns the conditioned default value of POINTER of MeasurePF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasurePF, POINTER) returns the conditioned default value of POINTER of MeasurePF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasurePF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasurePF.getPropProp(pointer);
			
			prop_default = MeasurePF.conditioning(prop, MeasurePF.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasurePF, PROP, VALUE) checks VALUE format for PROP of MeasurePF.
			%  CHECK = PF.CHECKPROP(MeasurePF, PROP, VALUE) checks VALUE format for PROP of MeasurePF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasurePF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasurePF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasurePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasurePF.
			%   Error id: €BRAPH2.STR€:MeasurePF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasurePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasurePF.
			%   Error id: €BRAPH2.STR€:MeasurePF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasurePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasurePF.getPropProp(pointer);
			
			switch prop
				case MeasurePF.H_AXES % __MeasurePF.H_AXES__
					check = Format.checkFormat(Format.HANDLE, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_AXIS % __MeasurePF.ST_AXIS__
					check = Format.checkFormat(Format.ITEM, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.LISTENER_ST_AXIS % __MeasurePF.LISTENER_ST_AXIS__
					check = Format.checkFormat(Format.HANDLE, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.M % __MeasurePF.M__
					check = Format.checkFormat(Format.ITEM, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.SETUP % __MeasurePF.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.H_AREA % __MeasurePF.H_AREA__
					check = Format.checkFormat(Format.HANDLE, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_AREA % __MeasurePF.ST_AREA__
					check = Format.checkFormat(Format.ITEM, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.LISTENER_ST_AREA % __MeasurePF.LISTENER_ST_AREA__
					check = Format.checkFormat(Format.HANDLE, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.H_LINE % __MeasurePF.H_LINE__
					check = Format.checkFormat(Format.HANDLE, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_LINE % __MeasurePF.ST_LINE__
					check = Format.checkFormat(Format.ITEM, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.LISTENER_ST_LINE % __MeasurePF.LISTENER_ST_LINE__
					check = Format.checkFormat(Format.HANDLE, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.H_TITLE % __MeasurePF.H_TITLE__
					check = Format.checkFormat(Format.HANDLE, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_TITLE % __MeasurePF.ST_TITLE__
					check = Format.checkFormat(Format.ITEM, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.H_XLABEL % __MeasurePF.H_XLABEL__
					check = Format.checkFormat(Format.HANDLE, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_XLABEL % __MeasurePF.ST_XLABEL__
					check = Format.checkFormat(Format.ITEM, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.H_YLABEL % __MeasurePF.H_YLABEL__
					check = Format.checkFormat(Format.HANDLE, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.ST_YLABEL % __MeasurePF.ST_YLABEL__
					check = Format.checkFormat(Format.ITEM, value, MeasurePF.getPropSettings(prop));
				case MeasurePF.TEMPLATE % __MeasurePF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasurePF.getPropSettings(prop));
				otherwise
					if prop <= PanelFig.getPropNumber()
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasurePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasurePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasurePF.getPropTag(prop) ' (' MeasurePF.getFormatTag(MeasurePF.getPropFormat(prop)) ').'] ...
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
				case MeasurePF.ST_AXIS % __MeasurePF.ST_AXIS__
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				otherwise
					if prop <= PanelFig.getPropNumber()
						postset@PanelFig(pf, prop);
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
				case MeasurePF.H_AXES % __MeasurePF.H_AXES__
					h_axes = uiaxes( ...
					    'Parent', pf.memorize('H'), ...
					    'Tag', 'H_AXES', ...
					    'Units', 'normalized', ...
					    'OuterPosition', [.2 .2 .6 .6] ... % % % %TODO transform this into a prop?
					    );
					h_axes.Toolbar.Visible = 'off';
					h_axes.Interactions = [];
					box(h_axes, 'on')
					hold(h_axes, 'on')
					value = h_axes;
					
				case MeasurePF.LISTENER_ST_AXIS % __MeasurePF.LISTENER_ST_AXIS__
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case MeasurePF.SETUP % __MeasurePF.SETUP__
					value = [];
					
				case MeasurePF.H_AREA % __MeasurePF.H_AREA__
					value = fill(pf.get('H_AXES'), [0], [0], 'k');
					
				case MeasurePF.LISTENER_ST_AREA % __MeasurePF.LISTENER_ST_AREA__
					value = listener(pf.get('ST_AREA'), 'PropSet', @cb_listener_st_area);
					
				case MeasurePF.H_LINE % __MeasurePF.H_LINE__
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case MeasurePF.LISTENER_ST_LINE % __MeasurePF.LISTENER_ST_LINE__
					value = listener(pf.get('ST_LINE'), 'PropSet', @cb_listener_st_line);
					
				case MeasurePF.H_TITLE % __MeasurePF.H_TITLE__
					value = title(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_TITLE'), 'NoValue')
					    st = pf.memorize('ST_TITLE');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', pf.get('M').get('LABEL'), ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case MeasurePF.H_XLABEL % __MeasurePF.H_XLABEL__
					value = xlabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_XLABEL'), 'NoValue')
					    st = pf.memorize('ST_XLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Layer', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case MeasurePF.H_YLABEL % __MeasurePF.H_YLABEL__
					value = ylabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_YLABEL'), 'NoValue')
					    st = pf.memorize('ST_YLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Measure Value', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case MeasurePF.DRAW % __MeasurePF.DRAW__
					value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', MeasurePF.H_AXES).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					
					    pf.memorize('H_AREA')
					    pf.memorize('ST_AREA').set('PANEL', pf, 'PROP', MeasurePF.H_AREA).get('SETUP')
					    pf.memorize('LISTENER_ST_AREA');
					
					    pf.memorize('H_LINE')
					    pf.memorize('ST_LINE').set('PANEL', pf, 'PROP', MeasurePF.H_LINE).get('SETUP')
					    pf.memorize('LISTENER_ST_LINE');
					
					    pf.memorize('H_TITLE')
					    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', MeasurePF.H_TITLE).get('SETUP')
					
					    pf.memorize('H_XLABEL')
					    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', MeasurePF.H_XLABEL).get('SETUP')
					
					    pf.memorize('H_YLABEL')
					    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', MeasurePF.H_YLABEL).get('SETUP')
					
					    pf.get('SETUP')
					end
					
				case MeasurePF.DELETE % __MeasurePF.DELETE__
					value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					    
					    pf.set('H_AREA', Element.getNoValue())
					    pf.set('LISTENER_ST_AREA', Element.getNoValue())
					 
					    pf.set('H_LINE', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE', Element.getNoValue())
					
					    pf.set('H_TITLE', Element.getNoValue())
					
					    pf.set('H_XLABEL', Element.getNoValue())
					    
					    pf.set('H_YLABEL', Element.getNoValue())
					end
					
				case MeasurePF.H_TOOLS % __MeasurePF.H_TOOLS__
					toolbar = pf.memorize('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    value = calculateValue@PanelFig(pf, PanelFig.H_TOOLS);
					    
					    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Axis
					    tool_axis = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Axis', ...
					        'Separator', 'on', ...
					        'State', pf.get('ST_AXIS').get('AXIS'), ...
					        'Tooltip', 'Show axis', ...
					        'CData', imread('icon_axis.png'), ...
					        'OnCallback', {@cb_axis, true}, ...
					        'OffCallback', {@cb_axis, false});
					
					    % Grid
					    tool_grid = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Grid', ...
					        'State', pf.get('ST_AXIS').get('GRID'), ...
					        'Tooltip', 'Show grid', ...
					        'CData', imread('icon_grid.png'), ...
					        'OnCallback', {@cb_grid, true}, ...
					        'OffCallback', {@cb_grid, false});
					
					    tool_separator_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Measure Area
					    tool_area = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Area', ...
					        'State', pf.get('ST_AREA').get('VISIBLE'), ...
					        'Tooltip', 'Show measure area', ...
					        'CData', imread('icon_area.png'), ...
					        'OnCallback', {@cb_area, true}, ...
					        'OffCallback', {@cb_area, false});
					    
					    % Measure Line
					    tool_line = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Line', ...
					        'State', pf.get('ST_LINE').get('VISIBLE'), ...
					        'Tooltip', 'Show measure line', ...
					        'CData', imread('icon_line.png'), ...
					        'OnCallback', {@cb_line, true}, ...
					        'OffCallback', {@cb_line, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ...
					        tool_separator_2, ...
					        tool_area, tool_line ...
					        };
					else
					    value = {};
					end
					
				otherwise
					if prop <= PanelFig.getPropNumber()
						value = calculateValue@PanelFig(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
			function cb_listener_st_axis(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
			            set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
			        end
			    end
			end
			function cb_listener_st_area(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Area'), 'State', pf.get('ST_AREA').get('VISIBLE'))
			        end
			    end
			end
			function cb_listener_st_line(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Line'), 'State', pf.get('ST_LINE').get('VISIBLE'))
			        end
			    end
			end
			function cb_axis(~, ~, axis) % (src, event)
			    pf.get('ST_AXIS').set('AXIS', axis);
			    
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_grid(~, ~, grid) % (src, event)
			    pf.get('ST_AXIS').set('GRID', grid);
			
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_area(~, ~, visible) % (src, event)
			    pf.get('ST_AREA').set('VISIBLE', visible)
			
			    % triggers the update of ST_AREA
			    pf.set('ST_AREA', pf.get('ST_AREA'))
			end
			function cb_line(~, ~, visible) % (src, event)
				pf.get('ST_LINE').set('VISIBLE', visible)
			
			    % triggers the update of ST_LINE
			    pf.set('ST_LINE', pf.get('ST_LINE'))
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
				case MeasurePF.ST_AXIS % __MeasurePF.ST_AXIS__
					pr = SettingsAxisPP('EL', pf, 'PROP', MeasurePF.ST_AXIS, varargin{:});
					
				case MeasurePF.ST_AREA % __MeasurePF.ST_AREA__
					pr = SettingsAreaPP('EL', pf, 'PROP', MeasurePF.ST_AREA, varargin{:});
					
				case MeasurePF.ST_LINE % __MeasurePF.ST_LINE__
					pr = SettingsLinePP('EL', pf, 'PROP', MeasurePF.ST_LINE, varargin{:});
					
				case MeasurePF.ST_TITLE % __MeasurePF.ST_TITLE__
					pr = SettingsTextPP('EL', pf, 'PROP', MeasurePF.ST_TITLE, varargin{:});
					
				case MeasurePF.ST_XLABEL % __MeasurePF.ST_XLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', MeasurePF.ST_XLABEL, varargin{:});
					
				case MeasurePF.ST_YLABEL % __MeasurePF.ST_YLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', MeasurePF.ST_YLABEL, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
