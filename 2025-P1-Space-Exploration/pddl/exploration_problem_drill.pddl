(define (problem exploration-problem-drill)
(:domain exploration-domain-drill)

(:objects
  curiosity - robot
  base valley crater - location
  rock mineral - sample
  valley_soil crater_soil - soil
  drill1 - drill
)

; Initially the robot is at the base
(:init
  (robot_at curiosity base)
  (gripper_free curiosity)
  (sample_at rock crater)
  (sample_at mineral valley)
  (soil_at valley_soil valley)
  (soil_at crater_soil crater)

  (drill_at drill1 base)
  (drill_free drill1)
)

; The goal is to make science!
(:goal
  (and
    (sample_at rock base)
    (sample_at mineral base)
    (soil_analysed valley_soil)
    (soil_analysed crater_soil)
  )
)
)
