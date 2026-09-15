# USO_IA.md

Registro do uso de ferramentas de IA (Gemini e Claude) como apoio conceitual durante a implementação do analisador léxico de Micro C (`microc.flex`). Em todos os casos, a IA foi usada apenas para esclarecer conceitos e técnicas do Flex/C; a escrita do código das regras e funções foi feita manualmente, adaptando o entendimento obtido às necessidades específicas do trabalho.

---

### 1. Ferramenta: Gemini
* **Trecho ou arquivo afetado:** Regras de reconhecimento de constantes de caractere (`CHARCONST`) e conversão de sequências de escape em `microc.flex`.
* **Finalidade do uso:** Pedi uma explicação conceitual sobre como formular expressões regulares no Flex para isolar aspas simples e lidar com a barra invertida, além de ideias de como substituir os caracteres de escape via código C.
* **O que você fez com a resposta:** Compreendi a lógica de precedência (longest match e ordem das regras) explicada pela ferramenta e escrevi sozinho as três regras em cascata para capturar os caracteres válidos e o erro de aspas não fechadas. A partir da explicação teórica, também implementei manualmente a função `converter_escapes()` em C para iterar sobre a string.

### 2. Ferramenta: Gemini
* **Trecho ou arquivo afetado:** Declaração de estado exclusivo (`%x STR`) e leitura de constantes de string (`STRINGCONST`).
* **Finalidade do uso:** Solicitei uma explicação detalhada de como funcionam as *Start Conditions* (estados exclusivos) no Flex e como a função interna `yymore()` opera na memória intermediária (`yytext`).
* **O que você fez com a resposta:** Com o entendimento de como o autômato troca de contexto, projetei e codifiquei manualmente todo o bloco `<STR>`. Escrevi as regras de transição de estado usando `BEGIN(STR)` e `BEGIN(INITIAL)`, aplicando o `yymore()` para concatenar os lexemas lidos de forma correta.

### 3. Ferramenta: Gemini
* **Trecho ou arquivo afetado:** Tratamento de erros semânticos específicos dentro de strings (`UNDEF`).
* **Finalidade do uso:** Pedi para a IA esclarecer o comportamento do analisador quando atinge o fim de arquivo (`<<EOF>>`) ou lê quebras de linha não escapadas enquanto está travado dentro de uma *Start Condition*.
* **O que você fez com a resposta:** Entendi o mapeamento de exceções do Flex e estruturei o código sozinho para capturar esses casos de borda. Criei as regras dentro de `<STR>` para disparar o token `UNDEF` e preencher a variável `microc_yylval.error_msg` com as strings exatas cobradas no roteiro do trabalho (como "String nao terminada" e "EOF em string").

### 4. Ferramenta: Claude (Anthropic)
* **Trecho ou arquivo afetado:** Regra de reconhecimento de palavras reservadas em `microc.flex`.
* **Finalidade do uso:** Pedi confirmação conceitual sobre por que o Flex não consegue diferenciar palavras reservadas de identificadores só com regex, e qual é a técnica convencional (comparação com `strcmp()` dentro da ação) para resolver isso.
* **O que você fez com a resposta:** Escrevi as 8 comparações `strcmp()` eu mesmo(a), seguindo o padrão explicado, e adaptei para os nomes de token do meu enum.

### 5. Ferramenta: Claude (Anthropic)
* **Trecho ou arquivo afetado:** Operadores relacionais/lógicos com prefixo compartilhado (`!=`, `!`, `<=`, `<`, `>=`, `>`, `&&`, `||`) em `microc.flex`.
* **Finalidade do uso:** Pedi explicação de por que o exemplo pronto (`==`/`=`) funciona via "longest match" do Flex, para poder replicar o mesmo padrão nos demais operadores.
* **O que você fez com a resposta:** Escrevi as regras eu mesmo(a), replicando a estrutura do exemplo já fornecido no esqueleto.

### 6. Ferramenta: Claude (Anthropic)
* **Trecho ou arquivo afetado:** Regra de `INTEGERCONST` com sinal em `microc.flex`.
* **Finalidade do uso:** Pedi explicação do porquê "-" e dígito colado geram ambiguidade com o operador `MINUS`, e como o longest match do Flex resolve isso usando duas regras separadas.
* **O que você fez com a resposta:** Implementei a regra `"-"{DIGIT}+` como alternativa às duas regras separadas (mantendo a regra `{DIGIT}+` original), em vez da sugestão inicial com `"-?{DIGIT}+"`; entendi a limitação de que essa técnica não resolve casos como `a-5` corretamente, e sei explicar essa limitação na entrevista.

### 7. Ferramenta: Gemini
* **Trecho ou arquivo afetado:** Implementação da estrutura da tabela de símbolos (`Symbol`, `microc_yylval`) e integração da busca/inserção de lexemas em C no arquivo `microc.flex`.
* **Finalidade do uso:** Solicitei orientação sobre como integrar uma lista encadeada diretamente no código do Flex sem depender do gerador do Bison/Yacc, garantindo que o ponteiro `microc_yylval.symbol` armazenasse os lexemas únicos sem duplicação de memória conforme a especificação do trabalho.
* **O que você fez com a resposta:** Analisei a estrutura de alocação recomendada, compreendi a mecânica de verificação por `strcmp` para reaproveitamento de ponteiros e adaptei as regras do analisador léxico (`{ID}`, `{NUM}`, `STRINGCONST`) para repassar a referência de memória correta ao atribuir o valor do token.
