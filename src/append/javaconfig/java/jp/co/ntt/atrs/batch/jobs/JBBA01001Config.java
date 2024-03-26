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

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.mybatis.spring.batch.MyBatisBatchItemWriter;
import org.mybatis.spring.batch.builder.MyBatisBatchItemWriterBuilder;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.file.FlatFileItemReader;
import org.springframework.batch.item.file.builder.FlatFileItemReaderBuilder;
import org.springframework.batch.item.file.mapping.BeanWrapperFieldSetMapper;
import org.springframework.batch.item.file.mapping.DefaultLineMapper;
import org.springframework.batch.item.file.transform.DelimitedLineTokenizer;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.core.io.PathResource;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.util.ClassUtils;

import jp.co.ntt.atrs.batch.common.listener.AtrsExceptionHandlingListener;
import jp.co.ntt.atrs.batch.common.listener.JobExitCodeChangeListener;
import jp.co.ntt.atrs.batch.common.listener.JobLoggingListener;
import jp.co.ntt.atrs.batch.config.JobBaseContextConfig;
import jp.co.ntt.atrs.batch.jbba00.FlightDto;
import jp.co.ntt.atrs.batch.jbba01001.FlightUpdateDto;
import jp.co.ntt.atrs.batch.jbba01001.JBBA01001ItemProcessor;
import jp.co.ntt.atrs.batch.jbba01001.JBBA01001JobExecutionListener;
import jp.co.ntt.atrs.batch.jbba01001.JBBA01001StepExecutionListener;

/**
 * JBBA01001用のJavaConfigクラス
 *
 * @author 電電次郎
 */
@Configuration
@Import(JobBaseContextConfig.class)
@ComponentScan({"jp.co.ntt.atrs.batch.jbba01001,jp.co.ntt.atrs.batch.common.listener",
    "jp.co.ntt.atrs.batch.common.mapstruct"})
@MapperScan(basePackages = "jp.co.ntt.atrs.batch.jbba01001", sqlSessionFactoryRef = "jobSqlSessionFactory")
public class JBBA01001Config {

    @Bean
    @StepScope
    public FlatFileItemReader<FlightUpdateDto> reader(
            @Value("${user.dir}") String userDir,
            @Value("${path.FlightUpdate}") String pathFlightUpdate) {  
        DelimitedLineTokenizer lineTokenizer = new DelimitedLineTokenizer();
        lineTokenizer.setNames("departureDateStr", "flightName", "boardingClassCd", "fareTypeCd", "vacantNumStr");
        lineTokenizer.setDelimiter(",");
        lineTokenizer.setQuoteCharacter('"');
        BeanWrapperFieldSetMapper<FlightUpdateDto> fieldSetMapper = new BeanWrapperFieldSetMapper<>();
        fieldSetMapper.setTargetType(FlightUpdateDto.class);
        DefaultLineMapper<FlightUpdateDto> lineMapper = new DefaultLineMapper<>();
        lineMapper.setLineTokenizer(lineTokenizer);
        lineMapper.setFieldSetMapper(fieldSetMapper);
        return new FlatFileItemReaderBuilder<FlightUpdateDto>()
                .name(ClassUtils.getShortName(FlatFileItemReader.class))
                .lineMapper(lineMapper)
                .resource(new PathResource(userDir + File.separator + pathFlightUpdate))
                .encoding("UTF-8")
                .strict(true)
                .build();
    }
    
    @Bean
    public MyBatisBatchItemWriter<FlightDto> writer(
            @Qualifier("jobSqlSessionFactory") SqlSessionFactory jobSqlSessionFactory,
            SqlSessionTemplate batchModeSqlSessionTemplate) {
        return new MyBatisBatchItemWriterBuilder<FlightDto>()
                .sqlSessionFactory(jobSqlSessionFactory)
                .statementId(
                        "jp.co.ntt.atrs.batch.jbba01001.JBBA01001BatchDao.insertFlight")
                .sqlSessionTemplate(batchModeSqlSessionTemplate)
                .build();
    }
    
    @Bean
    public Step step01(JobRepository jobRepository,
                       @Qualifier("jobTransactionManager") PlatformTransactionManager transactionManager,
                       FlatFileItemReader<FlightUpdateDto> reader,
                       JBBA01001ItemProcessor processor,
                       MyBatisBatchItemWriter<FlightDto> writer,
                       JBBA01001StepExecutionListener jBBA01001StepExecutionListener,
                       AtrsExceptionHandlingListener atrsExceptionHandlingListener) {
        return new StepBuilder("JBBA01001.step01",
                jobRepository)
                .listener(jBBA01001StepExecutionListener)
                .listener(atrsExceptionHandlingListener)
                .<FlightUpdateDto, FlightDto>chunk(10000,
                        transactionManager)
                .reader(reader)
                .processor(processor)
                .writer(writer)
                .build();
    }

    @Bean
    public Job JBBA01001(JobRepository jobRepository,
                                             Step step01,
                                             JBBA01001JobExecutionListener jBBA01001JobExecutionListener,
                                             JobExitCodeChangeListener jobExitCodeChangeListener,
                                             JobLoggingListener jobLoggingListener) {
        return new JobBuilder("JBBA01001", jobRepository)
                .start(step01)
                .listener(jBBA01001JobExecutionListener)
                .listener(jobExitCodeChangeListener)
                .listener(jobLoggingListener)
                .build();
    }
}
