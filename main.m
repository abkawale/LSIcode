function [A,B] =  main(directory)
%try
    fid = fopen('topWords.txt','w');
    if(fid == -1)
        err = MException('ResultChk:BadInput','Cannot Open output file');
        throw(err);
    end
    files = dir(fullfile(directory,'*.xml'));
    %A = zeros(1,length(files));
    %B = zeros(1,length(files));
    for i = 1:length(files)
        xmlFile = files(i).name;
        wm = wordMatrix(xmlFile);
        [uN,tf,idf] = tfidf(wm);
        tdm = termDocumentMatrix(uN,tf,idf);
        [u,tWords,~] = latentSemanticIndexing(tdm);
        fprintf(fid,'%s,',char(u));
        for j = 1:length(tWords)
            fprintf(fid,'%s,',char(tWords(j)));
        end
        fprintf(fid,'\n');
        A(i) = {u};
        B(i) = {tWords};
        %disp(u)
        %disp(tWords)
        %size(u)
        %size(tWords)
        %A(i) = u;
        %A(i) = u;
        %B(i) = {tWords};
    end
   
    fclose(fid);
%catch ME
    %fprintf(2,'%s\n',ME.message);
end