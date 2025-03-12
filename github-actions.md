### Workflow

- Um workflow é o arquivo YAML que define a automação completa (CI/CD).
- Ele pode ter vários jobs que são executados juntos ou separadamente.
- O workflow é acionado por eventos como push, PR, schedule, etc.

```sh
.github/workflows/meu-workflow.yml
```

### Jobs

- Um job é um conjunto de passos (steps) que são executados em sequência.
- Cada job roda em um runner separado e pode ser independente ou depender de outro job.

```yaml
jobs:
  job1:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Executando Job 1"

  job2:
    needs: job1  # Espera o Job 1 terminar antes de rodar
    runs-on: ubuntu-latest
    steps:
      - run: echo "Executando Job 2"
```

### Steps

- Os steps são os comandos dentro de um job.
- Podem executar scripts diretamente `run:` ou usar ações prontas `uses:`.

```yaml
jobs:
  example-job:
    runs-on: ubuntu-latest
    steps:
      - name: Passo 1 - Checkout do código # Por padrão, o código-fonte do repositório não é automaticamente baixado pelo GitHub Actions, por isso usar a actions/checkout é importante.
        uses: actions/checkout@v3

      - name: Passo 2 - Rodar comando
        run: echo "Executando um comando no step 2"
```

### Actions

- Actions são funcionalidades reutilizáveis que podem ser usadas nos steps.
- Existem actions oficiais do GitHub e de terceiros.
- Você pode criar suas próprias actions.

```yaml
jobs:
  example-job:
    runs-on: ubuntu-latest
    steps:
      - name: Usando uma action para instalar o Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
```