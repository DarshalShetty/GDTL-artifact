#lang s-exp GDTL

(define
  (plus : (-> Nat Nat Nat))
  (plus m n = (NatElim m (lambda (x) Nat) n m-1 rec (Succ rec))))

(define
  (mult : (-> Nat Nat Nat))
  (mult m n = (NatElim m (lambda (x) Nat) 0 m-1 rec (plus n rec))))

(define
   (loop : {-> (A : (Set 10)) (B : (Set 10)) {-> {-> A B} {-> A B}} ? {-> A B}})
   (loop A B f x = (f (lambda (y) (x x y)))))

(define
   (Z : {-> (A : (Set 10)) (B : (Set 10)) {-> {-> A B} {-> A B}} {-> A B}})
   (Z A B f = ((loop A B f) (loop A B f))))

(define
  (ifzero? : { -> (A : (Set 1)) Nat A A A})
  (ifzero? A n S1 S2 = (NatElim 2 n (lambda (x) A) S1 x1 x2 S2)))

(define
  (sub1 : (-> Nat Nat))
  (sub1 n = (NatElim n (lambda (x) Nat) 0 n-1 rec n-1)))

(define
  (almost-plus : (-> (-> Nat Nat Nat) Nat Nat Nat))
  (almost-plus self m n = (ifzero? Nat m n (Succ (self (sub1 m) n)))))

((Z Nat (-> Nat Nat) almost-plus) 1)
