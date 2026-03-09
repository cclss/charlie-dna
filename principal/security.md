---
id: security
load: on_demand
version: 1.0.0
---

# Security — 보안 원칙

The rules that protect what we build and those who use it.
우리가 만드는 것과 사용하는 사람을 보호하는 규칙.

Security is not a feature. It is a property.
A product that works but is not secure does not work.
보안은 기능이 아니다. 속성이다.
작동하지만 안전하지 않은 제품은 작동하지 않는 것이다.

Security is everyone's responsibility.
The moment it becomes "the security team's problem," it is no one's problem.
보안은 모두의 책임이다.
"보안팀의 문제"가 되는 순간, 아무도의 문제가 아니게 된다.

Every security decision starts with three questions:
What are we protecting? From whom? What does failure look like?
Without these answers, every defense is a guess.
모든 보안 결정은 세 가지 질문에서 시작한다:
무엇을 보호하는가? 누구로부터? 실패하면 어떻게 되는가?
이 답 없이 모든 방어는 추측이다.

Read this before any work involving external services, authentication,
user data, or system boundaries.
외부 서비스, 인증, 사용자 데이터, 시스템 경계에 관한 작업 전에 읽어라.

---

## 1. Secrets Are Not Code — 시크릿은 코드가 아니다

**Secrets belong in the environment. Never in the repository.**
**시크릿은 환경에 속한다. 저장소에는 절대 넣지 않는다.**

A leaked secret is not a bug. It is a breach.
The moment a secret touches version control, assume it is compromised.
유출된 시크릿은 버그가 아니다. 침해다.
시크릿이 버전 관리에 닿는 순간, 노출되었다고 가정하라.

- API keys, tokens, passwords, certificates — none of these go in code, config files, or comments.
  API 키, 토큰, 비밀번호, 인증서 — 코드, 설정 파일, 주석에 넣지 마라.
- Use environment variables or a secrets manager. No exceptions.
  환경 변수나 시크릿 매니저를 써라. 예외 없다.
- Do not log secrets. Not even partially. Not even "for debugging."
  시크릿을 로깅하지 마라. 부분적으로도. "디버깅용으로도" 안 된다.
- Provide a template showing what secrets are needed, with placeholder values only. Never commit the real values.
  어떤 시크릿이 필요한지 플레이스홀더 값으로 템플릿을 제공하라. 실제 값은 절대 커밋하지 마라.
- If a secret is accidentally committed, rotate it immediately. Removing the commit is not enough — git history is permanent.
  시크릿이 실수로 커밋되면 즉시 로테이트하라. 커밋을 지우는 것만으로는 부족하다 — git 히스토리는 영구적이다.

---

## 2. Trust Nothing External — 외부를 신뢰하지 마라

**All input from outside the system boundary is hostile until validated.**
**시스템 경계 밖에서 오는 모든 입력은 검증될 때까지 적대적이다.**

The attacker uses whatever you accept.
If you accept anything, the attacker can do anything.
공격자는 당신이 받아들이는 것을 사용한다.
무엇이든 받아들이면 공격자는 무엇이든 할 수 있다.

- Validate, sanitize, and constrain all external input — user input, API responses, file uploads, URL parameters.
  모든 외부 입력을 검증, 정화, 제한하라 — 사용자 입력, API 응답, 파일 업로드, URL 파라미터.
- Use allowlists over denylists. Reject unknown, accept known.
  차단 목록보다 허용 목록을 써라. 모르는 것은 거부, 아는 것만 수용.
- Never construct SQL, shell commands, or HTML from raw input. Use parameterized queries, safe APIs, and templating engines.
  원시 입력으로 SQL, 셸 명령, HTML을 구성하지 마라. 파라미터화된 쿼리, 안전한 API, 템플릿 엔진을 써라.
- Do not deserialize untrusted data. Deserialization of external input is a remote code execution waiting to happen.
  신뢰할 수 없는 데이터를 역직렬화하지 마라. 외부 입력의 역직렬화는 원격 코드 실행을 기다리는 것이다.
- Validate on the server. Client-side validation is UX, not security.
  서버에서 검증하라. 클라이언트 사이드 검증은 UX이지 보안이 아니다.
- Restrict cross-origin access explicitly. An open CORS policy is an open door.
  교차 출처 접근을 명시적으로 제한하라. 열린 CORS 정책은 열린 문이다.
