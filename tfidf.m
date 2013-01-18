function [userName,tfWeights,idfWeights] = tfidf(wm)
try
  userName = wm.userName;
  wordMat = wm.wordMatrix;
  [m,n] = size(wordMat);
  tfWeights = [];
  idfWeights = [];
  for i=1:m
      tfWeights = cat(1,tfWeights,{tf(wordMat(i,:))});
  end
  temp = [];
  for i=1:length(tfWeights)
      temp1 = tfWeights{i};
      temp = cat(1,temp,temp1');
  end
  idfWeights = idf(temp,m);
catch ME
    fprintf(2,'%s\n',ME.message);
end

function tfWeight = tf(wordMat)
try
    tfWeight = [];
    wordMat = wordMat';
    len = length(wordMat);
    for i=1:len
        word = wordMat(i,:);
        flag = 0;
        if(~strcmp(word,''))
            for j=1:length(tfWeight)
                if(isSimilar(char(tfWeight(j).word),char(word)) && ~flag)
                    tfWeight(j).weight = tfWeight(j).weight + 1;
                    flag = 1;
                end
            end
            if(~flag)
                tfWeight = cat(2,tfWeight,struct('word',word,'weight',1,'count',1));
            end
        end
    end
    total = 0;
    for i=1:length(tfWeight)
        total = total + tfWeight(i).weight;
    end
    for i=1:length(tfWeight)
        tfWeight(i).count = tfWeight(i).weight;
        tfWeight(i).weight = (tfWeight(i).weight * 1.0)/total;
    end
catch ME
    fprintf(2,'%s\n',ME.message);
end

function idfWeight = idf(tfWeight,noDocs)
try
    idfWeight = [];
    tempWords = [];
    for i=1:length(tfWeight)
        tempWords = cat(1,tempWords,cellstr(tfWeight(i).word));
    end
    flags = zeros(length(tempWords),1);
    for i = 1:length(tempWords)
        if(~flags(i))
            word = tempWords(i,:);
            tempIndexes = find(isSimilarC(tempWords,word));
            idf = log10((noDocs*1.0)/length(tempIndexes));
            idfWeight = cat(1,idfWeight,struct('word',tempWords(i),'weight',idf,'wordCount',length(tempIndexes)));
            for j=1:length(tempIndexes)
                flags(tempIndexes(j)) = 1;
            end
        end
    end
catch ME
    fprintf(2,'%s\n',ME.message);
end