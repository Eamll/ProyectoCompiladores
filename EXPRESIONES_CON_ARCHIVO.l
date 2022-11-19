%{
#include <stdio.h>
#include <stdlib.h>
%}
DIGITO [0-9]
SIGNO  [+-]
SIGNO_PAR_AB "("
SIGNO_PAR_CE ")"
SIGNO_ASIGNAR ":="
LLAVE_AB "{"
LLAVE_CE "}"
TIPOS_DATOS "char"|"int"|"double"
NUMERO_ENTERO {SIGNO}{DIGITO}+
NUMERO_SIN_SIGNO {DIGITO}+
LETRA_MINUSCULA  [a-z]
LETRA_MAYUSCULA  [A-Z]
PALABRA_MM {LETRA_MAYUSCULA}+
PALABRA_NN {LETRA_MINUSCULA}+
PALABRA_NM {LETRA_MINUSCULA}{LETRA_MAYUSCULA}+ 
PALABRA_MN {LETRA_MAYUSCULA}{LETRA_MINUSCULA}+
VARIABLE {LETRA_MAYUSCULA}{PALABRA_NN}{NUMERO_SIN_SIGNO}|{PALABRA_NN}{NUMERO_SIN_SIGNO}|{PALABRA_MM}
COMANDOS "if"|"repetir"|"asignar"
COMANDO_REP "while"|"for"
ASIGNAR {VARIABLE}{SIGNO_ASIGNAR}{VARIABLE}
CONDICIONAL {SIGNO_PAR_AB}{ASIGNAR}{SIGNO_PAR_CE}
EST_REP_COND {COMANDO_REP}{CONDICIONAL}{LLAVE_AB}{LLAVE_CE}

%%
{NUMERO_ENTERO} {printf ("es un numero entero - ");}
{NUMERO_SIN_SIGNO} {printf ("Es un numero sin signo - ");}
{VARIABLE} {printf ("Esto es una variable - ");}
{PALABRA_MM}|{PALABRA_NM} {printf ("Palabra - ");}
{PALABRA_NM}|{PALABRA_MN} {printf ("Palabra nmmn - ");}
{COMANDOS}    {printf ("Instruccion - ");}
{ASIGNAR}  {printf ("Asignar - ");}
{COMANDO_REP} {printf ("Comando de repeticion - ");}
{EST_REP_COND} {printf ("Condicional - ");}
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