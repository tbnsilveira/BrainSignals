\NeedsTeXFormat{LaTeX2e}
% Version 1.0 - Copyright Dr. ir. Rein van den Boomgaard (UvA)
% Version 1.1 - Copyright Eng. Marcos C. d'Ornellas (UvA)
% Version 1.2 - Copyright Dr. Eng. Marcos C. d'Ornellas (UFSM)
% Version 1.3 - Copyright Dr. Eng. Marcos C. d'Ornellas (UFSM)
% Version 2.0 - Modificado para uso pessoal por Tiago da Silveira (UFSM)
% Version 2.1 - Modificado para uso pessoal por Tiago da Silveira (UFSM)
\ProvidesClass{ufsmreport}[2009/06/18 Versao 2.1 Tiago da Silveira]
\RequirePackage{graphicx}
\RequirePackage{multicol}

%\DeclareGraphicsExtensions{bmp,eps,wmf,gif}
\newcommand{\UFSM@path}{.}
\newcommand{\UFSM@ufsmlogonovo}{\UFSM@path/ufsm.jpg}

\InputIfFileExists{ufsmreport.cfg}{}{}

\newif\if@email
\@emailfalse
\def\email#1{\@emailtrue\gdef\@email{#1}}

\newif\if@telephone
\@telephonefalse
\def\telephone#1{\@telephonetrue\gdef\@telephone{#1}}

\newif\if@http
\@httpfalse
\def\http#1{\@httptrue\gdef\@http{#1}}

\newif\if@correspondingauthorset
\@correspondingauthorsetfalse
\def\correspondingauthor#1{\@correspondingauthorsettrue\gdef\@correspondingauthor{#1}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass[11pt,a4paper]{report}

%
%	Defining the page size
%
\voffset	-1in
\hoffset	-1in
\topmargin       0mm
\headheight     20mm
\headsep        10mm
\footskip       10mm  
\textheight    240mm
\setlength{\textwidth}{160mm}
\if@twoside
	\oddsidemargin   30mm
	\evensidemargin  20mm
\else
	\oddsidemargin   30mm
	\evensidemargin  30mm
\fi

\renewcommand{\textfraction}{0.2}
\renewcommand{\bottomfraction}{0.8}
\renewcommand{\topfraction}{0.8}
\renewcommand{\floatpagefraction}{0.8}

 \newif\ifthanks 
 \newbox\@kapbox 
 \newcount\@kapcount

 \newtoks\t@a
 \newtoks\t@b
 \long\def\append@item#1\to#2{\t@a={\@k@p{#1}}\t@b=\expandafter{#2}%
   \xdef#2{\the\t@b\the\t@a}}
 \def\get@left#1\to#2{\expandafter\g@l#1\g@l#1#2}
 \long\def\g@l\@k@p#1#2\g@l#3#4{\def#4{#1}\def#3{#2}}

 \def\@authors{}
 \def\@allauthors{}
 \def\@institutes{}
 \def\authors@institute{}

