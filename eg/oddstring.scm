(load "../lazier.scm")
(load "../prelude.scm")
(load "../prelude-numbers.scm")
(load "../unlambdify.scm")
(load "../prelude-unlambda.scm")

; https://atcoder.jp/contests/abc072/tasks/abc072_b
; print chars in odd-indexed positions; e.g. "unlambda" -> "ulmd"

(lazy-def 'M
 '(lambda (f) (f f)))
(unlambda-def 'main
 '(M (lambda (f) ((d (read reprint read i)) f f))) )

(print-as-full-unlambda (unlambdify 'main))
