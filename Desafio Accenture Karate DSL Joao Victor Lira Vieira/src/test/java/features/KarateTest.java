package features; //define onde o runner Java está.

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

//classe java que dispara os testes
class KarateTest {

    @Test
    void testParallel() {
        Results results = Runner
                .path("classpath:features") //Diz ao Karate: “Execute todos os .feature que estão no pacote features”
                .tags("@NomeDaTag") //Executa somente cenários ou features marcados com @
//                .outputCucumberJson(true)
                .parallel(5); //utiliza 5 usuários para realizar os testes
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
