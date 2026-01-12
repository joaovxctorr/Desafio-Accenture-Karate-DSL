
Feature: Consultar livro específico por ID na API BookStore

  Background:
    Given url baseUrlBookstore + '/Book'
    # Aqui estou recebendo as variaveis da listagem de todos os livros para usa-las
    And def chamarTodosOsLivros = call read('classpath:features/books/listar-todos-os-livros.feature@ListarTodosOsLivros')
    And def isbnValido = chamarTodosOsLivros.capturarIdDoPrimeiroLivroDaLista
    And def livroSchema = read('classpath:features/books/schema/livro-schema.json')

  @ConsultarLivroPorID
  Scenario Outline: Validar busca de livro por ISBN - <cenario>
    Given param ISBN = <isbnInformado>
    When method get
    Then status <statusEsperado>
    And match response == <schemaOuMensagem>

    #prints
    And print '--------------------------'
    And print 'Cenário Testado:', '<cenario>'
    And print 'Status Code Recebido:', responseStatus
    And print 'Corpo da Resposta:', response
    And print '--------------------------'

    Examples:
      | cenario    | isbnInformado | statusEsperado | schemaOuMensagem                                          |
      | Sucesso    | isbnValido    | 200            | livroSchema                                               |
      | Inexistente| '1234567890'  | 400            | { "code": "1205", "message": "ISBN supplied is not available in Books Collection!" } |