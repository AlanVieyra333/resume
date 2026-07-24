%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ATS-friendly Software Engineer CV class
%
% Single column, no graphics/sidebars/tables-as-layout, standard fonts,
% real selectable text only -- designed to parse cleanly through
% Applicant Tracking Systems while remaining readable to humans.
%
% License: MIT (see included LICENSE file)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ProvidesClass{style}[2026/01/01 ATS-friendly Software Engineer CV class]
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

\setlist[itemize]{leftmargin=1.2em, itemsep=1pt, topsep=1pt, parsep=0pt, partopsep=0pt}
\AtEndEnvironment{itemize}{\vspace{5pt}}

%----------------------------------------------------------------------------------------
%	HEADER / CONTACT COMMANDS
%----------------------------------------------------------------------------------------

\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\cvsummary}[1]{\renewcommand{\cvsummary}{#1}}

% Prints the header block: name, job title, one-line plain-text contact
% line, and an optional professional summary paragraph.
\newcommand{\makeheader}{%
	\begin{center}
		{\fontsize{22}{24}\selectfont\bfseries\color{headingcolor}\cvname}\\[3pt]
		{\large\cvjobtitle}\\[6pt]
		{\small
			\mbox{\cvaddress}~\textbar~\mbox{\cvnumberphone}~\textbar~\mbox{\href{mailto:\cvmail}{\cvmail}}%
			\ifthenelse{\equal{\cvlinkedin}{}}{}{~\textbar~\mbox{\href{https://\cvlinkedin}{\cvlinkedin}}}%
			\ifthenelse{\equal{\cvgithub}{}}{}{~\textbar~\mbox{\href{https://\cvgithub}{\cvgithub}}}%
		}
	\end{center}
	\ifthenelse{\equal{\cvsummary}{}}{}{%
		\vspace{8pt}
		\cvsummary
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

\newcommand{\cventry}[4]{%
	\noindent\begin{tabular*}{\linewidth}{@{}l@{\extracolsep{\fill}}r@{}}
		\textbf{#1} & \textbf{\small #3}\\
	\end{tabular*}\\[-1pt]
	\noindent\begin{tabular*}{\linewidth}{@{}l@{\extracolsep{\fill}}r@{}}
		\textit{#2} & \textit{\small #4}\\
	\end{tabular*}\\[3pt]
}

%----------------------------------------------------------------------------------------
%	SKILL ROW -- plain text "Category: item, item, item" (no graphical bars)
%----------------------------------------------------------------------------------------

\newcommand{\skillrow}[2]{\textbf{#1:} #2\par\vspace{2pt}}

%----------------------------------------------------------------------------------------
%	MARGINS AND LINKS
%----------------------------------------------------------------------------------------

\urlstyle{same}
