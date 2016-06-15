package cms.config.sitemesh;

import javax.validation.Validator;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.opensymphony.sitemesh.webapp.SiteMeshFilter;

@Configuration
public class SiteMeshFilterConfig {

	@Bean
	public Validator validator() {
		return new org.springframework.validation.beanvalidation.LocalValidatorFactoryBean();
	}

	@Bean(name = "siteMeshFilter")
	public SiteMeshFilter characterEncodingFilter() {
		SiteMeshFilter bean = new SiteMeshFilter();
		return bean;
	}
}
