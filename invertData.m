function invData = invertData(Data,class)

%This function is used to invert the +1 class and -1 classes

%**************************Interested class********************************

indices = (Data(:,end)== class);
Data(indices,end) = 1 ;

%**********************Non - Interested class******************************

ind = ~indices;
Data(ind,end) = -1 ;

%***********************************************************************
