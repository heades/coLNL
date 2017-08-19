%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Modification log
%%
%% 2004/03/25 v0.1 based on amsart.cls, inspired by jair.sty 
%% 2004/09/01 v0.2 based on amsart.cls
%% 2004/10/12 v0.3 based on amsart.cls
%% 2004/12/16 v0.4 based on amsart.cls
%% 2005/01/24 v0.5 based on amsart.cls
%% 2006/01/18 v0.6 based on amsart.cls
%% 2006/07/24 v0.7 based on amsart.cls
%% 2009/05/25 v0.8 based on amsart.cls
%% 2011/04/23 v0.81 based on amsart.cls
%% 2013/02/05 v0.82 based on amsart.cls
%% 2013/09/20 v0.9 based on amsart.cls
%% 2015/03/27 v0.91 based on amsart.cls
%%                
%%                 Juergen Koslowski (Stefan Milius)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lmcs}
              [2009/05/25 v0.9 LMCS Layout Editor Class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsart}}
\ProcessOptions\relax

\LoadClass[11pt,reqno]{amsart}
\usepackage{helvet}

\usepackage{enumitem}
\setlist[enumerate]{font=\normalfont,labelindent=*,leftmargin=*}
\setlist[itemize]{labelindent=*,leftmargin=*}
\setlist[description]{labelindent=*,leftmargin=*,itemindent=-1 em}
\usepackage{microtype}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                   actual macros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\count255=\the\catcode`\@ \catcode`\@=11 \edef\catc@de{\the\count255}

\newif\ifsuPer \suPertrue
\def\rsuper#1{\ifsuPer${\,}^{\MakeLowercase #1}$\fi}%
\def\lsuper#1{\ \hskip-2 pt\ifsuPer\hbox to0 pt{\hss${}^{\MakeLowercase #1}\ $\fi}}%

\def\titlecomment#1{\def\@titlecomment{#1}}
\let\@titlecomment=\@empty
\renewcommand{\sfdefault}{phv}
\renewcommand*\subjclass[2][2012]{%
  \def\@subjclass{#2}%
  \@ifundefined{subjclassname@#1}{%
    \ClassWarning{\@classname}{Unknown edition (#1) of ACM
      Subject Classification; using '2012'.}%
  }{%
    \@xp\let\@xp\subjclassname\csname subjclassname@2012\endcsname
  }%
}
\@namedef{subjclassname@1998}{1998 ACM Subject Classification}
\@namedef{subjclassname@2012}{2012 ACM CCS}

\def\ACMCCS#1{\def\@ACMCCS{#1}}
\let\@ACMCCS=\@empty
\def\ACMCCSname{2012 ACM CCS}
    \@xp\let\@xp\subjclassname\csname subjclassname@2012\endcsname

\def\amsclass#1{\def\@amsclass{#1}}
\let\@amsclass=\@empty
\def\amsclassname{2010 Mathematics Subject Classification}

\renewenvironment{abstract}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{Abstract should precede
      \protect\maketitle\space in AMS documentclasses; reported}%
  \fi
  \global\setbox\abstractbox=\vtop \bgroup
    \normalfont\Small
    \list{}{\labelwidth\z@
      \leftmargin3pc \rightmargin\leftmargin
      \listparindent\normalparindent \itemindent\z@
      \parsep\z@ \@plus\p@
      \let\fullwidthdisplay\relax
    }%
    \item[\hskip\labelsep\scshape\abstractname.]%
}{%
  \endlist\egroup
  \ifx\@setabstract\relax \@setabstracta \fi
}
\newcommand{\revisionname}{Revision Note}
\newbox\revisionbox
\newenvironment{revision}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{Revision should precede
      \protect\maketitle\space in LMCS documentclasses; reported}%
  \fi
  \global\setbox\revisionbox=\vtop \bgroup
    \normalfont\Small
    \list{}{\labelwidth\z@
      \leftmargin3pc \rightmargin\leftmargin
      \listparindent\normalparindent \itemindent\z@
      \parsep\z@ \@plus\p@
      \let\fullwidthdisplay\relax
    }%
    \item[\hskip\labelsep\scshape\revisionname.]%
}{%
  \endlist\egroup
  \ifx\@setrevision\relax \@setrevisiona \fi
}
\def\@setrevision{\@setrevisiona \global\let\@setrevision\relax}
\def\@setrevisiona{%
  \ifvoid\revisionbox
  \else
    \skip@20\p@ \advance\skip@-\lastskip
    \advance\skip@-\baselineskip \vskip\skip@
    \box\revisionbox
    \prevdepth\z@ % because \revisionbox is a vtop
    \bigskip\hrule\medskip
  \fi
}
\def\@setACMCCS{%
  {\itshape\subjclassname:}\enspace\@ACMCCS\@addpunct.}
