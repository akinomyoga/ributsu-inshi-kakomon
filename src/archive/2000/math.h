%%-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=%%
%%     ���w�E�����L���}�N��                       %%
%%-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=-=*=-=%%

%======================================
% �x�N�g���A�s��A���Z�q�}�N��
%======================================

% ---- �x�N�g��(������) �����^�� \vec{} ���g��
\def\Vec#1{\mbox{\boldmath$#1$}}

% ---- 3�����x�N�g���̐����\��
\def\vect#1#2#3{\begin{pmatrix}#1\cr#2\cr#3\end{pmatrix}} 

% ---- �m����
\def\Norm#1{|{#1}|}

% ---- �s��
\def\Mat#1{{\rm\bf #1}}

% ---- �]�u�}�[�N
\def\Trans#1{#1\raisebox{1.0ex}{\tiny$\rm T$}\!}

% ---- ���Z�q
\def\Operator#1{\hat{#1}}

% ---- ���Ғl
\def\Mean#1{\langle{#1}\rangle}

% ---- �������Z�q
\def\Create#1{\hat{#1}^{\dagger}}

% ---- ���ŉ��Z�q
\def\Annihilate#1{\hat{#1}}

% ---- �����Z�q
\def\RaiseState#1{{#1}_{+}}

% ---- �~���Z�q
\def\LowerState#1{{#1}_{-}}

% ---- �d�q�O�� \Psi_{\Orbit{1s}}
\def\Orbit#1{{\rm #1}}

%======================================
% �����֘A�L���}�N��
%======================================

% ---- �S���� \diff{x}
\def\d#1{\,{\rm d}#1}

% ---- �L�������ʃf���^(��������)
\def\IDelta{{\mit\Delta}}

% ---- ����� \Deriver{x}{t}
\def\Deriver#1#2{{\frac{{\rm d} #1}{{\rm d} #2}}}

% ---- �Δ��� \Partial{q}{t}
\def\Partial#1#2{{\frac{\partial #1}{\partial #2}}}

% ---- �e�L�X�g���ߍ��ݗp ����� \tDeriver{x}{t}
\def\tDeriver#1#2{{\rm d} #1 / {\rm d} #2}

% ---- �e�L�X�g���ߍ��ݗp �Δ��� \tPartial{q}{t}
\def\tPartial#1#2{ \partial #1 / \partial #2}

% ---- �Δ����̋L��
\def\del{\partial}

%======================================
% �l�ߍ��݌^ �ϕ��֘A�L���}�N��
%======================================

% ---- �������� \int_{\nsub{\infty}}
\def\nsub#1{\mbox{\hbox to 0pt{\scriptsize$#1$\hss}}}

% ---- �s��ϕ� \Uint{\d{x}} f(x)
\def\Uint#1{\int \!\!{#1}\,\,}

% ---- ��ϕ� \Dint{-1}{+1}{\d{x}} f(x)
\def\Dint#1#2#3{\int_{\nsub{#1}}^{\nsub{#2}}\!\!{#3}\,\,}

% ---- �L�`�ϕ� \Iint{\d{x}} f(x)
\def\Iint#1{\int_{\nsub{-\infty}}^{\nsub{+\infty}}{#1}\,\,}


%======================================
% �������Z�q�}�N��
%======================================

% ---- ���v���V�A��
\def\Laplacian{\triangle}

% ---- �O���W�G���g
\def\Grad#1{{\rm grad\,}#1}

% ---- �_�C�o�[�W�F���X
\def\Div#1{{\rm div\,}#1}

% ---- ���[�e�[�V����
\def\Rot#1{{\rm rot\,}#1}



%======================================
% �f�B���b�N���ʎq�L���}�N��
%======================================

% ---- �u��
\def\Bra#1{\langle{#1}|}

% ---- �P�b�g
\def\Ket#1{|{#1}\rangle}

% ---- ����
\def\Product#1#2{\langle{#1}|{#2}\rangle}

% ---- �O��
\def\Projection#1#2{|{#1}\rangle\langle{#2}|}

% ---- �R���u���P�b�g
\def\Bracket#1#2#3{\langle{#1}|{#2}|{#3}\rangle}





%======================================
% ���l�\���p�}�N��
%======================================

% ---- �w���\�� 3.0 \Keta{8} \Unit{m}
\def\Keta#1{\times 10^{#1}}

% ---- �P�ʋL���\�� 3.0 \Keta{8} \Unit{m}
\def\Unit#1{\,{\rm #1}}

% ---- deg�p�x 90\deg
\def\deg{^{\circ}}

% ---- ���x
\def\degC{^{\circ}\!\rm C}

% ---- �~�������^���b�g�� 0.1 \mmol
\def\mmol{{\rm m\,mol/\ell}}

% ---- �I���O�X�g���[�� 1.414 \Ang
\def\Ang{\mbox{\AA}}

% ---- ���q�L����z�q���Ǝ��ʐ����ŏo��
\def\Atom#1#2#3{% #1 ���q�L�� #2 �z�q�� #3 ���ʐ�
\kern-2ex\raisebox{0.8ex}{\hbox to 5ex{\hfill\scriptsize$#3$}}%
\kern-5ex%
\raisebox{-0.4ex}{\hbox to 5ex{\hfill\scriptsize$#2$}}{$\rm #1$}\,}




%======================================
% ���̑��̕\���̃}�N��
%======================================

% ---- �� �䂦��
\def\Yueni{{.\raisebox{1.0ex}{.}.}\quad}

% ---- �� �Ȃ��Ȃ��
\def\Naze{{\raisebox{1.0ex}{.}.\raisebox{1.0ex}{.}}\quad}

% ---- ���
\def\bquad{\!\!\!\!}
\def\bqquad{\!\!\!\!\!\!\!\!}

% ---- �����s�ɂ킽�鉺���t�����͂������}�N�� (�g�c���N ��)

\def\aster{*}
\newcommand{\underlineeng}[2][{}]{%
  \def\stuff{#2 }\ \ \leavevmode\lower.66ex\hbox{$ {}_{#1} \;\: $}%
  \expandafter\ulword\stuff * \ \ }
\def\ulword#1 {\def\one{#1}\kern-.5em\ifx\one\aster\let\next\relax
  \else\vtop{\hbox{\strut#1\ \ }\hrule\relax}
  \let\next\ulword\fi\next}


% ---- ��K�̕\��
\def\printruler{%
  {\unitlength=1cm%
  \begin{picture}(10,0.7)%
    \put(0,0){\line(1,0){10}}%
    \multiput(0,0)(1,0){11}{\line(0,1){0,7}}%
    \multiput(0,0)(0.5,0){20}{\line(0,1){0,5}}%
    \multiput(0,0)(0.1,0){100}{\line(0,1){0,3}}%
  \end{picture}}%
}

% ---- \displaystyle�̊ȈՕ\��
\def\ds{\displaystyle}

% ---- �������Y��
\def\ssub#1{\raisebox{-0.3ex}{\tiny$\rm #1$}}

% ---- �ό`�M���V������
\def\eps{\varepsilon}
\def\uchi{\raisebox{0.5ex}{$\chi$}}
\def\uphi{\raisebox{0.5ex}{$\varphi$}}

% ---- �{�[�A���q
\def\muB{\mu\ssub{B}}

% ---- �{���c�}���萔
\def\kB{k\ssub{B}}
