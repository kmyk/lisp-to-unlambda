(load "../lazier.scm")
(load "../prelude.scm")
(load "../prelude-numbers.scm")
(load "../unlambdify.scm")
(load "../prelude-unlambda.scm")

; https://atcoder.jp/contests/abc117/tasks/abc117_b

(lazy-def '(max a b)
  '(if<= a b b a) )

(unlambda-def '(writeYes x)
  '((dot s) ((dot e) ((dot Y) x))) )

(unlambda-def '(writeNo x)
  '((dot o) ((dot N) x)) )

(unlambda-def '(update n pair)
  '(cons (max (car pair) n) (+ (cdr pair) n)) )

(unlambda-def '(write pair)
  '(if< (* 2 (car pair)) (cdr pair) writeYes writeNo i) )

(unlambda-def 'main
 '(write ((read-int i) (d (read-int update)) (cons 0 0))) )

(print-as-full-unlambda (unlambdify 'main))
