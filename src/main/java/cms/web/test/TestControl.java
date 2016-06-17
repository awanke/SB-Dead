package cms.web.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestControl {

    @ResponseBody
    @RequestMapping("/test")
    public String test() {
        return "test";
    }
}