\def\@setamsclass{%
  {\itshape\amsclassname:}\enspace\@amsclass\@addpunct.}
\def\@setkeywords{%
  {\itshape \keywordsname:}\enspace\@keywords\@addpunct.}
\def\@settitlecomment{\@titlecomment\@addpunct.}
\def\@maketitle{%
  \normalfont\normalsize
  \let\@makefnmark\relax  \let\@thefnmark\relax
  \ifx\@empty\@date\else \@footnotetext{\@setdate}\fi
  \ifx\@empty\@ACMCCS\else \@footnotetext{\@setACMCCS}\fi
  \ifx\@empty\@amsclass\else \@footnotetext{\@setamsclass}\fi
  \ifx\@empty\@keywords\else \@footnotetext{\@setkeywords}\fi
  \ifx\@empty\@titlecomment\else \@footnotetext{\@settitlecomment}\fi
  \ifx\@empty\thankses\else \@footnotetext{%
    \def\par{\let\par\@par}\@setthanks\par}\fi
  \@mkboth{\@nx\shortauthors}{\@nx\shorttitle}%
  \global\topskip12\p@\relax % 5.5pc   "   "   "     "     "
  \topskip42 pt\@settitle
  \ifx\@empty\authors \else \@setauthors \fi
  \@setaddresses
  \ifx\@empty\@dedicatory
  \else
    \baselineskip18\p@
    \vtop{\centering{\footnotesize\itshape\@dedicatory\@@par}%
      \global\dimen@i\prevdepth}\prevdepth\dimen@i
  \fi
  \endfront@text
  \bigskip\hrule\medskip
  \@setrevision
  \@setabstract
  \vskip-\bigskipamount
  \normalsize
  \if@titlepage
    \newpage
  \else
    \dimen@34\p@ \advance\dimen@-\baselineskip
    \vskip\dimen@\relax
  \fi
}
\def\@setaddresses{\par
  \nobreak \begingroup
\footnotesize
  \def\author##1{\nobreak\addvspace\bigskipamount}%
  \def\\{\unskip, \ignorespaces}%
  \interlinepenalty\@M
  \def\address##1##2{\begingroup
    \par\addvspace\bigskipamount\noindent\narrower
    \@ifnotempty{##1}{(\ignorespaces##1\unskip) }%
    {\ignorespaces##2}\par\endgroup}%
  \def\curraddr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape Current address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      ##2\par}\endgroup}%
  \def\email##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape e-mail address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      {##2}\par}\endgroup}%
  \def\urladdr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape URL}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      \ttfamily##2\par}\endgroup}%
  \addresses
  \endgroup
}
\copyrightinfo{}{}

\newinsert\copyins
\skip\copyins=3pc
\count\copyins=1000 % magnification factor, 1000 = 100%
\dimen\copyins=.5\textheight % maximum allowed per page

\renewcommand{\topfraction}{0.95}   % let figure take up nearly whole page
\renewcommand{\textfraction}{0.05}  % let figure take up nearly whole page

%% Specify the dimensions of each page

\setlength{\oddsidemargin}{.25 in}  %   Note \oddsidemargin = \evensidemargin
\setlength{\evensidemargin}{.25 in}
\setlength{\marginparwidth}{0.07 true in}
\setlength{\topmargin}{-0.7 in}
\addtolength{\headheight}{1.84 pt}
\addtolength{\headsep}{0.25in}
\addtolength{\voffset}{0.7 in}
\setlength{\textheight}{8.5 true in}  % Height of text (including footnotes & figures)
\setlength{\textwidth}{6.0 true in}   % Width of text line.
\setlength{\parindent}{20 pt}   % Width of text line.
\widowpenalty=10000
\clubpenalty=10000
\@twosidetrue \@mparswitchtrue \def\ds@draft{\overfullrule 5pt}
\raggedbottom

%% Pagestyle

%% Defines the pagestyle for the title page.
%% Usage: \lmcsheading{vol}{issue}{year}{pages}{subm}{publ}{rev}{spec_iss}{title}

\def\lmcsheading#1#2#3#4#5#6#7{\def\ps@firstpage{\let\@mkboth\@gobbletwo%
\def\@oddhead{%
\hbox{%
  \vbox to 30 pt{\scriptsize\vfill
    \hbox{\textsf{Logical Methods in Computer Science}\hfil}
    \hbox{\textsf{Vol.~? (?:?) 2???, ? pages}}
    \hbox{\textsf{www.lmcs-online.org}}
    \rlap{\vrule width\hsize depth .4 pt}}}\hfill
\raise 4pt
\hbox{%
  \vbox to 30 pt{\scriptsize\vfill
    \hbox{\textsf{}}
    \hbox{\textsf{}}}}\hfill
\raise 4pt
\hbox{%
  \vbox to 30 pt{\scriptsize\vfill
    \hbox to 94 pt{\textsf{Submitted\hfill date}}
    \hbox to 94 pt{\textsf{Published\hfill date}}
    }}}
\def\@evenhead{}\def\@evenfoot{}}%
\thispagestyle{firstpage}}

