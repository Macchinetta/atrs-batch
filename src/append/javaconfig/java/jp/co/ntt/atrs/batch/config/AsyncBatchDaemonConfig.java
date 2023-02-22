/*
 * Copyright(c) 2023 NTT Corporation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */
package jp.co.ntt.atrs.batch.config;

import org.apache.ibatis.mapping.DatabaseIdProvider;
import org.apache.ibatis.mapping.DatabaseIdProvider;
import org.apache.ibatis.mapping.VendorDatabaseIdProvider;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.LocalCacheScope;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.springframework.batch.core.configuration.JobRegistry;
import org.springframework.batch.core.configuration.support.*;
import org.springframework.batch.core.launch.JobOperator;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.jdbc.datasource.init.DataSourceInitializer;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.transaction.PlatformTransactionManager;
import org.terasoluna.batch.async.db.JobRequestPollTask;
import org.terasoluna.batch.async.db.repository.BatchJobRequestRepository;
import jp.co.ntt.atrs.batch.config.helper.ApplicationContextFactoryHelper;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.Properties;

/**
 * Async Batch Daemon用のConfiguration。
 *
 * @author 電電次郎
 */
@Configuration
@Import(LaunchContextConfig.class)
@PropertySource(value = "classpath:batch-application.properties")
@EnableScheduling
public class AsyncBatchDaemonConfig {

    @Bean
    public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
        return new PropertySourcesPlaceholderConfigurer();
    }

    @Bean
    public ThreadPoolTaskExecutor daemonTaskExecutor(@Value("${async-batch-daemon.job-concurrency-num}") int concurrency) {
        final ThreadPoolTaskExecutor threadPoolTaskExecutor = new ThreadPoolTaskExecutor();
        threadPoolTaskExecutor.setCorePoolSize(concurrency);
        threadPoolTaskExecutor.setMaxPoolSize(concurrency);
        threadPoolTaskExecutor.setQueueCapacity(0);
        return threadPoolTaskExecutor;
    }

    @Bean
    public ThreadPoolTaskScheduler daemonTaskScheduler(@Value("${async-batch-daemon.scheduler.size}") int size) {
        final ThreadPoolTaskScheduler threadPoolTaskScheduler = new ThreadPoolTaskScheduler();
        threadPoolTaskScheduler.setPoolSize(size);
        return threadPoolTaskScheduler;
    }

    @Bean
    public DataSourceInitializer asyncDataSourceInitializer(@Qualifier("adminDataSource") DataSource adminDataSource,
                                                       @Value("${data-source.initialize.enabled:false}") boolean enabled,
                                                       @Value("${async-batch-daemon.schema.script}") Resource script,
                                                       @Value("${terasoluna-batch.commit.script}") Resource commitScript) {
        final DataSourceInitializer asyncDataSourceInitializer = new DataSourceInitializer();
        asyncDataSourceInitializer.setDataSource(adminDataSource);
        asyncDataSourceInitializer.setEnabled(enabled);
        ResourceDatabasePopulator resourceDatabasePopulator = new ResourceDatabasePopulator(script, commitScript);
        resourceDatabasePopulator.setContinueOnError(true);
        asyncDataSourceInitializer.setDatabasePopulator(resourceDatabasePopulator);
        return asyncDataSourceInitializer;
    }

    @Bean
    public JobRequestPollTask jobRequestPollTask(@Qualifier("adminTransactionManager") PlatformTransactionManager adminTransactionManager,
                                                 JobOperator jobOperator,
                                                 BatchJobRequestRepository batchJobRequestRepository,
                                                 @Qualifier("daemonTaskExecutor") ThreadPoolTaskExecutor daemonTaskExecutor,
                                                 AutomaticJobRegistrar automaticJobRegistrar) {
        return new JobRequestPollTask(batchJobRequestRepository, adminTransactionManager, daemonTaskExecutor, jobOperator,
            automaticJobRegistrar);
    }

    @Bean
    public SqlSessionFactory adminSqlSessionFactory(@Qualifier("adminDataSource") DataSource adminDataSource,
                                                    DatabaseIdProvider databaseIdProvider) throws Exception {
        final SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(adminDataSource);
        sqlSessionFactoryBean.setDatabaseIdProvider(databaseIdProvider);
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
    public MapperFactoryBean<BatchJobRequestRepository> batchJobRequestRepository(
            @Qualifier("adminSqlSessionFactory") SqlSessionFactory adminSqlSessionFactory) {
        final MapperFactoryBean<BatchJobRequestRepository> mapperFactoryBean = new MapperFactoryBean<>();
        mapperFactoryBean.setMapperInterface(BatchJobRequestRepository.class);
        mapperFactoryBean.setSqlSessionFactory(adminSqlSessionFactory);
        return mapperFactoryBean;
    }

    @Bean
    public AutomaticJobRegistrar automaticJobRegistrar(ResourceLoader resourceLoader, JobRegistry jobRegistry,
                                                       ApplicationContextFactory[] applicationContextFactories) throws Exception {
        final AutomaticJobRegistrar automaticJobRegistrar = new AutomaticJobRegistrar();
        final DefaultJobLoader defaultJobLoader = new DefaultJobLoader();
        defaultJobLoader.setJobRegistry(jobRegistry);
        automaticJobRegistrar.setApplicationContextFactories(applicationContextFactories);
        automaticJobRegistrar.setJobLoader(defaultJobLoader);
        return automaticJobRegistrar;
    }

    @Bean
    public ApplicationContextFactory[] applicationContextFactories(final ApplicationContext ctx) throws IOException {
        return new ApplicationContextFactoryHelper(ctx).load("classpath:/META-INF/jobs/*.xml");
    }

    @Bean
    public JobRegistryBeanPostProcessor jobRegistryBeanPostProcessor(JobRegistry jobRegistry) {
        final JobRegistryBeanPostProcessor jobRegistryBeanPostProcessor = new JobRegistryBeanPostProcessor();
        jobRegistryBeanPostProcessor.setJobRegistry(jobRegistry);
        return jobRegistryBeanPostProcessor;
    }

    @Bean
    public VendorDatabaseIdProvider databaseIdProvider() {
        final VendorDatabaseIdProvider vendorDatabaseIdProvider = new VendorDatabaseIdProvider();
        final Properties properties = new Properties();
        properties.setProperty("Oracle", "oracle");
        vendorDatabaseIdProvider.setProperties(properties);
        return vendorDatabaseIdProvider;
    }
}
