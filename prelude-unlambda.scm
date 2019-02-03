(unlambda-def 'void 'v)
(unlambda-def 'call/cc 'c)
(unlambda-def 'exit 'e)
(unlambda-def 'read '@)
(unlambda-def 'reprint 'bar)

(unlambda-def '(void-not p) '(c (lambda (cont) (k i (p cont v)))))
