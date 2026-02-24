(define (problem lemon-problem)
(:domain lemon-fluent-problem)

(:objects
  robocop - robot
  cestita - basket
  tree1 tree2 tree3 - location
  l1 l2 l3 - lemon
)

(:init
  ; Example topology
  (connected base tree1)
  (connected tree1 base)
  (connected tree1 tree2)
  (connected tree2 tree1)
  (connected tree2 tree3)
  (connected tree3 tree2)

  (robot_at robocop base)
  (gripper_free robocop)
  (object_at cestita base)

  (object_at l1 tree1)
  (object_at l2 tree2)
  (object_at l3 tree3)

  (= (basket_max cestita) 50)
  (= (basket_act cestita) 0)
  
  (= (lemon_weight l1) 10)
  (= (lemon_weight l2) 10)
  (= (lemon_weight l3) 10)
)

(:goal
  (and
    ;; El objetivo es que todos los limones acaben descargados en la base
    (unloaded_at_base l1)
    (unloaded_at_base l2)
    (unloaded_at_base l3)
  )
)

)
