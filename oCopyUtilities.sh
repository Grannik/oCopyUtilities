#!/bin/bash
 E='echo -e';
 e='echo -en';
#
 i=0; CLEAR; CIVIS;NULL=/dev/null
 trap "R;exit" 2
 ESC=$( $e "\e")
 TPUT(){ $e "\e[${1};${2}H" ;}
 CLEAR(){ $e "\ec";}
 CIVIS(){ $e "\e[?25l";}
 R(){ CLEAR ;stty sane;CLEAR;};                 # в этом варианте фон прозрачный
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
#
 UNMARK(){ $e "\e[41;30m";}
 MARK(){ $e "\e[47;31m";}
#
 HEAD()
{
 for (( a=2; a<=15; a++ ))
          do
              TPUT $a 1
                        $E "\e[47;30m│                                                                                │\e[0m";
          done
              TPUT  1 1;$E "\033[47;30m┌────────────────────────────────────────────────────────────────────────────────┐\033[0m"
              TPUT  2 3;$E "\e[47;1;31m*** Copy Utilities ***\e[0m";
              TPUT  3 3;$E "\e[47;31m    Утилиты копирования\e[0m";
              TPUT  4 1;$E "\e[47;30m├\e[1;30m────────────────────────────────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m";
              TPUT 12 1;$E "\e[47;30m├\e[1;30m────────────────────────────────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m";
              TPUT 14 1;$E "\e[47;30m├\e[30m─ Up \xE2\x86\x91 \xE2\x86\x93 Down Select Enter ─────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m";
}
 FOOT(){ MARK;TPUT 16 1;$E "\033[47;30m└────────────────────────────────────────────────────────────────────────────────┘\033[0m";UNMARK;}
#
  M0(){ TPUT  5 3; $e " [ dd       ] Kопирование данных из одного места в другое на двоичном уровне ";}
  M1(){ TPUT  6 3; $e " [  cp      ]                                                                ";}
  M2(){ TPUT  7 3; $e " [ gcp      ]                                                                ";}
  M3(){ TPUT  8 3; $e " [ progress ]                                                                ";}
  M4(){ TPUT  9 3; $e " [  mv      ]                                                                ";}
  M5(){ TPUT 10 3; $e " [ mmv      ]                                                                ";}
  M6(){ TPUT 11 3; $e " [ rename   ]                                                                ";}
#
  M7(){ TPUT 13 3; $e " Grannik Git                                                                 ";}
#
  M8(){ TPUT 15 3; $e " Exit                                                                        ";}
LM=8
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
  0) S=M0;SC; if [[ $cur == enter ]];then R;man dd;ES;fi;;
  1) S=M1;SC; if [[ $cur == enter ]];then R;man cp;ES;fi;;
  2) S=M2;SC; if [[ $cur == enter ]];then R;man gcp;ES;fi;;
  3) S=M3;SC; if [[ $cur == enter ]];then R;man progress;ES;fi;;
  4) S=M4;SC; if [[ $cur == enter ]];then R;man mv;ES;fi;;
  5) S=M5;SC; if [[ $cur == enter ]];then R;man mmv;ES;fi;;
  6) S=M6;SC; if [[ $cur == enter ]];then R;man rename;ES;fi;;
#
 7) S=M7;SC;if [[ $cur == enter ]];then R;echo -e "
 Fr 01 Jul 2022
 o               file общее меню
 s - source      file источник
 m - menu        file меню
 n - simple menu file простое меню
 l - bash list   file лист
 t - text        file текстовый файл
 oCopyUtilities описание утилит копирования.
 Gogs       \e[36m https://try.gogs.io/Grannik/oCopyUtilities\e[0m
 Gitea      \e[36m https://try.gitea.io/Grannik/oCopyUtilities\e[0m
 Framagit   \e[36m https://framagit.org/GrannikOleg/ocopyutilities\e[0m
 Bitbucket  \e[36m https://bitbucket.org/grannikoleg/workspace/projects/OC\e[0m
 Codeberg   \e[36m https://codeberg.org/Grannik/oCopyUtilities\e[0m
 Notabug    \e[36m https://notabug.org/Grannikoleg/oCopyUtilities\e[0m
 Sourceforge\e[36m https://sourceforge.net/projects/ocopyutilities/files/\e[0m
 Gitlab     \e[36m https://gitlab.com/grannik/ocopyutilities\e[0m
 Github     \e[36m https://github.com/GrannikOleg/oCopyUtilities\e[0m
 Asciinema  \e[36m https://asciinema.org/a/505353\e[0m
";ES;fi;;
 8) S=M8;SC;if [[ $cur == enter ]];then R;clear;ls -l;exit 0;fi;;
 esac;POS;done
