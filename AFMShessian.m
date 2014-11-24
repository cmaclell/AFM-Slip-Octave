function [ whessian, shessian ] = AFMShessian( X, y, w, Q, sw, lambda=0.0)
    % iterative loop
    %f = size(X,2);
    %hessian = zeros(f,f);
    %numX = size(X,1);

    %for i = 1:numX
    %    p = AFMprob(X(i, :), w)(:,2);
    %    %hessian -= X(i, :)' * X(i, :);
    %    hessian -= X(i,:)' * X(i,:) * p * (1 - p);
    %end

    %Vectorized version
    p = AFMSprob(X, w, Q, sw)(:, 2);
    wm = ((1 - p) .* (exp(X*w) .* (p - y) - p) - p .* (p - y)) ./ ((1 +
    exp(X*w)).^2 .* (1 - p).^2);
    whessian = X' * diag(wm) * X;

    swm = ((1 - p) .* (exp(Q*sw) .* (p - y) - p) - p .* (p - y)) ./ ((1 +
    exp(Q*sw)).^2 .* (1 - p).^2);
    shessian = Q' * diag(swm) * Q;

    if (lambda > 0)
        nStu = size(X,2) - 2*size(Q,2);
        whessian(1:nStu) -= lambda;
    end
end
