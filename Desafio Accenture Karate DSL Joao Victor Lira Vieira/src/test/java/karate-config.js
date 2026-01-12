function fn() {
    var env = karate.env; // get system property 'karate.env'
    var config = {env: env} //objeto de configuração global
    // var headers = {"cache-control": "no-cache", "Content-Type": "application/json"} //headers fixos em todas as requests

    var config = {
        baseUrlAccount: "https://bookstore.toolsqa.com/Account/v1",
        baseUrlBookstore: "https://bookstore.toolsqa.com/BookStore/v1"
    };

    karate.log('karate.env system property was:', env);

    //Define ambiente padrão se não for informado o karate env
    // if (!env) { env = 'qa'; }
    //
    // switch (env) {
    //
    //     case 'qa':
    //         config = karate.read('classpath:features/support/config/baseUrl.yaml')['qa']
    //
    //         break;
    //
    //     case 'des':
    //         config = karate.read('classpath:features/support/config/baseUrl.yaml')['dev']
    //         break;
    //
    //     default:
    // }

    karate.log('karate.env system property was:', env);
    // karate.configure('headers', headers);
    karate.configure('retry', {count: 10, interval: 5000}); //10 tentativas com invtervalo de 5 segundos

    return config;
}