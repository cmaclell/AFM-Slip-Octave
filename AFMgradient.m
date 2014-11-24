function [ grad ] = AFMgradient( X, y, w, nStu, lambda=0.0)

    %Iterative Gradient
    %f = size(X,2);
    %grad = zeros(f,1);
    %numX = size(X,1);

    % Partial Gradient
    %for j = 1:50
    %    j = randperm(size(X,1))(1);
    %    grad = X(j,:)' * (y(j) - AFMprob(X(j,:),w)(2));
    %end

    % Full Gradient
    %for j = 1:numX
    %    grad += X(j,:)' * (y(j) - AFMprob(X(j,:),w)(2));
    %end
    %grad -= lambda / 2;

    % Vectorized Gradient
    grad = X' * (y - AFMprob(X, w)(:,2));

    % regularize student intercepts
    grad(1:nStu) -= lambda * w(1:nStu);

    % regularize all but intercept
    %grad(1:size(w,1)-1) -= lambda * w(1:size(w,1)-1);
    %grad(2:size(w,1)) -= lambda * w(2:size(w,1));

end
