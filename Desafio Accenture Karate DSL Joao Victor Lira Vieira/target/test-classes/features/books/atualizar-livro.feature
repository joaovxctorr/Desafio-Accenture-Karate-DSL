
Feature: Atualizar livro na coleção do usuário na API BookStore

  Background:
    Given url baseUrlBookstore

    #Aqui estou recebendo as variaveis de associacao para conseguir reaproveita-las
    And def associacao = call read('classpath:features/books/associar-livro.feature@AssociarLivro')
    And def meuToken = associacao.meuToken
    And def meuUserID = associacao.meuUserID
    And def isbnAntigo = associacao.isbnDinamico

    #Aqui estou recebendo as variaveis da lista de todos os livros para conseguir reaproveita-las
    And def buscaGeral = call read('classpath:features/books/listar-todos-os-livros.feature@ListarTodosOsLivros')
    And def isbnNovo = buscaGeral.response.books[1].isbn

  @AtualizarLivro
  Scenario Outline: Validar atualização de livro - <cenario_teste>
    And def headerAuth = <enviarToken> == 'sim' ? 'Bearer ' + meuToken : ''

    Given path 'Books/' + isbnAntigo
    And header Authorization = headerAuth
    And request
      """
      {
        "userId": "#(meuUserID)",
        "isbn": "#(isbnNovo)"
      }
      """
    When method put
    Then status <statusEsperado>
    And match response contains <respostaEsperada>

    #Prints
    And print '-----------------------------------------------------------------'
    And print 'Cenario Executado:', '<cenario_teste>'
    And print 'Url Da Chamada:', karate.prevRequest.url
    And print 'O ID do usuario:', meuUserID
    And print 'A troca de livros: saindo (' + isbnAntigo + ') -> e entrando (' + isbnNovo + ')'
    And print 'RESPOSTA COMPLETA:', response
    And print '-----------------------------------------------------------------'

    Examples:
      | cenario_teste   | enviarToken | statusEsperado | respostaEsperada                                  |
      | Sucesso         | 'sim'       | 200            | { userId: "#(meuUserID)" }                        |
      | Sem Autorização | 'nao'       | 401            | { code: '1200', message: 'User not authorized!' } |