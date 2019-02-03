(unlambda-def 'void 'v)
(unlambda-def 'call/cc 'c)
(unlambda-def 'exit 'e)
(unlambda-def 'read '@)
(unlambda-def 'reprint 'bar)

(unlambda-def '(void-not p)
  '(c (lambda (cont) (k i (p cont v)))) )

(unlambda-def '(void-if p a b)
  '(c (lambda (cont) (k cont (p cont a) b))) )

(lazy-def 'M
  '(lambda (f) (f f)) )

(unlambda-def '(read-int z)
  '(z (M (lambda (recur x)
              (c (lambda (next)
                  (k x
                   ((d (lambda (f)
                                  ((? 9) (f (+ 9))
                                  ((? 8) (f (+ 8))
                                  ((? 7) (f (+ 7))
                                  ((? 6) (f (+ 6))
                                  ((? 5) (f (+ 5))
                                  ((? 4) (f (+ 4))
                                  ((? 3) (f (+ 3))
                                  ((? 2) (f (+ 2))
                                  ((? 1) (f 1+)
                                  ((? 0) (f i)
                                   (@ i)))))))))))))
                              (lambda (g p) (p next (p recur recur (g (* 10 x))))))))))
               0)) )
