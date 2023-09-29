classdef ComparisonGroupPF < PanelFig
	%ComparisonGroupPF is the base element to plot a group comparison.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% ComparisonGroupPF manages the basic functionalities to plot of a group comparison.
	%
	% ComparisonGroupPF methods (constructor):
	%  ComparisonGroupPF - constructor
	%
	% ComparisonGroupPF methods:
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
	% ComparisonGroupPF methods (display):
	%  tostring - string with information about the panel group comparison figure
	%  disp - displays information about the panel group comparison figure
	%  tree - displays the tree of the panel group comparison figure
	%
	% ComparisonGroupPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel group comparison figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel group comparison figure
	%
	% ComparisonGroupPF methods (save/load, Static):
	%  save - saves BRAPH2 panel group comparison figure as b2 file
	%  load - loads a BRAPH2 panel group comparison figure from a b2 file
	%
	% ComparisonGroupPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel group comparison figure
	%
	% ComparisonGroupPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel group comparison figure
	%
	% ComparisonGroupPF methods (inspection, Static):
	%  getClass - returns the class of the panel group comparison figure
	%  getSubclasses - returns all subclasses of ComparisonGroupPF
	%  getProps - returns the property list of the panel group comparison figure
	%  getPropNumber - returns the property number of the panel group comparison figure
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
	% ComparisonGroupPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonGroupPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonGroupPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonGroupPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonGroupPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonGroupPF constants</a>.
	%
	%
	% See also ComparisonGroup.
	
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
		
		CP = PanelFig.getPropNumber() + 4;
		CP_TAG = 'CP';
		CP_CATEGORY = Category.METADATA;
		CP_FORMAT = Format.ITEM;
		
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
		
		H_LINE_DIFF = PanelFig.getPropNumber() + 9;
		H_LINE_DIFF_TAG = 'H_LINE_DIFF';
		H_LINE_DIFF_CATEGORY = Category.EVANESCENT;
		H_LINE_DIFF_FORMAT = Format.HANDLE;
		
		ST_LINE_DIFF = PanelFig.getPropNumber() + 10;
		ST_LINE_DIFF_TAG = 'ST_LINE_DIFF';
		ST_LINE_DIFF_CATEGORY = Category.FIGURE;
		ST_LINE_DIFF_FORMAT = Format.ITEM;
		
		LISTENER_ST_LINE_DIFF = PanelFig.getPropNumber() + 11;
		LISTENER_ST_LINE_DIFF_TAG = 'LISTENER_ST_LINE_DIFF';
		LISTENER_ST_LINE_DIFF_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_LINE_DIFF_FORMAT = Format.HANDLE;
		
		H_LINE_CIL = PanelFig.getPropNumber() + 12;
		H_LINE_CIL_TAG = 'H_LINE_CIL';
		H_LINE_CIL_CATEGORY = Category.EVANESCENT;
		H_LINE_CIL_FORMAT = Format.HANDLE;
		
		ST_LINE_CIL = PanelFig.getPropNumber() + 13;
		ST_LINE_CIL_TAG = 'ST_LINE_CIL';
		ST_LINE_CIL_CATEGORY = Category.FIGURE;
		ST_LINE_CIL_FORMAT = Format.ITEM;
		
		LISTENER_ST_LINE_CIL = PanelFig.getPropNumber() + 14;
		LISTENER_ST_LINE_CIL_TAG = 'LISTENER_ST_LINE_CIL';
		LISTENER_ST_LINE_CIL_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_LINE_CIL_FORMAT = Format.HANDLE;
		
		H_LINE_CIU = PanelFig.getPropNumber() + 15;
		H_LINE_CIU_TAG = 'H_LINE_CIU';
		H_LINE_CIU_CATEGORY = Category.EVANESCENT;
		H_LINE_CIU_FORMAT = Format.HANDLE;
		
		ST_LINE_CIU = PanelFig.getPropNumber() + 16;
		ST_LINE_CIU_TAG = 'ST_LINE_CIU';
		ST_LINE_CIU_CATEGORY = Category.FIGURE;
		ST_LINE_CIU_FORMAT = Format.ITEM;
		
		LISTENER_ST_LINE_CIU = PanelFig.getPropNumber() + 17;
		LISTENER_ST_LINE_CIU_TAG = 'LISTENER_ST_LINE_CIU';
		LISTENER_ST_LINE_CIU_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_LINE_CIU_FORMAT = Format.HANDLE;
		
		H_TITLE = PanelFig.getPropNumber() + 18;
		H_TITLE_TAG = 'H_TITLE';
		H_TITLE_CATEGORY = Category.EVANESCENT;
		H_TITLE_FORMAT = Format.HANDLE;
		
		ST_TITLE = PanelFig.getPropNumber() + 19;
		ST_TITLE_TAG = 'ST_TITLE';
		ST_TITLE_CATEGORY = Category.FIGURE;
		ST_TITLE_FORMAT = Format.ITEM;
		
		H_XLABEL = PanelFig.getPropNumber() + 20;
		H_XLABEL_TAG = 'H_XLABEL';
		H_XLABEL_CATEGORY = Category.EVANESCENT;
		H_XLABEL_FORMAT = Format.HANDLE;
		
		ST_XLABEL = PanelFig.getPropNumber() + 21;
		ST_XLABEL_TAG = 'ST_XLABEL';
		ST_XLABEL_CATEGORY = Category.FIGURE;
		ST_XLABEL_FORMAT = Format.ITEM;
		
		H_YLABEL = PanelFig.getPropNumber() + 22;
		H_YLABEL_TAG = 'H_YLABEL';
		H_YLABEL_CATEGORY = Category.EVANESCENT;
		H_YLABEL_FORMAT = Format.HANDLE;
		
		ST_YLABEL = PanelFig.getPropNumber() + 23;
		ST_YLABEL_TAG = 'ST_YLABEL';
		ST_YLABEL_CATEGORY = Category.FIGURE;
		ST_YLABEL_FORMAT = Format.ITEM;
	end
	methods % constructor
		function pf = ComparisonGroupPF(varargin)
			%ComparisonGroupPF() creates a panel group comparison figure.
			%
			% ComparisonGroupPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonGroupPF(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel group comparison figure.
			%
			% CLASS = ComparisonGroupPF.GETCLASS() returns the class 'ComparisonGroupPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel group comparison figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('ComparisonGroupPF') returns 'ComparisonGroupPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('ComparisonGroupPF')
			%  are less computationally efficient.
			
			pf_class = 'ComparisonGroupPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel group comparison figure.
			%
			% LIST = ComparisonGroupPF.GETSUBCLASSES() returns all subclasses of 'ComparisonGroupPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel group comparison figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('ComparisonGroupPF') returns all subclasses of 'ComparisonGroupPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('ComparisonGroupPF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel group comparison figure.
			%
			% PROPS = ComparisonGroupPF.GETPROPS() returns the property list of panel group comparison figure
			%  as a row vector.
			%
			% PROPS = ComparisonGroupPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel group comparison figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('ComparisonGroupPF'[, CATEGORY]) returns the property list of 'ComparisonGroupPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelFig.getProps() ...
						ComparisonGroupPF.H_AXES ...
						ComparisonGroupPF.ST_AXIS ...
						ComparisonGroupPF.LISTENER_ST_AXIS ...
						ComparisonGroupPF.CP ...
						ComparisonGroupPF.SETUP ...
						ComparisonGroupPF.H_AREA ...
						ComparisonGroupPF.ST_AREA ...
						ComparisonGroupPF.LISTENER_ST_AREA ...
						ComparisonGroupPF.H_LINE_DIFF ...
						ComparisonGroupPF.ST_LINE_DIFF ...
						ComparisonGroupPF.LISTENER_ST_LINE_DIFF ...
						ComparisonGroupPF.H_LINE_CIL ...
						ComparisonGroupPF.ST_LINE_CIL ...
						ComparisonGroupPF.LISTENER_ST_LINE_CIL ...
						ComparisonGroupPF.H_LINE_CIU ...
						ComparisonGroupPF.ST_LINE_CIU ...
						ComparisonGroupPF.LISTENER_ST_LINE_CIU ...
						ComparisonGroupPF.H_TITLE ...
						ComparisonGroupPF.ST_TITLE ...
						ComparisonGroupPF.H_XLABEL ...
						ComparisonGroupPF.ST_XLABEL ...
						ComparisonGroupPF.H_YLABEL ...
						ComparisonGroupPF.ST_YLABEL ...
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
						ComparisonGroupPF.CP ...
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
						ComparisonGroupPF.SETUP ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelFig.getProps(Category.EVANESCENT) ...
						ComparisonGroupPF.H_AXES ...
						ComparisonGroupPF.LISTENER_ST_AXIS ...
						ComparisonGroupPF.H_AREA ...
						ComparisonGroupPF.LISTENER_ST_AREA ...
						ComparisonGroupPF.H_LINE_DIFF ...
						ComparisonGroupPF.LISTENER_ST_LINE_DIFF ...
						ComparisonGroupPF.H_LINE_CIL ...
						ComparisonGroupPF.LISTENER_ST_LINE_CIL ...
						ComparisonGroupPF.H_LINE_CIU ...
						ComparisonGroupPF.LISTENER_ST_LINE_CIU ...
						ComparisonGroupPF.H_TITLE ...
						ComparisonGroupPF.H_XLABEL ...
						ComparisonGroupPF.H_YLABEL ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelFig.getProps(Category.FIGURE) ...
						ComparisonGroupPF.ST_AXIS ...
						ComparisonGroupPF.ST_AREA ...
						ComparisonGroupPF.ST_LINE_DIFF ...
						ComparisonGroupPF.ST_LINE_CIL ...
						ComparisonGroupPF.ST_LINE_CIU ...
						ComparisonGroupPF.ST_TITLE ...
						ComparisonGroupPF.ST_XLABEL ...
						ComparisonGroupPF.ST_YLABEL ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelFig.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel group comparison figure.
			%
			% N = ComparisonGroupPF.GETPROPNUMBER() returns the property number of panel group comparison figure.
			%
			% N = ComparisonGroupPF.GETPROPNUMBER(CATEGORY) returns the property number of panel group comparison figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel group comparison figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('ComparisonGroupPF') returns the property number of 'ComparisonGroupPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(ComparisonGroupPF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel group comparison figure/error.
			%
			% CHECK = ComparisonGroupPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(ComparisonGroupPF, PROP) checks whether PROP exists for ComparisonGroupPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupPF:WrongInput]
			%  Element.EXISTSPROP(ComparisonGroupPF, PROP) throws error if PROP does NOT exist for ComparisonGroupPF.
			%   Error id: [BRAPH2:ComparisonGroupPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == ComparisonGroupPF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonGroupPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel group comparison figure/error.
			%
			% CHECK = ComparisonGroupPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(ComparisonGroupPF, TAG) checks whether TAG exists for ComparisonGroupPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonGroupPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonGroupPF:WrongInput]
			%  Element.EXISTSTAG(ComparisonGroupPF, TAG) throws error if TAG does NOT exist for ComparisonGroupPF.
			%   Error id: [BRAPH2:ComparisonGroupPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			comparisongrouppf_tag_list = cellfun(@(x) ComparisonGroupPF.getPropTag(x), num2cell(ComparisonGroupPF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, comparisongrouppf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonGroupPF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonGroupPF, POINTER) returns property number of POINTER of ComparisonGroupPF.
			%  PROPERTY = PF.GETPROPPROP(ComparisonGroupPF, POINTER) returns property number of POINTER of ComparisonGroupPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				comparisongrouppf_tag_list = cellfun(@(x) ComparisonGroupPF.getPropTag(x), num2cell(ComparisonGroupPF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, comparisongrouppf_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(ComparisonGroupPF, POINTER) returns tag of POINTER of ComparisonGroupPF.
			%  TAG = PF.GETPROPTAG(ComparisonGroupPF, POINTER) returns tag of POINTER of ComparisonGroupPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case ComparisonGroupPF.H_AXES
						tag = ComparisonGroupPF.H_AXES_TAG;
					case ComparisonGroupPF.ST_AXIS
						tag = ComparisonGroupPF.ST_AXIS_TAG;
					case ComparisonGroupPF.LISTENER_ST_AXIS
						tag = ComparisonGroupPF.LISTENER_ST_AXIS_TAG;
					case ComparisonGroupPF.CP
						tag = ComparisonGroupPF.CP_TAG;
					case ComparisonGroupPF.SETUP
						tag = ComparisonGroupPF.SETUP_TAG;
					case ComparisonGroupPF.H_AREA
						tag = ComparisonGroupPF.H_AREA_TAG;
					case ComparisonGroupPF.ST_AREA
						tag = ComparisonGroupPF.ST_AREA_TAG;
					case ComparisonGroupPF.LISTENER_ST_AREA
						tag = ComparisonGroupPF.LISTENER_ST_AREA_TAG;
					case ComparisonGroupPF.H_LINE_DIFF
						tag = ComparisonGroupPF.H_LINE_DIFF_TAG;
					case ComparisonGroupPF.ST_LINE_DIFF
						tag = ComparisonGroupPF.ST_LINE_DIFF_TAG;
					case ComparisonGroupPF.LISTENER_ST_LINE_DIFF
						tag = ComparisonGroupPF.LISTENER_ST_LINE_DIFF_TAG;
					case ComparisonGroupPF.H_LINE_CIL
						tag = ComparisonGroupPF.H_LINE_CIL_TAG;
					case ComparisonGroupPF.ST_LINE_CIL
						tag = ComparisonGroupPF.ST_LINE_CIL_TAG;
					case ComparisonGroupPF.LISTENER_ST_LINE_CIL
						tag = ComparisonGroupPF.LISTENER_ST_LINE_CIL_TAG;
					case ComparisonGroupPF.H_LINE_CIU
						tag = ComparisonGroupPF.H_LINE_CIU_TAG;
					case ComparisonGroupPF.ST_LINE_CIU
						tag = ComparisonGroupPF.ST_LINE_CIU_TAG;
					case ComparisonGroupPF.LISTENER_ST_LINE_CIU
						tag = ComparisonGroupPF.LISTENER_ST_LINE_CIU_TAG;
					case ComparisonGroupPF.H_TITLE
						tag = ComparisonGroupPF.H_TITLE_TAG;
					case ComparisonGroupPF.ST_TITLE
						tag = ComparisonGroupPF.ST_TITLE_TAG;
					case ComparisonGroupPF.H_XLABEL
						tag = ComparisonGroupPF.H_XLABEL_TAG;
					case ComparisonGroupPF.ST_XLABEL
						tag = ComparisonGroupPF.ST_XLABEL_TAG;
					case ComparisonGroupPF.H_YLABEL
						tag = ComparisonGroupPF.H_YLABEL_TAG;
					case ComparisonGroupPF.ST_YLABEL
						tag = ComparisonGroupPF.ST_YLABEL_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonGroupPF, POINTER) returns category of POINTER of ComparisonGroupPF.
			%  CATEGORY = PF.GETPROPCATEGORY(ComparisonGroupPF, POINTER) returns category of POINTER of ComparisonGroupPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF.H_AXES
					prop_category = ComparisonGroupPF.H_AXES_CATEGORY;
				case ComparisonGroupPF.ST_AXIS
					prop_category = ComparisonGroupPF.ST_AXIS_CATEGORY;
				case ComparisonGroupPF.LISTENER_ST_AXIS
					prop_category = ComparisonGroupPF.LISTENER_ST_AXIS_CATEGORY;
				case ComparisonGroupPF.CP
					prop_category = ComparisonGroupPF.CP_CATEGORY;
				case ComparisonGroupPF.SETUP
					prop_category = ComparisonGroupPF.SETUP_CATEGORY;
				case ComparisonGroupPF.H_AREA
					prop_category = ComparisonGroupPF.H_AREA_CATEGORY;
				case ComparisonGroupPF.ST_AREA
					prop_category = ComparisonGroupPF.ST_AREA_CATEGORY;
				case ComparisonGroupPF.LISTENER_ST_AREA
					prop_category = ComparisonGroupPF.LISTENER_ST_AREA_CATEGORY;
				case ComparisonGroupPF.H_LINE_DIFF
					prop_category = ComparisonGroupPF.H_LINE_DIFF_CATEGORY;
				case ComparisonGroupPF.ST_LINE_DIFF
					prop_category = ComparisonGroupPF.ST_LINE_DIFF_CATEGORY;
				case ComparisonGroupPF.LISTENER_ST_LINE_DIFF
					prop_category = ComparisonGroupPF.LISTENER_ST_LINE_DIFF_CATEGORY;
				case ComparisonGroupPF.H_LINE_CIL
					prop_category = ComparisonGroupPF.H_LINE_CIL_CATEGORY;
				case ComparisonGroupPF.ST_LINE_CIL
					prop_category = ComparisonGroupPF.ST_LINE_CIL_CATEGORY;
				case ComparisonGroupPF.LISTENER_ST_LINE_CIL
					prop_category = ComparisonGroupPF.LISTENER_ST_LINE_CIL_CATEGORY;
				case ComparisonGroupPF.H_LINE_CIU
					prop_category = ComparisonGroupPF.H_LINE_CIU_CATEGORY;
				case ComparisonGroupPF.ST_LINE_CIU
					prop_category = ComparisonGroupPF.ST_LINE_CIU_CATEGORY;
				case ComparisonGroupPF.LISTENER_ST_LINE_CIU
					prop_category = ComparisonGroupPF.LISTENER_ST_LINE_CIU_CATEGORY;
				case ComparisonGroupPF.H_TITLE
					prop_category = ComparisonGroupPF.H_TITLE_CATEGORY;
				case ComparisonGroupPF.ST_TITLE
					prop_category = ComparisonGroupPF.ST_TITLE_CATEGORY;
				case ComparisonGroupPF.H_XLABEL
					prop_category = ComparisonGroupPF.H_XLABEL_CATEGORY;
				case ComparisonGroupPF.ST_XLABEL
					prop_category = ComparisonGroupPF.ST_XLABEL_CATEGORY;
				case ComparisonGroupPF.H_YLABEL
					prop_category = ComparisonGroupPF.H_YLABEL_CATEGORY;
				case ComparisonGroupPF.ST_YLABEL
					prop_category = ComparisonGroupPF.ST_YLABEL_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonGroupPF, POINTER) returns format of POINTER of ComparisonGroupPF.
			%  FORMAT = PF.GETPROPFORMAT(ComparisonGroupPF, POINTER) returns format of POINTER of ComparisonGroupPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF.H_AXES
					prop_format = ComparisonGroupPF.H_AXES_FORMAT;
				case ComparisonGroupPF.ST_AXIS
					prop_format = ComparisonGroupPF.ST_AXIS_FORMAT;
				case ComparisonGroupPF.LISTENER_ST_AXIS
					prop_format = ComparisonGroupPF.LISTENER_ST_AXIS_FORMAT;
				case ComparisonGroupPF.CP
					prop_format = ComparisonGroupPF.CP_FORMAT;
				case ComparisonGroupPF.SETUP
					prop_format = ComparisonGroupPF.SETUP_FORMAT;
				case ComparisonGroupPF.H_AREA
					prop_format = ComparisonGroupPF.H_AREA_FORMAT;
				case ComparisonGroupPF.ST_AREA
					prop_format = ComparisonGroupPF.ST_AREA_FORMAT;
				case ComparisonGroupPF.LISTENER_ST_AREA
					prop_format = ComparisonGroupPF.LISTENER_ST_AREA_FORMAT;
				case ComparisonGroupPF.H_LINE_DIFF
					prop_format = ComparisonGroupPF.H_LINE_DIFF_FORMAT;
				case ComparisonGroupPF.ST_LINE_DIFF
					prop_format = ComparisonGroupPF.ST_LINE_DIFF_FORMAT;
				case ComparisonGroupPF.LISTENER_ST_LINE_DIFF
					prop_format = ComparisonGroupPF.LISTENER_ST_LINE_DIFF_FORMAT;
				case ComparisonGroupPF.H_LINE_CIL
					prop_format = ComparisonGroupPF.H_LINE_CIL_FORMAT;
				case ComparisonGroupPF.ST_LINE_CIL
					prop_format = ComparisonGroupPF.ST_LINE_CIL_FORMAT;
				case ComparisonGroupPF.LISTENER_ST_LINE_CIL
					prop_format = ComparisonGroupPF.LISTENER_ST_LINE_CIL_FORMAT;
				case ComparisonGroupPF.H_LINE_CIU
					prop_format = ComparisonGroupPF.H_LINE_CIU_FORMAT;
				case ComparisonGroupPF.ST_LINE_CIU
					prop_format = ComparisonGroupPF.ST_LINE_CIU_FORMAT;
				case ComparisonGroupPF.LISTENER_ST_LINE_CIU
					prop_format = ComparisonGroupPF.LISTENER_ST_LINE_CIU_FORMAT;
				case ComparisonGroupPF.H_TITLE
					prop_format = ComparisonGroupPF.H_TITLE_FORMAT;
				case ComparisonGroupPF.ST_TITLE
					prop_format = ComparisonGroupPF.ST_TITLE_FORMAT;
				case ComparisonGroupPF.H_XLABEL
					prop_format = ComparisonGroupPF.H_XLABEL_FORMAT;
				case ComparisonGroupPF.ST_XLABEL
					prop_format = ComparisonGroupPF.ST_XLABEL_FORMAT;
				case ComparisonGroupPF.H_YLABEL
					prop_format = ComparisonGroupPF.H_YLABEL_FORMAT;
				case ComparisonGroupPF.ST_YLABEL
					prop_format = ComparisonGroupPF.ST_YLABEL_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonGroupPF, POINTER) returns description of POINTER of ComparisonGroupPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(ComparisonGroupPF, POINTER) returns description of POINTER of ComparisonGroupPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF.H_AXES
					prop_description = 'H_AXES (evanescent, handle) is the handle for the axes.';
				case ComparisonGroupPF.ST_AXIS
					prop_description = 'ST_AXIS (figure, item) determines the axis settings.';
				case ComparisonGroupPF.LISTENER_ST_AXIS
					prop_description = 'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.';
				case ComparisonGroupPF.CP
					prop_description = 'CP (metadata, item) is the group comparison.';
				case ComparisonGroupPF.SETUP
					prop_description = 'SETUP (query, empty) calculates the group comparison value and stores it to be implemented in the subelements.';
				case ComparisonGroupPF.H_AREA
					prop_description = 'H_AREA (evanescent, handle) is the handle for the group comparison confidence area.';
				case ComparisonGroupPF.ST_AREA
					prop_description = 'ST_AREA (figure, item) determines the area settings.';
				case ComparisonGroupPF.LISTENER_ST_AREA
					prop_description = 'LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.';
				case ComparisonGroupPF.H_LINE_DIFF
					prop_description = 'H_LINE_DIFF (evanescent, handle) is the handle for the group comparison line.';
				case ComparisonGroupPF.ST_LINE_DIFF
					prop_description = 'ST_LINE_DIFF (figure, item) determines the line settings.';
				case ComparisonGroupPF.LISTENER_ST_LINE_DIFF
					prop_description = 'LISTENER_ST_LINE_DIFF (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.';
				case ComparisonGroupPF.H_LINE_CIL
					prop_description = 'H_LINE_CIL (evanescent, handle) is the handle for the lower confidence interval of the group comparison line.';
				case ComparisonGroupPF.ST_LINE_CIL
					prop_description = 'ST_LINE_CIL (figure, item) determines the line settings.';
				case ComparisonGroupPF.LISTENER_ST_LINE_CIL
					prop_description = 'LISTENER_ST_LINE_CIL (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.';
				case ComparisonGroupPF.H_LINE_CIU
					prop_description = 'H_LINE_CIU (evanescent, handle) is the handle for the upper confidence interval of the group comparison line.';
				case ComparisonGroupPF.ST_LINE_CIU
					prop_description = 'ST_LINE_CIU (figure, item) determines the line settings.';
				case ComparisonGroupPF.LISTENER_ST_LINE_CIU
					prop_description = 'LISTENER_ST_LINE_CIU (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.';
				case ComparisonGroupPF.H_TITLE
					prop_description = 'H_TITLE (evanescent, handle) is the axis title.';
				case ComparisonGroupPF.ST_TITLE
					prop_description = 'ST_TITLE (figure, item) determines the title settings.';
				case ComparisonGroupPF.H_XLABEL
					prop_description = 'H_XLABEL (evanescent, handle) is the axis x-label.';
				case ComparisonGroupPF.ST_XLABEL
					prop_description = 'ST_XLABEL (figure, item) determines the x-label settings.';
				case ComparisonGroupPF.H_YLABEL
					prop_description = 'H_YLABEL (evanescent, handle) is the axis y-label.';
				case ComparisonGroupPF.ST_YLABEL
					prop_description = 'ST_YLABEL (figure, item) determines the y-label settings.';
				case ComparisonGroupPF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case ComparisonGroupPF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel group comparison figure.';
				case ComparisonGroupPF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel group comparison figure.';
				case ComparisonGroupPF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel group comparison figure.';
				case ComparisonGroupPF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel group comparison figure.';
				case ComparisonGroupPF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel group comparison figure.';
				case ComparisonGroupPF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel group comparison figure.';
				case ComparisonGroupPF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure comparison figure.';
				case ComparisonGroupPF.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure graph is deleted.';
				case ComparisonGroupPF.H_TOOLS
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonGroupPF, POINTER) returns settings of POINTER of ComparisonGroupPF.
			%  SETTINGS = PF.GETPROPSETTINGS(ComparisonGroupPF, POINTER) returns settings of POINTER of ComparisonGroupPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonGroupPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF.H_AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.ST_AXIS
					prop_settings = 'SettingsAxis';
				case ComparisonGroupPF.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.CP
					prop_settings = 'ComparisonGroup';
				case ComparisonGroupPF.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ComparisonGroupPF.H_AREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.ST_AREA
					prop_settings = 'SettingsArea';
				case ComparisonGroupPF.LISTENER_ST_AREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.H_LINE_DIFF
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.ST_LINE_DIFF
					prop_settings = 'SettingsLine';
				case ComparisonGroupPF.LISTENER_ST_LINE_DIFF
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.H_LINE_CIL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.ST_LINE_CIL
					prop_settings = 'SettingsLine';
				case ComparisonGroupPF.LISTENER_ST_LINE_CIL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.H_LINE_CIU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.ST_LINE_CIU
					prop_settings = 'SettingsLine';
				case ComparisonGroupPF.LISTENER_ST_LINE_CIU
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.H_TITLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.ST_TITLE
					prop_settings = 'SettingsText';
				case ComparisonGroupPF.H_XLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.ST_XLABEL
					prop_settings = 'SettingsText';
				case ComparisonGroupPF.H_YLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case ComparisonGroupPF.ST_YLABEL
					prop_settings = 'SettingsText';
				case ComparisonGroupPF.TEMPLATE
					prop_settings = 'ComparisonGroupPF';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonGroupPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonGroupPF, POINTER) returns the default value of POINTER of ComparisonGroupPF.
			%  DEFAULT = PF.GETPROPDEFAULT(ComparisonGroupPF, POINTER) returns the default value of POINTER of ComparisonGroupPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonGroupPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF.H_AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case ComparisonGroupPF.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.CP
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_AREA
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_AREA
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.LISTENER_ST_AREA
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_LINE_DIFF
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_LINE_DIFF
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.LISTENER_ST_LINE_DIFF
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_LINE_CIL
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_LINE_CIL
					prop_default = SettingsLine('SYMBOLSIZE', 6, 'FACECOLOR', [.5 .5 .5]);
				case ComparisonGroupPF.LISTENER_ST_LINE_CIL
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_LINE_CIU
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_LINE_CIU
					prop_default = SettingsLine('SYMBOLSIZE', 6, 'FACECOLOR', [.5 .5 .5]);
				case ComparisonGroupPF.LISTENER_ST_LINE_CIU
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_TITLE
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_TITLE
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case ComparisonGroupPF.H_XLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_XLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case ComparisonGroupPF.H_YLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_YLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90);
				case ComparisonGroupPF.ELCLASS
					prop_default = 'ComparisonGroupPF';
				case ComparisonGroupPF.NAME
					prop_default = 'ComparisonGroupPF';
				case ComparisonGroupPF.DESCRIPTION
					prop_default = 'ComparisonGroupPF manages the basic functionalities to plot of a group comparison.';
				case ComparisonGroupPF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ID
					prop_default = 'ComparisonGroupPF ID';
				case ComparisonGroupPF.LABEL
					prop_default = 'ComparisonGroupPF label';
				case ComparisonGroupPF.NOTES
					prop_default = 'ComparisonGroupPF notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonGroupPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonGroupPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonGroupPF, POINTER) returns the conditioned default value of POINTER of ComparisonGroupPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(ComparisonGroupPF, POINTER) returns the conditioned default value of POINTER of ComparisonGroupPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonGroupPF.getPropProp(pointer);
			
			prop_default = ComparisonGroupPF.conditioning(prop, ComparisonGroupPF.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonGroupPF, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupPF.
			%  CHECK = PF.CHECKPROP(ComparisonGroupPF, PROP, VALUE) checks VALUE format for PROP of ComparisonGroupPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:ComparisonGroupPF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:ComparisonGroupPF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(ComparisonGroupPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupPF.
			%   Error id: €BRAPH2.STR€:ComparisonGroupPF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(ComparisonGroupPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonGroupPF.
			%   Error id: €BRAPH2.STR€:ComparisonGroupPF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('ComparisonGroupPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonGroupPF.getPropProp(pointer);
			
			switch prop
				case ComparisonGroupPF.H_AXES % __ComparisonGroupPF.H_AXES__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_AXIS % __ComparisonGroupPF.ST_AXIS__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.LISTENER_ST_AXIS % __ComparisonGroupPF.LISTENER_ST_AXIS__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.CP % __ComparisonGroupPF.CP__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.SETUP % __ComparisonGroupPF.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_AREA % __ComparisonGroupPF.H_AREA__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_AREA % __ComparisonGroupPF.ST_AREA__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.LISTENER_ST_AREA % __ComparisonGroupPF.LISTENER_ST_AREA__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_LINE_DIFF % __ComparisonGroupPF.H_LINE_DIFF__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_LINE_DIFF % __ComparisonGroupPF.ST_LINE_DIFF__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.LISTENER_ST_LINE_DIFF % __ComparisonGroupPF.LISTENER_ST_LINE_DIFF__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_LINE_CIL % __ComparisonGroupPF.H_LINE_CIL__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_LINE_CIL % __ComparisonGroupPF.ST_LINE_CIL__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.LISTENER_ST_LINE_CIL % __ComparisonGroupPF.LISTENER_ST_LINE_CIL__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_LINE_CIU % __ComparisonGroupPF.H_LINE_CIU__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_LINE_CIU % __ComparisonGroupPF.ST_LINE_CIU__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.LISTENER_ST_LINE_CIU % __ComparisonGroupPF.LISTENER_ST_LINE_CIU__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_TITLE % __ComparisonGroupPF.H_TITLE__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_TITLE % __ComparisonGroupPF.ST_TITLE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_XLABEL % __ComparisonGroupPF.H_XLABEL__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_XLABEL % __ComparisonGroupPF.ST_XLABEL__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.H_YLABEL % __ComparisonGroupPF.H_YLABEL__
					check = Format.checkFormat(Format.HANDLE, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.ST_YLABEL % __ComparisonGroupPF.ST_YLABEL__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF.getPropSettings(prop));
				case ComparisonGroupPF.TEMPLATE % __ComparisonGroupPF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, ComparisonGroupPF.getPropSettings(prop));
				otherwise
					if prop <= PanelFig.getPropNumber()
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':ComparisonGroupPF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ComparisonGroupPF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonGroupPF.getPropTag(prop) ' (' ComparisonGroupPF.getFormatTag(ComparisonGroupPF.getPropFormat(prop)) ').'] ...
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
				case ComparisonGroupPF.ST_AXIS % __ComparisonGroupPF.ST_AXIS__
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
				case ComparisonGroupPF.H_AXES % __ComparisonGroupPF.H_AXES__
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
					
				case ComparisonGroupPF.LISTENER_ST_AXIS % __ComparisonGroupPF.LISTENER_ST_AXIS__
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case ComparisonGroupPF.SETUP % __ComparisonGroupPF.SETUP__
					value = [];
					
				case ComparisonGroupPF.H_AREA % __ComparisonGroupPF.H_AREA__
					value = fill(pf.get('H_AXES'), [0], [0], 'k');
					
				case ComparisonGroupPF.LISTENER_ST_AREA % __ComparisonGroupPF.LISTENER_ST_AREA__
					value = listener(pf.get('ST_AREA'), 'PropSet', @cb_listener_st_area);
					
				case ComparisonGroupPF.H_LINE_DIFF % __ComparisonGroupPF.H_LINE_DIFF__
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case ComparisonGroupPF.LISTENER_ST_LINE_DIFF % __ComparisonGroupPF.LISTENER_ST_LINE_DIFF__
					value = listener(pf.get('ST_LINE_DIFF'), 'PropSet', @cb_listener_st_line_diff);
					
				case ComparisonGroupPF.H_LINE_CIL % __ComparisonGroupPF.H_LINE_CIL__
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case ComparisonGroupPF.LISTENER_ST_LINE_CIL % __ComparisonGroupPF.LISTENER_ST_LINE_CIL__
					value = listener(pf.get('ST_LINE_DIFF'), 'PropSet', @cb_listener_st_line_cil);
					
				case ComparisonGroupPF.H_LINE_CIU % __ComparisonGroupPF.H_LINE_CIU__
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case ComparisonGroupPF.LISTENER_ST_LINE_CIU % __ComparisonGroupPF.LISTENER_ST_LINE_CIU__
					value = listener(pf.get('ST_LINE_CIU'), 'PropSet', @cb_listener_st_line_ciu);
					
				case ComparisonGroupPF.H_TITLE % __ComparisonGroupPF.H_TITLE__
					value = title(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_TITLE'), 'NoValue')
					    st = pf.memorize('ST_TITLE');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', pf.get('CP').get('LABEL'), ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case ComparisonGroupPF.H_XLABEL % __ComparisonGroupPF.H_XLABEL__
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
					
				case ComparisonGroupPF.H_YLABEL % __ComparisonGroupPF.H_YLABEL__
					value = ylabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_YLABEL'), 'NoValue')
					    st = pf.memorize('ST_YLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Difference', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case ComparisonGroupPF.DRAW % __ComparisonGroupPF.DRAW__
					value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					    
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', ComparisonGroupPF.H_AXES).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('H_AREA')
					    pf.memorize('ST_AREA').set('PANEL', pf, 'PROP', ComparisonGroupPF.H_AREA).get('SETUP')
					    pf.memorize('LISTENER_ST_AREA');
					
					    pf.memorize('H_LINE_DIFF')
					    pf.memorize('ST_LINE_DIFF').set('PANEL', pf, 'PROP', ComparisonGroupPF.H_LINE_DIFF).get('SETUP')
						pf.memorize('LISTENER_ST_LINE_DIFF');
					    
					    pf.memorize('H_LINE_CIL')
					    pf.memorize('ST_LINE_CIL').set('PANEL', pf, 'PROP', ComparisonGroupPF.H_LINE_CIL).get('SETUP')
						pf.memorize('LISTENER_ST_LINE_CIL');
					
					    pf.memorize('H_LINE_CIU')
					    pf.memorize('ST_LINE_CIU').set('PANEL', pf, 'PROP', ComparisonGroupPF.H_LINE_CIU).get('SETUP')
						pf.memorize('LISTENER_ST_LINE_CIU');
					
					    pf.memorize('H_TITLE')
					    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', ComparisonGroupPF.H_TITLE).get('SETUP')
					
					    pf.memorize('H_XLABEL')
					    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', ComparisonGroupPF.H_XLABEL).get('SETUP')
					    
					    pf.memorize('H_YLABEL')
					    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', ComparisonGroupPF.H_YLABEL).get('SETUP')
					
					    pf.get('SETUP')
					end
					
				case ComparisonGroupPF.DELETE % __ComparisonGroupPF.DELETE__
					value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					    
					    pf.set('H_AREA', Element.getNoValue())
					    pf.set('LISTENER_ST_AREA', Element.getNoValue())
					 
					    pf.set('H_LINE_DIFF', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE_DIFF', Element.getNoValue())
					
					    pf.set('H_LINE_CIL', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE_CIL', Element.getNoValue())
					
					    pf.set('H_LINE_CIU', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE_CIU', Element.getNoValue())
					
					    pf.set('H_TITLE', Element.getNoValue())
					
					    pf.set('H_XLABEL', Element.getNoValue())
					    
					    pf.set('H_YLABEL', Element.getNoValue())
					end
					
				case ComparisonGroupPF.H_TOOLS % __ComparisonGroupPF.H_TOOLS__
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
					    
					    % Difference Line
					    tool_line_diff = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Line_Diff', ...
					        'State', pf.get('ST_LINE_DIFF').get('VISIBLE'), ...
					        'Tooltip', 'Show difference line', ...
					        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % make icon 16x16
					        'OnCallback', {@cb_line_diff, true}, ...
					        'OffCallback', {@cb_line_diff, false});
					
					    % Difference Line
					    tool_line_ci = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Line_CI', ...
					        'State', pf.get('ST_LINE_DIFF').get('VISIBLE'), ...
					        'Tooltip', 'Show confidence lines (95%)', ...
					        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % imread('icon_lines_two.png'), ...
					        'OnCallback', {@cb_line_ci, true}, ...
					        'OffCallback', {@cb_line_ci, false});
					    
					    % Confidence Area
					    tool_area = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Area', ...
					        'State', pf.get('ST_AREA').get('VISIBLE'), ...
					        'Tooltip', 'Show confidence area (95%)', ...
					        'CData', imresize(imread('icon_area.png'), [24 24]), ... % % % make icon 16x16
					        'OnCallback', {@cb_area, true}, ...
					        'OffCallback', {@cb_area, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ... 
					        tool_separator_2, ... 
					        tool_line_diff, tool_line_ci, tool_area ...
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
			function cb_listener_st_line_diff(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Line_DIff'), 'State', pf.get('ST_LINE_DIFF').get('VISIBLE'))
			        end
			    end
			end
			function cb_listener_st_line_cil(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Line_CI'), 'State', pf.get('ST_LINE_CIL').get('VISIBLE'))
			        end
			    end
			end
			function cb_listener_st_line_ciu(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Line_CI'), 'State', pf.get('ST_LINE_CIU').get('VISIBLE'))
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
			function cb_line_diff(~, ~, visible) % (src, event)
				pf.get('ST_LINE_DIFF').set('VISIBLE', visible)
			
			    % triggers the update of ST_LINE_DIFF
			    pf.set('ST_LINE_DIFF', pf.get('ST_LINE_DIFF'))
			end
			function cb_line_ci(~, ~, visible) % (src, event)
				pf.get('ST_LINE_CIL').set('VISIBLE', visible)
				pf.get('ST_LINE_CIU').set('VISIBLE', visible)
			
			    % triggers the update of ST_LINE_CIL and ST_LINE_CIU
			    pf.set('ST_LINE_CIL', pf.get('ST_LINE_CIL'))
			    pf.set('ST_LINE_CIU', pf.get('ST_LINE_CIU'))
			end
			function cb_area(~, ~, visible) % (src, event)
			    pf.get('ST_AREA').set('VISIBLE', visible)
			
			    % triggers the update of ST_AREA
			    pf.set('ST_AREA', pf.get('ST_AREA'))
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
				case ComparisonGroupPF.ST_AXIS % __ComparisonGroupPF.ST_AXIS__
					pr = SettingsAxisPP('EL', pf, 'PROP', ComparisonGroupPF.ST_AXIS, varargin{:});
					
				case ComparisonGroupPF.ST_AREA % __ComparisonGroupPF.ST_AREA__
					pr = SettingsAreaPP('EL', pf, 'PROP', ComparisonGroupPF.ST_AREA, varargin{:});
					
				case ComparisonGroupPF.ST_LINE_DIFF % __ComparisonGroupPF.ST_LINE_DIFF__
					pr = SettingsLinePP('EL', pf, 'PROP', ComparisonGroupPF.ST_LINE_DIFF, varargin{:});
					
				case ComparisonGroupPF.ST_LINE_CIL % __ComparisonGroupPF.ST_LINE_CIL__
					pr = SettingsLinePP('EL', pf, 'PROP', ComparisonGroupPF.ST_LINE_CIL, varargin{:});
					
				case ComparisonGroupPF.ST_LINE_CIU % __ComparisonGroupPF.ST_LINE_CIU__
					pr = SettingsLinePP('EL', pf, 'PROP', ComparisonGroupPF.ST_LINE_CIU, varargin{:});
					
				case ComparisonGroupPF.ST_TITLE % __ComparisonGroupPF.ST_TITLE__
					pr = SettingsTextPP('EL', pf, 'PROP', ComparisonGroupPF.ST_TITLE, varargin{:});
					
				case ComparisonGroupPF.ST_XLABEL % __ComparisonGroupPF.ST_XLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', ComparisonGroupPF.ST_XLABEL, varargin{:});
					
				case ComparisonGroupPF.ST_YLABEL % __ComparisonGroupPF.ST_YLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', ComparisonGroupPF.ST_YLABEL, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
