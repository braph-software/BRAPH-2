function save_layout(el, order, title)
%SAVE_LAYOUT saves the layout of an element.
%
% SAVE_LAYOUT(EL, ORDER, TITLE) saves the layout of the element EL (which
%  can be a element, class, or class name). 
%  ORDER is the order of each property (from 1 to the number of properties
%   to be shown, NaN for properties not to be shown).
%  TITLE is a cell array with the title of each property.
%
% See also load_layout.

layout_filename = [fileparts(which('braph2.m')) filesep 'src' filesep 'gui' filesep 'layouts' filesep Element.getClass(el) '.layout'];

save(layout_filename, '-mat', 'order', 'title')