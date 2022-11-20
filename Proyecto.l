%{
#include <stdio.h>
#include <stdlib.h>
%}
DIGITO [0-9]
SIGNO  [+-]
ESPACIO " "
SIGNO_PTOCOMA ";"
PAR_AB "("
PAR_CE ")"
SIGNO_ASIGNAR ":="
LLAVE_AB "{"
LLAVE_CE "}"
MENOR_QUE "<"
MENOR_IGUAL_QUE "<="
MAYOR_QUE ">"
MAYOR_IGUAL_QUE ">="
IGUAL "=="
DISTINTO "<>"
WHILE "while"

OP_LOGICOS {MENOR_QUE}|{MENOR_IGUAL_QUE}|{MAYOR_QUE}|{MAYOR_IGUAL_QUE}|{IGUAL}|{DISTINTO}
TIPOS_DATOS "char"|"int"|"double"
NUMERO_ENTERO {SIGNO}{DIGITO}+
NUMERO_SIN_SIGNO {DIGITO}+
LETRA_MINUS  [a-z]
LETRA_MAYUS  [A-Z]
PALABRA_MM {LETRA_MAYUS}+
PALABRA_NN {LETRA_MINUS}+

VARIABLE {LETRA_MAYUS}{PALABRA_NN}{NUMERO_SIN_SIGNO}|{PALABRA_NN}{NUMERO_SIN_SIGNO}|{PALABRA_MM}
ASIGNAR {TIPOS_DATOS}{ESPACIO}{VARIABLE}{SIGNO_ASIGNAR}{VARIABLE}{SIGNO_PTOCOMA}

INSTRUCCION {ASIGNAR}
CONDICIONAL {VARIABLE}{OP_LOGICOS}{VARIABLE}
REP_COND_WHILE {WHILE}{PAR_AB}{CONDICIONAL}{PAR_CE}{LLAVE_AB}{INSTRUCCION}{LLAVE_CE}

/*** Puesto a ser probado

CONDICIONAL_FOR {PAR_AB}{ASIGNAR}{SIGNO_PTOCOMA}{CONDICIONAL}{INSTRUCCION}{PAR_CE}
***/

%%
{NUMERO_ENTERO} {printf ("es un numero entero - ");}

{VARIABLE} {printf ("Esto es una variable - ");}
{ASIGNAR}  {printf ("Asignacion de variable - ");}
{REP_COND_WHILE} {printf ("Esto es un while completo- ");}
{TIPOS_DATOS} {printf ("Este es un tipo de dato - ");}

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