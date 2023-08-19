function data=shuffleData(data)

[m][n]=size(data);
indices=randperm(m);
data=data(indices)