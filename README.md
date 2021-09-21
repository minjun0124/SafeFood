# 🌿SafeFood

본 프로젝트는 SSR에서 RESTful, CSR 을 거쳐 MSA 순서로 전환하며 아키텍처 및 스프링 프로젝트 학습을 목적으로 합니다.

<h3>🗂관련 저장소</h3>

- SafeFood (SafeFood Version.1)
	- SSR, JPA 적용
    - Link : https://github.com/minjun0124/SafeFood (현재 위치)
- Nutrition-Designer (SafeFood Version.2)
	- CSR, RESTful 적용
    - Link : https://github.com/minjun0124/NUDE
- Nutrition-Designer-MSA (SafeFood Version.3)
	- MSA 전환
    - Link : https://github.com/minjun0124/nude-msa
___

<br>

💻프로젝트 기획 배경 및 목표
---
- 사용자의 알러지 정보를 기반으로 안전한 식품을 섭취할 수 있도록 정보를 제공한다.
- 섭취한 영양소를 기반으로 부족한 영양소를 채울 수 있는 식품을 추천한다.

<br>

✏학습 목표
---
- Spring Framework에 대해 다시 학습한다.
- MyBatis를 적용하여 SQL 중심이었던 이전 프로젝트에 JPA를 적용하고 객체 지향적인 설계를 지향한다.

<br>

🛠개발 환경
---
- Java 11
- SpringBoot 2.5.1
- Spring-Data-JPA
- JSP
- Lombok
- MariaDB

<br>

📃ERD
---
<img src="/img/DB_ERD/DB_ERD.png" width="1000px" height="765px" title="DB_ERD" alt="DB_ERD"></img><br/>
<br>
보다 정확한 이미지를 보기 위해 이미지를 클릭하십시오.

<br>

