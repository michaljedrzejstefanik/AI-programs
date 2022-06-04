(define (domain warehouse)

    (:requirements :typing)
    (:types PL OB MV LD)
    
   
    
    (:predicates
        ; Objects - crates can be fragile
        (fragile ?o - OB)
        ; Objects - crates have to be loaded to the conveyor
        (loaded ?o - OB)
        ; The mover ?m is in place ?p
        (at_robby ?m - MV ?p - PL)
        ; Loader ?l is in place ?p
        (at_loader ?l - LD ?p - PL)
        ; The object - crate ?o is in place ?p
        (at_object ?o - OB ?p - PL)
        ; The mover ?m is free
        (free ?m - MV)
        ; The loader is ready
        (ready ?l - LD)
        ; The mover ?m is carrying object - crate ?o
        (carrying ?m - MV ?o - OB)
        ; The two grippers ?m1 and ?m2 are different
        (different ?m1 - MV ?m2 - MV)
        ; While loading the place cannot have objects- crates on the floor
        (empty_bay ?p - PL)
    )
    
     (:functions
        ; to measure units of time we are using function time
        (time)
        ; function that gives us distance between places
        (distance ?from - PL ?to - PL)
        ; weight of the objects- crates
        (mass ?o - OB)
    )
    
    
    (:action move_without
        ; move the mover from room ?from to room ?to
        :parameters (?m - MV ?from - PL ?to - PL)
        :precondition (and  (at_robby ?m ?from) (free ?m))
        :effect (and (at_robby ?m ?to) (not (at_robby ?m ?from)) (increase (time) (* 0.1 (distance ?from ?to))))
    )
    
     (:action move_with_one
        ; move the mover from room ?from to room ?to
        :parameters (?o - OB ?m - MV ?from - PL ?to - PL)
        :precondition (and  (at_robby ?m ?from) (not (free ?m)) (carrying ?m ?o) (not (fragile ?o)) (empty_bay ?to) (< (mass ?o) 50))
        :effect (and (at_robby ?m ?to) (not (at_robby ?m ?from)) (not (empty_bay ?to)) (increase (time) (* (* 0.01 (distance ?from ?to)) (mass ?o))))
    )

    (:action move_with_two_heavy
        ; move the movers from room ?from to room ?to
        :parameters (?m1 - MV ?m2 - MV ?from - PL ?to - PL ?o - OB)
        :precondition (and  (at_robby ?m1 ?from) (at_robby ?m2 ?from) (different ?m1 ?m2) (not (free ?m1)) (not (free ?m2)) (carrying ?m1 ?o) (carrying ?m2 ?o) (not (fragile ?o)) (empty_bay ?to) (>= (mass ?o) 50))
        :effect (and (at_robby ?m1 ?to) (at_robby ?m2 ?to) (not (at_robby ?m1 ?from)) (not (at_robby ?m2 ?from)) (not (empty_bay ?to)) (increase (time) (* (* 0.01 (distance ?from ?to)) (mass ?o))))
    )

     (:action move_with_two_light
        ; move the movers from room ?from to room ?to
        :parameters (?m1 - MV ?m2 - MV ?from - PL ?to - PL ?o - OB)
        :precondition (and  (at_robby ?m1 ?from) (at_robby ?m2 ?from) (different ?m1 ?m2) (not (free ?m1)) (not (free ?m2)) (carrying ?m1 ?o) (carrying ?m2 ?o) (not (fragile ?o)) (empty_bay ?to) (< (mass ?o) 50))
        :effect (and (at_robby ?m1 ?to) (at_robby ?m2 ?to) (not (at_robby ?m1 ?from)) (not (at_robby ?m2 ?from)) (not (empty_bay ?to)) (increase (time) (* (* 0.015 (distance ?from ?to)) (mass ?o))))
    )

    (:action move_with_fragile
        ; move the mover from room ?from to room ?to with fragile
        :parameters (?o - OB ?m1 - MV ?m2 - MV ?from - PL ?to - PL)
        :precondition (and  (at_robby ?m1 ?from) (at_robby ?m2 ?from) (not (free ?m1)) (not (free ?m2)) (carrying ?m1 ?o) (carrying ?m2 ?o) (fragile ?o) (empty_bay ?to))
        :effect (and (at_robby ?m1 ?to) (at_robby ?m2 ?to) (not (at_robby ?m1 ?from)) (not (at_robby ?m2 ?from)) (not (empty_bay ?to)) (increase (time) (* (* 0.01 (distance ?from ?to)) (mass ?o))))
    )



    
     (:action pickup_one
        ; pick up object ?o in place ?p with mover ?m
        :parameters (?o - OB ?p - PL ?m - MV)
        :precondition (and  (not (fragile ?o)) 
                            (at_robby ?m ?p) (at_object ?o ?p) (free ?m))
        :effect (and (carrying ?m ?o) (not (at_object ?o ?p)) (not (free ?m)) )
    )
    
    (:action pickup_two
        ; pick up object ?o in place ?p with mover ?m1 and mover ?m2
        :parameters (?o - OB ?p - PL ?m1 - MV ?m2 - MV)
        :precondition (and  (not (fragile ?o)) (different ?m1 ?m2)
                            (at_robby ?m1 ?p) (at_robby ?m2 ?p) (at_object ?o ?p) (free ?m1) (free ?m2))
        :effect (and (carrying ?m1 ?o) (carrying ?m2 ?o) (not (at_object ?o ?p)) (not (free ?m1)) (not (free ?m2)))
    )
    

    (:action pickup_fragile
        ; pick up light object ?o in place ?p with movers ?m1 ?m2
        :parameters (?o - OB ?p - PL ?m1 - MV ?m2 - MV)
        :precondition (and  (fragile ?o) (different ?m1 ?m2)
                            (at_robby ?m1 ?p) (at_robby ?m2 ?p)  (at_object ?o ?p) (free ?m1) (free ?m2))
        :effect (and (carrying ?m1 ?o) (carrying ?m2 ?o) 
                            (not (at_object ?o ?p)) (not (free ?m1)) (not (free ?m2)))
    )
    
      (:action putdown_two
        ; put down object ?o in place ?p with mover ?m
        :parameters (?o - OB ?p - PL ?m1 - MV ?m2 - MV)
        :precondition (and  (not (fragile ?o)) (different ?m1 ?m2) 
                            (carrying ?m1 ?o) (carrying ?m2 ?o) (at_robby ?m1 ?p) (at_robby ?m2 ?p))
        :effect (and (at_object ?o ?p) (free ?m1) (free ?m2) (not (carrying ?m1 ?o)) (not (carrying ?m2 ?o)))
    )
    
    
     (:action putdown_one
        ; put down object ?o in place ?p with mover ?m
        :parameters (?o - OB ?p - PL ?m - MV)
        :precondition (and  (not (fragile ?o))  
                            (carrying ?m ?o) (at_robby ?m ?p))
        :effect (and (at_object ?o ?p)  (free ?m) (not (carrying ?m ?o)))
    )
    
    
    (:action putdown_fragile
        ; put down object ?o in place ?p with movers ?m1 ?m2
        :parameters (?o - OB ?p - PL ?m1 - MV ?m2 - MV)
        :precondition (and  (fragile ?o) (different ?m1 ?m2) 
                            (carrying ?m1 ?o) (carrying ?m2 ?o) (at_robby ?m1 ?p) (at_robby ?m2 ?p))
        :effect (and (at_object ?o ?p) 
                            (free ?m1) (free ?m2)
                            (not (carrying ?m1 ?o)) (not (carrying ?m2 ?o)))
    )
    
    
    
    (:action loading_object_normal
    
    ; loading object ?o  at place ?p to conveyor with loader ?l
    :parameters (?o - OB ?p - PL ?l - LD)
    :precondition (and   
                  (not (loaded ?o)) (at_loader ?l ?p) (at_object ?o ?p) (ready ?l) (not (fragile ?o)))
    :effect (and (loaded ?o) (not (ready ?l)) (not (at_object ?o ?p)) (increase (time) 4))
    )

    (:action loading_object_fragile
    
    ; loading object ?o  at place ?p to conveyor with loader ?l
    :parameters (?o - OB ?p - PL ?l - LD)
    :precondition (and   
                  (not (loaded ?o)) (at_loader ?l ?p) (at_object ?o ?p) (ready ?l) (fragile ?o))
    :effect (and (loaded ?o) (not (ready ?l)) (not (at_object ?o ?p)) (increase (time) 6))
    )
    
    
    (:action reloading_loader
    
    :parameters (?l - LD  ?p - PL)
    :precondition(and (not (ready ?l)))
    :effect (and (ready ?l) (empty_bay ?p))
    )
    )