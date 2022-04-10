function [order, title, visible] = load_layout(el)
%LOAD_LAYOUT loads the layout of an element.
%
% [ORDER, TITLE, VISIBILITY] = LOAD_LAYOUT(EL) loads the layout of the
%  element EL (which can be a element, class, or class name). 
%  ORDER is the order of each property (from 1 to the number of properties
%   to be shown, NaN for properties not to be shown).
%  TITLE is a cell array with the title of each property.
%  VISIBLE indicates which properties are visible (i.e., their order is
%   not NaN).
%
% See also save_layout.

layout_filename = [fileparts(which('braph2.m')) filesep 'src' filesep 'gui' filesep 'layouts' filesep Element.getClass(el) '.layout'];

if isfile(layout_filename)
    load(layout_filename, '-mat', 'order', 'title')
else
    order = 1:1:Element.getPropNumber(el);
    title = cellfun(@(prop) upper(Element.getPropTag(el, prop)), num2cell(1:1:Element.getPropNumber(el)), 'UniformOutput', false);
end

visible = isfinite(order);