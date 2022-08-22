% test to plot nifti
clear all;
clc;

data = niftiread('aal.nii');
info = niftiinfo('aal.nii');


for i = 1:length(data)    
    try1 = data;
    try1(try1~=(i)) = 0;
    try1(try1==(i)) = 1;
    sm = smooth3(try1);
    issm = isosurface(sm);
    if ~isempty(issm.faces) && ~isempty(issm.vertices)
        p{i} = trisurf(issm.faces, issm.vertices(:, 1),issm.vertices(:, 2),issm.vertices(:,3));
%         if i == 10
        color = [randi(225)/225 randi(225)/225 randi(225)/225];
        alpha = 1;
%         else
%             color = [1 1 1];
%             alpha = 0.1;
%         end
        set(p{i},'FaceColor', color, 'EdgeAlpha', 0.1);
        msg{i} = ['Sip: ' num2str(i)];
    else
        msg{i} = ['Nope: ' num2str(i)];
    end
    hold on
end
