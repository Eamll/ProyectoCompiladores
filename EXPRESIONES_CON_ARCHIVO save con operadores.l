%{
#include <stdio.h>
#include <stdlib.h>
%}
DIGITO [0-9]
SIGNO  [+-]
SIGNO_PTOCOMA ";"
PAR_AB "("
PAR_CE ")"
SIGNO_ASIGNAR ":="
LLAVE_AB "{"
LLAVE_CE "}"
TIPOS_DATOS "char"|"int"|"double"
MENOR_QUE "<"
MAYOR_QUE ">"
IGUAL "=="
DISTINTO "<>"

NUMERO_ENTERO {SIGNO}{DIGITO}+
NUMERO_SIN_SIGNO {DIGITO}+
LETRA_MINUS  [a-z]
LETRA_MAYUS  [A-Z]
PALABRA_MM {LETRA_MAYUS}+
PALABRA_NN {LETRA_MINUS}+
PALABRA_NM {LETRA_MINUS}{LETRA_MAYUS}+ 
PALABRA_MN {LETRA_MAYUS}{LETRA_MINUS}+

VARIABLE {LETRA_MAYUS}{PALABRA_NN}{NUMERO_SIN_SIGNO}|{PALABRA_NN}{NUMERO_SIN_SIGNO}|{PALABRA_MM}
ASIGNAR {TIPOS_DATOS}" "{VARIABLE}{SIGNO_ASIGNAR}{VARIABLE}
INSTRUCCION {ASIGNAR}{SIGNO_PTOCOMA}
INSTRUCCIONES {INSTRUCCION}|{INSTRUCCION}{INSTRUCCIONES}
OPERADORES_LOGICOS {MENOR_QUE}|{MAYOR_QUE}|{IGUAL}|{DISTINTO}
CONDICIONAL {VARIABLE}{OPERADORES_LOGICOS}{VARIABLE}
REP_COND_WHILE "while"{PAR_AB}{CONDICIONAL}{PAR_CE}{LLAVE_AB}{INSTRUCCIONES}{LLAVE_CE}



%%
{NUMERO_ENTERO} {printf ("es un numero entero - ");}
{NUMERO_SIN_SIGNO} {printf ("Es un numero sin signo - ");}
{VARIABLE} {printf ("Esto es una variable - ");}
{PALABRA_MM}|{PALABRA_NM} {printf ("Palabra - ");}
{PALABRA_NM}|{PALABRA_MN} {printf ("Palabra nmmn - ");}
{ASIGNAR}  {printf ("Asignacion de variable - ");}
{REP_COND_WHILE} {printf ("Esto es un while completo- ");}
{TIPOS_DATOS} {printf ("Este es un tipo de dato - ");}
{MAYOR_QUE} {printf ("Este es un mayorque - ");}
%%

int main (int argc, char *argv[])
{
   if (argc == 2)
   {
      yyin = fopen (argv[1], "rt");
      if (yyin == NULL)
      {
         printf ("El fichero %s no se puede abrir\n", argv[1]);
         exit (-1);
      }
   }
  else 
     yyin = stdin;
  yylex ();
   return 0;
  
}

int yywrap ()
{
  return 1;
}