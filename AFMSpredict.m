function [ yHat ] = AFMSpredict( XTrain, yTrain, XTest, nStu, nKC, lambda=0.0)
    
    % Don't regularize slips
    %Q = XTrain(:,nStu+1:nStu+nKC);
    %QTest = XTest(:, nStu+1:nStu+nKC);

    % Regularize slips
    Q = [XTrain(:,nStu+1:nStu+nKC) ones(size(XTrain,1), 1)];
    QTest = [XTest(:, nStu+1:nStu+nKC) ones(size(XTest,1), 1)];

    % Train the model
    flogl = @(x, x2) AFMSlogLikelihood(XTrain, yTrain, x, Q, x2, lambda);
    fgrad = @(x, x2) AFMSgradient(XTrain, yTrain, x, Q, x2, lambda);
    fhess = @(x, x2) AFMShessian(XTrain, yTrain, x, Q, x2, lambda);

    w0 = zeros(size(XTrain,2),1);
    sw0 = zeros(size(Q,2),1);
    step = 1;
    niter = 3000;

    [w, sw] = AFMSnewtonDescent(flogl, fgrad, fhess, w0, sw0, step, niter, nStu, nKC);

    yHat = AFMSprob(XTest, w, QTest, sw)(:,2);
    
end
