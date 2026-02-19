#uni 
#prog

# architecture

Spring

Browser -> Spring Controller -> Service -> Repository -> Database

Java EE

Browser -> jsf managed bean -> service layer -> repository layer (repository, entityManager API) -> Database


# Models
```java
@Entity
@Table(name="movies")
public class Movie {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(nullable=false)
	private String title;
	
	@Column(nullable=false)
	private String genre;
	
	@OneToMany(mappedBy = "movie", cascade = CascadeType.All)
	private List<Session> sessions;
}
```

```java
public class Session {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne
	@JoinColumn(name="movie_id", nullable=false)
	private Movie movie;
	
	//same with cinema
	
	@ManyToMany
	@JoinTable(
		name= "session_seats",
		joinColumns = @JoinColumn(name="session_id"),
		inverseJoinColumns = @JoinColumn(name="seat_id")
	)
	private List<Seat> seats;
	
	@OneToMany(mappedBy= "session", cascade = CascadeType.ALL)
	private List<Order> orders;

}
```
# html forms
Spring (thymeleaf)
```html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Some title<title>
</head>
<body>
	<form action=/some/endpoint" method="get">
		<label for "name">Имя:</label>
		<input type="text" id="name" name="name" placeholder="Введите имя" required />
		<button type="submit">Submit</button>
	</form>
	
	<h1>Last order</h1>
	<p>User:<th:text="${order.user.name}"></p>
	<p>Movie:<th:text="${order.session.movie.name}"></p>
	<o>Place:<th:text="${order.setNumber}"></p>
</body>
</html>
```

JSF
```js
<!DOCTYPE html>
<head>
	<title>Some title<title>
</head>
<body>
	<h1> find last user's order </h1>
	<h:form>
		<h:outputLabel> for="name" value="Имя:" />
		<h:inputText id="name" value="#{orderBean.userName}" required="true" placeholder="Введите имя" />
		<h:commandButton value="Submit" action="#{orderBean.findLastOrder}"/>
	</h:form>
	
	<h:panelGroup rendered="#{not empty orderBean.LastOrder}">
		<h2>Last order</h2>
		<p>User: #{orderBean.lastOrder.user.name}</p>
		<p>Movie: #{orderBean.lastOrder.session.movie.title}</p>
		<p>Place: #{orderBean.lastOrder.seatNumber}</p>
	</h:panelGroup>
</body>
```

# controller vs managed bean
Spring
```java
@Controller
public class OrderController {
	
	public final OrderService orderService;
	
	public OrderController(OrderService orderService){
		this.orderService = orderService;
	}
	
	@getMapping("/some/url")
	public String getLastOrder(@RequestParam("name") String userName, Model model){
		Order lastOrder = orderService.findLastOrderUser(userName);
		model.addAttribute("order", lastOrder);
		return "last-order"; // html-page
	}
}
```

EE bean

```java

@Named("orderBean")
@RequestScoped
public class OrderManagedBean {
	@inject
	private OrderService orderService;
	
	private String userName;
	private Order lastOrder;
	
	//getters & setters with lombok
	
	public String findLastOrder() {
		this.lastOrder = orderService(findLastOrderForUser(userName));
		return null; // stay on the same page
	}
}
```

# EE service vs Spring service
Spring
```java
@Service
public class OrderService{
	private final OrderRepository orderRepository;
	
	public OrderService(OrderRepository orderRepository) {
		this.orderRepository = orderRepository; 
	}
	
	public Order findLastOrderForUser(String userName) {
		return orderRepository.findLastorderByUserName(userName);
	}
}
```
EE
```java
@Stateless
public class OrderService {
	@Inject
	private final OrderRepository orderRepository;
	
	public Order findLastOrderForUser(String userName) {
		return orderRepository.findLastorderByUserName(userName);
	}
}
```

# EE repo vs Spring repo

Spring 
```java

@Repository
public class OrderRepository {
	@PersistenceContext
	private EntityManager entityManager;
	
	public Order findLastOrderByUserName(String userName) {
		String query = "SELECT o FROM Order o JOIN o.user u WHERE u.name = :name ORDER BY o.id DESC";
		TypedQuery<Order> tq = entityManager.createQuery(query, Order.class);
		tq.setParameter("name", userName);
		
		return tq.getSingleResult();
	}
}
```

EE
```java
@Stateless
public class OrderRepository {
	@PersistenceContext
	private EntityManager entityManager;
	
	public Order findLastOrderByUserName(String userName) {
		String query = "SELECT o FROM Order o JOIN o.user u WHERE u.name = :name ORDER BY o.id DESC";
		TypedQuery<Order> tq = entityManager.createQuery(query, Order.class);
		tq.setParameter("name", userName);
		
		return tq.getSingleResult();
	}
}
```