function accuracy = OVASVMs(data,N)

%N - number of classes
%ntest - no .of training samples
[traindata,teData] = splitData(data);
[trdata,valData] = splitData(data);
%[trdata,teData] = scaleData(trdata,teData);

A = 1:N;

C = [2^-10,2^-9,2^-8,2^-7,2^-6,2^-5,2^-4,2^-3,2^-2,2^-1,2^0,2^1,2^2,2^3,2^4,2^5,2^6,2^7,2^8,2^9,2^10];

accuracy = [];

for i = 1:length(C)
    options = svmlopt('C',C(i),'Verbosity',0);
    predict=[];
    
    for class = 1:N
        Model = ['Model',int2str(A(class)),'VsAll'];
        x = invertData(trData,A(class));
        y = x(:,end);
        x(:,end) = [];
        svmlwrite('SVMLTrain',x,y);
        svm_learn(options,'SVMLTrain',Model);
        
        xval = invertData(valData,A(class));
        yval = xval(:,end);
        svmlwrite('SVMLVal',xval,yval);
        ModelOutput = ['ModelOutput',int2str(A(class)),'VsAll'];
        svm_classify(options,'SVMLVal',Model,ModelOutput);
        svmpredict = svmlread(ModelOutput);
        predict = [predict,svmpredict];
    end
    accuracy(i) = WinnerTakesAll(valData,predict,A); 
end
[elt,ind] = max(accuracy);
cOpt = C(ind);

options = svmlopt('C',cOpt,'Verbosity',0);
predict=[];
    
    for class = 1:N
        Model = ['Model',int2str(A(class)),'VsAll'];
        x = invertData(trData,A(class));
        y = x(:,end);
        x(:,end) = [];
        svmlwrite('SVMLTrain',x,y);
        svm_learn(options,'SVMLTrain',Model);
        
        xtest = invertData(teData,A(class));
        ytest = xtest(:,end);
        svmlwrite('SVMLTest',xtest,ytest);
        ModelOutput = ['ModelOutput',int2str(A(class)),'VsAll'];
        svm_classify(options,'SVMLTest',Model,ModelOutput);
        svmpredict = svmlread(ModelOutput);
        predict = [predict,svmpredict];
        
    end
    accuracy = WinnerTakesAll(teData,predict,A); 

    