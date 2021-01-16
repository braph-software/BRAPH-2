%% ¡header!
NoValue < Element (nv, NoValue) represents a value that has not been set or calculated.

%%% ¡class_attributes!
Sealed = true

%%% ¡description!
NoValue is an element without values used to represent a value that has
not been set (for properties of categories PARAMETER AND DATA) or
calculated (for properties of category RESULT). 
For computational efficiency, there is only one NoValue instance saved
as a static property in Element. 
No element can be a subclass of NoValue.

%%% ¡seealso!
Element