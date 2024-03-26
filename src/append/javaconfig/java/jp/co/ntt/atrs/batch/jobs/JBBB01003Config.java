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
package jp.co.ntt.atrs.batch.jobs;

import java.io.File;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.file.FlatFileItemWriter;
import org.springframework.batch.item.file.builder.FlatFileItemWriterBuilder;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.core.io.PathResource;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.util.ClassUtils;
import org.terasoluna.batch.item.file.transform.EnclosableDelimitedLineAggregator;

import jp.co.ntt.atrs.batch.common.listener.AtrsExceptionHandlingListener;
import jp.co.ntt.atrs.batch.common.listener.JobExitCodeChangeListener;
import jp.co.ntt.atrs.batch.common.listener.JobLoggingListener;
import jp.co.ntt.atrs.batch.config.JobBaseContextConfig;
import jp.co.ntt.atrs.batch.jbbb01003.DepartureDateChangeFieldExtractor;
import jp.co.ntt.atrs.batch.jbbb01003.FareTypeAggregationDto;
import jp.co.ntt.atrs.batch.jbbb01003.JBBB01003Dao;
import jp.co.ntt.atrs.batch.jbbb01003.JBBB01003Tasklet;
import jp.co.ntt.atrs.batch.jbbb01003.WriteHeaderFlatFileHeaderCallback;

/**
 * JBBB01003用のJavaConfigクラス
 *
 * @author 電電次郎
 */
@Configuration
@Import(JobBaseContextConfig.class)
@ComponentScan(value = {"jp.co.ntt.atrs.batch.jbbb01003",
    "jp.co.ntt.atrs.batch.common.listener",
    "jp.co.ntt.atrs.batch.common.mapstruct"}, scopedProxy = ScopedProxyMode.TARGET_CLASS)
public class JBBB01003Config {

    @Bean
    public MapperFactoryBean<JBBB01003Dao> JBBB01003Dao(
            SqlSessionTemplate batchModeSqlSessionTemplate) {
        MapperFactoryBean<JBBB01003Dao> dao = new MapperFactoryBean<>();
        dao.setMapperInterface(JBBB01003Dao.class);
        dao.setSqlSessionTemplate(batchModeSqlSessionTemplate);
        return dao;
    }
    
    @Bean
    @StepScope
    public FlatFileItemWriter<FareTypeAggregationDto> routeAggregationWriter(
            @Value("${user.dir}") String userDir,
            @Value("${path.FareTypeAggregationData}") String pathFareTypeAggregationData,
            WriteHeaderFlatFileHeaderCallback writeHeaderFlatFileHeaderCallback) {
        EnclosableDelimitedLineAggregator<FareTypeAggregationDto> lineAggregator = new EnclosableDelimitedLineAggregator<>();
        lineAggregator.setDelimiter(',');
        lineAggregator.setEnclosure('"');
        lineAggregator.setAllEnclosing(true);
        DepartureDateChangeFieldExtractor fieldExtractor = new DepartureDateChangeFieldExtractor();
        lineAggregator.setFieldExtractor(fieldExtractor);
        return new FlatFileItemWriterBuilder<FareTypeAggregationDto>()
                .name(ClassUtils.getShortName(FlatFileItemWriter.class))
                .resource(new PathResource(userDir + File.separator + pathFareTypeAggregationData))
                .lineAggregator(lineAggregator)
                .encoding("UTF-8")
                .lineSeparator("\n")
                .append(true)
                .transactional(false)
                .headerCallback(writeHeaderFlatFileHeaderCallback)
                .build();
    }
    
    @Bean
    public Step step01(JobRepository jobRepository,
                       @Qualifier("jobResourcelessTransactionManager") PlatformTransactionManager transactionManager,
                       JBBB01003Tasklet tasklet,
                       AtrsExceptionHandlingListener atrsExceptionHandlingListener) {
        return new StepBuilder("JBBB01003.step01",
                jobRepository)
                .tasklet(tasklet, transactionManager)
                .listener(atrsExceptionHandlingListener)
                .build();
    }

    @Bean
    public Job JBBB01003(JobRepository jobRepository,
                                             Step step01,
                                             JobExitCodeChangeListener jobExitCodeChangeListener,
                                             JobLoggingListener jobLoggingListener) {
        return new JobBuilder("JBBB01003", jobRepository)
                .start(step01)
                .listener(jobExitCodeChangeListener)
                .listener(jobLoggingListener)
                .build();
    }
}
