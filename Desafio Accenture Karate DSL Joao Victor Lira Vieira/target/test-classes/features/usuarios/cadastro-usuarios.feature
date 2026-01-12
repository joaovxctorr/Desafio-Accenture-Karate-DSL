@CriarUsuario
Feature: Cadastro de Usuários na API BookStore

  Background:
    Given url baseUrlAccount + '/User'
    And def Utils = Java.type('features.support.utils.Utils')
    #Schemas
    And def sucessoSchema = read('classpath:features/usuarios/dadosUsuarios/schemas/usuario-sucesso-schema.json')
    And def erroSchema = read('classpath:features/usuarios/dadosUsuarios/schemas/usuario-erro-schema.json')

  @CriarUsuarioComSucesso
  Scenario: Cadastro de usuario com sucesso
    And def emailAleatorio = Utils.gerarEmailFake()
    And def bodyRequest = read('classpath:features/usuarios/dadosUsuarios/cadastrar-usuario-com-sucesso.json')
    And set bodyRequest.userName = emailAleatorio

    Given request bodyRequest
    When method post
    Then status 201
    And match response == sucessoSchema

    #Aqui estou guardando as variaveis para serem usadas depois
    And def userID = response.userID
    And def userName = emailAleatorio
    And def password = bodyRequest.password
    And print 'Usuário Criado com Sucesso: ' + userName
    And print response

  @CriarUsuarioComFalha
  Scenario Outline: Validar erro ao cadastrar usuário - <cenario>
    Given request { "userName": "<userName>", "password": "<password>" }
    When method post
    Then status <statusEsperado>
    And match response == erroSchema
    And match response.message contains "<mensagemEsperada>"
    And print 'Cenário: <cenario> | Status: ' + responseStatus

    Examples:
      | cenario             | userName    | password     | statusEsperado | mensagemEsperada              |
      | Usuário Existente   | admin       | Password123! | 406            | User exists!                  |
      | Senha Sem Número    | user_test1  | Password!    | 400            | Passwords must have at least  |
      | Sem Usuário e Senha |             |              | 400            | UserName and Password required|