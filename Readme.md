# sep: A S-expression parser for lisp

Numbers:
```
1
=> [1]
```

Strings;
```
"Hello World!"
=> ["Hello World"]
```

Lists:
```
()
=> [[]]

'(one two)
=> [[:quote, [:one, :two]]]
```

Lets:
```
(let ((x 10) (y 20)) (foo x y))
=> [[:let, [[:x, 10], [:y, 20]], [:foo, :x, :y]]]
```

Definitions:
```
(define a 1)
=> [[:define, :a, 1]]

(define (square x) (* x x))
=> [[:define, [:square, :x], [:*, :x, :x]]]

"(define foo 42) ; define foo with an initial value of 42"
=> [[:define, :foo, 22]]

(define firstfive '(one two three four five))
=> [[:define, :firstfive, [:quote, [:one, :two, :three, :four, :five]]]]

(map (lambda (x) (+ x x)) mylist)
=> [[:map, [:lambda, [:x], [:+, :x, :x]], :mylist]]
```

Conditions:
```
(cond (test1 (action1)) (test2 (action2)) (test3 (action3)) (else (action4)))
=>[[:cond,
  [:test1, [:action1]],
  [:test2, [:action2]],
  [:test3, [:action3]],
  [:else, [:action4]]]]
```

Blankspace:
```
   1
=> [1]
```
