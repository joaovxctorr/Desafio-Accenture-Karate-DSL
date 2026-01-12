
Feature: Gerar token para autenticação na API BookStore

  Background:
    Given url baseUrlAccount + '/GenerateToken'
    #Aqui eu estou recebendo as variaveis criadas do cadastro-usuarios.feature
    And def variaveisCadastro = call read('classpath:features/usuarios/cadastro-usuarios.feature@CriarUsuarioComSucesso')
    #Aqui estou criando variaveis novas para receber os dados que vem do cadastro-usuarios.feature
    And def usuarioCriado = variaveisCadastro.userName
    And def senhaCriada = variaveisCadastro.password

  @Token
  Scenario: Gerar token de acesso com sucesso
    Given request
    """
    {
      "userName": "#(usuarioCriado)",
      "password": "#(senhaCriada)"
    }
    """
    And print 'Criando o Token para o usuário:', usuarioCriado, '| Senha:', senhaCriada
    When method post
    Then status 200
    #Aqui estou fazendo o armazenamento do Token para usar em outros arquivos
    And def meuToken = response.token
    And print response