- Treat external API responses as untrusted. They can be compromised, spoofed, or changed without notice.
  외부 API 응답을 신뢰하지 마라. 침해, 위장, 예고 없는 변경이 가능하다.

---

## 3. Least Privilege — 최소 권한

**Request only what is needed. Expose only what is required.**
**필요한 것만 요청하라. 요구되는 것만 노출하라.**

Every unnecessary permission is an unnecessary attack surface.
The question is not "do we need this access now?"
It is "what happens if this access is compromised?"
불필요한 모든 권한은 불필요한 공격 면이다.
질문은 "이 접근이 지금 필요한가?"가 아니라
"이 접근이 침해되면 무슨 일이 일어나는가?"이다.

- Services run with the minimum permissions required.
  서비스는 필요한 최소 권한으로 실행한다.
- APIs expose only the data the caller needs. No full objects when a subset suffices.
  API는 호출자가 필요한 데이터만 노출한다. 부분 집합으로 충분하면 전체 객체를 보내지 마라.
- File permissions, database roles, cloud IAM — always constrain to the narrowest scope.
  파일 권한, 데이터베이스 역할, 클라우드 IAM — 항상 가장 좁은 범위로 제한하라.
- Do not use admin credentials for application logic. Ever.
  애플리케이션 로직에 관리자 자격증명을 사용하지 마라. 절대로.
- Isolate workloads. Containers, sandboxes, network segmentation — when a process is compromised, limit the blast radius.
  워크로드를 격리하라. 컨테이너, 샌드박스, 네트워크 세그멘테이션 — 프로세스가 침해되면 폭발 반경을 제한하라.
- Tokens and sessions expire. If they do not expire, they will eventually be stolen.
  토큰과 세션은 만료된다. 만료되지 않으면 결국 도난당한다.

---

## 4. Authentication and Authorization Are Separate — 인증과 인가는 별개다

**Authentication proves who you are. Authorization decides what you can do. Never conflate them.**
**인증은 당신이 누구인지 증명한다. 인가는 무엇을 할 수 있는지 결정한다. 혼동하지 마라.**

"Logged in" does not mean "allowed."
A valid session proves identity. It does not grant permission.
"로그인됨"은 "허용됨"이 아니다.
유효한 세션은 신원을 증명한다. 권한을 부여하지 않는다.

- Do not implement your own cryptographic primitives. Use proven, maintained libraries for auth and encryption.
  암호화 원시 함수를 직접 구현하지 마라. 인증과 암호화에는 검증되고 유지보수되는 라이브러리를 써라.
- Check authorization on every request. Not just the first.
  모든 요청에서 인가를 확인하라. 첫 번째만이 아니다.
- Server decides access. The client is a suggestion.
  서버가 접근을 결정한다. 클라이언트는 제안일 뿐이다.
- Session management: secure flags, HttpOnly, SameSite. These are not optional.
  세션 관리: secure 플래그, HttpOnly, SameSite. 선택 사항이 아니다.
- Password storage: bcrypt, scrypt, or argon2. Nothing else.
  비밀번호 저장: bcrypt, scrypt, 또는 argon2. 그 외는 없다.
- Protect authentication endpoints against brute force. Rate limiting is not optional.
  인증 엔드포인트를 무차별 대입 공격으로부터 보호하라. 속도 제한은 선택이 아니다.
- Security-sensitive code demands additional review. Authentication, authorization, cryptography, data access control — these are not regular code changes.
  보안 민감 코드는 추가 리뷰를 요구한다. 인증, 인가, 암호화, 데이터 접근 제어 — 이것은 일반 코드 변경이 아니다.

---

## 5. Protect Data at Every Stage — 데이터를 모든 단계에서 보호하라

**Data at rest, in transit, and in use — all three must be secured.**
**저장 중, 전송 중, 사용 중인 데이터 — 세 가지 모두 보호되어야 한다.**

There is no trusted network. Internal is not safe.
Every connection is authenticated and encrypted, or it is a liability.
신뢰할 수 있는 네트워크는 없다. 내부도 안전하지 않다.
모든 연결은 인증되고 암호화되거나, 부채다.

Data is the target. Not the code. Not the infrastructure. The data.
Protecting code while leaving data exposed
is locking the door with the windows open.
데이터가 표적이다. 코드가 아니다. 인프라가 아니다. 데이터다.
데이터는 노출한 채 코드만 보호하는 것은
창문은 열어둔 채 문을 잠그는 것이다.