🖥Web Page
---
<img src="/img/WebPage/01_메인페이지.png" width="1000px" height="800px" title="MainPage" alt="MainPage"></img>
<br>
< 메인페이지 >
<br>
<img src="/img/WebPage/07_상품_알러지1.PNG" width="1000px" height="800px" title="ItemAllergy01" alt="ItemAllergy01"></img>
<br>
< 알러지 해당 상품 선택 >
<br>
<br>
[이미지 더 보기][https://github.com/minjun0124/SafeFood/tree/main/img/WebPage]

<br>
<br>

# 💡Discussion

<h3>프로젝트 수행 중 느낀 점, 기술적인 내용 정리</h3>
<br>

Entity Class
---
- 최대한 외부에서 Entity 클래스의 getter method를 사용하지 않도록 해당 클래스 안에서 필요한 로직 method을 구현한다.
    - 단, Domain Logic만 가지고 있어야 하며 Presentation Logic을 가지고 있어서는 안된다.
    - 여기서 구현한 method는 주로 Service Layer에서 사용한다.
- Entity 클래스와 DTO 클래스 분리 목적
    - View Layer와 DB Layer의 역할을 철저하게 분리하기 위함이다.
    - 테이블과 매핑되는 Entity 클래스가 변경되면 여러 클래스에 영향을 끼치게 되는 반면 View와 통신하는 DTO 클래스(Request / Response 클래스)는 자주 변경되므로 분리해야 한다.
    - API와 Entity를 정확히 분리할 수 있다. 
        (Entity 수정으로부터 자유로울 수 있다. 오류 발생 시 컴파일 단계에서 잡을 수 있다.)
    - Entity가 어떻게 다뤄지는지 명확하게 알 수 있다.
        - 필요한 데이터를 어떻게 가져오는지 못 가져온 데이터는 어떻게 채워지는 지 알 수 있다.
        - Entity만 보고 알기에는 어려운 부분들이 있기 때문
    - 추가로 Entity를 외부로 노출하면 보안 상의 문제도 발생할 수 있다.
    - DTO만 봐도 API의 스펙을 알 수 있다. (Entity를 보고 API 스펙을 아는 건 어렵다)

<br>

JPA
---
- Delete Logic
    - CASCADE 옵션, OrphanRemoval 적용

- 영속성 전이
    - CASCADE - ALL, PERSIST 정도만 고려한다.
    - 사용가능 조건
        - 두가지 조건을 모두 만족할 것
        - 단일 소유관계
        - 라이프 싸이클이 동일
    - 고아 객체
        - orphanRemovel = true
            - 부모 객체에서 해당 엔티티에 대한 관계성을 끊으면 자식 객체는 고아 객체가 되고 삭제된다.
            - 이는 CASCADE.REMOVE 와 같은 효과를 낸다.
            - CASCADE.ALL + orphanRemovel = true 같이 쓰면 부모 객체를 통해 자식 객체의 생명 주기를 관리할 수 있다.
                - 이는 DDD(도메인 주도 설계)의 Aggregate Root 개념을 구현할 때 유용하게 사용되며,
                    자식 객체는 레파지토리를 생성하지 않는 것이 좋다는 개념이다.

- Error Detection
    - 가장 위험한 에러는 Runtime 중 발생하는 에러이다.
    - SQL Mapper는 SQL을 XML 파일에 작성하여 사용하며 에러 발생 시 Runtime error 발생 확률이 높지만,
        JPA는 대다수의 경우 Build 단계에서 에러를 잡아낼 수 있다.
- update 수행 시 em.merge 가 아니라 jpa의 변경, 감시를 고려하여 설계할 것
- PageRequest, Pageable을 사용하면 쉬운 Pagenation이 가능하다.
- @ManyToMany -> @OneToMany, @ManyToOne
    - M:N 관계를 가진 엔티티는 1:N, N:1 관계로 풀어내는 것이 좋다.
    - 두 테이블의 외래키를 복합키로 가지는 것 보다는 연결 테이블 자체에 무의미한 고유 키를 설정하는 것이 좋다.
        이후 서비스 확장을 고려할 때 조금 더 나은 선택이며 아래와 같이 복잡한 처리가 필요하기 때문이다.
    - 식별 관계에서 복합키를 표현하기 위해 EmbeddedId 를 사용한다.
    - 복합키 클래스는 @Embeddable 을 할당하고 Serializable, 생성자를 구현한다.  equals, hashCode를 override하여 구현한다.
- Lazy Loading
    - 지연 로딩을 피하기 위해 즉시 로딩으로 설정하는 설계를 지양한다.
        즉시 로딩으로 인해 연관 관계가 불필요한 경우에도 데이터를 항상 조회해서 성능 문제가 발생할 수 있으며 성능 튜닝이 어렵다.
    - 지연 로딩을 기본으로 사용하고 성능 최적화가 필요한 경우 Fetch Join 을 사용한다.

<br>

API 접근 
---
- getMapping 으로 정보를 변경할 수 있게 되면 url만으로도 table에 접근하여 정보를 변경할 수 있게 된다.</br>
    ex) http://localhost:8080/carts/insert?intakecode=0&code=20&id=test&quantity=1
    <br>따라서 이런 경우 권한을 확인하는 방법이나 POST mapping으로 변경할 것을 고려해봐야 한다.

<br>

Common
---
- 객체의 null check 는 != null 의 형태가 아닌 Optional 객체를 사용해서 판단하면 NPE 로부터 안전하다.

- Query성 메소드와 Command 성 메소드를 분리할 것.
	- 유지 보수 용이
	- 서비스 확장 용이

