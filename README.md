# tools
small tools for dirty work




## using ral_var. 

*ral_var* stands for: read and list variables 

This tool reads any script file (if modified slightly) and lists its variables in a text file. This current version reads GAML file.



+ install python on your computer

+ set path to python

+ download ral_var folder

+ on command prompt or terminal, type the following 

` python path_to_/ral.py path_to_/fileName.gaml `

the result will be stored in ral_var folder as result.txt. The result includes line number of the variable, the variable type and the variable. To get it completely correct, you should have a well formatted gaml file. To get a well formatted gaml file: in GAMA open your file and in your editor, right click and select format. Save it. Now use the script. 

To use the sample gaml file in the folder, at the terminal or command prompt, type:

`python ral.py OML.gaml`

will give the following result on screen and in the result.txt

``` 3 file railStop <- file("../includes/Station_square.shp");

4 file railNet <- file("../includes/Srail_network.shp");

5 geometry shape <- envelope(railNet);

6 float step <-1#mn;

19 float speed <-1667#m/#mn;

20 path path_travelled;

21 float distance_travelled<-1.0;

22 float distance_km;

23 float speed_real;

24 geometry dummy <- line([{0,0,0},{0.5,0.5,0}]);

25 int my_entryTime_at_THIS_station;

62 int offset <-2500;

69 float distanceRail;

```


