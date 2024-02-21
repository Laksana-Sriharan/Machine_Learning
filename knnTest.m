data = load('C:\Users\DELL\Documents\MATLAB\iris.txt');
data = shuffleData(data);
[train,test] = splitData(data);
[train,test] = scaleData(train,test);
rate = knn(train,test,3);
disp(rate);