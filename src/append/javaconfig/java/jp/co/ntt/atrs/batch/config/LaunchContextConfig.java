/*
 * Copyright (C) 2023 NTT Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */
package jp.co.ntt.atrs.batch.config;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.LocalCacheScope;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.batch.core.configuration.JobRegistry;
import org.springframework.batch.core.converter.JobParametersConverter;
import org.springframework.batch.core.launch.support.ExitCodeMapper;
import org.springframework.batch.core.launch.support.SimpleJvmExitCodeMapper;
import org.springframework.batch.item.validator.SpringValidator;
import org.springframework.batch.support.transaction.ResourcelessTransactionManager;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.ResourcePatternUtils;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.init.DataSourceInitializer;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.validation.Validator;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.terasoluna.batch.converter.JobParametersConverterImpl;

/**
 * Launch Context用のConfiguration。
 *
 * @author 電電次郎
 */
@Configuration
@Import(TerasolunaBatchConfiguration.class)
public class LaunchContextConfig {

    @Bean
    public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() throws Exception {
        PropertySourcesPlaceholderConfigurer config = new PropertySourcesPlaceholderConfigurer();
        config.setIgnoreResourceNotFound(false);
        config.setIgnoreUnresolvablePlaceholders(true);
        config.setOrder(1);
        config.setLocations(ResourcePatternUtils.getResourcePatternResolver(
                new DefaultResourceLoader()).getResources(
                        "classpath*:**/*.properties"));
        return config;
    }

    @Bean(destroyMethod = "close", name = "adminDataSource")
    public BasicDataSource adminDataSource(
            @Value("${admin.jdbc.driver}") String driverClassName,
            @Value("${admin.jdbc.url}") String url,
            @Value("${admin.jdbc.username}") String username,
            @Value("${admin.jdbc.password}") String password) {
        final BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName(driverClassName);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        dataSource.setMaxTotal(5);
        dataSource.setMinIdle(1);
        dataSource.setMaxWait(Duration.ofMillis(5000));
        dataSource.setDefaultAutoCommit(false);
        return dataSource;
    }

    @Bean
    public PlatformTransactionManager adminTransactionManager(
            @Qualifier("adminDataSource") BasicDataSource adminDataSource) {
        final DataSourceTransactionManager transactionManager = new DataSourceTransactionManager();
        transactionManager.setDataSource(adminDataSource);
        transactionManager.setRollbackOnCommitFailure(true);
        return transactionManager;
    }

    @Bean
    public JobParametersConverter jobParametersConverter(
            @Qualifier("adminDataSource") DataSource adminDataSource) {
        return new JobParametersConverterImpl(adminDataSource);
    }

    @Bean
    public ExitCodeMapper exitCodeMapper() {
        final SimpleJvmExitCodeMapper simpleJvmExitCodeMapper = new SimpleJvmExitCodeMapper();
        final Map<String, Integer> exitCodeMapper = new HashMap<>();
        // ExitStatus
        exitCodeMapper.put("NOOP", 0);
        exitCodeMapper.put("COMPLETED", 0);
        exitCodeMapper.put("STOPPED", 255);
        exitCodeMapper.put("FAILED", 255);
        exitCodeMapper.put("UNKNOWN", 255);
        exitCodeMapper.put("NORMAL", 0);
        exitCodeMapper.put("NORMAL_NONE_TARGET", 2);
        exitCodeMapper.put("WARNING", 10);
        exitCodeMapper.put("BUSINESS_ERROR", 100);
        exitCodeMapper.put("SYSTEM_ERROR", 255);
        simpleJvmExitCodeMapper.setMapping(exitCodeMapper);
        return simpleJvmExitCodeMapper;
    }

    @Bean
    public DataSourceInitializer adminDataSourceInitializer(
            @Qualifier("adminDataSource") DataSource adminDataSource,
            @Value("${data-source.initialize.enabled:false}") boolean enabled,
            @Value("${spring-batch.schema.script}") Resource script,
            @Value("${terasoluna-batch.commit.script}") Resource commitScript) {
        final DataSourceInitializer dataSourceInitializer = new DataSourceInitializer();
        dataSourceInitializer.setDataSource(adminDataSource);
        dataSourceInitializer.setEnabled(enabled);
        ResourceDatabasePopulator resourceDatabasePopulator = new ResourceDatabasePopulator(
                script, commitScript);
        resourceDatabasePopulator.setContinueOnError(true);
        dataSourceInitializer.setDatabasePopulator(resourceDatabasePopulator);
        return dataSourceInitializer;
    }

    @Bean(destroyMethod = "close")
    public BasicDataSource jobDataSource(
            @Value("${jdbc.driver}") String driverClassName,
            @Value("${jdbc.url}") String url,
            @Value("${jdbc.username}") String username,
            @Value("${jdbc.password}") String password) {
        final BasicDataSource basicDataSource = new BasicDataSource();
        basicDataSource.setDriverClassName(driverClassName);
        basicDataSource.setUrl(url);
        basicDataSource.setUsername(username);
        basicDataSource.setPassword(password);
        basicDataSource.setMaxTotal(10);
        basicDataSource.setMinIdle(1);
        basicDataSource.setMaxWait(Duration.ofMillis(5000));
        basicDataSource.setDefaultAutoCommit(false);
        return basicDataSource;
    }

    @Bean
    public PlatformTransactionManager jobTransactionManager(
            @Qualifier("jobDataSource") DataSource jobDataSource) {
        final DataSourceTransactionManager dataSourceTransactionManager = new DataSourceTransactionManager();
        dataSourceTransactionManager.setDataSource(jobDataSource);
        dataSourceTransactionManager.setRollbackOnCommitFailure(true);
        return dataSourceTransactionManager;
    }

    @Bean
    public MessageSource messageSource() {
        final ResourceBundleMessageSource resourceBundleMessageSource = new ResourceBundleMessageSource();
        resourceBundleMessageSource.setBasename("i18n/application-messages");
        return resourceBundleMessageSource;
    }

    @Bean
    public SpringValidator<?> validator(Validator beanValidator) {
        final SpringValidator<?> springValidator = new SpringValidator<>();
        springValidator.setValidator(beanValidator);
        return springValidator;
    }

    @Bean
    public Validator beanValidator() {
        try (LocalValidatorFactoryBean localValidatorFactoryBean = new LocalValidatorFactoryBean()) {
            localValidatorFactoryBean.afterPropertiesSet();
            return localValidatorFactoryBean;
        }
    }

    @Bean
    public SqlSessionFactory jobSqlSessionFactory(
            @Qualifier("jobDataSource") DataSource jobDataSource) throws Exception {
        final SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(jobDataSource);

        final org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration();
        configuration.setLocalCacheScope(LocalCacheScope.STATEMENT);
        configuration.setLazyLoadingEnabled(true);
        configuration.setAggressiveLazyLoading(false);
        configuration.setDefaultFetchSize(1000);
        configuration.setDefaultExecutorType(ExecutorType.REUSE);

        sqlSessionFactoryBean.setConfiguration(configuration);
        return sqlSessionFactoryBean.getObject();
    }

    @Bean
    public SqlSessionTemplate batchModeSqlSessionTemplate(
            @Qualifier("jobSqlSessionFactory") SqlSessionFactory jobSqlSessionFactory) {
        return new SqlSessionTemplate(jobSqlSessionFactory, ExecutorType.BATCH);
    }

    @Bean
    public PlatformTransactionManager jobResourcelessTransactionManager() {
        return new ResourcelessTransactionManager();
    }
}
