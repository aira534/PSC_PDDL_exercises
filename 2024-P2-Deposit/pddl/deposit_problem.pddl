(define (problem deposit-problem)
(:domain deposit-fluent-domain)

(:objects
  robocop - robot
  metal piedra granito madera - trash
  suelo cama mesa - location
)

(:init
  (robot_at robocop main_deposit)
  
  (object_at metal cama)
  (object_at piedra mesa)
  (object_at granito cama)
  (object_at madera suelo)

  (= (trash_weight metal) 5)
  (= (trash_weight piedra) 3)
  (= (trash_weight granito) 2)
  (= (trash_weight madera) 1)

  (= (max_capacity robocop) 8)
  (= (carga_actual robocop) 0)

  (gripper_free robocop)
)

(:goal
  (and
    (unloaded_deposit metal)
    (unloaded_deposit piedra)
    (unloaded_deposit granito)
    (unloaded_deposit madera)
  )
)

)