- Entity 직접 반환의 문제점
	- List를 반환하는데 나는 Member만 알고 싶어, Order는 필요없다구. 특히 패스워드까지 줘버리면 어떡해?
	- 물론 Order 나 Password에 @JsonIgnore를 걸 수는 있겠지만, Member 객체만 가지고 모든 서비스, API에
	  다 대응할 거냐? -> 불가능
	- List를 반환하는데 List외의 다른 데이터도 함께 넣어서 반환하고 싶다? List를 반환한 Json에 그대로 데이터를
	  추가 삽입하여 반환하면 될 것 같지만, 이는 Json 형식을 깨버리는 행위이다.
	  따라서 List도 Generic Class로 한번 감싸서 Json 데이터의 일부로 만들어주고 그 외의 데이터는 추가 삽입해준다. 

<br>
<br>

# 👾Issue note
<h3>프로젝트 중 발생한 주요 이슈 및 해결 과정</h3>
<br>

org.hibernate.propertyAccessException: could not set field value by reflection 발생
---
- 해결 : em.persist(cart) 하는 과정에서 Food, User, Quantity 등 다 세팅해주었으나 복합키인 CartId 를 set 해주지 않았다.
- 연관 관계 맵핑이 있기 때문에 새로운 Cart를 만들때 Food, User 객체를 찾아서 입력을 해주어야 insert가 된다.

- filed를 nonnull로 설정하면 반드시 default value 를 설정해줘야 한다.

<br>

N+1 Problem
---
- org.hibernate.LazyInitializationException - could not initialize proxy - no Session 발생
    
    Cart 에서 연관 관계 Entity인 Food를 조회하자 발생했다.
    
    이는 Food에 적용한 매핑이 @ManyToOne(fetch = FetchType.Lazy) 이기 때문인데 
    Lazy로 설정한 이유는 Cart List를 조회했을 때 Cart 의 리스트만 뽑아오는 쿼리는 한번이지만
    리스트의 사이즈가 10일 경우 이에 따라 Food를 가져오는 join 연산이 10번 발생하기 때문이다.
    따라서 총 11번의 쿼리가 생성되게 되고 사이즈가 10만이면 10만 1개의 쿼리가 발생하는 것이다.
    이런 문제를 JPA에서 자주 만나게 되는 N+1 problem 이라고 한다.
- 해결 : 메소드 단위에 @Transactional을 걸어 DB 커넥션을 유지한다.

- org.hibernate.lazyinitializationexception could not initialize proxy
	- JPQL Fetch Join으로 해결
		- 대부분 JPQL Fetch Join으로 해결된다.
		- 일반 조인 실행 시 연관된 Entity를 함께 조회하지는 않는다.
		- 그렇다고 데이터가 프록시인 것은 아니나 해당 데이터에 접근하려고 하면 로딩 시점에 쿼리가 실행된다.
		- fetch join 을 사용하면 연관된 엔티티까지 모두 조회해온다.
		- distinct 와 함께 사용하면 중복 엔티티 문제를 해결할 수 있다.
			- select distinct t From Team t join fetch t.members;
			- 중복된 Team entity 를 제거할 수 있다.
			- 조회 시 Entity 즉, 객체 단위로 조회해오기 때문에 이렇게 객체 단위로 중복 제거도 가능
		- fetch join은 SQL에는 없는 문법이다.
			- 이처럼 JPQL에는 기존 SQL에 객체지향적으로 접근할 수 있는 문법이 존재한다.

<br>

JPA : Entity 직접 노출 & toString 호출
---
- 엔티티를 직접 노출할 때는 양방향 연관관계가 걸린 곳은 꼭 한 곳을 @JsonIgnore 처리 해야 한다.
- 양쪽을 서로 호출하며 무한 루프가 발생하고 Stackoverflow의 원인이 된다.
- DTO를 사용하는 것이 가장 좋다.

<br>

JSP
---
- 경로를 상대 경로로 요청하여 현재 경로 대비로 이동하기 때문에 request url에 문제가 발생한다.
    - <c:set var="path" value="<%=request.getContextPath()%>" scope="application"/> 와 같이 path variable에 root path 를 설정
    - 요청 시  frm.action="${path}/carts/insert"; 와 같이 요청하면 root path 대비 상대 경로로 이동하여 해결할 수 있다.




