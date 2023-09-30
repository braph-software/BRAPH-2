classdef ComparisonEnsembleBrainPF < BrainAtlasPF
	%ComparisonEnsembleBrainPF is the base element to plot an ensemble-based comparison on brain surface figure.
	% It is a subclass of <a href="matlab:help BrainAtlasPF">BrainAtlasPF</a>.
	%
	% ComparisonEnsembleBrainPF manages the basic functionalities to plot of an ensemble-based comparison on brain surface figure.
	%
	% The list of ComparisonEnsembleBrainPF properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of % % % .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel ensemble-based comparison figure on brain surface.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure on brain surface.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure on brain surface.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel ensemble-based comparison figure on brain surface.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure on brain surface.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure on brain surface.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure brain atlas.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
	%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
	%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
	%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
	%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
	%  <strong>24</strong> <strong>VIEW</strong> 	VIEW (figure, rvector) sets the desired view as the line-of-sight azimuth and elevation angles.
	%  <strong>25</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
	%  <strong>26</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
	%  <strong>27</strong> <strong>SURFFILE</strong> 	SURFFILE (figure, option) is the name of the file of the brain surface to be plotted.
	%  <strong>28</strong> <strong>SURF</strong> 	SURF (metadata, item) is the brain surface to be plotted.
	%  <strong>29</strong> <strong>H_BRAIN</strong> 	H_BRAIN (evanescent, handle) is the handle for brain surface.
	%  <strong>30</strong> <strong>BRAIN</strong> 	BRAIN (figure, logical) determines whether the brain surface is shown.
	%  <strong>31</strong> <strong>ST_SURFACE</strong> 	ST_SURFACE (figure, item) determines the surface settings.
	%  <strong>32</strong> <strong>ST_AMBIENT</strong> 	ST_AMBIENT (figure, item) determines the ambient settings.
	%  <strong>33</strong> <strong>BA</strong> 	BA (metadata, item) is the brain atlas with the brain regions.
	%  <strong>34</strong> <strong>H_SPHS</strong> 	H_SPHS (evanescent, handlelist) is the set of handles for the spheres.
	%  <strong>35</strong> <strong>SPHS</strong> 	SPHS (figure, logical) determines whether the spheres are shown.
	%  <strong>36</strong> <strong>SPH_DICT</strong> 	SPH_DICT (figure, idict) contains the spheres of the brain regions.
	%  <strong>37</strong> <strong>H_SYMS</strong> 	H_SYMS (evanescent, handlelist) is the set of handles for the symbols.
	%  <strong>38</strong> <strong>SYMS</strong> 	SYMS (figure, logical) determines whether the symbols are shown.
	%  <strong>39</strong> <strong>SYM_DICT</strong> 	SYM_DICT (figure, idict) contains the symbols of the brain regions.
	%  <strong>40</strong> <strong>H_IDS</strong> 	H_IDS (evanescent, handlelist) is the set of handles for the ids.
	%  <strong>41</strong> <strong>IDS</strong> 	IDS (figure, logical) determines whether the ids are shown.
	%  <strong>42</strong> <strong>ID_DICT</strong> 	ID_DICT (figure, idict) contains the ids of the brain regions.
	%  <strong>43</strong> <strong>H_LABS</strong> 	H_LABS (evanescent, handlelist) is the set of handles for the labels.
	%  <strong>44</strong> <strong>LABS</strong> 	LABS (figure, logical) determines whether the labels are shown.
	%  <strong>45</strong> <strong>LAB_DICT</strong> 	LAB_DICT (figure, idict) contains the labels of the brain regions.
	%  <strong>46</strong> <strong>CP</strong> 	CP (metadata, item) is the measure.
	%  <strong>47</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the diff value and stores it to be implemented in the subelements.
	%
	% ComparisonEnsembleBrainPF methods (constructor):
	%  ComparisonEnsembleBrainPF - constructor
	%
	% ComparisonEnsembleBrainPF methods:
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
	% ComparisonEnsembleBrainPF methods (display):
	%  tostring - string with information about the panel ensemble-based comparison figure on brain surface figure
	%  disp - displays information about the panel ensemble-based comparison figure on brain surface figure
	%  tree - displays the tree of the panel ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel ensemble-based comparison figure on brain surface figure are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF methods (save/load, Static):
	%  save - saves BRAPH2 panel ensemble-based comparison figure on brain surface figure as b2 file
	%  load - loads a BRAPH2 panel ensemble-based comparison figure on brain surface figure from a b2 file
	%
	% ComparisonEnsembleBrainPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel ensemble-based comparison figure on brain surface figure
	%
	% ComparisonEnsembleBrainPF methods (inspection, Static):
	%  getClass - returns the class of the panel ensemble-based comparison figure on brain surface figure
	%  getSubclasses - returns all subclasses of ComparisonEnsembleBrainPF
	%  getProps - returns the property list of the panel ensemble-based comparison figure on brain surface figure
	%  getPropNumber - returns the property number of the panel ensemble-based comparison figure on brain surface figure
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
	% ComparisonEnsembleBrainPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ComparisonEnsembleBrainPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ComparisonEnsembleBrainPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ComparisonEnsembleBrainPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ComparisonEnsembleBrainPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ComparisonEnsembleBrainPF constants</a>.
	%
	%
	% See also ComparisonEnsemble.
	
	properties (Constant) % properties
		CP = 46; %CET: Computational Efficiency Trick
		CP_TAG = 'CP';
		CP_CATEGORY = 2;
		CP_FORMAT = 8;
		
		SETUP = 47; %CET: Computational Efficiency Trick
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = 6;
		SETUP_FORMAT = 1;
	end
	methods % constructor
		function pf = ComparisonEnsembleBrainPF(varargin)
			%ComparisonEnsembleBrainPF() creates a panel ensemble-based comparison figure on brain surface figure.
			%
			% ComparisonEnsembleBrainPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ComparisonEnsembleBrainPF(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ComparisonEnsembleBrainPF properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of % % % .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel ensemble-based comparison figure on brain surface.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure on brain surface.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure on brain surface.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel ensemble-based comparison figure on brain surface.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure on brain surface.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure on brain surface.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the object.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure brain atlas.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
			%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
			%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
			%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
			%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
			%  <strong>24</strong> <strong>VIEW</strong> 	VIEW (figure, rvector) sets the desired view as the line-of-sight azimuth and elevation angles.
			%  <strong>25</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
			%  <strong>26</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
			%  <strong>27</strong> <strong>SURFFILE</strong> 	SURFFILE (figure, option) is the name of the file of the brain surface to be plotted.
			%  <strong>28</strong> <strong>SURF</strong> 	SURF (metadata, item) is the brain surface to be plotted.
			%  <strong>29</strong> <strong>H_BRAIN</strong> 	H_BRAIN (evanescent, handle) is the handle for brain surface.
			%  <strong>30</strong> <strong>BRAIN</strong> 	BRAIN (figure, logical) determines whether the brain surface is shown.
			%  <strong>31</strong> <strong>ST_SURFACE</strong> 	ST_SURFACE (figure, item) determines the surface settings.
			%  <strong>32</strong> <strong>ST_AMBIENT</strong> 	ST_AMBIENT (figure, item) determines the ambient settings.
			%  <strong>33</strong> <strong>BA</strong> 	BA (metadata, item) is the brain atlas with the brain regions.
			%  <strong>34</strong> <strong>H_SPHS</strong> 	H_SPHS (evanescent, handlelist) is the set of handles for the spheres.
			%  <strong>35</strong> <strong>SPHS</strong> 	SPHS (figure, logical) determines whether the spheres are shown.
			%  <strong>36</strong> <strong>SPH_DICT</strong> 	SPH_DICT (figure, idict) contains the spheres of the brain regions.
			%  <strong>37</strong> <strong>H_SYMS</strong> 	H_SYMS (evanescent, handlelist) is the set of handles for the symbols.
			%  <strong>38</strong> <strong>SYMS</strong> 	SYMS (figure, logical) determines whether the symbols are shown.
			%  <strong>39</strong> <strong>SYM_DICT</strong> 	SYM_DICT (figure, idict) contains the symbols of the brain regions.
			%  <strong>40</strong> <strong>H_IDS</strong> 	H_IDS (evanescent, handlelist) is the set of handles for the ids.
			%  <strong>41</strong> <strong>IDS</strong> 	IDS (figure, logical) determines whether the ids are shown.
			%  <strong>42</strong> <strong>ID_DICT</strong> 	ID_DICT (figure, idict) contains the ids of the brain regions.
			%  <strong>43</strong> <strong>H_LABS</strong> 	H_LABS (evanescent, handlelist) is the set of handles for the labels.
			%  <strong>44</strong> <strong>LABS</strong> 	LABS (figure, logical) determines whether the labels are shown.
			%  <strong>45</strong> <strong>LAB_DICT</strong> 	LAB_DICT (figure, idict) contains the labels of the brain regions.
			%  <strong>46</strong> <strong>CP</strong> 	CP (metadata, item) is the measure.
			%  <strong>47</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the diff value and stores it to be implemented in the subelements.
			%
			% See also Category, Format.
			
			pf = pf@BrainAtlasPF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel ensemble-based comparison figure on brain surface figure.
			%
			% CLASS = ComparisonEnsembleBrainPF.GETCLASS() returns the class 'ComparisonEnsembleBrainPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel ensemble-based comparison figure on brain surface figure PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('ComparisonEnsembleBrainPF') returns 'ComparisonEnsembleBrainPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			
			pf_class = 'ComparisonEnsembleBrainPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel ensemble-based comparison figure on brain surface figure.
			%
			% LIST = ComparisonEnsembleBrainPF.GETSUBCLASSES() returns all subclasses of 'ComparisonEnsembleBrainPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel ensemble-based comparison figure on brain surface figure PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('ComparisonEnsembleBrainPF') returns all subclasses of 'ComparisonEnsembleBrainPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ComparisonEnsembleBrainPF'  'ComparisonEnsembleBrainPF_BB'  'ComparisonEnsembleBrainPF_BS'  'ComparisonEnsembleBrainPF_BU'  'ComparisonEnsembleBrainPF_GB'  'ComparisonEnsembleBrainPF_GS'  'ComparisonEnsembleBrainPF_GU'  'ComparisonEnsembleBrainPF_NB'  'ComparisonEnsembleBrainPF_NS'  'ComparisonEnsembleBrainPF_NU' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel ensemble-based comparison figure on brain surface figure.
			%
			% PROPS = ComparisonEnsembleBrainPF.GETPROPS() returns the property list of panel ensemble-based comparison figure on brain surface figure
			%  as a row vector.
			%
			% PROPS = ComparisonEnsembleBrainPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel ensemble-based comparison figure on brain surface figure PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('ComparisonEnsembleBrainPF'[, CATEGORY]) returns the property list of 'ComparisonEnsembleBrainPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 28 33 46];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 47];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 21 22 23 26 29 34 37 40 43];
				case 8 % Category.FIGURE
					prop_list = [14 20 24 25 27 30 31 32 35 36 38 39 41 42 44 45];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel ensemble-based comparison figure on brain surface figure.
			%
			% N = ComparisonEnsembleBrainPF.GETPROPNUMBER() returns the property number of panel ensemble-based comparison figure on brain surface figure.
			%
			% N = ComparisonEnsembleBrainPF.GETPROPNUMBER(CATEGORY) returns the property number of panel ensemble-based comparison figure on brain surface figure
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel ensemble-based comparison figure on brain surface figure PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('ComparisonEnsembleBrainPF') returns the property number of 'ComparisonEnsembleBrainPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 47;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 5;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 8;
				case 7 % Category.EVANESCENT
					prop_number = 11;
				case 8 % Category.FIGURE
					prop_number = 16;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel ensemble-based comparison figure on brain surface figure/error.
			%
			% CHECK = ComparisonEnsembleBrainPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(ComparisonEnsembleBrainPF, PROP) checks whether PROP exists for ComparisonEnsembleBrainPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%  Element.EXISTSPROP(ComparisonEnsembleBrainPF, PROP) throws error if PROP does NOT exist for ComparisonEnsembleBrainPF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 47 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonEnsembleBrainPF:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonEnsembleBrainPF:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ComparisonEnsembleBrainPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel ensemble-based comparison figure on brain surface figure/error.
			%
			% CHECK = ComparisonEnsembleBrainPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(ComparisonEnsembleBrainPF, TAG) checks whether TAG exists for ComparisonEnsembleBrainPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%  Element.EXISTSTAG(ComparisonEnsembleBrainPF, TAG) throws error if TAG does NOT exist for ComparisonEnsembleBrainPF.
			%   Error id: [BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'VIEW'  'ST_AXIS'  'LISTENER_ST_AXIS'  'SURFFILE'  'SURF'  'H_BRAIN'  'BRAIN'  'ST_SURFACE'  'ST_AMBIENT'  'BA'  'H_SPHS'  'SPHS'  'SPH_DICT'  'H_SYMS'  'SYMS'  'SYM_DICT'  'H_IDS'  'IDS'  'ID_DICT'  'H_LABS'  'LABS'  'LAB_DICT'  'CP'  'SETUP' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonEnsembleBrainPF:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonEnsembleBrainPF:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ComparisonEnsembleBrainPF.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ComparisonEnsembleBrainPF, POINTER) returns property number of POINTER of ComparisonEnsembleBrainPF.
			%  PROPERTY = PF.GETPROPPROP(ComparisonEnsembleBrainPF, POINTER) returns property number of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'VIEW'  'ST_AXIS'  'LISTENER_ST_AXIS'  'SURFFILE'  'SURF'  'H_BRAIN'  'BRAIN'  'ST_SURFACE'  'ST_AMBIENT'  'BA'  'H_SPHS'  'SPHS'  'SPH_DICT'  'H_SYMS'  'SYMS'  'SYM_DICT'  'H_IDS'  'IDS'  'ID_DICT'  'H_LABS'  'LABS'  'LAB_DICT'  'CP'  'SETUP' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(ComparisonEnsembleBrainPF, POINTER) returns tag of POINTER of ComparisonEnsembleBrainPF.
			%  TAG = PF.GETPROPTAG(ComparisonEnsembleBrainPF, POINTER) returns tag of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				comparisonensemblebrainpf_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'VIEW'  'ST_AXIS'  'LISTENER_ST_AXIS'  'SURFFILE'  'SURF'  'H_BRAIN'  'BRAIN'  'ST_SURFACE'  'ST_AMBIENT'  'BA'  'H_SPHS'  'SPHS'  'SPH_DICT'  'H_SYMS'  'SYMS'  'SYM_DICT'  'H_IDS'  'IDS'  'ID_DICT'  'H_LABS'  'LABS'  'LAB_DICT'  'CP'  'SETUP' };
				tag = comparisonensemblebrainpf_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(ComparisonEnsembleBrainPF, POINTER) returns category of POINTER of ComparisonEnsembleBrainPF.
			%  CATEGORY = PF.GETPROPCATEGORY(ComparisonEnsembleBrainPF, POINTER) returns category of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisonensemblebrainpf_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  8  7  8  2  7  8  8  8  2  7  8  8  7  8  8  7  8  8  7  8  8  2  6 };
			prop_category = comparisonensemblebrainpf_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(ComparisonEnsembleBrainPF, POINTER) returns format of POINTER of ComparisonEnsembleBrainPF.
			%  FORMAT = PF.GETPROPFORMAT(ComparisonEnsembleBrainPF, POINTER) returns format of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisonensemblebrainpf_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  12  8  18  5  8  18  4  8  8  8  19  4  10  19  4  10  19  4  10  19  4  10  8  1 };
			prop_format = comparisonensemblebrainpf_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ComparisonEnsembleBrainPF, POINTER) returns description of POINTER of ComparisonEnsembleBrainPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(ComparisonEnsembleBrainPF, POINTER) returns description of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			comparisonensemblebrainpf_description_list = { 'ELCLASS (constant, string) is the class of % % % .'  'NAME (constant, string) is the name of the panel ensemble-based comparison figure on brain surface.'  'DESCRIPTION (constant, string) is the description of the panel ensemble-based comparison figure on brain surface.'  'TEMPLATE (parameter, item) is the template of the panel ensemble-based comparison figure on brain surface.'  'ID (data, string) is a few-letter code for the panel ensemble-based comparison figure on brain surface.'  'LABEL (metadata, string) is an extended label of the panel ensemble-based comparison figure on brain surface.'  'NOTES (metadata, string) are some specific notes about the panel ensemble-based comparison figure on brain surface.'  'TOSTRING (query, string) returns a string that represents the object.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the figure brain atlas.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'VIEW (figure, rvector) sets the desired view as the line-of-sight azimuth and elevation angles.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'SURFFILE (figure, option) is the name of the file of the brain surface to be plotted.'  'SURF (metadata, item) is the brain surface to be plotted.'  'H_BRAIN (evanescent, handle) is the handle for brain surface.'  'BRAIN (figure, logical) determines whether the brain surface is shown.'  'ST_SURFACE (figure, item) determines the surface settings.'  'ST_AMBIENT (figure, item) determines the ambient settings.'  'BA (metadata, item) is the brain atlas with the brain regions.'  'H_SPHS (evanescent, handlelist) is the set of handles for the spheres.'  'SPHS (figure, logical) determines whether the spheres are shown.'  'SPH_DICT (figure, idict) contains the spheres of the brain regions.'  'H_SYMS (evanescent, handlelist) is the set of handles for the symbols.'  'SYMS (figure, logical) determines whether the symbols are shown.'  'SYM_DICT (figure, idict) contains the symbols of the brain regions.'  'H_IDS (evanescent, handlelist) is the set of handles for the ids.'  'IDS (figure, logical) determines whether the ids are shown.'  'ID_DICT (figure, idict) contains the ids of the brain regions.'  'H_LABS (evanescent, handlelist) is the set of handles for the labels.'  'LABS (figure, logical) determines whether the labels are shown.'  'LAB_DICT (figure, idict) contains the labels of the brain regions.'  'CP (metadata, item) is the measure.'  'SETUP (query, empty) calculates the diff value and stores it to be implemented in the subelements.' };
			prop_description = comparisonensemblebrainpf_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(ComparisonEnsembleBrainPF, POINTER) returns settings of POINTER of ComparisonEnsembleBrainPF.
			%  SETTINGS = PF.GETPROPSETTINGS(ComparisonEnsembleBrainPF, POINTER) returns settings of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 46 % ComparisonEnsembleBrainPF.CP
					prop_settings = 'ComparisonEnsemble';
				case 47 % ComparisonEnsembleBrainPF.SETUP
					prop_settings = Format.getFormatSettings(1);
				case 4 % ComparisonEnsembleBrainPF.TEMPLATE
					prop_settings = 'ComparisonEnsembleBrainPF';
				otherwise
					prop_settings = getPropSettings@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ComparisonEnsembleBrainPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsembleBrainPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(ComparisonEnsembleBrainPF, POINTER) returns the default value of POINTER of ComparisonEnsembleBrainPF.
			%  DEFAULT = PF.GETPROPDEFAULT(ComparisonEnsembleBrainPF, POINTER) returns the default value of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 46 % ComparisonEnsembleBrainPF.CP
					prop_default = Format.getFormatDefault(8, ComparisonEnsembleBrainPF.getPropSettings(prop));
				case 47 % ComparisonEnsembleBrainPF.SETUP
					prop_default = Format.getFormatDefault(1, ComparisonEnsembleBrainPF.getPropSettings(prop));
				case 1 % ComparisonEnsembleBrainPF.ELCLASS
					prop_default = 'ComparisonEnsembleBrainPF';
				case 2 % ComparisonEnsembleBrainPF.NAME
					prop_default = 'ComparisonEnsembleBrainPF';
				case 3 % ComparisonEnsembleBrainPF.DESCRIPTION
					prop_default = 'ComparisonEnsembleBrainPF manages the basic functionalities to plot of an ensemble-based comparison on brain surface.';
				case 4 % ComparisonEnsembleBrainPF.TEMPLATE
					prop_default = Format.getFormatDefault(8, ComparisonEnsembleBrainPF.getPropSettings(prop));
				case 5 % ComparisonEnsembleBrainPF.ID
					prop_default = 'ComparisonEnsembleBrainPF ID';
				case 6 % ComparisonEnsembleBrainPF.LABEL
					prop_default = 'ComparisonEnsembleBrainPF label';
				case 7 % ComparisonEnsembleBrainPF.NOTES
					prop_default = 'ComparisonEnsembleBrainPF notes';
				otherwise
					prop_default = getPropDefault@BrainAtlasPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ComparisonEnsembleBrainPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ComparisonEnsembleBrainPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ComparisonEnsembleBrainPF, POINTER) returns the conditioned default value of POINTER of ComparisonEnsembleBrainPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(ComparisonEnsembleBrainPF, POINTER) returns the conditioned default value of POINTER of ComparisonEnsembleBrainPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			prop_default = ComparisonEnsembleBrainPF.conditioning(prop, ComparisonEnsembleBrainPF.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ComparisonEnsembleBrainPF, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsembleBrainPF.
			%  CHECK = PF.CHECKPROP(ComparisonEnsembleBrainPF, PROP, VALUE) checks VALUE format for PROP of ComparisonEnsembleBrainPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ComparisonEnsembleBrainPF:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:ComparisonEnsembleBrainPF:WrongInput
			%  Element.CHECKPROP(ComparisonEnsembleBrainPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsembleBrainPF.
			%   Error id: BRAPH2:ComparisonEnsembleBrainPF:WrongInput
			%  PF.CHECKPROP(ComparisonEnsembleBrainPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ComparisonEnsembleBrainPF.
			%   Error id: BRAPH2:ComparisonEnsembleBrainPF:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('ComparisonEnsembleBrainPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ComparisonEnsembleBrainPF.getPropProp(pointer);
			
			switch prop
				case 46 % ComparisonEnsembleBrainPF.CP
					check = Format.checkFormat(8, value, ComparisonEnsembleBrainPF.getPropSettings(prop));
				case 47 % ComparisonEnsembleBrainPF.SETUP
					check = Format.checkFormat(1, value, ComparisonEnsembleBrainPF.getPropSettings(prop));
				case 4 % ComparisonEnsembleBrainPF.TEMPLATE
					check = Format.checkFormat(8, value, ComparisonEnsembleBrainPF.getPropSettings(prop));
				otherwise
					if prop <= 45
						check = checkProp@BrainAtlasPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ComparisonEnsembleBrainPF:' 'WrongInput'], ...
					['BRAPH2' ':ComparisonEnsembleBrainPF:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ComparisonEnsembleBrainPF.getPropTag(prop) ' (' ComparisonEnsembleBrainPF.getFormatTag(ComparisonEnsembleBrainPF.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
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
				case 47 % ComparisonEnsembleBrainPF.SETUP
					value = [];
					
				case 11 % ComparisonEnsembleBrainPF.DRAW
					value = calculateValue@BrainAtlasPF(pf, 11, varargin{:}); % also warning
					if value
					    pf.get('SETUP')
					end
					
				case 18 % ComparisonEnsembleBrainPF.DELETE
					value = calculateValue@BrainAtlasPF(pf, 18, varargin{:}); % also warning
					if value
					    pf.set('H_SPHS', Element.getNoValue())
					    pf.set('H_SYMS', Element.getNoValue())
					    pf.set('H_IDS', Element.getNoValue())
					    pf.set('H_LABS', Element.getNoValue())
					end
					
				otherwise
					if prop <= 45
						value = calculateValue@BrainAtlasPF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
end