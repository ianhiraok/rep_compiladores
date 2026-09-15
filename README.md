aluno: 2024.1905.026-3
aluno: 2024.1905.054-9
aluno: 2024.1905.017-4
uso_ia: sim

# Trabalho Prático 1: Análise Léxica para Micro C

Trabalho Prático 1 da disciplina **Compiladores I (FACOM)**: implementação, a partir do esqueleto `microc.flex`, de um **analisador léxico (scanner)** para a linguagem **Micro C**, usando **Flex**. Reconhece palavras reservadas, identificadores (com tabela de símbolos), constantes, operadores e delimitadores, além de identificar e reportar erros léxicos.

O executável de teste `lexer` (ver Seção 6 do enunciado) lê um arquivo `.mc` e imprime, para cada token reconhecido, seu tipo, o lexema correspondente e a linha em que foi encontrado:

```
Token: tipo = INT lexema = 'int' linha = 1
Token: tipo = ID lexema = 'x' linha = 1
Token: tipo = ASSIGN lexema = '=' linha = 1
Token: tipo = INTEGERCONST lexema = '10' linha = 1
Token: tipo = SEMICOLON lexema = ';' linha = 1
```

Erros léxicos (token `UNDEF`) são impressos na saída de erro padrão (`stderr`) no formato:

```
ERRO LEXICO (linha N): <mensagem de erro>
```

O enunciado completo do trabalho está disponível em [`TP1_Analise_Lexica_MicroC.pdf`](./TP1_Analise_Lexica_MicroC.pdf).

## 📁 Estrutura do repositório

```
comp1-2026/
├── microc.flex                    # Especificação léxica (arquivo principal)
├── minhaparte.flex                # Rascunho/parte de desenvolvimento individual
├── tests/                         # Programas de exemplo em Micro C usados como entrada de teste
├── TP1_Analise_Lexica_MicroC.pdf  # Enunciado do trabalho
├── leiame.txt                     # Instruções originais do professor
├── USO_IA.md                      # Registro do uso de ferramentas de IA no desenvolvimento
└── README.md                      # Este arquivo
```

## ✅ Itens implementados

- [x] Reconhecimento das palavras reservadas: `main`, `if`, `else`, `for`, `return`, `int`, `char`, `print` (via `strcmp()`, demais sequências alfanuméricas viram `ID`)
- [x] Tabela de símbolos (lista encadeada) para armazenar lexemas únicos de `ID`, `INTEGERCONST`, `CHARCONST` e `STRINGCONST`, expostos em `microc_yylval.symbol`
- [x] Constantes de caractere (`CHARCONST`), incluindo escapes (`'\n'`, `'\t'`, `'\"'`, `'\''`, `'\\'`) e erro de aspas não fechadas/inválidas
- [x] Constantes de string (`STRINGCONST`), com estado exclusivo `<STR>`, conversão de sequências de escape (`\n`, `\t`, `\\`, `\"`, `\0`) e tratamento dos erros exigidos na Seção 4.1 do enunciado: `EOF em string`, `String nao terminada`, `String contem caractere nulo`, `EOF em comentario` e `Comentario nao iniciado`
- [x] Operadores relacionais e lógicos com prefixo compartilhado: `!=`, `!`, `<=`, `<`, `>=`, `>`, `&&`, `||` (seguindo o exemplo já implementado para `==` e `=`)
- [x] Tratamento de constantes inteiras negativas (`"-"{DIGIT}+`), diferenciando-as do operador de subtração
- [x] Especificação léxica completa (toda entrada corresponde a alguma regra, inclusive a regra de erro no final do arquivo)
- [x] Nenhuma instrução de depuração além do `main()` de teste previsto no enunciado (Seção 6)
- [ ] Ampliação de `tests/test.mc` cobrindo também casos de erro léxico (ver observações abaixo)

## 🔧 Como compilar

No diretório do projeto, execute:

```bash
flex microc.flex
gcc lex.yy.c -o lexer
```

O primeiro comando gera o arquivo `lex.yy.c` a partir das regras definidas em `microc.flex`. O segundo compila esse código gerado, produzindo o executável `lexer`. Ver `leiame.txt` para instruções adicionais.

## ▶️ Como executar

```bash
./lexer tests/test.mc
```

O programa lê o arquivo Micro C informado, imprime os tokens reconhecidos e reporta eventuais erros léxicos.

## 🤖 Uso de IA

O uso de ferramentas de IA (Gemini e Claude) como apoio conceitual durante o desenvolvimento está documentado em [`USO_IA.md`](./USO_IA.md), incluindo trecho afetado, finalidade do uso e o que foi feito com cada resposta.

## 👤 Autor(es)

| Nome | Matrícula |
|------|-----------|
| Heitor Monteiro Padovese | 2024.1905.026-3 |
| Ian Hiraoka Gaidarji | 2024.1905.054-9 |
| Yan Lucas Galvão Almeida | 2024.1905.017-4 |

## 🎓 Disciplina

- **Curso:** Compiladores I
- **Instituição:** FACOM
- **Trabalho:** TP1 — Análise Léxica para a linguagem Micro C

A submissão deve seguir as instruções específicas informadas pelo professor no AVA (Moodle), dentro do prazo estabelecido no cronograma da disciplina.
