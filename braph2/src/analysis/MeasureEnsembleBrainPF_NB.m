classdef MeasureEnsembleBrainPF_NB < MeasureEnsembleBrainPF
	%MeasureEnsembleBrainPF_NB is a plot of a nodal bilayer measure group brain.
	% It is a subclass of <a href="matlab:help MeasureEnsembleBrainPF">MeasureEnsembleBrainPF</a>.
	%
	% A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF_NB) manages the plot of the nodal bilayer measure
	%  ploted over the brain.  
	% MeasureEnsembleBrainPF_NB  utilizes the surface created from BrainAtlasPF to integrate 
	%  the nodal bilayer meaure into the brain regions.
	%
	% MeasureEnsembleBrainPF_NB methods (constructor):
	%  MeasureEnsembleBrainPF_NB - constructor
	%
	% MeasureEnsembleBrainPF_NB methods:
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
	% MeasureEnsembleBrainPF_NB methods (display):
	%  tostring - string with information about the panel figure for nodal bilayer measure group brain
	%  disp - displays information about the panel figure for nodal bilayer measure group brain
	%  tree - displays the tree of the panel figure for nodal bilayer measure group brain
	%
	% MeasureEnsembleBrainPF_NB methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for nodal bilayer measure group brain are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for nodal bilayer measure group brain
	%
	% MeasureEnsembleBrainPF_NB methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for nodal bilayer measure group brain as b2 file
	%  load - loads a BRAPH2 panel figure for nodal bilayer measure group brain from a b2 file
	%
	% MeasureEnsembleBrainPF_NB method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for nodal bilayer measure group brain
	%
	% MeasureEnsembleBrainPF_NB method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for nodal bilayer measure group brain
	%
	% MeasureEnsembleBrainPF_NB methods (inspection, Static):
	%  getClass - returns the class of the panel figure for nodal bilayer measure group brain
	%  getSubclasses - returns all subclasses of MeasureEnsembleBrainPF_NB
	%  getProps - returns the property list of the panel figure for nodal bilayer measure group brain
	%  getPropNumber - returns the property number of the panel figure for nodal bilayer measure group brain
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
	% MeasureEnsembleBrainPF_NB methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureEnsembleBrainPF_NB methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureEnsembleBrainPF_NB methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureEnsembleBrainPF_NB methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureEnsembleBrainPF_NB; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureEnsembleBrainPF_NB constants</a>.
	%
	%
	% See also BrainAtlas, BrainSurface, BrainAtlasPF.
	
	methods % constructor
		function pf = MeasureEnsembleBrainPF_NB(varargin)
			%MeasureEnsembleBrainPF_NB() creates a panel figure for nodal bilayer measure group brain.
			%
			% MeasureEnsembleBrainPF_NB(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureEnsembleBrainPF_NB(TAG, VALUE, ...) with property TAG set to VALUE.
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
			%GETCLASS returns the class of the panel figure for nodal bilayer measure group brain.
			%
			% CLASS = MeasureEnsembleBrainPF_NB.GETCLASS() returns the class 'MeasureEnsembleBrainPF_NB'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for nodal bilayer measure group brain PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasureEnsembleBrainPF_NB') returns 'MeasureEnsembleBrainPF_NB'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			
			pf_class = 'MeasureEnsembleBrainPF_NB';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for nodal bilayer measure group brain.
			%
			% LIST = MeasureEnsembleBrainPF_NB.GETSUBCLASSES() returns all subclasses of 'MeasureEnsembleBrainPF_NB'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for nodal bilayer measure group brain PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasureEnsembleBrainPF_NB') returns all subclasses of 'MeasureEnsembleBrainPF_NB'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('MeasureEnsembleBrainPF_NB', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for nodal bilayer measure group brain.
			%
			% PROPS = MeasureEnsembleBrainPF_NB.GETPROPS() returns the property list of panel figure for nodal bilayer measure group brain
			%  as a row vector.
			%
			% PROPS = MeasureEnsembleBrainPF_NB.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for nodal bilayer measure group brain PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasureEnsembleBrainPF_NB'[, CATEGORY]) returns the property list of 'MeasureEnsembleBrainPF_NB'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					MeasureEnsembleBrainPF.getProps() ...
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
						];
				case Category.GUI
					prop_list = [ ...
						MeasureEnsembleBrainPF.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure for nodal bilayer measure group brain.
			%
			% N = MeasureEnsembleBrainPF_NB.GETPROPNUMBER() returns the property number of panel figure for nodal bilayer measure group brain.
			%
			% N = MeasureEnsembleBrainPF_NB.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for nodal bilayer measure group brain
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for nodal bilayer measure group brain PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasureEnsembleBrainPF_NB') returns the property number of 'MeasureEnsembleBrainPF_NB'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(MeasureEnsembleBrainPF_NB.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure for nodal bilayer measure group brain/error.
			%
			% CHECK = MeasureEnsembleBrainPF_NB.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasureEnsembleBrainPF_NB, PROP) checks whether PROP exists for MeasureEnsembleBrainPF_NB.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsembleBrainPF_NB:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NB:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NB:WrongInput]
			%  Element.EXISTSPROP(MeasureEnsembleBrainPF_NB, PROP) throws error if PROP does NOT exist for MeasureEnsembleBrainPF_NB.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NB:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == MeasureEnsembleBrainPF_NB.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NB:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NB:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureEnsembleBrainPF_NB.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for nodal bilayer measure group brain/error.
			%
			% CHECK = MeasureEnsembleBrainPF_NB.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasureEnsembleBrainPF_NB, TAG) checks whether TAG exists for MeasureEnsembleBrainPF_NB.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureEnsembleBrainPF_NB:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NB:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NB:WrongInput]
			%  Element.EXISTSTAG(MeasureEnsembleBrainPF_NB, TAG) throws error if TAG does NOT exist for MeasureEnsembleBrainPF_NB.
			%   Error id: [BRAPH2:MeasureEnsembleBrainPF_NB:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			measureensemblebrainpf_nb_tag_list = cellfun(@(x) MeasureEnsembleBrainPF_NB.getPropTag(x), num2cell(MeasureEnsembleBrainPF_NB.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, measureensemblebrainpf_nb_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NB:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NB:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for MeasureEnsembleBrainPF_NB.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureEnsembleBrainPF_NB, POINTER) returns property number of POINTER of MeasureEnsembleBrainPF_NB.
			%  PROPERTY = PF.GETPROPPROP(MeasureEnsembleBrainPF_NB, POINTER) returns property number of POINTER of MeasureEnsembleBrainPF_NB.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				measureensemblebrainpf_nb_tag_list = cellfun(@(x) MeasureEnsembleBrainPF_NB.getPropTag(x), num2cell(MeasureEnsembleBrainPF_NB.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, measureensemblebrainpf_nb_tag_list)); % tag = pointer
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
			%  TAG = Element.GETPROPTAG(MeasureEnsembleBrainPF_NB, POINTER) returns tag of POINTER of MeasureEnsembleBrainPF_NB.
			%  TAG = PF.GETPROPTAG(MeasureEnsembleBrainPF_NB, POINTER) returns tag of POINTER of MeasureEnsembleBrainPF_NB.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureEnsembleBrainPF_NB, POINTER) returns category of POINTER of MeasureEnsembleBrainPF_NB.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasureEnsembleBrainPF_NB, POINTER) returns category of POINTER of MeasureEnsembleBrainPF_NB.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_NB.getPropProp(pointer);
			
			switch prop
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureEnsembleBrainPF_NB, POINTER) returns format of POINTER of MeasureEnsembleBrainPF_NB.
			%  FORMAT = PF.GETPROPFORMAT(MeasureEnsembleBrainPF_NB, POINTER) returns format of POINTER of MeasureEnsembleBrainPF_NB.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_NB.getPropProp(pointer);
			
			switch prop
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureEnsembleBrainPF_NB, POINTER) returns description of POINTER of MeasureEnsembleBrainPF_NB.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasureEnsembleBrainPF_NB, POINTER) returns description of POINTER of MeasureEnsembleBrainPF_NB.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_NB.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_NB.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % %.';
				case MeasureEnsembleBrainPF_NB.NAME
					prop_description = 'NAME (constant, string) is the name of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NB.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NB.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NB.ID
					prop_description = 'ID (data, string) is a few-letter code for the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NB.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NB.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.';
				case MeasureEnsembleBrainPF_NB.SETUP
					prop_description = 'SETUP (query, empty) calculates the measure value and stores it to be ploted on a brain surface.';
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureEnsembleBrainPF_NB, POINTER) returns settings of POINTER of MeasureEnsembleBrainPF_NB.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasureEnsembleBrainPF_NB, POINTER) returns settings of POINTER of MeasureEnsembleBrainPF_NB.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureEnsembleBrainPF_NB.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_NB.TEMPLATE
					prop_settings = 'MeasureEnsembleBrainPF_NB';
				otherwise
					prop_settings = getPropSettings@MeasureEnsembleBrainPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureEnsembleBrainPF_NB.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsembleBrainPF_NB.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureEnsembleBrainPF_NB, POINTER) returns the default value of POINTER of MeasureEnsembleBrainPF_NB.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasureEnsembleBrainPF_NB, POINTER) returns the default value of POINTER of MeasureEnsembleBrainPF_NB.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureEnsembleBrainPF_NB.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_NB.ELCLASS
					prop_default = 'MeasureEnsembleBrainPF_NB';
				case MeasureEnsembleBrainPF_NB.NAME
					prop_default = 'Panel Figure for Measure Group Brain';
				case MeasureEnsembleBrainPF_NB.DESCRIPTION
					prop_default = 'A Panel Figure for a Brain Measure of Analyze Group (MeasureEnsembleBrainPF_NB) manages the plot of the nodal bilayer measure ploted over the brain. MeasureEnsembleBrainPF_NB  utilizes the surface created from BrainAtlasPF to integrate the nodal bilayer meaure into the brain regions.';
				case MeasureEnsembleBrainPF_NB.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, MeasureEnsembleBrainPF_NB.getPropSettings(prop));
				case MeasureEnsembleBrainPF_NB.ID
					prop_default = 'MeasureEnsembleBrainPF_NB ID';
				case MeasureEnsembleBrainPF_NB.LABEL
					prop_default = 'MeasureEnsembleBrainPF_NB label';
				case MeasureEnsembleBrainPF_NB.NOTES
					prop_default = 'MeasureEnsembleBrainPF_NB notes';
				otherwise
					prop_default = getPropDefault@MeasureEnsembleBrainPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureEnsembleBrainPF_NB.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureEnsembleBrainPF_NB.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureEnsembleBrainPF_NB, POINTER) returns the conditioned default value of POINTER of MeasureEnsembleBrainPF_NB.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasureEnsembleBrainPF_NB, POINTER) returns the conditioned default value of POINTER of MeasureEnsembleBrainPF_NB.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureEnsembleBrainPF_NB.getPropProp(pointer);
			
			prop_default = MeasureEnsembleBrainPF_NB.conditioning(prop, MeasureEnsembleBrainPF_NB.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureEnsembleBrainPF_NB, PROP, VALUE) checks VALUE format for PROP of MeasureEnsembleBrainPF_NB.
			%  CHECK = PF.CHECKPROP(MeasureEnsembleBrainPF_NB, PROP, VALUE) checks VALUE format for PROP of MeasureEnsembleBrainPF_NB.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_NB:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_NB:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(MeasureEnsembleBrainPF_NB, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsembleBrainPF_NB.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_NB:€BRAPH2.WRONG_INPUT€
			%  PF.CHECKPROP(MeasureEnsembleBrainPF_NB, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureEnsembleBrainPF_NB.
			%   Error id: €BRAPH2.STR€:MeasureEnsembleBrainPF_NB:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasureEnsembleBrainPF_NB')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureEnsembleBrainPF_NB.getPropProp(pointer);
			
			switch prop
				case MeasureEnsembleBrainPF_NB.TEMPLATE % __MeasureEnsembleBrainPF_NB.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, MeasureEnsembleBrainPF_NB.getPropSettings(prop));
				otherwise
					if prop <= MeasureEnsembleBrainPF.getPropNumber()
						check = checkProp@MeasureEnsembleBrainPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NB:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':MeasureEnsembleBrainPF_NB:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureEnsembleBrainPF_NB.getPropTag(prop) ' (' MeasureEnsembleBrainPF_NB.getFormatTag(MeasureEnsembleBrainPF_NB.getPropFormat(prop)) ').'] ...
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
				case MeasureEnsembleBrainPF_NB.SETUP % __MeasureEnsembleBrainPF_NB.SETUP__
					%%%__WARN_TBI__
					value = [];
					
				otherwise
					if prop <= MeasureEnsembleBrainPF.getPropNumber()
						value = calculateValue@MeasureEnsembleBrainPF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
end
