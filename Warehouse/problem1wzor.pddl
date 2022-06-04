(define (problem ai2)

    (:domain warehouse)
    
    (:objects
        loading_bay room_o1 room_o2 room_o3 - PL
        object_1 object_2 object_3 - OB
        mover_1 mover_2 - MV
        loader - LD
    )
    
    (:init
        (not (fragile object_1)) (fragile object_2)
        (not (fragile object_3)) 
        (not (loaded object_2)) 
        (not (loaded object_1)) (not (loaded object_3))
        ; The robots are initially in room_loader
        (at_robby mover_1 loading_bay)
        (at_robby mover_2 loading_bay)
        (at_loader loader loading_bay)
        ; The grippers are empty
        (free mover_1) 
        (free mover_2)
        (ready loader)
        ; The grippers are different
        (different mover_1 mover_2)
        ; The objects are placed inside room 2 and room 3
        (at_object object_1 room_o1) (at_object object_2 room_o2)
        (at_object object_3 room_o3) 
        (empty_bay loading_bay) (not (empty_bay room_o1))
        (not (empty_bay room_o2)) (not (empty_bay room_o3))
        (= (time) 0)
        (= (distance loading_bay room_o1) 10)
        (= (distance loading_bay room_o2) 20)
        (= (distance loading_bay room_o3) 20)
        (= (distance room_o1 loading_bay) 10)
        (= (distance room_o2 loading_bay) 20)
        (= (distance room_o3 loading_bay) 20)
        (= (mass object_1) 70)
        (= (mass object_2) 20)
        (= (mass object_3) 20) 
 
    )

    (:goal
        (and (loaded object_1) (loaded object_2)
             (loaded object_3))
    )

   (:metric 

    minimize  (time))
)