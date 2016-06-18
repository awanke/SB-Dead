package cms.config;

import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import javax.servlet.ServletContext;

@Component
public class ServletContextHolder implements ServletContextAware {
    private static ServletContext servletContext;

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public static ServletContext getServletContext() {
        return servletContext;
    }

    public static String getRealPath() {
        return servletContext.getRealPath("/");
    }
}
