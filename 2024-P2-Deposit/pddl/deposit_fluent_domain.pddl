(define (domain deposit-fluent-domain)
(:requirements :typing :strips :fluents)

(:types
  robot
  trash - object
  location
)

(:constants
  main_deposit - location
)

(:predicates
  (gripper_free ?r - robot)
  (grabbed ?r - robot ?o - object)
  (in_container ?r - robot ?o - object)
  (robot_at ?r - robot ?l - location)
  (object_at ?o - object ?l - location)
  (unloaded_deposit ?o - object)
)

(:functions
  (max_capacity ?r - robot)
  (carga_actual ?r - robot)
  (trash_weight ?t - trash)
)

(:action move
  :parameters (?r - robot ?from ?to - location)
  :precondition
    (and
      (robot_at ?r ?from)
    )
  :effect
    (and
      (not (robot_at ?r ?from))
      (robot_at ?r ?to)
    )
)

(:action pick
  :parameters (?r - robot ?o - trash ?l - location)
  :precondition
    (and
      (robot_at ?r ?l)
      (gripper_free ?r)
      (object_at ?o ?l)
    )
  :effect
    (and
      (not (object_at ?o ?l))
      (not (gripper_free ?r))
      (grabbed ?r ?o)
    )
)

(:action drop
  :parameters (?r - robot ?o - trash ?l - location)
  :precondition
    (and
      (robot_at ?r ?l)
      (grabbed ?r ?o)
    )
  :effect
    (and
      (object_at ?o ?l)
      (gripper_free ?r)
      (not (grabbed ?r ?o))
    )
)

(:action load
  :parameters (?r - robot ?o - trash ?l - location)
  :precondition
    (and
      (grabbed ?r ?o)
      (<= (+ (carga_actual ?r) (trash_weight ?o)) (max_capacity ?r))
      (robot_at ?r ?l)
    )
  :effect
    (and
      (gripper_free ?r)
      (not (grabbed ?r ?o))
      (in_container ?r ?o)
      (increase (carga_actual ?r) (trash_weight ?o))
    )
)

(:action unload
  :parameters (?r - robot ?o - trash)
  :precondition
    (and
      (in_container ?r ?o)
      (robot_at ?r main_deposit)
      (> (carga_actual ?r) 0)
    )
  :effect
    (and
      (not (in_container ?r ?o))
      (decrease (carga_actual ?r) (trash_weight ?o))
      (unloaded_deposit ?o)
    )
)

)
