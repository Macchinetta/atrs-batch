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
package jp.co.ntt.atrs.batch.config.helper;

import org.springframework.batch.core.configuration.support.ApplicationContextFactory;
import org.springframework.batch.core.configuration.support.GenericApplicationContextFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.type.AnnotationMetadata;
import org.springframework.core.type.classreading.CachingMetadataReaderFactory;
import org.springframework.core.type.classreading.MetadataReader;
import org.springframework.core.type.classreading.MetadataReaderFactory;
import org.springframework.util.ClassUtils;

import java.io.IOException;
import java.util.stream.Stream;

/**
 * ApplicationContext生成用のFactoryHelper。
 *
 * @author 電電次郎
 */

public class ApplicationContextFactoryHelper {

    private final PathMatchingResourcePatternResolver pathMatchingResourcePatternResolver = new PathMatchingResourcePatternResolver();

    private final MetadataReaderFactory metadataReaderFactory = new CachingMetadataReaderFactory(
            pathMatchingResourcePatternResolver);

    private final ClassLoader classLoader = ClassUtils.getDefaultClassLoader();

    private final ApplicationContext applicationContext;

    public ApplicationContextFactoryHelper(
            ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
    }

    public ApplicationContextFactory[] load(String... locations) {
        final Stream<String> locationStream = Stream.of(locations);
        return locationStream
                .flatMap(loc -> loc.endsWith(".xml") ?
                        createXmlConfigFactories(loc) :
                        createJavaConfigFactories(loc))
                .toArray(ApplicationContextFactory[]::new);
    }

    private Stream<ApplicationContextFactory> createXmlConfigFactories(
            final String xmlConfigPathPattern) {
        return resolvePatternedResource(xmlConfigPathPattern)
                .map(this::createFactory);
    }

    private Stream<ApplicationContextFactory> createJavaConfigFactories(
            String javaConfigResourcePattern) {
        return resolvePatternedResource(javaConfigResourcePattern)
                .map(this::loadConfigClassCandidate)
                .filter(this::hasAnnotatedConfigClass)
                .map(this::createFactory);
    }

    Stream<Resource> resolvePatternedResource(String resourcePattern) {
        try {
            return Stream.of(pathMatchingResourcePatternResolver.getResources(
                            resourcePattern))
                    .filter(Resource::isReadable);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    Class<?> loadConfigClassCandidate(Resource javaConfigResource) {
        final MetadataReader reader;
        try {
            reader = metadataReaderFactory.getMetadataReader(
                    javaConfigResource);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return ClassUtils.resolveClassName(
                reader.getClassMetadata().getClassName(), classLoader);
    }

    /**
     * Whether is candidate class annotated as
     * {@link org.springframework.context.annotation.Configuration}.
     *
     * @param candidate candidate class
     * @return true - annotated as Configuration.
     */
    boolean hasAnnotatedConfigClass(Class<?> candidate) {
        return AnnotationMetadata
                .introspect(candidate)
                .getAnnotations()
                .isPresent(Configuration.class);
    }

    private ApplicationContextFactory createFactory(Object resource) {
        final GenericApplicationContextFactory factory = new GenericApplicationContextFactory(
                resource);
        factory.setApplicationContext(applicationContext);
        return factory;
    }
}
