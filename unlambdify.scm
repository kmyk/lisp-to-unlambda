; unlambda-def.

(define unlambda-defs '())

(define (unlambda-def name body)
  (set! unlambda-defs
        (cons (if (pair? name)
                  (cons (car name)
                        (curry-lambda (cdr name) (curry body)) )
                  (cons name (curry body)) )
              unlambda-defs )))

(define (unlambda-def-lookup name)
  (assv name unlambda-defs) )

; Macro expansion.

(define (expr-dispatch-unlambda expr leaf dely dot question appl lamb)
  (if (pair? expr)
      (cond
       ((eq? (car expr) 'lambda) (lamb (caadr expr) (caddr expr)))
       ((memq (car expr) '(d delay)) (dely (cadr expr)))
       ((memq (car expr) '(dot print)) (dot (cadr expr)))
       ((memq (car expr) '(? compare)) (question (cadr expr)))
       (else (appl (car expr) (cadr expr))) )
      (leaf expr) ))

(define (expand-unlambda-macros expr)
  (let helper ((expr expr) (exclude '()) (stack '()))
    (expr-dispatch-unlambda expr
     (lambda (leaf)
       (cond ((memv leaf exclude) leaf)
             ((memv leaf stack)
              (display "Recursion within lazy-defs detected: ")
              (display (cons leaf stack))
              (newline)
              (error) )
             (else
              (let ((def (unlambda-def-lookup leaf)))
                (if def
                    (helper (cdr def) exclude (cons leaf stack))
                    (let ((def (lazy-def-lookup leaf)))
                     (if def
                         (helper (cdr def) exclude (cons leaf stack))
                         leaf )))))))
     (lambda (f)
       (list 'delay (helper f '() '())) )
     (lambda (c)
       (list 'dot c) )
     (lambda (c)
       (list '? c) )
     (lambda (f g)
       (list (helper f exclude stack) (helper g exclude stack)) )
     (lambda (var body)
       `(lambda (,var) ,(helper body (cons var exclude) stack)) ))))

; Printing it out.

(define (print-as-full-unlambda lazified-code)
  (let self ((code lazified-code))
    (expr-dispatch-unlambda code
     (lambda (leaf)
      (cond ((eq? leaf 'i) (display "i"))
            ((eq? leaf 'k) (display "k"))
            ((eq? leaf 's) (display "s"))
            ((eq? leaf 'v) (display "v"))
            ((eq? leaf 'c) (display "c"))
            ((eq? leaf 'e) (display "e"))
            ((eq? leaf '@) (display "@"))
            ((eq? leaf 'bar) (display "|"))
            (else (display "[") (display leaf) (display "]")) ))
     (lambda (f)
      (display "`d")
      (self f))
     (lambda (c)
      (display ".")
      (display c))
     (lambda (c)
      (display "?")
      (display c))
     (lambda (f g)
      (display "`")
      (self f)
      (self g) )
     (lambda (var body)
      (error "Can't print lambdas as Lazy code!") )))
  (newline) )

; Putting it all together.

(define (unlambdify code)
  (unabstract (expand-unlambda-macros (curry code))) )