- TLS everywhere. No exceptions for "internal" services.
  모든 곳에 TLS. "내부" 서비스라고 예외 없다.
- Encrypt sensitive data at rest. If the disk is stolen, the data is still safe.
  민감한 데이터는 저장 시 암호화하라. 디스크가 도난당해도 데이터는 안전해야 한다.
- Classify data. Know which fields are PII, which are confidential, which are public.
  데이터를 분류하라. 어떤 필드가 PII인지, 기밀인지, 공개인지 파악하라.
- Log access to sensitive data. If you cannot answer "who accessed what, when" — your audit trail is broken.
  민감한 데이터 접근을 로깅하라. "누가 무엇에 언제 접근했는가"에 답할 수 없으면 — 감사 추적이 깨진 것이다.
- Do not expose sensitive data in URLs, error messages, or logs.
  URL, 에러 메시지, 로그에 민감한 데이터를 노출하지 마라.
- Retention: do not keep data longer than needed. Data you do not have cannot be breached.
  보존: 필요 이상으로 데이터를 보관하지 마라. 갖고 있지 않은 데이터는 침해될 수 없다.

---

## 6. Dependencies Are Attack Surface — 의존성은 공격 면이다

**Every dependency is code you did not write, running with your permissions.**
**모든 의존성은 당신이 작성하지 않았지만 당신의 권한으로 실행되는 코드다.**

A supply chain attack does not need to find a bug in your code.
It just needs one compromised library in your dependency tree.
공급망 공격은 당신의 코드에서 버그를 찾을 필요가 없다.
의존성 트리에서 하나의 침해된 라이브러리면 충분하다.

- Pin dependency versions. A floating version is an unreviewed code change.
  의존성 버전을 고정하라. 유동적 버전은 리뷰되지 않은 코드 변경이다.
- Review what you add. Read the package scope, permissions, and maintainer history before adopting.
  추가하는 것을 리뷰하라. 도입 전에 패키지의 범위, 권한, 관리자 이력을 읽어라.
- Fewer dependencies is more secure. If you can write it in 20 lines, do not import a package.
  의존성이 적을수록 안전하다. 20줄로 작성할 수 있으면 패키지를 임포트하지 마라.
- Keep dependencies updated. Known vulnerabilities with available patches are negligence, not risk.
  의존성을 업데이트하라. 패치가 있는 알려진 취약점은 위험이 아니라 태만이다.
- Use lockfiles. Commit them. They are the snapshot of what you actually run.
  락파일을 사용하라. 커밋하라. 실제로 실행하는 것의 스냅샷이다.
- Secure the build pipeline. If the CI/CD is compromised, every deployment is compromised.
  빌드 파이프라인을 보호하라. CI/CD가 침해되면 모든 배포가 침해된다.

---

## 7. Fail Secure — 안전하게 실패하라

**When something goes wrong, the system must default to the safe state.**
**무언가 잘못되면 시스템은 안전한 상태를 기본으로 해야 한다.**

A crash is better than an open door.
When the auth service is down, the answer is "access denied" — not "access granted."
크래시가 열린 문보다 낫다.
인증 서비스가 다운되면 답은 "접근 거부"다 — "접근 허용"이 아니다.

- Default deny. If the system cannot verify, it must reject.
  기본 거부. 시스템이 검증할 수 없으면 거부해야 한다.
- Defense in depth. No single layer is sufficient. When one defense fails — and it will — the next must hold.
  심층 방어. 단일 레이어는 충분하지 않다. 하나의 방어가 실패하면 — 그리고 반드시 실패한다 — 다음이 잡아야 한다.
- Error messages to users must not reveal system internals.
  사용자에게 보여주는 에러 메시지에 시스템 내부를 드러내지 마라.
- Security-critical failures must be loud. Alert, log, and notify.
  보안 관련 실패는 크게 알려야 한다. 알림, 로깅, 통지.
- Do not trust client-reported errors or status codes for security decisions.
  보안 결정에 클라이언트가 보고한 에러나 상태 코드를 신뢰하지 마라.
- Security is not a one-time setup. Review, test, and audit continuously. A system that was secure last year is not necessarily secure today.
  보안은 일회성 설정이 아니다. 지속적으로 리뷰, 테스트, 감사하라. 작년에 안전했던 시스템이 오늘도 안전한 것은 아니다.
