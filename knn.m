function rate = knn(trainData,testData,k)

m = size(trainData,1);
n = size(testData,1);
predict = [];

for test = 1:n
    for train = 1:m
        Euclidist(train) = norm(testData(test,1:end-1) - trainData(train,1:end-1));
    end
    
   [val,ind] = sort(Euclidist);
   k_nearest_indices = ind(1:k);
   predict(test) = mode(trainData(k_nearest_indices,end));
end

actual = testData(:,end);
rate = 100 * (sum(actual == predict')/n);
     
    