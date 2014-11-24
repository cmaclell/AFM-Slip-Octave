function [ w, sw, li ] = AFMSnewtonDescent( f, fgrad, fhess, w0, sw0, step0, niter, nStu, nKC)

    alpha = 0.1;
    w = w0;
    sw = sw0;
    li = size(niter,1);
    n = 1;
    fw1 = f(w, sw);
    fw0 = fw1 + 1;


    while (abs(fw0 - fw1) > 0.001 && n < niter)
        fw0 = fw1;
        step = step0;

        [wg, swg] = fgrad(w, sw);
        [wh, swh] = fhess(w, sw);
        whinv = pinv(wh);
        swhinv = pinv(swh);

        w1 = w - step * whinv * wg;
        w1(1+nStu+nKC:nStu+nKC+nKC) = max(0, w1(1+nStu+nKC:nStu+nKC+nKC));
        sw1 = sw - step * swhinv * swg;
        sw1 = max(-15, sw1);
        sw1 = min(15, sw1);
        fw1 = f(w1, sw1);

        while (fw1 < fw0)
            step = alpha * step;
            w1 = w - step * whinv * wg;
            w1(1+nStu+nKC:nStu+nKC+nKC) = max(0, w1(1+nStu+nKC:nStu+nKC+nKC));
            sw1 = sw - step * swhinv * swg;
            sw1 = max(-15, sw1);
            sw1 = min(15, sw1);
            fw1 = f(w1, sw1);
        end

        w = w1;
        sw = sw1;
        li(n) = fw1;
        n += 1;
    end
end

