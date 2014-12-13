function [S, Q, Opp, y, p] = RemoveSingular(S, Q, Opp, y, p)
    validS = find(sum(S)>2);
    validQ = find(sum(Q)>2);

    S = S(:,validS);
    Q = Q(:,validQ);
    Opp = Opp(:,validQ);

    validRow = find(sum(Q, 2)==1);
    S = S(validRow,:);
    Q = Q(validRow,:);
    Opp = Opp(validRow,:);
    y = y(validRow);
    p = p(validRow);

    validRow = find(sum(S, 2)==1);
    S = S(validRow,:);
    Q = Q(validRow,:);
    Opp = Opp(validRow,:);
    y = y(validRow);
    p = p(validRow);

end
