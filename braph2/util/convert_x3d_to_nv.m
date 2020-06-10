function convert_x3d_to_nv(file, varargin)

if nargin< 1 || isempty(file)
    msg = get_from_varargin(BRAPH2.X3D__MSG_GETFILE, 'msg', varargin{:});
    [filename, filepath, filterindex] = uigetfile(BRAPH2.X3D_EXTENSION, msg);
    file = [filepath filename];
    
    if ~filterindex
        return
    end
end

xml_file  = xmlread(file);
x3d_inner_file = xml_file.getFirstChild();
scene_elements = x3d_inner_file.getElementsByTagName('Scene');
scene = scene_elements.item(0);
transform_elements = scene.getElementsByTagName('Transform');
transform = transform_elements.item(0);
transform_inner_elements = transform.getElementsByTagName('Transform');
transform_inner = transform_inner_elements.item(0);
shape_elements = transform_inner.getElementsByTagName('Shape');
shape = shape_elements.item(0);
index_facet_elements = shape.getElementsByTagName('IndexedFaceSet');
index_facet = index_facet_elements.item(0);
triangles = index_facet.getAttribute('coordIndex');
coordinate_elements = index_facet.getElementsByTagName('Coordinate');
coordinate_element = coordinate_elements.item(0);
coordinates = coordinate_element.getAttribute('point');

% manage strings remove leading space, remove unwanted chars, split string,
% trimming and removing empty cells, triangles need to increase the number
% by 1, because matlab patch needs to be >= 1

triangles = erase(char(triangles), '             ');
triangles = strrep(triangles, '-1', newline);
triangles = split(triangles, newline);
triangles = strtrim(triangles);
triangles = setdiff(triangles, {''});
number_triangles = length(triangles);
for i = 1:number_triangles
    tmp = triangles{i, 1};
    tmp_array = split(tmp, ' ');
    tmp_array = cellfun(@(x) str2num(x) + 1, tmp_array); %#ok<ST2NM>
    triangles{i, 1} = [num2str(tmp_array(1)) ' ' num2str(tmp_array(2)) ' ' num2str(tmp_array(3))];
end
coordinates = erase(char(coordinates), '             ');
coordinates = strrep(coordinates, ',' , newline);
coordinates = split(coordinates, newline);
coordinates = strtrim(coordinates);
coordinates = setdiff(coordinates, {''});
number_coordinates = length(coordinates);

% output
file = strrep(file, '.x3d', '.nv');
nv_file = fopen(file, 'w');
fprintf(nv_file, num2str(number_coordinates));
fprintf(nv_file, newline);
for i = 1:number_coordinates
    fprintf(nv_file, coordinates{i,1});
    fprintf(nv_file, newline);
end
fprintf(nv_file, num2str(number_triangles));
fprintf(nv_file, newline);
for i = 1:number_triangles
    fprintf(nv_file, triangles{i, 1});
    fprintf(nv_file, newline);
end
fclose(nv_file);
end