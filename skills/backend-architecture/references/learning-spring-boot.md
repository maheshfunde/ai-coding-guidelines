# Cloud-Native Framework Architecture & Modern Spring: LLM System Instructions & Guidelines

This document synthesizes core architectural principles, framework baselines, coding standards, and operational guidelines for modern cloud-native services. It is structured as system instructions for AI models (LLMs) to strictly enforce modern conventions during software design, code generation, and microservice architecture.

---

## 1. Core Architectural Values & Framework Changes

1. **Baseline & Runtime Stack**:
   - Built on **Spring Framework 7.0**, **Java 25 LTS** (retaining Java 17 compatibility), and **Jakarta EE 11** (Servlet 6.1, Jakarta Persistence 3.2, Jakarta Validation 3.1).
   - Use Jakarta EE namespaces (`jakarta.persistence.*`, `jakarta.servlet.*`, `jakarta.validation.*`) exclusively.
2. **Modular Autoconfiguration**:
   - Autoconfiguration is no longer delivered as a single monolithic artifact (`spring-boot-autoconfigure`). It is split into technology-focused modules aligned with explicitly enabled capabilities (reducing autoconfigure artifact size from >2MB to ~369KB).
3. **Explicit, Technology-Focused Starters**:
   - Starters strictly reflect architectural decisions:
     - `spring-boot-starter-webmvc`: Servlet-based MVC applications.
     - `spring-boot-starter-webflux`: Reactive, non-blocking WebFlux applications.
     - `spring-boot-starter-flyway`: Database migrations (no longer auto-detected transitively).
     - `spring-boot-starter-aspectj`: Aspect-Oriented Programming (renamed from `spring-boot-starter-aop`).
     - `spring-boot-starter-webservices`: SOAP web services (renamed from `spring-boot-starter-web-services`).
4. **Programmatic Bean Registration**:
   - Use `BeanRegistrar` with `BeanRegistry` and `Environment` for programmatic, AOT-friendly bean registration during context initialization when bean creation depends on dynamic environment properties or loops.

---

## 2. Web Layer & API Design Standards

### Controllers & Dependency Injection
- **Rest Controllers**: Mark API endpoints with `@RestController`. Every controller method returns domain records/DTOs serialized to JSON via Jackson 3.
- **Constructor Injection**: Enforce Constructor Injection for all dependencies. Omit `@Autowired` on classes with a single constructor. Avoid field injection (`@Autowired private MyService service;`).

### Declarative HTTP Service Clients (Interface Proxies)
- Define remote HTTP API contracts as plain Java interfaces annotated with `@HttpExchange`, `@GetExchange`, `@PostExchange`, `@PutExchange`, and `@DeleteExchange`.
- Import client interfaces into configuration using `@ImportHttpServices(MyClient.class)`.
- Customizing underlying HTTP transport (`RestClient` or `WebClient`) via `RestClientHttpServiceGroupConfigurer`.

### Built-in API Versioning
- Use Spring Boot 4's native API versioning via path-segments, headers, or request parameters.
- Example: Annotate controller methods with `@GetMapping(value = "/api/{version}/items", version = "1")` and configure path segment extraction in `application.properties`:
  ```properties
  spring.mvc.apiversion.use.path-segment=1
  ```

### Null-Safety Standards
- Adopt **JSpecify** (`org.jspecify.annotations.*`) as the standard null-safety annotation model across all domain classes, services, and APIs (`@NullMarked`, `@Nullable`). Do not use legacy `org.springframework.lang` annotations.

### Concurrency & Virtual Threads
- Enable Java 21+ Virtual Threads for lightweight, non-blocking servlet thread execution by setting:
  ```properties
  spring.threads.virtual.enabled=true
  ```

---

## 3. Data Persistence & Spring Data Guidelines

1. **Modular Persistence Infrastructure**:
   - Persistence abstractions reside in the `spring-boot-persistence` module.
2. **Domain Entities & Repositories**:
   - Define clean JPA Entities (`@Entity`) or R2DBC mapped classes. Keep entities free of presentation or HTTP-layer logic.
   - Use Spring Data Repositories (`JpaRepository<T, ID>` or `R2dbcRepository<T, ID>`) for declarative queries and custom finder methods (`findByNameContainsIgnoreCase`).
3. **Reactive Persistence**:
   - Use `spring-boot-starter-data-r2dbc` alongside `spring-boot-starter-webflux` for end-to-end non-blocking reactive database pipelines.

---

## 4. Security Architecture (Spring Security 7 Integration)

1. **Security Filter Chain**:
   - Declare custom security policies by defining a `SecurityFilterChain` bean using the Lambda DSL (`HttpSecurity`).
2. **Authorization Rules**:
   - Order authorization rules from most specific to least specific, always ending with `.anyRequest().denyAll()`:
     ```java
     @Bean
     SecurityFilterChain configureSecurity(HttpSecurity http) throws Exception {
         http
             .authorizeHttpRequests(auth -> auth
                 .requestMatchers("/login", "/public/**").permitAll()
                 .requestMatchers(HttpMethod.GET, "/api/**").authenticated()
                 .requestMatchers(HttpMethod.POST, "/api/**").hasRole("ADMIN")
                 .anyRequest().denyAll()
             )
             .formLogin(Customizer.withDefaults())
             .httpBasic(Customizer.withDefaults());
         return http.build();
     }
     ```
