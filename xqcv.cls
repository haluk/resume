%----------------------------------------------------------------------------------------
% 
% LaTeX CV class: xqcv 
% author: Xian Qiu
% version: beta 0
%
% Note: 1. do not use \subsubsection.
%       2. itemized lists should not be more than two levels
%       3. publications must be compiled by biber.
%
% any problem? do not ask me. 
%
%----------------------------------------------------------------------------------------


\ProvidesClass{xqcv}[2013/08/28 CV class]
\NeedsTeXFormat{LaTeX2e}

%----------------------------------------------------------------------------------------
% proccessing options
%----------------------------------------------------------------------------------------

\DeclareOption{print}{\def\@print{}}
\DeclareOption{showupdate}{\newcommand\@showupdate{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\PassOptionsToClass{12pt}{article}%
\ProcessOptions\relax
\LoadClass{article}

%----------------------------------------------------------------------------------------
% loading packages
%----------------------------------------------------------------------------------------

\RequirePackage{xcolor}
\RequirePackage{hyperref}
\RequirePackage{ifthen}
\RequirePackage{parskip}
\RequirePackage{enumitem}
\RequirePackage{marvosym,eurosym,pifont} % symbols
% layout
\RequirePackage[left=1.5cm,top=2cm,right=1.5cm,bottom=2.5cm,nohead,nofoot]{geometry}                                          
\RequirePackage{tikz}
\RequirePackage{parcolumns}
\RequirePackage{tabularx}

%----------------------------------------------------------------------------------------
% colors
%----------------------------------------------------------------------------------------


\definecolor{white}{RGB}{255,255,255}
\definecolor{black}{RGB}{0,0,0}
\definecolor{gray}{RGB}{90,90,90}
\definecolor{orange}{RGB}{242,101,34}
\definecolor{red}{RGB}{153,40,42}
\definecolor{green}{RGB}{0,114,54}
\definecolor{blue}{RGB}{66,69,206}

\definecolor{lightwhite}{RGB}{225,225,225}
\definecolor{lightblack}{RGB}{50,50,50}
\definecolor{lightorange}{RGB}{253,198,137}
\definecolor{lightgray}{RGB}{150,150,150}

\colorlet{c@fillheader}{gray}
\colorlet{c@firstname}{white}
\colorlet{c@lastname}{white}
\definecolor{c@contacttext}{RGB}{255,128,40}
\colorlet{c@header}{white}
\colorlet{c@contact}{lightwhite}
\colorlet{c@headerlogo}{lightwhite}
\colorlet{c@section}{blue}
\colorlet{c@subsection}{orange}

% print option
\ifdefined\@print
  \colorlet{c@fillheader}{white}
  \colorlet{c@firstname}{black}
	\colorlet{c@lastname}{black}
	\definecolor{c@contacttext}{RGB}{255,128,40}
	\colorlet{c@header}{black}
	\colorlet{c@contact}{lightblack}
	\colorlet{c@headerlogo}{lightblack}
\fi

%----------------------------------------------------------------------------------------
% font
%----------------------------------------------------------------------------------------

\RequirePackage{helvet}
\RequirePackage[T1]{fontenc}
%set default font
\renewcommand{\sfdefault}{phv}
\renewcommand{\familydefault}{\sfdefault}

\newcommand{\namefont}[2]{\fontsize{30pt}{42pt}
                               \color{#2}
                               \fontfamily{phv}
                               %\fontseries{bc} %bold
                               \selectfont #1}
                               
\newcommand{\headerfont}[2]{\fontsize{12pt}{16pt}
                            \color{#2}
                            \fontfamily{phv}
                            \selectfont \parbox{8cm}{\center #1}}

\newcommand{\contactfont}[2]{\fontsize{12pt}{16pt}
                            \color{#2}
                            \fontfamily{phv}
                            \selectfont \parbox{10cm}{#1}}
                            
\newcommand{\sectionfont}[2]{\fontsize{16pt}{24pt}
                            \color{#2}
                            \fontfamily{phv}
                            \selectfont #1}
\newcommand{\subsectionfont}[2]{\fontsize{12pt}{18pt}
                            \color{#2}
                            \fontfamily{phv}
                            \selectfont #1}        

\renewcommand{\normalfont}{\fontsize{12pt}{18pt}
                            \color{lightblack}
                            \fontfamily{phv}
                            \selectfont}

%----------------------------------------------------------------------------------------
% header
%----------------------------------------------------------------------------------------

\newcommand{\headerboxheight}[1]{\newcommand\@headerboxheight{#1}}

\newcommand{\name}[2]{\newcommand\@firstname{#1}
                      \newcommand\@lastname{#2}}


\newcommand{\currentposition}[1]{\newcommand\@currentposition{#1}}

\newcommand{\address}[1]{\newcommand\@address{#1}}
\newcommand{\phonenumber}[1]{\newcommand\@phonenumber{#1}}
\newcommand{\email}[1]{\newcommand\@email{#1}}
\newcommand{\homepage}[1]{\newcommand\@homepage{#1}}
                                                         
\renewcommand{\maketitle}{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=c@fillheader, anchor=north, minimum width=\paperwidth, minimum height= \@headerboxheight] (box) at (current page.north){};
    %-------------------------------------------------------------------
    % left part of the header
    %------------------------------------------------------------------
    % name and current position
    \node [anchor = center, shift = {(-6.5,0)}] (name) at (box) {
      \namefont{\@firstname}{c@firstname}
      \hspace*{-20pt}
      \namefont{\@lastname}{c@lastname}
    };
    \ifdefined\@currentposition
      \node [anchor = north, shift = {(0,-0.5)}] (currentposition) at (name.south) {%
        \headerfont{\@currentposition}{c@header}
      };
      \else
      \node[shift = {(0,-0.5)}] (currentposition) at (name.south) {};
    \fi
    
    \ifdefined\@showupdate
      \node[shift = {(0,-0.5)}] (update) at (currentposition.south) {\headerfont{\today}{white}};
    \fi
    %------------------------------------------------------------------
    % vertical rule
    %------------------------------------------------------------------
    
    \draw[lightgray, transform canvas={xshift=-2cm}] (box.north) -- (box.south);
    
    
    %------------------------------------------------------------------
    % contact info
    %------------------------------------------------------------------
    % contact
    \node [anchor = south east, shift = {(1.5,0.7)}] at (box.center) {%
        \sectionfont{Contact}{c@contacttext}
      };
    % address  
    \ifdefined\@address
      \node[anchor = north west, shift = {(1.5,0.6)}] (address) at (box.center) {%
        \contactfont{\@address}{c@contact}
      };
      % logo
      \node[anchor = north east, shift = {(1.6,0.6)}, c@headerlogo] at (box.center) {%
        \Large{\Letter}
      };
      \else
        \node[shift = {(6.7,0.6)}] (address) at (box.center) {};
    \fi
    % phone number
    \ifdefined\@phonenumber
      \node[shift = {(0,-0.3)}] (phonenumber) at (address.south) {%
        \contactfont{\@phonenumber}{c@contact}
      };
      % logo
      \node[shift = {(-0.3,0.05)}, c@headerlogo] at (phonenumber.west) {%
        \Large{\Telefon}
      };
      \else
        \node[shift = {(0,0.1)}] (phonenumber) at (address.south) {};
    \fi
    % email
    \ifdefined\@email
      \node[shift = {(0,-0.3)}] (email) at (phonenumber.south) {%
        \contactfont{\@email}{c@contact}
      };
      % logo
      \node[shift = {(-0.3,0.05)}, c@headerlogo] at (email.west) {%
        \Large{\MVAt}
      };
      \else
        \node[shift = {(0,0.1)}] (email) at (phonenumber.south) {};
    \fi
    % homepage
    \ifdefined\@homepage
      \node[shift = {(0,-0.3)}] (homepage) at (email.south) {%
        \contactfont{\@homepage}{c@contact}
      };
      % logo
      \node[shift = {(-0.3,0.05)}, c@headerlogo] at (homepage.west) {%
        \Large{\Mundus}
      };
      \else
        \node[shift = {(0,0.1)}] (homepage) at (email.south) {};
    \fi
  \end{tikzpicture}
  \vspace{\@headerboxheight}
  \vspace{-1cm}
}


%----------------------------------------------------------------------------------------
% sections
%----------------------------------------------------------------------------------------

\renewcommand{\section}[1]{
  \pdfbookmark[0]{#1}{#1}
  \par\vspace{\parskip}{  
    \begin{tikzpicture}
      \draw[c@section, line width = 1.5pt] (0,0) -- (\textwidth,0);
      \node[anchor = west,fill = c@section, rectangle] (section) at (0,0) {\sectionfont{#1}{white}};
    \end{tikzpicture}
  }
  \par\vspace{0.5\parskip}
}

\renewcommand{\subsection}[1]{
  \pdfbookmark[1]{#1}{#1}
  \par\vspace{.5\parskip}%
  \begin{tikzpicture}[inner sep = 2pt]
     \draw[c@subsection] (0,0) -- (\textwidth-1,0);
     \node[anchor = east, fill = c@subsection, rectangle] (subsection) at (\textwidth,0)                 
       {\subsectionfont{#1}{white}};
  \end{tikzpicture}
  \par\vspace{.25\parskip}%
}

\pagestyle{empty}


%----------------------------------------------------------------------------------------
% List environment
%----------------------------------------------------------------------------------------
\RequirePackage{longtable}
\setlength{\tabcolsep}{0pt}
\setlength\LTleft{0pt}
\setlength\LTright{0pt}
\newenvironment{entrylist}{%
  \normalfont
  \begin{longtable}{@{\extracolsep{\fill}}ll}
}{%
  \end{longtable}
}

\newcommand{\entry}[4]{%
  #1&\parbox[t]{16cm}{%
    #2
    \hfill%
    {\small\color{gray} #3}
    \ifx #4 % if #4 is empty
      \else
      \\[0.5ex]
      \small #4\vspace{\parsep}
    \fi
  }\\
}


\newcommand{\hentry}[4]{
\begin{minipage}{16cm}
\begin{tabular}{p{5cm}p{11cm}}
#1&#2\\
&\footnotesize{#3} \\
&\footnotesize{#4}
\end{tabular}
\end{minipage}
\\
}

\newcommand{\lentry}[2]{%
    #1&\parbox[t]{13cm}{%
    #2}\\
}
\newcommand{\rtext}[1]{{\hfill\small\color{gray}#1}}

% itemize
\renewcommand{\labelitemi}{\ding{47}}
\renewcommand{\labelitemii}{\ding{49}}

%----------------------------------------------------------------------------------------
% Bibliography 
%----------------------------------------------------------------------------------------

\usepackage[sorting=ydnt,bibstyle=numeric,labelyear=false,defernumbers=true,maxnames=20,firstinits=true,uniquename=init]{biblatex}
\DeclareFieldFormat{url}{\url{#1}}
\DeclareFieldFormat[article]{pages}{#1}
\DeclareFieldFormat[inproceedings]{pages}{\lowercase{pp.}#1}
\DeclareFieldFormat[incollection]{pages}{\lowercase{pp.}#1}
\DeclareFieldFormat[article]{volume}{\textbf{#1}}
\DeclareFieldFormat[article]{number}{(#1)}
\DeclareFieldFormat[article]{title}{\MakeCapital{#1}}
\DeclareFieldFormat[inproceedings]{title}{#1}
\DeclareFieldFormat{shorthandwidth}{#1}

% Don't use "In:" in bibliography. Omit urls from journal articles.
\DeclareBibliographyDriver{article}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/editor}%
  \setunit{\labelnamepunct}\newblock
  \MakeSentenceCase{\usebibmacro{title}}%
  \newunit
  \printlist{language}%
  \newunit\newblock
  \usebibmacro{byauthor}%
  \newunit\newblock
  \usebibmacro{byeditor+others}%
  \newunit\newblock
  \printfield{version}%
  \newunit\newblock
%  \usebibmacro{in:}%
  \usebibmacro{journal+issuetitle}%
  \newunit\newblock
  \printfield{note}%
  \setunit{\bibpagespunct}%
  \printfield{pages}
  \newunit\newblock
  \usebibmacro{eprint}
  \newunit\newblock
  \printfield{addendum}%
  \newunit\newblock
  \usebibmacro{pageref}%
  \usebibmacro{finentry}}

% Remove dot between volume and number in journal articles.
\renewbibmacro*{journal+issuetitle}{%
  \usebibmacro{journal}%
  \setunit*{\addspace}%
  \iffieldundef{series}
    {}
    {\newunit
     \printfield{series}%
     \setunit{\addspace}}%
  \printfield{volume}%
%  \setunit*{\adddot}%
  \printfield{number}%
  \setunit{\addcomma\space}%
  \printfield{eid}%
  \setunit{\addspace}%
  \usebibmacro{issue+date}%
  \newunit\newblock
  \usebibmacro{issue}%
  \newunit}


% Bibliography categories
\def\makebibcategory#1#2{\DeclareBibliographyCategory{#1}\defbibheading{#1}{\subsection{#2}}}
\makebibcategory{books}{Books}
\makebibcategory{papers}{Journal papers}
\makebibcategory{chapters}{Book chapters}
\makebibcategory{proceedings}{Conference papers}
\makebibcategory{reports}{Reports}
\makebibcategory{workingpapers}{Working papers}
\setlength{\bibitemsep}{2.65pt}
\setlength{\bibhang}{.8cm}
\renewcommand{\bibfont}{\small}

\renewcommand*{\bibitem}{\addtocounter{papers}{1}\item \mbox{}\hskip-0.85cm\hbox to 0.85cm{\hfill\arabic{papers}.~~}}
\defbibenvironment{bibliography}
{\list{}
  {\setlength{\leftmargin}{\bibhang}%
   \setlength{\itemsep}{\bibitemsep}%
   \setlength{\parsep}{\bibparsep}}}
{\endlist}
{\bibitem}

\newenvironment{publications}{\section{\LARGE Publications}\label{papersstart}\vspace*{0.2cm}\small
\titlespacing{\section}{0pt}{1.5ex}{1ex}\itemsep=0.00cm
}{\label{papersend}\addtocounter{sumpapers}{-1}\refstepcounter{sumpapers}\label{sumpapers}}

\def\printbib#1{\printbibliography[category=#1,heading=#1]\lastref{sumpapers}}

% Counters for keeping track of papers
\newcounter{papers}\setcounter{papers}{0}
\newcounter{sumpapers}\setcounter{sumpapers}{0}
\def\lastref#1{\addtocounter{#1}{\value{papers}}\setcounter{papers}{0}}
\nocite{*}
