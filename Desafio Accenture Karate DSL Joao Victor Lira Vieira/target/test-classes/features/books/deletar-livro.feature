@DeletarLivros
Feature: Remover livro da coleção do usuário na API BookStore

  Background:
    Given url baseUrlBookstore
    # Aqui estou recebendo as variaveis de autentificacao para usa-las
    And def auth = callonce read('classpath:features/auth/autenticacao.feature@Token')
    And def meuToken = auth.meuToken
    And def meuUserID = auth.variaveisCadastro.userID
    # Aqui estou recebendo as variaveis da lista de todos os livros para usa-las
    And def buscaLivros = callonce read('classpath:features/books/listar-todos-os-livros.feature@ListarTodosOsLivros')
    And def isbnDaLista = buscaLivros.response.books[0].isbn

    # Aqui estou fazendo uma validacao para garantir que exista um livro a ser excluido
    And path 'Books'
    And header Authorization = 'Bearer ' + meuToken
    And request { "userId": "#(meuUserID)", "collectionOfIsbns": [ { "isbn": "#(isbnDaLista)" } ] }
    And method post
    And match [201, 400] contains responseStatus

  @DeletarLivroComSucesso
  Scenario: Remover um livro específico da coleção com sucesso
    Given path 'Book'
    And param UserId = meuUserID
    And header Authorization = 'Bearer ' + meuToken
    And request { "isbn": "#(isbnDaLista)", "userId": "#(meuUserID)" }
    When method delete
    Then status 204

    #prints
    And print '----------------------------------------------------------------'
    And print 'Cenario: Remocao com Sucesso'
    And print 'ID do usuario:', meuUserID
    And print 'ID do livro removido:', isbnDaLista
    And print 'status recebido:', responseStatus
    And print '----------------------------------------------------------------'

  @DeletarLivroComFalha
  Scenario: Tentar remover livro com ISBN inexistente na coleção (400)
    And def isbnInexistente = '0000000000'

    Given path 'Book'
    And param UserId = meuUserID
    And header Authorization = 'Bearer ' + meuToken
    And request { "isbn": "#(isbnInexistente)", "userId": "#(meuUserID)" }
    When method delete
    Then status 400
    And match response.code == '1206'
    And match response.message == "ISBN supplied is not available in User's Collection!"

    #prints
    And print '----------------------------------------------------------------'
    And print 'Cenario: ISBN Inexistente'
    And print 'ID do usuario:', meuUserID
    And print 'ISBN utilizado:', isbnInexistente
    And print 'status recebido:', responseStatus
    And print 'Mensagem de erro:', response.message
    And print '----------------------------------------------------------------'