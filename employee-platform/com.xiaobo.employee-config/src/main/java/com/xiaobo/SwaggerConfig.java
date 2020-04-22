package com.xiaobo;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import springfox.documentation.builders.*;
import springfox.documentation.schema.ModelRef;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.ApiKey;
import springfox.documentation.service.Parameter;
import springfox.documentation.service.ResponseMessage;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.ArrayList;
import java.util.List;

import static com.google.common.collect.Lists.newArrayList;


@Configuration
@EnableSwagger2
@EnableWebMvc
public class SwaggerConfig  {
	
	@Value("${zxb.swagger.show:true}")
	private boolean swaggerShow;
 
	 
    @Bean
    public Docket createRestApi() {
    	//System.out.println("AAAAAAAAAAAA createRestApi DDDDDDDDDDDDDDDDDDDDD");
    	ParameterBuilder ticketPar = new ParameterBuilder();
        List<Parameter> pars = new ArrayList<Parameter>();  
    	ticketPar.name("token").description("user token")
    	.modelRef(new ModelRef("string")).parameterType("header") 
    	.required(false).build(); //header中的token参数非必填，传空也可以
    	pars.add(ticketPar.build());    //根据每个方法名也知道当前方法在设置什么参数
    	
    	List<ResponseMessage> responseMessageList = new ArrayList<>();
        responseMessageList.add(new ResponseMessageBuilder().code(404).message("找不到资源").responseModel(new ModelRef("ApiError")).build());
        responseMessageList.add(new ResponseMessageBuilder().code(401).message("token过期或者没有权限").responseModel(new ModelRef("ApiError")).build());
        
        responseMessageList.add(new ResponseMessageBuilder().code(409).message("业务逻辑异常").responseModel(new ModelRef("ApiError")).build());
        responseMessageList.add(new ResponseMessageBuilder().code(422).message("参数校验异常").responseModel(new ModelRef("ApiError")).build());
        responseMessageList.add(new ResponseMessageBuilder().code(500).message("服务器内部错误").responseModel(new ModelRef("ApiError")).build());
        responseMessageList.add(new ResponseMessageBuilder().code(503).message("Hystrix异常").responseModel(new ModelRef("ApiError")).build());
 
    	
        return new Docket(DocumentationType.SWAGGER_2)
        		.useDefaultResponseMessages(true)
        		.enable(swaggerShow)
        		.globalResponseMessage(RequestMethod.GET, responseMessageList)
        		.globalResponseMessage(RequestMethod.POST, responseMessageList)
        		//.globalResponseMessage(RequestMethod.PUT, responseMessageList)
        		//.globalResponseMessage(RequestMethod.DELETE, responseMessageList)

        		.apiInfo(apiInfo())
        		.select()
        		//加了ApiOperation注解的类，才生成接口文档
        		.apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))
        		.apis(RequestHandlerSelectors.withClassAnnotation(Api.class))
        		//包下的类，才生成接口文档
        		//.apis(RequestHandlerSelectors.basePackage("com.tr.controller"))
        		.paths(PathSelectors.any())

        		.build()
        		.globalOperationParameters(pars)
        		.securitySchemes(security());
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
            .title("员工信息管理系统 接口API")
            .description("员工信息管理系统 API文档")
            //.termsOfServiceUrl("http://www.gs-software.com/")
            .version("1.0.0")
            .build();
    }

    private List<ApiKey> security() {
        return newArrayList(
            new ApiKey("token", "token", "header")
        );
    }

}