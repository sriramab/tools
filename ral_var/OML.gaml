model multimodal

global 
{
	
	file railStop <- file("../includes/Station_square.shp");
	file railNet <- file("../includes/Srail_network.shp");
	geometry shape <- envelope(railNet);
	float step <-1#mn;
   
  
 graph rail_network;
    init { 
    	
    		create stops from:railStop with:[title::string(read("Name"))];
             create rails from: railNet with:[distanceRail::float(read("distance"))];
              rail_network <- as_edge_graph(rails);
              create trains number:1{ location<-stops[0].location; 	}
                   
   }
   
   reflex trains_from_amserfoort when:every(10){
   	create trains number:1{ location<-stops[0].location; 	}
   }
   
   	
   
}
species trains skills:[moving] control:fsm{
	float speed <-1667#m/#mn;
	path path_travelled;
	float distance_travelled<-1.0;
	float distance_km;
	float speed_real;
	geometry dummy <- line([{0,0,0},{0.5,0.5,0}]);
	int my_entryTime_at_THIS_station;
	
	state moving_state initial:true{
		do moves_on_rail;
		
			transition to: standing_state when: ((self.location overlaps stops[1])=true) {
				my_entryTime_at_THIS_station<-cycle;
				write name+" is at station 1";
			}
			transition to: dead_end when:	((self.location overlaps stops[2])=true)	{}
	}
	
	state standing_state {
		
		transition to: moving_state when: (cycle - self.my_entryTime_at_THIS_station >2){
				my_entryTime_at_THIS_station<-0;
				write name+" is leaving station 1";
			}
				
		
	}
	state dead_end final:true{
		write name+" rreached final stop";
	}
	
	action moves_on_rail {
		
		
 		path_travelled <-  goto (target:stops[2], on:rail_network, return_path: true);
		//distance_travelled <- distance_travelled + union(path_travelled.segments).perimeter;
		if (path_travelled!=nil){
			distance_travelled <- distance_travelled + union(path_travelled.segments+dummy).perimeter;
		}
		else {distance_travelled<-0.0;}
//		do goto on:rail_network target:stops[2];
//		if (self.location overlaps stops[1])=true{
//			//ask world{do pause;}
//			speed <-0.0;
//		}
	}
	
	aspect k{
		draw rectangle(2000,1000) color:rgb(255,0,0) rotate:heading+1;
	}
}
species stops{
	string title;
	int offset <-2500;
	aspect k{
		draw shape color:#yellow;
		draw string(title) size:2500 at:{location.x-3*offset,location.y+offset} color:#green;
	}
}

species rails{
	float distanceRail;
	aspect k{
		draw shape+10 color:#gray;
		//draw string(distanceRail) size:100;
	}
}







experiment OML type:gui{

	output{
		display map type:java2D{
			species stops aspect: k;
			species rails aspect: k;
			species trains aspect:k;
		}
		
		display Fund_Condition_display  {
				
			chart name: 'Time-Space Diagram' type: series background: rgb(255,255,255) size: {0.9, 0.9} position: {0.05, 0.05} y_range:({0,100000}){//} x_range:(2500){//x_range:(100) y_range:({0,20}){
				data name:'Distance (km)' value: (trains[0].distance_travelled) style: line color: rgb('green') marker:false;
				//data name:'Distance (km)' value: (trains collect each.distance_travelled) style: line color: rgb('green') marker:false;

				
			}
			}
	}
}

