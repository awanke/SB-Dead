package cms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.PropertySource;

@SpringBootApplication
@PropertySource({"classpath:db-config.properties"})
public class Appliaction {

    public static void main(String[] args) {
        SpringApplication.run(Appliaction.class, args);
    }
}
