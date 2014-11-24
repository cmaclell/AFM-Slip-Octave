function [ yHat ] = AFMSpredict( XTrain, yTrain, XTest, nStu, nKC, lambda=0.0)
    
    % Train the model
    flogl = @(x, x2) AFMSlogLikelihood(XTrain, yTrain, x, XTrain(:,nStu+1:nStu+nKC), x2, lambda);
    fgrad = @(x, x2) AFMSgradient(XTrain, yTrain, x, XTrain(:,nStu+1:nStu+nKC), x2, lambda);
    fhess = @(x, x2) AFMShessian(XTrain, yTrain, x, XTrain(:,nStu+1:nStu+nKC), x2, lambda);

    w0 = zeros(size(XTrain,2),1);
    sw0 = zeros(nKC,1);
    step = 1;
    niter = 3000;

    [w, sw] = AFMSnewtonDescent(flogl, fgrad, fhess, w0, sw0, step, niter, nStu, nKC);
    
    % Vectorized
    yHat = AFMSprob(XTest, w, XTest(:,nStu+1:nStu+nKC), sw)(:,2);
end
