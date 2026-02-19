$$
L:\begin{cases}
x = x(t) \\
y = y(t)
\end{cases}
\quad
t \in [t_{1};t_{2}]
$$

$$
\int_\limits{L}f(x,y)dl=\int_\limits{L}f(x(t),y(t))dl
$$
Распишем длин у дуги на i-ом участке через теорему пифагора
$$
\Delta l_{i}=\sqrt{ \Delta x_{i}^2 +\Delta y_{i}^2}=
$$
$$
=\sqrt{ (x(t_{i+1}) - x(t_{i}))^2 + (y(t_{i+1}) - y(t_{i}))^2 }
$$
по Лагранжу: 
$$
\begin{cases}
x(t_{i+1}) - x(t_{i}) = x^{^\prime}(c_{i})(t_{i+1} - t_{i}) \\
y(t_{i+1}) - y(t_{i}) = y^{^\prime}(c_{i})(t_{i+1}-t_{i})
\end{cases}
\quad c_{i} \in L
$$

**Отступление. Теорема Лагранжа**
>[!Note]
>Формулировка:
>Пусть $f(x)$ — функция, непрерывная и дифференциируемая на отрезке [a,b]. Тогда: существует точка $c \in (a;b)$ такая, что: 
> $$
> f^{^\prime}(c) = \frac{f(b)-f(a)}{b-a}
> $$
> или, в эквивалентной форме:
> $$
> f(b)-f(a)=f^{^\prime}(c)\cdot(b-a)
> $$

***

$$
=\left| \text{по теореме Лагранжа}
\begin{cases}
\Delta x_{i} = x^{^\prime}(\tilde{t_{i}})\Delta t_{i} \\
\Delta y_{i} = y^{^\prime}(\tilde{\tilde{t_{i}}})\Delta t_{i}
\end{cases}
\right |=
$$

$$
= \sqrt{ x^{^\prime{2}}(\tilde{t_{i}})^2 + y^{^\prime{2}}(\tilde{\tilde{t_{i}}}) } \cdot|\Delta t_{i}|
$$
Переходим к пределу при бесконечно малом приращении — $\tilde{t_i}$ и $\tilde{\tilde{t_i}}$ "сожмутся" в $t$. Получаем:
$$
dl = \sqrt{ x^{^\prime{2}}(t) + y^{^\prime{2}}(t) }dt
$$
Итог:
$$
\int_\limits{L}f(x,y)dl=\int_\limits{L}f(x(t),y(t))dl= \int_\limits{L}f(x(t),y(t))\sqrt{ x^{^\prime{2}}(t) + y^{^\prime{2}}(t) }dt
$$

###### Объяснение другими словами с нуля:

Пусть кривая задана параметризацией:
$\sqsupset L: \begin{cases} x=x(t) \\ y=y(t) \end{cases},\ t\in [t_1,t_2]$
Для начала вычислим $dl$:

По теореме Пифагора:
$\Delta l_i = \sqrt{\Delta x_i^2 + \Delta y_i^2}=*$
По теореме Лагранжа:
$\exists \tilde{t_i}, \tilde{\tilde{t_i}} : \Delta x_i = x'(\tilde{t_i})\Delta t_i,\ \Delta y_i = y'(\tilde{\tilde{t_i}})\Delta t_i$
Если не понятно, каким образом это следует из теоремы Лагранжа — напомню: у нас в данном случае $x$ и $y$ — это функции от переменной $t$. Ну а как к функции одной переменной применить теорему Лагранжа — должно быть понятно.
По т. Пифагора:
$*=\sqrt{(x'(\tilde{t_i}))^2\Delta t_i^2+(y'(\tilde{\tilde{t_i}}))^2\Delta t_i^2}=|\Delta t_i| \cdot \sqrt{(x'(\tilde{t_i}))^2+(y'(\tilde{\tilde{t_i}}))^2}$
Переходим к пределу при бесконечно малом приращении — $\tilde{t_i}$ и $\tilde{\tilde{t_i}}$ "сожмутся" в $t$:
$dl=\sqrt{(x'(t))^2+(y'(t))^2}\ dt$
И в результате имеем:
$\int\limits_{L} f(x,y)\ dl = \int\limits_{t_1}^{t_2} f(x(t),y(t))\ \sqrt{(x'(t))^2+(y'(t))^2}\ dt$
Куда делся модуль $|\Delta t_i|$ при предельном переходе? Дело в том, что при интегрировании нижний предел $t_1$ всегда меньше верхнего $t_2$, а значит $dt$ всегда будет положительным.