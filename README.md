  Sobre o Projeto:
  
Projeto Flappy Bird desenvolvido em Godot 4 com testes unitários implementados usando GUT (Godot Unit Test).

 Como Configurar o Projeto:
1. Pré-requisitos
Godot 4.2.1 ou superior instalado
GUT (Godot Unit Test) - Já incluído no projeto

2. Baixar e Abrir o Projeto
Faça o download do projeto (ZIP ou clone via Git)
Extraia os arquivos em uma pasta de sua preferência
Abra o Godot Engine
Clique em "Importar" e selecione a pasta do projeto
Abra o arquivo project.godot

  3.Executar os Testes Unitários:
Vá para a aba inferior do Godot e clique em "GUT"
Verifique se as configurações estão corretas:
Diretório de testes: res://tests/unit
Incluir subdiretórios: MARCADO
Ignore Pause: MARCADO
Clique no botão "Run All" para executar todos os testes
Os resultados aparecerão em verde (PASS) ou vermelho (FAIL)

 Funcionalidades Principais Testadas
Este projeto implementa e testa 3 sistemas principais com validação de regras de negócio:

  1. Sistema de Score e Pontuação
✅ Adicionar pontos
✅ Checar high score
✅ Resetar pontuação
✅ Emitir sinais de mudança de score

  2. Sistema de Estados do Personagem (Bird)
✅ Transição entre estados (FLYING, FLAPPING, HIT, GROUNDED)
✅ Detecção de colisões com pipes e chão
✅ Validação de mudanças de estado

  3. Sistema de Geração de Pipes (Obstáculos)
✅ Cálculo de posições iniciais
✅ Geração de posições aleatórias dentro dos limites
✅ Configuração de offsets e espaçamento
