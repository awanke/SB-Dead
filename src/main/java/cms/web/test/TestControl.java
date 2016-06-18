package cms.web.test;

import cms.config.GlobalConfig;
import cms.config.ServletContextHolder;
import cms.utils.RegexUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class TestControl {

    @ResponseBody
    @RequestMapping("/test")
    public String test(HttpServletRequest request, HttpServletResponse response) {
        String requestURL = request.getRequestURL().toString();

//        http://localhost:8080/test
        System.out.println(requestURL);

//        http://localhost:8080
        System.out.println("http://" + RegexUtil.getRegexGroup("//(.*?)/", requestURL, 1));

//        C:\Users\hong\Desktop\SB-Dead\src\main\webapp\
        System.out.println(request.getServletContext().getRealPath("/"));

        System.out.println(ServletContextHolder.getRealPath());

        System.out.println(GlobalConfig.realPath);
        return "test";
    }
}
