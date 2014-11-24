function [ logl ] = AFMSlogLikelihood( X, y, w, Q, sw, lambda=0.0)

    % Vectorized operations
    m = [1-y y];

    % Regularize student intercepts
    nStu = size(X,2) - 2*size(Q,2);
    reg = w(1:nStu);

    % Regularize the slopes
    %nStu = size(X,2) - 2*size(Q,2);
    %nKC = size(Q,2);
    %reg = w(nStu+nKC+1:nStu+nKC+nKC);

    % Regularize weights
    %reg = w(1:size(w,1)-1);

    % Regularize All
    %reg = [w; sw];

    logl = sum((m .* log(AFMSprob(X, w, Q, sw)))(:));
    
    if lambda > 0
        logl -= (lambda / 2) * reg' * reg;
         %+ (size(X,1) / 2) * log(2 * pi * (1 / lambda));
    end

end