\def\@supervisor{}

 \def\author@#1{\append@item#1\to\@authors
   \append@item#1\to\@allauthors}
 \def\institute@#1{\append@item#1\to\@institutes
   \expandafter\append@item\expandafter{\@authors}\to\authors@institute
   \gdef\@authors{}}

 \let\oneauthor=\author@
 \let\institute=\institute@

 \def\@formatname#1#2{\@kapcount\c@footnote\begingroup
   \def\thanks##1{\global\thankstrue}\setbox\@kapbox\vbox{#1}\endgroup
   \c@footnote\@kapcount
   \begingroup
   \ifthanks
   \def\fn##1\thanks##2{{##1}\hbox
     to 0pt{#2\hss}\thanks{##2}}\expandafter\fn#1
   \else
   \def\fn##1{{##1}#2}\expandafter\fn\expandafter{#1}\fi
   \endgroup\global\thanksfalse}


 \def\@formatauthors{{\small\begingroup
     \newcount\cnt@authors
     \cnt@authors=0\def\@k@p##1{\advance\cnt@authors by 1}\@curauths
     \def\@k@p##1{\advance\cnt@authors by -1
       \ifnum\cnt@authors>1 \hbox{\@formatname{##1}{,}\penalty-1000}\space\fi
       \ifnum\cnt@authors=1 \hbox{\@formatname{##1}{} and\penalty-1000}\space\fi
       \ifnum\cnt@authors<1 \hbox{\@formatname{##1}{}}\par\fi}\@curauths
     \endgroup}}

 \def\@formatinstitute{{\@curinst\par}}

 \newif\if@runningtitleset
 \newif\if@runningauthorset

 \def\runningauthor#1{\if@runningauthorset\else
   \xdef\@runningauthor{{#1}}\fi
   \global\@runningauthorsettrue}
 \gdef\@runningauthor{}

 \def\@formatauthorsandinstitutes{\begingroup
   \newcount\cnt@institutes
   \newcount\cnt@authors
   \newbox\@authbox
   \cnt@authors=0\def\@k@p##1{\advance\cnt@authors by 1}\@allauthors
   \xdef\@authnames{}%
   \begingroup
     \def\thanks##1{}%
     \def\@k@p##1{\advance\cnt@authors by -1
       \ifnum\cnt@authors=0 \xdef\@authnames{\@authnames ##1}\fi
       \ifnum\cnt@authors=1 \xdef\@authnames{##1\ and }\fi
       \ifnum\cnt@authors>1 \xdef\@authnames{##1\ et al.}\cnt@authors=0\fi}%
     \global\setbox\@authbox=\hbox{\@allauthors}%
     \expandafter\runningauthor\expandafter{\@authnames}
   \endgroup
   \cnt@institutes=0
   \def\@k@p##1{\advance\cnt@institutes by 1}\@institutes
   \loop\ifnum\cnt@institutes>0
     \get@left\authors@institute\to\@curauths
     {\normalsize\sffamily\bfseries\noindent\@formatauthors}
     \get@left\@institutes\to\@curinst
     {\normalsize\sffamily\noindent\@formatinstitute}
     \ifnum\cnt@institutes=2
       \vskip 0.4\baselineskip
       %%      and   <<<==== this is ugly
     \fi
     \ifnum\cnt@institutes>1
       \vskip 0.4\baselineskip
     \fi
     \advance\cnt@institutes by -1
   \repeat\endgroup}

\newif\if@subtitle
\@subtitlefalse
\def\subtitle#1{\@subtitletrue\gdef\@subtitle{#1}}

\newif\if@affiliation
\@affiliationfalse
\def\affiliation#1{\@affiliationtrue\gdef\@affiliation{#1}}

\newif\if@status
\@statusfalse
\def\status#1#2{\@statustrue\gdef\@statushead{#1}\gdef\@statustail{#2}}

\newif\if@abstract
\@abstractfalse
\renewcommand{\abstract}[1]{\@abstracttrue\gdef\@abstract{#1}}

\newif\if@acknowledge
\@acknowledgefalse
\newcommand{\acknowledge}[1]{\@acknowledgetrue\gdef\@acknowledge{#1}}

\newif\if@UFSMreport
\@UFSMreportfalse
\newcommand{\UFSMreport}[1]{\@UFSMreporttrue\gdef\@UFSMreport{#1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Headers en Footers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\if@twoside
	\def\ps@ufsmhead{%
		\let\@oddfoot\@empty
		\let\@evenfoot\@empty
   		\def\@evenhead{%
			\parbox{\textwidth}{\sffamily\thepage\hfill\leftmark\\ 
			\rule[1.5ex]{\textwidth}{1pt}}}
		\def\@oddhead{%
			\parbox{\textwidth}{\sffamily\rightmark\hfill\thepage\\
			\rule[1.5ex]{\textwidth}{1pt}}}
		\let\@mkboth\markboth
		\def\sectionmark##1{%
			\markboth{\@runningauthor}{%
			\ifnum \c@secnumdepth >\m@ne
				Se\c{c}\~{a}o \thesection\hskip 1em\relax
			\fi
			##1}}}%
\else
	\def\ps@ufsmhead{%
		\let\@oddfoot\@empty
		\def\@oddhead\parbox{\textwidth{\sffamily\rightmark\hfill\thepage\\
			\rule[1.5ex]{\textwidth}{1pt}}}%
		\let\@mkboth\markboth
		\def\sectionmark##1{%
			\markright {%
			\ifnum \c@secnumdepth >\m@ne
				Section \thesection\hskip 1em\relax
			\fi
			##1}}}
\fi
\pagestyle{ufsmhead}  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Set secnumdepth and tocdepth to 5, allowing numbering to paragraph and
%% subparagraph [Marcos C. d'Ornellas  -  UvA 09/09/98]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{5}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Sans Serif Font for Sections
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\section}{\@startsection {section}{1}{\z@}%
	{-3.5ex \@plus -1ex \@minus -.2ex}%
	{2.3ex \@plus.2ex}%
	{\reset@font\Large\bfseries\sffamily}}

\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
	{-3.25ex\@plus -1ex \@minus -.2ex}%
	{1.5ex \@plus .2ex}%
	{\reset@font\large\bfseries\sffamily}}

\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
	{-3.25ex\@plus -1ex \@minus -.2ex}%
	{1.5ex \@plus .2ex}%
	{\reset@font\normalsize\bfseries\sffamily}}

\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
	{3.25ex \@plus1ex \@minus.2ex}%
	{-1em}%
	{\reset@font\normalsize\bfseries}}

\renewcommand{\subparagraph}{\@startsection{subparagraph}{5}{\parindent}%
	{3.25ex \@plus1ex \@minus .2ex}%
	{-1em}%
	{\reset@font\normalsize\bfseries}}
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Front Cover Page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlength{\UFSM@vup}	\setlength{\UFSM@vup}{3cm}
\newlength{\UFSM@vdown}	\setlength{\UFSM@vdown}{2cm}
\newlength{\UFSM@tph}	\setlength{\UFSM@tph}{\textheight}
\addtolength{\UFSM@tph}{\UFSM@vup}
\addtolength{\UFSM@tph}{\UFSM@vdown}
\addtolength{\UFSM@tph}{-1cm}
\newlength{\UFSM@hleft}	\setlength{\UFSM@hleft}{3cm}
\newlength{\UFSM@tpw}	\setlength{\UFSM@tpw}{\textwidth}
\addtolength{\UFSM@tpw}{\UFSM@hleft}
\addtolength{\UFSM@tpw}{-.5cm}

\newlength{\UFSM@vbannerwidth}	\setlength{\UFSM@vbannerwidth}{3cm}
\newlength{\UFSM@tpew}	\setlength{\UFSM@tpew}{\UFSM@tpw}
\addtolength{\UFSM@tpew}{-\UFSM@vbannerwidth}
\addtolength{\UFSM@tpew}{-17mm}

\renewcommand{\maketitle}{%
	%
	%	Outside cover page
	%
	\thispagestyle{empty}%

	%Capa baseada no modelo de Tiago Weber, adaptada por Grasiela Pecinni.
	\begin{center}

% Upper part of the page
\textsc{\LARGE Universidade Federal de Santa Maria}\\[0.6cm]
\textsc{\LARGE Programa de Pós-Graduação em Informática}\\[1.7cm]
\includegraphics[scale=0.4]{\UFSM@ufsmlogonovo}\\[1.7cm]

\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}

\HRule \\[0.4cm]
{ \huge \bfseries \@title}\\[0.25cm]
\
{\Large \bfseries \@subtitle} \\[0.4cm]

\HRule \\[3cm]

% Author and supervisor
\begin{center}
\begin{minipage}{\textwidth}

\begin{center}
\emph{\Large \bfseries Aluno: Tiago da Silveira, Eng.}\\[1.0cm] 
\end{center}

\begin{center}
\emph{\Large \bfseries Orientador: Alice Kozakevicius, Dra.}\\[1.0cm] 
\end{center}

\begin{center}
\emph{\Large \bfseries Coorientador: Cesar Rodrigues, Dr.}\\[1.0cm] 
\end{center}

%\begin{center}
%\emph{Aluno: \@author}\\[0.75cm] 
%\end{center}
%
%\begin{center}
%%\emph{Professor: \professor}
%\emph{Orientador: Alice Kozakevicius}
%\end{center}

\end{minipage}
\end{center}
\vfill

% Bottom of the page
%{\large \@date}
{\large \@statustail}
%\end{center}
\end{center}

	%
	%	Inside cover page
	%
	\newpage
	\let\UFSM@tempevenhead\@evenhead
	\def\@evenhead{%
		\parbox{\textwidth}{\sffamily\@title\hfill\leftmark\\ 
		\rule[1.5ex]{\textwidth}{1pt}}}
	\enlargethispage{\UFSM@vdown}
	%\vspace*{-\UFSM@vup}
	\tableofcontents
	\vspace*{\fill}

	\setcounter{page}\z@
	\newpage
	\let\@evenhead\UFSM@tempevenhead
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@maketitle{%
	{\LARGE\sffamily\bfseries \noindent\@title\\[.5ex]}
	\if@subtitle{\Large\sffamily\bfseries\noindent\@subtitle}\fi
	\hspace{0pt}\\[2.5em]
	\@formatauthorsandinstitutes
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  {\sffamily\bfseries\small #1:}\hspace{.5em}#2
  \vskip\belowcaptionskip}