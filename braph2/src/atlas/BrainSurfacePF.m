classdef BrainSurfacePF < PanelFig
	%BrainSurfacePF is a plot of a brain surfce.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% A Panel Figure for Brain Surface (BrainSurfacePF) manages the plot of the 
	%  brain surface choosen by the user. 
	% BrainSurfacePF provides the common methods needed to manage the plot of 
	%  the surface. In particular, the user can change lighting, material, 
	%  camlight, shadning, colormap, facecolor, brain color, face color, 
	%  edge color, and background color. 
	% A collection of brain surfaces in NV format can be found in the folder 
	%  ./braph2/brainsurfs/.
	%
	% BrainSurfacePF methods (constructor):
	%  BrainSurfacePF - constructor
	%
	% BrainSurfacePF methods:
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
	% BrainSurfacePF methods (display):
	%  tostring - string with information about the panel figure for brain surface
	%  disp - displays information about the panel figure for brain surface
	%  tree - displays the tree of the panel figure for brain surface
	%
	% BrainSurfacePF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for brain surface are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for brain surface
	%
	% BrainSurfacePF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for brain surface as b2 file
	%  load - loads a BRAPH2 panel figure for brain surface from a b2 file
	%
	% BrainSurfacePF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for brain surface
	%
	% BrainSurfacePF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for brain surface
	%
	% BrainSurfacePF methods (inspection, Static):
	%  getClass - returns the class of the panel figure for brain surface
	%  getSubclasses - returns all subclasses of BrainSurfacePF
	%  getProps - returns the property list of the panel figure for brain surface
	%  getPropNumber - returns the property number of the panel figure for brain surface
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
	% BrainSurfacePF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BrainSurfacePF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BrainSurfacePF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BrainSurfacePF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BrainSurfacePF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BrainSurfacePF constants</a>.
	%
	%
	% See also BrainSurface.
	
	properties (Constant) % constants
		% fixed 3d view
		VIEW_3D	= 1 % 3D view numeric code
		VIEW_3D_CMD = '3D' % 3D view name
		VIEW_3D_AZEL = [-37.5 30] % 3D view azimutal and polar angles
		
		% sagittal left view
		VIEW_SL	= 2 % sagittal left view numeric code
		VIEW_SL_CMD = 'Sagittal left' % sagittal left view name
		VIEW_SL_AZEL = [-90 0] % sagittal left view azimutal and polar angles
		
		% sagittal right view
		VIEW_SR	= 3 % sagittal right view numeric code
		VIEW_SR_CMD = 'Sagittal right' % sagittal right view name
		VIEW_SR_AZEL = [90 0] % sagittal right view azimutal and polar angles 
		
		% axial dorsal view
		VIEW_AD = 4 % axial dorsal view numeric code
		VIEW_AD_CMD = 'Axial dorsal' % axial dorsal view name
		VIEW_AD_AZEL = [0 90] % axial dorsal view azimutal and polar angles
		
		% axial ventral view
		VIEW_AV = 5 % axial ventral view numeric code
		VIEW_AV_CMD = 'Axial ventral' % axial ventral view name
		VIEW_AV_AZEL = [0 -90] % axial ventral view azimutal and polar angles
		
		% coronal anterior view
		VIEW_CA = 6 % coronal anterior view numeric code
		VIEW_CA_CMD = 'Coronal anterior' % coronal anterior view name
		VIEW_CA_AZEL = [180 0] % coronal anterior view azimutal and polar angles
		
		% coronal posterior view
		VIEW_CP = 7 % coronal posterior view numeric code
		VIEW_CP_CMD = 'Coronal posterior' % coronal posterior view name
		VIEW_CP_AZEL = [0 0] % coronal posterior view azimutal and polar angles
		
		VIEW_CMD = { ... % vector of view names
		    BrainSurfacePF.VIEW_3D_CMD ...
		    BrainSurfacePF.VIEW_SL_CMD ...
		    BrainSurfacePF.VIEW_SR_CMD ...
		    BrainSurfacePF.VIEW_AD_CMD ...
		    BrainSurfacePF.VIEW_AV_CMD ...
		    BrainSurfacePF.VIEW_CA_CMD ...
		    BrainSurfacePF.VIEW_CP_CMD ...
		    }
		
		VIEW_AZEL = { ... % vector of view azimutal and polar angle
		    BrainSurfacePF.VIEW_3D_AZEL ...
		    BrainSurfacePF.VIEW_SL_AZEL ...
		    BrainSurfacePF.VIEW_SR_AZEL ...
		    BrainSurfacePF.VIEW_AD_AZEL ...
		    BrainSurfacePF.VIEW_AV_AZEL ...
		    BrainSurfacePF.VIEW_CA_AZEL ...
		    BrainSurfacePF.VIEW_CP_AZEL ...
		    }
	end
	properties (Constant) % properties
		H_AXES = PanelFig.getPropNumber() + 1;
		H_AXES_TAG = 'H_AXES';
		H_AXES_CATEGORY = Category.EVANESCENT;
		H_AXES_FORMAT = Format.HANDLE;
		
		VIEW = PanelFig.getPropNumber() + 2;
		VIEW_TAG = 'VIEW';
		VIEW_CATEGORY = Category.FIGURE;
		VIEW_FORMAT = Format.RVECTOR;
		
		ST_AXIS = PanelFig.getPropNumber() + 3;
		ST_AXIS_TAG = 'ST_AXIS';
		ST_AXIS_CATEGORY = Category.FIGURE;
		ST_AXIS_FORMAT = Format.ITEM;
		
		LISTENER_ST_AXIS = PanelFig.getPropNumber() + 4;
		LISTENER_ST_AXIS_TAG = 'LISTENER_ST_AXIS';
		LISTENER_ST_AXIS_CATEGORY = Category.EVANESCENT;
		LISTENER_ST_AXIS_FORMAT = Format.HANDLE;
		
		SURFFILE = PanelFig.getPropNumber() + 5;
		SURFFILE_TAG = 'SURFFILE';
		SURFFILE_CATEGORY = Category.FIGURE;
		SURFFILE_FORMAT = Format.OPTION;
		
		SURF = PanelFig.getPropNumber() + 6;
		SURF_TAG = 'SURF';
		SURF_CATEGORY = Category.METADATA;
		SURF_FORMAT = Format.ITEM;
		
		H_BRAIN = PanelFig.getPropNumber() + 7;
		H_BRAIN_TAG = 'H_BRAIN';
		H_BRAIN_CATEGORY = Category.EVANESCENT;
		H_BRAIN_FORMAT = Format.HANDLE;
		
		BRAIN = PanelFig.getPropNumber() + 8;
		BRAIN_TAG = 'BRAIN';
		BRAIN_CATEGORY = Category.FIGURE;
		BRAIN_FORMAT = Format.LOGICAL;
		
		ST_SURFACE = PanelFig.getPropNumber() + 9;
		ST_SURFACE_TAG = 'ST_SURFACE';
		ST_SURFACE_CATEGORY = Category.FIGURE;
		ST_SURFACE_FORMAT = Format.ITEM;
		
		ST_AMBIENT = PanelFig.getPropNumber() + 10;
		ST_AMBIENT_TAG = 'ST_AMBIENT';
		ST_AMBIENT_CATEGORY = Category.FIGURE;
		ST_AMBIENT_FORMAT = Format.ITEM;
	end
	methods % constructor
		function pf = BrainSurfacePF(varargin)
			%BrainSurfacePF() creates a panel figure for brain surface.
			%
			% BrainSurfacePF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BrainSurfacePF(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel figure for brain surface.
			%
			% CLASS = BrainSurfacePF.GETCLASS() returns the class 'BrainSurfacePF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for brain surface PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('BrainSurfacePF') returns 'BrainSurfacePF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('BrainSurfacePF')
			%  are less computationally efficient.
			
			pf_class = 'BrainSurfacePF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for brain surface.
			%
			% LIST = BrainSurfacePF.GETSUBCLASSES() returns all subclasses of 'BrainSurfacePF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for brain surface PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('BrainSurfacePF') returns all subclasses of 'BrainSurfacePF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('BrainSurfacePF', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for brain surface.
			%
			% PROPS = BrainSurfacePF.GETPROPS() returns the property list of panel figure for brain surface
			%  as a row vector.
			%
			% PROPS = BrainSurfacePF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for brain surface PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('BrainSurfacePF'[, CATEGORY]) returns the property list of 'BrainSurfacePF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					PanelFig.getProps() ...
						BrainSurfacePF.H_AXES ...
						BrainSurfacePF.VIEW ...
						BrainSurfacePF.ST_AXIS ...
						BrainSurfacePF.LISTENER_ST_AXIS ...
						BrainSurfacePF.SURFFILE ...
						BrainSurfacePF.SURF ...
						BrainSurfacePF.H_BRAIN ...
						BrainSurfacePF.BRAIN ...
						BrainSurfacePF.ST_SURFACE ...
						BrainSurfacePF.ST_AMBIENT ...
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
						BrainSurfacePF.SURF ...
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
						];
				case Category.EVANESCENT
					prop_list = [ ...
						PanelFig.getProps(Category.EVANESCENT) ...
						BrainSurfacePF.H_AXES ...
						BrainSurfacePF.LISTENER_ST_AXIS ...
						BrainSurfacePF.H_BRAIN ...
						];
				case Category.FIGURE
					prop_list = [ ...
						PanelFig.getProps(Category.FIGURE) ...
						BrainSurfacePF.VIEW ...
						BrainSurfacePF.ST_AXIS ...
						BrainSurfacePF.SURFFILE ...
						BrainSurfacePF.BRAIN ...
						BrainSurfacePF.ST_SURFACE ...
						BrainSurfacePF.ST_AMBIENT ...
						];
				case Category.GUI
					prop_list = [ ...
						PanelFig.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for brain surface.
			%
			% N = BrainSurfacePF.GETPROPNUMBER() returns the property number of panel figure for brain surface.
			%
			% N = BrainSurfacePF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for brain surface
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for brain surface PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('BrainSurfacePF') returns the property number of 'BrainSurfacePF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(BrainSurfacePF.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for brain surface/error.
			%
			% CHECK = BrainSurfacePF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(BrainSurfacePF, PROP) checks whether PROP exists for BrainSurfacePF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BrainSurfacePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:BrainSurfacePF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:BrainSurfacePF:WrongInput]
			%  Element.EXISTSPROP(BrainSurfacePF, PROP) throws error if PROP does NOT exist for BrainSurfacePF.
			%   Error id: [BRAPH2:BrainSurfacePF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == BrainSurfacePF.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainSurfacePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainSurfacePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BrainSurfacePF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for brain surface/error.
			%
			% CHECK = BrainSurfacePF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(BrainSurfacePF, TAG) checks whether TAG exists for BrainSurfacePF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BrainSurfacePF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:BrainSurfacePF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:BrainSurfacePF:WrongInput]
			%  Element.EXISTSTAG(BrainSurfacePF, TAG) throws error if TAG does NOT exist for BrainSurfacePF.
			%   Error id: [BRAPH2:BrainSurfacePF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			brainsurfacepf_tag_list = cellfun(@(x) BrainSurfacePF.getPropTag(x), num2cell(BrainSurfacePF.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, brainsurfacepf_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainSurfacePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainSurfacePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for BrainSurfacePF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(BrainSurfacePF, POINTER) returns property number of POINTER of BrainSurfacePF.
			%  PROPERTY = PF.GETPROPPROP(BrainSurfacePF, POINTER) returns property number of POINTER of BrainSurfacePF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				brainsurfacepf_tag_list = cellfun(@(x) BrainSurfacePF.getPropTag(x), num2cell(BrainSurfacePF.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, brainsurfacepf_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(BrainSurfacePF, POINTER) returns tag of POINTER of BrainSurfacePF.
			%  TAG = PF.GETPROPTAG(BrainSurfacePF, POINTER) returns tag of POINTER of BrainSurfacePF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case BrainSurfacePF.H_AXES
						tag = BrainSurfacePF.H_AXES_TAG;
					case BrainSurfacePF.VIEW
						tag = BrainSurfacePF.VIEW_TAG;
					case BrainSurfacePF.ST_AXIS
						tag = BrainSurfacePF.ST_AXIS_TAG;
					case BrainSurfacePF.LISTENER_ST_AXIS
						tag = BrainSurfacePF.LISTENER_ST_AXIS_TAG;
					case BrainSurfacePF.SURFFILE
						tag = BrainSurfacePF.SURFFILE_TAG;
					case BrainSurfacePF.SURF
						tag = BrainSurfacePF.SURF_TAG;
					case BrainSurfacePF.H_BRAIN
						tag = BrainSurfacePF.H_BRAIN_TAG;
					case BrainSurfacePF.BRAIN
						tag = BrainSurfacePF.BRAIN_TAG;
					case BrainSurfacePF.ST_SURFACE
						tag = BrainSurfacePF.ST_SURFACE_TAG;
					case BrainSurfacePF.ST_AMBIENT
						tag = BrainSurfacePF.ST_AMBIENT_TAG;
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
			%  CATEGORY = Element.GETPROPCATEGORY(BrainSurfacePF, POINTER) returns category of POINTER of BrainSurfacePF.
			%  CATEGORY = PF.GETPROPCATEGORY(BrainSurfacePF, POINTER) returns category of POINTER of BrainSurfacePF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case BrainSurfacePF.H_AXES
					prop_category = BrainSurfacePF.H_AXES_CATEGORY;
				case BrainSurfacePF.VIEW
					prop_category = BrainSurfacePF.VIEW_CATEGORY;
				case BrainSurfacePF.ST_AXIS
					prop_category = BrainSurfacePF.ST_AXIS_CATEGORY;
				case BrainSurfacePF.LISTENER_ST_AXIS
					prop_category = BrainSurfacePF.LISTENER_ST_AXIS_CATEGORY;
				case BrainSurfacePF.SURFFILE
					prop_category = BrainSurfacePF.SURFFILE_CATEGORY;
				case BrainSurfacePF.SURF
					prop_category = BrainSurfacePF.SURF_CATEGORY;
				case BrainSurfacePF.H_BRAIN
					prop_category = BrainSurfacePF.H_BRAIN_CATEGORY;
				case BrainSurfacePF.BRAIN
					prop_category = BrainSurfacePF.BRAIN_CATEGORY;
				case BrainSurfacePF.ST_SURFACE
					prop_category = BrainSurfacePF.ST_SURFACE_CATEGORY;
				case BrainSurfacePF.ST_AMBIENT
					prop_category = BrainSurfacePF.ST_AMBIENT_CATEGORY;
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
			%  FORMAT = Element.GETPROPFORMAT(BrainSurfacePF, POINTER) returns format of POINTER of BrainSurfacePF.
			%  FORMAT = PF.GETPROPFORMAT(BrainSurfacePF, POINTER) returns format of POINTER of BrainSurfacePF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case BrainSurfacePF.H_AXES
					prop_format = BrainSurfacePF.H_AXES_FORMAT;
				case BrainSurfacePF.VIEW
					prop_format = BrainSurfacePF.VIEW_FORMAT;
				case BrainSurfacePF.ST_AXIS
					prop_format = BrainSurfacePF.ST_AXIS_FORMAT;
				case BrainSurfacePF.LISTENER_ST_AXIS
					prop_format = BrainSurfacePF.LISTENER_ST_AXIS_FORMAT;
				case BrainSurfacePF.SURFFILE
					prop_format = BrainSurfacePF.SURFFILE_FORMAT;
				case BrainSurfacePF.SURF
					prop_format = BrainSurfacePF.SURF_FORMAT;
				case BrainSurfacePF.H_BRAIN
					prop_format = BrainSurfacePF.H_BRAIN_FORMAT;
				case BrainSurfacePF.BRAIN
					prop_format = BrainSurfacePF.BRAIN_FORMAT;
				case BrainSurfacePF.ST_SURFACE
					prop_format = BrainSurfacePF.ST_SURFACE_FORMAT;
				case BrainSurfacePF.ST_AMBIENT
					prop_format = BrainSurfacePF.ST_AMBIENT_FORMAT;
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BrainSurfacePF, POINTER) returns description of POINTER of BrainSurfacePF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(BrainSurfacePF, POINTER) returns description of POINTER of BrainSurfacePF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case BrainSurfacePF.H_AXES
					prop_description = 'H_AXES (evanescent, handle) is the handle for the axes.';
				case BrainSurfacePF.VIEW
					prop_description = 'VIEW (figure, rvector) sets the desired view as the line-of-sight azimuth and elevation angles.';
				case BrainSurfacePF.ST_AXIS
					prop_description = 'ST_AXIS (figure, item) determines the axis settings.';
				case BrainSurfacePF.LISTENER_ST_AXIS
					prop_description = 'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.';
				case BrainSurfacePF.SURFFILE
					prop_description = 'SURFFILE (figure, option) is the name of the file of the brain surface to be plotted.';
				case BrainSurfacePF.SURF
					prop_description = 'SURF (metadata, item) is the brain surface to be plotted.';
				case BrainSurfacePF.H_BRAIN
					prop_description = 'H_BRAIN (evanescent, handle) is the handle for brain surface.';
				case BrainSurfacePF.BRAIN
					prop_description = 'BRAIN (figure, logical) determines whether the brain surface is shown.';
				case BrainSurfacePF.ST_SURFACE
					prop_description = 'ST_SURFACE (figure, item) determines the surface settings.';
				case BrainSurfacePF.ST_AMBIENT
					prop_description = 'ST_AMBIENT (figure, item) determines the ambient settings.';
				case BrainSurfacePF.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the panel figure for brain surface.';
				case BrainSurfacePF.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for brain surface.';
				case BrainSurfacePF.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for brain surface.';
				case BrainSurfacePF.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for brain surface.';
				case BrainSurfacePF.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for brain surface.';
				case BrainSurfacePF.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for brain surface.';
				case BrainSurfacePF.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for brain surface.';
				case BrainSurfacePF.DRAW
					prop_description = 'DRAW (query, logical) draws the figure brain surface.';
				case BrainSurfacePF.DELETE
					prop_description = 'DELETE (query, logical) resets the handles when the panel figure for brain surface is deleted.';
				case BrainSurfacePF.H_TOOLS
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
			%  SETTINGS = Element.GETPROPSETTINGS(BrainSurfacePF, POINTER) returns settings of POINTER of BrainSurfacePF.
			%  SETTINGS = PF.GETPROPSETTINGS(BrainSurfacePF, POINTER) returns settings of POINTER of BrainSurfacePF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case BrainSurfacePF.H_AXES
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case BrainSurfacePF.VIEW
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case BrainSurfacePF.ST_AXIS
					prop_settings = 'SettingsAxis';
				case BrainSurfacePF.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case BrainSurfacePF.SURFFILE
					prop_settings = {dir([fileparts(which('braph2')) filesep() 'brainsurfs' filesep() '*.nv']).name};
				case BrainSurfacePF.SURF
					prop_settings = 'BrainSurface';
				case BrainSurfacePF.H_BRAIN
					prop_settings = Format.getFormatSettings(Format.HANDLE);
				case BrainSurfacePF.BRAIN
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case BrainSurfacePF.ST_SURFACE
					prop_settings = 'SettingsSurface';
				case BrainSurfacePF.ST_AMBIENT
					prop_settings = 'SettingsAmbient';
				case BrainSurfacePF.TEMPLATE
					prop_settings = 'BrainSurfacePF';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BrainSurfacePF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainSurfacePF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(BrainSurfacePF, POINTER) returns the default value of POINTER of BrainSurfacePF.
			%  DEFAULT = PF.GETPROPDEFAULT(BrainSurfacePF, POINTER) returns the default value of POINTER of BrainSurfacePF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case BrainSurfacePF.H_AXES
					prop_default = Format.getFormatDefault(Format.HANDLE, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.VIEW
					prop_default = BrainSurfacePF.VIEW_SL_AZEL;
				case BrainSurfacePF.ST_AXIS
					prop_default = SettingsAxis('GRID', false, 'AXIS', false);
				case BrainSurfacePF.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(Format.HANDLE, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.SURFFILE
					prop_default = 'human_ICBM152.nv';
				case BrainSurfacePF.SURF
					prop_default = ImporterBrainSurfaceNV('FILE', BrainSurfacePF.getPropDefault('SURFFILE')).get('SURF');
				case BrainSurfacePF.H_BRAIN
					prop_default = Format.getFormatDefault(Format.HANDLE, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.BRAIN
					prop_default = true;
				case BrainSurfacePF.ST_SURFACE
					prop_default = Format.getFormatDefault(Format.ITEM, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.ST_AMBIENT
					prop_default = SettingsAmbient('LIGHTING', 'gouraud', 'MATERIAL', 'dull', 'CAMLIGHT', 'headlight (x2)', 'SHADING', 'none', 'COLORMAP', 'none');
				case BrainSurfacePF.ELCLASS
					prop_default = 'BrainSurfacePF';
				case BrainSurfacePF.NAME
					prop_default = 'Panel Figure for Brain Surface';
				case BrainSurfacePF.DESCRIPTION
					prop_default = 'A Panel Figure for Brain Surface (BrainSurfacePF) manages the plot of the brain surface choosen by the user. BrainSurfacePF provides the common methods needed to manage the plot of the surface. In particular, the user can change lighting, material, camlight, shadning, colormap, facecolor, brain color, face color, edge color, and background color. A collection of brain surfaces in NV format can be found in the folder ./braph2/brainsurfs/.';
				case BrainSurfacePF.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.ID
					prop_default = 'BrainSurfacePF ID';
				case BrainSurfacePF.LABEL
					prop_default = 'BrainSurfacePF label';
				case BrainSurfacePF.NOTES
					prop_default = 'BrainSurfacePF notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BrainSurfacePF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BrainSurfacePF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BrainSurfacePF, POINTER) returns the conditioned default value of POINTER of BrainSurfacePF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(BrainSurfacePF, POINTER) returns the conditioned default value of POINTER of BrainSurfacePF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BrainSurfacePF.getPropProp(pointer);
			
			prop_default = BrainSurfacePF.conditioning(prop, BrainSurfacePF.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(BrainSurfacePF, PROP, VALUE) checks VALUE format for PROP of BrainSurfacePF.
			%  CHECK = PF.CHECKPROP(BrainSurfacePF, PROP, VALUE) checks VALUE format for PROP of BrainSurfacePF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:BrainSurfacePF:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:BrainSurfacePF:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(BrainSurfacePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainSurfacePF.
			%   Error id: €BRAPH2.STR€:BrainSurfacePF:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(BrainSurfacePF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BrainSurfacePF.
			%   Error id: €BRAPH2.STR€:BrainSurfacePF:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('BrainSurfacePF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BrainSurfacePF.getPropProp(pointer);
			
			switch prop
				case BrainSurfacePF.H_AXES % __BrainSurfacePF.H_AXES__
					check = Format.checkFormat(Format.HANDLE, value, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.VIEW % __BrainSurfacePF.VIEW__
					check = Format.checkFormat(Format.RVECTOR, value, BrainSurfacePF.getPropSettings(prop));
					if check
						check = length(value) == 2;
					end
				case BrainSurfacePF.ST_AXIS % __BrainSurfacePF.ST_AXIS__
					check = Format.checkFormat(Format.ITEM, value, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.LISTENER_ST_AXIS % __BrainSurfacePF.LISTENER_ST_AXIS__
					check = Format.checkFormat(Format.HANDLE, value, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.SURFFILE % __BrainSurfacePF.SURFFILE__
					check = Format.checkFormat(Format.OPTION, value, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.SURF % __BrainSurfacePF.SURF__
					check = Format.checkFormat(Format.ITEM, value, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.H_BRAIN % __BrainSurfacePF.H_BRAIN__
					check = Format.checkFormat(Format.HANDLE, value, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.BRAIN % __BrainSurfacePF.BRAIN__
					check = Format.checkFormat(Format.LOGICAL, value, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.ST_SURFACE % __BrainSurfacePF.ST_SURFACE__
					check = Format.checkFormat(Format.ITEM, value, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.ST_AMBIENT % __BrainSurfacePF.ST_AMBIENT__
					check = Format.checkFormat(Format.ITEM, value, BrainSurfacePF.getPropSettings(prop));
				case BrainSurfacePF.TEMPLATE % __BrainSurfacePF.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, BrainSurfacePF.getPropSettings(prop));
				otherwise
					if prop <= PanelFig.getPropNumber()
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':BrainSurfacePF:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':BrainSurfacePF:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BrainSurfacePF.getPropTag(prop) ' (' BrainSurfacePF.getFormatTag(BrainSurfacePF.getPropFormat(prop)) ').'] ...
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
				case BrainSurfacePF.VIEW % __BrainSurfacePF.VIEW__
					if pf.get('DRAWN')
					    view(pf.get('H_AXES'), pf.get('VIEW'))
					    
					    % reset the ambient lighting
					    pf.memorize('ST_AMBIENT').set('PANEL', pf, 'PROP', pf.H_AXES).get('SETUP')
					    
					    % update state of toggle tools
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.View3D'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_3D_AZEL))
					        set(findobj(toolbar, 'Tag', 'TOOL.ViewSL'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_SL_AZEL))
					        set(findobj(toolbar, 'Tag', 'TOOL.ViewSR'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_SR_AZEL))
					        set(findobj(toolbar, 'Tag', 'TOOL.ViewAD'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_AD_AZEL))
					        set(findobj(toolbar, 'Tag', 'TOOL.ViewAV'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_AV_AZEL))
					        set(findobj(toolbar, 'Tag', 'TOOL.ViewCA'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_CA_AZEL))
					        set(findobj(toolbar, 'Tag', 'TOOL.ViewCP'), 'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_CP_AZEL))
					    end
					end
					
				case BrainSurfacePF.ST_AXIS % __BrainSurfacePF.ST_AXIS__
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				case BrainSurfacePF.SURFFILE % __BrainSurfacePF.SURFFILE__
					bs = ImporterBrainSurfaceNV('FILE', pf.get('SURFFILE')).get('SURF');
					pf.set('SURF', bs)
					
					if pf.get('DRAWN')
					    delete(pf.get('H_BRAIN'))
					    pf.set('H_BRAIN', Element.getNoValue())
					
					    pf.memorize('H_BRAIN')
					
					    pf.set('BRAIN', pf.get('BRAIN'))
					
					    pf.memorize('ST_SURFACE').set('PANEL', pf, 'PROP', pf.H_BRAIN).get('SETUP')
					
					    pf.memorize('ST_AMBIENT').set('PANEL', pf, 'PROP', pf.H_AXES).get('SETUP')
					end
					
				case BrainSurfacePF.BRAIN % __BrainSurfacePF.BRAIN__
					if pf.get('DRAWN')
					    if pf.get('BRAIN')
					        set(pf.get('H_BRAIN'), 'Visible', 'on')
					    else % ~pf.get('BRAIN') 
					        set(pf.get('H_BRAIN'), 'Visible', 'off')
					    end
					
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Brain'), 'State', pf.get('BRAIN'))
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
				case BrainSurfacePF.H_AXES % __BrainSurfacePF.H_AXES__
					h_axes = uiaxes( ...
					    'Parent', pf.memorize('H'), ...
					    'Tag', 'H_AXES', ...
					    'Units', 'normalized', ...
					    'OuterPosition', [0 0 1 1] ...
					    );
					h_axes.Toolbar.Visible = 'off';
					h_axes.Interactions = [];
					value = h_axes;
					
				case BrainSurfacePF.LISTENER_ST_AXIS % __BrainSurfacePF.LISTENER_ST_AXIS__
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case BrainSurfacePF.H_BRAIN % __BrainSurfacePF.H_BRAIN__
					triangles = pf.get('SURF').get('TRIANGLES');
					coordinates = pf.get('SURF').get('COORDINATES');
					h_brain = trisurf( ...
					    triangles, ...
					    coordinates(:, 1), ...
					    coordinates(:, 2), ...
					    coordinates(:, 3), ...
					    'Parent', pf.memorize('H_AXES'), ...
					    'Tag', 'H_BRAIN' ...
					    );
					xlabel(pf.get('H_AXES'), 'Sagittal')
					ylabel(pf.get('H_AXES'), 'Axial')
					zlabel(pf.get('H_AXES'), 'Coronal')
					value = h_brain;
					
				case BrainSurfacePF.DRAW % __BrainSurfacePF.DRAW__
					value = calculateValue@PanelFig(pf, PanelFig.DRAW, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					    
					    pf.set('VIEW', pf.get('VIEW'))
					
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', BrainSurfacePF.H_AXES).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					    
					    pf.memorize('H_BRAIN')
					
					    pf.set('BRAIN', pf.get('BRAIN'))
					
					    pf.memorize('ST_SURFACE').set('PANEL', pf, 'PROP', BrainSurfacePF.H_BRAIN).get('SETUP')
					    
					    pf.memorize('ST_AMBIENT').set('PANEL', pf, 'PROP', BrainSurfacePF.H_AXES).get('SETUP')
					end
					
				case BrainSurfacePF.DELETE % __BrainSurfacePF.DELETE__
					value = calculateValue@PanelFig(pf, PanelFig.DELETE, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					    pf.set('H_BRAIN', Element.getNoValue())
					    
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					end
					
				case BrainSurfacePF.H_TOOLS % __BrainSurfacePF.H_TOOLS__
					toolbar = pf.memorize('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    value = calculateValue@PanelFig(pf, PanelFig.H_TOOLS);
					    
					    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Brain
					    tool_brain = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Brain', ...
					        'Separator', 'on', ...
					        'State', pf.get('BRAIN'), ...
					        'Tooltip', 'Show Brain', ...
					        'CData', imread('icon_brain.png'), ...
					        'OnCallback', {@cb_brain, true}, ...
					        'OffCallback', {@cb_brain, false});
					
					    % Axis
					    tool_axis = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Axis', ...
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
					
					    % View 3D
					    tool_view3D = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.View3D', ...
					        'Separator', 'on', ... 
					        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_3D_AZEL), ...
					        'Tooltip', BrainSurfacePF.VIEW_3D_CMD, ...
					        'CData', imread('icon_view_3d.png'), ...
					        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_3D_AZEL});
					
					    % View SL
					    tool_viewSL = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.ViewSL', ...
					        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_SL_AZEL), ...
					        'Tooltip', BrainSurfacePF.VIEW_SL_CMD, ...
					        'CData', imread('icon_view_sl.png'), ...
					        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_SL_AZEL});
					
					    % View SR
					    tool_viewSR = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.ViewSR', ...
					        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_SR_AZEL), ...
					        'Tooltip', BrainSurfacePF.VIEW_SR_CMD, ...
					        'CData', imread('icon_view_sr.png'), ...
					        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_SR_AZEL});
					
					    % View AD
					    tool_viewAD = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.ViewAD', ...
					        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_AD_AZEL), ...
					        'Tooltip', BrainSurfacePF.VIEW_AD_CMD, ...
					        'CData', imread('icon_view_ad.png'), ...
					        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_AD_AZEL});
					
					    % View AV
					    tool_viewAV = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.ViewAV', ...
					        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_AV_AZEL), ...
					        'Tooltip', BrainSurfacePF.VIEW_AV_CMD, ...
					        'CData', imread('icon_view_av.png'), ...
					        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_AV_AZEL});
					
					    % View CA
					    tool_viewCA = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.ViewCA', ...
					        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_CA_AZEL), ...
					        'Tooltip', BrainSurfacePF.VIEW_CA_CMD, ...
					        'CData', imread('icon_view_ca.png'), ...
					        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_CA_AZEL});
					
					    % View CP
					    tool_viewCP = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.ViewCP', ...
					        'State', isequal(pf.get('VIEW'), BrainSurfacePF.VIEW_CP_AZEL), ...
					        'Tooltip', BrainSurfacePF.VIEW_CP_CMD, ...
					        'CData', imread('icon_view_cp.png'), ...
					        'ClickedCallback', {@cb_view, BrainSurfacePF.VIEW_CP_AZEL});
					    
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_brain, tool_axis, tool_grid, ...
					        tool_separator_2, ...
					        tool_view3D, tool_viewSL, tool_viewSL, tool_viewSR, tool_viewAD, tool_viewAV, tool_viewCA, tool_viewCP ...
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
			function cb_brain(~, ~, brain) % (src, event)
			    pf.set('BRAIN', brain)
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
			function cb_view(~, ~, azel) % (src, event)
			    pf.set('VIEW', azel)
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
				case BrainSurfacePF.VIEW % __BrainSurfacePF.VIEW__
					pr = PanelPropRVectorView('EL', pf, 'PROP', BrainSurfacePF.VIEW, varargin{:});
					
				case BrainSurfacePF.ST_AXIS % __BrainSurfacePF.ST_AXIS__
					pr = SettingsAxisPP('EL', pf, 'PROP', BrainSurfacePF.ST_AXIS, varargin{:});
					
				case BrainSurfacePF.ST_SURFACE % __BrainSurfacePF.ST_SURFACE__
					pr = SettingsSurfacePP('EL', pf, 'PROP', BrainSurfacePF.ST_SURFACE, varargin{:});
					
				case BrainSurfacePF.ST_AMBIENT % __BrainSurfacePF.ST_AMBIENT__
					pr = SettingsAmbientPP('EL', pf, 'PROP', BrainSurfacePF.ST_AMBIENT, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
