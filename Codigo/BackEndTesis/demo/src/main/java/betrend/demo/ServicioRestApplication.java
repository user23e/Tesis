package betrend.demo;
import java.util.Map;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ServicioRestApplication {

    @CrossOrigin
    @GetMapping(value = "/signIn", produces = "application/json")
    public int getSignIn(@RequestParam String emailInput, @RequestParam String passwordInput) throws Exception {
        Usuario usuario = new Usuario(emailInput, passwordInput);
        return usuario.signIn();
    }

    @CrossOrigin
    @GetMapping(value = "/signUp", produces = "application/json")
    public int getSignUp(@RequestParam String nameInput, @RequestParam String lastInput,
            @RequestParam String emailInput, @RequestParam String passwordInput, @RequestParam String countryInput,
            @RequestParam String spotifyInput) throws Exception {
        Usuario usuario = new Usuario(nameInput, lastInput, emailInput, passwordInput, countryInput, spotifyInput);
        return usuario.signUp();
    }

    @CrossOrigin
    @GetMapping(value = "/music1", produces = "application/json")
    public Map<String, Object> getMusic1(@RequestParam int userId, @RequestParam String nameSong) throws Exception {
        Usuario usuario = new Usuario();
        usuario.setUserId(userId);
        return usuario.Music(nameSong);
    }

    @CrossOrigin
    @GetMapping(value = "/profile", produces = "application/json")
    public Map<String, Object> getProfile(@RequestParam int userId) throws Exception {
        Usuario usuario = new Usuario();
        usuario.setUserId(userId);
        return usuario.Profile();
    }
}