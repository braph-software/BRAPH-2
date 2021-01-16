%% ¡header!
NoValue < Element (nv, NoValue) represents a value that has not been set or calculated.

%%% ¡class_attributes!
Sealed = true

%%% ¡description!
NoValue is an element without values used to represent a value that has
not been set (for properties of categories PARAMETER AND DATA) or
calculated (for properties of category RESULT). 
For computational efficiency, it is best to use only one instance of NV 
using NoValue.getNoValue(), instead of creating new instances using the 
constructor NoValue(). 
No element can be a subclass of NoValue.

%%% ¡seealso!
Element

%% ¡staticmethods!
function nv = getNoValue()
    % GETNV returns a pointer to a persistent instance of NoValue.
    %
    % NV = GETNV() returns a pointer to a persistent instance of NoValue.
    % For computational efficiency, it is best to use NoValue.getNoValue(),
    % instead of creating new instances using the  constructor NoValue().

    persistent local_nv
    
    if isempty(local_nv) || ~isvalid(local_nv)
        local_nv = NoValue();
    end
    nv = local_nv;
end
