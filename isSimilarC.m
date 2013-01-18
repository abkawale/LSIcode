function resBool = isSimilarC(C1,str2)
    resBool = [];
    for i=1:length(C1)
        resBool = cat(1,resBool,isSimilar(char(C1(i)),char(str2)));
    end