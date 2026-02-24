(define (domain lemon-fluent-domain)
(:requirements :fluents :typing :strips)

(:types
  basket lemon - object
  location
  robot
)

(:constants 
  base - location
)

(:predicates
  (connected ?l1 ?l2 - location)
  (grabbed ?r - robot ?o - object)
  (object_at ?o - object ?l - location)
  (robot_at ?r - robot ?l - location)
  (lemon_in ?l - lemon ?b - basket)
  (unloaded_at_base ?l - lemon)
  (gripper_free ?r - robot)
)

(:functions
  (basket_max ?b - basket)
  (basket_act ?b - basket)
  (lemon_weight ?l - lemon)
  (tree_weight ?l - lemon)
)

(:action move
  :parameters (?r - robot ?l1 ?l2 - location)
  :precondition
    (and
      (connected ?l1 ?l2)
      (robot_at ?r ?l1)
    )
  :effect
    (and
      (robot_at ?r ?l2)
      (not (robot_at ?r ?l1))
    )
)

(:action pick
  :parameters (?r - robot ?o - object ?l - location)
  :precondition
    (and
      (robot_at ?r ?l)
      (object_at ?o ?l)
      (gripper_free ?r)
    )
  :effect
    (and
      (not (object_at ?o ?l))
      (grabbed ?r ?o)
      (not (gripper_free ?r))
    )
)

(:action drop
  :parameters (?r - robot ?o - object ?l - location)
  :precondition
    (and
      (robot_at ?r ?l)
      (grabbed ?r ?o)
    )
  :effect
    (and
      (object_at ?o ?l)
      (not (grabbed ?r ?o))
      (gripper_free ?r)
    )
)

(:action deposit
  :parameters (?r - robot ?lem - lemon ?b - basket ?l - location)
  :precondition
    (and
      (robot_at ?r ?l)
      (object_at ?b ?l)
      (grabbed ?r ?lem)
      (<= (+ (lemon_weight ?lem) (basket_act ?b)) (basket_max ?b))
    )
  :effect
    (and
      (lemon_in ?lem ?b)
      (increase (basket_act ?b) (lemon_weight ?lem))
      (not (grabbed ?r ?lem))
      (gripper_free ?r)
    )
)

(:action unload
  :parameters (?r - robot ?b - basket ?lem - lemon)
  :precondition
    (and
      (robot_at ?r base)
      (object_at ?b base)
      (lemon_in ?lem ?b)
    )
  :effect
    (and
      (unloaded_at_base ?lem)
      (decrease (basket_act ?b) (lemon_weight ?lem))
    )
)

)
