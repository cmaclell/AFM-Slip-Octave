function [ wgrad, swgrad ] = AFMSgradient( X, y, w, Q, sw, lambda=0.0)

    % Vectorized Gradient
    p = AFMSprob(X, w, Q, sw)(:,2);

    wgrad = X' * ((y - p) ./ ((1 + exp(X*w)) .* (1 - p)));
    swgrad = Q' * ((y - p) ./ ((1 + exp(Q*sw)) .* (1 - p)));

    % regularize student intercepts
    nStu = size(X,2) - 2*size(Q,2);
    wgrad(1:nStu) -= lambda * w(1:nStu);

    % Regularize KC slopes
    %nStu = size(X,2) - 2*size(Q,2);
    %nKC = size(Q,2);
    %wgrad(nStu+nKC+1:nStu+nKC+nKC) -= lambda * w(nStu+nKC+1:nStu+nKC+nKC);

    % regularize weights
    wgrad(1:size(w,1)-1) -= lambda * w(1:size(w,1)-1);

    % regularize slips
    %swgrad -= lambda * sw;

end
