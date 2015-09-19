% -*- coding: utf-8 -*-

% cedv.cls
%
% Copyright © 2011
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cedv}[2011/09/25 modified book class for CEDV]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\PassOptionsToClass{a5paper, 10pt, twoside, openright}{book}
\ProcessOptions\relax
\LoadClass{book}

\makeatletter

% Codificación UTF8
\usepackage[T1]{fontenc}
\usepackage[utf8]{inputenc}
\usepackage[spanish]{babel}

% Espaciado entre párrafos
\setlength{\parskip}{5pt}
% Hipervínculos dentro del documento
\usepackage{hyperref}
% Ubicaciones absolutas
\usepackage{float}
% Encabezado y pie de página
\usepackage{fancybox}
\usepackage{fancyvrb}
% Elementos centrados en página en plantillas book
\usepackage{changepage}
% Tipografía del documento
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{bookman}  % bookman | newcent | palatino | times
\usepackage{courier}
\usepackage{eurosym}

% Para la inserción de imágenes
\usepackage{graphics}
% Configuración de página
\usepackage{a4wide}

%\usepackage[a4paper,left=7cm,right=2cm, top=2.75cm, bottom=2.5cm, marginparwidth=2.5cm, marginparsep=1.0cm]{geometry}
\usepackage[
  paperwidth=210mm,
  paperheight=262mm,
  left=7cm,right=2cm,
  top=2.75cm, bottom=2.5cm,
  marginparwidth=2.5cm, marginparsep=1.0cm]{geometry}

% % Macros personalizadas
\usepackage{ifthen}
\usepackage{colortbl}
\usepackage{captdef}
\usepackage{lettrine}
% \usepackage{shadow}
% \usepackage{mparhack}
\usepackage{tabularx}
\usepackage{booktabs}

\usepackage{authblk}

\usepackage{xspace}  % gentle spacing after a macro

\usepackage{xcolor}
\definecolor{gris}{rgb}{0.3,0.3,0.3}
\definecolor{grisclaro}{rgb}{0.85,0.85,0.85}
\definecolor{grisoscuro}{rgb}{0.2,0.2,0.2}

\renewcommand{\LettrineFontHook}{\color[gray]{0.4}}

\reversemarginpar

\usepackage{fancyhdr}

%\setlenght\headheight{17pt}
\fancyhf{}
\fancyheadoffset[RO,LE]{0pt}
\fancyheadoffset[LO]{145pt}
\fancyheadoffset[RE]{145pt}
\fancyhead[RO,LE]{[\textbf{\thepage}]}
\fancyhead[LO]{\nouppercase{\rightmark}} % Seccion
\fancyhead[RE]{\leftmark}  % CAPITULO
\renewcommand\headrule{\hrule height 1.5pt width\headwidth \vspace{1mm}}


% Para el dibujado de grafos (requiere tener instalado el paquete dot2tex en el sistema)
%\usepackage[outputdir={./dot/},autosize]{dot2texi}
\usepackage{tikz}
\usepackage[customcolors]{hf-tikz}
\usetikzlibrary{arrows,automata,positioning,shapes,decorations}

\usepackage{cedv-listings}
\usepackage{cedv-acronym}

