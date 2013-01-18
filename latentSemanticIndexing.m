function [userName,topWords,topWordsWeight] = latentSemanticIndexing(tdm)
try
    userName = tdm.userName;
    wordsCount = tdm.wordsCount;
    docMatrix = tdm.docMatrix;
    
    Pij = [];
    [termX,docY] = size(docMatrix);
    
    for i = 1:docY
        Pij = cat(2,Pij,(docMatrix(:,i)./wordsCount(i)));
    end
    gi = zeros(termX,1);
    
    for i = 1:termX
        temp = sum(Pij(i,:).*log10(Pij(i,:))/log2(docY));
        if(isnan(temp))
            temp = 0;
        end
        gi(i) = 1 + temp;
    end
    aij = [];
    
    for i = 1:docY
        aij = cat(2,aij,gi.*log10(docMatrix(:,i)+1));
    end
    [~,~,T] = svd(aij');
    
    k=50;
    topWords = [];
    topWordsWeight = [];
    
    words = tdm.words;
    
    for i=1:k
        [C,I] = max(T(:,i));
        topWords = cat(1,topWords,words(I));
        topWordsWeight = cat(1,topWordsWeight,C);
    end
catch ME
    fprintf(2,'%s\n',ME.message);
end