(define (problem container-problem)

    (:domain container)
    
    (:objects 
        c1 c2 c3 c4 c5 c6 c7 c8
        truck1 truck2 truck3 truck4 train
        hub1Italy hub2Italy trainstationItaly trainstationFrance hub3France hub4France
    )
    
    (:init
        (CONTAINER c1) (CONTAINER c2) (CONTAINER c3) (CONTAINER c4) (CONTAINER c5) (CONTAINER c6) (CONTAINER c7) (CONTAINER c8)
        (TRANSPORT truck1) (TRANSPORT truck2) (TRANSPORT truck3) (TRANSPORT truck4) (TRANSPORT train)
        (LOCATION hub1Italy) (LOCATION hub2Italy) (LOCATION trainstationItaly) (LOCATION trainstationFrance) (LOCATION hub3France) (LOCATION hub4France)
        
        (can-go truck1 hub1Italy trainstationItaly)
        (can-go truck1 trainstationItaly hub1Italy)
        (can-go truck2 hub2Italy trainstationItaly)
        (can-go truck2 trainstationItaly hub2Italy)
        
        (can-go truck3 hub3France trainstationFrance)
        (can-go truck3 trainstationFrance hub3France)
        (can-go truck4 hub4France trainstationFrance)
        (can-go truck4 trainstationFrance hub4France)
        
        (can-go train trainstationItaly trainstationFrance)
        (can-go train trainstationFrance trainstationItaly)
        
       
        
        (at-container c1 hub1Italy)
        (at-container c2 hub1Italy)
        (at-container c3 hub1Italy)
        (at-container c4 hub1Italy)
        (at-container c5 hub2Italy)
        (at-container c6 hub2Italy)
        (at-container c7 hub2Italy)
        (at-container c8 hub2Italy)
        
        (at-transport truck1 hub1Italy)
        (at-transport truck2 hub2Italy)
        (at-transport truck3 hub3France)
        (at-transport truck4 hub4France)
        
        (at-transport train trainstationItaly)
    )
    
    (:goal
        (and (at-container c1 hub3France) (at-container c2 hub4France)
             (at-container c3 hub3France) (at-container c4 hub4France)
             (at-container c5 hub3France) (at-container c6 hub4France)
             (at-container c7 hub3France) (at-container c8 hub4France))
    )
)