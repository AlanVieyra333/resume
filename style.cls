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
\ProcessOptions\relax
\LoadClass[10pt]{article}

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}

\RequirePackage[left=1.8cm,right=1.8cm,top=1.3cm,bottom=1.3cm,nohead,nofoot]{geometry}
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
\linespread{1.09}

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

\newcommand{\resumename}[1]{\renewcommand{\resumename}{#1}}
\newcommand{\resumejobtitle}[1]{\renewcommand{\resumejobtitle}{#1}}
\newcommand{\resumeaddress}[1]{\renewcommand{\resumeaddress}{#1}}
\newcommand{\resumenumberphone}[1]{\renewcommand{\resumenumberphone}{#1}}
\newcommand{\resumemail}[1]{\renewcommand{\resumemail}{#1}}
\newcommand{\resumelinkedin}[1]{\renewcommand{\resumelinkedin}{#1}}
\newcommand{\resumegithub}[1]{\renewcommand{\resumegithub}{#1}}
\newcommand{\resumesummary}[1]{\renewcommand{\resumesummary}{#1}}

% Prints the header block: name, job title, one-line plain-text contact
% line, and an optional professional summary paragraph.
\newcommand{\makeheader}{%
	\begin{center}
		{\fontsize{22}{24}\selectfont\bfseries\color{headingcolor}\resumename}\\[3pt]
		{\large\resumejobtitle}\\[6pt]
		{\small
			\mbox{\resumeaddress}~\textbar~\mbox{\resumenumberphone}~\textbar~\mbox{\href{mailto:\resumemail}{\resumemail}}%
			\\[3pt]
			\ifthenelse{\equal{\resumelinkedin}{}}{}{\mbox{\href{https://\resumelinkedin}{\resumelinkedin}}}%
			\ifthenelse{\equal{\resumegithub}{}}{}{~\textbar~\mbox{\href{https://\resumegithub}{\resumegithub}}}%
		}
	\end{center}
	\ifthenelse{\equal{\resumesummary}{}}{}{%
		\vspace{8pt}
		\resumesummary
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
