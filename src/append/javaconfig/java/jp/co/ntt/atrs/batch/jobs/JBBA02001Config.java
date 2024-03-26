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
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.file.FlatFileItemWriter;
import org.springframework.batch.item.file.builder.FlatFileItemWriterBuilder;
import org.springframework.batch.item.file.transform.BeanWrapperFieldExtractor;
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
import jp.co.ntt.atrs.batch.jbba02001.FlightBackupDto;
import jp.co.ntt.atrs.batch.jbba02001.FlightBackupDtoDateChangeFieldExtractor;
import jp.co.ntt.atrs.batch.jbba02001.JBBA02001Dao;
import jp.co.ntt.atrs.batch.jbba02001.JBBA02001Tasklet;
import jp.co.ntt.atrs.batch.jbba02001.PassengerBackupDto;
import jp.co.ntt.atrs.batch.jbba02001.ReserveFlightBackupDto;
import jp.co.ntt.atrs.batch.jbba02001.ReserveFlightBackupDtoDateChangeFieldExtractor;

/**
 * JBBA02001用のJavaConfigクラス
 *
 * @author 電電次郎
 */
@Configuration
@Import(JobBaseContextConfig.class)
@ComponentScan(value = {"jp.co.ntt.atrs.batch.jbba02001",
    "jp.co.ntt.atrs.batch.common.listener",
    "jp.co.ntt.atrs.batch.common.mapstruct"}, scopedProxy = ScopedProxyMode.TARGET_CLASS)
public class JBBA02001Config {

    @Bean
    public MapperFactoryBean<JBBA02001Dao> JBBA02001Dao(
            @Qualifier("jobSqlSessionFactory") SqlSessionFactory jobSqlSessionFactory) {
        MapperFactoryBean<JBBA02001Dao> dao = new MapperFactoryBean<JBBA02001Dao>();
        dao.setMapperInterface(JBBA02001Dao.class);
        dao.setSqlSessionFactory(jobSqlSessionFactory);
        return dao;
    }
    
    @Bean
    @StepScope
    public FlatFileItemWriter<FlightBackupDto> flightBackupFileWriter(
            @Value("${user.dir}") String userDir,
            @Value("${path.FlightBackup}") String pathFlightBackup) {
        EnclosableDelimitedLineAggregator<FlightBackupDto> lineAggregator = new EnclosableDelimitedLineAggregator<>();
        lineAggregator.setDelimiter(',');
        lineAggregator.setEnclosure('\"');
        lineAggregator.setAllEnclosing(true);
        FlightBackupDtoDateChangeFieldExtractor fieldExtractor = new FlightBackupDtoDateChangeFieldExtractor();
        lineAggregator.setFieldExtractor(fieldExtractor);
        return new FlatFileItemWriterBuilder<FlightBackupDto>()
                .name(ClassUtils.getShortName(FlatFileItemWriter.class))
                .resource(new PathResource(userDir + File.separator + pathFlightBackup))
                .lineAggregator(lineAggregator)
                .encoding("UTF-8")
                .lineSeparator("\n")
                .append(true)
                .transactional(false)
                .build();
    }
    
    @Bean
    @StepScope
    public FlatFileItemWriter<ReserveFlightBackupDto> reserveFlightBackupFileWriter(
            @Value("${user.dir}") String userDir,
            @Value("${path.ReserveFlightBackup}") String pathReserveFlightBackup) {
        EnclosableDelimitedLineAggregator<ReserveFlightBackupDto> lineAggregator = new EnclosableDelimitedLineAggregator<>();
        lineAggregator.setDelimiter(',');
        lineAggregator.setEnclosure('\"');
        lineAggregator.setAllEnclosing(true);
        ReserveFlightBackupDtoDateChangeFieldExtractor fieldExtractor = new ReserveFlightBackupDtoDateChangeFieldExtractor();
        lineAggregator.setFieldExtractor(fieldExtractor);
        return new FlatFileItemWriterBuilder<ReserveFlightBackupDto>()
                .name(ClassUtils.getShortName(FlatFileItemWriter.class))
                .resource(new PathResource(userDir + File.separator + pathReserveFlightBackup))
                .lineAggregator(lineAggregator)
                .encoding("UTF-8")
                .lineSeparator("\n")
                .append(true)
                .transactional(false)
                .build();
    }
    
    @Bean
    @StepScope
    public FlatFileItemWriter<PassengerBackupDto> passengerBackupFileWriter(
            @Value("${user.dir}") String userDir,
            @Value("${path.PassengerBackup}") String pathPassengerBackup) {
        EnclosableDelimitedLineAggregator<PassengerBackupDto> lineAggregator = new EnclosableDelimitedLineAggregator<>();
        lineAggregator.setDelimiter(',');
        lineAggregator.setEnclosure('\"');
        lineAggregator.setAllEnclosing(true);
        BeanWrapperFieldExtractor<PassengerBackupDto> fieldExtractor = new BeanWrapperFieldExtractor<>();
        fieldExtractor.setNames(new String[] {"passengerNo", "reserveFlightNo", "familyName",
                                              "givenName", "age", "gender", "customerNo"});
        lineAggregator.setFieldExtractor(fieldExtractor);
        return new FlatFileItemWriterBuilder<PassengerBackupDto>()
                .name(ClassUtils.getShortName(FlatFileItemWriter.class))
                .resource(new PathResource(userDir + File.separator + pathPassengerBackup))
                .lineAggregator(lineAggregator)
                .encoding("UTF-8")
                .lineSeparator("\n")
                .append(true)
                .transactional(false)
                .build();
    }
    
    @Bean
    public Step step01(JobRepository jobRepository,
                       @Qualifier("jobTransactionManager") PlatformTransactionManager transactionManager,
                       JBBA02001Tasklet tasklet,
                       AtrsExceptionHandlingListener atrsExceptionHandlingListener) {
        return new StepBuilder("JBBA02001.step01",
                jobRepository)
                .listener(atrsExceptionHandlingListener)
                .tasklet(tasklet, transactionManager)
                .build();
    }

    @Bean
    public Job JBBA02001(JobRepository jobRepository,
                                             Step step01,
                                             JobExitCodeChangeListener jobExitCodeChangeListener,
                                             JobLoggingListener jobLoggingListener) {
        return new JobBuilder("JBBA02001", jobRepository)
                .start(step01)
                .listener(jobExitCodeChangeListener)
                .listener(jobLoggingListener)
                .build();
    }
}
