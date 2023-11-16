clear all, clc

tex_file = 'tut_ba.tex';

tex = fileread(tex_file);

%% Analysis

% title
title = regexp(tex, '\\title{([^{}]*)}', 'tokens', 'once'); 
title = strtrim(title{1});

% document
document = regexp(tex, '\\begin{document}(.*)\\end{document}', 'tokens', 'once');
document = document{1};
document = regexprep(document, '\\maketitle', '');
document = regexprep(document, '\\noindent', '');
document = regexprep(document, '\\tableofcontents', '');
document = regexprep(document, '\\clearpage', '');
document = regexprep(document, '\\end\{abstract\}', '');
document = strtrim(document);

% basic reformatting
document = regexprep(document, 'BRAPH~2.0', 'BRAPH 2.0');
document = regexprep(document, '---', '-');
document = regexprep(document, '\\\\\n', '\n');

% (sub)section
document = regexprep(document, '\\section{([^{}]*)}', '## $1');
document = regexprep(document, '\\subsection{([^{}]*)}', '### $1');
document = regexprep(document, '\\subsubsection{([^{}]*)}', '#### $1');

% figures
document = regexprep(document, '{\\bf ([a-z])}', '**$1**');
pattern = '\\fig\{[^}]+\}\s*\{([^}]+)\}\s*\{(?:\s*\[h!\]\s*)?(?:\s*\[b!\]\s*)?\\includegraphics(?:\[height=10cm\])?\{([^{}]*)}(?:\s*)?\}\s*\{([^{}]*)\}';
findings = regexp(document, pattern, 'tokens', 'all');
for i = 1:length(findings)
    finding = findings{i};
    document = regexprep(document, pattern, ['![' finding{3} '](' finding{2} ')'], 'once');    
end

pattern = '\(([^()]*)\)\s*\{\s*([^{}]*)';
findings = regexp(document, pattern, 'tokens', 'all');
for i = 1:length(findings)
    finding = findings{i};
    document = regexprep(document, pattern, ['(' finding{1} ') \n \> ' strtrim(finding{2}) ], 'once');
end

% itemize
document = regexprep(document, '\\begin\{itemize\}', '');
document = regexprep(document, '\\end\{itemize\}', '');
pattern = '\\item\s+([^\\]*)';
findings = regexp(document, pattern, 'tokens', 'all');
for i = 1:length(findings)
    finding = findings{i};
    document = regexprep(document, pattern, ['- ' finding{1}], 'once');
end

% tcolorbox
tmp_listbox = regexp(document, '\\begin{tcolorbox}(.*)\\end{tcolorbox}', 'tokens', 'all'); % hold it
index_list = regexp(document, '\\begin{tcolorbox}(.*)\\end{tcolorbox}', 'all');
document = regexprep(document, '\\begin{tcolorbox}(.*)\\end{tcolorbox}', ''); % remove it
pattern = '\[\s*title=([^=\]]*)\]([^\]\\]*)(.*)\}';
pattern2 = '\}..\]..([^\]\\]*)\\';
for i = 1:length(tmp_listbox)
    % get sections
    tmp_finding = regexp(tmp_listbox{i}, pattern, 'tokens', 'once');

    % get code
    section_code = regexp(tmp_listbox{i}, pattern2, 'tokens', 'once');
    section_title =  ['> **' tmp_finding{1}{1} '**'];
    section_explanation = ['> ' tmp_finding{1}{2}];
    % insert into document
    document = insertBefore(document, index_list(i),  section_title);
    document = insertBefore(document, index_list(i)+length(section_title),  section_explanation);
    document = insertBefore(document, index_list(i)+length(section_title)+length(section_explanation),  section_code{1});
end

document = regexprep(document, '\.\s*\}', '');
document = regexprep(document, '\\code\{([^=\}]*)\}', '"$1"');

% txt or xls
document = regexprep(document, '\(\\fn\{\*\.txt\}\)', '(.txt)');
document = regexprep(document, '\(\\fn\{\*\.xls\}\)', '(.xls)');
document = regexprep(document, '\(\\fn\{\*\.xlsx\}\)', '(.xlsx)');
document = regexprep(document, '\(\\fn\{..xls\} or \\fn\{..xlsx\}\)', '(.xls or .xlsx)');

% web
document = regexprep(document, '\(\\url\{.*\}\)', '');

% references
document = regexprep(document, '\$([^\$\^]*)\^\{(?:\^\{)?\\rm\s*([^\s*\}]*)\}\$', '$1 $2');
document = regexprep(document, '\\Figref\{fig:([^:\}]*)\}', 'Figure $1');
document = regexprep(document, '\\fn\{([^\{\}]*)\}', '"$1"');
document = regexprep(document, '\{([^\{\}]*)\}', '"$1"');

% extra
document = regexprep(document, '\s*\\', '');
document = strtrim(document);

%% Generate README file
readme = [
    '# ' title newline() ...
    newline() ...
    '[![Tutorial ' title '](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](' tex_file(1:end-4) '.pdf)' newline() ...
    newline()
    ];

readme = [readme ...
    document
    ];


%% Save readme
writelines(readme, 'test_readme.md')

% % trick to remove white space
% text = readlines('test_readme.md');
% output = cellfun(@(x) strtrim(x), text);
% writelines(output, 'test_readme.md');

