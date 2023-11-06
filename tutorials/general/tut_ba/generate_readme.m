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
pattern = '\\fig\{[^}]+\}\s*\{([^}]+)\}\s*\{(?:\s*\[h!\]\s*)?(?:\s*\[b!\]\s*)?\\includegraphics(?:\[height=10cm\])?\{([^{}]*)}(?:\s*)?\}\s*\{([^{}]*)\}';
findings = regexp(document, pattern, 'tokens', 'all');
for i = 1:length(findings)
    finding = findings{i};
    document = regexprep(document, pattern, ['![' finding{3} '](' finding{2} ') \n '], 'once');
    document = regexprep(document, '{\\bf ([a-z])}', '**$1**');
end

pattern = '\(([^()]*)\)\s*\{\s*([^{}]*)\}';
findings = regexp(document, pattern, 'tokens', 'all');
for i = 1:length(findings)
    finding = findings{i};
    document = regexprep(document, pattern, ['(' finding{1} ') \n ' finding{2} '\n' ], 'once');
end

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

readme
