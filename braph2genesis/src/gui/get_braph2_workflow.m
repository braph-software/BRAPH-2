function var = get_braph2_workflow(file, section)

if ~isfile(file)
    return;
end

txt = fileread(file);
token_tmp = getToken(txt, section);
tokens = getGUIToken(token_tmp);

for i = 1:length(tokens)
    token = tokens{i};
    if ~isempty(token) && i == 1
        section_obj = eval(token);
    elseif ~isempty(token) && exists(section_obj)
        v = eval([section_obj]);
    end
end

end