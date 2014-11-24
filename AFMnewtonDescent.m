function [ w, li ] = AFMnewtonDescent( f, fgrad, fhess, w0, step0, niter, nStu, nKC)

    alpha = 0.1;
    w = w0;
    li = size(niter,1);
    n = 1;
    fw1 = f(w);
    fw0 = fw1 + 1;

    while (abs(fw0 - fw1) > 0.001 && n < niter)
        fw0 = fw1;
        step = step0;

        wg = fgrad(w);
        fhinv = pinv(fhess(w));

        w1 = w - step * fhinv * wg;
        w1(1+nStu+nKC:nStu+nKC+nKC) = max(0, w1(1+nStu+nKC:nStu+nKC+nKC));
        fw1 = f(w1);

        while (fw1 < fw0)
            step = alpha * step;
            w1 = w - step * fhinv * wg;
            w1(1+nStu+nKC:nStu+nKC+nKC) = max(0, w1(1+nStu+nKC:nStu+nKC+nKC));
            fw1 = f(w1);
        end

        w = w1;
        li(n) = fw1;
        n += 1;
    end
end