3. **CSRF Policy**:
   - Retain CSRF protection for browser-rendered form applications.
   - Explicitly disable CSRF (`.csrf(csrf -> csrf.disable())`) ONLY for stateless REST APIs that do not rely on session cookies.
4. **OAuth 2.1 & OIDC Client**:
   - Configure external providers (Google, GitHub, Okta) in YAML under `spring.security.oauth2.client.registration.*`.
   - Register a `DefaultOAuth2AuthorizedClientManager` bean to handle client credentials and token refresh.
5. **Data Protection at Rest**:
   - Always hash passwords using `BCryptPasswordEncoder`.

---

## 5. Modern Testing Strategies & Tooling

### Modular Test Starters
- Include layer-specific test starters in `pom.xml`:
  - `spring-boot-starter-webmvc-test`: Spring MVC slice testing (`MockMvc`).
  - `spring-boot-starter-webflux-test`: WebFlux reactive slice testing (`WebTestClient`).
  - `spring-boot-starter-data-jpa-test`: Data JPA slice testing (`@DataJpaTest`).
  - `spring-boot-starter-security-test`: Security policy testing (`@WithMockUser`).

### Mockito Annotations Migration
- **Remove** deprecated Spring Boot-specific `@MockBean` and `@SpyBean`.
- **Use** Spring Framework 7's `@MockitoBean` and `@MockitoSpyBean` to inject mocks into the Spring `ApplicationContext`.

### Testcontainers & Service Connections
- Leverage `@Testcontainers` and `@Container` with Spring Boot 4's `@ServiceConnection` to automatically wire containerized databases (PostgreSQL, MongoDB, Kafka) into the `ApplicationContext` without manual property overrides:
  ```java
  @Testcontainers
  @DataJpaTest
  @AutoConfigureTestDatabase(replace = Replace.NONE)
  class RepositoryTest {
      @Container
      @ServiceConnection
      static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:17-alpine");
  }
  ```

---

## 6. Externalized Configuration & Profiles

1. **Type-Safe Configuration Properties**:
   - Express configuration properties as immutable **Java Records** annotated with `@ConfigurationProperties("app.prefix")`.
   - Constructor binding is automatic for records; omit `@ConstructorBinding`.
2. **Profile Hierarchy**:
   - Place production defaults in `application.properties`.
   - Define profile overrides in `application-{profile}.properties` (e.g., `application-dev.properties`, `application-test.properties`).
   - *Note*: Collection/List properties replace the entire list across profiles rather than merging.
3. **Property Precedence**:
   - Command-line arguments > OS Environment Variables > External Profile Properties > Packaged `application.properties`.

---

## 7. Performance, Packaging & Native Execution

### Buildpacks Containerization
- Generate production-grade, OCI-compliant layered container images without writing Dockerfiles:
  ```bash
  ./mvnw spring-boot:build-image
  ```

### GraalVM Native Image Compilation
- Produce ahead-of-time (AOT) compiled native executables using Paketo buildpacks:
  ```bash
  ./mvnw spring-boot:build-image -Pnative
  ```
- **Closed-World Assumption**: Structural decisions (`@Profile`, `@ConditionalOnProperty`) and reflection/proxy registration are frozen at build time. Custom reflection requires `@RegisterReflectionForBinding` or runtime hints.

### Java 25 AOT Cache
- JVM-level startup optimization that records training-run compilation artifacts to reduce startup/warmup latency while preserving JIT dynamic optimizations:
  ```bash
  BP_JVM_AOT_ENABLED=true ./mvnw spring-boot:build-image
  ```

---

## 8. Observability & Spring AI

1. **Actuator Health Probes**:
   - Liveness (`/actuator/health/liveness`) and Readiness (`/actuator/health/readiness`) probes are enabled by default across all environments.
2. **OpenTelemetry Starter**:
   - Use `spring-boot-starter-opentelemetry` for standardized OTLP trace, metric, and log export integrated with Micrometer `Observation`.
3. **Spring AI Integration**:
   - Use `ChatClient` with fluent prompts (`chatClient.prompt().user(...).call()`).
   - Expose application tools to LLMs via `@McpTool` using the Model Context Protocol (MCP).
   - Instrument AI calls automatically via Micrometer Observations.

---

## 9. Code Generation Execution Checklist

When generating or refactoring Spring Boot 4 code, verify:
- [ ] Are Jakarta EE imports used exclusively (`jakarta.persistence.*`, `jakarta.servlet.*`)?
- [ ] Are nullability annotations sourced from JSpecify (`org.jspecify.annotations.*`)?
- [ ] Are test mocks created using `@MockitoBean` / `@MockitoSpyBean` instead of `@MockBean` / `@SpyBean`?
- [ ] Is constructor injection used without explicit `@Autowired` on single-constructor classes?
- [ ] Are configuration properties declared as Java Records with `@ConfigurationProperties`?
- [ ] Is security configured via Spring Security 7 Lambda DSL ending with `.anyRequest().denyAll()`?
- [ ] Are Testcontainers bound using `@ServiceConnection`?
