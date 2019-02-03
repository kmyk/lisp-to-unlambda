(load "../lazier.scm")
(load "../prelude.scm")
(load "../prelude-numbers.scm")
(load "../unlambdify.scm")

; https://atcoder.jp/contests/abc006/tasks/abc006_1
; read a digit '1' ... '9' and print whether it is a multiplier of 3

(unlambda-def 'main
 '((dot S) ((dot E) ((dot Y)
             (c (lambda (cont)
                 ((lambda (f) (e ((dot O) ((dot N)
                                           ((? 9) f ((? 6) f ((? 3) f (@ i))))))))
                  (lambda (p) (p cont p)))))))) )

(print-as-full-unlambda (unlambdify 'main))
