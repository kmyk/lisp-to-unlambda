(load "../lazier.scm")
(load "../prelude.scm")
(load "../prelude-numbers.scm")
(load "../unlambdify.scm")

(lazy-def 'M
 '(lambda (f) (f f)))
(unlambda-def 'main
 '(M (s (dot B) (dot A))) )

(print-as-full-unlambda (unlambdify 'main))
