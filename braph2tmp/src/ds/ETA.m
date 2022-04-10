classdef ETA < Element
	% ETA tests props.
	% It is a subclass of <a href="matlab:help Element">Element</a>.
	%
	% Tests the methods set, get, and check for all properties categories and formats.
	% It also checks the use of reproducible randomness, the conditioning, 
	% and the restoring of a property after a failed check value.
	%
	% The list of ETA properties is:
	%  <strong>1</strong> <strong>prop_empty_m</strong> 	PROP_EMPTY_M (metadata, empty) is a metadata, empty.
	%  <strong>2</strong> <strong>prop_string_m</strong> 	PROP_STRING_M (metadata, string) is a metadata, string.
	%  <strong>3</strong> <strong>prop_logical_m</strong> 	PROP_LOGICAL_M (metadata, logical) is a metadata, logical.
	%  <strong>4</strong> <strong>prop_option_m</strong> 	PROP_OPTION_M (metadata, option) is a metadata, option.
	%  <strong>5</strong> <strong>prop_class_m</strong> 	PROP_CLASS_M (metadata, class) is a metadata, class.
	%  <strong>6</strong> <strong>prop_classlist_m</strong> 	PROP_CLASSLIST_M (metadata, classlist) is a metadata, classlist.
	%  <strong>7</strong> <strong>prop_item_m</strong> 	PROP_ITEM_M (metadata, item) is a metadata, item.
	%  <strong>8</strong> <strong>prop_itemlist_m</strong> 	PROP_ITEMLIST_M (metadata, itemlist) is a metadata, itemlist.
	%  <strong>9</strong> <strong>prop_idict_m</strong> 	PROP_IDICT_M (metadata, idict) is a metadata, idict.
	%  <strong>10</strong> <strong>prop_scalar_m</strong> 	PROP_SCALAR_M (metadata, scalar) is a metadata, scalar.
	%  <strong>11</strong> <strong>prop_rvector_m</strong> 	PROP_RVECTOR_M (metadata, rvector) is a metadata, rvector.
	%  <strong>12</strong> <strong>prop_cvector_m</strong> 	PROP_CVECTOR_M (metadata, cvector) is a metadata, cvector.
	%  <strong>13</strong> <strong>prop_matrix_m</strong> 	PROP_MATRIX_M (metadata, matrix) is a metadata, matrix.
	%  <strong>14</strong> <strong>prop_smatrix_m</strong> 	PROP_SMATRIX_M (metadata, smatrix) is a metadata, smatrix.
	%  <strong>15</strong> <strong>prop_cell_m</strong> 	PROP_CELL_M (metadata, cell) is a metadata, cell.
	%  <strong>16</strong> <strong>prop_net_m</strong> 	PROP_NET_M (metadata, net) is a metadata, net.
	%  <strong>17</strong> <strong>prop_empty_p</strong> 	PROP_EMPTY_P (parameter, empty) is a parameter, empty.
	%  <strong>18</strong> <strong>prop_string_p</strong> 	PROP_STRING_P (parameter, string) is a parameter, string.
	%  <strong>19</strong> <strong>prop_logical_p</strong> 	PROP_LOGICAL_P (parameter, logical) is a parameter, logical.
	%  <strong>20</strong> <strong>prop_option_p</strong> 	PROP_OPTION_P (parameter, option) is a parameter, option.
	%  <strong>21</strong> <strong>prop_class_p</strong> 	PROP_CLASS_P (parameter, class) is a parameter, class.
	%  <strong>22</strong> <strong>prop_classlist_p</strong> 	PROP_CLASSLIST_P (parameter, classlist) is a parameter, classlist.
	%  <strong>23</strong> <strong>prop_item_p</strong> 	PROP_ITEM_P (parameter, item) is a parameter, item.
	%  <strong>24</strong> <strong>prop_itemlist_p</strong> 	PROP_ITEMLIST_P (parameter, itemlist) is a parameter, itemlist.
	%  <strong>25</strong> <strong>prop_idict_p</strong> 	PROP_IDICT_P (parameter, idict) is a parameter, idict.
	%  <strong>26</strong> <strong>prop_scalar_p</strong> 	PROP_SCALAR_P (parameter, scalar) is a parameter, scalar.
	%  <strong>27</strong> <strong>prop_rvector_p</strong> 	PROP_RVECTOR_P (parameter, rvector) is a parameter, rvector.
	%  <strong>28</strong> <strong>prop_cvector_p</strong> 	PROP_CVECTOR_P (parameter, cvector) is a parameter, cvector.
	%  <strong>29</strong> <strong>prop_matrix_p</strong> 	PROP_MATRIX_P (parameter, matrix) is a parameter, matrix.
	%  <strong>30</strong> <strong>prop_smatrix_p</strong> 	PROP_SMATRIX_P (parameter, smatrix) is a parameter, smatrix.
	%  <strong>31</strong> <strong>prop_cell_p</strong> 	PROP_CELL_P (parameter, cell) is a parameter, cell.
	%  <strong>32</strong> <strong>prop_net_p</strong> 	PROP_NET_P (parameter, net) is a parameter, net.
	%  <strong>33</strong> <strong>prop_empty_d</strong> 	PROP_EMPTY_D (data, empty) is a data, empty.
	%  <strong>34</strong> <strong>prop_string_d</strong> 	PROP_STRING_D (data, string) is a data, string.
	%  <strong>35</strong> <strong>prop_logical_d</strong> 	PROP_LOGICAL_D (data, logical) is a data, logical.
	%  <strong>36</strong> <strong>prop_option_d</strong> 	PROP_OPTION_D (data, option) is a data, option.
	%  <strong>37</strong> <strong>prop_class_d</strong> 	PROP_CLASS_D (data, class) is a data, class.
	%  <strong>38</strong> <strong>prop_classlist_d</strong> 	PROP_CLASSLIST_D (data, classlist) is a data, classlist.
	%  <strong>39</strong> <strong>prop_item_d</strong> 	PROP_ITEM_D (data, item) is a data, item.
	%  <strong>40</strong> <strong>prop_itemlist_d</strong> 	PROP_ITEMLIST_D (data, itemlist) is a data, itemlist.
	%  <strong>41</strong> <strong>prop_idict_d</strong> 	PROP_IDICT_D (data, idict) is a data, idict.
	%  <strong>42</strong> <strong>prop_scalar_d</strong> 	PROP_SCALAR_D (data, scalar) is a data, scalar.
	%  <strong>43</strong> <strong>prop_rvector_d</strong> 	PROP_RVECTOR_D (data, rvector) is a data, rvector.
	%  <strong>44</strong> <strong>prop_cvector_d</strong> 	PROP_CVECTOR_D (data, cvector) is a data, cvector.
	%  <strong>45</strong> <strong>prop_matrix_d</strong> 	PROP_MATRIX_D (data, matrix) is a data, matrix.
	%  <strong>46</strong> <strong>prop_smatrix_d</strong> 	PROP_SMATRIX_D (data, smatrix) is a data, smatrix.
	%  <strong>47</strong> <strong>prop_cell_d</strong> 	PROP_CELL_D (data, cell) is a data, cell.
	%  <strong>48</strong> <strong>prop_net_d</strong> 	PROP_NET_D (data, net) is a data, net.
	%  <strong>49</strong> <strong>prop_empty_f</strong> 	PROP_EMPTY_F (figure, empty) is a figure, empty.
	%  <strong>50</strong> <strong>prop_string_f</strong> 	PROP_STRING_F (figure, string) is a figure, string.
	%  <strong>51</strong> <strong>prop_logical_f</strong> 	PROP_LOGICAL_F (figure, logical) is a figure, logical.
	%  <strong>52</strong> <strong>prop_option_f</strong> 	PROP_OPTION_F (figure, option) is a figure, option.
	%  <strong>53</strong> <strong>prop_class_f</strong> 	PROP_CLASS_F (figure, class) is a figure, class.
	%  <strong>54</strong> <strong>prop_classlist_f</strong> 	PROP_CLASSLIST_F (figure, classlist) is a figure, classlist.
	%  <strong>55</strong> <strong>prop_item_f</strong> 	PROP_ITEM_F (figure, item) is a figure, item.
	%  <strong>56</strong> <strong>prop_itemlist_f</strong> 	PROP_ITEMLIST_F (figure, itemlist) is a figure, itemlist.
	%  <strong>57</strong> <strong>prop_idict_f</strong> 	PROP_IDICT_F (figure, idict) is a figure, idict.
	%  <strong>58</strong> <strong>prop_scalar_f</strong> 	PROP_SCALAR_F (figure, scalar) is a figure, scalar.
	%  <strong>59</strong> <strong>prop_rvector_f</strong> 	PROP_RVECTOR_F (figure, rvector) is a figure, rvector.
	%  <strong>60</strong> <strong>prop_cvector_f</strong> 	PROP_CVECTOR_F (figure, cvector) is a figure, cvector.
	%  <strong>61</strong> <strong>prop_matrix_f</strong> 	PROP_MATRIX_F (figure, matrix) is a figure, matrix.
	%  <strong>62</strong> <strong>prop_smatrix_f</strong> 	PROP_SMATRIX_F (figure, smatrix) is a figure, smatrix.
	%  <strong>63</strong> <strong>prop_cell_f</strong> 	PROP_CELL_F (figure, cell) is a figure, cell.
	%  <strong>64</strong> <strong>prop_net_f</strong> 	PROP_NET_F (figure, net) is a figure, net.
	%  <strong>65</strong> <strong>prop_empty_g</strong> 	PROP_EMPTY_G (gui, empty) is a gui, empty.
	%  <strong>66</strong> <strong>prop_string_g</strong> 	PROP_STRING_G (gui, string) is a gui, string.
	%  <strong>67</strong> <strong>prop_logical_g</strong> 	PROP_LOGICAL_G (gui, logical) is a gui, logical.
	%  <strong>68</strong> <strong>prop_option_g</strong> 	PROP_OPTION_G (gui, option) is a gui, option.
	%  <strong>69</strong> <strong>prop_class_g</strong> 	PROP_CLASS_G (gui, class) is a gui, class.
	%  <strong>70</strong> <strong>prop_classlist_g</strong> 	PROP_CLASSLIST_G (gui, classlist) is a gui, classlist.
	%  <strong>71</strong> <strong>prop_item_g</strong> 	PROP_ITEM_G (gui, item) is a gui, item.
	%  <strong>72</strong> <strong>prop_itemlist_g</strong> 	PROP_ITEMLIST_G (gui, itemlist) is a gui, itemlist.
	%  <strong>73</strong> <strong>prop_idict_g</strong> 	PROP_IDICT_G (gui, idict) is a gui, idict.
	%  <strong>74</strong> <strong>prop_scalar_g</strong> 	PROP_SCALAR_G (gui, scalar) is a gui, scalar.
	%  <strong>75</strong> <strong>prop_rvector_g</strong> 	PROP_RVECTOR_G (gui, rvector) is a gui, rvector.
	%  <strong>76</strong> <strong>prop_cvector_g</strong> 	PROP_CVECTOR_G (gui, cvector) is a gui, cvector.
	%  <strong>77</strong> <strong>prop_matrix_g</strong> 	PROP_MATRIX_G (gui, matrix) is a gui, matrix.
	%  <strong>78</strong> <strong>prop_smatrix_g</strong> 	PROP_SMATRIX_G (gui, smatrix) is a gui, smatrix.
	%  <strong>79</strong> <strong>prop_cell_g</strong> 	PROP_CELL_G (gui, cell) is a gui, cell.
	%  <strong>80</strong> <strong>prop_net_g</strong> 	PROP_NET_G (gui, net) is a gui, net.
	%  <strong>81</strong> <strong>prop_empty_r</strong> 	PROP_EMPTY_R (result, empty) is a result, empty.
	%  <strong>82</strong> <strong>prop_string_r</strong> 	PROP_STRING_R (result, string) is a result, string.
	%  <strong>83</strong> <strong>prop_logical_r</strong> 	PROP_LOGICAL_R (result, logical) is a result, logical.
	%  <strong>84</strong> <strong>prop_option_r</strong> 	PROP_OPTION_R (result, option) is a result, option.
	%  <strong>85</strong> <strong>prop_class_r</strong> 	PROP_CLASS_R (result, class) is a result, class.
	%  <strong>86</strong> <strong>prop_classlist_r</strong> 	PROP_CLASSLIST_R (result, classlist) is a result, classlist.
	%  <strong>87</strong> <strong>prop_item_r</strong> 	PROP_ITEM_R (result, item) is a result, item.
	%  <strong>88</strong> <strong>prop_itemlist_r</strong> 	PROP_ITEMLIST_R (result, itemlist) is a result, itemlist.
	%  <strong>89</strong> <strong>prop_idict_r</strong> 	PROP_IDICT_R (result, idict) is a result, idict.
	%  <strong>90</strong> <strong>prop_scalar_r</strong> 	PROP_SCALAR_R (result, scalar) is a result, scalar.
	%  <strong>91</strong> <strong>prop_rvector_r</strong> 	PROP_RVECTOR_R (result, rvector) is a result, rvector.
	%  <strong>92</strong> <strong>prop_cvector_r</strong> 	PROP_CVECTOR_R (result, cvector) is a result, cvector.
	%  <strong>93</strong> <strong>prop_matrix_r</strong> 	PROP_MATRIX_R (result, matrix) is a result, matrix.
	%  <strong>94</strong> <strong>prop_smatrix_r</strong> 	PROP_SMATRIX_R (result, smatrix) is a result, smatrix.
	%  <strong>95</strong> <strong>prop_cell_r</strong> 	PROP_CELL_R (result, cell) is a result, cell.
	%  <strong>96</strong> <strong>prop_net_r</strong> 	PROP_NET_R (result, net) is a result, net.
	%  <strong>97</strong> <strong>prop_empty_r_calc</strong> 	PROP_EMPTY_R_CALC (result, empty) is a result, empty.
	%  <strong>98</strong> <strong>prop_string_r_calc</strong> 	PROP_STRING_R_CALC (result, string) is a result, string.
	%  <strong>99</strong> <strong>prop_logical_r_calc</strong> 	PROP_LOGICAL_R_CALC (result, logical) is a result, logical.
	%  <strong>100</strong> <strong>prop_option_r_calc</strong> 	PROP_OPTION_R_CALC (result, option) is a result, option.
	%  <strong>101</strong> <strong>prop_class_r_calc</strong> 	PROP_CLASS_R_CALC (result, class) is a result, class.
	%  <strong>102</strong> <strong>prop_classlist_r_calc</strong> 	PROP_CLASSLIST_R_CALC (result, classlist) is a result, classlist.
	%  <strong>103</strong> <strong>prop_item_r_calc</strong> 	PROP_ITEM_R_CALC (result, item) is a result, item.
	%  <strong>104</strong> <strong>prop_itemlist_r_calc</strong> 	PROP_ITEMLIST_R_CALC (result, itemlist) is a result, itemlist.
	%  <strong>105</strong> <strong>prop_idict_r_calc</strong> 	PROP_IDICT_R_CALC (result, idict) is a result, idict.
	%  <strong>106</strong> <strong>prop_scalar_r_calc</strong> 	PROP_SCALAR_R_CALC (result, scalar) is a result, scalar.
	%  <strong>107</strong> <strong>prop_rvector_r_calc</strong> 	PROP_RVECTOR_R_CALC (result, rvector) is a result, rvector.
	%  <strong>108</strong> <strong>prop_cvector_r_calc</strong> 	PROP_CVECTOR_R_CALC (result, cvector) is a result, cvector.
	%  <strong>109</strong> <strong>prop_matrix_r_calc</strong> 	PROP_MATRIX_R_CALC (result, matrix) is a result, matrix.
	%  <strong>110</strong> <strong>prop_smatrix_r_calc</strong> 	PROP_SMATRIX_R_CALC (result, smatrix) is a result, smatrix.
	%  <strong>111</strong> <strong>prop_cell_r_calc</strong> 	PROP_CELL_R_CALC (result, cell) is a result, cell.
	%  <strong>112</strong> <strong>prop_net_r_calc</strong> 	PROP_NET_R_CALC (result, net) is a result, net.
	%
	% ETA methods (constructor):
	% ETA - constructor
	%
	% ETA methods (Static):
	%  checkProp - checks whether a value has the correct format/error.
	%  getPropDefaultConditioned - returns the conditioned default value of a property.
	%  getPropDefault - returns the default value of a property.
	%  getPropSettings - returns the settings of a property.
	%  getPropDescription - returns the description of a property.
	%  getPropFormat - returns the format of a property.
	%  getPropCategory - returns the category of a property.
	%  getPropTag - returns the tag of a property.
	%  getPropProp - returns the property number of a property.
	%  existsTag - checks whether tag exists in test Element A/error.
	%  existsProp - checks whether property exists in test Element A/error.
	%  getPropNumber - returns the property number of test Element A.
	%  getProps - returns the property list of test Element A.
	%  getDescription - returns the description of the test Element A.
	%  getName - returns the name of the test Element A.
	%  getClass - returns the class of the test Element A.
	%
	% ETA methods:
	%  getPlotProp - returns a prop plot.
	%  set - sets the value of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns and memorizes the value of a property
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% ETA methods (operators):
	%  isequal - determines whether two ETA are equal (values, locked)
	%
	% ETA methods (display):
	%  tostring - string with information about the ETA
	%  disp - displays information about the ETA
	%  tree - displays the element of ETA
	%
	% ETA method (element list):
	%  getElementList - returns a list with all subelements of ETA
	%
	% ETA method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the ETA
	%
	% ETA method (JSON decode, Static):
	%  decodeJSON - returns a JSON string encoding the ETA
	%
	% ETA methods (copy):
	%  copy - copies the ETA
	%  deepclone - deep-clones the ETA
	%  clone - clones the ETA
	%
	% ETA methods (inspection, Static):
	%  getClass - returns ETA
	%  getName - returns the name of ETA
	%  getDescription - returns the description of ETA
	%  getProps - returns the property list of ETA
	%  getPropNumber - returns the property number of ETA
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditione default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% ETA methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ETA methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% ETA methods (GUI):
	%  getGUI - returns the element GUI
	%  getPlotElement - returns the element plot
	%  getPlotProp - returns a prop plot
	%
	% ETA methods (GUI, Static):
	%  getGUIMenuImport - returns an importer menu
	%  getGUIMenuExport - returns an exporter menu
	%
	% ETA properties (Constant).
	%  PROP_EMPTY_M - 1
	%  PROP_EMPTY_M_TAG - 'prop_empty_m'
	%  PROP_EMPTY_M_CATEGORY - 'm'
	%  PROP_EMPTY_M_FORMAT - 'em'
	%  PROP_STRING_M - 2
	%  PROP_STRING_M_TAG - 'prop_string_m'
	%  PROP_STRING_M_CATEGORY - 'm'
	%  PROP_STRING_M_FORMAT - 'st'
	%  PROP_LOGICAL_M - 3
	%  PROP_LOGICAL_M_TAG - 'prop_logical_m'
	%  PROP_LOGICAL_M_CATEGORY - 'm'
	%  PROP_LOGICAL_M_FORMAT - 'lo'
	%  PROP_OPTION_M - 4
	%  PROP_OPTION_M_TAG - 'prop_option_m'
	%  PROP_OPTION_M_CATEGORY - 'm'
	%  PROP_OPTION_M_FORMAT - 'op'
	%  PROP_CLASS_M - 5
	%  PROP_CLASS_M_TAG - 'prop_class_m'
	%  PROP_CLASS_M_CATEGORY - 'm'
	%  PROP_CLASS_M_FORMAT - 'ca'
	%  PROP_CLASSLIST_M - 6
	%  PROP_CLASSLIST_M_TAG - 'prop_classlist_m'
	%  PROP_CLASSLIST_M_CATEGORY - 'm'
	%  PROP_CLASSLIST_M_FORMAT - 'cl'
	%  PROP_ITEM_M - 7
	%  PROP_ITEM_M_TAG - 'prop_item_m'
	%  PROP_ITEM_M_CATEGORY - 'm'
	%  PROP_ITEM_M_FORMAT - 'it'
	%  PROP_ITEMLIST_M - 8
	%  PROP_ITEMLIST_M_TAG - 'prop_itemlist_m'
	%  PROP_ITEMLIST_M_CATEGORY - 'm'
	%  PROP_ITEMLIST_M_FORMAT - 'il'
	%  PROP_IDICT_M - 9
	%  PROP_IDICT_M_TAG - 'prop_idict_m'
	%  PROP_IDICT_M_CATEGORY - 'm'
	%  PROP_IDICT_M_FORMAT - 'di'
	%  PROP_SCALAR_M - 10
	%  PROP_SCALAR_M_TAG - 'prop_scalar_m'
	%  PROP_SCALAR_M_CATEGORY - 'm'
	%  PROP_SCALAR_M_FORMAT - 'nn'
	%  PROP_RVECTOR_M - 11
	%  PROP_RVECTOR_M_TAG - 'prop_rvector_m'
	%  PROP_RVECTOR_M_CATEGORY - 'm'
	%  PROP_RVECTOR_M_FORMAT - 'nr'
	%  PROP_CVECTOR_M - 12
	%  PROP_CVECTOR_M_TAG - 'prop_cvector_m'
	%  PROP_CVECTOR_M_CATEGORY - 'm'
	%  PROP_CVECTOR_M_FORMAT - 'nc'
	%  PROP_MATRIX_M - 13
	%  PROP_MATRIX_M_TAG - 'prop_matrix_m'
	%  PROP_MATRIX_M_CATEGORY - 'm'
	%  PROP_MATRIX_M_FORMAT - 'nm'
	%  PROP_SMATRIX_M - 14
	%  PROP_SMATRIX_M_TAG - 'prop_smatrix_m'
	%  PROP_SMATRIX_M_CATEGORY - 'm'
	%  PROP_SMATRIX_M_FORMAT - 'ns'
	%  PROP_CELL_M - 15
	%  PROP_CELL_M_TAG - 'prop_cell_m'
	%  PROP_CELL_M_CATEGORY - 'm'
	%  PROP_CELL_M_FORMAT - 'll'
	%  PROP_NET_M - 16
	%  PROP_NET_M_TAG - 'prop_net_m'
	%  PROP_NET_M_CATEGORY - 'm'
	%  PROP_NET_M_FORMAT - 'ml'
	%  PROP_EMPTY_P - 17
	%  PROP_EMPTY_P_TAG - 'prop_empty_p'
	%  PROP_EMPTY_P_CATEGORY - 'p'
	%  PROP_EMPTY_P_FORMAT - 'em'
	%  PROP_STRING_P - 18
	%  PROP_STRING_P_TAG - 'prop_string_p'
	%  PROP_STRING_P_CATEGORY - 'p'
	%  PROP_STRING_P_FORMAT - 'st'
	%  PROP_LOGICAL_P - 19
	%  PROP_LOGICAL_P_TAG - 'prop_logical_p'
	%  PROP_LOGICAL_P_CATEGORY - 'p'
	%  PROP_LOGICAL_P_FORMAT - 'lo'
	%  PROP_OPTION_P - 20
	%  PROP_OPTION_P_TAG - 'prop_option_p'
	%  PROP_OPTION_P_CATEGORY - 'p'
	%  PROP_OPTION_P_FORMAT - 'op'
	%  PROP_CLASS_P - 21
	%  PROP_CLASS_P_TAG - 'prop_class_p'
	%  PROP_CLASS_P_CATEGORY - 'p'
	%  PROP_CLASS_P_FORMAT - 'ca'
	%  PROP_CLASSLIST_P - 22
	%  PROP_CLASSLIST_P_TAG - 'prop_classlist_p'
	%  PROP_CLASSLIST_P_CATEGORY - 'p'
	%  PROP_CLASSLIST_P_FORMAT - 'cl'
	%  PROP_ITEM_P - 23
	%  PROP_ITEM_P_TAG - 'prop_item_p'
	%  PROP_ITEM_P_CATEGORY - 'p'
	%  PROP_ITEM_P_FORMAT - 'it'
	%  PROP_ITEMLIST_P - 24
	%  PROP_ITEMLIST_P_TAG - 'prop_itemlist_p'
	%  PROP_ITEMLIST_P_CATEGORY - 'p'
	%  PROP_ITEMLIST_P_FORMAT - 'il'
	%  PROP_IDICT_P - 25
	%  PROP_IDICT_P_TAG - 'prop_idict_p'
	%  PROP_IDICT_P_CATEGORY - 'p'
	%  PROP_IDICT_P_FORMAT - 'di'
	%  PROP_SCALAR_P - 26
	%  PROP_SCALAR_P_TAG - 'prop_scalar_p'
	%  PROP_SCALAR_P_CATEGORY - 'p'
	%  PROP_SCALAR_P_FORMAT - 'nn'
	%  PROP_RVECTOR_P - 27
	%  PROP_RVECTOR_P_TAG - 'prop_rvector_p'
	%  PROP_RVECTOR_P_CATEGORY - 'p'
	%  PROP_RVECTOR_P_FORMAT - 'nr'
	%  PROP_CVECTOR_P - 28
	%  PROP_CVECTOR_P_TAG - 'prop_cvector_p'
	%  PROP_CVECTOR_P_CATEGORY - 'p'
	%  PROP_CVECTOR_P_FORMAT - 'nc'
	%  PROP_MATRIX_P - 29
	%  PROP_MATRIX_P_TAG - 'prop_matrix_p'
	%  PROP_MATRIX_P_CATEGORY - 'p'
	%  PROP_MATRIX_P_FORMAT - 'nm'
	%  PROP_SMATRIX_P - 30
	%  PROP_SMATRIX_P_TAG - 'prop_smatrix_p'
	%  PROP_SMATRIX_P_CATEGORY - 'p'
	%  PROP_SMATRIX_P_FORMAT - 'ns'
	%  PROP_CELL_P - 31
	%  PROP_CELL_P_TAG - 'prop_cell_p'
	%  PROP_CELL_P_CATEGORY - 'p'
	%  PROP_CELL_P_FORMAT - 'll'
	%  PROP_NET_P - 32
	%  PROP_NET_P_TAG - 'prop_net_p'
	%  PROP_NET_P_CATEGORY - 'p'
	%  PROP_NET_P_FORMAT - 'ml'
	%  PROP_EMPTY_D - 33
	%  PROP_EMPTY_D_TAG - 'prop_empty_d'
	%  PROP_EMPTY_D_CATEGORY - 'd'
	%  PROP_EMPTY_D_FORMAT - 'em'
	%  PROP_STRING_D - 34
	%  PROP_STRING_D_TAG - 'prop_string_d'
	%  PROP_STRING_D_CATEGORY - 'd'
	%  PROP_STRING_D_FORMAT - 'st'
	%  PROP_LOGICAL_D - 35
	%  PROP_LOGICAL_D_TAG - 'prop_logical_d'
	%  PROP_LOGICAL_D_CATEGORY - 'd'
	%  PROP_LOGICAL_D_FORMAT - 'lo'
	%  PROP_OPTION_D - 36
	%  PROP_OPTION_D_TAG - 'prop_option_d'
	%  PROP_OPTION_D_CATEGORY - 'd'
	%  PROP_OPTION_D_FORMAT - 'op'
	%  PROP_CLASS_D - 37
	%  PROP_CLASS_D_TAG - 'prop_class_d'
	%  PROP_CLASS_D_CATEGORY - 'd'
	%  PROP_CLASS_D_FORMAT - 'ca'
	%  PROP_CLASSLIST_D - 38
	%  PROP_CLASSLIST_D_TAG - 'prop_classlist_d'
	%  PROP_CLASSLIST_D_CATEGORY - 'd'
	%  PROP_CLASSLIST_D_FORMAT - 'cl'
	%  PROP_ITEM_D - 39
	%  PROP_ITEM_D_TAG - 'prop_item_d'
	%  PROP_ITEM_D_CATEGORY - 'd'
	%  PROP_ITEM_D_FORMAT - 'it'
	%  PROP_ITEMLIST_D - 40
	%  PROP_ITEMLIST_D_TAG - 'prop_itemlist_d'
	%  PROP_ITEMLIST_D_CATEGORY - 'd'
	%  PROP_ITEMLIST_D_FORMAT - 'il'
	%  PROP_IDICT_D - 41
	%  PROP_IDICT_D_TAG - 'prop_idict_d'
	%  PROP_IDICT_D_CATEGORY - 'd'
	%  PROP_IDICT_D_FORMAT - 'di'
	%  PROP_SCALAR_D - 42
	%  PROP_SCALAR_D_TAG - 'prop_scalar_d'
	%  PROP_SCALAR_D_CATEGORY - 'd'
	%  PROP_SCALAR_D_FORMAT - 'nn'
	%  PROP_RVECTOR_D - 43
	%  PROP_RVECTOR_D_TAG - 'prop_rvector_d'
	%  PROP_RVECTOR_D_CATEGORY - 'd'
	%  PROP_RVECTOR_D_FORMAT - 'nr'
	%  PROP_CVECTOR_D - 44
	%  PROP_CVECTOR_D_TAG - 'prop_cvector_d'
	%  PROP_CVECTOR_D_CATEGORY - 'd'
	%  PROP_CVECTOR_D_FORMAT - 'nc'
	%  PROP_MATRIX_D - 45
	%  PROP_MATRIX_D_TAG - 'prop_matrix_d'
	%  PROP_MATRIX_D_CATEGORY - 'd'
	%  PROP_MATRIX_D_FORMAT - 'nm'
	%  PROP_SMATRIX_D - 46
	%  PROP_SMATRIX_D_TAG - 'prop_smatrix_d'
	%  PROP_SMATRIX_D_CATEGORY - 'd'
	%  PROP_SMATRIX_D_FORMAT - 'ns'
	%  PROP_CELL_D - 47
	%  PROP_CELL_D_TAG - 'prop_cell_d'
	%  PROP_CELL_D_CATEGORY - 'd'
	%  PROP_CELL_D_FORMAT - 'll'
	%  PROP_NET_D - 48
	%  PROP_NET_D_TAG - 'prop_net_d'
	%  PROP_NET_D_CATEGORY - 'd'
	%  PROP_NET_D_FORMAT - 'ml'
	%  PROP_EMPTY_F - 49
	%  PROP_EMPTY_F_TAG - 'prop_empty_f'
	%  PROP_EMPTY_F_CATEGORY - 'f'
	%  PROP_EMPTY_F_FORMAT - 'em'
	%  PROP_STRING_F - 50
	%  PROP_STRING_F_TAG - 'prop_string_f'
	%  PROP_STRING_F_CATEGORY - 'f'
	%  PROP_STRING_F_FORMAT - 'st'
	%  PROP_LOGICAL_F - 51
	%  PROP_LOGICAL_F_TAG - 'prop_logical_f'
	%  PROP_LOGICAL_F_CATEGORY - 'f'
	%  PROP_LOGICAL_F_FORMAT - 'lo'
	%  PROP_OPTION_F - 52
	%  PROP_OPTION_F_TAG - 'prop_option_f'
	%  PROP_OPTION_F_CATEGORY - 'f'
	%  PROP_OPTION_F_FORMAT - 'op'
	%  PROP_CLASS_F - 53
	%  PROP_CLASS_F_TAG - 'prop_class_f'
	%  PROP_CLASS_F_CATEGORY - 'f'
	%  PROP_CLASS_F_FORMAT - 'ca'
	%  PROP_CLASSLIST_F - 54
	%  PROP_CLASSLIST_F_TAG - 'prop_classlist_f'
	%  PROP_CLASSLIST_F_CATEGORY - 'f'
	%  PROP_CLASSLIST_F_FORMAT - 'cl'
	%  PROP_ITEM_F - 55
	%  PROP_ITEM_F_TAG - 'prop_item_f'
	%  PROP_ITEM_F_CATEGORY - 'f'
	%  PROP_ITEM_F_FORMAT - 'it'
	%  PROP_ITEMLIST_F - 56
	%  PROP_ITEMLIST_F_TAG - 'prop_itemlist_f'
	%  PROP_ITEMLIST_F_CATEGORY - 'f'
	%  PROP_ITEMLIST_F_FORMAT - 'il'
	%  PROP_IDICT_F - 57
	%  PROP_IDICT_F_TAG - 'prop_idict_f'
	%  PROP_IDICT_F_CATEGORY - 'f'
	%  PROP_IDICT_F_FORMAT - 'di'
	%  PROP_SCALAR_F - 58
	%  PROP_SCALAR_F_TAG - 'prop_scalar_f'
	%  PROP_SCALAR_F_CATEGORY - 'f'
	%  PROP_SCALAR_F_FORMAT - 'nn'
	%  PROP_RVECTOR_F - 59
	%  PROP_RVECTOR_F_TAG - 'prop_rvector_f'
	%  PROP_RVECTOR_F_CATEGORY - 'f'
	%  PROP_RVECTOR_F_FORMAT - 'nr'
	%  PROP_CVECTOR_F - 60
	%  PROP_CVECTOR_F_TAG - 'prop_cvector_f'
	%  PROP_CVECTOR_F_CATEGORY - 'f'
	%  PROP_CVECTOR_F_FORMAT - 'nc'
	%  PROP_MATRIX_F - 61
	%  PROP_MATRIX_F_TAG - 'prop_matrix_f'
	%  PROP_MATRIX_F_CATEGORY - 'f'
	%  PROP_MATRIX_F_FORMAT - 'nm'
	%  PROP_SMATRIX_F - 62
	%  PROP_SMATRIX_F_TAG - 'prop_smatrix_f'
	%  PROP_SMATRIX_F_CATEGORY - 'f'
	%  PROP_SMATRIX_F_FORMAT - 'ns'
	%  PROP_CELL_F - 63
	%  PROP_CELL_F_TAG - 'prop_cell_f'
	%  PROP_CELL_F_CATEGORY - 'f'
	%  PROP_CELL_F_FORMAT - 'll'
	%  PROP_NET_F - 64
	%  PROP_NET_F_TAG - 'prop_net_f'
	%  PROP_NET_F_CATEGORY - 'f'
	%  PROP_NET_F_FORMAT - 'ml'
	%  PROP_EMPTY_G - 65
	%  PROP_EMPTY_G_TAG - 'prop_empty_g'
	%  PROP_EMPTY_G_CATEGORY - 'g'
	%  PROP_EMPTY_G_FORMAT - 'em'
	%  PROP_STRING_G - 66
	%  PROP_STRING_G_TAG - 'prop_string_g'
	%  PROP_STRING_G_CATEGORY - 'g'
	%  PROP_STRING_G_FORMAT - 'st'
	%  PROP_LOGICAL_G - 67
	%  PROP_LOGICAL_G_TAG - 'prop_logical_g'
	%  PROP_LOGICAL_G_CATEGORY - 'g'
	%  PROP_LOGICAL_G_FORMAT - 'lo'
	%  PROP_OPTION_G - 68
	%  PROP_OPTION_G_TAG - 'prop_option_g'
	%  PROP_OPTION_G_CATEGORY - 'g'
	%  PROP_OPTION_G_FORMAT - 'op'
	%  PROP_CLASS_G - 69
	%  PROP_CLASS_G_TAG - 'prop_class_g'
	%  PROP_CLASS_G_CATEGORY - 'g'
	%  PROP_CLASS_G_FORMAT - 'ca'
	%  PROP_CLASSLIST_G - 70
	%  PROP_CLASSLIST_G_TAG - 'prop_classlist_g'
	%  PROP_CLASSLIST_G_CATEGORY - 'g'
	%  PROP_CLASSLIST_G_FORMAT - 'cl'
	%  PROP_ITEM_G - 71
	%  PROP_ITEM_G_TAG - 'prop_item_g'
	%  PROP_ITEM_G_CATEGORY - 'g'
	%  PROP_ITEM_G_FORMAT - 'it'
	%  PROP_ITEMLIST_G - 72
	%  PROP_ITEMLIST_G_TAG - 'prop_itemlist_g'
	%  PROP_ITEMLIST_G_CATEGORY - 'g'
	%  PROP_ITEMLIST_G_FORMAT - 'il'
	%  PROP_IDICT_G - 73
	%  PROP_IDICT_G_TAG - 'prop_idict_g'
	%  PROP_IDICT_G_CATEGORY - 'g'
	%  PROP_IDICT_G_FORMAT - 'di'
	%  PROP_SCALAR_G - 74
	%  PROP_SCALAR_G_TAG - 'prop_scalar_g'
	%  PROP_SCALAR_G_CATEGORY - 'g'
	%  PROP_SCALAR_G_FORMAT - 'nn'
	%  PROP_RVECTOR_G - 75
	%  PROP_RVECTOR_G_TAG - 'prop_rvector_g'
	%  PROP_RVECTOR_G_CATEGORY - 'g'
	%  PROP_RVECTOR_G_FORMAT - 'nr'
	%  PROP_CVECTOR_G - 76
	%  PROP_CVECTOR_G_TAG - 'prop_cvector_g'
	%  PROP_CVECTOR_G_CATEGORY - 'g'
	%  PROP_CVECTOR_G_FORMAT - 'nc'
	%  PROP_MATRIX_G - 77
	%  PROP_MATRIX_G_TAG - 'prop_matrix_g'
	%  PROP_MATRIX_G_CATEGORY - 'g'
	%  PROP_MATRIX_G_FORMAT - 'nm'
	%  PROP_SMATRIX_G - 78
	%  PROP_SMATRIX_G_TAG - 'prop_smatrix_g'
	%  PROP_SMATRIX_G_CATEGORY - 'g'
	%  PROP_SMATRIX_G_FORMAT - 'ns'
	%  PROP_CELL_G - 79
	%  PROP_CELL_G_TAG - 'prop_cell_g'
	%  PROP_CELL_G_CATEGORY - 'g'
	%  PROP_CELL_G_FORMAT - 'll'
	%  PROP_NET_G - 80
	%  PROP_NET_G_TAG - 'prop_net_g'
	%  PROP_NET_G_CATEGORY - 'g'
	%  PROP_NET_G_FORMAT - 'ml'
	%  PROP_EMPTY_R - 81
	%  PROP_EMPTY_R_TAG - 'prop_empty_r'
	%  PROP_EMPTY_R_CATEGORY - 'r'
	%  PROP_EMPTY_R_FORMAT - 'em'
	%  PROP_STRING_R - 82
	%  PROP_STRING_R_TAG - 'prop_string_r'
	%  PROP_STRING_R_CATEGORY - 'r'
	%  PROP_STRING_R_FORMAT - 'st'
	%  PROP_LOGICAL_R - 83
	%  PROP_LOGICAL_R_TAG - 'prop_logical_r'
	%  PROP_LOGICAL_R_CATEGORY - 'r'
	%  PROP_LOGICAL_R_FORMAT - 'lo'
	%  PROP_OPTION_R - 84
	%  PROP_OPTION_R_TAG - 'prop_option_r'
	%  PROP_OPTION_R_CATEGORY - 'r'
	%  PROP_OPTION_R_FORMAT - 'op'
	%  PROP_CLASS_R - 85
	%  PROP_CLASS_R_TAG - 'prop_class_r'
	%  PROP_CLASS_R_CATEGORY - 'r'
	%  PROP_CLASS_R_FORMAT - 'ca'
	%  PROP_CLASSLIST_R - 86
	%  PROP_CLASSLIST_R_TAG - 'prop_classlist_r'
	%  PROP_CLASSLIST_R_CATEGORY - 'r'
	%  PROP_CLASSLIST_R_FORMAT - 'cl'
	%  PROP_ITEM_R - 87
	%  PROP_ITEM_R_TAG - 'prop_item_r'
	%  PROP_ITEM_R_CATEGORY - 'r'
	%  PROP_ITEM_R_FORMAT - 'it'
	%  PROP_ITEMLIST_R - 88
	%  PROP_ITEMLIST_R_TAG - 'prop_itemlist_r'
	%  PROP_ITEMLIST_R_CATEGORY - 'r'
	%  PROP_ITEMLIST_R_FORMAT - 'il'
	%  PROP_IDICT_R - 89
	%  PROP_IDICT_R_TAG - 'prop_idict_r'
	%  PROP_IDICT_R_CATEGORY - 'r'
	%  PROP_IDICT_R_FORMAT - 'di'
	%  PROP_SCALAR_R - 90
	%  PROP_SCALAR_R_TAG - 'prop_scalar_r'
	%  PROP_SCALAR_R_CATEGORY - 'r'
	%  PROP_SCALAR_R_FORMAT - 'nn'
	%  PROP_RVECTOR_R - 91
	%  PROP_RVECTOR_R_TAG - 'prop_rvector_r'
	%  PROP_RVECTOR_R_CATEGORY - 'r'
	%  PROP_RVECTOR_R_FORMAT - 'nr'
	%  PROP_CVECTOR_R - 92
	%  PROP_CVECTOR_R_TAG - 'prop_cvector_r'
	%  PROP_CVECTOR_R_CATEGORY - 'r'
	%  PROP_CVECTOR_R_FORMAT - 'nc'
	%  PROP_MATRIX_R - 93
	%  PROP_MATRIX_R_TAG - 'prop_matrix_r'
	%  PROP_MATRIX_R_CATEGORY - 'r'
	%  PROP_MATRIX_R_FORMAT - 'nm'
	%  PROP_SMATRIX_R - 94
	%  PROP_SMATRIX_R_TAG - 'prop_smatrix_r'
	%  PROP_SMATRIX_R_CATEGORY - 'r'
	%  PROP_SMATRIX_R_FORMAT - 'ns'
	%  PROP_CELL_R - 95
	%  PROP_CELL_R_TAG - 'prop_cell_r'
	%  PROP_CELL_R_CATEGORY - 'r'
	%  PROP_CELL_R_FORMAT - 'll'
	%  PROP_NET_R - 96
	%  PROP_NET_R_TAG - 'prop_net_r'
	%  PROP_NET_R_CATEGORY - 'r'
	%  PROP_NET_R_FORMAT - 'ml'
	%  PROP_EMPTY_R_CALC - 97
	%  PROP_EMPTY_R_CALC_TAG - 'prop_empty_r_calc'
	%  PROP_EMPTY_R_CALC_CATEGORY - 'r'
	%  PROP_EMPTY_R_CALC_FORMAT - 'em'
	%  PROP_STRING_R_CALC - 98
	%  PROP_STRING_R_CALC_TAG - 'prop_string_r_calc'
	%  PROP_STRING_R_CALC_CATEGORY - 'r'
	%  PROP_STRING_R_CALC_FORMAT - 'st'
	%  PROP_LOGICAL_R_CALC - 99
	%  PROP_LOGICAL_R_CALC_TAG - 'prop_logical_r_calc'
	%  PROP_LOGICAL_R_CALC_CATEGORY - 'r'
	%  PROP_LOGICAL_R_CALC_FORMAT - 'lo'
	%  PROP_OPTION_R_CALC - 100
	%  PROP_OPTION_R_CALC_TAG - 'prop_option_r_calc'
	%  PROP_OPTION_R_CALC_CATEGORY - 'r'
	%  PROP_OPTION_R_CALC_FORMAT - 'op'
	%  PROP_CLASS_R_CALC - 101
	%  PROP_CLASS_R_CALC_TAG - 'prop_class_r_calc'
	%  PROP_CLASS_R_CALC_CATEGORY - 'r'
	%  PROP_CLASS_R_CALC_FORMAT - 'ca'
	%  PROP_CLASSLIST_R_CALC - 102
	%  PROP_CLASSLIST_R_CALC_TAG - 'prop_classlist_r_calc'
	%  PROP_CLASSLIST_R_CALC_CATEGORY - 'r'
	%  PROP_CLASSLIST_R_CALC_FORMAT - 'cl'
	%  PROP_ITEM_R_CALC - 103
	%  PROP_ITEM_R_CALC_TAG - 'prop_item_r_calc'
	%  PROP_ITEM_R_CALC_CATEGORY - 'r'
	%  PROP_ITEM_R_CALC_FORMAT - 'it'
	%  PROP_ITEMLIST_R_CALC - 104
	%  PROP_ITEMLIST_R_CALC_TAG - 'prop_itemlist_r_calc'
	%  PROP_ITEMLIST_R_CALC_CATEGORY - 'r'
	%  PROP_ITEMLIST_R_CALC_FORMAT - 'il'
	%  PROP_IDICT_R_CALC - 105
	%  PROP_IDICT_R_CALC_TAG - 'prop_idict_r_calc'
	%  PROP_IDICT_R_CALC_CATEGORY - 'r'
	%  PROP_IDICT_R_CALC_FORMAT - 'di'
	%  PROP_SCALAR_R_CALC - 106
	%  PROP_SCALAR_R_CALC_TAG - 'prop_scalar_r_calc'
	%  PROP_SCALAR_R_CALC_CATEGORY - 'r'
	%  PROP_SCALAR_R_CALC_FORMAT - 'nn'
	%  PROP_RVECTOR_R_CALC - 107
	%  PROP_RVECTOR_R_CALC_TAG - 'prop_rvector_r_calc'
	%  PROP_RVECTOR_R_CALC_CATEGORY - 'r'
	%  PROP_RVECTOR_R_CALC_FORMAT - 'nr'
	%  PROP_CVECTOR_R_CALC - 108
	%  PROP_CVECTOR_R_CALC_TAG - 'prop_cvector_r_calc'
	%  PROP_CVECTOR_R_CALC_CATEGORY - 'r'
	%  PROP_CVECTOR_R_CALC_FORMAT - 'nc'
	%  PROP_MATRIX_R_CALC - 109
	%  PROP_MATRIX_R_CALC_TAG - 'prop_matrix_r_calc'
	%  PROP_MATRIX_R_CALC_CATEGORY - 'r'
	%  PROP_MATRIX_R_CALC_FORMAT - 'nm'
	%  PROP_SMATRIX_R_CALC - 110
	%  PROP_SMATRIX_R_CALC_TAG - 'prop_smatrix_r_calc'
	%  PROP_SMATRIX_R_CALC_CATEGORY - 'r'
	%  PROP_SMATRIX_R_CALC_FORMAT - 'ns'
	%  PROP_CELL_R_CALC - 111
	%  PROP_CELL_R_CALC_TAG - 'prop_cell_r_calc'
	%  PROP_CELL_R_CALC_CATEGORY - 'r'
	%  PROP_CELL_R_CALC_FORMAT - 'll'
	%  PROP_NET_R_CALC - 112
	%  PROP_NET_R_CALC_TAG - 'prop_net_r_calc'
	%  PROP_NET_R_CALC_CATEGORY - 'r'
	%  PROP_NET_R_CALC_FORMAT - 'ml'
	%  METADATA - 'm'
	%  METADATA_NAME - 'metadata'
	%  METADATA_DESCRIPTION - 'Metadata NOT used in the calculation of the results (does not allow callbacks, not cloned).'
	%  PARAMETER - 'p'
	%  PARAMETER_NAME - 'parameter'
	%  PARAMETER_DESCRIPTION - 'Parameter used to calculate the results of the element (allows incoming and outgoing callbacks, cloned).'
	%  DATA - 'd'
	%  DATA_NAME - 'data'
	%  DATA_DESCRIPTION - 'Data used to calculate the results of the element (can be NoResult when not set, allows incoming and outgoing callbacks, not cloned).'
	%  RESULT - 'r'
	%  RESULT_NAME - 'result'
	%  RESULT_DESCRIPTION - 'Result calculated by the element using parameters and data (can be NoResult when not calculated, allows incoming callbacks).'
	%  FIGURE - 'f'
	%  FIGURE_NAME - 'figure'
	%  FIGURE_DESCRIPTION - 'Parameter used to plot the results in a figure (allows incoming and outgoing callbacks, not cloned).'
	%  GUI - 'g'
	%  GUI_NAME - 'gui'
	%  GUI_DESCRIPTION - 'Parameter used by the graphical user interface (allows incoming and outgoing callbacks, not cloned).'
	%  EMPTY - 'em'
	%  EMPTY_NAME - 'empty'
	%  EMPTY_DESCRIPTION - 'Empty has an empty value and is typically used as a result to execute some code.'
	%  STRING - 'st'
	%  STRING_NAME - 'string'
	%  STRING_DESCRIPTION - 'String is a char array.'
	%  LOGICAL - 'lo'
	%  LOGICAL_NAME - 'logical'
	%  LOGICAL_DESCRIPTION - 'Logical is a boolean value.'
	%  OPTION - 'op'
	%  OPTION_NAME - 'option'
	%  OPTION_DESCRIPTION - 'Option is a char array representing an option within a set defined in the element.'
	%  CLASS - 'ca'
	%  CLASS_NAME - 'class'
	%  CLASS_DESCRIPTION - 'Class is a char array corresponding to an element class.'
	%  CLASSLIST - 'cl'
	%  CLASSLIST_NAME - 'classlist'
	%  CLASSLIST_DESCRIPTION - 'ClassList is a cell array with char arrays corresponding to element classes.'
	%  ITEM - 'it'
	%  ITEM_NAME - 'item'
	%  ITEM_DESCRIPTION - 'Item is a pointer to an element of a class defined in the element.'
	%  ITEMLIST - 'il'
	%  ITEMLIST_NAME - 'itemlist'
	%  ITEMLIST_DESCRIPTION - 'ItemList is a cell array with pointers to elements of a class defined in the element.'
	%  IDICT - 'di'
	%  IDICT_NAME - 'idict'
	%  IDICT_DESCRIPTION - 'Idict is an indexed dictionary of elements of a class defined in the element.'
	%  SCALAR - 'nn'
	%  SCALAR_NAME - 'scalar'
	%  SCALAR_DESCRIPTION - 'Scalar is a scalar numerical value.'
	%  RVECTOR - 'nr'
	%  RVECTOR_NAME - 'rvector'
	%  RVECTOR_DESCRIPTION - 'Rvector is a numerical row vector.'
	%  CVECTOR - 'nc'
	%  CVECTOR_NAME - 'cvector'
	%  CVECTOR_DESCRIPTION - 'Cvector is a numerical column vector.'
	%  MATRIX - 'nm'
	%  MATRIX_NAME - 'matrix'
	%  MATRIX_DESCRIPTION - 'Matrix is a numerical matrix.'
	%  SMATRIX - 'ns'
	%  SMATRIX_NAME - 'smatrix'
	%  SMATRIX_DESCRIPTION - 'Smatrix is a numerical square matrix.'
	%  CELL - 'll'
	%  CELL_NAME - 'cell'
	%  CELL_DESCRIPTION - 'Cell is a 2D cell array of numeric data, typically used for adjaciency matrices and measures.'
	%  NET - 'ml'
	%  NET_NAME - 'net'
	%  NET_DESCRIPTION - 'Net is a MatLab neural network object.'
	%
	% See also Element, Category, Format.
	
	properties (Constant) % properties
		PROP_EMPTY_M = 1;
		PROP_EMPTY_M_TAG = 'prop_empty_m';
		PROP_EMPTY_M_CATEGORY = Category.METADATA;
		PROP_EMPTY_M_FORMAT = Format.EMPTY;
		
		PROP_STRING_M = 2;
		PROP_STRING_M_TAG = 'prop_string_m';
		PROP_STRING_M_CATEGORY = Category.METADATA;
		PROP_STRING_M_FORMAT = Format.STRING;
		
		PROP_LOGICAL_M = 3;
		PROP_LOGICAL_M_TAG = 'prop_logical_m';
		PROP_LOGICAL_M_CATEGORY = Category.METADATA;
		PROP_LOGICAL_M_FORMAT = Format.LOGICAL;
		
		PROP_OPTION_M = 4;
		PROP_OPTION_M_TAG = 'prop_option_m';
		PROP_OPTION_M_CATEGORY = Category.METADATA;
		PROP_OPTION_M_FORMAT = Format.OPTION;
		
		PROP_CLASS_M = 5;
		PROP_CLASS_M_TAG = 'prop_class_m';
		PROP_CLASS_M_CATEGORY = Category.METADATA;
		PROP_CLASS_M_FORMAT = Format.CLASS;
		
		PROP_CLASSLIST_M = 6;
		PROP_CLASSLIST_M_TAG = 'prop_classlist_m';
		PROP_CLASSLIST_M_CATEGORY = Category.METADATA;
		PROP_CLASSLIST_M_FORMAT = Format.CLASSLIST;
		
		PROP_ITEM_M = 7;
		PROP_ITEM_M_TAG = 'prop_item_m';
		PROP_ITEM_M_CATEGORY = Category.METADATA;
		PROP_ITEM_M_FORMAT = Format.ITEM;
		
		PROP_ITEMLIST_M = 8;
		PROP_ITEMLIST_M_TAG = 'prop_itemlist_m';
		PROP_ITEMLIST_M_CATEGORY = Category.METADATA;
		PROP_ITEMLIST_M_FORMAT = Format.ITEMLIST;
		
		PROP_IDICT_M = 9;
		PROP_IDICT_M_TAG = 'prop_idict_m';
		PROP_IDICT_M_CATEGORY = Category.METADATA;
		PROP_IDICT_M_FORMAT = Format.IDICT;
		
		PROP_SCALAR_M = 10;
		PROP_SCALAR_M_TAG = 'prop_scalar_m';
		PROP_SCALAR_M_CATEGORY = Category.METADATA;
		PROP_SCALAR_M_FORMAT = Format.SCALAR;
		
		PROP_RVECTOR_M = 11;
		PROP_RVECTOR_M_TAG = 'prop_rvector_m';
		PROP_RVECTOR_M_CATEGORY = Category.METADATA;
		PROP_RVECTOR_M_FORMAT = Format.RVECTOR;
		
		PROP_CVECTOR_M = 12;
		PROP_CVECTOR_M_TAG = 'prop_cvector_m';
		PROP_CVECTOR_M_CATEGORY = Category.METADATA;
		PROP_CVECTOR_M_FORMAT = Format.CVECTOR;
		
		PROP_MATRIX_M = 13;
		PROP_MATRIX_M_TAG = 'prop_matrix_m';
		PROP_MATRIX_M_CATEGORY = Category.METADATA;
		PROP_MATRIX_M_FORMAT = Format.MATRIX;
		
		PROP_SMATRIX_M = 14;
		PROP_SMATRIX_M_TAG = 'prop_smatrix_m';
		PROP_SMATRIX_M_CATEGORY = Category.METADATA;
		PROP_SMATRIX_M_FORMAT = Format.SMATRIX;
		
		PROP_CELL_M = 15;
		PROP_CELL_M_TAG = 'prop_cell_m';
		PROP_CELL_M_CATEGORY = Category.METADATA;
		PROP_CELL_M_FORMAT = Format.CELL;
		
		PROP_NET_M = 16;
		PROP_NET_M_TAG = 'prop_net_m';
		PROP_NET_M_CATEGORY = Category.METADATA;
		PROP_NET_M_FORMAT = Format.NET;
		
		PROP_EMPTY_P = 17;
		PROP_EMPTY_P_TAG = 'prop_empty_p';
		PROP_EMPTY_P_CATEGORY = Category.PARAMETER;
		PROP_EMPTY_P_FORMAT = Format.EMPTY;
		
		PROP_STRING_P = 18;
		PROP_STRING_P_TAG = 'prop_string_p';
		PROP_STRING_P_CATEGORY = Category.PARAMETER;
		PROP_STRING_P_FORMAT = Format.STRING;
		
		PROP_LOGICAL_P = 19;
		PROP_LOGICAL_P_TAG = 'prop_logical_p';
		PROP_LOGICAL_P_CATEGORY = Category.PARAMETER;
		PROP_LOGICAL_P_FORMAT = Format.LOGICAL;
		
		PROP_OPTION_P = 20;
		PROP_OPTION_P_TAG = 'prop_option_p';
		PROP_OPTION_P_CATEGORY = Category.PARAMETER;
		PROP_OPTION_P_FORMAT = Format.OPTION;
		
		PROP_CLASS_P = 21;
		PROP_CLASS_P_TAG = 'prop_class_p';
		PROP_CLASS_P_CATEGORY = Category.PARAMETER;
		PROP_CLASS_P_FORMAT = Format.CLASS;
		
		PROP_CLASSLIST_P = 22;
		PROP_CLASSLIST_P_TAG = 'prop_classlist_p';
		PROP_CLASSLIST_P_CATEGORY = Category.PARAMETER;
		PROP_CLASSLIST_P_FORMAT = Format.CLASSLIST;
		
		PROP_ITEM_P = 23;
		PROP_ITEM_P_TAG = 'prop_item_p';
		PROP_ITEM_P_CATEGORY = Category.PARAMETER;
		PROP_ITEM_P_FORMAT = Format.ITEM;
		
		PROP_ITEMLIST_P = 24;
		PROP_ITEMLIST_P_TAG = 'prop_itemlist_p';
		PROP_ITEMLIST_P_CATEGORY = Category.PARAMETER;
		PROP_ITEMLIST_P_FORMAT = Format.ITEMLIST;
		
		PROP_IDICT_P = 25;
		PROP_IDICT_P_TAG = 'prop_idict_p';
		PROP_IDICT_P_CATEGORY = Category.PARAMETER;
		PROP_IDICT_P_FORMAT = Format.IDICT;
		
		PROP_SCALAR_P = 26;
		PROP_SCALAR_P_TAG = 'prop_scalar_p';
		PROP_SCALAR_P_CATEGORY = Category.PARAMETER;
		PROP_SCALAR_P_FORMAT = Format.SCALAR;
		
		PROP_RVECTOR_P = 27;
		PROP_RVECTOR_P_TAG = 'prop_rvector_p';
		PROP_RVECTOR_P_CATEGORY = Category.PARAMETER;
		PROP_RVECTOR_P_FORMAT = Format.RVECTOR;
		
		PROP_CVECTOR_P = 28;
		PROP_CVECTOR_P_TAG = 'prop_cvector_p';
		PROP_CVECTOR_P_CATEGORY = Category.PARAMETER;
		PROP_CVECTOR_P_FORMAT = Format.CVECTOR;
		
		PROP_MATRIX_P = 29;
		PROP_MATRIX_P_TAG = 'prop_matrix_p';
		PROP_MATRIX_P_CATEGORY = Category.PARAMETER;
		PROP_MATRIX_P_FORMAT = Format.MATRIX;
		
		PROP_SMATRIX_P = 30;
		PROP_SMATRIX_P_TAG = 'prop_smatrix_p';
		PROP_SMATRIX_P_CATEGORY = Category.PARAMETER;
		PROP_SMATRIX_P_FORMAT = Format.SMATRIX;
		
		PROP_CELL_P = 31;
		PROP_CELL_P_TAG = 'prop_cell_p';
		PROP_CELL_P_CATEGORY = Category.PARAMETER;
		PROP_CELL_P_FORMAT = Format.CELL;
		
		PROP_NET_P = 32;
		PROP_NET_P_TAG = 'prop_net_p';
		PROP_NET_P_CATEGORY = Category.PARAMETER;
		PROP_NET_P_FORMAT = Format.NET;
		
		PROP_EMPTY_D = 33;
		PROP_EMPTY_D_TAG = 'prop_empty_d';
		PROP_EMPTY_D_CATEGORY = Category.DATA;
		PROP_EMPTY_D_FORMAT = Format.EMPTY;
		
		PROP_STRING_D = 34;
		PROP_STRING_D_TAG = 'prop_string_d';
		PROP_STRING_D_CATEGORY = Category.DATA;
		PROP_STRING_D_FORMAT = Format.STRING;
		
		PROP_LOGICAL_D = 35;
		PROP_LOGICAL_D_TAG = 'prop_logical_d';
		PROP_LOGICAL_D_CATEGORY = Category.DATA;
		PROP_LOGICAL_D_FORMAT = Format.LOGICAL;
		
		PROP_OPTION_D = 36;
		PROP_OPTION_D_TAG = 'prop_option_d';
		PROP_OPTION_D_CATEGORY = Category.DATA;
		PROP_OPTION_D_FORMAT = Format.OPTION;
		
		PROP_CLASS_D = 37;
		PROP_CLASS_D_TAG = 'prop_class_d';
		PROP_CLASS_D_CATEGORY = Category.DATA;
		PROP_CLASS_D_FORMAT = Format.CLASS;
		
		PROP_CLASSLIST_D = 38;
		PROP_CLASSLIST_D_TAG = 'prop_classlist_d';
		PROP_CLASSLIST_D_CATEGORY = Category.DATA;
		PROP_CLASSLIST_D_FORMAT = Format.CLASSLIST;
		
		PROP_ITEM_D = 39;
		PROP_ITEM_D_TAG = 'prop_item_d';
		PROP_ITEM_D_CATEGORY = Category.DATA;
		PROP_ITEM_D_FORMAT = Format.ITEM;
		
		PROP_ITEMLIST_D = 40;
		PROP_ITEMLIST_D_TAG = 'prop_itemlist_d';
		PROP_ITEMLIST_D_CATEGORY = Category.DATA;
		PROP_ITEMLIST_D_FORMAT = Format.ITEMLIST;
		
		PROP_IDICT_D = 41;
		PROP_IDICT_D_TAG = 'prop_idict_d';
		PROP_IDICT_D_CATEGORY = Category.DATA;
		PROP_IDICT_D_FORMAT = Format.IDICT;
		
		PROP_SCALAR_D = 42;
		PROP_SCALAR_D_TAG = 'prop_scalar_d';
		PROP_SCALAR_D_CATEGORY = Category.DATA;
		PROP_SCALAR_D_FORMAT = Format.SCALAR;
		
		PROP_RVECTOR_D = 43;
		PROP_RVECTOR_D_TAG = 'prop_rvector_d';
		PROP_RVECTOR_D_CATEGORY = Category.DATA;
		PROP_RVECTOR_D_FORMAT = Format.RVECTOR;
		
		PROP_CVECTOR_D = 44;
		PROP_CVECTOR_D_TAG = 'prop_cvector_d';
		PROP_CVECTOR_D_CATEGORY = Category.DATA;
		PROP_CVECTOR_D_FORMAT = Format.CVECTOR;
		
		PROP_MATRIX_D = 45;
		PROP_MATRIX_D_TAG = 'prop_matrix_d';
		PROP_MATRIX_D_CATEGORY = Category.DATA;
		PROP_MATRIX_D_FORMAT = Format.MATRIX;
		
		PROP_SMATRIX_D = 46;
		PROP_SMATRIX_D_TAG = 'prop_smatrix_d';
		PROP_SMATRIX_D_CATEGORY = Category.DATA;
		PROP_SMATRIX_D_FORMAT = Format.SMATRIX;
		
		PROP_CELL_D = 47;
		PROP_CELL_D_TAG = 'prop_cell_d';
		PROP_CELL_D_CATEGORY = Category.DATA;
		PROP_CELL_D_FORMAT = Format.CELL;
		
		PROP_NET_D = 48;
		PROP_NET_D_TAG = 'prop_net_d';
		PROP_NET_D_CATEGORY = Category.DATA;
		PROP_NET_D_FORMAT = Format.NET;
		
		PROP_EMPTY_F = 49;
		PROP_EMPTY_F_TAG = 'prop_empty_f';
		PROP_EMPTY_F_CATEGORY = Category.FIGURE;
		PROP_EMPTY_F_FORMAT = Format.EMPTY;
		
		PROP_STRING_F = 50;
		PROP_STRING_F_TAG = 'prop_string_f';
		PROP_STRING_F_CATEGORY = Category.FIGURE;
		PROP_STRING_F_FORMAT = Format.STRING;
		
		PROP_LOGICAL_F = 51;
		PROP_LOGICAL_F_TAG = 'prop_logical_f';
		PROP_LOGICAL_F_CATEGORY = Category.FIGURE;
		PROP_LOGICAL_F_FORMAT = Format.LOGICAL;
		
		PROP_OPTION_F = 52;
		PROP_OPTION_F_TAG = 'prop_option_f';
		PROP_OPTION_F_CATEGORY = Category.FIGURE;
		PROP_OPTION_F_FORMAT = Format.OPTION;
		
		PROP_CLASS_F = 53;
		PROP_CLASS_F_TAG = 'prop_class_f';
		PROP_CLASS_F_CATEGORY = Category.FIGURE;
		PROP_CLASS_F_FORMAT = Format.CLASS;
		
		PROP_CLASSLIST_F = 54;
		PROP_CLASSLIST_F_TAG = 'prop_classlist_f';
		PROP_CLASSLIST_F_CATEGORY = Category.FIGURE;
		PROP_CLASSLIST_F_FORMAT = Format.CLASSLIST;
		
		PROP_ITEM_F = 55;
		PROP_ITEM_F_TAG = 'prop_item_f';
		PROP_ITEM_F_CATEGORY = Category.FIGURE;
		PROP_ITEM_F_FORMAT = Format.ITEM;
		
		PROP_ITEMLIST_F = 56;
		PROP_ITEMLIST_F_TAG = 'prop_itemlist_f';
		PROP_ITEMLIST_F_CATEGORY = Category.FIGURE;
		PROP_ITEMLIST_F_FORMAT = Format.ITEMLIST;
		
		PROP_IDICT_F = 57;
		PROP_IDICT_F_TAG = 'prop_idict_f';
		PROP_IDICT_F_CATEGORY = Category.FIGURE;
		PROP_IDICT_F_FORMAT = Format.IDICT;
		
		PROP_SCALAR_F = 58;
		PROP_SCALAR_F_TAG = 'prop_scalar_f';
		PROP_SCALAR_F_CATEGORY = Category.FIGURE;
		PROP_SCALAR_F_FORMAT = Format.SCALAR;
		
		PROP_RVECTOR_F = 59;
		PROP_RVECTOR_F_TAG = 'prop_rvector_f';
		PROP_RVECTOR_F_CATEGORY = Category.FIGURE;
		PROP_RVECTOR_F_FORMAT = Format.RVECTOR;
		
		PROP_CVECTOR_F = 60;
		PROP_CVECTOR_F_TAG = 'prop_cvector_f';
		PROP_CVECTOR_F_CATEGORY = Category.FIGURE;
		PROP_CVECTOR_F_FORMAT = Format.CVECTOR;
		
		PROP_MATRIX_F = 61;
		PROP_MATRIX_F_TAG = 'prop_matrix_f';
		PROP_MATRIX_F_CATEGORY = Category.FIGURE;
		PROP_MATRIX_F_FORMAT = Format.MATRIX;
		
		PROP_SMATRIX_F = 62;
		PROP_SMATRIX_F_TAG = 'prop_smatrix_f';
		PROP_SMATRIX_F_CATEGORY = Category.FIGURE;
		PROP_SMATRIX_F_FORMAT = Format.SMATRIX;
		
		PROP_CELL_F = 63;
		PROP_CELL_F_TAG = 'prop_cell_f';
		PROP_CELL_F_CATEGORY = Category.FIGURE;
		PROP_CELL_F_FORMAT = Format.CELL;
		
		PROP_NET_F = 64;
		PROP_NET_F_TAG = 'prop_net_f';
		PROP_NET_F_CATEGORY = Category.FIGURE;
		PROP_NET_F_FORMAT = Format.NET;
		
		PROP_EMPTY_G = 65;
		PROP_EMPTY_G_TAG = 'prop_empty_g';
		PROP_EMPTY_G_CATEGORY = Category.GUI;
		PROP_EMPTY_G_FORMAT = Format.EMPTY;
		
		PROP_STRING_G = 66;
		PROP_STRING_G_TAG = 'prop_string_g';
		PROP_STRING_G_CATEGORY = Category.GUI;
		PROP_STRING_G_FORMAT = Format.STRING;
		
		PROP_LOGICAL_G = 67;
		PROP_LOGICAL_G_TAG = 'prop_logical_g';
		PROP_LOGICAL_G_CATEGORY = Category.GUI;
		PROP_LOGICAL_G_FORMAT = Format.LOGICAL;
		
		PROP_OPTION_G = 68;
		PROP_OPTION_G_TAG = 'prop_option_g';
		PROP_OPTION_G_CATEGORY = Category.GUI;
		PROP_OPTION_G_FORMAT = Format.OPTION;
		
		PROP_CLASS_G = 69;
		PROP_CLASS_G_TAG = 'prop_class_g';
		PROP_CLASS_G_CATEGORY = Category.GUI;
		PROP_CLASS_G_FORMAT = Format.CLASS;
		
		PROP_CLASSLIST_G = 70;
		PROP_CLASSLIST_G_TAG = 'prop_classlist_g';
		PROP_CLASSLIST_G_CATEGORY = Category.GUI;
		PROP_CLASSLIST_G_FORMAT = Format.CLASSLIST;
		
		PROP_ITEM_G = 71;
		PROP_ITEM_G_TAG = 'prop_item_g';
		PROP_ITEM_G_CATEGORY = Category.GUI;
		PROP_ITEM_G_FORMAT = Format.ITEM;
		
		PROP_ITEMLIST_G = 72;
		PROP_ITEMLIST_G_TAG = 'prop_itemlist_g';
		PROP_ITEMLIST_G_CATEGORY = Category.GUI;
		PROP_ITEMLIST_G_FORMAT = Format.ITEMLIST;
		
		PROP_IDICT_G = 73;
		PROP_IDICT_G_TAG = 'prop_idict_g';
		PROP_IDICT_G_CATEGORY = Category.GUI;
		PROP_IDICT_G_FORMAT = Format.IDICT;
		
		PROP_SCALAR_G = 74;
		PROP_SCALAR_G_TAG = 'prop_scalar_g';
		PROP_SCALAR_G_CATEGORY = Category.GUI;
		PROP_SCALAR_G_FORMAT = Format.SCALAR;
		
		PROP_RVECTOR_G = 75;
		PROP_RVECTOR_G_TAG = 'prop_rvector_g';
		PROP_RVECTOR_G_CATEGORY = Category.GUI;
		PROP_RVECTOR_G_FORMAT = Format.RVECTOR;
		
		PROP_CVECTOR_G = 76;
		PROP_CVECTOR_G_TAG = 'prop_cvector_g';
		PROP_CVECTOR_G_CATEGORY = Category.GUI;
		PROP_CVECTOR_G_FORMAT = Format.CVECTOR;
		
		PROP_MATRIX_G = 77;
		PROP_MATRIX_G_TAG = 'prop_matrix_g';
		PROP_MATRIX_G_CATEGORY = Category.GUI;
		PROP_MATRIX_G_FORMAT = Format.MATRIX;
		
		PROP_SMATRIX_G = 78;
		PROP_SMATRIX_G_TAG = 'prop_smatrix_g';
		PROP_SMATRIX_G_CATEGORY = Category.GUI;
		PROP_SMATRIX_G_FORMAT = Format.SMATRIX;
		
		PROP_CELL_G = 79;
		PROP_CELL_G_TAG = 'prop_cell_g';
		PROP_CELL_G_CATEGORY = Category.GUI;
		PROP_CELL_G_FORMAT = Format.CELL;
		
		PROP_NET_G = 80;
		PROP_NET_G_TAG = 'prop_net_g';
		PROP_NET_G_CATEGORY = Category.GUI;
		PROP_NET_G_FORMAT = Format.NET;
		
		PROP_EMPTY_R = 81;
		PROP_EMPTY_R_TAG = 'prop_empty_r';
		PROP_EMPTY_R_CATEGORY = Category.RESULT;
		PROP_EMPTY_R_FORMAT = Format.EMPTY;
		
		PROP_STRING_R = 82;
		PROP_STRING_R_TAG = 'prop_string_r';
		PROP_STRING_R_CATEGORY = Category.RESULT;
		PROP_STRING_R_FORMAT = Format.STRING;
		
		PROP_LOGICAL_R = 83;
		PROP_LOGICAL_R_TAG = 'prop_logical_r';
		PROP_LOGICAL_R_CATEGORY = Category.RESULT;
		PROP_LOGICAL_R_FORMAT = Format.LOGICAL;
		
		PROP_OPTION_R = 84;
		PROP_OPTION_R_TAG = 'prop_option_r';
		PROP_OPTION_R_CATEGORY = Category.RESULT;
		PROP_OPTION_R_FORMAT = Format.OPTION;
		
		PROP_CLASS_R = 85;
		PROP_CLASS_R_TAG = 'prop_class_r';
		PROP_CLASS_R_CATEGORY = Category.RESULT;
		PROP_CLASS_R_FORMAT = Format.CLASS;
		
		PROP_CLASSLIST_R = 86;
		PROP_CLASSLIST_R_TAG = 'prop_classlist_r';
		PROP_CLASSLIST_R_CATEGORY = Category.RESULT;
		PROP_CLASSLIST_R_FORMAT = Format.CLASSLIST;
		
		PROP_ITEM_R = 87;
		PROP_ITEM_R_TAG = 'prop_item_r';
		PROP_ITEM_R_CATEGORY = Category.RESULT;
		PROP_ITEM_R_FORMAT = Format.ITEM;
		
		PROP_ITEMLIST_R = 88;
		PROP_ITEMLIST_R_TAG = 'prop_itemlist_r';
		PROP_ITEMLIST_R_CATEGORY = Category.RESULT;
		PROP_ITEMLIST_R_FORMAT = Format.ITEMLIST;
		
		PROP_IDICT_R = 89;
		PROP_IDICT_R_TAG = 'prop_idict_r';
		PROP_IDICT_R_CATEGORY = Category.RESULT;
		PROP_IDICT_R_FORMAT = Format.IDICT;
		
		PROP_SCALAR_R = 90;
		PROP_SCALAR_R_TAG = 'prop_scalar_r';
		PROP_SCALAR_R_CATEGORY = Category.RESULT;
		PROP_SCALAR_R_FORMAT = Format.SCALAR;
		
		PROP_RVECTOR_R = 91;
		PROP_RVECTOR_R_TAG = 'prop_rvector_r';
		PROP_RVECTOR_R_CATEGORY = Category.RESULT;
		PROP_RVECTOR_R_FORMAT = Format.RVECTOR;
		
		PROP_CVECTOR_R = 92;
		PROP_CVECTOR_R_TAG = 'prop_cvector_r';
		PROP_CVECTOR_R_CATEGORY = Category.RESULT;
		PROP_CVECTOR_R_FORMAT = Format.CVECTOR;
		
		PROP_MATRIX_R = 93;
		PROP_MATRIX_R_TAG = 'prop_matrix_r';
		PROP_MATRIX_R_CATEGORY = Category.RESULT;
		PROP_MATRIX_R_FORMAT = Format.MATRIX;
		
		PROP_SMATRIX_R = 94;
		PROP_SMATRIX_R_TAG = 'prop_smatrix_r';
		PROP_SMATRIX_R_CATEGORY = Category.RESULT;
		PROP_SMATRIX_R_FORMAT = Format.SMATRIX;
		
		PROP_CELL_R = 95;
		PROP_CELL_R_TAG = 'prop_cell_r';
		PROP_CELL_R_CATEGORY = Category.RESULT;
		PROP_CELL_R_FORMAT = Format.CELL;
		
		PROP_NET_R = 96;
		PROP_NET_R_TAG = 'prop_net_r';
		PROP_NET_R_CATEGORY = Category.RESULT;
		PROP_NET_R_FORMAT = Format.NET;
		
		PROP_EMPTY_R_CALC = 97;
		PROP_EMPTY_R_CALC_TAG = 'prop_empty_r_calc';
		PROP_EMPTY_R_CALC_CATEGORY = Category.RESULT;
		PROP_EMPTY_R_CALC_FORMAT = Format.EMPTY;
		
		PROP_STRING_R_CALC = 98;
		PROP_STRING_R_CALC_TAG = 'prop_string_r_calc';
		PROP_STRING_R_CALC_CATEGORY = Category.RESULT;
		PROP_STRING_R_CALC_FORMAT = Format.STRING;
		
		PROP_LOGICAL_R_CALC = 99;
		PROP_LOGICAL_R_CALC_TAG = 'prop_logical_r_calc';
		PROP_LOGICAL_R_CALC_CATEGORY = Category.RESULT;
		PROP_LOGICAL_R_CALC_FORMAT = Format.LOGICAL;
		
		PROP_OPTION_R_CALC = 100;
		PROP_OPTION_R_CALC_TAG = 'prop_option_r_calc';
		PROP_OPTION_R_CALC_CATEGORY = Category.RESULT;
		PROP_OPTION_R_CALC_FORMAT = Format.OPTION;
		
		PROP_CLASS_R_CALC = 101;
		PROP_CLASS_R_CALC_TAG = 'prop_class_r_calc';
		PROP_CLASS_R_CALC_CATEGORY = Category.RESULT;
		PROP_CLASS_R_CALC_FORMAT = Format.CLASS;
		
		PROP_CLASSLIST_R_CALC = 102;
		PROP_CLASSLIST_R_CALC_TAG = 'prop_classlist_r_calc';
		PROP_CLASSLIST_R_CALC_CATEGORY = Category.RESULT;
		PROP_CLASSLIST_R_CALC_FORMAT = Format.CLASSLIST;
		
		PROP_ITEM_R_CALC = 103;
		PROP_ITEM_R_CALC_TAG = 'prop_item_r_calc';
		PROP_ITEM_R_CALC_CATEGORY = Category.RESULT;
		PROP_ITEM_R_CALC_FORMAT = Format.ITEM;
		
		PROP_ITEMLIST_R_CALC = 104;
		PROP_ITEMLIST_R_CALC_TAG = 'prop_itemlist_r_calc';
		PROP_ITEMLIST_R_CALC_CATEGORY = Category.RESULT;
		PROP_ITEMLIST_R_CALC_FORMAT = Format.ITEMLIST;
		
		PROP_IDICT_R_CALC = 105;
		PROP_IDICT_R_CALC_TAG = 'prop_idict_r_calc';
		PROP_IDICT_R_CALC_CATEGORY = Category.RESULT;
		PROP_IDICT_R_CALC_FORMAT = Format.IDICT;
		
		PROP_SCALAR_R_CALC = 106;
		PROP_SCALAR_R_CALC_TAG = 'prop_scalar_r_calc';
		PROP_SCALAR_R_CALC_CATEGORY = Category.RESULT;
		PROP_SCALAR_R_CALC_FORMAT = Format.SCALAR;
		
		PROP_RVECTOR_R_CALC = 107;
		PROP_RVECTOR_R_CALC_TAG = 'prop_rvector_r_calc';
		PROP_RVECTOR_R_CALC_CATEGORY = Category.RESULT;
		PROP_RVECTOR_R_CALC_FORMAT = Format.RVECTOR;
		
		PROP_CVECTOR_R_CALC = 108;
		PROP_CVECTOR_R_CALC_TAG = 'prop_cvector_r_calc';
		PROP_CVECTOR_R_CALC_CATEGORY = Category.RESULT;
		PROP_CVECTOR_R_CALC_FORMAT = Format.CVECTOR;
		
		PROP_MATRIX_R_CALC = 109;
		PROP_MATRIX_R_CALC_TAG = 'prop_matrix_r_calc';
		PROP_MATRIX_R_CALC_CATEGORY = Category.RESULT;
		PROP_MATRIX_R_CALC_FORMAT = Format.MATRIX;
		
		PROP_SMATRIX_R_CALC = 110;
		PROP_SMATRIX_R_CALC_TAG = 'prop_smatrix_r_calc';
		PROP_SMATRIX_R_CALC_CATEGORY = Category.RESULT;
		PROP_SMATRIX_R_CALC_FORMAT = Format.SMATRIX;
		
		PROP_CELL_R_CALC = 111;
		PROP_CELL_R_CALC_TAG = 'prop_cell_r_calc';
		PROP_CELL_R_CALC_CATEGORY = Category.RESULT;
		PROP_CELL_R_CALC_FORMAT = Format.CELL;
		
		PROP_NET_R_CALC = 112;
		PROP_NET_R_CALC_TAG = 'prop_net_r_calc';
		PROP_NET_R_CALC_CATEGORY = Category.RESULT;
		PROP_NET_R_CALC_FORMAT = Format.NET;
	end
	methods (Static) % inspection methods
		function et_class = getClass()
			%GETCLASS returns the class of the test Element A.
			%
			% CLASS = ETA.GETCLASS() returns the class 'ETA'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ET.GETCLASS() returns the class of the test Element A ET.
			%  CLASS = Element.GETCLASS(ET) returns the class of 'ET'.
			%  CLASS = Element.GETCLASS('ETA') returns 'ETA'.
			%
			% See also getName, getDescription.
			
			et_class = 'ETA';
		end
		function et_name = getName()
			%GETNAME returns the name of the test Element A.
			%
			% NAME = ETA.GETNAME() returns the name of the 'test Element A'.
			%  Test Element A.
			%
			% Alternative forms to call this method are:
			%  NAME = ET.GETNAME() returns the name of the test Element A ET.
			%  NAME = Element.GETNAME(ET) returns the name of 'ET'.
			%  NAME = Element.GETNAME('ETA') returns the name of 'ETA'.
			%
			% See also getClass, getDescription.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			et_name = 'Test Element A';
		end
		function et_description = getDescription()
			%GETDESCRIPTION returns the description of the test Element A.
			%
			% STR = ETA.GETDESCRIPTION() returns the description of the 'test Element A'.
			%  which is:
			%
			%  Tests the methods set, get, and check for all properties categories and formats.
			%  It also checks the use of reproducible randomness, the conditioning, 
			%  and the restoring of a property after a failed check value.
			%
			% Alternative forms to call this method are:
			%  STR = ET.GETDESCRIPTION() returns the description of the test Element A ET.
			%  STR = Element.GETDESCRIPTION(ET) returns the description of 'ET'.
			%  STR = Element.GETDESCRIPTION('ETA') returns the description of 'ETA'.
			%
			% See also getClass, getName.
			
			et_description = [
				'Tests the methods set, get, and check for all properties categories and formats.' ...
				'It also checks the use of reproducible randomness, the conditioning, ' ...
				'and the restoring of a property after a failed check value.' ...
				];
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of test Element A.
			%
			% PROPS = ETA.GETPROPS() returns the property list of test Element A.
			%
			% PROPS = ETA.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ET.GETPROPS([CATEGORY]) returns the property list of the test Element A ET.
			%  PROPS = Element.GETPROPS(ET[, CATEGORY]) returns the property list of 'ET'.
			%  PROPS = Element.GETPROPS('ETA'[, CATEGORY]) returns the property list of 'ETA'.
			%
			% See also getPropNumber.
			
			if nargin < 1
				category = 'all';
			end
			
			switch category
				case Category.METADATA
					prop_list = [
						ETA.PROP_EMPTY_M
						ETA.PROP_STRING_M
						ETA.PROP_LOGICAL_M
						ETA.PROP_OPTION_M
						ETA.PROP_CLASS_M
						ETA.PROP_CLASSLIST_M
						ETA.PROP_ITEM_M
						ETA.PROP_ITEMLIST_M
						ETA.PROP_IDICT_M
						ETA.PROP_SCALAR_M
						ETA.PROP_RVECTOR_M
						ETA.PROP_CVECTOR_M
						ETA.PROP_MATRIX_M
						ETA.PROP_SMATRIX_M
						ETA.PROP_CELL_M
						ETA.PROP_NET_M
						];
				case Category.PARAMETER
					prop_list = [
						ETA.PROP_EMPTY_P
						ETA.PROP_STRING_P
						ETA.PROP_LOGICAL_P
						ETA.PROP_OPTION_P
						ETA.PROP_CLASS_P
						ETA.PROP_CLASSLIST_P
						ETA.PROP_ITEM_P
						ETA.PROP_ITEMLIST_P
						ETA.PROP_IDICT_P
						ETA.PROP_SCALAR_P
						ETA.PROP_RVECTOR_P
						ETA.PROP_CVECTOR_P
						ETA.PROP_MATRIX_P
						ETA.PROP_SMATRIX_P
						ETA.PROP_CELL_P
						ETA.PROP_NET_P
						];
				case Category.DATA
					prop_list = [
						ETA.PROP_EMPTY_D
						ETA.PROP_STRING_D
						ETA.PROP_LOGICAL_D
						ETA.PROP_OPTION_D
						ETA.PROP_CLASS_D
						ETA.PROP_CLASSLIST_D
						ETA.PROP_ITEM_D
						ETA.PROP_ITEMLIST_D
						ETA.PROP_IDICT_D
						ETA.PROP_SCALAR_D
						ETA.PROP_RVECTOR_D
						ETA.PROP_CVECTOR_D
						ETA.PROP_MATRIX_D
						ETA.PROP_SMATRIX_D
						ETA.PROP_CELL_D
						ETA.PROP_NET_D
						];
				case Category.RESULT
					prop_list = [
						ETA.PROP_EMPTY_R
						ETA.PROP_STRING_R
						ETA.PROP_LOGICAL_R
						ETA.PROP_OPTION_R
						ETA.PROP_CLASS_R
						ETA.PROP_CLASSLIST_R
						ETA.PROP_ITEM_R
						ETA.PROP_ITEMLIST_R
						ETA.PROP_IDICT_R
						ETA.PROP_SCALAR_R
						ETA.PROP_RVECTOR_R
						ETA.PROP_CVECTOR_R
						ETA.PROP_MATRIX_R
						ETA.PROP_SMATRIX_R
						ETA.PROP_CELL_R
						ETA.PROP_NET_R
						ETA.PROP_EMPTY_R_CALC
						ETA.PROP_STRING_R_CALC
						ETA.PROP_LOGICAL_R_CALC
						ETA.PROP_OPTION_R_CALC
						ETA.PROP_CLASS_R_CALC
						ETA.PROP_CLASSLIST_R_CALC
						ETA.PROP_ITEM_R_CALC
						ETA.PROP_ITEMLIST_R_CALC
						ETA.PROP_IDICT_R_CALC
						ETA.PROP_SCALAR_R_CALC
						ETA.PROP_RVECTOR_R_CALC
						ETA.PROP_CVECTOR_R_CALC
						ETA.PROP_MATRIX_R_CALC
						ETA.PROP_SMATRIX_R_CALC
						ETA.PROP_CELL_R_CALC
						ETA.PROP_NET_R_CALC
						];
				case Category.FIGURE
					prop_list = [
						ETA.PROP_EMPTY_F
						ETA.PROP_STRING_F
						ETA.PROP_LOGICAL_F
						ETA.PROP_OPTION_F
						ETA.PROP_CLASS_F
						ETA.PROP_CLASSLIST_F
						ETA.PROP_ITEM_F
						ETA.PROP_ITEMLIST_F
						ETA.PROP_IDICT_F
						ETA.PROP_SCALAR_F
						ETA.PROP_RVECTOR_F
						ETA.PROP_CVECTOR_F
						ETA.PROP_MATRIX_F
						ETA.PROP_SMATRIX_F
						ETA.PROP_CELL_F
						ETA.PROP_NET_F
						];
				case Category.GUI
					prop_list = [
						ETA.PROP_EMPTY_G
						ETA.PROP_STRING_G
						ETA.PROP_LOGICAL_G
						ETA.PROP_OPTION_G
						ETA.PROP_CLASS_G
						ETA.PROP_CLASSLIST_G
						ETA.PROP_ITEM_G
						ETA.PROP_ITEMLIST_G
						ETA.PROP_IDICT_G
						ETA.PROP_SCALAR_G
						ETA.PROP_RVECTOR_G
						ETA.PROP_CVECTOR_G
						ETA.PROP_MATRIX_G
						ETA.PROP_SMATRIX_G
						ETA.PROP_CELL_G
						ETA.PROP_NET_G
						];
				otherwise
					prop_list = [
						ETA.PROP_EMPTY_M
						ETA.PROP_STRING_M
						ETA.PROP_LOGICAL_M
						ETA.PROP_OPTION_M
						ETA.PROP_CLASS_M
						ETA.PROP_CLASSLIST_M
						ETA.PROP_ITEM_M
						ETA.PROP_ITEMLIST_M
						ETA.PROP_IDICT_M
						ETA.PROP_SCALAR_M
						ETA.PROP_RVECTOR_M
						ETA.PROP_CVECTOR_M
						ETA.PROP_MATRIX_M
						ETA.PROP_SMATRIX_M
						ETA.PROP_CELL_M
						ETA.PROP_NET_M
						ETA.PROP_EMPTY_P
						ETA.PROP_STRING_P
						ETA.PROP_LOGICAL_P
						ETA.PROP_OPTION_P
						ETA.PROP_CLASS_P
						ETA.PROP_CLASSLIST_P
						ETA.PROP_ITEM_P
						ETA.PROP_ITEMLIST_P
						ETA.PROP_IDICT_P
						ETA.PROP_SCALAR_P
						ETA.PROP_RVECTOR_P
						ETA.PROP_CVECTOR_P
						ETA.PROP_MATRIX_P
						ETA.PROP_SMATRIX_P
						ETA.PROP_CELL_P
						ETA.PROP_NET_P
						ETA.PROP_EMPTY_D
						ETA.PROP_STRING_D
						ETA.PROP_LOGICAL_D
						ETA.PROP_OPTION_D
						ETA.PROP_CLASS_D
						ETA.PROP_CLASSLIST_D
						ETA.PROP_ITEM_D
						ETA.PROP_ITEMLIST_D
						ETA.PROP_IDICT_D
						ETA.PROP_SCALAR_D
						ETA.PROP_RVECTOR_D
						ETA.PROP_CVECTOR_D
						ETA.PROP_MATRIX_D
						ETA.PROP_SMATRIX_D
						ETA.PROP_CELL_D
						ETA.PROP_NET_D
						ETA.PROP_EMPTY_F
						ETA.PROP_STRING_F
						ETA.PROP_LOGICAL_F
						ETA.PROP_OPTION_F
						ETA.PROP_CLASS_F
						ETA.PROP_CLASSLIST_F
						ETA.PROP_ITEM_F
						ETA.PROP_ITEMLIST_F
						ETA.PROP_IDICT_F
						ETA.PROP_SCALAR_F
						ETA.PROP_RVECTOR_F
						ETA.PROP_CVECTOR_F
						ETA.PROP_MATRIX_F
						ETA.PROP_SMATRIX_F
						ETA.PROP_CELL_F
						ETA.PROP_NET_F
						ETA.PROP_EMPTY_G
						ETA.PROP_STRING_G
						ETA.PROP_LOGICAL_G
						ETA.PROP_OPTION_G
						ETA.PROP_CLASS_G
						ETA.PROP_CLASSLIST_G
						ETA.PROP_ITEM_G
						ETA.PROP_ITEMLIST_G
						ETA.PROP_IDICT_G
						ETA.PROP_SCALAR_G
						ETA.PROP_RVECTOR_G
						ETA.PROP_CVECTOR_G
						ETA.PROP_MATRIX_G
						ETA.PROP_SMATRIX_G
						ETA.PROP_CELL_G
						ETA.PROP_NET_G
						ETA.PROP_EMPTY_R
						ETA.PROP_STRING_R
						ETA.PROP_LOGICAL_R
						ETA.PROP_OPTION_R
						ETA.PROP_CLASS_R
						ETA.PROP_CLASSLIST_R
						ETA.PROP_ITEM_R
						ETA.PROP_ITEMLIST_R
						ETA.PROP_IDICT_R
						ETA.PROP_SCALAR_R
						ETA.PROP_RVECTOR_R
						ETA.PROP_CVECTOR_R
						ETA.PROP_MATRIX_R
						ETA.PROP_SMATRIX_R
						ETA.PROP_CELL_R
						ETA.PROP_NET_R
						ETA.PROP_EMPTY_R_CALC
						ETA.PROP_STRING_R_CALC
						ETA.PROP_LOGICAL_R_CALC
						ETA.PROP_OPTION_R_CALC
						ETA.PROP_CLASS_R_CALC
						ETA.PROP_CLASSLIST_R_CALC
						ETA.PROP_ITEM_R_CALC
						ETA.PROP_ITEMLIST_R_CALC
						ETA.PROP_IDICT_R_CALC
						ETA.PROP_SCALAR_R_CALC
						ETA.PROP_RVECTOR_R_CALC
						ETA.PROP_CVECTOR_R_CALC
						ETA.PROP_MATRIX_R_CALC
						ETA.PROP_SMATRIX_R_CALC
						ETA.PROP_CELL_R_CALC
						ETA.PROP_NET_R_CALC
						];
			end
		end
		function prop_number = getPropNumber()
			%GETPROPNUMBER returns the property number of test Element A.
			%
			% N = ETA.GETPROPNUMBER() returns the property number of test Element A.
			%
			% Alternative forms to call this method are:
			%  N = ET.GETPROPNUMBER() returns the property number of the test Element A ET.
			%  N = Element.GETPROPNUMBER(ET) returns the property number of 'ET'.
			%  N = Element.GETPROPNUMBER('ETA') returns the property number of 'ETA'.
			%
			% See also getProps.
			
			% COMPUTATIONAL EFFICIENCY TRICK
			prop_number = 112;
		end
		function check = existsProp(prop)
			%EXISTSPROP checks whether property exists in test Element A/error.
			%
			% CHECK = ETA.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSPROP(PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ET, PROP) checks whether PROP exists for ET.
			%  CHECK = Element.EXISTSPROP(ETA, PROP) checks whether PROP exists for ETA.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ETA:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSPROP(PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETA:WrongInput]
			%  Element.EXISTSPROP(ET, PROP) throws error if PROP does NOT exist for ET.
			%   Error id: [BRAPH2:ETA:WrongInput]
			%  Element.EXISTSPROP(ETA, PROP) throws error if PROP does NOT exist for ETA.
			%   Error id: [BRAPH2:ETA:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				check = any(prop == [ 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40  41  42  43  44  45  46  47  48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99  100  101  102  103  104  105  106  107  108  109  110  111  112 ]);
			else
				assert( ...
					ETA.existsProp(prop), ...
					[BRAPH2.STR ':ETA:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETA:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ETA.'] ...
					)
			end
		end
		function check = existsTag(tag)
			%EXISTSTAG checks whether tag exists in test Element A/error.
			%
			% CHECK = ETA.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ET.EXISTSTAG(TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ET, TAG) checks whether TAG exists for ET.
			%  CHECK = Element.EXISTSTAG(ETA, TAG) checks whether TAG exists for ETA.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ETA:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ET.EXISTSTAG(TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETA:WrongInput]
			%  Element.EXISTSTAG(ET, TAG) throws error if TAG does NOT exist for ET.
			%   Error id: [BRAPH2:ETA:WrongInput]
			%  Element.EXISTSTAG(ETA, TAG) throws error if TAG does NOT exist for ETA.
			%   Error id: [BRAPH2:ETA:WrongInput]
			%
			% See also getProps, existsTag.
			
			if nargout == 1
				% COMPUTATIONAL EFFICIENCY TRICK
				eta_tag_list = { 'prop_empty_m'  'prop_string_m'  'prop_logical_m'  'prop_option_m'  'prop_class_m'  'prop_classlist_m'  'prop_item_m'  'prop_itemlist_m'  'prop_idict_m'  'prop_scalar_m'  'prop_rvector_m'  'prop_cvector_m'  'prop_matrix_m'  'prop_smatrix_m'  'prop_cell_m'  'prop_net_m'  'prop_empty_p'  'prop_string_p'  'prop_logical_p'  'prop_option_p'  'prop_class_p'  'prop_classlist_p'  'prop_item_p'  'prop_itemlist_p'  'prop_idict_p'  'prop_scalar_p'  'prop_rvector_p'  'prop_cvector_p'  'prop_matrix_p'  'prop_smatrix_p'  'prop_cell_p'  'prop_net_p'  'prop_empty_d'  'prop_string_d'  'prop_logical_d'  'prop_option_d'  'prop_class_d'  'prop_classlist_d'  'prop_item_d'  'prop_itemlist_d'  'prop_idict_d'  'prop_scalar_d'  'prop_rvector_d'  'prop_cvector_d'  'prop_matrix_d'  'prop_smatrix_d'  'prop_cell_d'  'prop_net_d'  'prop_empty_f'  'prop_string_f'  'prop_logical_f'  'prop_option_f'  'prop_class_f'  'prop_classlist_f'  'prop_item_f'  'prop_itemlist_f'  'prop_idict_f'  'prop_scalar_f'  'prop_rvector_f'  'prop_cvector_f'  'prop_matrix_f'  'prop_smatrix_f'  'prop_cell_f'  'prop_net_f'  'prop_empty_g'  'prop_string_g'  'prop_logical_g'  'prop_option_g'  'prop_class_g'  'prop_classlist_g'  'prop_item_g'  'prop_itemlist_g'  'prop_idict_g'  'prop_scalar_g'  'prop_rvector_g'  'prop_cvector_g'  'prop_matrix_g'  'prop_smatrix_g'  'prop_cell_g'  'prop_net_g'  'prop_empty_r'  'prop_string_r'  'prop_logical_r'  'prop_option_r'  'prop_class_r'  'prop_classlist_r'  'prop_item_r'  'prop_itemlist_r'  'prop_idict_r'  'prop_scalar_r'  'prop_rvector_r'  'prop_cvector_r'  'prop_matrix_r'  'prop_smatrix_r'  'prop_cell_r'  'prop_net_r'  'prop_empty_r_calc'  'prop_string_r_calc'  'prop_logical_r_calc'  'prop_option_r_calc'  'prop_class_r_calc'  'prop_classlist_r_calc'  'prop_item_r_calc'  'prop_itemlist_r_calc'  'prop_idict_r_calc'  'prop_scalar_r_calc'  'prop_rvector_r_calc'  'prop_cvector_r_calc'  'prop_matrix_r_calc'  'prop_smatrix_r_calc'  'prop_cell_r_calc'  'prop_net_r_calc' };
				
				check = any(strcmpi(tag, eta_tag_list));
			else
				assert( ...
					ETA.existsTag(tag), ...
					[BRAPH2.STR ':ETA:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETA:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tag ' is not a valid tag for ETA'] ...
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
			%  PROPERTY = ET.GETPROPPROP(POINTER) returns property number of POINTER of ET.
			%  PROPERTY = Element.GETPROPPROP(ETA, POINTER) returns property number of POINTER of ETA.
			%  PROPERTY = ET.GETPROPPROP(ETA, POINTER) returns property number of POINTER of ETA.
			%
			% See also getPropFormat, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				% COMPUTATIONAL EFFICIENCY TRICK
				eta_tag_list = { 'prop_empty_m'  'prop_string_m'  'prop_logical_m'  'prop_option_m'  'prop_class_m'  'prop_classlist_m'  'prop_item_m'  'prop_itemlist_m'  'prop_idict_m'  'prop_scalar_m'  'prop_rvector_m'  'prop_cvector_m'  'prop_matrix_m'  'prop_smatrix_m'  'prop_cell_m'  'prop_net_m'  'prop_empty_p'  'prop_string_p'  'prop_logical_p'  'prop_option_p'  'prop_class_p'  'prop_classlist_p'  'prop_item_p'  'prop_itemlist_p'  'prop_idict_p'  'prop_scalar_p'  'prop_rvector_p'  'prop_cvector_p'  'prop_matrix_p'  'prop_smatrix_p'  'prop_cell_p'  'prop_net_p'  'prop_empty_d'  'prop_string_d'  'prop_logical_d'  'prop_option_d'  'prop_class_d'  'prop_classlist_d'  'prop_item_d'  'prop_itemlist_d'  'prop_idict_d'  'prop_scalar_d'  'prop_rvector_d'  'prop_cvector_d'  'prop_matrix_d'  'prop_smatrix_d'  'prop_cell_d'  'prop_net_d'  'prop_empty_f'  'prop_string_f'  'prop_logical_f'  'prop_option_f'  'prop_class_f'  'prop_classlist_f'  'prop_item_f'  'prop_itemlist_f'  'prop_idict_f'  'prop_scalar_f'  'prop_rvector_f'  'prop_cvector_f'  'prop_matrix_f'  'prop_smatrix_f'  'prop_cell_f'  'prop_net_f'  'prop_empty_g'  'prop_string_g'  'prop_logical_g'  'prop_option_g'  'prop_class_g'  'prop_classlist_g'  'prop_item_g'  'prop_itemlist_g'  'prop_idict_g'  'prop_scalar_g'  'prop_rvector_g'  'prop_cvector_g'  'prop_matrix_g'  'prop_smatrix_g'  'prop_cell_g'  'prop_net_g'  'prop_empty_r'  'prop_string_r'  'prop_logical_r'  'prop_option_r'  'prop_class_r'  'prop_classlist_r'  'prop_item_r'  'prop_itemlist_r'  'prop_idict_r'  'prop_scalar_r'  'prop_rvector_r'  'prop_cvector_r'  'prop_matrix_r'  'prop_smatrix_r'  'prop_cell_r'  'prop_net_r'  'prop_empty_r_calc'  'prop_string_r_calc'  'prop_logical_r_calc'  'prop_option_r_calc'  'prop_class_r_calc'  'prop_classlist_r_calc'  'prop_item_r_calc'  'prop_itemlist_r_calc'  'prop_idict_r_calc'  'prop_scalar_r_calc'  'prop_rvector_r_calc'  'prop_cvector_r_calc'  'prop_matrix_r_calc'  'prop_smatrix_r_calc'  'prop_cell_r_calc'  'prop_net_r_calc' };
				
				tag = pointer;
				ETA.existsTag(tag);
				
				prop = find(strcmpi(tag, eta_tag_list));
			else % numeric
				prop = pointer;
				ETA.existsProp(prop);
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
			%  TAG = ET.GETPROPTAG(POINTER) returns tag of POINTER of ET.
			%  TAG = Element.GETPROPTAG(ETA, POINTER) returns tag of POINTER of ETA.
			%  TAG = ET.GETPROPTAG(ETA, POINTER) returns tag of POINTER of ETA.
			%
			% See also getPropProp, getPropSettings, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			if ischar(pointer)
				tag = pointer;
				ETA.existsTag(tag);
			else % numeric
				prop = pointer;
				ETA.existsProp(prop);
				
				switch prop
					case ETA.PROP_EMPTY_M
						tag = ETA.PROP_EMPTY_M_TAG;
					case ETA.PROP_STRING_M
						tag = ETA.PROP_STRING_M_TAG;
					case ETA.PROP_LOGICAL_M
						tag = ETA.PROP_LOGICAL_M_TAG;
					case ETA.PROP_OPTION_M
						tag = ETA.PROP_OPTION_M_TAG;
					case ETA.PROP_CLASS_M
						tag = ETA.PROP_CLASS_M_TAG;
					case ETA.PROP_CLASSLIST_M
						tag = ETA.PROP_CLASSLIST_M_TAG;
					case ETA.PROP_ITEM_M
						tag = ETA.PROP_ITEM_M_TAG;
					case ETA.PROP_ITEMLIST_M
						tag = ETA.PROP_ITEMLIST_M_TAG;
					case ETA.PROP_IDICT_M
						tag = ETA.PROP_IDICT_M_TAG;
					case ETA.PROP_SCALAR_M
						tag = ETA.PROP_SCALAR_M_TAG;
					case ETA.PROP_RVECTOR_M
						tag = ETA.PROP_RVECTOR_M_TAG;
					case ETA.PROP_CVECTOR_M
						tag = ETA.PROP_CVECTOR_M_TAG;
					case ETA.PROP_MATRIX_M
						tag = ETA.PROP_MATRIX_M_TAG;
					case ETA.PROP_SMATRIX_M
						tag = ETA.PROP_SMATRIX_M_TAG;
					case ETA.PROP_CELL_M
						tag = ETA.PROP_CELL_M_TAG;
					case ETA.PROP_NET_M
						tag = ETA.PROP_NET_M_TAG;
					case ETA.PROP_EMPTY_P
						tag = ETA.PROP_EMPTY_P_TAG;
					case ETA.PROP_STRING_P
						tag = ETA.PROP_STRING_P_TAG;
					case ETA.PROP_LOGICAL_P
						tag = ETA.PROP_LOGICAL_P_TAG;
					case ETA.PROP_OPTION_P
						tag = ETA.PROP_OPTION_P_TAG;
					case ETA.PROP_CLASS_P
						tag = ETA.PROP_CLASS_P_TAG;
					case ETA.PROP_CLASSLIST_P
						tag = ETA.PROP_CLASSLIST_P_TAG;
					case ETA.PROP_ITEM_P
						tag = ETA.PROP_ITEM_P_TAG;
					case ETA.PROP_ITEMLIST_P
						tag = ETA.PROP_ITEMLIST_P_TAG;
					case ETA.PROP_IDICT_P
						tag = ETA.PROP_IDICT_P_TAG;
					case ETA.PROP_SCALAR_P
						tag = ETA.PROP_SCALAR_P_TAG;
					case ETA.PROP_RVECTOR_P
						tag = ETA.PROP_RVECTOR_P_TAG;
					case ETA.PROP_CVECTOR_P
						tag = ETA.PROP_CVECTOR_P_TAG;
					case ETA.PROP_MATRIX_P
						tag = ETA.PROP_MATRIX_P_TAG;
					case ETA.PROP_SMATRIX_P
						tag = ETA.PROP_SMATRIX_P_TAG;
					case ETA.PROP_CELL_P
						tag = ETA.PROP_CELL_P_TAG;
					case ETA.PROP_NET_P
						tag = ETA.PROP_NET_P_TAG;
					case ETA.PROP_EMPTY_D
						tag = ETA.PROP_EMPTY_D_TAG;
					case ETA.PROP_STRING_D
						tag = ETA.PROP_STRING_D_TAG;
					case ETA.PROP_LOGICAL_D
						tag = ETA.PROP_LOGICAL_D_TAG;
					case ETA.PROP_OPTION_D
						tag = ETA.PROP_OPTION_D_TAG;
					case ETA.PROP_CLASS_D
						tag = ETA.PROP_CLASS_D_TAG;
					case ETA.PROP_CLASSLIST_D
						tag = ETA.PROP_CLASSLIST_D_TAG;
					case ETA.PROP_ITEM_D
						tag = ETA.PROP_ITEM_D_TAG;
					case ETA.PROP_ITEMLIST_D
						tag = ETA.PROP_ITEMLIST_D_TAG;
					case ETA.PROP_IDICT_D
						tag = ETA.PROP_IDICT_D_TAG;
					case ETA.PROP_SCALAR_D
						tag = ETA.PROP_SCALAR_D_TAG;
					case ETA.PROP_RVECTOR_D
						tag = ETA.PROP_RVECTOR_D_TAG;
					case ETA.PROP_CVECTOR_D
						tag = ETA.PROP_CVECTOR_D_TAG;
					case ETA.PROP_MATRIX_D
						tag = ETA.PROP_MATRIX_D_TAG;
					case ETA.PROP_SMATRIX_D
						tag = ETA.PROP_SMATRIX_D_TAG;
					case ETA.PROP_CELL_D
						tag = ETA.PROP_CELL_D_TAG;
					case ETA.PROP_NET_D
						tag = ETA.PROP_NET_D_TAG;
					case ETA.PROP_EMPTY_F
						tag = ETA.PROP_EMPTY_F_TAG;
					case ETA.PROP_STRING_F
						tag = ETA.PROP_STRING_F_TAG;
					case ETA.PROP_LOGICAL_F
						tag = ETA.PROP_LOGICAL_F_TAG;
					case ETA.PROP_OPTION_F
						tag = ETA.PROP_OPTION_F_TAG;
					case ETA.PROP_CLASS_F
						tag = ETA.PROP_CLASS_F_TAG;
					case ETA.PROP_CLASSLIST_F
						tag = ETA.PROP_CLASSLIST_F_TAG;
					case ETA.PROP_ITEM_F
						tag = ETA.PROP_ITEM_F_TAG;
					case ETA.PROP_ITEMLIST_F
						tag = ETA.PROP_ITEMLIST_F_TAG;
					case ETA.PROP_IDICT_F
						tag = ETA.PROP_IDICT_F_TAG;
					case ETA.PROP_SCALAR_F
						tag = ETA.PROP_SCALAR_F_TAG;
					case ETA.PROP_RVECTOR_F
						tag = ETA.PROP_RVECTOR_F_TAG;
					case ETA.PROP_CVECTOR_F
						tag = ETA.PROP_CVECTOR_F_TAG;
					case ETA.PROP_MATRIX_F
						tag = ETA.PROP_MATRIX_F_TAG;
					case ETA.PROP_SMATRIX_F
						tag = ETA.PROP_SMATRIX_F_TAG;
					case ETA.PROP_CELL_F
						tag = ETA.PROP_CELL_F_TAG;
					case ETA.PROP_NET_F
						tag = ETA.PROP_NET_F_TAG;
					case ETA.PROP_EMPTY_G
						tag = ETA.PROP_EMPTY_G_TAG;
					case ETA.PROP_STRING_G
						tag = ETA.PROP_STRING_G_TAG;
					case ETA.PROP_LOGICAL_G
						tag = ETA.PROP_LOGICAL_G_TAG;
					case ETA.PROP_OPTION_G
						tag = ETA.PROP_OPTION_G_TAG;
					case ETA.PROP_CLASS_G
						tag = ETA.PROP_CLASS_G_TAG;
					case ETA.PROP_CLASSLIST_G
						tag = ETA.PROP_CLASSLIST_G_TAG;
					case ETA.PROP_ITEM_G
						tag = ETA.PROP_ITEM_G_TAG;
					case ETA.PROP_ITEMLIST_G
						tag = ETA.PROP_ITEMLIST_G_TAG;
					case ETA.PROP_IDICT_G
						tag = ETA.PROP_IDICT_G_TAG;
					case ETA.PROP_SCALAR_G
						tag = ETA.PROP_SCALAR_G_TAG;
					case ETA.PROP_RVECTOR_G
						tag = ETA.PROP_RVECTOR_G_TAG;
					case ETA.PROP_CVECTOR_G
						tag = ETA.PROP_CVECTOR_G_TAG;
					case ETA.PROP_MATRIX_G
						tag = ETA.PROP_MATRIX_G_TAG;
					case ETA.PROP_SMATRIX_G
						tag = ETA.PROP_SMATRIX_G_TAG;
					case ETA.PROP_CELL_G
						tag = ETA.PROP_CELL_G_TAG;
					case ETA.PROP_NET_G
						tag = ETA.PROP_NET_G_TAG;
					case ETA.PROP_EMPTY_R
						tag = ETA.PROP_EMPTY_R_TAG;
					case ETA.PROP_STRING_R
						tag = ETA.PROP_STRING_R_TAG;
					case ETA.PROP_LOGICAL_R
						tag = ETA.PROP_LOGICAL_R_TAG;
					case ETA.PROP_OPTION_R
						tag = ETA.PROP_OPTION_R_TAG;
					case ETA.PROP_CLASS_R
						tag = ETA.PROP_CLASS_R_TAG;
					case ETA.PROP_CLASSLIST_R
						tag = ETA.PROP_CLASSLIST_R_TAG;
					case ETA.PROP_ITEM_R
						tag = ETA.PROP_ITEM_R_TAG;
					case ETA.PROP_ITEMLIST_R
						tag = ETA.PROP_ITEMLIST_R_TAG;
					case ETA.PROP_IDICT_R
						tag = ETA.PROP_IDICT_R_TAG;
					case ETA.PROP_SCALAR_R
						tag = ETA.PROP_SCALAR_R_TAG;
					case ETA.PROP_RVECTOR_R
						tag = ETA.PROP_RVECTOR_R_TAG;
					case ETA.PROP_CVECTOR_R
						tag = ETA.PROP_CVECTOR_R_TAG;
					case ETA.PROP_MATRIX_R
						tag = ETA.PROP_MATRIX_R_TAG;
					case ETA.PROP_SMATRIX_R
						tag = ETA.PROP_SMATRIX_R_TAG;
					case ETA.PROP_CELL_R
						tag = ETA.PROP_CELL_R_TAG;
					case ETA.PROP_NET_R
						tag = ETA.PROP_NET_R_TAG;
					case ETA.PROP_EMPTY_R_CALC
						tag = ETA.PROP_EMPTY_R_CALC_TAG;
					case ETA.PROP_STRING_R_CALC
						tag = ETA.PROP_STRING_R_CALC_TAG;
					case ETA.PROP_LOGICAL_R_CALC
						tag = ETA.PROP_LOGICAL_R_CALC_TAG;
					case ETA.PROP_OPTION_R_CALC
						tag = ETA.PROP_OPTION_R_CALC_TAG;
					case ETA.PROP_CLASS_R_CALC
						tag = ETA.PROP_CLASS_R_CALC_TAG;
					case ETA.PROP_CLASSLIST_R_CALC
						tag = ETA.PROP_CLASSLIST_R_CALC_TAG;
					case ETA.PROP_ITEM_R_CALC
						tag = ETA.PROP_ITEM_R_CALC_TAG;
					case ETA.PROP_ITEMLIST_R_CALC
						tag = ETA.PROP_ITEMLIST_R_CALC_TAG;
					case ETA.PROP_IDICT_R_CALC
						tag = ETA.PROP_IDICT_R_CALC_TAG;
					case ETA.PROP_SCALAR_R_CALC
						tag = ETA.PROP_SCALAR_R_CALC_TAG;
					case ETA.PROP_RVECTOR_R_CALC
						tag = ETA.PROP_RVECTOR_R_CALC_TAG;
					case ETA.PROP_CVECTOR_R_CALC
						tag = ETA.PROP_CVECTOR_R_CALC_TAG;
					case ETA.PROP_MATRIX_R_CALC
						tag = ETA.PROP_MATRIX_R_CALC_TAG;
					case ETA.PROP_SMATRIX_R_CALC
						tag = ETA.PROP_SMATRIX_R_CALC_TAG;
					case ETA.PROP_CELL_R_CALC
						tag = ETA.PROP_CELL_R_CALC_TAG;
					case ETA.PROP_NET_R_CALC
						tag = ETA.PROP_NET_R_CALC_TAG;
				end
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the
			%  category of the property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the
			%  category of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = ET.GETPROPCATEGORY(POINTER) returns category of POINTER of ET.
			%  CATEGORY = Element.GETPROPCATEGORY(ETA, POINTER) returns category of POINTER of ETA.
			%  CATEGORY = ET.GETPROPCATEGORY(ETA, POINTER) returns category of POINTER of ETA.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETA.getPropProp(pointer);
			
			switch prop
				case ETA.PROP_EMPTY_M
					prop_category = ETA.PROP_EMPTY_M_CATEGORY;
				case ETA.PROP_STRING_M
					prop_category = ETA.PROP_STRING_M_CATEGORY;
				case ETA.PROP_LOGICAL_M
					prop_category = ETA.PROP_LOGICAL_M_CATEGORY;
				case ETA.PROP_OPTION_M
					prop_category = ETA.PROP_OPTION_M_CATEGORY;
				case ETA.PROP_CLASS_M
					prop_category = ETA.PROP_CLASS_M_CATEGORY;
				case ETA.PROP_CLASSLIST_M
					prop_category = ETA.PROP_CLASSLIST_M_CATEGORY;
				case ETA.PROP_ITEM_M
					prop_category = ETA.PROP_ITEM_M_CATEGORY;
				case ETA.PROP_ITEMLIST_M
					prop_category = ETA.PROP_ITEMLIST_M_CATEGORY;
				case ETA.PROP_IDICT_M
					prop_category = ETA.PROP_IDICT_M_CATEGORY;
				case ETA.PROP_SCALAR_M
					prop_category = ETA.PROP_SCALAR_M_CATEGORY;
				case ETA.PROP_RVECTOR_M
					prop_category = ETA.PROP_RVECTOR_M_CATEGORY;
				case ETA.PROP_CVECTOR_M
					prop_category = ETA.PROP_CVECTOR_M_CATEGORY;
				case ETA.PROP_MATRIX_M
					prop_category = ETA.PROP_MATRIX_M_CATEGORY;
				case ETA.PROP_SMATRIX_M
					prop_category = ETA.PROP_SMATRIX_M_CATEGORY;
				case ETA.PROP_CELL_M
					prop_category = ETA.PROP_CELL_M_CATEGORY;
				case ETA.PROP_NET_M
					prop_category = ETA.PROP_NET_M_CATEGORY;
				case ETA.PROP_EMPTY_P
					prop_category = ETA.PROP_EMPTY_P_CATEGORY;
				case ETA.PROP_STRING_P
					prop_category = ETA.PROP_STRING_P_CATEGORY;
				case ETA.PROP_LOGICAL_P
					prop_category = ETA.PROP_LOGICAL_P_CATEGORY;
				case ETA.PROP_OPTION_P
					prop_category = ETA.PROP_OPTION_P_CATEGORY;
				case ETA.PROP_CLASS_P
					prop_category = ETA.PROP_CLASS_P_CATEGORY;
				case ETA.PROP_CLASSLIST_P
					prop_category = ETA.PROP_CLASSLIST_P_CATEGORY;
				case ETA.PROP_ITEM_P
					prop_category = ETA.PROP_ITEM_P_CATEGORY;
				case ETA.PROP_ITEMLIST_P
					prop_category = ETA.PROP_ITEMLIST_P_CATEGORY;
				case ETA.PROP_IDICT_P
					prop_category = ETA.PROP_IDICT_P_CATEGORY;
				case ETA.PROP_SCALAR_P
					prop_category = ETA.PROP_SCALAR_P_CATEGORY;
				case ETA.PROP_RVECTOR_P
					prop_category = ETA.PROP_RVECTOR_P_CATEGORY;
				case ETA.PROP_CVECTOR_P
					prop_category = ETA.PROP_CVECTOR_P_CATEGORY;
				case ETA.PROP_MATRIX_P
					prop_category = ETA.PROP_MATRIX_P_CATEGORY;
				case ETA.PROP_SMATRIX_P
					prop_category = ETA.PROP_SMATRIX_P_CATEGORY;
				case ETA.PROP_CELL_P
					prop_category = ETA.PROP_CELL_P_CATEGORY;
				case ETA.PROP_NET_P
					prop_category = ETA.PROP_NET_P_CATEGORY;
				case ETA.PROP_EMPTY_D
					prop_category = ETA.PROP_EMPTY_D_CATEGORY;
				case ETA.PROP_STRING_D
					prop_category = ETA.PROP_STRING_D_CATEGORY;
				case ETA.PROP_LOGICAL_D
					prop_category = ETA.PROP_LOGICAL_D_CATEGORY;
				case ETA.PROP_OPTION_D
					prop_category = ETA.PROP_OPTION_D_CATEGORY;
				case ETA.PROP_CLASS_D
					prop_category = ETA.PROP_CLASS_D_CATEGORY;
				case ETA.PROP_CLASSLIST_D
					prop_category = ETA.PROP_CLASSLIST_D_CATEGORY;
				case ETA.PROP_ITEM_D
					prop_category = ETA.PROP_ITEM_D_CATEGORY;
				case ETA.PROP_ITEMLIST_D
					prop_category = ETA.PROP_ITEMLIST_D_CATEGORY;
				case ETA.PROP_IDICT_D
					prop_category = ETA.PROP_IDICT_D_CATEGORY;
				case ETA.PROP_SCALAR_D
					prop_category = ETA.PROP_SCALAR_D_CATEGORY;
				case ETA.PROP_RVECTOR_D
					prop_category = ETA.PROP_RVECTOR_D_CATEGORY;
				case ETA.PROP_CVECTOR_D
					prop_category = ETA.PROP_CVECTOR_D_CATEGORY;
				case ETA.PROP_MATRIX_D
					prop_category = ETA.PROP_MATRIX_D_CATEGORY;
				case ETA.PROP_SMATRIX_D
					prop_category = ETA.PROP_SMATRIX_D_CATEGORY;
				case ETA.PROP_CELL_D
					prop_category = ETA.PROP_CELL_D_CATEGORY;
				case ETA.PROP_NET_D
					prop_category = ETA.PROP_NET_D_CATEGORY;
				case ETA.PROP_EMPTY_F
					prop_category = ETA.PROP_EMPTY_F_CATEGORY;
				case ETA.PROP_STRING_F
					prop_category = ETA.PROP_STRING_F_CATEGORY;
				case ETA.PROP_LOGICAL_F
					prop_category = ETA.PROP_LOGICAL_F_CATEGORY;
				case ETA.PROP_OPTION_F
					prop_category = ETA.PROP_OPTION_F_CATEGORY;
				case ETA.PROP_CLASS_F
					prop_category = ETA.PROP_CLASS_F_CATEGORY;
				case ETA.PROP_CLASSLIST_F
					prop_category = ETA.PROP_CLASSLIST_F_CATEGORY;
				case ETA.PROP_ITEM_F
					prop_category = ETA.PROP_ITEM_F_CATEGORY;
				case ETA.PROP_ITEMLIST_F
					prop_category = ETA.PROP_ITEMLIST_F_CATEGORY;
				case ETA.PROP_IDICT_F
					prop_category = ETA.PROP_IDICT_F_CATEGORY;
				case ETA.PROP_SCALAR_F
					prop_category = ETA.PROP_SCALAR_F_CATEGORY;
				case ETA.PROP_RVECTOR_F
					prop_category = ETA.PROP_RVECTOR_F_CATEGORY;
				case ETA.PROP_CVECTOR_F
					prop_category = ETA.PROP_CVECTOR_F_CATEGORY;
				case ETA.PROP_MATRIX_F
					prop_category = ETA.PROP_MATRIX_F_CATEGORY;
				case ETA.PROP_SMATRIX_F
					prop_category = ETA.PROP_SMATRIX_F_CATEGORY;
				case ETA.PROP_CELL_F
					prop_category = ETA.PROP_CELL_F_CATEGORY;
				case ETA.PROP_NET_F
					prop_category = ETA.PROP_NET_F_CATEGORY;
				case ETA.PROP_EMPTY_G
					prop_category = ETA.PROP_EMPTY_G_CATEGORY;
				case ETA.PROP_STRING_G
					prop_category = ETA.PROP_STRING_G_CATEGORY;
				case ETA.PROP_LOGICAL_G
					prop_category = ETA.PROP_LOGICAL_G_CATEGORY;
				case ETA.PROP_OPTION_G
					prop_category = ETA.PROP_OPTION_G_CATEGORY;
				case ETA.PROP_CLASS_G
					prop_category = ETA.PROP_CLASS_G_CATEGORY;
				case ETA.PROP_CLASSLIST_G
					prop_category = ETA.PROP_CLASSLIST_G_CATEGORY;
				case ETA.PROP_ITEM_G
					prop_category = ETA.PROP_ITEM_G_CATEGORY;
				case ETA.PROP_ITEMLIST_G
					prop_category = ETA.PROP_ITEMLIST_G_CATEGORY;
				case ETA.PROP_IDICT_G
					prop_category = ETA.PROP_IDICT_G_CATEGORY;
				case ETA.PROP_SCALAR_G
					prop_category = ETA.PROP_SCALAR_G_CATEGORY;
				case ETA.PROP_RVECTOR_G
					prop_category = ETA.PROP_RVECTOR_G_CATEGORY;
				case ETA.PROP_CVECTOR_G
					prop_category = ETA.PROP_CVECTOR_G_CATEGORY;
				case ETA.PROP_MATRIX_G
					prop_category = ETA.PROP_MATRIX_G_CATEGORY;
				case ETA.PROP_SMATRIX_G
					prop_category = ETA.PROP_SMATRIX_G_CATEGORY;
				case ETA.PROP_CELL_G
					prop_category = ETA.PROP_CELL_G_CATEGORY;
				case ETA.PROP_NET_G
					prop_category = ETA.PROP_NET_G_CATEGORY;
				case ETA.PROP_EMPTY_R
					prop_category = ETA.PROP_EMPTY_R_CATEGORY;
				case ETA.PROP_STRING_R
					prop_category = ETA.PROP_STRING_R_CATEGORY;
				case ETA.PROP_LOGICAL_R
					prop_category = ETA.PROP_LOGICAL_R_CATEGORY;
				case ETA.PROP_OPTION_R
					prop_category = ETA.PROP_OPTION_R_CATEGORY;
				case ETA.PROP_CLASS_R
					prop_category = ETA.PROP_CLASS_R_CATEGORY;
				case ETA.PROP_CLASSLIST_R
					prop_category = ETA.PROP_CLASSLIST_R_CATEGORY;
				case ETA.PROP_ITEM_R
					prop_category = ETA.PROP_ITEM_R_CATEGORY;
				case ETA.PROP_ITEMLIST_R
					prop_category = ETA.PROP_ITEMLIST_R_CATEGORY;
				case ETA.PROP_IDICT_R
					prop_category = ETA.PROP_IDICT_R_CATEGORY;
				case ETA.PROP_SCALAR_R
					prop_category = ETA.PROP_SCALAR_R_CATEGORY;
				case ETA.PROP_RVECTOR_R
					prop_category = ETA.PROP_RVECTOR_R_CATEGORY;
				case ETA.PROP_CVECTOR_R
					prop_category = ETA.PROP_CVECTOR_R_CATEGORY;
				case ETA.PROP_MATRIX_R
					prop_category = ETA.PROP_MATRIX_R_CATEGORY;
				case ETA.PROP_SMATRIX_R
					prop_category = ETA.PROP_SMATRIX_R_CATEGORY;
				case ETA.PROP_CELL_R
					prop_category = ETA.PROP_CELL_R_CATEGORY;
				case ETA.PROP_NET_R
					prop_category = ETA.PROP_NET_R_CATEGORY;
				case ETA.PROP_EMPTY_R_CALC
					prop_category = ETA.PROP_EMPTY_R_CALC_CATEGORY;
				case ETA.PROP_STRING_R_CALC
					prop_category = ETA.PROP_STRING_R_CALC_CATEGORY;
				case ETA.PROP_LOGICAL_R_CALC
					prop_category = ETA.PROP_LOGICAL_R_CALC_CATEGORY;
				case ETA.PROP_OPTION_R_CALC
					prop_category = ETA.PROP_OPTION_R_CALC_CATEGORY;
				case ETA.PROP_CLASS_R_CALC
					prop_category = ETA.PROP_CLASS_R_CALC_CATEGORY;
				case ETA.PROP_CLASSLIST_R_CALC
					prop_category = ETA.PROP_CLASSLIST_R_CALC_CATEGORY;
				case ETA.PROP_ITEM_R_CALC
					prop_category = ETA.PROP_ITEM_R_CALC_CATEGORY;
				case ETA.PROP_ITEMLIST_R_CALC
					prop_category = ETA.PROP_ITEMLIST_R_CALC_CATEGORY;
				case ETA.PROP_IDICT_R_CALC
					prop_category = ETA.PROP_IDICT_R_CALC_CATEGORY;
				case ETA.PROP_SCALAR_R_CALC
					prop_category = ETA.PROP_SCALAR_R_CALC_CATEGORY;
				case ETA.PROP_RVECTOR_R_CALC
					prop_category = ETA.PROP_RVECTOR_R_CALC_CATEGORY;
				case ETA.PROP_CVECTOR_R_CALC
					prop_category = ETA.PROP_CVECTOR_R_CALC_CATEGORY;
				case ETA.PROP_MATRIX_R_CALC
					prop_category = ETA.PROP_MATRIX_R_CALC_CATEGORY;
				case ETA.PROP_SMATRIX_R_CALC
					prop_category = ETA.PROP_SMATRIX_R_CALC_CATEGORY;
				case ETA.PROP_CELL_R_CALC
					prop_category = ETA.PROP_CELL_R_CALC_CATEGORY;
				case ETA.PROP_NET_R_CALC
					prop_category = ETA.PROP_NET_R_CALC_CATEGORY;
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
			%  FORMAT = ET.GETPROPFORMAT(POINTER) returns format of POINTER of ET.
			%  FORMAT = Element.GETPROPFORMAT(ETA, POINTER) returns format of POINTER of ETA.
			%  FORMAT = ET.GETPROPFORMAT(ETA, POINTER) returns format of POINTER of ETA.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			% getPropDescription, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETA.getPropProp(pointer);
			
			switch prop
				case ETA.PROP_EMPTY_M
					prop_format = ETA.PROP_EMPTY_M_FORMAT;
				case ETA.PROP_STRING_M
					prop_format = ETA.PROP_STRING_M_FORMAT;
				case ETA.PROP_LOGICAL_M
					prop_format = ETA.PROP_LOGICAL_M_FORMAT;
				case ETA.PROP_OPTION_M
					prop_format = ETA.PROP_OPTION_M_FORMAT;
				case ETA.PROP_CLASS_M
					prop_format = ETA.PROP_CLASS_M_FORMAT;
				case ETA.PROP_CLASSLIST_M
					prop_format = ETA.PROP_CLASSLIST_M_FORMAT;
				case ETA.PROP_ITEM_M
					prop_format = ETA.PROP_ITEM_M_FORMAT;
				case ETA.PROP_ITEMLIST_M
					prop_format = ETA.PROP_ITEMLIST_M_FORMAT;
				case ETA.PROP_IDICT_M
					prop_format = ETA.PROP_IDICT_M_FORMAT;
				case ETA.PROP_SCALAR_M
					prop_format = ETA.PROP_SCALAR_M_FORMAT;
				case ETA.PROP_RVECTOR_M
					prop_format = ETA.PROP_RVECTOR_M_FORMAT;
				case ETA.PROP_CVECTOR_M
					prop_format = ETA.PROP_CVECTOR_M_FORMAT;
				case ETA.PROP_MATRIX_M
					prop_format = ETA.PROP_MATRIX_M_FORMAT;
				case ETA.PROP_SMATRIX_M
					prop_format = ETA.PROP_SMATRIX_M_FORMAT;
				case ETA.PROP_CELL_M
					prop_format = ETA.PROP_CELL_M_FORMAT;
				case ETA.PROP_NET_M
					prop_format = ETA.PROP_NET_M_FORMAT;
				case ETA.PROP_EMPTY_P
					prop_format = ETA.PROP_EMPTY_P_FORMAT;
				case ETA.PROP_STRING_P
					prop_format = ETA.PROP_STRING_P_FORMAT;
				case ETA.PROP_LOGICAL_P
					prop_format = ETA.PROP_LOGICAL_P_FORMAT;
				case ETA.PROP_OPTION_P
					prop_format = ETA.PROP_OPTION_P_FORMAT;
				case ETA.PROP_CLASS_P
					prop_format = ETA.PROP_CLASS_P_FORMAT;
				case ETA.PROP_CLASSLIST_P
					prop_format = ETA.PROP_CLASSLIST_P_FORMAT;
				case ETA.PROP_ITEM_P
					prop_format = ETA.PROP_ITEM_P_FORMAT;
				case ETA.PROP_ITEMLIST_P
					prop_format = ETA.PROP_ITEMLIST_P_FORMAT;
				case ETA.PROP_IDICT_P
					prop_format = ETA.PROP_IDICT_P_FORMAT;
				case ETA.PROP_SCALAR_P
					prop_format = ETA.PROP_SCALAR_P_FORMAT;
				case ETA.PROP_RVECTOR_P
					prop_format = ETA.PROP_RVECTOR_P_FORMAT;
				case ETA.PROP_CVECTOR_P
					prop_format = ETA.PROP_CVECTOR_P_FORMAT;
				case ETA.PROP_MATRIX_P
					prop_format = ETA.PROP_MATRIX_P_FORMAT;
				case ETA.PROP_SMATRIX_P
					prop_format = ETA.PROP_SMATRIX_P_FORMAT;
				case ETA.PROP_CELL_P
					prop_format = ETA.PROP_CELL_P_FORMAT;
				case ETA.PROP_NET_P
					prop_format = ETA.PROP_NET_P_FORMAT;
				case ETA.PROP_EMPTY_D
					prop_format = ETA.PROP_EMPTY_D_FORMAT;
				case ETA.PROP_STRING_D
					prop_format = ETA.PROP_STRING_D_FORMAT;
				case ETA.PROP_LOGICAL_D
					prop_format = ETA.PROP_LOGICAL_D_FORMAT;
				case ETA.PROP_OPTION_D
					prop_format = ETA.PROP_OPTION_D_FORMAT;
				case ETA.PROP_CLASS_D
					prop_format = ETA.PROP_CLASS_D_FORMAT;
				case ETA.PROP_CLASSLIST_D
					prop_format = ETA.PROP_CLASSLIST_D_FORMAT;
				case ETA.PROP_ITEM_D
					prop_format = ETA.PROP_ITEM_D_FORMAT;
				case ETA.PROP_ITEMLIST_D
					prop_format = ETA.PROP_ITEMLIST_D_FORMAT;
				case ETA.PROP_IDICT_D
					prop_format = ETA.PROP_IDICT_D_FORMAT;
				case ETA.PROP_SCALAR_D
					prop_format = ETA.PROP_SCALAR_D_FORMAT;
				case ETA.PROP_RVECTOR_D
					prop_format = ETA.PROP_RVECTOR_D_FORMAT;
				case ETA.PROP_CVECTOR_D
					prop_format = ETA.PROP_CVECTOR_D_FORMAT;
				case ETA.PROP_MATRIX_D
					prop_format = ETA.PROP_MATRIX_D_FORMAT;
				case ETA.PROP_SMATRIX_D
					prop_format = ETA.PROP_SMATRIX_D_FORMAT;
				case ETA.PROP_CELL_D
					prop_format = ETA.PROP_CELL_D_FORMAT;
				case ETA.PROP_NET_D
					prop_format = ETA.PROP_NET_D_FORMAT;
				case ETA.PROP_EMPTY_F
					prop_format = ETA.PROP_EMPTY_F_FORMAT;
				case ETA.PROP_STRING_F
					prop_format = ETA.PROP_STRING_F_FORMAT;
				case ETA.PROP_LOGICAL_F
					prop_format = ETA.PROP_LOGICAL_F_FORMAT;
				case ETA.PROP_OPTION_F
					prop_format = ETA.PROP_OPTION_F_FORMAT;
				case ETA.PROP_CLASS_F
					prop_format = ETA.PROP_CLASS_F_FORMAT;
				case ETA.PROP_CLASSLIST_F
					prop_format = ETA.PROP_CLASSLIST_F_FORMAT;
				case ETA.PROP_ITEM_F
					prop_format = ETA.PROP_ITEM_F_FORMAT;
				case ETA.PROP_ITEMLIST_F
					prop_format = ETA.PROP_ITEMLIST_F_FORMAT;
				case ETA.PROP_IDICT_F
					prop_format = ETA.PROP_IDICT_F_FORMAT;
				case ETA.PROP_SCALAR_F
					prop_format = ETA.PROP_SCALAR_F_FORMAT;
				case ETA.PROP_RVECTOR_F
					prop_format = ETA.PROP_RVECTOR_F_FORMAT;
				case ETA.PROP_CVECTOR_F
					prop_format = ETA.PROP_CVECTOR_F_FORMAT;
				case ETA.PROP_MATRIX_F
					prop_format = ETA.PROP_MATRIX_F_FORMAT;
				case ETA.PROP_SMATRIX_F
					prop_format = ETA.PROP_SMATRIX_F_FORMAT;
				case ETA.PROP_CELL_F
					prop_format = ETA.PROP_CELL_F_FORMAT;
				case ETA.PROP_NET_F
					prop_format = ETA.PROP_NET_F_FORMAT;
				case ETA.PROP_EMPTY_G
					prop_format = ETA.PROP_EMPTY_G_FORMAT;
				case ETA.PROP_STRING_G
					prop_format = ETA.PROP_STRING_G_FORMAT;
				case ETA.PROP_LOGICAL_G
					prop_format = ETA.PROP_LOGICAL_G_FORMAT;
				case ETA.PROP_OPTION_G
					prop_format = ETA.PROP_OPTION_G_FORMAT;
				case ETA.PROP_CLASS_G
					prop_format = ETA.PROP_CLASS_G_FORMAT;
				case ETA.PROP_CLASSLIST_G
					prop_format = ETA.PROP_CLASSLIST_G_FORMAT;
				case ETA.PROP_ITEM_G
					prop_format = ETA.PROP_ITEM_G_FORMAT;
				case ETA.PROP_ITEMLIST_G
					prop_format = ETA.PROP_ITEMLIST_G_FORMAT;
				case ETA.PROP_IDICT_G
					prop_format = ETA.PROP_IDICT_G_FORMAT;
				case ETA.PROP_SCALAR_G
					prop_format = ETA.PROP_SCALAR_G_FORMAT;
				case ETA.PROP_RVECTOR_G
					prop_format = ETA.PROP_RVECTOR_G_FORMAT;
				case ETA.PROP_CVECTOR_G
					prop_format = ETA.PROP_CVECTOR_G_FORMAT;
				case ETA.PROP_MATRIX_G
					prop_format = ETA.PROP_MATRIX_G_FORMAT;
				case ETA.PROP_SMATRIX_G
					prop_format = ETA.PROP_SMATRIX_G_FORMAT;
				case ETA.PROP_CELL_G
					prop_format = ETA.PROP_CELL_G_FORMAT;
				case ETA.PROP_NET_G
					prop_format = ETA.PROP_NET_G_FORMAT;
				case ETA.PROP_EMPTY_R
					prop_format = ETA.PROP_EMPTY_R_FORMAT;
				case ETA.PROP_STRING_R
					prop_format = ETA.PROP_STRING_R_FORMAT;
				case ETA.PROP_LOGICAL_R
					prop_format = ETA.PROP_LOGICAL_R_FORMAT;
				case ETA.PROP_OPTION_R
					prop_format = ETA.PROP_OPTION_R_FORMAT;
				case ETA.PROP_CLASS_R
					prop_format = ETA.PROP_CLASS_R_FORMAT;
				case ETA.PROP_CLASSLIST_R
					prop_format = ETA.PROP_CLASSLIST_R_FORMAT;
				case ETA.PROP_ITEM_R
					prop_format = ETA.PROP_ITEM_R_FORMAT;
				case ETA.PROP_ITEMLIST_R
					prop_format = ETA.PROP_ITEMLIST_R_FORMAT;
				case ETA.PROP_IDICT_R
					prop_format = ETA.PROP_IDICT_R_FORMAT;
				case ETA.PROP_SCALAR_R
					prop_format = ETA.PROP_SCALAR_R_FORMAT;
				case ETA.PROP_RVECTOR_R
					prop_format = ETA.PROP_RVECTOR_R_FORMAT;
				case ETA.PROP_CVECTOR_R
					prop_format = ETA.PROP_CVECTOR_R_FORMAT;
				case ETA.PROP_MATRIX_R
					prop_format = ETA.PROP_MATRIX_R_FORMAT;
				case ETA.PROP_SMATRIX_R
					prop_format = ETA.PROP_SMATRIX_R_FORMAT;
				case ETA.PROP_CELL_R
					prop_format = ETA.PROP_CELL_R_FORMAT;
				case ETA.PROP_NET_R
					prop_format = ETA.PROP_NET_R_FORMAT;
				case ETA.PROP_EMPTY_R_CALC
					prop_format = ETA.PROP_EMPTY_R_CALC_FORMAT;
				case ETA.PROP_STRING_R_CALC
					prop_format = ETA.PROP_STRING_R_CALC_FORMAT;
				case ETA.PROP_LOGICAL_R_CALC
					prop_format = ETA.PROP_LOGICAL_R_CALC_FORMAT;
				case ETA.PROP_OPTION_R_CALC
					prop_format = ETA.PROP_OPTION_R_CALC_FORMAT;
				case ETA.PROP_CLASS_R_CALC
					prop_format = ETA.PROP_CLASS_R_CALC_FORMAT;
				case ETA.PROP_CLASSLIST_R_CALC
					prop_format = ETA.PROP_CLASSLIST_R_CALC_FORMAT;
				case ETA.PROP_ITEM_R_CALC
					prop_format = ETA.PROP_ITEM_R_CALC_FORMAT;
				case ETA.PROP_ITEMLIST_R_CALC
					prop_format = ETA.PROP_ITEMLIST_R_CALC_FORMAT;
				case ETA.PROP_IDICT_R_CALC
					prop_format = ETA.PROP_IDICT_R_CALC_FORMAT;
				case ETA.PROP_SCALAR_R_CALC
					prop_format = ETA.PROP_SCALAR_R_CALC_FORMAT;
				case ETA.PROP_RVECTOR_R_CALC
					prop_format = ETA.PROP_RVECTOR_R_CALC_FORMAT;
				case ETA.PROP_CVECTOR_R_CALC
					prop_format = ETA.PROP_CVECTOR_R_CALC_FORMAT;
				case ETA.PROP_MATRIX_R_CALC
					prop_format = ETA.PROP_MATRIX_R_CALC_FORMAT;
				case ETA.PROP_SMATRIX_R_CALC
					prop_format = ETA.PROP_SMATRIX_R_CALC_FORMAT;
				case ETA.PROP_CELL_R_CALC
					prop_format = ETA.PROP_CELL_R_CALC_FORMAT;
				case ETA.PROP_NET_R_CALC
					prop_format = ETA.PROP_NET_R_CALC_FORMAT;
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
			%  DESCRIPTION = ET.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ET.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ETA, POINTER) returns description of POINTER of ETA.
			%  DESCRIPTION = ET.GETPROPDESCRIPTION(ETA, POINTER) returns description of POINTER of ETA.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropSettings, getPropDefault,
			% checkProp.
			
			prop = ETA.getPropProp(pointer);
			
			switch prop
				case ETA.PROP_EMPTY_M
					prop_description = 'PROP_EMPTY_M (metadata, empty) is a metadata, empty.';
				case ETA.PROP_STRING_M
					prop_description = 'PROP_STRING_M (metadata, string) is a metadata, string.';
				case ETA.PROP_LOGICAL_M
					prop_description = 'PROP_LOGICAL_M (metadata, logical) is a metadata, logical.';
				case ETA.PROP_OPTION_M
					prop_description = 'PROP_OPTION_M (metadata, option) is a metadata, option.';
				case ETA.PROP_CLASS_M
					prop_description = 'PROP_CLASS_M (metadata, class) is a metadata, class.';
				case ETA.PROP_CLASSLIST_M
					prop_description = 'PROP_CLASSLIST_M (metadata, classlist) is a metadata, classlist.';
				case ETA.PROP_ITEM_M
					prop_description = 'PROP_ITEM_M (metadata, item) is a metadata, item.';
				case ETA.PROP_ITEMLIST_M
					prop_description = 'PROP_ITEMLIST_M (metadata, itemlist) is a metadata, itemlist.';
				case ETA.PROP_IDICT_M
					prop_description = 'PROP_IDICT_M (metadata, idict) is a metadata, idict.';
				case ETA.PROP_SCALAR_M
					prop_description = 'PROP_SCALAR_M (metadata, scalar) is a metadata, scalar.';
				case ETA.PROP_RVECTOR_M
					prop_description = 'PROP_RVECTOR_M (metadata, rvector) is a metadata, rvector.';
				case ETA.PROP_CVECTOR_M
					prop_description = 'PROP_CVECTOR_M (metadata, cvector) is a metadata, cvector.';
				case ETA.PROP_MATRIX_M
					prop_description = 'PROP_MATRIX_M (metadata, matrix) is a metadata, matrix.';
				case ETA.PROP_SMATRIX_M
					prop_description = 'PROP_SMATRIX_M (metadata, smatrix) is a metadata, smatrix.';
				case ETA.PROP_CELL_M
					prop_description = 'PROP_CELL_M (metadata, cell) is a metadata, cell.';
				case ETA.PROP_NET_M
					prop_description = 'PROP_NET_M (metadata, net) is a metadata, net.';
				case ETA.PROP_EMPTY_P
					prop_description = 'PROP_EMPTY_P (parameter, empty) is a parameter, empty.';
				case ETA.PROP_STRING_P
					prop_description = 'PROP_STRING_P (parameter, string) is a parameter, string.';
				case ETA.PROP_LOGICAL_P
					prop_description = 'PROP_LOGICAL_P (parameter, logical) is a parameter, logical.';
				case ETA.PROP_OPTION_P
					prop_description = 'PROP_OPTION_P (parameter, option) is a parameter, option.';
				case ETA.PROP_CLASS_P
					prop_description = 'PROP_CLASS_P (parameter, class) is a parameter, class.';
				case ETA.PROP_CLASSLIST_P
					prop_description = 'PROP_CLASSLIST_P (parameter, classlist) is a parameter, classlist.';
				case ETA.PROP_ITEM_P
					prop_description = 'PROP_ITEM_P (parameter, item) is a parameter, item.';
				case ETA.PROP_ITEMLIST_P
					prop_description = 'PROP_ITEMLIST_P (parameter, itemlist) is a parameter, itemlist.';
				case ETA.PROP_IDICT_P
					prop_description = 'PROP_IDICT_P (parameter, idict) is a parameter, idict.';
				case ETA.PROP_SCALAR_P
					prop_description = 'PROP_SCALAR_P (parameter, scalar) is a parameter, scalar.';
				case ETA.PROP_RVECTOR_P
					prop_description = 'PROP_RVECTOR_P (parameter, rvector) is a parameter, rvector.';
				case ETA.PROP_CVECTOR_P
					prop_description = 'PROP_CVECTOR_P (parameter, cvector) is a parameter, cvector.';
				case ETA.PROP_MATRIX_P
					prop_description = 'PROP_MATRIX_P (parameter, matrix) is a parameter, matrix.';
				case ETA.PROP_SMATRIX_P
					prop_description = 'PROP_SMATRIX_P (parameter, smatrix) is a parameter, smatrix.';
				case ETA.PROP_CELL_P
					prop_description = 'PROP_CELL_P (parameter, cell) is a parameter, cell.';
				case ETA.PROP_NET_P
					prop_description = 'PROP_NET_P (parameter, net) is a parameter, net.';
				case ETA.PROP_EMPTY_D
					prop_description = 'PROP_EMPTY_D (data, empty) is a data, empty.';
				case ETA.PROP_STRING_D
					prop_description = 'PROP_STRING_D (data, string) is a data, string.';
				case ETA.PROP_LOGICAL_D
					prop_description = 'PROP_LOGICAL_D (data, logical) is a data, logical.';
				case ETA.PROP_OPTION_D
					prop_description = 'PROP_OPTION_D (data, option) is a data, option.';
				case ETA.PROP_CLASS_D
					prop_description = 'PROP_CLASS_D (data, class) is a data, class.';
				case ETA.PROP_CLASSLIST_D
					prop_description = 'PROP_CLASSLIST_D (data, classlist) is a data, classlist.';
				case ETA.PROP_ITEM_D
					prop_description = 'PROP_ITEM_D (data, item) is a data, item.';
				case ETA.PROP_ITEMLIST_D
					prop_description = 'PROP_ITEMLIST_D (data, itemlist) is a data, itemlist.';
				case ETA.PROP_IDICT_D
					prop_description = 'PROP_IDICT_D (data, idict) is a data, idict.';
				case ETA.PROP_SCALAR_D
					prop_description = 'PROP_SCALAR_D (data, scalar) is a data, scalar.';
				case ETA.PROP_RVECTOR_D
					prop_description = 'PROP_RVECTOR_D (data, rvector) is a data, rvector.';
				case ETA.PROP_CVECTOR_D
					prop_description = 'PROP_CVECTOR_D (data, cvector) is a data, cvector.';
				case ETA.PROP_MATRIX_D
					prop_description = 'PROP_MATRIX_D (data, matrix) is a data, matrix.';
				case ETA.PROP_SMATRIX_D
					prop_description = 'PROP_SMATRIX_D (data, smatrix) is a data, smatrix.';
				case ETA.PROP_CELL_D
					prop_description = 'PROP_CELL_D (data, cell) is a data, cell.';
				case ETA.PROP_NET_D
					prop_description = 'PROP_NET_D (data, net) is a data, net.';
				case ETA.PROP_EMPTY_F
					prop_description = 'PROP_EMPTY_F (figure, empty) is a figure, empty.';
				case ETA.PROP_STRING_F
					prop_description = 'PROP_STRING_F (figure, string) is a figure, string.';
				case ETA.PROP_LOGICAL_F
					prop_description = 'PROP_LOGICAL_F (figure, logical) is a figure, logical.';
				case ETA.PROP_OPTION_F
					prop_description = 'PROP_OPTION_F (figure, option) is a figure, option.';
				case ETA.PROP_CLASS_F
					prop_description = 'PROP_CLASS_F (figure, class) is a figure, class.';
				case ETA.PROP_CLASSLIST_F
					prop_description = 'PROP_CLASSLIST_F (figure, classlist) is a figure, classlist.';
				case ETA.PROP_ITEM_F
					prop_description = 'PROP_ITEM_F (figure, item) is a figure, item.';
				case ETA.PROP_ITEMLIST_F
					prop_description = 'PROP_ITEMLIST_F (figure, itemlist) is a figure, itemlist.';
				case ETA.PROP_IDICT_F
					prop_description = 'PROP_IDICT_F (figure, idict) is a figure, idict.';
				case ETA.PROP_SCALAR_F
					prop_description = 'PROP_SCALAR_F (figure, scalar) is a figure, scalar.';
				case ETA.PROP_RVECTOR_F
					prop_description = 'PROP_RVECTOR_F (figure, rvector) is a figure, rvector.';
				case ETA.PROP_CVECTOR_F
					prop_description = 'PROP_CVECTOR_F (figure, cvector) is a figure, cvector.';
				case ETA.PROP_MATRIX_F
					prop_description = 'PROP_MATRIX_F (figure, matrix) is a figure, matrix.';
				case ETA.PROP_SMATRIX_F
					prop_description = 'PROP_SMATRIX_F (figure, smatrix) is a figure, smatrix.';
				case ETA.PROP_CELL_F
					prop_description = 'PROP_CELL_F (figure, cell) is a figure, cell.';
				case ETA.PROP_NET_F
					prop_description = 'PROP_NET_F (figure, net) is a figure, net.';
				case ETA.PROP_EMPTY_G
					prop_description = 'PROP_EMPTY_G (gui, empty) is a gui, empty.';
				case ETA.PROP_STRING_G
					prop_description = 'PROP_STRING_G (gui, string) is a gui, string.';
				case ETA.PROP_LOGICAL_G
					prop_description = 'PROP_LOGICAL_G (gui, logical) is a gui, logical.';
				case ETA.PROP_OPTION_G
					prop_description = 'PROP_OPTION_G (gui, option) is a gui, option.';
				case ETA.PROP_CLASS_G
					prop_description = 'PROP_CLASS_G (gui, class) is a gui, class.';
				case ETA.PROP_CLASSLIST_G
					prop_description = 'PROP_CLASSLIST_G (gui, classlist) is a gui, classlist.';
				case ETA.PROP_ITEM_G
					prop_description = 'PROP_ITEM_G (gui, item) is a gui, item.';
				case ETA.PROP_ITEMLIST_G
					prop_description = 'PROP_ITEMLIST_G (gui, itemlist) is a gui, itemlist.';
				case ETA.PROP_IDICT_G
					prop_description = 'PROP_IDICT_G (gui, idict) is a gui, idict.';
				case ETA.PROP_SCALAR_G
					prop_description = 'PROP_SCALAR_G (gui, scalar) is a gui, scalar.';
				case ETA.PROP_RVECTOR_G
					prop_description = 'PROP_RVECTOR_G (gui, rvector) is a gui, rvector.';
				case ETA.PROP_CVECTOR_G
					prop_description = 'PROP_CVECTOR_G (gui, cvector) is a gui, cvector.';
				case ETA.PROP_MATRIX_G
					prop_description = 'PROP_MATRIX_G (gui, matrix) is a gui, matrix.';
				case ETA.PROP_SMATRIX_G
					prop_description = 'PROP_SMATRIX_G (gui, smatrix) is a gui, smatrix.';
				case ETA.PROP_CELL_G
					prop_description = 'PROP_CELL_G (gui, cell) is a gui, cell.';
				case ETA.PROP_NET_G
					prop_description = 'PROP_NET_G (gui, net) is a gui, net.';
				case ETA.PROP_EMPTY_R
					prop_description = 'PROP_EMPTY_R (result, empty) is a result, empty.';
				case ETA.PROP_STRING_R
					prop_description = 'PROP_STRING_R (result, string) is a result, string.';
				case ETA.PROP_LOGICAL_R
					prop_description = 'PROP_LOGICAL_R (result, logical) is a result, logical.';
				case ETA.PROP_OPTION_R
					prop_description = 'PROP_OPTION_R (result, option) is a result, option.';
				case ETA.PROP_CLASS_R
					prop_description = 'PROP_CLASS_R (result, class) is a result, class.';
				case ETA.PROP_CLASSLIST_R
					prop_description = 'PROP_CLASSLIST_R (result, classlist) is a result, classlist.';
				case ETA.PROP_ITEM_R
					prop_description = 'PROP_ITEM_R (result, item) is a result, item.';
				case ETA.PROP_ITEMLIST_R
					prop_description = 'PROP_ITEMLIST_R (result, itemlist) is a result, itemlist.';
				case ETA.PROP_IDICT_R
					prop_description = 'PROP_IDICT_R (result, idict) is a result, idict.';
				case ETA.PROP_SCALAR_R
					prop_description = 'PROP_SCALAR_R (result, scalar) is a result, scalar.';
				case ETA.PROP_RVECTOR_R
					prop_description = 'PROP_RVECTOR_R (result, rvector) is a result, rvector.';
				case ETA.PROP_CVECTOR_R
					prop_description = 'PROP_CVECTOR_R (result, cvector) is a result, cvector.';
				case ETA.PROP_MATRIX_R
					prop_description = 'PROP_MATRIX_R (result, matrix) is a result, matrix.';
				case ETA.PROP_SMATRIX_R
					prop_description = 'PROP_SMATRIX_R (result, smatrix) is a result, smatrix.';
				case ETA.PROP_CELL_R
					prop_description = 'PROP_CELL_R (result, cell) is a result, cell.';
				case ETA.PROP_NET_R
					prop_description = 'PROP_NET_R (result, net) is a result, net.';
				case ETA.PROP_EMPTY_R_CALC
					prop_description = 'PROP_EMPTY_R_CALC (result, empty) is a result, empty.';
				case ETA.PROP_STRING_R_CALC
					prop_description = 'PROP_STRING_R_CALC (result, string) is a result, string.';
				case ETA.PROP_LOGICAL_R_CALC
					prop_description = 'PROP_LOGICAL_R_CALC (result, logical) is a result, logical.';
				case ETA.PROP_OPTION_R_CALC
					prop_description = 'PROP_OPTION_R_CALC (result, option) is a result, option.';
				case ETA.PROP_CLASS_R_CALC
					prop_description = 'PROP_CLASS_R_CALC (result, class) is a result, class.';
				case ETA.PROP_CLASSLIST_R_CALC
					prop_description = 'PROP_CLASSLIST_R_CALC (result, classlist) is a result, classlist.';
				case ETA.PROP_ITEM_R_CALC
					prop_description = 'PROP_ITEM_R_CALC (result, item) is a result, item.';
				case ETA.PROP_ITEMLIST_R_CALC
					prop_description = 'PROP_ITEMLIST_R_CALC (result, itemlist) is a result, itemlist.';
				case ETA.PROP_IDICT_R_CALC
					prop_description = 'PROP_IDICT_R_CALC (result, idict) is a result, idict.';
				case ETA.PROP_SCALAR_R_CALC
					prop_description = 'PROP_SCALAR_R_CALC (result, scalar) is a result, scalar.';
				case ETA.PROP_RVECTOR_R_CALC
					prop_description = 'PROP_RVECTOR_R_CALC (result, rvector) is a result, rvector.';
				case ETA.PROP_CVECTOR_R_CALC
					prop_description = 'PROP_CVECTOR_R_CALC (result, cvector) is a result, cvector.';
				case ETA.PROP_MATRIX_R_CALC
					prop_description = 'PROP_MATRIX_R_CALC (result, matrix) is a result, matrix.';
				case ETA.PROP_SMATRIX_R_CALC
					prop_description = 'PROP_SMATRIX_R_CALC (result, smatrix) is a result, smatrix.';
				case ETA.PROP_CELL_R_CALC
					prop_description = 'PROP_CELL_R_CALC (result, cell) is a result, cell.';
				case ETA.PROP_NET_R_CALC
					prop_description = 'PROP_NET_R_CALC (result, net) is a result, net.';
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
			%  SETTINGS = ET.GETPROPSETTINGS(POINTER) returns settings of POINTER of ET.
			%  SETTINGS = Element.GETPROPSETTINGS(ETA, POINTER) returns settings of POINTER of ETA.
			%  SETTINGS = ET.GETPROPSETTINGS(ETA, POINTER) returns settings of POINTER of ETA.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			% getPropFormat, getPropDescription, getPropDefault,
			% checkProp.
			
			prop = ETA.getPropProp(pointer);
			
			switch prop
				case ETA.PROP_EMPTY_M
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ETA.PROP_STRING_M
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETA.PROP_LOGICAL_M
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case ETA.PROP_OPTION_M
					prop_settings = {'one' 'two' 'three'};
				case ETA.PROP_CLASS_M
					prop_settings = 'ETA';
				case ETA.PROP_CLASSLIST_M
					prop_settings = 'ETA';
				case ETA.PROP_ITEM_M
					prop_settings = 'ETA';
				case ETA.PROP_ITEMLIST_M
					prop_settings = 'ETA';
				case ETA.PROP_IDICT_M
					prop_settings = 'ETA';
				case ETA.PROP_SCALAR_M
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETA.PROP_RVECTOR_M
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETA.PROP_CVECTOR_M
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETA.PROP_MATRIX_M
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case ETA.PROP_SMATRIX_M
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case ETA.PROP_CELL_M
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ETA.PROP_NET_M
					prop_settings = Format.getFormatSettings(Format.NET);
				case ETA.PROP_EMPTY_P
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ETA.PROP_STRING_P
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETA.PROP_LOGICAL_P
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case ETA.PROP_OPTION_P
					prop_settings = {'one' 'two' 'three'};
				case ETA.PROP_CLASS_P
					prop_settings = 'Element';
				case ETA.PROP_CLASSLIST_P
					prop_settings = 'Element';
				case ETA.PROP_ITEM_P
					prop_settings = 'Element';
				case ETA.PROP_ITEMLIST_P
					prop_settings = 'Element';
				case ETA.PROP_IDICT_P
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case ETA.PROP_SCALAR_P
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETA.PROP_RVECTOR_P
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETA.PROP_CVECTOR_P
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETA.PROP_MATRIX_P
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case ETA.PROP_SMATRIX_P
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case ETA.PROP_CELL_P
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ETA.PROP_NET_P
					prop_settings = Format.getFormatSettings(Format.NET);
				case ETA.PROP_EMPTY_D
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ETA.PROP_STRING_D
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETA.PROP_LOGICAL_D
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case ETA.PROP_OPTION_D
					prop_settings = Format.getFormatSettings(Format.OPTION);
				case ETA.PROP_CLASS_D
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case ETA.PROP_CLASSLIST_D
					prop_settings = Format.getFormatSettings(Format.CLASSLIST);
				case ETA.PROP_ITEM_D
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case ETA.PROP_ITEMLIST_D
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
				case ETA.PROP_IDICT_D
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case ETA.PROP_SCALAR_D
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETA.PROP_RVECTOR_D
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETA.PROP_CVECTOR_D
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETA.PROP_MATRIX_D
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case ETA.PROP_SMATRIX_D
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case ETA.PROP_CELL_D
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ETA.PROP_NET_D
					prop_settings = Format.getFormatSettings(Format.NET);
				case ETA.PROP_EMPTY_F
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ETA.PROP_STRING_F
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETA.PROP_LOGICAL_F
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case ETA.PROP_OPTION_F
					prop_settings = {'one' 'two' 'three'};
				case ETA.PROP_CLASS_F
					prop_settings = 'ETA';
				case ETA.PROP_CLASSLIST_F
					prop_settings = 'ETA';
				case ETA.PROP_ITEM_F
					prop_settings = 'ETA';
				case ETA.PROP_ITEMLIST_F
					prop_settings = 'ETA';
				case ETA.PROP_IDICT_F
					prop_settings = 'ETA';
				case ETA.PROP_SCALAR_F
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETA.PROP_RVECTOR_F
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETA.PROP_CVECTOR_F
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETA.PROP_MATRIX_F
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case ETA.PROP_SMATRIX_F
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case ETA.PROP_CELL_F
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ETA.PROP_NET_F
					prop_settings = Format.getFormatSettings(Format.NET);
				case ETA.PROP_EMPTY_G
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ETA.PROP_STRING_G
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETA.PROP_LOGICAL_G
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case ETA.PROP_OPTION_G
					prop_settings = {'one' 'two' 'three'};
				case ETA.PROP_CLASS_G
					prop_settings = 'ETA';
				case ETA.PROP_CLASSLIST_G
					prop_settings = 'ETA';
				case ETA.PROP_ITEM_G
					prop_settings = 'ETA';
				case ETA.PROP_ITEMLIST_G
					prop_settings = 'ETA';
				case ETA.PROP_IDICT_G
					prop_settings = 'ETA';
				case ETA.PROP_SCALAR_G
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETA.PROP_RVECTOR_G
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETA.PROP_CVECTOR_G
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETA.PROP_MATRIX_G
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case ETA.PROP_SMATRIX_G
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case ETA.PROP_CELL_G
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ETA.PROP_NET_G
					prop_settings = Format.getFormatSettings(Format.NET);
				case ETA.PROP_EMPTY_R
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ETA.PROP_STRING_R
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETA.PROP_LOGICAL_R
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case ETA.PROP_OPTION_R
					prop_settings = Format.getFormatSettings(Format.OPTION);
				case ETA.PROP_CLASS_R
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case ETA.PROP_CLASSLIST_R
					prop_settings = Format.getFormatSettings(Format.CLASSLIST);
				case ETA.PROP_ITEM_R
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case ETA.PROP_ITEMLIST_R
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
				case ETA.PROP_IDICT_R
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case ETA.PROP_SCALAR_R
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETA.PROP_RVECTOR_R
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETA.PROP_CVECTOR_R
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETA.PROP_MATRIX_R
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case ETA.PROP_SMATRIX_R
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case ETA.PROP_CELL_R
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ETA.PROP_NET_R
					prop_settings = Format.getFormatSettings(Format.NET);
				case ETA.PROP_EMPTY_R_CALC
					prop_settings = Format.getFormatSettings(Format.EMPTY);
				case ETA.PROP_STRING_R_CALC
					prop_settings = Format.getFormatSettings(Format.STRING);
				case ETA.PROP_LOGICAL_R_CALC
					prop_settings = Format.getFormatSettings(Format.LOGICAL);
				case ETA.PROP_OPTION_R_CALC
					prop_settings = [ETA.getPropSettings('PROP_OPTION_D') ETA.getPropSettings('PROP_OPTION_P')];
				case ETA.PROP_CLASS_R_CALC
					prop_settings = Format.getFormatSettings(Format.CLASS);
				case ETA.PROP_CLASSLIST_R_CALC
					prop_settings = Format.getFormatSettings(Format.CLASSLIST);
				case ETA.PROP_ITEM_R_CALC
					prop_settings = Format.getFormatSettings(Format.ITEM);
				case ETA.PROP_ITEMLIST_R_CALC
					prop_settings = Format.getFormatSettings(Format.ITEMLIST);
				case ETA.PROP_IDICT_R_CALC
					prop_settings = Format.getFormatSettings(Format.IDICT);
				case ETA.PROP_SCALAR_R_CALC
					prop_settings = Format.getFormatSettings(Format.SCALAR);
				case ETA.PROP_RVECTOR_R_CALC
					prop_settings = Format.getFormatSettings(Format.RVECTOR);
				case ETA.PROP_CVECTOR_R_CALC
					prop_settings = Format.getFormatSettings(Format.CVECTOR);
				case ETA.PROP_MATRIX_R_CALC
					prop_settings = Format.getFormatSettings(Format.MATRIX);
				case ETA.PROP_SMATRIX_R_CALC
					prop_settings = Format.getFormatSettings(Format.SMATRIX);
				case ETA.PROP_CELL_R_CALC
					prop_settings = Format.getFormatSettings(Format.CELL);
				case ETA.PROP_NET_R_CALC
					prop_settings = Format.getFormatSettings(Format.NET);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ETA.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ETA.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULT(ETA, POINTER) returns the default value of POINTER of ETA.
			%  DEFAULT = ET.GETPROPDEFAULT(ETA, POINTER) returns the default value of POINTER of ETA.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETA.getPropProp(pointer);
			
			switch prop
				case ETA.PROP_EMPTY_M
					prop_default = Format.getFormatDefault(Format.EMPTY, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_M
					prop_default = Format.getFormatDefault(Format.STRING, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_M
					prop_default = Format.getFormatDefault(Format.LOGICAL, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_M
					prop_default = Format.getFormatDefault(Format.OPTION, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_M
					prop_default = Format.getFormatDefault(Format.CLASS, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_M
					prop_default = Format.getFormatDefault(Format.CLASSLIST, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_M
					prop_default = Format.getFormatDefault(Format.ITEM, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_M
					prop_default = Format.getFormatDefault(Format.ITEMLIST, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_M
					prop_default = Format.getFormatDefault(Format.IDICT, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_M
					prop_default = Format.getFormatDefault(Format.SCALAR, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_M
					prop_default = Format.getFormatDefault(Format.RVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_M
					prop_default = Format.getFormatDefault(Format.CVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_M
					prop_default = Format.getFormatDefault(Format.MATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_M
					prop_default = Format.getFormatDefault(Format.SMATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_M
					prop_default = Format.getFormatDefault(Format.CELL, ETA.getPropSettings(prop));
				case ETA.PROP_NET_M
					prop_default = Format.getFormatDefault(Format.NET, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_P
					prop_default = Format.getFormatDefault(Format.EMPTY, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_P
					prop_default = Format.getFormatDefault(Format.STRING, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_P
					prop_default = Format.getFormatDefault(Format.LOGICAL, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_P
					prop_default = 'two';
				case ETA.PROP_CLASS_P
					prop_default = 'ETA';
				case ETA.PROP_CLASSLIST_P
					prop_default = {'Element' 'NoValue' 'ETA'};
				case ETA.PROP_ITEM_P
					prop_default = ETA();
				case ETA.PROP_ITEMLIST_P
					prop_default = {ETA ETA ETA};
				case ETA.PROP_IDICT_P
					prop_default = Format.getFormatDefault(Format.IDICT, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_P
					prop_default = pi;
				case ETA.PROP_RVECTOR_P
					prop_default = Format.getFormatDefault(Format.RVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_P
					prop_default = Format.getFormatDefault(Format.CVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_P
					prop_default = Format.getFormatDefault(Format.MATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_P
					prop_default = Format.getFormatDefault(Format.SMATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_P
					prop_default = Format.getFormatDefault(Format.CELL, ETA.getPropSettings(prop));
				case ETA.PROP_NET_P
					prop_default = Format.getFormatDefault(Format.NET, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_D
					prop_default = Format.getFormatDefault(Format.EMPTY, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_D
					prop_default = Format.getFormatDefault(Format.STRING, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_D
					prop_default = Format.getFormatDefault(Format.LOGICAL, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_D
					prop_default = Format.getFormatDefault(Format.OPTION, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_D
					prop_default = Format.getFormatDefault(Format.CLASS, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_D
					prop_default = Format.getFormatDefault(Format.CLASSLIST, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_D
					prop_default = Format.getFormatDefault(Format.ITEM, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_D
					prop_default = Format.getFormatDefault(Format.ITEMLIST, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_D
					prop_default = Format.getFormatDefault(Format.IDICT, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_D
					prop_default = Format.getFormatDefault(Format.SCALAR, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_D
					prop_default = Format.getFormatDefault(Format.RVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_D
					prop_default = Format.getFormatDefault(Format.CVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_D
					prop_default = Format.getFormatDefault(Format.MATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_D
					prop_default = Format.getFormatDefault(Format.SMATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_D
					prop_default = Format.getFormatDefault(Format.CELL, ETA.getPropSettings(prop));
				case ETA.PROP_NET_D
					prop_default = Format.getFormatDefault(Format.NET, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_F
					prop_default = Format.getFormatDefault(Format.EMPTY, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_F
					prop_default = Format.getFormatDefault(Format.STRING, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_F
					prop_default = Format.getFormatDefault(Format.LOGICAL, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_F
					prop_default = Format.getFormatDefault(Format.OPTION, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_F
					prop_default = Format.getFormatDefault(Format.CLASS, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_F
					prop_default = Format.getFormatDefault(Format.CLASSLIST, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_F
					prop_default = Format.getFormatDefault(Format.ITEM, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_F
					prop_default = Format.getFormatDefault(Format.ITEMLIST, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_F
					prop_default = Format.getFormatDefault(Format.IDICT, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_F
					prop_default = Format.getFormatDefault(Format.SCALAR, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_F
					prop_default = Format.getFormatDefault(Format.RVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_F
					prop_default = Format.getFormatDefault(Format.CVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_F
					prop_default = Format.getFormatDefault(Format.MATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_F
					prop_default = Format.getFormatDefault(Format.SMATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_F
					prop_default = Format.getFormatDefault(Format.CELL, ETA.getPropSettings(prop));
				case ETA.PROP_NET_F
					prop_default = Format.getFormatDefault(Format.NET, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_G
					prop_default = Format.getFormatDefault(Format.EMPTY, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_G
					prop_default = Format.getFormatDefault(Format.STRING, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_G
					prop_default = Format.getFormatDefault(Format.LOGICAL, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_G
					prop_default = Format.getFormatDefault(Format.OPTION, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_G
					prop_default = Format.getFormatDefault(Format.CLASS, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_G
					prop_default = Format.getFormatDefault(Format.CLASSLIST, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_G
					prop_default = Format.getFormatDefault(Format.ITEM, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_G
					prop_default = Format.getFormatDefault(Format.ITEMLIST, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_G
					prop_default = Format.getFormatDefault(Format.IDICT, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_G
					prop_default = Format.getFormatDefault(Format.SCALAR, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_G
					prop_default = Format.getFormatDefault(Format.RVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_G
					prop_default = Format.getFormatDefault(Format.CVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_G
					prop_default = Format.getFormatDefault(Format.MATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_G
					prop_default = Format.getFormatDefault(Format.SMATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_G
					prop_default = Format.getFormatDefault(Format.CELL, ETA.getPropSettings(prop));
				case ETA.PROP_NET_G
					prop_default = Format.getFormatDefault(Format.NET, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_R
					prop_default = Format.getFormatDefault(Format.EMPTY, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_R
					prop_default = Format.getFormatDefault(Format.STRING, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_R
					prop_default = Format.getFormatDefault(Format.LOGICAL, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_R
					prop_default = Format.getFormatDefault(Format.OPTION, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_R
					prop_default = Format.getFormatDefault(Format.CLASS, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_R
					prop_default = Format.getFormatDefault(Format.CLASSLIST, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_R
					prop_default = Format.getFormatDefault(Format.ITEM, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_R
					prop_default = Format.getFormatDefault(Format.ITEMLIST, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_R
					prop_default = Format.getFormatDefault(Format.IDICT, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_R
					prop_default = Format.getFormatDefault(Format.SCALAR, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_R
					prop_default = Format.getFormatDefault(Format.RVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_R
					prop_default = Format.getFormatDefault(Format.CVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_R
					prop_default = Format.getFormatDefault(Format.MATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_R
					prop_default = Format.getFormatDefault(Format.SMATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_R
					prop_default = Format.getFormatDefault(Format.CELL, ETA.getPropSettings(prop));
				case ETA.PROP_NET_R
					prop_default = Format.getFormatDefault(Format.NET, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_R_CALC
					prop_default = Format.getFormatDefault(Format.EMPTY, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_R_CALC
					prop_default = Format.getFormatDefault(Format.STRING, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_R_CALC
					prop_default = Format.getFormatDefault(Format.LOGICAL, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_R_CALC
					prop_default = Format.getFormatDefault(Format.OPTION, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_R_CALC
					prop_default = Format.getFormatDefault(Format.CLASS, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_R_CALC
					prop_default = Format.getFormatDefault(Format.CLASSLIST, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_R_CALC
					prop_default = Format.getFormatDefault(Format.ITEM, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_R_CALC
					prop_default = Format.getFormatDefault(Format.ITEMLIST, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_R_CALC
					prop_default = Format.getFormatDefault(Format.IDICT, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_R_CALC
					prop_default = Format.getFormatDefault(Format.SCALAR, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_R_CALC
					prop_default = Format.getFormatDefault(Format.RVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_R_CALC
					prop_default = Format.getFormatDefault(Format.CVECTOR, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_R_CALC
					prop_default = Format.getFormatDefault(Format.MATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_R_CALC
					prop_default = Format.getFormatDefault(Format.SMATRIX, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_R_CALC
					prop_default = Format.getFormatDefault(Format.CELL, ETA.getPropSettings(prop));
				case ETA.PROP_NET_R_CALC
					prop_default = Format.getFormatDefault(Format.NET, ETA.getPropSettings(prop));
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ETA.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ETA.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ET.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ETA, POINTER) returns the conditioned default value of POINTER of ETA.
			%  DEFAULT = ET.GETPROPDEFAULTCONDITIONED(ETA, POINTER) returns the conditioned default value of POINTER of ETA.
			%
			% See also getPropDefault, getPropProp, getPropTag, getPropSettings, 
			% getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ETA.getPropProp(pointer);
			
			prop_default = ETA.conditioning(prop, ETA.getPropDefault(prop));
		end
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ET.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ET.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ET.
			%  CHECK = Element.CHECKPROP(ETA, PROP, VALUE) checks VALUE format for PROP of ETA.
			%  CHECK = ET.CHECKPROP(ETA, PROP, VALUE) checks VALUE format for PROP of ETA.
			% 
			% ET.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: [BRAPH2:ETA:WrongInput]
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ET.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ET.
			%   Error id: [BRAPH2:ETA:WrongInput]
			%  Element.CHECKPROP(ETA, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETA.
			%   Error id: [BRAPH2:ETA:WrongInput]
			%  ET.CHECKPROP(ETA, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ETA.
			%   Error id: [BRAPH2:ETA:WrongInput]
			% 
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription,
			% getPropDefault.
			
			prop = ETA.getPropProp(pointer);
			
			switch prop
				case ETA.PROP_EMPTY_M
					check = Format.checkFormat(Format.EMPTY, value, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_M
					check = Format.checkFormat(Format.STRING, value, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_M
					check = Format.checkFormat(Format.LOGICAL, value, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_M
					check = Format.checkFormat(Format.OPTION, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_M
					check = Format.checkFormat(Format.CLASS, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_M
					check = Format.checkFormat(Format.CLASSLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_M
					check = Format.checkFormat(Format.ITEM, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_M
					check = Format.checkFormat(Format.ITEMLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_M
					check = Format.checkFormat(Format.IDICT, value, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_M
					check = Format.checkFormat(Format.SCALAR, value, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_M
					check = Format.checkFormat(Format.RVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_M
					check = Format.checkFormat(Format.CVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_M
					check = Format.checkFormat(Format.MATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_M
					check = Format.checkFormat(Format.SMATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_M
					check = Format.checkFormat(Format.CELL, value, ETA.getPropSettings(prop));
				case ETA.PROP_NET_M
					check = Format.checkFormat(Format.NET, value, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_P
					check = Format.checkFormat(Format.EMPTY, value, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_P
					check = Format.checkFormat(Format.STRING, value, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_P
					check = Format.checkFormat(Format.LOGICAL, value, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_P
					check = Format.checkFormat(Format.OPTION, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_P
					check = Format.checkFormat(Format.CLASS, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_P
					check = Format.checkFormat(Format.CLASSLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_P
					check = Format.checkFormat(Format.ITEM, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_P
					check = Format.checkFormat(Format.ITEMLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_P
					check = Format.checkFormat(Format.IDICT, value, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_P
					check = Format.checkFormat(Format.SCALAR, value, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_P
					check = Format.checkFormat(Format.RVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_P
					check = Format.checkFormat(Format.CVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_P
					check = Format.checkFormat(Format.MATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_P
					check = Format.checkFormat(Format.SMATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_P
					check = Format.checkFormat(Format.CELL, value, ETA.getPropSettings(prop));
				case ETA.PROP_NET_P
					check = Format.checkFormat(Format.NET, value, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_D
					check = Format.checkFormat(Format.EMPTY, value, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_D
					check = Format.checkFormat(Format.STRING, value, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_D
					check = Format.checkFormat(Format.LOGICAL, value, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_D
					check = Format.checkFormat(Format.OPTION, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_D
					check = Format.checkFormat(Format.CLASS, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_D
					check = Format.checkFormat(Format.CLASSLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_D
					check = Format.checkFormat(Format.ITEM, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_D
					check = Format.checkFormat(Format.ITEMLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_D
					check = Format.checkFormat(Format.IDICT, value, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_D
					check = Format.checkFormat(Format.SCALAR, value, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_D
					check = Format.checkFormat(Format.RVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_D
					check = Format.checkFormat(Format.CVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_D
					check = Format.checkFormat(Format.MATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_D
					check = Format.checkFormat(Format.SMATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_D
					check = Format.checkFormat(Format.CELL, value, ETA.getPropSettings(prop));
				case ETA.PROP_NET_D
					check = Format.checkFormat(Format.NET, value, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_F
					check = Format.checkFormat(Format.EMPTY, value, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_F
					check = Format.checkFormat(Format.STRING, value, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_F
					check = Format.checkFormat(Format.LOGICAL, value, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_F
					check = Format.checkFormat(Format.OPTION, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_F
					check = Format.checkFormat(Format.CLASS, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_F
					check = Format.checkFormat(Format.CLASSLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_F
					check = Format.checkFormat(Format.ITEM, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_F
					check = Format.checkFormat(Format.ITEMLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_F
					check = Format.checkFormat(Format.IDICT, value, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_F
					check = Format.checkFormat(Format.SCALAR, value, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_F
					check = Format.checkFormat(Format.RVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_F
					check = Format.checkFormat(Format.CVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_F
					check = Format.checkFormat(Format.MATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_F
					check = Format.checkFormat(Format.SMATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_F
					check = Format.checkFormat(Format.CELL, value, ETA.getPropSettings(prop));
				case ETA.PROP_NET_F
					check = Format.checkFormat(Format.NET, value, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_G
					check = Format.checkFormat(Format.EMPTY, value, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_G
					check = Format.checkFormat(Format.STRING, value, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_G
					check = Format.checkFormat(Format.LOGICAL, value, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_G
					check = Format.checkFormat(Format.OPTION, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_G
					check = Format.checkFormat(Format.CLASS, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_G
					check = Format.checkFormat(Format.CLASSLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_G
					check = Format.checkFormat(Format.ITEM, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_G
					check = Format.checkFormat(Format.ITEMLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_G
					check = Format.checkFormat(Format.IDICT, value, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_G
					check = Format.checkFormat(Format.SCALAR, value, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_G
					check = Format.checkFormat(Format.RVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_G
					check = Format.checkFormat(Format.CVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_G
					check = Format.checkFormat(Format.MATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_G
					check = Format.checkFormat(Format.SMATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_G
					check = Format.checkFormat(Format.CELL, value, ETA.getPropSettings(prop));
				case ETA.PROP_NET_G
					check = Format.checkFormat(Format.NET, value, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_R
					check = Format.checkFormat(Format.EMPTY, value, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_R
					check = Format.checkFormat(Format.STRING, value, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_R
					check = Format.checkFormat(Format.LOGICAL, value, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_R
					check = Format.checkFormat(Format.OPTION, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_R
					check = Format.checkFormat(Format.CLASS, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_R
					check = Format.checkFormat(Format.CLASSLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_R
					check = Format.checkFormat(Format.ITEM, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_R
					check = Format.checkFormat(Format.ITEMLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_R
					check = Format.checkFormat(Format.IDICT, value, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_R
					check = Format.checkFormat(Format.SCALAR, value, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_R
					check = Format.checkFormat(Format.RVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_R
					check = Format.checkFormat(Format.CVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_R
					check = Format.checkFormat(Format.MATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_R
					check = Format.checkFormat(Format.SMATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_R
					check = Format.checkFormat(Format.CELL, value, ETA.getPropSettings(prop));
				case ETA.PROP_NET_R
					check = Format.checkFormat(Format.NET, value, ETA.getPropSettings(prop));
				case ETA.PROP_EMPTY_R_CALC
					check = Format.checkFormat(Format.EMPTY, value, ETA.getPropSettings(prop));
				case ETA.PROP_STRING_R_CALC
					check = Format.checkFormat(Format.STRING, value, ETA.getPropSettings(prop));
				case ETA.PROP_LOGICAL_R_CALC
					check = Format.checkFormat(Format.LOGICAL, value, ETA.getPropSettings(prop));
				case ETA.PROP_OPTION_R_CALC
					check = Format.checkFormat(Format.OPTION, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASS_R_CALC
					check = Format.checkFormat(Format.CLASS, value, ETA.getPropSettings(prop));
				case ETA.PROP_CLASSLIST_R_CALC
					check = Format.checkFormat(Format.CLASSLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEM_R_CALC
					check = Format.checkFormat(Format.ITEM, value, ETA.getPropSettings(prop));
				case ETA.PROP_ITEMLIST_R_CALC
					check = Format.checkFormat(Format.ITEMLIST, value, ETA.getPropSettings(prop));
				case ETA.PROP_IDICT_R_CALC
					check = Format.checkFormat(Format.IDICT, value, ETA.getPropSettings(prop));
				case ETA.PROP_SCALAR_R_CALC
					check = Format.checkFormat(Format.SCALAR, value, ETA.getPropSettings(prop));
				case ETA.PROP_RVECTOR_R_CALC
					check = Format.checkFormat(Format.RVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_CVECTOR_R_CALC
					check = Format.checkFormat(Format.CVECTOR, value, ETA.getPropSettings(prop));
				case ETA.PROP_MATRIX_R_CALC
					check = Format.checkFormat(Format.MATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_SMATRIX_R_CALC
					check = Format.checkFormat(Format.SMATRIX, value, ETA.getPropSettings(prop));
				case ETA.PROP_CELL_R_CALC
					check = Format.checkFormat(Format.CELL, value, ETA.getPropSettings(prop));
				case ETA.PROP_NET_R_CALC
					check = Format.checkFormat(Format.NET, value, ETA.getPropSettings(prop));
			end
			
			if nargout == 1
				prop_check = check;
			else
				assert( ...
					check, ...
					[BRAPH2.STR ':ETA:' BRAPH2.WRONG_INPUT], ...
					[BRAPH2.STR ':ETA:' BRAPH2.WRONG_INPUT ' ' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ETA.getPropTag(prop) ' (' ETA.getPropFormat(prop) ').'] ...
					)
			end
		end
	end
	methods % constructor
		function et = ETA(varargin)
			% ETA() creates a test Element A.
			%
			% ETA(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ETA(TAG, VALUE, ...) with property with tag TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ETA properties is:
			%  <strong>1</strong> <strong>prop_empty_m</strong> 	PROP_EMPTY_M (metadata, empty) is a metadata, empty.
			%  <strong>2</strong> <strong>prop_string_m</strong> 	PROP_STRING_M (metadata, string) is a metadata, string.
			%  <strong>3</strong> <strong>prop_logical_m</strong> 	PROP_LOGICAL_M (metadata, logical) is a metadata, logical.
			%  <strong>4</strong> <strong>prop_option_m</strong> 	PROP_OPTION_M (metadata, option) is a metadata, option.
			%  <strong>5</strong> <strong>prop_class_m</strong> 	PROP_CLASS_M (metadata, class) is a metadata, class.
			%  <strong>6</strong> <strong>prop_classlist_m</strong> 	PROP_CLASSLIST_M (metadata, classlist) is a metadata, classlist.
			%  <strong>7</strong> <strong>prop_item_m</strong> 	PROP_ITEM_M (metadata, item) is a metadata, item.
			%  <strong>8</strong> <strong>prop_itemlist_m</strong> 	PROP_ITEMLIST_M (metadata, itemlist) is a metadata, itemlist.
			%  <strong>9</strong> <strong>prop_idict_m</strong> 	PROP_IDICT_M (metadata, idict) is a metadata, idict.
			%  <strong>10</strong> <strong>prop_scalar_m</strong> 	PROP_SCALAR_M (metadata, scalar) is a metadata, scalar.
			%  <strong>11</strong> <strong>prop_rvector_m</strong> 	PROP_RVECTOR_M (metadata, rvector) is a metadata, rvector.
			%  <strong>12</strong> <strong>prop_cvector_m</strong> 	PROP_CVECTOR_M (metadata, cvector) is a metadata, cvector.
			%  <strong>13</strong> <strong>prop_matrix_m</strong> 	PROP_MATRIX_M (metadata, matrix) is a metadata, matrix.
			%  <strong>14</strong> <strong>prop_smatrix_m</strong> 	PROP_SMATRIX_M (metadata, smatrix) is a metadata, smatrix.
			%  <strong>15</strong> <strong>prop_cell_m</strong> 	PROP_CELL_M (metadata, cell) is a metadata, cell.
			%  <strong>16</strong> <strong>prop_net_m</strong> 	PROP_NET_M (metadata, net) is a metadata, net.
			%  <strong>17</strong> <strong>prop_empty_p</strong> 	PROP_EMPTY_P (parameter, empty) is a parameter, empty.
			%  <strong>18</strong> <strong>prop_string_p</strong> 	PROP_STRING_P (parameter, string) is a parameter, string.
			%  <strong>19</strong> <strong>prop_logical_p</strong> 	PROP_LOGICAL_P (parameter, logical) is a parameter, logical.
			%  <strong>20</strong> <strong>prop_option_p</strong> 	PROP_OPTION_P (parameter, option) is a parameter, option.
			%  <strong>21</strong> <strong>prop_class_p</strong> 	PROP_CLASS_P (parameter, class) is a parameter, class.
			%  <strong>22</strong> <strong>prop_classlist_p</strong> 	PROP_CLASSLIST_P (parameter, classlist) is a parameter, classlist.
			%  <strong>23</strong> <strong>prop_item_p</strong> 	PROP_ITEM_P (parameter, item) is a parameter, item.
			%  <strong>24</strong> <strong>prop_itemlist_p</strong> 	PROP_ITEMLIST_P (parameter, itemlist) is a parameter, itemlist.
			%  <strong>25</strong> <strong>prop_idict_p</strong> 	PROP_IDICT_P (parameter, idict) is a parameter, idict.
			%  <strong>26</strong> <strong>prop_scalar_p</strong> 	PROP_SCALAR_P (parameter, scalar) is a parameter, scalar.
			%  <strong>27</strong> <strong>prop_rvector_p</strong> 	PROP_RVECTOR_P (parameter, rvector) is a parameter, rvector.
			%  <strong>28</strong> <strong>prop_cvector_p</strong> 	PROP_CVECTOR_P (parameter, cvector) is a parameter, cvector.
			%  <strong>29</strong> <strong>prop_matrix_p</strong> 	PROP_MATRIX_P (parameter, matrix) is a parameter, matrix.
			%  <strong>30</strong> <strong>prop_smatrix_p</strong> 	PROP_SMATRIX_P (parameter, smatrix) is a parameter, smatrix.
			%  <strong>31</strong> <strong>prop_cell_p</strong> 	PROP_CELL_P (parameter, cell) is a parameter, cell.
			%  <strong>32</strong> <strong>prop_net_p</strong> 	PROP_NET_P (parameter, net) is a parameter, net.
			%  <strong>33</strong> <strong>prop_empty_d</strong> 	PROP_EMPTY_D (data, empty) is a data, empty.
			%  <strong>34</strong> <strong>prop_string_d</strong> 	PROP_STRING_D (data, string) is a data, string.
			%  <strong>35</strong> <strong>prop_logical_d</strong> 	PROP_LOGICAL_D (data, logical) is a data, logical.
			%  <strong>36</strong> <strong>prop_option_d</strong> 	PROP_OPTION_D (data, option) is a data, option.
			%  <strong>37</strong> <strong>prop_class_d</strong> 	PROP_CLASS_D (data, class) is a data, class.
			%  <strong>38</strong> <strong>prop_classlist_d</strong> 	PROP_CLASSLIST_D (data, classlist) is a data, classlist.
			%  <strong>39</strong> <strong>prop_item_d</strong> 	PROP_ITEM_D (data, item) is a data, item.
			%  <strong>40</strong> <strong>prop_itemlist_d</strong> 	PROP_ITEMLIST_D (data, itemlist) is a data, itemlist.
			%  <strong>41</strong> <strong>prop_idict_d</strong> 	PROP_IDICT_D (data, idict) is a data, idict.
			%  <strong>42</strong> <strong>prop_scalar_d</strong> 	PROP_SCALAR_D (data, scalar) is a data, scalar.
			%  <strong>43</strong> <strong>prop_rvector_d</strong> 	PROP_RVECTOR_D (data, rvector) is a data, rvector.
			%  <strong>44</strong> <strong>prop_cvector_d</strong> 	PROP_CVECTOR_D (data, cvector) is a data, cvector.
			%  <strong>45</strong> <strong>prop_matrix_d</strong> 	PROP_MATRIX_D (data, matrix) is a data, matrix.
			%  <strong>46</strong> <strong>prop_smatrix_d</strong> 	PROP_SMATRIX_D (data, smatrix) is a data, smatrix.
			%  <strong>47</strong> <strong>prop_cell_d</strong> 	PROP_CELL_D (data, cell) is a data, cell.
			%  <strong>48</strong> <strong>prop_net_d</strong> 	PROP_NET_D (data, net) is a data, net.
			%  <strong>49</strong> <strong>prop_empty_f</strong> 	PROP_EMPTY_F (figure, empty) is a figure, empty.
			%  <strong>50</strong> <strong>prop_string_f</strong> 	PROP_STRING_F (figure, string) is a figure, string.
			%  <strong>51</strong> <strong>prop_logical_f</strong> 	PROP_LOGICAL_F (figure, logical) is a figure, logical.
			%  <strong>52</strong> <strong>prop_option_f</strong> 	PROP_OPTION_F (figure, option) is a figure, option.
			%  <strong>53</strong> <strong>prop_class_f</strong> 	PROP_CLASS_F (figure, class) is a figure, class.
			%  <strong>54</strong> <strong>prop_classlist_f</strong> 	PROP_CLASSLIST_F (figure, classlist) is a figure, classlist.
			%  <strong>55</strong> <strong>prop_item_f</strong> 	PROP_ITEM_F (figure, item) is a figure, item.
			%  <strong>56</strong> <strong>prop_itemlist_f</strong> 	PROP_ITEMLIST_F (figure, itemlist) is a figure, itemlist.
			%  <strong>57</strong> <strong>prop_idict_f</strong> 	PROP_IDICT_F (figure, idict) is a figure, idict.
			%  <strong>58</strong> <strong>prop_scalar_f</strong> 	PROP_SCALAR_F (figure, scalar) is a figure, scalar.
			%  <strong>59</strong> <strong>prop_rvector_f</strong> 	PROP_RVECTOR_F (figure, rvector) is a figure, rvector.
			%  <strong>60</strong> <strong>prop_cvector_f</strong> 	PROP_CVECTOR_F (figure, cvector) is a figure, cvector.
			%  <strong>61</strong> <strong>prop_matrix_f</strong> 	PROP_MATRIX_F (figure, matrix) is a figure, matrix.
			%  <strong>62</strong> <strong>prop_smatrix_f</strong> 	PROP_SMATRIX_F (figure, smatrix) is a figure, smatrix.
			%  <strong>63</strong> <strong>prop_cell_f</strong> 	PROP_CELL_F (figure, cell) is a figure, cell.
			%  <strong>64</strong> <strong>prop_net_f</strong> 	PROP_NET_F (figure, net) is a figure, net.
			%  <strong>65</strong> <strong>prop_empty_g</strong> 	PROP_EMPTY_G (gui, empty) is a gui, empty.
			%  <strong>66</strong> <strong>prop_string_g</strong> 	PROP_STRING_G (gui, string) is a gui, string.
			%  <strong>67</strong> <strong>prop_logical_g</strong> 	PROP_LOGICAL_G (gui, logical) is a gui, logical.
			%  <strong>68</strong> <strong>prop_option_g</strong> 	PROP_OPTION_G (gui, option) is a gui, option.
			%  <strong>69</strong> <strong>prop_class_g</strong> 	PROP_CLASS_G (gui, class) is a gui, class.
			%  <strong>70</strong> <strong>prop_classlist_g</strong> 	PROP_CLASSLIST_G (gui, classlist) is a gui, classlist.
			%  <strong>71</strong> <strong>prop_item_g</strong> 	PROP_ITEM_G (gui, item) is a gui, item.
			%  <strong>72</strong> <strong>prop_itemlist_g</strong> 	PROP_ITEMLIST_G (gui, itemlist) is a gui, itemlist.
			%  <strong>73</strong> <strong>prop_idict_g</strong> 	PROP_IDICT_G (gui, idict) is a gui, idict.
			%  <strong>74</strong> <strong>prop_scalar_g</strong> 	PROP_SCALAR_G (gui, scalar) is a gui, scalar.
			%  <strong>75</strong> <strong>prop_rvector_g</strong> 	PROP_RVECTOR_G (gui, rvector) is a gui, rvector.
			%  <strong>76</strong> <strong>prop_cvector_g</strong> 	PROP_CVECTOR_G (gui, cvector) is a gui, cvector.
			%  <strong>77</strong> <strong>prop_matrix_g</strong> 	PROP_MATRIX_G (gui, matrix) is a gui, matrix.
			%  <strong>78</strong> <strong>prop_smatrix_g</strong> 	PROP_SMATRIX_G (gui, smatrix) is a gui, smatrix.
			%  <strong>79</strong> <strong>prop_cell_g</strong> 	PROP_CELL_G (gui, cell) is a gui, cell.
			%  <strong>80</strong> <strong>prop_net_g</strong> 	PROP_NET_G (gui, net) is a gui, net.
			%  <strong>81</strong> <strong>prop_empty_r</strong> 	PROP_EMPTY_R (result, empty) is a result, empty.
			%  <strong>82</strong> <strong>prop_string_r</strong> 	PROP_STRING_R (result, string) is a result, string.
			%  <strong>83</strong> <strong>prop_logical_r</strong> 	PROP_LOGICAL_R (result, logical) is a result, logical.
			%  <strong>84</strong> <strong>prop_option_r</strong> 	PROP_OPTION_R (result, option) is a result, option.
			%  <strong>85</strong> <strong>prop_class_r</strong> 	PROP_CLASS_R (result, class) is a result, class.
			%  <strong>86</strong> <strong>prop_classlist_r</strong> 	PROP_CLASSLIST_R (result, classlist) is a result, classlist.
			%  <strong>87</strong> <strong>prop_item_r</strong> 	PROP_ITEM_R (result, item) is a result, item.
			%  <strong>88</strong> <strong>prop_itemlist_r</strong> 	PROP_ITEMLIST_R (result, itemlist) is a result, itemlist.
			%  <strong>89</strong> <strong>prop_idict_r</strong> 	PROP_IDICT_R (result, idict) is a result, idict.
			%  <strong>90</strong> <strong>prop_scalar_r</strong> 	PROP_SCALAR_R (result, scalar) is a result, scalar.
			%  <strong>91</strong> <strong>prop_rvector_r</strong> 	PROP_RVECTOR_R (result, rvector) is a result, rvector.
			%  <strong>92</strong> <strong>prop_cvector_r</strong> 	PROP_CVECTOR_R (result, cvector) is a result, cvector.
			%  <strong>93</strong> <strong>prop_matrix_r</strong> 	PROP_MATRIX_R (result, matrix) is a result, matrix.
			%  <strong>94</strong> <strong>prop_smatrix_r</strong> 	PROP_SMATRIX_R (result, smatrix) is a result, smatrix.
			%  <strong>95</strong> <strong>prop_cell_r</strong> 	PROP_CELL_R (result, cell) is a result, cell.
			%  <strong>96</strong> <strong>prop_net_r</strong> 	PROP_NET_R (result, net) is a result, net.
			%  <strong>97</strong> <strong>prop_empty_r_calc</strong> 	PROP_EMPTY_R_CALC (result, empty) is a result, empty.
			%  <strong>98</strong> <strong>prop_string_r_calc</strong> 	PROP_STRING_R_CALC (result, string) is a result, string.
			%  <strong>99</strong> <strong>prop_logical_r_calc</strong> 	PROP_LOGICAL_R_CALC (result, logical) is a result, logical.
			%  <strong>100</strong> <strong>prop_option_r_calc</strong> 	PROP_OPTION_R_CALC (result, option) is a result, option.
			%  <strong>101</strong> <strong>prop_class_r_calc</strong> 	PROP_CLASS_R_CALC (result, class) is a result, class.
			%  <strong>102</strong> <strong>prop_classlist_r_calc</strong> 	PROP_CLASSLIST_R_CALC (result, classlist) is a result, classlist.
			%  <strong>103</strong> <strong>prop_item_r_calc</strong> 	PROP_ITEM_R_CALC (result, item) is a result, item.
			%  <strong>104</strong> <strong>prop_itemlist_r_calc</strong> 	PROP_ITEMLIST_R_CALC (result, itemlist) is a result, itemlist.
			%  <strong>105</strong> <strong>prop_idict_r_calc</strong> 	PROP_IDICT_R_CALC (result, idict) is a result, idict.
			%  <strong>106</strong> <strong>prop_scalar_r_calc</strong> 	PROP_SCALAR_R_CALC (result, scalar) is a result, scalar.
			%  <strong>107</strong> <strong>prop_rvector_r_calc</strong> 	PROP_RVECTOR_R_CALC (result, rvector) is a result, rvector.
			%  <strong>108</strong> <strong>prop_cvector_r_calc</strong> 	PROP_CVECTOR_R_CALC (result, cvector) is a result, cvector.
			%  <strong>109</strong> <strong>prop_matrix_r_calc</strong> 	PROP_MATRIX_R_CALC (result, matrix) is a result, matrix.
			%  <strong>110</strong> <strong>prop_smatrix_r_calc</strong> 	PROP_SMATRIX_R_CALC (result, smatrix) is a result, smatrix.
			%  <strong>111</strong> <strong>prop_cell_r_calc</strong> 	PROP_CELL_R_CALC (result, cell) is a result, cell.
			%  <strong>112</strong> <strong>prop_net_r_calc</strong> 	PROP_NET_R_CALC (result, net) is a result, net.
			%
			% See also Category, Format, set, check.
			
			et = et@Element(varargin{:});
		end
	end
	methods (Static, Access=protected) % conditioning
		function value = conditioning(pointer, value)
			prop = ETA.getPropProp(pointer);
			
			switch prop
				case ETA.PROP_CELL_D
					if isnumeric(value)
					    value = {value};
					end
					
				otherwise
					if prop <= Element.getPropNumber()
						value = conditioning@Element(pointer, value);
					end
			end
		end
	end
	methods (Access=protected) % check value
		function [check, msg] = checkValue(et, prop, value)
			check = true;
			msg = ['Error while checking' tostring(et) ' ' et.getPropTag(prop) '.'];
			
			switch prop
				case ETA.PROP_SCALAR_P
					check = value >= 0;
					
				otherwise
					[check, msg] = checkValue@Element(et, prop, value);
					
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(et, prop)
		
			switch prop
				case ETA.PROP_EMPTY_R_CALC
					rng(et.getPropSeed(ETA.PROP_EMPTY_R_CALC), 'twister')
					
					value = et.get('PROP_EMPTY_P');
					
				case ETA.PROP_STRING_R_CALC
					rng(et.getPropSeed(ETA.PROP_STRING_R_CALC), 'twister')
					
					value = ['P: ' et.get('PROP_STRING_P') ' D:' et.get('PROP_STRING_D')];
					
				case ETA.PROP_LOGICAL_R_CALC
					rng(et.getPropSeed(ETA.PROP_LOGICAL_R_CALC), 'twister')
					
					value = xor(et.get('PROP_LOGICAL_P'), et.get('PROP_LOGICAL_D'));
					
				case ETA.PROP_OPTION_R_CALC
					rng(et.getPropSeed(ETA.PROP_OPTION_R_CALC), 'twister')
					
					options = ETA.getPropSettings('PROP_OPTION_R_CALC');
					option = et.get('PROP_OPTION_P');
					value = options{find(strcmpi(option, options))};
					
				case ETA.PROP_SCALAR_R_CALC
					rng(et.getPropSeed(ETA.PROP_SCALAR_R_CALC), 'twister')
					
					value = et.get('PROP_SCALAR_P') + et.get('PROP_SCALAR_D') + et.get('PROP_SCALAR_R');
					
				case ETA.PROP_MATRIX_R_CALC
					rng(et.getPropSeed(ETA.PROP_MATRIX_R_CALC), 'twister')
					
					value = rand(10);
					
				case ETA.PROP_CELL_R_CALC
					rng(et.getPropSeed(ETA.PROP_CELL_R_CALC), 'twister')
					
					value = cellfun(@(x) rand(x), {1 2 3; 4 5 6}, 'UniformOutput', false);
					
				otherwise
					value = calculateValue@Element(et, prop);
					
			end
		end
	end
	methods % GUI
		function pr = getPlotProp(et, prop, varargin)
			%GETPLOTPROP returns a prop plot.
			%
			% PR = GETPLOTPROP(EL, PROP) returns the plot of prop PROP.
			%
			% PR = GETPLOTPROP(EL, PROP, 'Name', Value, ...) sets the settings.
			%
			% See also PlotProp, PlotPropCell, PlotPropClass, PlotPropClassList,
			%  PlotPropIDict, PlotPropItem, PlotPropItemList, PlotPropLogical,
			%  PlotPropMatrix, PlotPropOption, PlotPropScalar, PlotPropString.
			
			switch prop
				case ETA.PROP_STRING_M
					pr = PlotPropString('EL', et, 'PROP', ETA.PROP_STRING_M, varargin{:});
					
				otherwise
					pr = getPlotProp@Element(et, prop, varargin{:});
					
			end
		end
	end
end
