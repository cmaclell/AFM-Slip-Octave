function [ yHat ] = AFMSpredict( XTrain, yTrain, XTest, nStu, nKC, lambda=0.0)
    
    % Don't regularize slips
    %Q = XTrain(:,nStu+1:nStu+nKC);
    %QTest = XTest(:, nStu+1:nStu+nKC);

    % Regularize slips
    Q = [XTrain(:,nStu+1:nStu+nKC) ones(size(XTrain,1), 1)];
    QTest = [XTest(:, nStu+1:nStu+nKC) ones(size(XTest,1), 1)];

    nw = size(XTrain,2);
    nsw = size(Q,2);
    w0 = zeros(nw + nsw, 1);

    f = @(x) -AFMSlogLikelihood(XTrain, yTrain, x(1:nw), Q, x(nw+1:nw+nsw), lambda);
    fgrad = @(x) -AFMSgradient(XTrain, yTrain, x(1:nw), Q, x(nw+1:nw+nsw), lambda);
    fhess = @(x) -AFMShessian(XTrain, yTrain, x(1:nw), Q, x(nw+1:nw+nsw), lambda);

    [w] = sqp(w0, {f, fgrad, fhess}, [], [], -realmax, realmax, 500);

    sw = w(nw+1:nw+nsw);
    w = w(1:nw);

    yHat = AFMSprob(XTest, w, QTest, sw)(:,2);
    
end
