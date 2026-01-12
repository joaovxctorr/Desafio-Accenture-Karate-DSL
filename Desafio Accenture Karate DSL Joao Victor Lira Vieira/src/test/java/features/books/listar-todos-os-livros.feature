Feature: Listar todos os livros na API BookStore

  Background:

  @ListarTodosOsLivros
  Scenario: Listar todos os livros com sucesso
    Given url baseUrlBookstore + '/Books'
    When method get
    Then status 200
    #Aqui estou fazendo as validacoes do schema
    And match each response.books == read('classpath:features/books/schema/livro-schema.json')
    And def listaCompletaDeLivros = response.books
    #Aqui vou capturar o ID do primeiro livro para assim ser capaz de utiliza-lo depois
    And def capturarIdDoPrimeiroLivroDaLista = response.books[0].isbn
    And def tituloLivro = response.books[0].title

    #prints
    And print '-------------------------------------'
    * print 'Status da Resposta:', responseStatus
    * print 'Total de livros encontrados no catálogo:', listaCompletaDeLivros.length
    * print 'Informações do primeiro livro da lista:'
    * print 'ID do Livro:', capturarIdDoPrimeiroLivroDaLista
    * print 'Título:', tituloLivro
    And print '-------------------------------------'
    
    And print response