\def\endfront@text{%
    \insert\copyins{\hsize\textwidth
      \fontsize{6}{7\p@}\normalfont\upshape
      \noindent
\hbox{%
  \vbox{\fontsize{6}{8 pt}\baselineskip=6 pt\vss
    \hbox{\hbox to 20 pt{\hfill}
          \textsf{LOGICAL METHODS}\hfil}
    \hbox{\hbox to 20 pt{\phantom{x}}
          \textsf{IN COMPUTER SCIENCE}}}}
\hfill\textsf{DOI:10.2168/LMCS-???}
%\hfill\textsf{\copyright\shortauthors}
\hfill
\hbox{%
  \vbox{\fontsize{6}{8 pt}\baselineskip=6 pt\vss
    \hbox{\textsf{\,\,\copyright\quad \shortauthors}\hfil}
    \hbox{\textsf{Creative Commons}\hfil}}}
\par\kern\z@}%
}
%\def\endfront@text{}

\def\enddoc@text{\nobreak%
    \insert\copyins{\hsize.57\textwidth
\vbox to 0pt{\vskip12 pt%
      \fontsize{6}{7\p@}\normalfont\upshape
      \everypar{}%
      \noindent\fontencoding{T1}%
  \textsf{This work is licensed under the Creative Commons
  Attribution-NoDerivs License. To view a copy of this license, visit
  \texttt{http://creativecommons.org/licenses/by-nd/2.0/} or send a
  letter to Creative Commons, 171 Second St, Suite 300, San Francisco,
    CA 94105, USA, or Eisenacher Strasse 2, 10777 Berlin, Germany}\vss}
      \par
      \kern\z@}%
}

%% Defines the pagestyle for the rest of the pages
%% Usage: \ShortHeadings{Minimizing Conflicts}{Minton et al}
%%	  \ShortHeadings{short title}{short authors}

%\def\firstpageno#1{\setcounter{page}{#1}}
%\def\ShortHeadings#1#2{\def\ps@lmcsps{\let\@mkboth\@gobbletwo%
%\def\@oddhead{\hfill {\small\sc #1} \hfill}%
%\def\@oddfoot{\hfill \small\rm \thepage \hfill}%
%\def\@evenhead{\hfill {\small\sc #2} \hfill}%
%\def\@evenfoot{\hfill \small\rm \thepage \hfill}}%
%\pagestyle{lmcsps}}

%% MISCELLANY

\def\@startsection#1#2#3#4#5#6{\bigskip%
 \if@noskipsec \leavevmode \fi
 \par \@tempskipa #4\relax
 \@afterindentfalse
 \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi
 \if@nobreak \everypar{}\else
     \addpenalty\@secpenalty\addvspace\@tempskipa\fi
 \@ifstar{\@dblarg{\@sect{#1}{\@m}{#3}{#4}{#5}{#6}}}%
         {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}%
}

\def\figurecaption#1#2{\noindent\hangindent 40pt
                       \hbox to 36pt {\small\sl #1 \hfil}
                       \ignorespaces {\small #2}}
% Figurecenter prints the caption title centered.
\def\figurecenter#1#2{\centerline{{\sl #1} #2}}
\def\figurecenter#1#2{\centerline{{\small\sl #1} {\small #2}}}

%
%  Allow ``hanging indents'' in long captions
%
\long\def\@makecaption#1#2{
   \vskip 10pt 
   \setbox\@tempboxa\hbox{#1: #2}
   \ifdim \wd\@tempboxa >\hsize               % IF longer than one line:
       \begin{list}{#1:}{
       \settowidth{\labelwidth}{#1:}
       \setlength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
        }\item #2 \end{list}\par   % Output in quote mode
     \else                                    %   ELSE  center.
       \hbox to\hsize{\hfil\box\@tempboxa\hfil}  
   \fi}


% Define strut macros for skipping spaces above and below text in a
% tabular environment.
\def\abovestrut#1{\rule[0in]{0in}{#1}\ignorespaces}
\def\belowstrut#1{\rule[-#1]{0in}{#1}\ignorespaces}

%%% Theorem environments

% the following environments switch to a slanted font:
\theoremstyle{plain}

\newtheorem{thm}{Theorem}[section]
\newtheorem{cor}[thm]{Corollary}
\newtheorem{lem}[thm]{Lemma}
\newtheorem{prop}[thm]{Proposition}
\newtheorem{asm}[thm]{Assumption}

% the following environments keep the roman font:
\theoremstyle{definition}

\newtheorem{rem}[thm]{Remark}
\newtheorem{rems}[thm]{Remarks}
\newtheorem{exa}[thm]{Example}
\newtheorem{exas}[thm]{Examples}
\newtheorem{defi}[thm]{Definition}
\newtheorem{conv}[thm]{Convention}
\newtheorem{conj}[thm]{Conjecture}
\newtheorem{prob}[thm]{Problem}
\newtheorem{oprob}[thm]{Open Problem}
\newtheorem{oprobs}[thm]{Open Problems}
\newtheorem{algo}[thm]{Algorithm}
\newtheorem{obs}[thm]{Observation}
\newtheorem{desc}[thm]{Description}
\newtheorem{fact}[thm]{Fact}
\newtheorem{qu}[thm]{Question}
\newtheorem{oqu}[thm]{Open Question}
\newtheorem{pty}[thm]{Property}
\newtheorem{clm}[thm]{Claim}
\newtheorem{nota}[thm]{Notation}
\newtheorem{com}[thm]{Comment}
\newtheorem{coms}[thm]{Comments}

\numberwithin{equation}{section}

% end-of-proof sign, to appear at right margin
% Paul Taylor and Chris Thompson, Cambridge, 1986
%
\def\pushright#1{{%        set up
   \parfillskip=0pt            % so \par doesn't push #1 to left
   \widowpenalty=10000         % so we dont break the page before #1
   \displaywidowpenalty=10000  % ditto
   \finalhyphendemerits=0      % TeXbook exercise 14.32
  %
  %                 horizontal
   \leavevmode                 % \nobreak means lines not pages
   \unskip                     % remove previous space or glue
   \nobreak                    % don't break lines
   \hfil                       % ragged right if we spill over
   \penalty50                  % discouragement to do so
   \hskip.2em                  % ensure some space
   \null                       % anchor following \hfill
   \hfill                      % push #1 to right
   {#1}                        % the end-of-proof mark (or whatever)
  %
  %                   vertical
   \par}}                      % build paragraph

\def\qEd{{\lower1 pt\hbox{\vbox{\hrule\hbox{\vrule\kern4 pt
    \vbox{\kern4 pt\hbox{\hss}\kern4 pt}\kern4 pt\vrule}\hrule}}}}
\def\qed{\pushright{\qEd}
    \penalty-700 \par\addvspace{\medskipamount}}

\newenvironment{Proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \item[\hskip\labelsep
        \itshape
    #1.]\ignorespaces
}{%
  \popQED\endtrivlist\@endpefalse
}

% Bibliographystyle

\bibliographystyle{alpha}

\def\(#1{\relax\hbox to1.4 em{\rm(\hss#1\hss)}}

%\ProvidesPackage{cclicenses}[2005/05/20 v0.4 CC licenses typesetting]
\RequirePackage{rotating}
\newdimen\cCHardim
%\newdimen\cChDim
%\newdimen\cChTmp
%\newcount\cChPos
%\newcount\cCvPos
%\newcommand{\SA@aRRow}{
%\cChDim\cCHardim
%\ifdim\cChDim<1.5pt \cChDim=1.5pt\fi
%\setlength\unitlength{1sp}
%\begin{picture}(0,0)
%  \cChPos=0
%  \cCvPos\cChDim
%  \loop
%    \put(\cChPos,\cCvPos){
%      \rule[0mm]{\cChDim}{1000sp}
%    }
%    \advance\cChTmp by 1000sp
%    \cChPos\cChTmp
%    \advance\cCvPos by -1000
%    \advance\cChDim by -2000sp
%  \ifnum\cCvPos > 0 \repeat
%\end{picture}}
\DeclareTextCommandDefault{\text@cC}{%
  \let\origfontfamily\f@family
  \let\origfontseries\f@series
  \cCHardim\fontdimen6\font
  \divide\cCHardim by 2
  {
    \fontfamily{phv}\fontseries{b}\selectfont%
    \textcircled{%
      \raisebox{.12ex}{\fontsize{\cCHardim}{\baselineskip}\selectfont{CC}}%
    }
  }
  \fontfamily{\origfontfamily}\fontseries{\origfontseries}\selectfont
}
\DeclareTextCommandDefault{\text@cCnd}{%
  \let\origfontfamily\f@family
  \let\origfontseries\f@series
  \cCHardim\fontdimen6\font
  \divide\cCHardim by 2
  {
    \fontfamily{phv}\fontseries{b}\selectfont%
    \textcircled{%
      \raisebox{.20ex}{\fontsize{\cCHardim}{\baselineskip}\selectfont{=}}%
    }
  }
  \fontfamily{\origfontfamily}\fontseries{\origfontseries}\selectfont
}
\DeclareTextCommandDefault{\text@cCby}{%
  \let\origfontfamily\f@family
  \let\origfontseries\f@series
  \cCHardim\fontdimen6\font
  \divide\cCHardim by 2
  {
    \fontfamily{phv}\fontseries{b}\selectfont%
    \textcircled{%
      \raisebox{.5pt}{\fontsize{\cCHardim}{\baselineskip}\selectfont%
      {B\kern -.15em Y\kern -.15em:}}%
    }
  }
  \fontfamily{\origfontfamily}\fontseries{\origfontseries}\selectfont
}
\DeclareTextCommandDefault{\text@cCnc}{%
  \let\origfontfamily\f@family
  \let\origfontseries\f@series
  \cCHardim\fontdimen6\font
  \divide\cCHardim by 2
  {
    \fontfamily{phv}\fontseries{b}\selectfont%
    \textcircled{%
      \raisebox{.15ex}{\fontsize{\cCHardim}{\baselineskip}\selectfont%
      \makebox[0cm][c]{\$}}%
      \setlength{\cCHardim}{1.98\cCHardim}%
      \fontsize{\cCHardim}{\baselineskip}\selectfont%
      \raisebox{-.20ex}{\begin{rotate}{45}\textbackslash\end{rotate}}%
    }
  }
  \fontfamily{\origfontfamily}\fontseries{\origfontseries}\selectfont
}
\DeclareTextCommandDefault{\text@cCsa}{%
  \let\origfontfamily\f@family
  \let\origfontseries\f@series
  \fontfamily{phv}\fontseries{b}\selectfont%
  \textcircled{%
    \makebox[1em][l]{
      \raisebox{.95ex}{\hskip-.45ex
        \begin{rotate}{180}\scshape{c}\end{rotate}}}%
      \cCHardim\fontdimen6\font
      \divide\cCHardim by 6
      \raisebox{.3ex}{\hspace{-5ex}
      \SA@aRRow}
  }
  \fontfamily{\origfontfamily}\fontseries{\origfontseries}\selectfont
}
\DeclareRobustCommand{\cC}{%
  \ifmmode{\nfss@text{\text@cC}}\else\text@cC\fi}
\DeclareRobustCommand{\cCnd}{%
  \ifmmode{\nfss@text{\text@cCnd}}\else\text@cCnd\fi}
\DeclareRobustCommand{\cCby}{%
  \ifmmode{\nfss@text{\text@cCby}}\else\text@cCby\fi}
\DeclareRobustCommand{\cCnc}{%
  \ifmmode{\nfss@text{\text@cCnc}}\else\text@cCnc\fi}
\DeclareRobustCommand{\cCsa}{%
  \ifmmode{\nfss@text{\text@cCsa}}\else\text@cCsa\fi}
\newcommand{\by}{\cCby}
\newcommand{\bynd}{\cCby\cCnd}
\newcommand{\byncnd}{\cCby\cCnc\cCnd}
\newcommand{\bync}{\cCby\cCnc}
\newcommand{\byncsa}{\cCby\cCnc\cCsa}
\newcommand{\bysa}{\cCby\cCsa}
\newcommand{\nd}{\cCnd}
\newcommand{\ndnc}{\cCnd\cCnc}
\newcommand{\nc}{\cCnc}
\newcommand{\ncsa}{\cCnc\cCsa}
\newcommand{\sa}{\cCsa}

\def\eqalign#1{\null\,\vcenter{\openup\jot\mathsurround=0 pt
  \ialign{\strut\hfil$\displaystyle{##}$&$\displaystyle{{}##}$\hfil
      \crcr#1\crcr}}\,}

\endinput
