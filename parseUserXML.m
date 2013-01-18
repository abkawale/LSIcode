function userStruct = parseUserXML(xmlFile)
    tweetDoc = [];
    %try
        tempXmlTree = convert(xmltree(xmlFile));
        userName = tempXmlTree.tweeterId;
        
        len = length(tempXmlTree.tweet);
        disp(len)
        for i=1:len
            tweetDoc=cat(1,tweetDoc,{tempXmlTree.tweet{i}});
        end
        userStruct = struct('userName',userName,'tweetDoc',{tweetDoc});
    %catch ME
        %fprintf(2,'%s\n',ME.message);
    end