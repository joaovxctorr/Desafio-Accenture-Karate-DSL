
Feature: Associar livro a um usuário na API BookStore

  Background:
    Given url baseUrlBookstore + '/Books'

    # Aqui estou recebendo as variaveis de autentificacao para usa-las
    And def auth = callonce read('classpath:features/auth/autenticacao.feature@Token')
    And def meuToken = auth.meuToken
    And def meuUserID = auth.variaveisCadastro.userID
    And def meuUsuario = auth.variaveisCadastro.userName

    # Aqui estou recebendo as variaveis da lista de todos os livros para conseguir reaproveita-las
    And def buscaLivros = call read('classpath:features/books/listar-todos-os-livros.feature@ListarTodosOsLivros')
    And def isbnDinamico = buscaLivros.response.books[0].isbn

  @AssociarLivro
  Scenario Outline: Validar associação de livros - <cenario_teste>
    # Aqui estou fazendo a Lógica para o Token e para o ISBN
    And def headerAuth = <enviarToken> == 'sim' ? 'Bearer ' + meuToken : ''
    And def isbnFinal = <isbnUsado> == 'valido' ? isbnDinamico : <isbnUsado>

    Given header Authorization = headerAuth
    And request
      """
      {
        "userId": "#(meuUserID)",
        "collectionOfIsbns": [
          {
            "isbn": "#(isbnFinal)"
          }
        ]
      }
      """
    When method post
    Then status <statusEsperado>
    And match response contains <respostaEsperada>

    #prints
    And print 'Cenario de associaçao de: ' + '<cenario_teste>'
    And print 'Usuário:', meuUsuario
    And print 'ISBN usado na requisição:', isbnFinal
    And print 'Resposta da API:', response

    Examples:
      | cenario_teste      | enviarToken | isbnUsado    | statusEsperado | respostaEsperada                                                                 |
      | Sucesso            | 'sim'       | 'valido'     | 201            | { books: [{ isbn: "#string" }] }                                                 |
      | Sem Autorização    | 'nao'       | 'valido'     | 401            | { code: '1200', message: 'User not authorized!' }                                |
      | ISBN Inexistente   | 'sim'       | '0000000000' | 400            | { code: '1205', message: 'ISBN supplied is not available in Books Collection!' } |

