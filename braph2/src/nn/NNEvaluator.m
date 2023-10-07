classdef NNEvaluator < ConcreteElement
	%NNEvaluator evaluates the performance of a trained neural network model with a dataset.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A neural network evaluator (NNEvaluator) evaluates the performance of a neural network model with a specific dataset.
	% Instances of this class should not be created. Use one of its subclasses instead.
	% Its subclasses shall be specifically designed to cater to different evaluation cases such as a classification task, a regression task, or a data generation task.
	%
	% NNEvaluator methods (constructor):
	%  NNEvaluator - constructor
	%
	% NNEvaluator methods:
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
	% NNEvaluator methods (display):
	%  tostring - string with information about the neural network evaluator
	%  disp - displays information about the neural network evaluator
	%  tree - displays the tree of the neural network evaluator
	%
	% NNEvaluator methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two neural network evaluator are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the neural network evaluator
	%
	% NNEvaluator methods (save/load, Static):
	%  save - saves BRAPH2 neural network evaluator as b2 file
	%  load - loads a BRAPH2 neural network evaluator from a b2 file
	%
	% NNEvaluator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the neural network evaluator
	%
	% NNEvaluator method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the neural network evaluator
	%
	% NNEvaluator methods (inspection, Static):
	%  getClass - returns the class of the neural network evaluator
	%  getSubclasses - returns all subclasses of NNEvaluator
	%  getProps - returns the property list of the neural network evaluator
	%  getPropNumber - returns the property number of the neural network evaluator
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
	% NNEvaluator methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% NNEvaluator methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% NNEvaluator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% NNEvaluator methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?NNEvaluator; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">NNEvaluator constants</a>.
	%
	%
	% See also NNDataPoint, NNDataset, NNBase.
	
	properties (Constant) % properties
		NN = ConcreteElement.getPropNumber() + 1;
		NN_TAG = 'NN';
		NN_CATEGORY = Category.DATA;
		NN_FORMAT = Format.ITEM;
		
		D = ConcreteElement.getPropNumber() + 2;
		D_TAG = 'D';
		D_CATEGORY = Category.DATA;
		D_FORMAT = Format.ITEM;
	end
	methods % constructor
		function nne = NNEvaluator(varargin)
			%NNEvaluator() creates a neural network evaluator.
			%
			% NNEvaluator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% NNEvaluator(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			%
			% See also Category, Format.
			
			nne = nne@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function nne_class = getClass()
			%GETCLASS returns the class of the neural network evaluator.
			%
			% CLASS = NNEvaluator.GETCLASS() returns the class 'NNEvaluator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = NNE.GETCLASS() returns the class of the neural network evaluator NNE.
			%  CLASS = Element.GETCLASS(NNE) returns the class of 'NNE'.
			%  CLASS = Element.GETCLASS('NNEvaluator') returns 'NNEvaluator'.
			%
			% Note that the Element.GETCLASS(NNE) and Element.GETCLASS('NNEvaluator')
			%  are less computationally efficient.
			
			nne_class = 'NNEvaluator';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the neural network evaluator.
			%
			% LIST = NNEvaluator.GETSUBCLASSES() returns all subclasses of 'NNEvaluator'.
			%
			% Alternative forms to call this method are:
			%  LIST = NNE.GETSUBCLASSES() returns all subclasses of the neural network evaluator NNE.
			%  LIST = Element.GETSUBCLASSES(NNE) returns all subclasses of 'NNE'.
			%  LIST = Element.GETSUBCLASSES('NNEvaluator') returns all subclasses of 'NNEvaluator'.
			%
			% Note that the Element.GETSUBCLASSES(NNE) and Element.GETSUBCLASSES('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = subclasses('NNEvaluator', [], [], true);
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of neural network evaluator.
			%
			% PROPS = NNEvaluator.GETPROPS() returns the property list of neural network evaluator
			%  as a row vector.
			%
			% PROPS = NNEvaluator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = NNE.GETPROPS([CATEGORY]) returns the property list of the neural network evaluator NNE.
			%  PROPS = Element.GETPROPS(NNE[, CATEGORY]) returns the property list of 'NNE'.
			%  PROPS = Element.GETPROPS('NNEvaluator'[, CATEGORY]) returns the property list of 'NNEvaluator'.
			%
			% Note that the Element.GETPROPS(NNE) and Element.GETPROPS('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			if nargin == 0
				prop_list = [ ...
					ConcreteElement.getProps() ...
						NNEvaluator.NN ...
						NNEvaluator.D ...
						];
				return
			end
			
			switch category
				case Category.CONSTANT
					prop_list = [ ...
						ConcreteElement.getProps(Category.CONSTANT) ...
						];
				case Category.METADATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.METADATA) ...
						];
				case Category.PARAMETER
					prop_list = [ ...
						ConcreteElement.getProps(Category.PARAMETER) ...
						];
				case Category.DATA
					prop_list = [ ...
						ConcreteElement.getProps(Category.DATA) ...
						NNEvaluator.NN ...
						NNEvaluator.D ...
						];
				case Category.RESULT
					prop_list = [
						ConcreteElement.getProps(Category.RESULT) ...
						];
				case Category.QUERY
					prop_list = [ ...
						ConcreteElement.getProps(Category.QUERY) ...
						];
				case Category.EVANESCENT
					prop_list = [ ...
						ConcreteElement.getProps(Category.EVANESCENT) ...
						];
				case Category.FIGURE
					prop_list = [ ...
						ConcreteElement.getProps(Category.FIGURE) ...
						];
				case Category.GUI
					prop_list = [ ...
						ConcreteElement.getProps(Category.GUI) ...
						];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of neural network evaluator.
			%
			% N = NNEvaluator.GETPROPNUMBER() returns the property number of neural network evaluator.
			%
			% N = NNEvaluator.GETPROPNUMBER(CATEGORY) returns the property number of neural network evaluator
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = NNE.GETPROPNUMBER([CATEGORY]) returns the property number of the neural network evaluator NNE.
			%  N = Element.GETPROPNUMBER(NNE) returns the property number of 'NNE'.
			%  N = Element.GETPROPNUMBER('NNEvaluator') returns the property number of 'NNEvaluator'.
			%
			% Note that the Element.GETPROPNUMBER(NNE) and Element.GETPROPNUMBER('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			prop_number = numel(NNEvaluator.getProps(varargin{:}));
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in neural network evaluator/error.
			%
			% CHECK = NNEvaluator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSPROP(PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNE, PROP) checks whether PROP exists for NNE.
			%  CHECK = Element.EXISTSPROP(NNEvaluator, PROP) checks whether PROP exists for NNEvaluator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:NNEvaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSPROP(PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%  Element.EXISTSPROP(NNE, PROP) throws error if PROP does NOT exist for NNE.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%  Element.EXISTSPROP(NNEvaluator, PROP) throws error if PROP does NOT exist for NNEvaluator.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%
			% Note that the Element.EXISTSPROP(NNE) and Element.EXISTSPROP('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(prop == NNEvaluator.getProps());
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for NNEvaluator.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in neural network evaluator/error.
			%
			% CHECK = NNEvaluator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = NNE.EXISTSTAG(TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNE, TAG) checks whether TAG exists for NNE.
			%  CHECK = Element.EXISTSTAG(NNEvaluator, TAG) checks whether TAG exists for NNEvaluator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:NNEvaluator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  NNE.EXISTSTAG(TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%  Element.EXISTSTAG(NNE, TAG) throws error if TAG does NOT exist for NNE.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%  Element.EXISTSTAG(NNEvaluator, TAG) throws error if TAG does NOT exist for NNEvaluator.
			%   Error id: [BRAPH2:NNEvaluator:WrongInput]
			%
			% Note that the Element.EXISTSTAG(NNE) and Element.EXISTSTAG('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			nnevaluator_tag_list = cellfun(@(x) NNEvaluator.getPropTag(x), num2cell(NNEvaluator.getProps()), 'UniformOutput', false);
			check = any(strcmp(tag, nnevaluator_tag_list));
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tag ' is not a valid tag for NNEvaluator.'] ...
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
			%  PROPERTY = NNE.GETPROPPROP(POINTER) returns property number of POINTER of NNE.
			%  PROPERTY = Element.GETPROPPROP(NNEvaluator, POINTER) returns property number of POINTER of NNEvaluator.
			%  PROPERTY = NNE.GETPROPPROP(NNEvaluator, POINTER) returns property number of POINTER of NNEvaluator.
			%
			% Note that the Element.GETPROPPROP(NNE) and Element.GETPROPPROP('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				nnevaluator_tag_list = cellfun(@(x) NNEvaluator.getPropTag(x), num2cell(NNEvaluator.getProps()), 'UniformOutput', false);
				prop = find(strcmp(pointer, nnevaluator_tag_list)); % tag = pointer
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
			%  TAG = NNE.GETPROPTAG(POINTER) returns tag of POINTER of NNE.
			%  TAG = Element.GETPROPTAG(NNEvaluator, POINTER) returns tag of POINTER of NNEvaluator.
			%  TAG = NNE.GETPROPTAG(NNEvaluator, POINTER) returns tag of POINTER of NNEvaluator.
			%
			% Note that the Element.GETPROPTAG(NNE) and Element.GETPROPTAG('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				prop = pointer;
				
				switch prop
					case NNEvaluator.NN
						tag = NNEvaluator.NN_TAG;
					case NNEvaluator.D
						tag = NNEvaluator.D_TAG;
					otherwise
						tag = getPropTag@ConcreteElement(prop);
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
			%  CATEGORY = NNE.GETPROPCATEGORY(POINTER) returns category of POINTER of NNE.
			%  CATEGORY = Element.GETPROPCATEGORY(NNEvaluator, POINTER) returns category of POINTER of NNEvaluator.
			%  CATEGORY = NNE.GETPROPCATEGORY(NNEvaluator, POINTER) returns category of POINTER of NNEvaluator.
			%
			% Note that the Element.GETPROPCATEGORY(NNE) and Element.GETPROPCATEGORY('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.NN
					prop_category = NNEvaluator.NN_CATEGORY;
				case NNEvaluator.D
					prop_category = NNEvaluator.D_CATEGORY;
				otherwise
					prop_category = getPropCategory@ConcreteElement(prop);
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
			%  FORMAT = NNE.GETPROPFORMAT(POINTER) returns format of POINTER of NNE.
			%  FORMAT = Element.GETPROPFORMAT(NNEvaluator, POINTER) returns format of POINTER of NNEvaluator.
			%  FORMAT = NNE.GETPROPFORMAT(NNEvaluator, POINTER) returns format of POINTER of NNEvaluator.
			%
			% Note that the Element.GETPROPFORMAT(NNE) and Element.GETPROPFORMAT('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.NN
					prop_format = NNEvaluator.NN_FORMAT;
				case NNEvaluator.D
					prop_format = NNEvaluator.D_FORMAT;
				otherwise
					prop_format = getPropFormat@ConcreteElement(prop);
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
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of NNE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(NNEvaluator, POINTER) returns description of POINTER of NNEvaluator.
			%  DESCRIPTION = NNE.GETPROPDESCRIPTION(NNEvaluator, POINTER) returns description of POINTER of NNEvaluator.
			%
			% Note that the Element.GETPROPDESCRIPTION(NNE) and Element.GETPROPDESCRIPTION('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.NN
					prop_description = 'NN (data, item) contains a trained neural network model.';
				case NNEvaluator.D
					prop_description = 'D (data, item) is the dataset to evaluate the neural network model.';
				case NNEvaluator.ELCLASS
					prop_description = 'ELCLASS (constant, string) is the class of the % % % .';
				case NNEvaluator.NAME
					prop_description = 'NAME (constant, string) is the name of the evaluator for the neural network analysis.';
				case NNEvaluator.DESCRIPTION
					prop_description = 'DESCRIPTION (constant, string) is the description of the evaluator for the neural network analysis.';
				case NNEvaluator.TEMPLATE
					prop_description = 'TEMPLATE (parameter, item) is the template of the evaluator for the neural network analysis.';
				case NNEvaluator.ID
					prop_description = 'ID (data, string) is a few-letter code for the evaluator for the neural network analysis.';
				case NNEvaluator.LABEL
					prop_description = 'LABEL (metadata, string) is an extended label of the evaluator for the neural network analysis.';
				case NNEvaluator.NOTES
					prop_description = 'NOTES (metadata, string) are some specific notes about the evaluator for the neural network analysis.';
				otherwise
					prop_description = getPropDescription@ConcreteElement(prop);
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
			%  SETTINGS = NNE.GETPROPSETTINGS(POINTER) returns settings of POINTER of NNE.
			%  SETTINGS = Element.GETPROPSETTINGS(NNEvaluator, POINTER) returns settings of POINTER of NNEvaluator.
			%  SETTINGS = NNE.GETPROPSETTINGS(NNEvaluator, POINTER) returns settings of POINTER of NNEvaluator.
			%
			% Note that the Element.GETPROPSETTINGS(NNE) and Element.GETPROPSETTINGS('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.NN
					prop_settings = 'NNBase';
				case NNEvaluator.D
					prop_settings = 'NNDataset';
				case NNEvaluator.TEMPLATE
					prop_settings = 'NNEvaluator';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = NNEvaluator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = NNEvaluator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULT(NNEvaluator, POINTER) returns the default value of POINTER of NNEvaluator.
			%  DEFAULT = NNE.GETPROPDEFAULT(NNEvaluator, POINTER) returns the default value of POINTER of NNEvaluator.
			%
			% Note that the Element.GETPROPDEFAULT(NNE) and Element.GETPROPDEFAULT('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.NN
					prop_default = Format.getFormatDefault(Format.ITEM, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.D
					prop_default = Format.getFormatDefault(Format.ITEM, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.ELCLASS
					prop_default = 'NNEvaluator';
				case NNEvaluator.NAME
					prop_default = 'NNEvaluator';
				case NNEvaluator.DESCRIPTION
					prop_default = 'A neural network evaluator (NNEvaluator) evaluates the performance of a neural network model with a specific dataset. Instances of this class should not be created. Use one of its subclasses instead. Its subclasses shall be specifically designed to cater to different evaluation cases such as a classification task, a regression task, or a data generation task.';
				case NNEvaluator.TEMPLATE
					prop_default = Format.getFormatDefault(Format.ITEM, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.ID
					prop_default = 'NNEvaluator ID';
				case NNEvaluator.LABEL
					prop_default = 'NNEvaluator label';
				case NNEvaluator.NOTES
					prop_default = 'NNEvaluator notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = NNEvaluator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = NNEvaluator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of NNE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(NNEvaluator, POINTER) returns the conditioned default value of POINTER of NNEvaluator.
			%  DEFAULT = NNE.GETPROPDEFAULTCONDITIONED(NNEvaluator, POINTER) returns the conditioned default value of POINTER of NNEvaluator.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(NNE) and Element.GETPROPDEFAULTCONDITIONED('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			prop_default = NNEvaluator.conditioning(prop, NNEvaluator.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = NNE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = NNE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of NNE.
			%  CHECK = Element.CHECKPROP(NNEvaluator, PROP, VALUE) checks VALUE format for PROP of NNEvaluator.
			%  CHECK = NNE.CHECKPROP(NNEvaluator, PROP, VALUE) checks VALUE format for PROP of NNEvaluator.
			% 
			% NNE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: €BRAPH2.STR€:NNEvaluator:€BRAPH2.WRONG_INPUT€
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  NNE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of NNE.
			%   Error id: €BRAPH2.STR€:NNEvaluator:€BRAPH2.WRONG_INPUT€
			%  Element.CHECKPROP(NNEvaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNEvaluator.
			%   Error id: €BRAPH2.STR€:NNEvaluator:€BRAPH2.WRONG_INPUT€
			%  NNE.CHECKPROP(NNEvaluator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of NNEvaluator.
			%   Error id: €BRAPH2.STR€:NNEvaluator:€BRAPH2.WRONG_INPUT€]
			% 
			% Note that the Element.CHECKPROP(NNE) and Element.CHECKPROP('NNEvaluator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = NNEvaluator.getPropProp(pointer);
			
			switch prop
				case NNEvaluator.NN % __NNEvaluator.NN__
					check = Format.checkFormat(Format.ITEM, value, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.D % __NNEvaluator.D__
					check = Format.checkFormat(Format.ITEM, value, NNEvaluator.getPropSettings(prop));
				case NNEvaluator.TEMPLATE % __NNEvaluator.TEMPLATE__
					check = Format.checkFormat(Format.ITEM, value, NNEvaluator.getPropSettings(prop));
				otherwise
					if prop <= ConcreteElement.getPropNumber()
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':NNEvaluator:' BRAPH2.WRONG_INPUT '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' NNEvaluator.getPropTag(prop) ' (' NNEvaluator.getFormatTag(NNEvaluator.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
end
