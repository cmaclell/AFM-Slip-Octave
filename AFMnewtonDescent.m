function [ w, li ] = AFMnewtonDescent( f, fgrad, fhess, w0, step0, niter, nStu, nKC)

    w = w0;
    fw1 = f(w);
    fw0 = fw1 + 1;

    alpha = 0.5;
    li = size(niter,1);
    n = 1;

    while (abs(fw0 - fw1) > 10^(-10) && n < niter)
        fw0 = fw1;
        direction = pinv(fhess(w)) * fgrad(w);

        step = step0 / alpha;
        once = 1;

        while (once || fw1 - fw0 < 0)
            once = 0;
            step = alpha * step;

            w1 = w - step * direction;
            %w1(1+nStu+nKC:nStu+nKC+nKC) = max(0, w1(1+nStu+nKC:nStu+nKC+nKC));

            fw1 = f(w1);
        end

        w = w1;
        li(n) = fw1;
        n += 1;
    end
end

