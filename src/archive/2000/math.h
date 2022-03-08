%%-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=%%
%%     数学・物理記号マクロ                       %%
%%-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=%%

%======================================
% ベクトル、行列、演算子マクロ
%======================================

% ---- ベクトル(太文字) ＊矢印型は \vec{} を使う
\def\Vec#1{\mbox{\boldmath$#1$}}

% ---- 3次元ベクトルの成分表示
\def\vect#1#2#3{\begin{pmatrix}#1\cr#2\cr#3\end{pmatrix}} 

% ---- ノルム
\def\Norm#1{|{#1}|}

% ---- 行列
\def\Mat#1{{\rm\bf #1}}

% ---- 転置マーク
\def\Trans#1{#1\raisebox{1.0ex}{\tiny$\rm T$}\!}

% ---- 演算子
\def\Operator#1{\hat{#1}}

% ---- 期待値
\def\Mean#1{\langle{#1}\rangle}

% ---- 生成演算子
\def\Create#1{\hat{#1}^{\dagger}}

% ---- 消滅演算子
\def\Annihilate#1{\hat{#1}}

% ---- 昇演算子
\def\RaiseState#1{{#1}_{+}}

% ---- 降演算子
\def\LowerState#1{{#1}_{-}}

% ---- 電子軌道 \Psi_{\Orbit{1s}}
\def\Orbit#1{{\rm #1}}

%======================================
% 微分関連記号マクロ
%======================================

% ---- 全微分 \diff{x}
\def\d#1{\,{\rm d}#1}

% ---- 有限微小量デルタ(Δが直立)
\def\IDelta{{\mit\Delta}}

% ---- 常微分 \Deriver{x}{t}
\def\Deriver#1#2{{\frac{{\rm d} #1}{{\rm d} #2}}}

% ---- 偏微分 \Partial{q}{t}
\def\Partial#1#2{{\frac{\partial #1}{\partial #2}}}

% ---- テキスト埋め込み用 常微分 \tDeriver{x}{t}
\def\tDeriver#1#2{{\rm d} #1 / {\rm d} #2}

% ---- テキスト埋め込み用 偏微分 \tPartial{q}{t}
\def\tPartial#1#2{ \partial #1 / \partial #2}

% ---- 偏微分の記号
\def\del{\partial}

%======================================
% 詰め込み型 積分関連記号マクロ
%======================================

% ---- 無長沿字 \int_{\nsub{\infty}}
\def\nsub#1{\mbox{\hbox to 0pt{\scriptsize$#1$\hss}}}

% ---- 不定積分 \Uint{\d{x}} f(x)
\def\Uint#1{\int \!\!{#1}\,\,}

% ---- 定積分 \Dint{-1}{+1}{\d{x}} f(x)
\def\Dint#1#2#3{\int_{\nsub{#1}}^{\nsub{#2}}\!\!{#3}\,\,}

% ---- 広義積分 \Iint{\d{x}} f(x)
\def\Iint#1{\int_{\nsub{-\infty}}^{\nsub{+\infty}}{#1}\,\,}


%======================================
% 微分演算子マクロ
%======================================

% ---- ラプラシアン
\def\Laplacian{\triangle}

% ---- グラジエント
\def\Grad#1{{\rm grad\,}#1}

% ---- ダイバージェンス
\def\Div#1{{\rm div\,}#1}

% ---- ローテーション
\def\Rot#1{{\rm rot\,}#1}



%======================================
% ディラック流量子記号マクロ
%======================================

% ---- ブラ
\def\Bra#1{\langle{#1}|}

% ---- ケット
\def\Ket#1{|{#1}\rangle}

% ---- 内積
\def\Product#1#2{\langle{#1}|{#2}\rangle}

% ---- 外積
\def\Projection#1#2{|{#1}\rangle\langle{#2}|}

% ---- ３項ブラケット
\def\Bracket#1#2#3{\langle{#1}|{#2}|{#3}\rangle}





%======================================
% 数値表現用マクロ
%======================================

% ---- 指数表示 3.0 \Keta{8} \Unit{m}
\def\Keta#1{\times 10^{#1}}

% ---- 単位記号表示 3.0 \Keta{8} \Unit{m}
\def\Unit#1{\,{\rm #1}}

% ---- deg角度 90\deg
\def\deg{^{\circ}}

% ---- 温度
\def\degC{^{\circ}\!\rm C}

% ---- ミリモル／リットル 0.1 \mmol
\def\mmol{{\rm m\,mol/\ell}}

% ---- オングストローム 1.414 \Ang
\def\Ang{\mbox{\AA}}

% ---- 原子記号を陽子数と質量数つきで出力
\def\Atom#1#2#3{% #1 原子記号 #2 陽子数 #3 質量数
\kern-2ex\raisebox{0.8ex}{\hbox to 5ex{\hfill\scriptsize$#3$}}%
\kern-5ex%
\raisebox{-0.4ex}{\hbox to 5ex{\hfill\scriptsize$#2$}}{$\rm #1$}\,}




%======================================
% その他の表現のマクロ
%======================================

% ---- ∴ ゆえに
\def\Yueni{{.\raisebox{1.0ex}{.}.}\quad}

% ---- ∵ なぜならば
\def\Naze{{\raisebox{1.0ex}{.}.\raisebox{1.0ex}{.}}\quad}

% ---- 後退
\def\bquad{\!\!\!\!}
\def\bqquad{\!\!\!\!\!\!\!\!}

% ---- 複数行にわたる下線付き文章を書くマクロ (吉田寛君 提供)

\def\aster{*}
\newcommand{\underlineeng}[2][{}]{%
  \def\stuff{#2 }\ \ \leavevmode\lower.66ex\hbox{$ {}_{#1} \;\: $}%
  \expandafter\ulword\stuff * \ \ }
\def\ulword#1 {\def\one{#1}\kern-.5em\ifx\one\aster\let\next\relax
  \else\vtop{\hbox{\strut#1\ \ }\hrule\relax}
  \let\next\ulword\fi\next}


% ---- 定規の表示
\def\printruler{%
  {\unitlength=1cm%
  \begin{picture}(10,0.7)%
    \put(0,0){\line(1,0){10}}%
    \multiput(0,0)(1,0){11}{\line(0,1){0,7}}%
    \multiput(0,0)(0.5,0){20}{\line(0,1){0,5}}%
    \multiput(0,0)(0.1,0){100}{\line(0,1){0,3}}%
  \end{picture}}%
}

% ---- \displaystyleの簡易表現
\def\ds{\displaystyle}

% ---- 小さい添字
\def\ssub#1{\raisebox{-0.3ex}{\tiny$\rm #1$}}

% ---- 変形ギリシャ文字
\def\eps{\varepsilon}
\def\uchi{\raisebox{0.5ex}{$\chi$}}
\def\uphi{\raisebox{0.5ex}{$\varphi$}}

% ---- ボーア磁子
\def\muB{\mu\ssub{B}}

% ---- ボルツマン定数
\def\kB{k\ssub{B}}
