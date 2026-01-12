
Feature: Deletar usuario na API BookStore

  Background:
    Given url baseUrlAccount + '/User'
    # Aqui estou recebendo as variaveis de autentificacao para usa-las
    And def auth = callonce read('classpath:features/auth/autenticacao.feature@Token')
    And def idParaDeletar = auth.variaveisCadastro.userID
    And def token = auth.meuToken
    And def usuario = auth.variaveisCadastro.userName

  @DeletarUsuario
  Scenario Outline: Validar exclusão de usuário - <cenario_teste>
    And def headerAuth = <enviarToken> == 'sim' ? 'Bearer ' + token : ''

    Given path idParaDeletar
    And header Authorization = headerAuth
    When method delete
    Then status <statusEsperado>
    And if (<statusEsperado> != 204) karate.match(response.message, 'User not authorized!')

    #Prints
    And print '-----------------------------------------------------------------'
    And print 'Cenario:', '<cenario_teste>'
    And print 'Tentativa de exclusao do Usuario: Nome: ' + usuario + ' | ID: ' + idParaDeletar
    And print '-----------------------------------------------------------------'

    Examples:
      | cenario_teste    | enviarToken | statusEsperado |
      | Sucesso          | 'sim'       | 204            |
      | Sem Autorização  | 'nao'       | 401            |