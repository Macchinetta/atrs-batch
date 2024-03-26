/*
 * Copyright (C) 2024 NTT Corporation
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

import org.springframework.batch.core.configuration.BatchConfigurationException;
import org.springframework.batch.core.configuration.support.DefaultBatchConfiguration;
import org.springframework.batch.core.launch.JobOperator;
import org.springframework.batch.core.launch.support.JobOperatorFactoryBean;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.repository.support.JobRepositoryFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.Isolation;
import org.terasoluna.batch.converter.JobParametersConverterImpl;

import javax.sql.DataSource;

/**
 * Terasoluna Batch用のConfiguration。
 *
 * @author 電電次郎
 */
@Configuration
public class TerasolunaBatchConfiguration extends DefaultBatchConfiguration {

    // DefaultBatchConfigurationはデータソースのBean名を「dataSource」で探すので、
    // getDataSourceをオーバーライドして「adminDataSource」で探すように修正
    @Override
    protected DataSource getDataSource() {
        String errorMessage =
                " To use the default configuration, a data source bean named 'adminDataSource'"
                        + " should be defined in the application context but none was found. Override getDataSource()"
                        + " to provide the data source to use for Batch meta-data.";
        if (this.applicationContext.getBeansOfType(DataSource.class)
                .isEmpty()) {
            throw new BatchConfigurationException(
                    "Unable to find a DataSource bean in the application context."
                            + errorMessage);
        } else {
            if (!this.applicationContext.containsBean("adminDataSource")) {
                throw new BatchConfigurationException(errorMessage);
            }
        }
        return this.applicationContext.getBean("adminDataSource",
                DataSource.class);
    }

    // DefaultBatchConfigurationはトランザクションマネージャのBean名を「transactionManager」で探すので、
    // getTransactionManagerをオーバーライドして「adminTransactionManager」で探すように修正
    @Override
    protected PlatformTransactionManager getTransactionManager() {
        String errorMessage =
                " To use the default configuration, a transaction manager bean named 'adminTransactionManager'"
                        + " should be defined in the application context but none was found. Override getTransactionManager()"
                        + " to provide the transaction manager to use for the job repository.";
        if (this.applicationContext.getBeansOfType(
                PlatformTransactionManager.class).isEmpty()) {
            throw new BatchConfigurationException(
                    "Unable to find a PlatformTransactionManager bean in the application context."
                            + errorMessage);
        } else {
            if (!this.applicationContext.containsBean(
                    "adminTransactionManager")) {
                throw new BatchConfigurationException(errorMessage);
            }
        }
        return this.applicationContext.getBean("adminTransactionManager",
                PlatformTransactionManager.class);
    }

    // JobRepositoryのデフォルトのトランザクション隔離レベルが「SERIALIZABLE」なので、
    // Bean定義をオーバーライドして「READ COMMITTED」に修正
    @Override
    @Bean
    public JobRepository jobRepository() throws BatchConfigurationException {
        JobRepositoryFactoryBean jobRepositoryFactoryBean = new JobRepositoryFactoryBean();
        jobRepositoryFactoryBean.setDataSource(
                getDataSource()); // adminDataSourceを取得、設定
        jobRepositoryFactoryBean.setTransactionManager(
                getTransactionManager()); // adminTransactionManagerを取得、設定
        jobRepositoryFactoryBean.setIncrementerFactory(getIncrementerFactory());
        jobRepositoryFactoryBean.setClobType(getClobType());
        jobRepositoryFactoryBean.setTablePrefix(getTablePrefix());
        jobRepositoryFactoryBean.setSerializer(getExecutionContextSerializer());
        jobRepositoryFactoryBean.setConversionService(getConversionService());
        jobRepositoryFactoryBean.setJdbcOperations(getJdbcOperations());
        jobRepositoryFactoryBean.setLobHandler(getLobHandler());
        jobRepositoryFactoryBean.setCharset(getCharset());
        jobRepositoryFactoryBean.setMaxVarCharLength(getMaxVarCharLength());
        jobRepositoryFactoryBean.setIsolationLevelForCreateEnum(
                Isolation.READ_COMMITTED); // SERIALIZABLEから変更
        jobRepositoryFactoryBean.setValidateTransactionState(
                getValidateTransactionState());

        try {
            jobRepositoryFactoryBean.setDatabaseType(getDatabaseType());
            jobRepositoryFactoryBean.afterPropertiesSet();
            return jobRepositoryFactoryBean.getObject();

        } catch (BatchConfigurationException e) {
            throw e;
        } catch (Exception e) {
            throw new BatchConfigurationException(
                    "Unable to configure the customized job repository", e);
        }
    }

    // JobOperatorのデフォルトのJobParametersConverterの実装クラスが「DefaultJobParametersConverter」なので、
    // Bean定義をオーバーライドして「JobParametersConverterImpl」に修正
    @Override
    @Bean
    public JobOperator jobOperator() throws BatchConfigurationException {
        JobOperatorFactoryBean jobOperatorFactoryBean = new JobOperatorFactoryBean();
        jobOperatorFactoryBean.setTransactionManager(
                getTransactionManager());  // adminTransactionManagerを取得、設定
        jobOperatorFactoryBean.setJobRepository(jobRepository());
        jobOperatorFactoryBean.setJobExplorer(jobExplorer());
        jobOperatorFactoryBean.setJobRegistry(jobRegistry());
        jobOperatorFactoryBean.setJobLauncher(jobLauncher());
        JobParametersConverterImpl jobParametersConverter = new JobParametersConverterImpl(
                getDataSource());
        jobOperatorFactoryBean.setJobParametersConverter(
                jobParametersConverter); // JobParametersConverterImplに変更

        try {
            jobParametersConverter.afterPropertiesSet();
            jobOperatorFactoryBean.afterPropertiesSet();
            return jobOperatorFactoryBean.getObject();

        } catch (BatchConfigurationException e) {
            throw e;
        } catch (Exception e) {
            throw new BatchConfigurationException(
                    "Unable to configure the customized job operator", e);
        }
    }
}
