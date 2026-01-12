package features.support.utils;

import com.github.javafaker.Faker;

import java.util.Locale;

public class Utils {

    private static final Faker faker = new Faker(new Locale("pt-BR"));

    /**
     * Gera um e-mail fake e realista
     * Exemplo: joao.silva@gmail.com
     */
    public static String gerarEmailFake() {
        return faker.internet().emailAddress();
    }
}