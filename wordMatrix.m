function userMatrix = wordMatrix(xmlFile)
    wordMat = [];
    empty = '';
    %try
        parseData = parseUserXML(xmlFile);
        for i = 1:length(parseData.tweetDoc)
            temp1 = regexp(parseData.tweetDoc{i},' ','split');
            temp = [];
            len = length(temp1);
            for j=1:length(temp1)
                str = char(temp1{j});
                str(~isstrprop(str,'alphanum'))='';
                %str = stemmer(str);
                str = lower(str);
                temp = cat(2,temp,{str});
            end
            for j = len+1 : 70
                temp = cat(2,temp,{empty});
            end
            wordMat = cat(1,wordMat,temp);
        end
        userMatrix = struct('userName',parseData.userName,'wordMatrix',{wordMat});
    %catch ME
     %   fprintf(2,'%s\n',ME.message);
    end