classdef PanelPropRVectorSmart < PanelPropString
	%PanelPropRVectorSmart plots the panel of a smart row vector.
	% It is a subclass of <a href="matlab:help PanelPropString">PanelPropString</a>.
	%
	% A Smart Row-Vector Prop Panel (PanelPropRVEctorSmart) plots the panel 
	%  for a row vector with an edit field. Smart means that (almost) any MatLab 
	%  expression leading to a correct row vector can be introduced in the edit field.
	%  Also, the value of the vector can be limited between some MIN and MAX.
	% It works for all categories, exept for Category.RESULT, Category.QUERY, or Category.EVANESCENT.
	%
	% The list of PanelPropRVectorSmart properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the smart row-vector prop panel.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the smart row-vector prop panel.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the smart row-vector prop panel.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the smart row-vector prop panel.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the smart row-vector prop panel.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the smart row-vector prop panel.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the smart row-vector prop panel.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the prop panel.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the prop panel.
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the editfield.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the prop number.
	%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the prop panel.
	%  <strong>26</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
	%  <strong>27</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
	%  <strong>28</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
	%  <strong>29</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
	%  <strong>30</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
	%  <strong>31</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>32</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>33</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
	%  <strong>34</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
	%  <strong>35</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
	%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.
	%  <strong>37</strong> <strong>EDITFIELD</strong> 	EDITFIELD (evanescent, handle) is the string value edit field with a smart row vector.
	%  <strong>38</strong> <strong>MAX</strong> 	MAX (parameter, scalar) is the max value acceptable as input.
	%  <strong>39</strong> <strong>MIN</strong> 	MIN (parameter, scalar) is the min value acceptable as input.
	%  <strong>40</strong> <strong>UNIQUE_VALUE</strong> 	UNIQUE_VALUE (parameter, logical) determines if sorting the data with no repetitions.
	%  <strong>41</strong> <strong>DEFAULT</strong> 	DEFAULT (parameter, rvector) is the default value.
	%
	% PanelPropRVectorSmart methods (constructor):
	%  PanelPropRVectorSmart - constructor
	%
	% PanelPropRVectorSmart methods:
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
	% PanelPropRVectorSmart methods (display):
	%  tostring - string with information about the smart row-vector prop panel
	%  disp - displays information about the smart row-vector prop panel
	%  tree - displays the tree of the smart row-vector prop panel
	%
	% PanelPropRVectorSmart methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two smart row-vector prop panel are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the smart row-vector prop panel
	%
	% PanelPropRVectorSmart methods (save/load, Static):
	%  save - saves BRAPH2 smart row-vector prop panel as b2 file
	%  load - loads a BRAPH2 smart row-vector prop panel from a b2 file
	%
	% PanelPropRVectorSmart method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the smart row-vector prop panel
	%
	% PanelPropRVectorSmart method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the smart row-vector prop panel
	%
	% PanelPropRVectorSmart methods (inspection, Static):
	%  getClass - returns the class of the smart row-vector prop panel
	%  getSubclasses - returns all subclasses of PanelPropRVectorSmart
	%  getProps - returns the property list of the smart row-vector prop panel
	%  getPropNumber - returns the property number of the smart row-vector prop panel
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
	% PanelPropRVectorSmart methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% PanelPropRVectorSmart methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% PanelPropRVectorSmart methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% PanelPropRVectorSmart methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?PanelPropRVectorSmart; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">PanelPropRVectorSmart constants</a>.
	%
	%
	% See also uieditfield, GUI, PanelElement.
	
	properties (Constant) % properties
		MAX = 38; %CET: Computational Efficiency Trick
		MAX_TAG = 'MAX';
		MAX_CATEGORY = 3;
		MAX_FORMAT = 11;
		
		MIN = 39; %CET: Computational Efficiency Trick
		MIN_TAG = 'MIN';
		MIN_CATEGORY = 3;
		MIN_FORMAT = 11;
		
		UNIQUE_VALUE = 40; %CET: Computational Efficiency Trick
		UNIQUE_VALUE_TAG = 'UNIQUE_VALUE';
		UNIQUE_VALUE_CATEGORY = 3;
		UNIQUE_VALUE_FORMAT = 4;
		
		DEFAULT = 41; %CET: Computational Efficiency Trick
		DEFAULT_TAG = 'DEFAULT';
		DEFAULT_CATEGORY = 3;
		DEFAULT_FORMAT = 12;
	end
	methods % constructor
		function pr = PanelPropRVectorSmart(varargin)
			%PanelPropRVectorSmart() creates a smart row-vector prop panel.
			%
			% PanelPropRVectorSmart(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% PanelPropRVectorSmart(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of PanelPropRVectorSmart properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the smart row-vector prop panel.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the smart row-vector prop panel.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the smart row-vector prop panel.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the smart row-vector prop panel.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the smart row-vector prop panel.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the smart row-vector prop panel.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the smart row-vector prop panel.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the prop panel.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the prop panel.
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the editfield.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the prop number.
			%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the prop panel.
			%  <strong>26</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
			%  <strong>27</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
			%  <strong>28</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
			%  <strong>29</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
			%  <strong>30</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
			%  <strong>31</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>32</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>33</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
			%  <strong>34</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
			%  <strong>35</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
			%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.
			%  <strong>37</strong> <strong>EDITFIELD</strong> 	EDITFIELD (evanescent, handle) is the string value edit field with a smart row vector.
			%  <strong>38</strong> <strong>MAX</strong> 	MAX (parameter, scalar) is the max value acceptable as input.
			%  <strong>39</strong> <strong>MIN</strong> 	MIN (parameter, scalar) is the min value acceptable as input.
			%  <strong>40</strong> <strong>UNIQUE_VALUE</strong> 	UNIQUE_VALUE (parameter, logical) determines if sorting the data with no repetitions.
			%  <strong>41</strong> <strong>DEFAULT</strong> 	DEFAULT (parameter, rvector) is the default value.
			%
			% See also Category, Format.
			
			pr = pr@PanelPropString(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the smart row-vector prop panel.
			%
			% CLASS = PanelPropRVectorSmart.GETCLASS() returns the class 'PanelPropRVectorSmart'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the smart row-vector prop panel PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('PanelPropRVectorSmart') returns 'PanelPropRVectorSmart'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('PanelPropRVectorSmart')
			%  are less computationally efficient.
			
			pr_class = 'PanelPropRVectorSmart';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the smart row-vector prop panel.
			%
			% LIST = PanelPropRVectorSmart.GETSUBCLASSES() returns all subclasses of 'PanelPropRVectorSmart'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the smart row-vector prop panel PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('PanelPropRVectorSmart') returns all subclasses of 'PanelPropRVectorSmart'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'PanelPropRVectorSmart' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of smart row-vector prop panel.
			%
			% PROPS = PanelPropRVectorSmart.GETPROPS() returns the property list of smart row-vector prop panel
			%  as a row vector.
			%
			% PROPS = PanelPropRVectorSmart.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the smart row-vector prop panel PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('PanelPropRVectorSmart'[, CATEGORY]) returns the property list of 'PanelPropRVectorSmart'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 38 39 40 41];
				case 4 % Category.DATA
					prop_list = [5 23 24 29];
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 20 21 22];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 27 28 30 31 32 33 34 35 37];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of smart row-vector prop panel.
			%
			% N = PanelPropRVectorSmart.GETPROPNUMBER() returns the property number of smart row-vector prop panel.
			%
			% N = PanelPropRVectorSmart.GETPROPNUMBER(CATEGORY) returns the property number of smart row-vector prop panel
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the smart row-vector prop panel PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('PanelPropRVectorSmart') returns the property number of 'PanelPropRVectorSmart'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 41;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 5;
				case 4 % Category.DATA
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 10;
				case 7 % Category.EVANESCENT
					prop_number = 11;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 5;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in smart row-vector prop panel/error.
			%
			% CHECK = PanelPropRVectorSmart.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PanelPropRVectorSmart, PROP) checks whether PROP exists for PanelPropRVectorSmart.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%  Element.EXISTSPROP(PanelPropRVectorSmart, PROP) throws error if PROP does NOT exist for PanelPropRVectorSmart.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 41 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropRVectorSmart:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropRVectorSmart:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for PanelPropRVectorSmart.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in smart row-vector prop panel/error.
			%
			% CHECK = PanelPropRVectorSmart.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PanelPropRVectorSmart, TAG) checks whether TAG exists for PanelPropRVectorSmart.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%  Element.EXISTSTAG(PanelPropRVectorSmart, TAG) throws error if TAG does NOT exist for PanelPropRVectorSmart.
			%   Error id: [BRAPH2:PanelPropRVectorSmart:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'EDITFIELD'  'MAX'  'MIN'  'UNIQUE_VALUE'  'DEFAULT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropRVectorSmart:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropRVectorSmart:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for PanelPropRVectorSmart.'] ...
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
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(PanelPropRVectorSmart, POINTER) returns property number of POINTER of PanelPropRVectorSmart.
			%  PROPERTY = PR.GETPROPPROP(PanelPropRVectorSmart, POINTER) returns property number of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'EDITFIELD'  'MAX'  'MIN'  'UNIQUE_VALUE'  'DEFAULT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(PanelPropRVectorSmart, POINTER) returns tag of POINTER of PanelPropRVectorSmart.
			%  TAG = PR.GETPROPTAG(PanelPropRVectorSmart, POINTER) returns tag of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				panelproprvectorsmart_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'EDITFIELD'  'MAX'  'MIN'  'UNIQUE_VALUE'  'DEFAULT' };
				tag = panelproprvectorsmart_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(PanelPropRVectorSmart, POINTER) returns category of POINTER of PanelPropRVectorSmart.
			%  CATEGORY = PR.GETPROPCATEGORY(PanelPropRVectorSmart, POINTER) returns category of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelproprvectorsmart_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  7  3  3  3  3 };
			prop_category = panelproprvectorsmart_category_list{prop};
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(PanelPropRVectorSmart, POINTER) returns format of POINTER of PanelPropRVectorSmart.
			%  FORMAT = PR.GETPROPFORMAT(PanelPropRVectorSmart, POINTER) returns format of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelproprvectorsmart_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  18  11  11  4  12 };
			prop_format = panelproprvectorsmart_format_list{prop};
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(PanelPropRVectorSmart, POINTER) returns description of POINTER of PanelPropRVectorSmart.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(PanelPropRVectorSmart, POINTER) returns description of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			panelproprvectorsmart_description_list = { 'ELCLASS (constant, string) is the class of the smart row-vector prop panel.'  'NAME (constant, string) is the name of the smart row-vector prop panel.'  'DESCRIPTION (constant, string) is the description of the smart row-vector prop panel.'  'TEMPLATE (parameter, item) is the template of the smart row-vector prop panel.'  'ID (data, string) is a few-letter code for the smart row-vector prop panel.'  'LABEL (metadata, string) is an extended label of the smart row-vector prop panel.'  'NOTES (metadata, string) are some specific notes about the smart row-vector prop panel.'  'TOSTRING (query, string) returns a string that represents the object.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the prop panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the prop panel.'  'UPDATE (query, logical) updates the content and permissions of the editfield.'  'REDRAW (query, logical) resizes the prop panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the prop number.'  'HEIGHT (gui, size) is the pixel height of the prop panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.'  'EDITFIELD (evanescent, handle) is the string value edit field with a smart row vector.'  'MAX (parameter, scalar) is the max value acceptable as input.'  'MIN (parameter, scalar) is the min value acceptable as input.'  'UNIQUE_VALUE (parameter, logical) determines if sorting the data with no repetitions.'  'DEFAULT (parameter, rvector) is the default value.' };
			prop_description = panelproprvectorsmart_description_list{prop};
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(PanelPropRVectorSmart, POINTER) returns settings of POINTER of PanelPropRVectorSmart.
			%  SETTINGS = PR.GETPROPSETTINGS(PanelPropRVectorSmart, POINTER) returns settings of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 38 % PanelPropRVectorSmart.MAX
					prop_settings = Format.getFormatSettings(11);
				case 39 % PanelPropRVectorSmart.MIN
					prop_settings = Format.getFormatSettings(11);
				case 40 % PanelPropRVectorSmart.UNIQUE_VALUE
					prop_settings = Format.getFormatSettings(4);
				case 41 % PanelPropRVectorSmart.DEFAULT
					prop_settings = Format.getFormatSettings(12);
				case 4 % PanelPropRVectorSmart.TEMPLATE
					prop_settings = 'PanelPropRVectorSmart';
				otherwise
					prop_settings = getPropSettings@PanelPropString(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = PanelPropRVectorSmart.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropRVectorSmart.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(PanelPropRVectorSmart, POINTER) returns the default value of POINTER of PanelPropRVectorSmart.
			%  DEFAULT = PR.GETPROPDEFAULT(PanelPropRVectorSmart, POINTER) returns the default value of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 38 % PanelPropRVectorSmart.MAX
					prop_default = +Inf;
				case 39 % PanelPropRVectorSmart.MIN
					prop_default = -Inf;
				case 40 % PanelPropRVectorSmart.UNIQUE_VALUE
					prop_default = true;
				case 41 % PanelPropRVectorSmart.DEFAULT
					prop_default = Format.getFormatDefault(12, PanelPropRVectorSmart.getPropSettings(prop));
				case 1 % PanelPropRVectorSmart.ELCLASS
					prop_default = 'PanelPropRVectorSmart';
				case 2 % PanelPropRVectorSmart.NAME
					prop_default = 'Smart Row-Vector Prop Panel';
				case 3 % PanelPropRVectorSmart.DESCRIPTION
					prop_default = 'A Smart Row-Vector Prop Panel (PanelPropRVEctorSmart) plots the panel for a row vector with an edit field. Smart means that (almost) any MatLab expression leading to a correct row vector can be introduced in the edit field. Also, the value of the vector can be limited between some MIN and MAX. It works for all categories, exept for Category.RESULT, Category.QUERY, or Category.EVANESCENT.';
				case 4 % PanelPropRVectorSmart.TEMPLATE
					prop_default = Format.getFormatDefault(8, PanelPropRVectorSmart.getPropSettings(prop));
				case 5 % PanelPropRVectorSmart.ID
					prop_default = 'PanelPropRVectorSmart ID';
				case 6 % PanelPropRVectorSmart.LABEL
					prop_default = 'PanelPropRVectorSmart label';
				case 7 % PanelPropRVectorSmart.NOTES
					prop_default = 'PanelPropRVectorSmart notes';
				case 23 % PanelPropRVectorSmart.EL
					prop_default = Graph();
				case 24 % PanelPropRVectorSmart.PROP
					prop_default = 14;
				otherwise
					prop_default = getPropDefault@PanelPropString(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = PanelPropRVectorSmart.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = PanelPropRVectorSmart.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(PanelPropRVectorSmart, POINTER) returns the conditioned default value of POINTER of PanelPropRVectorSmart.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(PanelPropRVectorSmart, POINTER) returns the conditioned default value of POINTER of PanelPropRVectorSmart.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			prop_default = PanelPropRVectorSmart.conditioning(prop, PanelPropRVectorSmart.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(PanelPropRVectorSmart, PROP, VALUE) checks VALUE format for PROP of PanelPropRVectorSmart.
			%  CHECK = PR.CHECKPROP(PanelPropRVectorSmart, PROP, VALUE) checks VALUE format for PROP of PanelPropRVectorSmart.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:PanelPropRVectorSmart:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:PanelPropRVectorSmart:WrongInput
			%  Element.CHECKPROP(PanelPropRVectorSmart, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropRVectorSmart.
			%   Error id: BRAPH2:PanelPropRVectorSmart:WrongInput
			%  PR.CHECKPROP(PanelPropRVectorSmart, PROP, VALUE) throws error if VALUE has not a valid format for PROP of PanelPropRVectorSmart.
			%   Error id: BRAPH2:PanelPropRVectorSmart:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('PanelPropRVectorSmart')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = PanelPropRVectorSmart.getPropProp(pointer);
			
			switch prop
				case 38 % PanelPropRVectorSmart.MAX
					check = Format.checkFormat(11, value, PanelPropRVectorSmart.getPropSettings(prop));
				case 39 % PanelPropRVectorSmart.MIN
					check = Format.checkFormat(11, value, PanelPropRVectorSmart.getPropSettings(prop));
				case 40 % PanelPropRVectorSmart.UNIQUE_VALUE
					check = Format.checkFormat(4, value, PanelPropRVectorSmart.getPropSettings(prop));
				case 41 % PanelPropRVectorSmart.DEFAULT
					check = Format.checkFormat(12, value, PanelPropRVectorSmart.getPropSettings(prop));
				case 4 % PanelPropRVectorSmart.TEMPLATE
					check = Format.checkFormat(8, value, PanelPropRVectorSmart.getPropSettings(prop));
				otherwise
					if prop <= 37
						check = checkProp@PanelPropString(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':PanelPropRVectorSmart:' 'WrongInput'], ...
					['BRAPH2' ':PanelPropRVectorSmart:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' PanelPropRVectorSmart.getPropTag(prop) ' (' PanelPropRVectorSmart.getFormatTag(PanelPropRVectorSmart.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 21 % PanelPropRVectorSmart.UPDATE
					value = calculateValue@PanelProp(pr, 21, varargin{:}); % skips PanelPropString.UPDATE % also warning
					if value
					    el = pr.get('EL');
					    prop = pr.get('PROP');
					    
					    switch el.getPropCategory(prop)
					        case 1
					            set(pr.get('EDITFIELD'), ...
					                'Value', mat2str(el.get(prop)), ...
					                'Editable', 'off', ...
					                'Enable', pr.get('ENABLE') ...
					                )
					            
					        case 2
					            set(pr.get('EDITFIELD'), 'Value', mat2str(el.get(prop)))
					
					            if el.isLocked(prop)
					                set(pr.get('EDITFIELD'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					            
					        case {3, 4, 8, 9}
					            set(pr.get('EDITFIELD'), 'Value', mat2str(el.get(prop)))
					
					            prop_value = el.getr(prop);
					            if el.isLocked(prop) || isa(prop_value, 'Callback')
					                set(pr.get('EDITFIELD'), ...
					                    'Editable', 'off', ...
					                    'Enable', pr.get('ENABLE') ...
					                    )
					            end
					
					        case {5 6 7}
					            error(['BRAPH2' ':PanelPropRVectorSmart:' 'ErrorFunc'], ...
					                'PanelPropRVectorSmart should not be used with Category.RESULT, Category.QUERY, or Category.EVANESCENT.')
					    end
					end
					
				case 37 % PanelPropRVectorSmart.EDITFIELD
					el = pr.get('EL');
					prop = pr.get('PROP');
					
					editfield = uieditfield( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'EDITFIELD', ...
					    'FontSize', 12, ...
					    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
					    'ValueChangedFcn', {@cb_editfield} ...
					    );
					
					value = editfield;
					
				otherwise
					if prop <= 37
						value = calculateValue@PanelPropString(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
			function cb_editfield(~, ~)
			    el = pr.get('EL');
			    prop = pr.get('PROP');
			
			    try 
			        value = eval(['[' get(pr.get('EDITFIELD'), 'Value') ']']);
			        if pr.get('UNIQUE_VALUE')
			            value = unique(value(:)'); % sort done by unique
			        end
			        value(value < pr.get('MIN')) = pr.get('MIN');
			        value(value > pr.get('MAX')) = pr.get('MAX');
			        
			        if isempty(value)
			            value = pr.get('DEFAULT');
			        end
			    catch
			        value = el.get(prop);
			    end
			    
			    el.set(prop, value)
			end
		end
	end
end