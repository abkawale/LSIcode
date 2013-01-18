function tdm = termDocumentMatrix(userName,tf,idf)
try
    words = [];
    wordsIdf = [];
    wordsCount = [];
    dMatrix = zeros(length(idf),length(tf));
    for i=1:length(idf)
        words = cat(1,words,cellstr(idf(i).word));
        wordsIdf = cat(1,wordsIdf,idf(i).weight);
        wordsCount = cat(1,wordsCount,idf(i).wordCount);
    end
    for i=1:length(words)
        for j=1:length(tf)
            dWords = [];
            dWordsTf = [];
            dTf = tf{j};
            for k=1:length(dTf)
                dWords = cat(1,dWords,cellstr(dTf(k).word));
                dWordsTf = cat(1,dWordsTf,dTf(k).weight);
            end
            tfIndexes = find(isSimilarC(dWords,words(i)));
            sum = 0;
            for k = 1:length(tfIndexes)
                sum = sum + (dWordsTf(tfIndexes(k)) * wordsIdf(i));
            end
            if(~isempty(tfIndexes))
                sum = sum / length(tfIndexes);
                dMatrix(i,j) = sum;
            end
        end
    end
    tdm = struct('userName',userName,'words',{words},'docMatrix',{dMatrix},'wordsCount',{wordsCount});
catch ME
    fprintf(2,'%s\n',ME.message);
end