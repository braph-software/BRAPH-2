classdef MeasureEnsemblePF < PanelFig
	%MeasureEnsemblePF is the base element to plot an ensemble-based comparison.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% MeasureEnsemblePF manages the basic functionalities to plot of an ensemble-based comparison.
	%
	% MeasureEnsemblePF methods (constructor):
	%  MeasureEnsemblePF - constructor
	%
	% MeasureEnsemblePF methods:
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
	% MeasureEnsemblePF methods (display):
	%  tostring - string with information about the panel ensemble-based comparison figure
	%  disp - displays information about the panel ensemble-based comparison figure
	%  tree - displays the tree of the panel ensemble-based comparison figure
	%
	% MeasureEnsemblePF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel ensemble-based comparison figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel ensemble-based comparison figure
	%
	% MeasureEnsemblePF methods (save/load, Static):
	%  save - saves BRAPH2 panel ensemble-based comparison figure as b2 file
	%  load - loads a BRAPH2 panel ensemble-based comparison figure from a b2 file
	%
	% MeasureEnsemblePF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel ensemble-based comparison figure
	%
	% MeasureEnsemblePF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel ensemble-based comparison figure
	%
	% MeasureEnsemblePF methods (inspection, Static):
	%  getClass - returns the class of the panel ensemble-based comparison figure
	%  getSubclasses - returns all subclasses of MeasureEnsemblePF
	%  getProps - returns the property list of the panel ensemble-based comparison figure
	%  getPropNumber - returns the property number of the panel ensemble-based comparison figure
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
	% MeasureEnsemblePF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureEnsemblePF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureEnsemblePF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureEnsemblePF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureEnsemblePF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureEnsemblePF constants</a>.
	%
	%
	% See also MeasureEnsemble.
	
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
		
		ME = PanelFig.getPropNumber() + 4;
		ME_TAG = 'ME';
		ME_CATEGORY = Category.METADATA;
		ME_FORMAT = Format.ITEM;
		
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
		
		H_LINE_M = PanelFig.getPropNumber() + 9;
		H_LINE_M_TAG = 'H_LINE_M';
		H_LINE_M_CATEGORY = Category.EVANESCENT;
		H_LINE_M_FORMAT = Format.HANDLE;
		
		ST_LINE_M = PanelFig.getPropNumber() + 10;
		ST_LINE_M_TAG = 'ST_LINE_M';
		ST_LINE_M_CATEGORY = Category.FIGURE;
		ST_LINE_M_FORMAT = Format.ITEM;
		
		LISTENER_ST_LINE_M = PanelFig.getPropNumber() + 11;
		LISTENER_ST_LINE_M_TAG = 'LISTENER_ST_LINE_M';
		LISTENER_ST_LINE_M_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_LINE_M_FORMAT = Format.HANDLE;
		
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
		function pf = MeasureEnsemblePF(varargin)
			%MeasureEnsemblePF() creates a panel ensemble-based comparison figure.
			%
			% MeasureEnsemblePF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureEnsemblePF(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel ensemble-based comparison figure.
			%
			% CLASS = MeasureEnsemblePF.GETCLASS() returns the class 'MeasureEnsemblePF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel ensemble-based comparison figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasureEnsemblePF') returns 'MeasureEnsemblePF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasureEnsemblePF')
			%  are less computationally efficient.
			
			pf_class = 'MeasureEnsemblePF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel ensemble-based comparison figure.
			%
			% LIST = MeasureEnsemblePF.GETSUBCLASSES() returns all subclasses of 'MeasureEnsemblePF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel ensemble-based comparison figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasureEnsemblePF') returns all subclasses of 'MeasureEnsemblePF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasureEnsemblePF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel ensemble-based comparison figure.
			%
			% PROPS = MeasureEnsemblePF.GETPROPS() returns the property list of panel ensemble-based comparison figure
			%  as a row vector.
			%
			% PROPS = MeasureEnsemblePF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel ensemble-based comparison figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasureEnsemblePF'[, CATEGORY]) returns the property list of 'MeasureEnsemblePF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelFig.getProps() ...
						MeasureEnsemblePF.H_AXES ...
						MeasureEnsemblePF.ST_AXIS ...
						MeasureEnsemblePF.LISTENER_ST_AXIS ...
						MeasureEnsemblePF.ME ...
						MeasureEnsemblePF.SETUP ...
						MeasureEnsemblePF.H_AREA ...
						MeasureEnsemblePF.ST_AREA ...
						MeasureEnsemblePF.LISTENER_ST_AREA ...
						MeasureEnsemblePF.H_LINE_M ...
						MeasureEnsemblePF.ST_LINE_M ...
						MeasureEnsemblePF.LISTENER_ST_LINE_M ...
						MeasureEnsemblePF.H_TITLE ...
						MeasureEnsemblePF.ST_TITLE ...
						MeasureEnsemblePF.H_XLABEL ...
						MeasureEnsemblePF.ST_XLABEL ...
						MeasureEnsemblePF.H_YLABEL ...
						MeasureEnsemblePF.ST_YLABEL ...
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
						MeasureEnsemblePF.ME ...
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
						MeasureEnsemblePF.SETUP ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelFig.getProps(Category.EVANESCENT) ...
						MeasureEnsemblePF.H_AXES ...
						MeasureEnsemblePF.LISTENER_ST_AXIS ...
						MeasureEnsemblePF.H_AREA ...
						MeasureEnsemblePF.LISTENER_ST_AREA ...
						MeasureEnsemblePF.H_LINE_M ...
						MeasureEnsemblePF.LISTENER_ST_LINE_M ...
						MeasureEnsemblePF.H_TITLE ...
						MeasureEnsemblePF.H_XLABEL ...
						MeasureEnsemblePF.H_YLABEL ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelFig.getProps(Category.FIGURE) ...
						MeasureEnsemblePF.ST_AXIS ...
						MeasureEnsemblePF.ST_AREA ...
						MeasureEnsemblePF.ST_LINE_M ...
						MeasureEnsemblePF.ST_TITLE ...
						MeasureEnsemblePF.ST_XLABEL ...
						MeasureEnsemblePF.ST_YLABEL ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelFig.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel ensemble-based comparison figure.
			%
			% N = MeasureEnsemblePF.GETPROPNUMBER() returns the property number of panel ensemble-based comparison figure.
			%
			% N = MeasureEnsemblePF.GETPROPNUMBER(CATEGORY) returns the property number of panel ensemble-based comparison figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel ensemble-based comparison figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasureEnsemblePF') returns the property number of 'MeasureEnsemblePF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasureEnsemblePF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel ensemble-based comparison figure/error.
			%
			% CHECK = MeasureEnsemblePF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasureEnsemblePF, PROP) checks whether PROP exists for MeasureEnsemblePF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemblePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF:WrongInput]
			%  Element.EXISTSPROP(MeasureEnsemblePF, PROP) throws error if PROP does NOT exist for MeasureEnsemblePF.
			%   Error id: [BRAPH2:MeasureEnsemblePF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasureEnsemblePF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsemblePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemblePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureEnsemblePF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel ensemble-based comparison figure/error.
			%
			% CHECK = MeasureEnsemblePF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasureEnsemblePF, TAG) checks whether TAG exists for MeasureEnsemblePF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsemblePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsemblePF:WrongInput]
			%  Element.EXISTSTAG(MeasureEnsemblePF, TAG) throws error if TAG does NOT exist for MeasureEnsemblePF.
			%   Error id: [BRAPH2:MeasureEnsemblePF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measureensemblepf_tag_list = cellfun(@(x) MeasureEnsemblePF.getPropTag(x), num2cell(MeasureEnsemblePF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measureensemblepf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsemblePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemblePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasureEnsemblePF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureEnsemblePF, POINTER) returns property number of POINTER of MeasureEnsemblePF.
			%  PROPERTY = PF.GETPROPPROP(MeasureEnsemblePF, POINTER) returns property number of POINTER of MeasureEnsemblePF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measureensemblepf_tag_list = cellfun(@(x) MeasureEnsemblePF.getPropTag(x), num2cell(MeasureEnsemblePF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measureensemblepf_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasureEnsemblePF, POINTER) returns tag of POINTER of MeasureEnsemblePF.
			%  TAG = PF.GETPROPTAG(MeasureEnsemblePF, POINTER) returns tag of POINTER of MeasureEnsemblePF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case MeasureEnsemblePF.H_AXES
						tag = MeasureEnsemblePF.H_AXES_TAG;
					case MeasureEnsemblePF.ST_AXIS
						tag = MeasureEnsemblePF.ST_AXIS_TAG;
					case MeasureEnsemblePF.LISTENER_ST_AXIS
						tag = MeasureEnsemblePF.LISTENER_ST_AXIS_TAG;
					case MeasureEnsemblePF.ME
						tag = MeasureEnsemblePF.ME_TAG;
					case MeasureEnsemblePF.SETUP
						tag = MeasureEnsemblePF.SETUP_TAG;
					case MeasureEnsemblePF.H_AREA
						tag = MeasureEnsemblePF.H_AREA_TAG;
					case MeasureEnsemblePF.ST_AREA
						tag = MeasureEnsemblePF.ST_AREA_TAG;
					case MeasureEnsemblePF.LISTENER_ST_AREA
						tag = MeasureEnsemblePF.LISTENER_ST_AREA_TAG;
					case MeasureEnsemblePF.H_LINE_M
						tag = MeasureEnsemblePF.H_LINE_M_TAG;
					case MeasureEnsemblePF.ST_LINE_M
						tag = MeasureEnsemblePF.ST_LINE_M_TAG;
					case MeasureEnsemblePF.LISTENER_ST_LINE_M
						tag = MeasureEnsemblePF.LISTENER_ST_LINE_M_TAG;
					case MeasureEnsemblePF.H_TITLE
						tag = MeasureEnsemblePF.H_TITLE_TAG;
					case MeasureEnsemblePF.ST_TITLE
						tag = MeasureEnsemblePF.ST_TITLE_TAG;
					case MeasureEnsemblePF.H_XLABEL
						tag = MeasureEnsemblePF.H_XLABEL_TAG;
					case MeasureEnsemblePF.ST_XLABEL
						tag = MeasureEnsemblePF.ST_XLABEL_TAG;
					case MeasureEnsemblePF.H_YLABEL
						tag = MeasureEnsemblePF.H_YLABEL_TAG;
					case MeasureEnsemblePF.ST_YLABEL
						tag = MeasureEnsemblePF.ST_YLABEL_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureEnsemblePF, POINTER) returns category of POINTER of MeasureEnsemblePF.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasureEnsemblePF, POINTER) returns category of POINTER of MeasureEnsemblePF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF.H_AXES
					prop_category = MeasureEnsemblePF.H_AXES_CATEGORY;
				case MeasureEnsemblePF.ST_AXIS
					prop_category = MeasureEnsemblePF.ST_AXIS_CATEGORY;
				case MeasureEnsemblePF.LISTENER_ST_AXIS
					prop_category = MeasureEnsemblePF.LISTENER_ST_AXIS_CATEGORY;
				case MeasureEnsemblePF.ME
					prop_category = MeasureEnsemblePF.ME_CATEGORY;
				case MeasureEnsemblePF.SETUP
					prop_category = MeasureEnsemblePF.SETUP_CATEGORY;
				case MeasureEnsemblePF.H_AREA
					prop_category = MeasureEnsemblePF.H_AREA_CATEGORY;
				case MeasureEnsemblePF.ST_AREA
					prop_category = MeasureEnsemblePF.ST_AREA_CATEGORY;
				case MeasureEnsemblePF.LISTENER_ST_AREA
					prop_category = MeasureEnsemblePF.LISTENER_ST_AREA_CATEGORY;
				case MeasureEnsemblePF.H_LINE_M
					prop_category = MeasureEnsemblePF.H_LINE_M_CATEGORY;
				case MeasureEnsemblePF.ST_LINE_M
					prop_category = MeasureEnsemblePF.ST_LINE_M_CATEGORY;
				case MeasureEnsemblePF.LISTENER_ST_LINE_M
					prop_category = MeasureEnsemblePF.LISTENER_ST_LINE_M_CATEGORY;
				case MeasureEnsemblePF.H_TITLE
					prop_category = MeasureEnsemblePF.H_TITLE_CATEGORY;
				case MeasureEnsemblePF.ST_TITLE
					prop_category = MeasureEnsemblePF.ST_TITLE_CATEGORY;
				case MeasureEnsemblePF.H_XLABEL
					prop_category = MeasureEnsemblePF.H_XLABEL_CATEGORY;
				case MeasureEnsemblePF.ST_XLABEL
					prop_category = MeasureEnsemblePF.ST_XLABEL_CATEGORY;
				case MeasureEnsemblePF.H_YLABEL
					prop_category = MeasureEnsemblePF.H_YLABEL_CATEGORY;
				case MeasureEnsemblePF.ST_YLABEL
					prop_category = MeasureEnsemblePF.ST_YLABEL_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureEnsemblePF, POINTER) returns format of POINTER of MeasureEnsemblePF.
			%  FORMAT = PF.GETPROPFORMAT(MeasureEnsemblePF, POINTER) returns format of POINTER of MeasureEnsemblePF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF.H_AXES
					prop_format = MeasureEnsemblePF.H_AXES_FORMAT;
				case MeasureEnsemblePF.ST_AXIS
					prop_format = MeasureEnsemblePF.ST_AXIS_FORMAT;
				case MeasureEnsemblePF.LISTENER_ST_AXIS
					prop_format = MeasureEnsemblePF.LISTENER_ST_AXIS_FORMAT;
				case MeasureEnsemblePF.ME
					prop_format = MeasureEnsemblePF.ME_FORMAT;
				case MeasureEnsemblePF.SETUP
					prop_format = MeasureEnsemblePF.SETUP_FORMAT;
				case MeasureEnsemblePF.H_AREA
					prop_format = MeasureEnsemblePF.H_AREA_FORMAT;
				case MeasureEnsemblePF.ST_AREA
					prop_format = MeasureEnsemblePF.ST_AREA_FORMAT;
				case MeasureEnsemblePF.LISTENER_ST_AREA
					prop_format = MeasureEnsemblePF.LISTENER_ST_AREA_FORMAT;
				case MeasureEnsemblePF.H_LINE_M
					prop_format = MeasureEnsemblePF.H_LINE_M_FORMAT;
				case MeasureEnsemblePF.ST_LINE_M
					prop_format = MeasureEnsemblePF.ST_LINE_M_FORMAT;
				case MeasureEnsemblePF.LISTENER_ST_LINE_M
					prop_format = MeasureEnsemblePF.LISTENER_ST_LINE_M_FORMAT;
				case MeasureEnsemblePF.H_TITLE
					prop_format = MeasureEnsemblePF.H_TITLE_FORMAT;
				case MeasureEnsemblePF.ST_TITLE
					prop_format = MeasureEnsemblePF.ST_TITLE_FORMAT;
				case MeasureEnsemblePF.H_XLABEL
					prop_format = MeasureEnsemblePF.H_XLABEL_FORMAT;
				case MeasureEnsemblePF.ST_XLABEL
					prop_format = MeasureEnsemblePF.ST_XLABEL_FORMAT;
				case MeasureEnsemblePF.H_YLABEL
					prop_format = MeasureEnsemblePF.H_YLABEL_FORMAT;
				case MeasureEnsemblePF.ST_YLABEL
					prop_format = MeasureEnsemblePF.ST_YLABEL_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureEnsemblePF, POINTER) returns description of POINTER of MeasureEnsemblePF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasureEnsemblePF, POINTER) returns description of POINTER of MeasureEnsemblePF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF.H_AXES
					prop_description = 'H_AXES (evanescent, handle) is the handle for the axes.';
				case MeasureEnsemblePF.ST_AXIS
					prop_description = 'ST_AXIS (figure, item) determines the axis settings.';
				case MeasureEnsemblePF.LISTENER_ST_AXIS
					prop_description = 'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.';
				case MeasureEnsemblePF.ME
					prop_description = 'ME (metadata, item) is the ensemble-based comparison.';
				case MeasureEnsemblePF.SETUP
					prop_description = 'SETUP (query, empty) calculates the ensemble-based comparison value and stores it to be implemented in the subelements.';
				case MeasureEnsemblePF.H_AREA
					prop_description = 'H_AREA (evanescent, handle) is the handle for the ensemble-based comparison confidence area.';
				case MeasureEnsemblePF.ST_AREA
					prop_description = 'ST_AREA (figure, item) determines the area settings.';
				case MeasureEnsemblePF.LISTENER_ST_AREA
					prop_description = 'LISTENER_ST_AREA (evanescent, handle) contains the listener to the measure area settings to update the pushbutton.';
				case MeasureEnsemblePF.H_LINE_M
					prop_description = 'H_LINE_M (evanescent, handle) is the handle for the ensemble-based comparison line.';
				case MeasureEnsemblePF.ST_LINE_M
					prop_description = 'ST_LINE_M (figure, item) determines the line settings.';
				case MeasureEnsemblePF.LISTENER_ST_LINE_M
					prop_description = 'LISTENER_ST_LINE_M (evanescent, handle) contains the listener to the measure line settings to update the pushbutton.';
				case MeasureEnsemblePF.H_TITLE
					prop_description = 'H_TITLE (evanescent, handle) is the axis title.';
				case MeasureEnsemblePF.ST_TITLE
					prop_description = 'ST_TITLE (figure, item) determines the title settings.';
				case MeasureEnsemblePF.H_XLABEL
					prop_description = 'H_XLABEL (evanescent, handle) is the axis x-label.';
				case MeasureEnsemblePF.ST_XLABEL
					prop_description = 'ST_XLABEL (figure, item) determines the x-label settings.';
				case MeasureEnsemblePF.H_YLABEL
					prop_description = 'H_YLABEL (evanescent, handle) is the axis y-label.';
				case MeasureEnsemblePF.ST_YLABEL
					prop_description = 'ST_YLABEL (figure, item) determines the y-label settings.';
				case MeasureEnsemblePF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case MeasureEnsemblePF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel ensemble-based comparison figure.';
				case MeasureEnsemblePF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure.';
				case MeasureEnsemblePF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure.';
				case MeasureEnsemblePF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel ensemble-based comparison figure.';
				case MeasureEnsemblePF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure.';
				case MeasureEnsemblePF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure.';
				case MeasureEnsemblePF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure comparison figure.';
				case MeasureEnsemblePF.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure graph is deleted.';
				case MeasureEnsemblePF.H_TOOLS
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureEnsemblePF, POINTER) returns settings of POINTER of MeasureEnsemblePF.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasureEnsemblePF, POINTER) returns settings of POINTER of MeasureEnsemblePF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsemblePF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF.H_AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasureEnsemblePF.ST_AXIS
					prop_settings = 'SettingsAxis';
				case MeasureEnsemblePF.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasureEnsemblePF.ME
					prop_settings = 'MeasureEnsemble';
				case MeasureEnsemblePF.SETUP
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case MeasureEnsemblePF.H_AREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasureEnsemblePF.ST_AREA
					prop_settings = 'SettingsArea';
				case MeasureEnsemblePF.LISTENER_ST_AREA
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasureEnsemblePF.H_LINE_M
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasureEnsemblePF.ST_LINE_M
					prop_settings = 'SettingsLine';
				case MeasureEnsemblePF.LISTENER_ST_LINE_M
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasureEnsemblePF.H_TITLE
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasureEnsemblePF.ST_TITLE
					prop_settings = 'SettingsText';
				case MeasureEnsemblePF.H_XLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasureEnsemblePF.ST_XLABEL
					prop_settings = 'SettingsText';
				case MeasureEnsemblePF.H_YLABEL
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case MeasureEnsemblePF.ST_YLABEL
					prop_settings = 'SettingsText';
				case MeasureEnsemblePF.TEMPLATE
					prop_settings = 'MeasureEnsemblePF';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureEnsemblePF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemblePF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureEnsemblePF, POINTER) returns the default value of POINTER of MeasureEnsemblePF.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasureEnsemblePF, POINTER) returns the default value of POINTER of MeasureEnsemblePF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsemblePF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF.H_AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case MeasureEnsemblePF.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ME
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.SETUP
					prop_default = Format.getFormatDefault(Format.EMPTY, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.H_AREA
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_AREA
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.LISTENER_ST_AREA
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.H_LINE_M
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_LINE_M
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.LISTENER_ST_LINE_M
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.H_TITLE
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_TITLE
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case MeasureEnsemblePF.H_XLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_XLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle');
				case MeasureEnsemblePF.H_YLABEL
					prop_default = Format.getFormatDefault(Format.HANDLE, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_YLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', s(2), 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90);
				case MeasureEnsemblePF.ELCLASS
					prop_default = 'MeasureEnsemblePF';
				case MeasureEnsemblePF.NAME
					prop_default = 'MeasureEnsemblePF';
				case MeasureEnsemblePF.DESCRIPTION
					prop_default = 'MeasureEnsemblePF manages the basic functionalities to plot of an ensemble-based comparison.';
				case MeasureEnsemblePF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ID
					prop_default = 'MeasureEnsemblePF ID';
				case MeasureEnsemblePF.LABEL
					prop_default = 'MeasureEnsemblePF label';
				case MeasureEnsemblePF.NOTES
					prop_default = 'MeasureEnsemblePF notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureEnsemblePF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsemblePF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureEnsemblePF, POINTER) returns the conditioned default value of POINTER of MeasureEnsemblePF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasureEnsemblePF, POINTER) returns the conditioned default value of POINTER of MeasureEnsemblePF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureEnsemblePF.getPropProp(pointer);
			
			prop_default = MeasureEnsemblePF.conditioning(prop, MeasureEnsemblePF.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureEnsemblePF, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemblePF.
			%  CHECK = PF.CHECKPROP(MeasureEnsemblePF, PROP, VALUE) checks VALUE format for PROP of MeasureEnsemblePF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasureEnsemblePF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasureEnsemblePF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasureEnsemblePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemblePF.
			%   Error id: €BRAPH2.STR€:MeasureEnsemblePF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasureEnsemblePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsemblePF.
			%   Error id: €BRAPH2.STR€:MeasureEnsemblePF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasureEnsemblePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureEnsemblePF.getPropProp(pointer);
			
			switch prop
				case MeasureEnsemblePF.H_AXES % __MeasureEnsemblePF.H_AXES__
					check = Format.checkFormat(Format.HANDLE, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_AXIS % __MeasureEnsemblePF.ST_AXIS__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.LISTENER_ST_AXIS % __MeasureEnsemblePF.LISTENER_ST_AXIS__
					check = Format.checkFormat(Format.HANDLE, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ME % __MeasureEnsemblePF.ME__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.SETUP % __MeasureEnsemblePF.SETUP__
					check = Format.checkFormat(Format.EMPTY, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.H_AREA % __MeasureEnsemblePF.H_AREA__
					check = Format.checkFormat(Format.HANDLE, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_AREA % __MeasureEnsemblePF.ST_AREA__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.LISTENER_ST_AREA % __MeasureEnsemblePF.LISTENER_ST_AREA__
					check = Format.checkFormat(Format.HANDLE, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.H_LINE_M % __MeasureEnsemblePF.H_LINE_M__
					check = Format.checkFormat(Format.HANDLE, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_LINE_M % __MeasureEnsemblePF.ST_LINE_M__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.LISTENER_ST_LINE_M % __MeasureEnsemblePF.LISTENER_ST_LINE_M__
					check = Format.checkFormat(Format.HANDLE, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.H_TITLE % __MeasureEnsemblePF.H_TITLE__
					check = Format.checkFormat(Format.HANDLE, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_TITLE % __MeasureEnsemblePF.ST_TITLE__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.H_XLABEL % __MeasureEnsemblePF.H_XLABEL__
					check = Format.checkFormat(Format.HANDLE, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_XLABEL % __MeasureEnsemblePF.ST_XLABEL__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.H_YLABEL % __MeasureEnsemblePF.H_YLABEL__
					check = Format.checkFormat(Format.HANDLE, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.ST_YLABEL % __MeasureEnsemblePF.ST_YLABEL__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemblePF.getPropSettings(prop));
				case MeasureEnsemblePF.TEMPLATE % __MeasureEnsemblePF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsemblePF.getPropSettings(prop));
				otherwise
					if prop <= PanelFig.getPropNumber()
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsemblePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsemblePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureEnsemblePF.getPropTag(prop) ' (' MeasureEnsemblePF.getFormatTag(MeasureEnsemblePF.getPropFormat(prop)) ').'] ...
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
				case MeasureEnsemblePF.ST_AXIS % __MeasureEnsemblePF.ST_AXIS__
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
				case MeasureEnsemblePF.H_AXES % __MeasureEnsemblePF.H_AXES__
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
					
				case MeasureEnsemblePF.LISTENER_ST_AXIS % __MeasureEnsemblePF.LISTENER_ST_AXIS__
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case MeasureEnsemblePF.SETUP % __MeasureEnsemblePF.SETUP__
					value = [];
					
				case MeasureEnsemblePF.H_AREA % __MeasureEnsemblePF.H_AREA__
					value = fill(pf.get('H_AXES'), [0], [0], 'k');
					
				case MeasureEnsemblePF.LISTENER_ST_AREA % __MeasureEnsemblePF.LISTENER_ST_AREA__
					value = listener(pf.get('ST_AREA'), 'PropSet', @cb_listener_st_area);
					
				case MeasureEnsemblePF.H_LINE_M % __MeasureEnsemblePF.H_LINE_M__
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case MeasureEnsemblePF.LISTENER_ST_LINE_M % __MeasureEnsemblePF.LISTENER_ST_LINE_M__
					value = listener(pf.get('ST_LINE_M'), 'PropSet', @cb_listener_st_LINE_M);
					
				case MeasureEnsemblePF.H_TITLE % __MeasureEnsemblePF.H_TITLE__
					value = title(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_TITLE'), 'NoValue')
					    st = pf.memorize('ST_TITLE');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', pf.get('ME').get('LABEL'), ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case MeasureEnsemblePF.H_XLABEL % __MeasureEnsemblePF.H_XLABEL__
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
					
				case MeasureEnsemblePF.H_YLABEL % __MeasureEnsemblePF.H_YLABEL__
					value = ylabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_YLABEL'), 'NoValue')
					    st = pf.memorize('ST_YLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Measure', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case MeasureEnsemblePF.DRAW % __MeasureEnsemblePF.DRAW__
					value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					    
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', MeasureEnsemblePF.H_AXES).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('H_AREA')
					    pf.memorize('ST_AREA').set('PANEL', pf, 'PROP', MeasureEnsemblePF.H_AREA).get('SETUP')
					    pf.memorize('LISTENER_ST_AREA');
					
					    pf.memorize('H_LINE_M')
					    pf.memorize('ST_LINE_M').set('PANEL', pf, 'PROP', MeasureEnsemblePF.H_LINE_M).get('SETUP')
						pf.memorize('LISTENER_ST_LINE_M');
					    
					    pf.memorize('H_TITLE')
					    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', MeasureEnsemblePF.H_TITLE).get('SETUP')
					
					    pf.memorize('H_XLABEL')
					    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', MeasureEnsemblePF.H_XLABEL).get('SETUP')
					    
					    pf.memorize('H_YLABEL')
					    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', MeasureEnsemblePF.H_YLABEL).get('SETUP')
					
					    pf.get('SETUP')
					end
					
				case MeasureEnsemblePF.DELETE % __MeasureEnsemblePF.DELETE__
					value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					    
					    pf.set('H_AREA', Element.getNoValue())
					    pf.set('LISTENER_ST_AREA', Element.getNoValue())
					 
					    pf.set('H_LINE_M', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE_M', Element.getNoValue())
					
					    pf.set('H_TITLE', Element.getNoValue())
					
					    pf.set('H_XLABEL', Element.getNoValue())
					    
					    pf.set('H_YLABEL', Element.getNoValue())
					end
					
				case MeasureEnsemblePF.H_TOOLS % __MeasureEnsemblePF.H_TOOLS__
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
					    
					    % Measure Line
					    tool_LINE_M = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.LINE_M', ...
					        'State', pf.get('ST_LINE_M').get('VISIBLE'), ...
					        'Tooltip', 'Show Measure line', ...
					        'CData', imresize(imread('icon_line.png'), [24 24]), ... % % % make icon 16x16
					        'OnCallback', {@cb_LINE_M, true}, ...
					        'OffCallback', {@cb_LINE_M, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ... 
					        tool_separator_2, ... 
					        tool_LINE_M ...
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
			function cb_listener_st_LINE_M(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.LINE_M'), 'State', pf.get('ST_LINE_M').get('VISIBLE'))
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
			function cb_LINE_M(~, ~, visible) % (src, event)
				pf.get('ST_LINE_M').set('VISIBLE', visible)
			
			    % triggers the update of ST_LINE_M
			    pf.set('ST_LINE_M', pf.get('ST_LINE_M'))
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
				case MeasureEnsemblePF.ST_AXIS % __MeasureEnsemblePF.ST_AXIS__
					pr = SettingsAxisPP('EL', pf, 'PROP', MeasureEnsemblePF.ST_AXIS, varargin{:});
					
				case MeasureEnsemblePF.ST_AREA % __MeasureEnsemblePF.ST_AREA__
					pr = SettingsAreaPP('EL', pf, 'PROP', MeasureEnsemblePF.ST_AREA, varargin{:});
					
				case MeasureEnsemblePF.ST_LINE_M % __MeasureEnsemblePF.ST_LINE_M__
					pr = SettingsLinePP('EL', pf, 'PROP', MeasureEnsemblePF.ST_LINE_M, varargin{:});
					
				case MeasureEnsemblePF.ST_TITLE % __MeasureEnsemblePF.ST_TITLE__
					pr = SettingsTextPP('EL', pf, 'PROP', MeasureEnsemblePF.ST_TITLE, varargin{:});
					
				case MeasureEnsemblePF.ST_XLABEL % __MeasureEnsemblePF.ST_XLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', MeasureEnsemblePF.ST_XLABEL, varargin{:});
					
				case MeasureEnsemblePF.ST_YLABEL % __MeasureEnsemblePF.ST_YLABEL__
					pr = SettingsTextPP('EL', pf, 'PROP', MeasureEnsemblePF.ST_YLABEL, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
