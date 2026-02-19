---
tags:
  - uni
---
* Людям сложнее читать код на многопоточке чем упорядоченный: “humans are quickly overwhelmed by concurrency and find it much more difficult to reason about concurrent than sequential code”
* “in science, data parallel language extensions and message passing libraries (like PVM, MPI , and OpenMP1) dominate over threads for concurrent programming”
* “An interesting property of many embedded applications is that reliability and predictability are far more important than expressiveness or performance. It is arguable that this should be true in general purpose computing, but that’s a side argument. I will argue that achieving reliability and predictability using threads is essentially impossible for many applications” 
* Главная проблема с математической точки хрения – неопределенность (недетерминированность) в вычислениях на многопоточке, так как невозможно определить эквивалентность двух состояний процессов: “We conclude that with threads, there is no useful theory of equivalence”
* Автор считает, что если продолжить пушить мультитрединг в массы, то следующее поколение компьютеров будет неработающим: “These same computer vendors are advocating more multi-threaded programming, so that there is concurrency that can exploit the parallelism they would like to sell us. Intel, for example, has embarked on an active campaign to get leading computer science academic programs to put more emphasis on multi-threaded programming. If they are successful, and the next generation of programmers makes more intensive use of multithreading, then the next generation of computers will become nearly unusable.”
* “Regrettably, I have to conclude that testing may never reveal all the problems in nontrivial multithreaded code”
Какие существуют компромиссы, чтобы нормально использовать мультитрединг?
* “A common compromise is to extend established programming languages with annotations or a few selected keywords to support concurrent computation” - C-like языки. Но данные фичи все еще обладают риском deadlock’а. То есть автор нихуя не придумал?
* “But achieving deterministic aims through nondeterministic means remains difficult”. WOW!!!!!!
Альтернативы
* Просто хуйню какую то высрал на две страницы про своего Птолемея Второго. Долбоёб сука.
* Добавил некий “Merge block”, который является единственной недетерминированной частью программы.
* Короче придумал какую то непонятную шнягу и на её примере сказал мол вот, у нас вся программа кроме мёрж блока стала детерминированной так как у неё нет зацикленности. Добавляем некого Process Network Manager’a и вуаля.
Почему эти альтернативы не будут использоваться?
* “Probably the most important is that the very notion of programming, and the core abstractions of computation, are deeply rooted in the sequential paradigm. The most widely used programming languages (by far) adhere to this paradigm.”
* “We should not replace established languages. We should instead build on them. However, building on them using only libraries is not satisfactory. Libraries offer little structure, no enforcement of patterns, and few composable properties.”
* “I believe that the right answer is coordination languages. Coordination languages do introduce new syntax, but that syntax serves purposes that are orthogonal to those of established programming languages”
* 