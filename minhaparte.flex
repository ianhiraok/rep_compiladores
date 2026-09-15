/* -----------------------------------------------------------------------
 * 2. SECAO DE DEFINICOES
 * ------------------------------------------------------------------- */

DIGIT       [0-9]
LETRA       [a-zA-Z_]
ALFANUM     [a-zA-Z0-9_]

%x COMMENT
%x STR 
/* Adicionamos o estado STR para facilitar a leitura de strings */

%%

/* -----------------------------------------------------------------------
 * 3. SECAO DE REGRAS (Apenas as partes para modificar)
 * --------------------------------------------------------------------- */

 /* --- Palavras reservadas e identificadores --- */
{LETRA}{ALFANUM}*   {
                        /* TODO (Frente 1): Usar strcmp() para verificar se yytext 
                           é main, if, else, for, return, int, char ou print.
                           Se for, retornar o token específico. Se não, retornar ID. */
                        guarda_lexema();
                        return ID;
                    }

 /* --- Constantes inteiras --- */
{DIGIT}+            {
                        /* TODO (Frente 1): Tratar o sinal de menos (lookahead)
                           para diferenciar número negativo de subtração. */
                        guarda_lexema();
                        return INTEGERCONST;
                    }

 /* --- Constantes de caractere (Passo 1 concluído) --- */
'([^'\\\n]|\\.)'    {
                        guarda_lexema();
                        return CHARCONST;
                    }

'([^'\\\n]|\\.)*    {
                        microc_yylval.error_msg = "Constante de caractere nao terminada";
                        return UNDEF;
                    }

 /* --- Constantes de string (Estrutura para o Passo 2) --- */
\"                  { 
                        /* Inicia a leitura da string */
                        BEGIN(STR); 
                    }

<STR>\"             { 
                        /* TODO (Frente 2): Fim da string. Converter escapes (\n, \t, etc), 
                           salvar o lexema e retornar STRINGCONST */
                        BEGIN(INITIAL); 
                    }
<STR>\n             { 
                        /* TODO (Frente 2): Erro de string não fechada na mesma linha */ 
                    }
<STR><<EOF>>        { 
                        /* TODO (Frente 2): Erro de EOF antes de fechar a string */ 
                    }
<STR>\\0            { 
                        /* TODO (Frente 2): Erro de caractere nulo na string */ 
                    }
<STR>\\.            { 
                        /* TODO (Frente 2): Captura caracteres escapados válidos */ 
                    }
<STR>.              { 
                        /* TODO (Frente 2): Captura caracteres normais da string */ 
                    }

 /* --- Operadores relacionais e logicos --- */
"=="                { return EQ; }
"="                 { return ASSIGN; }

 /* TODO (Frente 1): Adicionar as regras para:
  * !=   -> NEQ
  * !    -> NOT
  * <=   -> LEQ
  * <    -> LT
  * >=   -> GEQ
  * >    -> GT
  * &&   -> AND
  * ||   -> OR
  */

%%
/* ... (Restante do arquivo permanece igual) ... */