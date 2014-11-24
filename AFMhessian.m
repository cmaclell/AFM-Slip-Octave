function [ hessian ] = AFMhessian( X, y, w, nStu, lambda=0.0 )

    %Vectorized version
    p = AFMprob(X, w)(:, 2);
    hessian = -1 * X' * diag(p .* (1-p)) * X;
    
    if (lambda > 0)
        hessian(1:nStu) -= lambda;
    end

end
