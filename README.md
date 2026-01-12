# Automação de APIs - BookStore com Karate DSL
Este projeto consiste em uma suíte de testes automatizados para a API **BookStore**. A automação foi desenvolvida utilizando o **Karate DSL** para cobrir os endpoints de *Account* (gestão de acesso e tokens) e *BookStore* (operações de CRUD de livros), validando cenários de sucesso, falha e conformidade de dados.

# Tecnologias e Frameworks
* **Karate DSL:** Framework focado em BDD para testes de API, simplificando chamadas HTTP e asserções.
* **Maven:** Gerenciador de dependências e automação de build para execução dos testes.
* **Java 21:** Linguagem base utilizada para a infraestrutura de execução do projeto.
* **JUnit 5:** Runner utilizado para integração, execução paralela e geração de logs.

# Estrutura do Projeto
A organização dos arquivos no diretório `src/test/java/` segue a lógica de separação por responsabilidades:

* **features/auth:** Scripts voltados ao gerenciamento e validação de tokens de acesso.
* **features/books:** Contém os testes de consulta, adição, atualização e remoção de livros.
* **features/usuarios:** Contém os testes de cadastro e exclusão de contas de usuários.
* **KarateTest.java:** Runner Java que executa os testes
* **karate-config.js:** Configurações globais (URLs, credenciais e ambientes).

# Configurações e Variáveis
O gerenciamento de ambientes e dados globais é centralizado no arquivo `karate-config.js`. Este arquivo permite que as URLs base sejam injetadas dinamicamente nos scripts de teste, facilitando a manutenção e a escalabilidade do projeto.

* **Base URL Account:** `https://bookstore.toolsqa.com/Account/v1`
* **Base URL Bookstore:** `https://bookstore.toolsqa.com/BookStore/v1`

# Execução dos Testes
O projeto foi estruturado para suportar execuções **independentes** e **flexíveis**, permitindo validar funcionalidades isoladas ou fluxos completos através de filtros.

## Via Terminal (Maven)
A execução via terminal utiliza o Maven, permitindo rodar uma ou mais tags simultaneamente:
* mvn test "-Dkarate.options=--tags @NomeDaTag"`

## Via IDE (Runner Java)
A execução ocorre através do Runner `testParallelTags`, bastando editar o filtro diretamente no código:
* .tags("@NomeDaTag")`

# Tags Disponíveis
## Execução Individual
Abaixo estão as etiquetas utilizadas para filtrar os testes por funcionalidade:

### Usuários e Autenticação
* **@CriarUsuario:** Realiza o cadastro de novos usuários.
* **@Token:** Valida a geração de credenciais e tokens de acesso.
* **@DeletarUsuario:** Remove o usuário da base de dados.

### Livros
* **@ListarTodosOsLivros:** Consulta o catálogo completo da biblioteca.
* **@ConsultarLivroPorID:** Busca detalhes de um livro específico via ISBN.
* **@AssociarLivro:** Adiciona livros à coleção do usuário.
* **@AtualizarLivro:** Substitui livros dentro da coleção do usuário.
* **@DeletarLivros:** Remove livros da coleção do usuário.

## Execução Combinada
Para rodar todos os testes de um módulo de uma só vez, utilize as tags agrupadas por vírgula no terminal:
* `mvn test "-Dkarate.options=--tags @ListarTodosOsLivros,@ConsultarLivroPorID,@AssociarLivro,@AtualizarLivro,@DeletarLivros"
*  mvn test "-Dkarate.options=--tags @CriarUsuario,@Token,@DeletarUsuario"

# Relatórios de Execução
O Karate DSL gera automaticamente relatórios detalhados após cada execução, permitindo visualizar o status de cada passo, o tempo de resposta e os logs de cada requisição HTTP.

Para visualizar os resultados:
* **Localização:** Navegue até o diretório `target/karate-reports/`.
* **Arquivo:** Abra o karate-summary.html no seu navegador para visualizar os resultados, tempos de resposta e evidências de cada requisição


