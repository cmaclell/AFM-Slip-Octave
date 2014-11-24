function [ rmse ] = CrossValidate( X, y, fPredict, nFolds, indicator=ones(size(y)) )
    
    % Sort by random pertebation of indicator
    stratify = floor(100 * indicator)+unifrnd(0,1, size(indicator));
    Xy = [X y stratify];
    Xy = sortrows(Xy,size(Xy,2));

    % Re-extract X and y
    X = Xy(:,1:size(X,2));
    y = Xy(:,size(X,2)+1:size(X,2)+1);

    % Generate fold assignment
    idx = 1:1:size(X,1);

    % Vector for rmse values
    rmse = ones(nFolds, 1);

    for i = 0:nFolds-1
        XTest = X(find(mod(idx,nFolds)==i),:);
        yTest = y(find(mod(idx,nFolds)==i),:);
        
        XTrain = X(find(mod(idx,nFolds)!=i),:);
        yTrain = y(find(mod(idx,nFolds)!=i),:);

        [yHat] = fPredict(XTrain, yTrain, XTest);

        e = yHat - yTest;
        rmse(i+1) = sqrt(1/size(yTest, 1) * e'*e);


        %%%%%%%%%%%%%%%%%%%%%%
        %% Plotting stuff
        %%%%%%%%%%%%%%%%%%%%%%

        %Q = XTest(:,1+59:59+18);
        %Opp = XTest(:,1+59+18:59+18+18);
        %O1 = Q + Opp;
        %m = max(O1(:));
        %xd = 1:1:m;
        %actual = zeros(size(xd));
        %afm = zeros(size(xd));
        %afms = zeros(size(xd));

        %for i = 1:m
        %    actual(i) = mean(yTest(find(sum(O1==i,2)>0)));
        %    afm(i) = mean(yHat(find(sum(O1==i,2)>0)));
        %end
        %
        %plot(xd, 1-actual, '-1', xd, 1-afm, '-2');
        %axis([0 m 0 1], "autox");
        %disp('Press any key to continue')
        %pause()
        %%%%%%%%%%%%%%%%%%%%%%%%
        %% End Plotting
        %%%%%%%%%%%%%%%%%%%%%%%%

    end

    rmse = mean(rmse);

end
