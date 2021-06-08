function token = getGUIToken(txt, ignore)


    for j = 1:1:length(splits)
        split_tmp = splits{j};
        if regexp(split_tmp, '(?<==)(.*)(?=;)')
            [i, f] = regexp(split_tmp, '(?<==)(.*)(?=;)');
            token_tmp = deblank(split_tmp(i+1:f)); 
            if ~isequal(token_tmp, ignore) || ~exists(ignore)
                token = token_tmp;
                break;
            end            
        end
    end
end