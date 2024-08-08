classdef VOINumeric < VOI
	%VOINumeric is a numerical variable of interest.
	% It is a subclass of <a href="matlab:help VOI">VOI</a>.
	%
	% A Numerical Variable Of Interest (VOINumeric) is a numerical variable of interest.
	%
	% VOINumeric methods (constructor):
	%  VOINumeric - constructor
	%
	% VOINumeric methods:
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
	% VOINumeric methods (display):
	%  tostring - string with information about the numerical variable of interest
	%  disp - displays information about the numerical variable of interest
	%  tree - displays the tree of the numerical variable of interest
	%
	% VOINumeric methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two numerical variable of interest are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the numerical variable of interest
	%
	% VOINumeric methods (save/load, Static):
	%  save - saves BRAPH2 numerical variable of interest as b2 file
	%  load - loads a BRAPH2 numerical variable of interest from a b2 file
	%
	% VOINumeric method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the numerical variable of interest
	%
	% VOINumeric method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the numerical variable of interest
	%
	% VOINumeric methods (inspection, Static):
	%  getClass - returns the class of the numerical variable of interest
	%  getSubclasses - returns all subclasses of VOINumeric
	%  getProps - returns the property list of the numerical variable of interest
	%  getPropNumber - returns the property number of the numerical variable of interest
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
	% VOINumeric methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% VOINumeric methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% VOINumeric methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% VOINumeric methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?VOINumeric; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">VOINumeric constants</a>.
	%
	%
	% See also VOICategoric.
	
	methods % constructor
		function voi = VOINumeric(varargin)
			%VOINumeric() creates a numerical variable of interest.
			%
			% VOINumeric(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% VOINumeric(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			voi = voi@VOI(varargin{:});
		end
	end
	methods (Static) % inspection
		function voi_class = getClass()
			%GETCLASS returns the class of the numerical variable of interest.
			%
			% CLASS = VOINumeric.GETCLASS() returns the class 'VOINumeric'.
			%
			% Alternative forms to call this method are:
			%  CLASS = VOI.GETCLASS() returns the class of the numerical variable of interest VOI.
			%  CLASS = Element.GETCLASS(VOI) returns the class of 'VOI'.
			%  CLASS = Element.GETCLASS('VOINumeric') returns 'VOINumeric'.
			%
			% Note that the Element.GETCLASS(VOI) and Element.GETCLASS('VOINumeric')
			%  are less computationally efficient.
			
			voi_class = 'VOINumeric';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the numerical variable of interest.
			%
			% LIST = VOINumeric.GETSUBCLASSES() returns all subclasses of 'VOINumeric'.
			%
			% Alternative forms to call this method are:
			%  LIST = VOI.GETSUBCLASSES() returns all subclasses of the numerical variable of interest VOI.
			%  LIST = Element.GETSUBCLASSES(VOI) returns all subclasses of 'VOI'.
			%  LIST = Element.GETSUBCLASSES('VOINumeric') returns all subclasses of 'VOINumeric'.
			%
			% Note that the Element.GETSUBCLASSES(VOI) and Element.GETSUBCLASSES('VOINumeric')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('VOINumeric', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of numerical variable of interest.
			%
			% PROPS = VOINumeric.GETPROPS() returns the property list of numerical variable of interest
			%  as a row vector.
			%
			% PROPS = VOINumeric.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = VOI.GETPROPS([CATEGORY]) returns the property list of the numerical variable of interest VOI.
			%  PROPS = Element.GETPROPS(VOI[, CATEGORY]) returns the property list of 'VOI'.
			%  PROPS = Element.GETPROPS('VOINumeric'[, CATEGORY]) returns the property list of 'VOINumeric'.
			%
			% Note that the Element.GETPROPS(VOI) and Element.GETPROPS('VOINumeric')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					VOI.getProps() ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						VOI.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						VOI.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						VOI.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						VOI.getProps(Category.DATA) ...
						];
				case Category.RESULT
					prop_list = [
						VOI.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						VOI.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						VOI.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						VOI.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						VOI.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of numerical variable of interest.
			%
			% N = VOINumeric.GETPROPNUMBER() returns the property number of numerical variable of interest.
			%
			% N = VOINumeric.GETPROPNUMBER(CATEGORY) returns the property number of numerical variable of interest
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = VOI.GETPROPNUMBER([CATEGORY]) returns the property number of the numerical variable of interest VOI.
			%  N = Element.GETPROPNUMBER(VOI) returns the property number of 'VOI'.
			%  N = Element.GETPROPNUMBER('VOINumeric') returns the property number of 'VOINumeric'.
			%
			% Note that the Element.GETPROPNUMBER(VOI) and Element.GETPROPNUMBER('VOINumeric')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(VOINumeric.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in numerical variable of interest/error.
			%
			% CHECK = VOINumeric.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = VOI.EXISTSPROP(PROP) checks whether PROP exists for VOI.
			%  CHECK = Element.EXISTSPROP(VOI, PROP) checks whether PROP exists for VOI.
			%  CHECK = Element.EXISTSPROP(VOINumeric, PROP) checks whether PROP exists for VOINumeric.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:VOINumeric:WrongInput]
			%
			% Alternative forms to call this method are:
			%  VOI.EXISTSPROP(PROP) throws error if PROP does NOT exist for VOI.
			%   Error id: [BRAPH2:VOINumeric:WrongInput]
			%  Element.EXISTSPROP(VOI, PROP) throws error if PROP does NOT exist for VOI.
			%   Error id: [BRAPH2:VOINumeric:WrongInput]
			%  Element.EXISTSPROP(VOINumeric, PROP) throws error if PROP does NOT exist for VOINumeric.
			%   Error id: [BRAPH2:VOINumeric:WrongInput]
			%
			% Note that the Element.EXISTSPROP(VOI) and Element.EXISTSPROP('VOINumeric')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == VOINumeric.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':VOINumeric:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':VOINumeric:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for VOINumeric.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in numerical variable of interest/error.
			%
			% CHECK = VOINumeric.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = VOI.EXISTSTAG(TAG) checks whether TAG exists for VOI.
			%  CHECK = Element.EXISTSTAG(VOI, TAG) checks whether TAG exists for VOI.
			%  CHECK = Element.EXISTSTAG(VOINumeric, TAG) checks whether TAG exists for VOINumeric.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:VOINumeric:WrongInput]
			%
			% Alternative forms to call this method are:
			%  VOI.EXISTSTAG(TAG) throws error if TAG does NOT exist for VOI.
			%   Error id: [BRAPH2:VOINumeric:WrongInput]
			%  Element.EXISTSTAG(VOI, TAG) throws error if TAG does NOT exist for VOI.
			%   Error id: [BRAPH2:VOINumeric:WrongInput]
			%  Element.EXISTSTAG(VOINumeric, TAG) throws error if TAG does NOT exist for VOINumeric.
			%   Error id: [BRAPH2:VOINumeric:WrongInput]
			%
			% Note that the Element.EXISTSTAG(VOI) and Element.EXISTSTAG('VOINumeric')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			voinumeric_tag_list = cellfun(@(x) VOINumeric.getPropTag(x), num2cell(VOINumeric.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, voinumeric_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':VOINumeric:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':VOINumeric:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for VOINumeric.'] ...
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
			%  PROPERTY = VOI.GETPROPPROP(POINTER) returns property number of POINTER of VOI.
			%  PROPERTY = Element.GETPROPPROP(VOINumeric, POINTER) returns property number of POINTER of VOINumeric.
			%  PROPERTY = VOI.GETPROPPROP(VOINumeric, POINTER) returns property number of POINTER of VOINumeric.
			%
			% Note that the Element.GETPROPPROP(VOI) and Element.GETPROPPROP('VOINumeric')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				voinumeric_tag_list = cellfun(@(x) VOINumeric.getPropTag(x), num2cell(VOINumeric.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, voinumeric_tag_list)); % tag = pointer
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
			%  TAG = VOI.GETPROPTAG(POINTER) returns tag of POINTER of VOI.
			%  TAG = Element.GETPROPTAG(VOINumeric, POINTER) returns tag of POINTER of VOINumeric.
			%  TAG = VOI.GETPROPTAG(VOINumeric, POINTER) returns tag of POINTER of VOINumeric.
			%
			% Note that the Element.GETPROPTAG(VOI) and Element.GETPROPTAG('VOINumeric')
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
						tag = getPropTag@VOI(prop);
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
			%  CATEGORY = VOI.GETPROPCATEGORY(POINTER) returns category of POINTER of VOI.
			%  CATEGORY = Element.GETPROPCATEGORY(VOINumeric, POINTER) returns category of POINTER of VOINumeric.
			%  CATEGORY = VOI.GETPROPCATEGORY(VOINumeric, POINTER) returns category of POINTER of VOINumeric.
			%
			% Note that the Element.GETPROPCATEGORY(VOI) and Element.GETPROPCATEGORY('VOINumeric')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = VOINumeric.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_category = getPropCategory@VOI(prop);
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
			%  FORMAT = VOI.GETPROPFORMAT(POINTER) returns format of POINTER of VOI.
			%  FORMAT = Element.GETPROPFORMAT(VOINumeric, POINTER) returns format of POINTER of VOINumeric.
			%  FORMAT = VOI.GETPROPFORMAT(VOINumeric, POINTER) returns format of POINTER of VOINumeric.
			%
			% Note that the Element.GETPROPFORMAT(VOI) and Element.GETPROPFORMAT('VOINumeric')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = VOINumeric.getPropProp(pointer);
			
			switch prop
				otherwise
					prop_format = getPropFormat@VOI(prop);
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
			%  DESCRIPTION = VOI.GETPROPDESCRIPTION(POINTER) returns description of POINTER of VOI.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(VOINumeric, POINTER) returns description of POINTER of VOINumeric.
			%  DESCRIPTION = VOI.GETPROPDESCRIPTION(VOINumeric, POINTER) returns description of POINTER of VOINumeric.
			%
			% Note that the Element.GETPROPDESCRIPTION(VOI) and Element.GETPROPDESCRIPTION('VOINumeric')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = VOINumeric.getPropProp(pointer);
			
			switch prop
				case VOINumeric.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the numerical variable of interest.';
				case VOINumeric.NAME
					prop_description = 'NAME (constant, string) is the name of the numerical variable of interest.';
				case VOINumeric.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the numerical variable of interest.';
				case VOINumeric.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the numerical variable of interest.';
				case VOINumeric.ID
					prop_description = 'ID (data, string) is a few-letter code for the numerical variable of interest.';
				case VOINumeric.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the numerical variable of interest.';
				case VOINumeric.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the numerical variable of interest.';
				otherwise
					prop_description = getPropDescription@VOI(prop);
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
			%  SETTINGS = VOI.GETPROPSETTINGS(POINTER) returns settings of POINTER of VOI.
			%  SETTINGS = Element.GETPROPSETTINGS(VOINumeric, POINTER) returns settings of POINTER of VOINumeric.
			%  SETTINGS = VOI.GETPROPSETTINGS(VOINumeric, POINTER) returns settings of POINTER of VOINumeric.
			%
			% Note that the Element.GETPROPSETTINGS(VOI) and Element.GETPROPSETTINGS('VOINumeric')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = VOINumeric.getPropProp(pointer);
			
			switch prop
				case VOINumeric.TEMPLATE
					prop_settings = 'VOINumeric';
				otherwise
					prop_settings = getPropSettings@VOI(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = VOINumeric.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = VOINumeric.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = VOI.GETPROPDEFAULT(POINTER) returns the default value of POINTER of VOI.
			%  DEFAULT = Element.GETPROPDEFAULT(VOINumeric, POINTER) returns the default value of POINTER of VOINumeric.
			%  DEFAULT = VOI.GETPROPDEFAULT(VOINumeric, POINTER) returns the default value of POINTER of VOINumeric.
			%
			% Note that the Element.GETPROPDEFAULT(VOI) and Element.GETPROPDEFAULT('VOINumeric')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = VOINumeric.getPropProp(pointer);
			
			switch prop
				case VOINumeric.ELCLASS
					prop_default = 'VOINumeric';
				case VOINumeric.NAME
					prop_default = 'Numerical Variable Of Interest';
				case VOINumeric.DESCRIPTION
					prop_default = 'A Numerical Variable Of Interest (VOINumeric) is a numerical variable of interest.';
				case VOINumeric.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, VOINumeric.getPropSettings(prop));
				case VOINumeric.ID
					prop_default = 'VOINumeric ID';
				case VOINumeric.LABEL
					prop_default = 'VOINumeric label';
				case VOINumeric.NOTES
					prop_default = 'VOINumeric notes';
				otherwise
					prop_default = getPropDefault@VOI(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = VOINumeric.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = VOINumeric.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of VOI.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(VOINumeric, POINTER) returns the conditioned default value of POINTER of VOINumeric.
			%  DEFAULT = VOI.GETPROPDEFAULTCONDITIONED(VOINumeric, POINTER) returns the conditioned default value of POINTER of VOINumeric.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(VOI) and Element.GETPROPDEFAULTCONDITIONED('VOINumeric')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = VOINumeric.getPropProp(pointer);
			
			prop_default = VOINumeric.conditioning(prop, VOINumeric.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = VOI.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = VOI.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of VOI.
			%  CHECK = Element.CHECKPROP(VOINumeric, PROP, VALUE) checks VALUE format for PROP of VOINumeric.
			%  CHECK = VOI.CHECKPROP(VOINumeric, PROP, VALUE) checks VALUE format for PROP of VOINumeric.
			% 
			% VOI.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:VOINumeric:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  VOI.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of VOI.
			%   Error id: €BRAPH2.STR€:VOINumeric:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(VOINumeric, PROP, VALUE) throws error if VALUE has not a valid format for PROP of VOINumeric.
			%   Error id: €BRAPH2.STR€:VOINumeric:€BRAPH2.WRONG_INPUT€
			%  VOI.CHECKPROP(VOINumeric, PROP, VALUE) throws error if VALUE has not a valid format for PROP of VOINumeric.
			%   Error id: €BRAPH2.STR€:VOINumeric:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(VOI) and Element.CHECKPROP('VOINumeric')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = VOINumeric.getPropProp(pointer);
			
			switch prop
				case VOINumeric.TEMPLATE % __VOINumeric.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, VOINumeric.getPropSettings(prop));
				otherwise
					if prop <= VOI.getPropNumber()
						check = checkProp@VOI(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':VOINumeric:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':VOINumeric:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' VOINumeric.getPropTag(prop) ' (' VOINumeric.getFormatTag(VOINumeric.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
