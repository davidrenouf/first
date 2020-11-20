function [res] = entrelaceur(encode)
    %size(encode)
    reshape(encode,[378,100]); 
    tmp = encode';
    res = tmp(:);
end