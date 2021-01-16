function token = getToken(txt, h1, varargin)
% GETTOKEN extract a token from a text.
%
% TOKEN = GETTOKEN(TXT, H1) extracts from text TXT the token 
% %% ¡H1!
% TOKEN
%
% TOKEN = GETTOKEN(TXT, H1, H2) extracts from text TXT the token 
% %% ¡H1!
% ...
% %%% ¡H2!
% TOKEN
%
% TOKEN = GETTOKEN(TXT, H1, H2, H3, ...) extracts from text TXT the token
% corresponding to the headings H1, H2, H3, ...
%
% See also getTokens, create_Element, create_test_Element.

if isempty(varargin)
    splits = regexp(txt, ['(^|' newline() ')%%\s*¡'], 'split');
    split = '';
    for j = 1:1:length(splits)
        split_tmp = splits{j};
        if regexp(split_tmp, ['^' h1 '!'])
            split = split_tmp;
            break
        end
    end
    [~, final_index] = regexp(split, [h1 '!(\s*)']);
    split = regexprep(split, '%%%\s*¡', '%% ¡');
    token = deblank(split(final_index+1:end));
else
    txt = getToken(txt, h1);
    token = getToken(txt, varargin{:});
end

end