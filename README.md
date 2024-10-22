# Batalha Naval em Assembly 8086

## Descrição do Projeto

Este repositório contém a implementação de um jogo de Batalha Naval em Assembly 8086, desenvolvido para rodar no ambiente DOS usando MASM/TASM. O jogo permite que um jogador posicione seus navios e ataque o de seu openente que é controlado pelo computador. Ganha quem derrubar todas embarcações inimigas primeiro

## Desafios

Desenvolver em Assembly 8086 apresenta vários desafios que tornam o projeto especialmente complexo:

- **Baixo Nível de Abstração**: Assembly é uma linguagem extremamente detalhista, onde cada instrução afeta diretamente o hardware. Diferente de linguagens de alto nível, cada pequeno passo no jogo, desde exibir algo na tela até processar uma entrada do jogador, precisa ser cuidadosamente construído.
  
- **Controle Manual de Recursos**: O jogo precisa lidar diretamente com o hardware, o que significa gerenciar memória, registradores e realizar operações de I/O (entrada e saída) de forma muito mais explícita do que em linguagens modernas.

- **Ambiente Limitado (DOS)**: Programar no DOS exige lidar com um ambiente minimalista, onde as interações com o sistema operacional são feitas por meio de interrupções e chamadas de sistema específicas. A ausência de bibliotecas modernas ou funções de alto nível aumenta a complexidade.

## Estrutura do Projeto

- **Código fonte**: Todos os arquivos `.asm` contendo a lógica do jogo.
- **Compilação**: Usamos o MASM/TASM para compilar o código Assembly 8086.
- **Execução**: O jogo é executado diretamente no DOS, em emuladores como DOSBox.

## Como Executar

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/batalha-naval-8086.git
Compile o código com MASM ou TASM:
bash
Copiar código
masm batalha_naval.asm;
ou
bash
Copiar código
tasm batalha_naval.asm;
Execute o arquivo .exe gerado no DOS ou em um emulador como DOSBox:
bash
Copiar código
batalha_naval.exe
Pré-requisitos
Assembler: MASM ou TASM.
Ambiente DOS: Um PC antigo rodando DOS ou um emulador como DOSBox.
