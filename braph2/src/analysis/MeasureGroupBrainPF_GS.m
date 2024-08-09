classdef MeasureGroupBrainPF_GS < MeasureGroupBrainPF
	%MeasureGroupBrainPF_GS is a plot of a global superglobal measure group brain.
	% It is a subclass of <a href="matlab:help MeasureGroupBrainPF">MeasureGroupBrainPF</a>.
	%
	% A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_GS) manages the plot of the global superglobal measure
	%  ploted over the brain.  
	% MeasureGroupBrainPF_GS utilizes the surface created from BrainAtlasPF to integrate 
	%  the global superglobal meaure into the brain regions.
	%
	% The list of MeasureGroupBrainPF_GS properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % %.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure for measure group brain.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure for measure group brain.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
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
	%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the panel figure for brain atlas.
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
	%  <strong>46</strong> <strong>M</strong> 	M (metadata, item) is the measure.
	%  <strong>47</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the measure value and stores it to be ploted on a brain surface.
	%
	% MeasureGroupBrainPF_GS methods (constructor):
	%  MeasureGroupBrainPF_GS - constructor
	%
	% MeasureGroupBrainPF_GS methods:
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
	% MeasureGroupBrainPF_GS methods (display):
	%  tostring - string with information about the panel figure for global superglobal measure group brain
	%  disp - displays information about the panel figure for global superglobal measure group brain
	%  tree - displays the tree of the panel figure for global superglobal measure group brain
	%
	% MeasureGroupBrainPF_GS methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure for global superglobal measure group brain are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure for global superglobal measure group brain
	%
	% MeasureGroupBrainPF_GS methods (save/load, Static):
	%  save - saves BRAPH2 panel figure for global superglobal measure group brain as b2 file
	%  load - loads a BRAPH2 panel figure for global superglobal measure group brain from a b2 file
	%
	% MeasureGroupBrainPF_GS method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure for global superglobal measure group brain
	%
	% MeasureGroupBrainPF_GS method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure for global superglobal measure group brain
	%
	% MeasureGroupBrainPF_GS methods (inspection, Static):
	%  getClass - returns the class of the panel figure for global superglobal measure group brain
	%  getSubclasses - returns all subclasses of MeasureGroupBrainPF_GS
	%  getProps - returns the property list of the panel figure for global superglobal measure group brain
	%  getPropNumber - returns the property number of the panel figure for global superglobal measure group brain
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
	% MeasureGroupBrainPF_GS methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% MeasureGroupBrainPF_GS methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% MeasureGroupBrainPF_GS methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% MeasureGroupBrainPF_GS methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?MeasureGroupBrainPF_GS; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">MeasureGroupBrainPF_GS constants</a>.
	%
	%
	% See also BrainAtlas, BrainSurface, BrainAtlasPF.
	
	methods % constructor
		function pf = MeasureGroupBrainPF_GS(varargin)
			%MeasureGroupBrainPF_GS() creates a panel figure for global superglobal measure group brain.
			%
			% MeasureGroupBrainPF_GS(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% MeasureGroupBrainPF_GS(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of MeasureGroupBrainPF_GS properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the % % %.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure for measure group brain.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure for measure group brain.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure for measure group brain.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
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
			%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the panel figure for brain atlas.
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
			%  <strong>46</strong> <strong>M</strong> 	M (metadata, item) is the measure.
			%  <strong>47</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the measure value and stores it to be ploted on a brain surface.
			%
			% See also Category, Format.
			
			pf = pf@MeasureGroupBrainPF(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure for global superglobal measure group brain.
			%
			% CLASS = MeasureGroupBrainPF_GS.GETCLASS() returns the class 'MeasureGroupBrainPF_GS'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure for global superglobal measure group brain PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('MeasureGroupBrainPF_GS') returns 'MeasureGroupBrainPF_GS'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			
			pf_class = 'MeasureGroupBrainPF_GS';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure for global superglobal measure group brain.
			%
			% LIST = MeasureGroupBrainPF_GS.GETSUBCLASSES() returns all subclasses of 'MeasureGroupBrainPF_GS'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure for global superglobal measure group brain PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('MeasureGroupBrainPF_GS') returns all subclasses of 'MeasureGroupBrainPF_GS'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'MeasureGroupBrainPF_GS' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure for global superglobal measure group brain.
			%
			% PROPS = MeasureGroupBrainPF_GS.GETPROPS() returns the property list of panel figure for global superglobal measure group brain
			%  as a row vector.
			%
			% PROPS = MeasureGroupBrainPF_GS.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure for global superglobal measure group brain PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('MeasureGroupBrainPF_GS'[, CATEGORY]) returns the property list of 'MeasureGroupBrainPF_GS'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('MeasureGroupBrainPF_GS')
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
			%GETPROPNUMBER returns the property number of panel figure for global superglobal measure group brain.
			%
			% N = MeasureGroupBrainPF_GS.GETPROPNUMBER() returns the property number of panel figure for global superglobal measure group brain.
			%
			% N = MeasureGroupBrainPF_GS.GETPROPNUMBER(CATEGORY) returns the property number of panel figure for global superglobal measure group brain
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure for global superglobal measure group brain PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('MeasureGroupBrainPF_GS') returns the property number of 'MeasureGroupBrainPF_GS'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('MeasureGroupBrainPF_GS')
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
			%EXISTSPROP checks whether property exists in panel figure for global superglobal measure group brain/error.
			%
			% CHECK = MeasureGroupBrainPF_GS.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(MeasureGroupBrainPF_GS, PROP) checks whether PROP exists for MeasureGroupBrainPF_GS.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:MeasureGroupBrainPF_GS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_GS:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_GS:WrongInput]
			%  Element.EXISTSPROP(MeasureGroupBrainPF_GS, PROP) throws error if PROP does NOT exist for MeasureGroupBrainPF_GS.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_GS:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 47 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureGroupBrainPF_GS:' 'WrongInput'], ...
					['BRAPH2' ':MeasureGroupBrainPF_GS:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for MeasureGroupBrainPF_GS.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure for global superglobal measure group brain/error.
			%
			% CHECK = MeasureGroupBrainPF_GS.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(MeasureGroupBrainPF_GS, TAG) checks whether TAG exists for MeasureGroupBrainPF_GS.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:MeasureGroupBrainPF_GS:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_GS:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_GS:WrongInput]
			%  Element.EXISTSTAG(MeasureGroupBrainPF_GS, TAG) throws error if TAG does NOT exist for MeasureGroupBrainPF_GS.
			%   Error id: [BRAPH2:MeasureGroupBrainPF_GS:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'VIEW'  'ST_AXIS'  'LISTENER_ST_AXIS'  'SURFFILE'  'SURF'  'H_BRAIN'  'BRAIN'  'ST_SURFACE'  'ST_AMBIENT'  'BA'  'H_SPHS'  'SPHS'  'SPH_DICT'  'H_SYMS'  'SYMS'  'SYM_DICT'  'H_IDS'  'IDS'  'ID_DICT'  'H_LABS'  'LABS'  'LAB_DICT'  'M'  'SETUP' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureGroupBrainPF_GS:' 'WrongInput'], ...
					['BRAPH2' ':MeasureGroupBrainPF_GS:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for MeasureGroupBrainPF_GS.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(MeasureGroupBrainPF_GS, POINTER) returns property number of POINTER of MeasureGroupBrainPF_GS.
			%  PROPERTY = PF.GETPROPPROP(MeasureGroupBrainPF_GS, POINTER) returns property number of POINTER of MeasureGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'VIEW'  'ST_AXIS'  'LISTENER_ST_AXIS'  'SURFFILE'  'SURF'  'H_BRAIN'  'BRAIN'  'ST_SURFACE'  'ST_AMBIENT'  'BA'  'H_SPHS'  'SPHS'  'SPH_DICT'  'H_SYMS'  'SYMS'  'SYM_DICT'  'H_IDS'  'IDS'  'ID_DICT'  'H_LABS'  'LABS'  'LAB_DICT'  'M'  'SETUP' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(MeasureGroupBrainPF_GS, POINTER) returns tag of POINTER of MeasureGroupBrainPF_GS.
			%  TAG = PF.GETPROPTAG(MeasureGroupBrainPF_GS, POINTER) returns tag of POINTER of MeasureGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				measuregroupbrainpf_gs_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'VIEW'  'ST_AXIS'  'LISTENER_ST_AXIS'  'SURFFILE'  'SURF'  'H_BRAIN'  'BRAIN'  'ST_SURFACE'  'ST_AMBIENT'  'BA'  'H_SPHS'  'SPHS'  'SPH_DICT'  'H_SYMS'  'SYMS'  'SYM_DICT'  'H_IDS'  'IDS'  'ID_DICT'  'H_LABS'  'LABS'  'LAB_DICT'  'M'  'SETUP' };
				tag = measuregroupbrainpf_gs_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(MeasureGroupBrainPF_GS, POINTER) returns category of POINTER of MeasureGroupBrainPF_GS.
			%  CATEGORY = PF.GETPROPCATEGORY(MeasureGroupBrainPF_GS, POINTER) returns category of POINTER of MeasureGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_GS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measuregroupbrainpf_gs_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  8  7  8  2  7  8  8  8  2  7  8  8  7  8  8  7  8  8  7  8  8  2  6 };
			prop_category = measuregroupbrainpf_gs_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(MeasureGroupBrainPF_GS, POINTER) returns format of POINTER of MeasureGroupBrainPF_GS.
			%  FORMAT = PF.GETPROPFORMAT(MeasureGroupBrainPF_GS, POINTER) returns format of POINTER of MeasureGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_GS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measuregroupbrainpf_gs_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  12  8  18  5  8  18  4  8  8  8  19  4  10  19  4  10  19  4  10  19  4  10  8  1 };
			prop_format = measuregroupbrainpf_gs_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(MeasureGroupBrainPF_GS, POINTER) returns description of POINTER of MeasureGroupBrainPF_GS.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(MeasureGroupBrainPF_GS, POINTER) returns description of POINTER of MeasureGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_GS.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			measuregroupbrainpf_gs_description_list = { 'ELCLASS (constant, string) is the class of the % % %.'  'NAME (constant, string) is the name of the panel figure for measure group brain.'  'DESCRIPTION (constant, string) is the description of the panel figure for measure group brain.'  'TEMPLATE (parameter, item) is the template of the panel figure for measure group brain.'  'ID (data, string) is a few-letter code for the panel figure for measure group brain.'  'LABEL (metadata, string) is an extended label of the panel figure for measure group brain.'  'NOTES (metadata, string) are some specific notes about the panel figure for measure group brain.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the figure brain atlas.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure brain surface is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the panel figure for brain atlas.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'VIEW (figure, rvector) sets the desired view as the line-of-sight azimuth and elevation angles.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'SURFFILE (figure, option) is the name of the file of the brain surface to be plotted.'  'SURF (metadata, item) is the brain surface to be plotted.'  'H_BRAIN (evanescent, handle) is the handle for brain surface.'  'BRAIN (figure, logical) determines whether the brain surface is shown.'  'ST_SURFACE (figure, item) determines the surface settings.'  'ST_AMBIENT (figure, item) determines the ambient settings.'  'BA (metadata, item) is the brain atlas with the brain regions.'  'H_SPHS (evanescent, handlelist) is the set of handles for the spheres.'  'SPHS (figure, logical) determines whether the spheres are shown.'  'SPH_DICT (figure, idict) contains the spheres of the brain regions.'  'H_SYMS (evanescent, handlelist) is the set of handles for the symbols.'  'SYMS (figure, logical) determines whether the symbols are shown.'  'SYM_DICT (figure, idict) contains the symbols of the brain regions.'  'H_IDS (evanescent, handlelist) is the set of handles for the ids.'  'IDS (figure, logical) determines whether the ids are shown.'  'ID_DICT (figure, idict) contains the ids of the brain regions.'  'H_LABS (evanescent, handlelist) is the set of handles for the labels.'  'LABS (figure, logical) determines whether the labels are shown.'  'LAB_DICT (figure, idict) contains the labels of the brain regions.'  'M (metadata, item) is the measure.'  'SETUP (query, empty) calculates the measure value and stores it to be ploted on a brain surface.' };
			prop_description = measuregroupbrainpf_gs_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(MeasureGroupBrainPF_GS, POINTER) returns settings of POINTER of MeasureGroupBrainPF_GS.
			%  SETTINGS = PF.GETPROPSETTINGS(MeasureGroupBrainPF_GS, POINTER) returns settings of POINTER of MeasureGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = MeasureGroupBrainPF_GS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % MeasureGroupBrainPF_GS.TEMPLATE
					prop_settings = 'MeasureGroupBrainPF_GS';
				otherwise
					prop_settings = getPropSettings@MeasureGroupBrainPF(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = MeasureGroupBrainPF_GS.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureGroupBrainPF_GS.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(MeasureGroupBrainPF_GS, POINTER) returns the default value of POINTER of MeasureGroupBrainPF_GS.
			%  DEFAULT = PF.GETPROPDEFAULT(MeasureGroupBrainPF_GS, POINTER) returns the default value of POINTER of MeasureGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = MeasureGroupBrainPF_GS.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % MeasureGroupBrainPF_GS.ELCLASS
					prop_default = 'MeasureGroupBrainPF_GS';
				case 2 % MeasureGroupBrainPF_GS.NAME
					prop_default = 'Panel Figure for Measure Group Brain';
				case 3 % MeasureGroupBrainPF_GS.DESCRIPTION
					prop_default = 'A Panel Figure for a Brain Measure of Analyze Group (MeasureGroupBrainPF_GS) manages the plot of the global superglobal measure ploted over the brain. MeasureGroupBrainPF_GS  utilizes the surface created from BrainAtlasPF to integrate the global superglobal meaure into the brain regions.';
				case 4 % MeasureGroupBrainPF_GS.TEMPLATE
					prop_default = Format.getFormatDefault(8, MeasureGroupBrainPF_GS.getPropSettings(prop));
				case 5 % MeasureGroupBrainPF_GS.ID
					prop_default = 'MeasureGroupBrainPF_GS ID';
				case 6 % MeasureGroupBrainPF_GS.LABEL
					prop_default = 'MeasureGroupBrainPF_GS label';
				case 7 % MeasureGroupBrainPF_GS.NOTES
					prop_default = 'MeasureGroupBrainPF_GS notes';
				otherwise
					prop_default = getPropDefault@MeasureGroupBrainPF(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = MeasureGroupBrainPF_GS.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = MeasureGroupBrainPF_GS.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(MeasureGroupBrainPF_GS, POINTER) returns the conditioned default value of POINTER of MeasureGroupBrainPF_GS.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(MeasureGroupBrainPF_GS, POINTER) returns the conditioned default value of POINTER of MeasureGroupBrainPF_GS.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = MeasureGroupBrainPF_GS.getPropProp(pointer);
			
			prop_default = MeasureGroupBrainPF_GS.conditioning(prop, MeasureGroupBrainPF_GS.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(MeasureGroupBrainPF_GS, PROP, VALUE) checks VALUE format for PROP of MeasureGroupBrainPF_GS.
			%  CHECK = PF.CHECKPROP(MeasureGroupBrainPF_GS, PROP, VALUE) checks VALUE format for PROP of MeasureGroupBrainPF_GS.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:MeasureGroupBrainPF_GS:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:MeasureGroupBrainPF_GS:WrongInput
			%  Element.CHECKPROP(MeasureGroupBrainPF_GS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureGroupBrainPF_GS.
			%   Error id: BRAPH2:MeasureGroupBrainPF_GS:WrongInput
			%  PF.CHECKPROP(MeasureGroupBrainPF_GS, PROP, VALUE) throws error if VALUE has not a valid format for PROP of MeasureGroupBrainPF_GS.
			%   Error id: BRAPH2:MeasureGroupBrainPF_GS:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('MeasureGroupBrainPF_GS')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = MeasureGroupBrainPF_GS.getPropProp(pointer);
			
			switch prop
				case 4 % MeasureGroupBrainPF_GS.TEMPLATE
					check = Format.checkFormat(8, value, MeasureGroupBrainPF_GS.getPropSettings(prop));
				otherwise
					if prop <= 47
						check = checkProp@MeasureGroupBrainPF(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':MeasureGroupBrainPF_GS:' 'WrongInput'], ...
					['BRAPH2' ':MeasureGroupBrainPF_GS:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' MeasureGroupBrainPF_GS.getPropTag(prop) ' (' MeasureGroupBrainPF_GS.getFormatTag(MeasureGroupBrainPF_GS.getPropFormat(prop)) ').'] ...
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
				case 47 % MeasureGroupBrainPF_GS.SETUP
					warning([BRAPH2.STR ':MeasureGroupBrainPF_GS'], [BRAPH2.STR ':MeasureGroupBrainPF_GS \nThis functionality is not implemented yet.\nYou can contact the BRAPH2 developers and ask for it, \nor, even better, implement it yourself and share it with the community!'])
					value = [];
					
				otherwise
					if prop <= 47
						value = calculateValue@MeasureGroupBrainPF(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
		end
	end
end