\usepackage{caption}
\DeclareCaptionFont{white}{\fontsize{9}{9}\selectfont\color{white}}
\DeclareCaptionFormat{listing}{
  \colorbox[cmyk]{0.43, 0.35, 0.35,0.01}{\parbox{0.982\textwidth}{\hspace{15pt}#1#2#3}}}
\captionsetup[lstlisting]{
  format=listing,
  labelfont=white,
  textfont=white,
  singlelinecheck=false,
  margin=0pt,
  font={bf,footnotesize}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\bigrule}{\vspace{-0.5cm}\hspace{-4.95cm}\titlerule[1.0mm]}



\def\comando#1{\texttt{\small{#1}}}

\def\linea#1{\fboxsep=0.8mm\fontsize{7}{7}\selectfont\ovalbox{\texttt{\textbf{#1}}}\normalsize}

\def\botonazo#1{\fboxsep=0.8mm\fontsize{6}{6}\selectfont\ovalbox{\textbf{#1}}\normalsize}


\def\raton#1{
\negthinspace \negthinspace
\begin{minipage}[c][1ex][c]{1em}
   \resizebox{!}{1em}{\includegraphics{../common/img/gui/#1.jpg}}
\end{minipage}
}


\def\interfaz#1{
\negthinspace \negthinspace
\begin{minipage}[c][1ex][c]{1em}
   \resizebox{!}{1em}{\linethickness{0.3mm} \frame{\includegraphics{../common/img/gui/#1.jpg}}}
\end{minipage}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Insercion de teclazos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ejemplo: \teclazo{Ctrl} %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\teclazo#1{
    \negthinspace
    \fontsize{9}{6}\selectfont \ovalbox{\texttt{\textbf{#1}}} \normalsize
    \negthinspace
}

%% Imagen en el margen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ejemplo: \imagenmargen{path}{label}{caption} %%%%%%%%%%%%%%%%%%%%%%%%

\def\imagenmargen#1#2#3{
    \marginparsep=1cm
    \captionsetup{margin=0pt,font=footnotesize,labelfont=bf}
    \marginparwidth=4cm
    \marginpar{
        \resizebox{\marginparwidth}{!}{\includegraphics{#1}}
    }
    \marginpar{
        \vspace{0.2cm}
        \figcaption{#3}\label{#2}
    }
}

%% Nota en el margen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ejemplo: \notamargen{Texto} %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\notamargen#1#2{
    \interlineado{1.2}
    \ifodd\thepage
        \marginparsep=1.0cm
    \else
        \marginparsep=1.0cm
    \fi
    \marginparwidth=4.0cm
    \marginpar{
        \fontsize{9}{8}\selectfont
        \fboxsep=1.5mm
        \vspace{0.2cm} \hspace{-0.08cm} \fbox{#1} \vspace{0.2cm} \\
        \fontsize{8}{7.5}
        \selectfont #2
    }
    \marginparwidth=2.5cm
    \normalsize
    \interlineado{0.95}
}

%% Bloque llamativo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Uso: \importante{tipo}{Texto} % tipo = warning | info | question

\def\admonition#1#2{
  \vspace{3mm}
  {\small
    \fboxrule=0.5pt
    \fboxsep=5mm
    \par\noindent\fcolorbox{grisoscuro}{grisclaro}{\parbox{1.3cm}{\resizebox{1cm}{!}{\includegraphics{../common/img/iconos/#1.png}}}\parbox{0.81\hsize}{#2}}
    \vspace{3mm}
    \fboxsep=1.5mm
  }
}

\def\info#1{\admonition{info}{#1}}
\def\question#1{\admonition{question}{#1}}
\def\warning#1{\admonition{warning}{#1}}

%% Insercion de imagen como figura %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Uso: \imagenhere{nombreFichero}{Ancho}{Descripcion}{Identificador}

\def\imagenhere#1#2#3#4{
  \begin{figure}[h]
    \begin{center}
%     \resizebox{#2\textwidth}{!}{\includegraphics{#1}}
      \resizebox{#2}{!}{\includegraphics{#1}}
      \ifthenelse{\equal{#3}{}}{}{\caption {#3}}
      \label{#4}
    \end{center}
  \end{figure}
}

%% Letra capital %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Uso: \capital{letra}

\def\capital#1{
    \lettrine[lines=3, lhang=0.00, loversize=0.04]{#1}{}
}

%% Insercion de citas %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Uso: \cita{frase}{autor}

\def\cita#1#2{
  \vspace{0.2cm}
  \begin{quote}
    #1
    \begin{flushright}
      {\it #2}
    \end{flushright}
  \end{quote}
  \normalsize
}

%% Cambiar el interlineado %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Uso: \interlineado{factor} % factor 1.0 es el normal, 2.0 doble...

%% FIXME: Usar setspace
%% FIXME: Usar \linespread
\newcommand{\interlineado}[1]{
  \renewcommand{\baselinestretch}{#1}  % -- Cambiamos interlineado
  \large\normalsize % ---------------------- Para que cambie de verdad
}

%% Imagen de ancho total %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Uso: \imagenanchototal{path}{caption}{label}

\def\imagenanchototal#1#2#3{
  \begin{figure}[tb]
    \ifodd\thepage
      \hspace{-5.2cm}
    \else
      \hspace{-0.1cm}
    \fi
    \begin{minipage}{17.1cm}
      \centering
      \includegraphics[width=\textwidth]{#1}
      \ifthenelse{\equal{#2}{}}{}{\caption{#2}}
      \ifthenelse{\equal{#3}{}}{}{\label{#3}}
    \end{minipage}
  \end{figure}
}

%% http://tex.stackexchange.com/questions/16582/center-figure-that-is-wider-than-textwidth
\usepackage[export]{adjustbox}
\def\imagenanchototal#1#2#3{
  \begin{figure}
    \includegraphics[width=1.43\textwidth,outer]{#1}%
    \ifthenelse{\equal{#2}{}}{}{\caption{#2}}
    \ifthenelse{\equal{#3}{}}{}{\label{#3}}
  \end{figure}
}

\newcommand{\putone}[1]{#1}


%% -- Personalización de los títulos de los capítulos
\usepackage[clearempty]{titlesec}

\titleformat{\chapter}[display]{\bfseries\Huge}
  {%
    \filleft
    \vspace{0.5cm}
    \Large\chaptertitlename\ % "Capítulo" o "Apéndice"
    \textcolor{gris}{\fontsize{90}{90}\selectfont\thechapter}\normalsize
  }     % número de capítulo
  {0cm} % espacio mínimo entre etiqueta y cuerpo
  {\filleft} % texto del cuerpo alineado a la derecha
  [\vspace{0.5mm} \bigrule\\
  {\normalsize\textnormal{\@chapterauthors}}
  ] % después del cuerpo, dejar espacio vertical y trazar línea horizontal gruesa


\usepackage[dotinlabels]{titletoc}

%\contentsmargin{2.55em}
\contentsmargin{1em}
\titlecontents{chapter}
              [1.5em]
              {\vspace*{3mm}}
              {\contentslabel{3.5em}\bfseries\hspace*{-5mm}}
              {\hspace*{-1.5em}}
              {\titlerule*[1pc]{.}\contentspage}

%               \textbf{\thecontentslabel.}\hspace{1.5em}\bfseries\hspace*{-5mm}}

\titlecontents{section}
              [2.5em]
              {}
              {\contentslabel{3.5em}}
              {\hspace*{-2.3em}}
              {\titlerule*[1pc]{.}\contentspage}

\titlecontents{subsection}
               [4.2em]
               {} % note that 3.8 = 1.5 + 2.3
               {\contentslabel{3.5em}}
               {\hspace*{-3.2em}}
               {\titlerule*[1pc]{.}\contentspage}


% Para crear índices de términos
%\usepackage{makeidx}


% --- Variables del paquete  ---
\author{}

\newcommand{\@cedvSubtitle}{Curso de Enseñanzas Propias}
\newcommand{\cedvSubtitle}[1]{%
  \renewcommand{\@cedvSubtitle}{#1}}

\newcommand{\@chapterauthors}{}
\newcommand{\chapterauthors}[1]{%
  \renewcommand{\@chapterauthors}{#1}}



\newcommand{\frontpage}{%
  \pagestyle{empty}
  \textbf{}\\[5cm]
  \begin{adjustwidth*}{-130pt}{} % Margenes izquierdo y derecho

    \begin{center}

      \begin{huge}\textbf{\@title}\end{huge}\\[0.4cm]
      \begin{Large}{\it \textbf{\@cedvSubtitle}}\end{Large}\\[0.9cm]
%      \begin{large}\MakeUppercase{\@author}\end{large}\\[0.5cm]

%      \@author

      % CAMBIO DAVID.
      \textbf{}\\[5cm]

      \includegraphics[scale=0.5]{../common/img/escudo-uclm.jpg}

      {\bf Universidad de Castilla-La Mancha}\par
      Escuela de Ingeniería Industrial\\de Toledo
    \end{center}
  \end{adjustwidth*}

  \newpage
  \mbox{}
  % CAMBIO DAVID
  \vspace{10cm}
  \begin{adjustwidth*}{-100pt}{50pt} % Margenes izquierdo y derecho
%    {\bf\@author}\\[0.1cm]
    Escuela de Ingeniería Industrial\\[0.3cm]
    \begin{tabular}{ll}
      {\it e-mail} & {\tt industriales.to@uclm.es} \\[0.1cm]
      {\it Teléfono} & {\tt 925 268 800} \\[0.1cm]
      {\it Web} & {\tt http://www.uclm.es/to/eii/}\\[0.1cm]
    \end{tabular}

    \vspace{0.5cm}
    \begin{small}
      \copyright~\the\year~ Los autores del documento. Se permite la
      copia, distribución y/o modificación de este documento bajo los
      términos de la licencia de documentación libre GNU, versión 1.1
      o cualquier versión posterior publicada por la {\em Free
        Software Foundation}, sin secciones invariantes. Puede
      consultar esta licencia en http://www.gnu.org.\\[0.2cm]
      Raspberry Pi y su logo son marcas
      registradas de Raspberry Pi Foundation.\\[0.2cm]
      Arduino es marca registrada de Arduino team.\\[0.2cm]
      Todas las demás marcas empleadas en este documento son marcas
      registradas por sus respectivos propietarios.\\[0.2cm]
      Este documento fue compuesto con \LaTeX{}, y ha sido
      desarrollado a partir de una plantilla de Carlos González
      Morcillo, Sergio García Mondaray y David Villa Alises.
    \end{small}

  \end{adjustwidth*}
}


%------------------ NUEVO (no afecta al contenido previo) -------------------------

\hypersetup{%
  bookmarks,
  hyperfootnotes = false,
  pdfview        = {fitv},
  hidelinks      = true,
  % backref,                % debug: refs desde la bibliografía
}


\usepackage{enumitem}
\newlist{definitionlist}{description}{1}
\setlist[definitionlist]{
  style     = nextline,
}

%-- marcado semántico ---
\newcommand{\ecode}[1]{{\texttt{#1}}}     % trozo pequeño de código fuente
\newcommand{\kw}[1]{\texttt{#1}}          % keyword, palabra reservada
\def \token   #1{\texttt{#1}}                 % literal, constante simbólica
\def \command #1{\texttt{#1}}                 % comando
\newcommand{\iface}[1]{\textit{#1}}       % interfaz
\newcommand{\function}[1]{\texttt{#1()}}
\newcommand{\id}[1]{\texttt{#1}}          % identificador
\newcommand{\fg}[1]{\textit{#1}}          % foreign, una palabra en inglés
\newcommand{\email}[1]{~$<$#1$>$}
\newcommand{\gloss}[1]{#1}                % entrada del glosario
\newcommand{\filename}[1]{\texttt{#1}}
\newcommand{\varname}[1]{\texttt{#1}}
\newcommand{\type}[1]{\texttt{#1}}        % tipo de dato o clase


\usepackage{nameref}
\let\oldnameref=\nameref
\renewcommand{\nameref}[1]{«\oldnameref{#1}»}

\def\texcmd#1{\texttt{$\backslash$#1}}

\usepackage{cedv-config}

\newcommand{\loremipsum}{%
  \textcolor{gray}{Suspendisse aliquet diam pellentesque lectus posuere eu
    vehicula velit aliquet. Cras iaculis, quam quis venenatis venenatis, nulla leo porta
    mi, lacinia hendrerit arcu lorem et dui.}
  \par
  \textcolor{gray}{
    Nullam varius dui sit amet dui scelerisque consectetur. Nullam tortor est, ullamcorper
    viverra ullamcorper a, convallis et nisl. Phasellus nunc ligula, fermentum quis
    iaculis at, consectetur vel diam. Aliquam tincidunt orci eget ante mollis pulvinar. In
    hac habitasse platea dictumst. Suspendisse id tellus a ante mattis feugiat.}}


% http://tug.org/mailman/htdig/pstricks/2011/009122.html
\usepackage{etex}

\makeatother
