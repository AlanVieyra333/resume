%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ATS-friendly Software Engineer Resume class
%
% Single column, no graphics/sidebars/tables-as-layout, standard fonts,
% real selectable text only -- designed to parse cleanly through
% Applicant Tracking Systems while remaining readable to humans.
%
% License: MIT (see included LICENSE file)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{style}[2026/01/01 ATS-friendly Software Engineer Resume class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
% `design` opts into the two-column recruiter-facing layout defined in
% styledesign.tex. It is deliberately NOT forwarded to article.
\newif\ifdesign
\designfalse
\DeclareOption{design}{\designtrue}
\ProcessOptions\relax
\LoadClass[10pt]{article}

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}

\ifdesign
	% The designed layout paints a sidebar panel beside the text block, so the
	% text block is positioned as the MAIN column instead of as the full page.
	% Geometry keeps both margins as explicit lengths because styledesign.tex
	% needs to know where the text block starts to land the header in the band.
	\RequirePackage{graphicx}
	\RequirePackage{tikz}
	\RequirePackage{microtype}
	\RequirePackage{fontawesome5}
	\RequirePackage[left=7.71cm,right=1.6cm,top=1.1cm,bottom=1.0cm,nohead,nofoot]{geometry}
\else
	\RequirePackage[left=1.8cm,right=1.8cm,top=1.3cm,bottom=1.3cm,nohead,nofoot]{geometry}
	% Column wrappers are no-ops in the ATS layout: the content files carry the
	% same \sidecol/\maincol markers for the designed layout and these make
	% those files compile -- and print -- unchanged here.
	\newcommand{\sidecol}[1]{#1}
	\newcommand{\maincol}[1]{#1}
	\newcommand{\resumesummaryheading}[1]{}
	\newcommand{\designinput}[1]{\input{#1}}
\fi
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{needspace}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage{ifthen}
\RequirePackage[colorlinks=true, linkcolor=headingcolor, urlcolor=headingcolor, citecolor=headingcolor]{hyperref}

%----------------------------------------------------------------------------------------
%	COLOURS (subtle -- print/greyscale/ATS safe, text remains pure black-on-white in essence)
%----------------------------------------------------------------------------------------

\definecolor{headingcolor}{HTML}{1A3A5C}
\definecolor{bodygray}{HTML}{1A1A1A}

\color{bodygray}
\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\emergencystretch}{2em}
% Leading opened from 1.06 after the 2026-10 editorial pass trimmed body copy:
% the shorter blocks left a visible band of white at the foot of page 2, and a
% slightly looser leading absorbs it while improving readability. Font size,
% margins and colours are deliberately unchanged -- ATS parsing depends on
% plain selectable text, not on these values.
%
% Kept at 1.09, not the 1.12 first tried: Spanish runs ~20% longer than English,
% and at 1.12 both Spanish profiles spilled the Awards row onto a third page.
% 1.09 plus the wider \itemsep absorbs the white space and holds all six
% profiles at two pages.
\ifdesign
	% The designed layout sets its own leading: its measure is narrower, so it
	% runs looser than the ATS column rather than tighter.
	\linespread{1.06}
\else
\linespread{1.09}
\fi

%----------------------------------------------------------------------------------------
%	SECTION HEADINGS
%----------------------------------------------------------------------------------------

\setcounter{secnumdepth}{0}

\titleformat{\section}
	{\large\bfseries\color{headingcolor}}
	{}{0em}{}
	[\vspace{-7pt}{\color{headingcolor}\rule{\linewidth}{0.9pt}}]
\titlespacing*{\section}{0pt}{11pt}{5pt}

%----------------------------------------------------------------------------------------
%	LISTS
%----------------------------------------------------------------------------------------

\setlist[itemize]{leftmargin=1.2em, itemsep=2pt, topsep=1pt, parsep=0pt, partopsep=0pt}
\AtEndEnvironment{itemize}{\vspace{5pt}}

%----------------------------------------------------------------------------------------
%	HEADER / CONTACT COMMANDS
%----------------------------------------------------------------------------------------

% Personal-data setters. Each stores its value in a plain, NON-argument macro
% (`...value`) instead of redefining itself.
%
% The old self-redefining form cannot be used here: the designed layout
% typesets the content file TWICE (a harvest pass that collects the sidebar,
% then a typeset pass -- see styles/styledesign.tex). A self-redefining macro
% takes an argument only until its first call, so on the second pass
% `\resumesummary{X}` would expand the macro (typesetting the OLD summary) and
% then treat `{X}` as a stray group -- printing the text twice. Storing into
% a fixed zero-argument macro makes the setters idempotent, and lets the
% values be passed through expanding contexts like \MakeUppercase or
% microtype's \textls safely.
%
% Call them as `\resumeaddress{...}`; do NOT use \renewcommand on them.
\newcommand{\resumename}[1]{\def\resumenamevalue{#1}}
\newcommand{\resumejobtitle}[1]{\def\resumejobtitlevalue{#1}}
\newcommand{\resumeaddress}[1]{\def\resumeaddressvalue{#1}}
\newcommand{\resumenumberphone}[1]{\def\resumenumberphonevalue{#1}}
\newcommand{\resumemail}[1]{\def\resumemailvalue{#1}}
\newcommand{\resumelinkedin}[1]{\def\resumelinkedinvalue{#1}}
\newcommand{\resumegithub}[1]{\def\resumegithubvalue{#1}}
\newcommand{\resumesummary}[1]{\def\resumesummaryvalue{#1}}

\def\resumenamevalue{}
\def\resumejobtitlevalue{}
\def\resumeaddressvalue{}
\def\resumenumberphonevalue{}
\def\resumemailvalue{}
\def\resumelinkedinvalue{}
\def\resumegithubvalue{}
\def\resumesummaryvalue{}

% Prints the header block: name, job title, one-line plain-text contact
% line, and an optional professional summary paragraph.
\newcommand{\makeheader}{%
	\begin{center}
		{\fontsize{22}{24}\selectfont\bfseries\color{headingcolor}\resumenamevalue}\\[3pt]
		{\large\resumejobtitlevalue}\\[6pt]
		{\small
			\mbox{\resumeaddressvalue}~\textbar~\mbox{\resumenumberphonevalue}~\textbar~\mbox{\href{mailto:\resumemailvalue}{\resumemailvalue}}%
			\\[3pt]
			\ifthenelse{\equal{\resumelinkedinvalue}{}}{}{\mbox{\href{https://\resumelinkedinvalue}{\resumelinkedinvalue}}}%
			\ifthenelse{\equal{\resumegithubvalue}{}}{}{~\textbar~\mbox{\href{https://\resumegithubvalue}{\resumegithubvalue}}}%
		}
	\end{center}
	\ifthenelse{\equal{\resumesummaryvalue}{}}{}{%
		\vspace{8pt}
		\resumesummaryvalue
	}
	\vspace{-4pt}
}

%----------------------------------------------------------------------------------------
%	ENTRY BLOCK (used for both Experience and Education)
%	#1 Primary heading (role / institution) -- bold
%	#2 Secondary heading (organization / degree) -- italic
%	#3 Dates -- right aligned
%	#4 Location -- right aligned
%----------------------------------------------------------------------------------------

\newcommand{\resumeentry}[4]{%
	\Needspace{6\baselineskip}%
	\noindent\begin{tabularx}{\linewidth}{@{}>{\raggedright\arraybackslash}X r@{}}
		\textbf{#1} & \textbf{\small #3}\\
		\textit{#2} & \textit{\small #4}\\
	\end{tabularx}\par\vspace{3pt}%
}

%----------------------------------------------------------------------------------------
%	SKILL ROW -- plain text "Category: item, item, item" (no graphical bars)
%----------------------------------------------------------------------------------------

\newcommand{\skillrow}[2]{\textbf{#1:} #2\par\vspace{2pt}}

%----------------------------------------------------------------------------------------
%	MARGINS AND LINKS
%----------------------------------------------------------------------------------------

\urlstyle{same}

%----------------------------------------------------------------------------------------
%	DESIGNED LAYOUT (opt-in)
%
%	Loaded last so it can redefine \makeheader, \resumeentry, \skillrow and the
%	titlesec rules, and can own the geometry-dependent lengths it needs. With
%	the `design` option absent, none of this is read.
%----------------------------------------------------------------------------------------

\ifdesign
	% Lives in styles/ rather than the repo root on purpose: latexmk resolves
	% the source file by globbing *.tex in the root, and a second one there
	% makes it refuse to build.
	\input{styles/styledesign.tex}
\fi
