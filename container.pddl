(define (domain container)

    (:requirements :strips)

    (:predicates
        (CONTAINER ?c)
        (LOCATION ?l)
        (TRANSPORT ?t)
        (at-container ?c ?l)
        (at-transport ?t ?l)
        (in ?c ?t)
        (can-go ?t ?from ?to)
    )

    (:action board
        :parameters (?c ?t ?l)
        :precondition (and (CONTAINER ?c) (TRANSPORT ?t) (LOCATION ?l)
                            (at-container ?c ?l) (at-transport ?t ?l))
        :effect (and (in ?c ?t) (not (at-container ?c ?l)))
    )
    
    (:action unboard
        :parameters (?c ?t ?l)
        :precondition (and (CONTAINER ?c) (TRANSPORT ?t) (LOCATION ?l)
                            (in ?c ?t) (at-transport ?t ?l))
        :effect (and (at-container ?c ?l) (not (in ?c ?t)))
    )
    
    (:action move
        :parameters (?c ?t ?from ?to)
        :precondition (and (CONTAINER ?c) (TRANSPORT ?t) (LOCATION ?from) (LOCATION ?to)
                            (at-transport ?t ?from) (in ?c ?t) (can-go ?t ?from ?to))
        :effect (and (at-transport ?t ?to) (not (at-transport ?t ?from)))
    )
     (:action move-back
        :parameters (?c ?t ?from ?to)
        :precondition (and (CONTAINER ?c) (TRANSPORT ?t) (LOCATION ?from) (LOCATION ?to)
                            (at-transport ?t ?from) (can-go ?t ?from ?to) (not (in ?c ?t)))
        :effect (and (at-transport ?t ?to) (not (at-transport ?t ?from)))
    )
)