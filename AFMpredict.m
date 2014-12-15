function [ yHat ] = AFMpredict( XTrain, yTrain, XTest, nStu, nKC, lambda=0.0)
    
    % Train the model
    f = @(w) -AFMlogLikelihood( XTrain, yTrain, w, nStu, lambda);
    fgrad = @(w) -AFMgradient( XTrain, yTrain, w, nStu, lambda);
    fhess = @(w) -AFMhessian( XTrain, yTrain, w, nStu, lambda);
    w0 = zeros(size(XTrain,2),1);
    niter = 500;

    [w] = sqp(w0, {f, fgrad, fhess}, [], [], -realmax, realmax, niter);
    %[w] = AFMnewtonDescent(flogl, fgrad, fhess, w0, step, niter, nStu, nKC);
    
    % Vectorized
    yHat = AFMprob(XTest, w)(:,2);
end
