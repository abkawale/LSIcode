function [users,cen,Un,obFcn,doc] = ExtractWordsAndCluster(Directory)
    [A,B] = main(Directory);
    BagOfWords = [];
    for i = 1:size(B,2)
        for j = 1:50
            %if (find(strcmp(BagOfWords,B{i}(j))))
                BagOfWords = cat(1,BagOfWords,B{i}(j));
            %end
        end
    end
    
    
    disp('clustering data using fuzzy c means');    
    BOW = unique(BagOfWords);
    DocVector = zeros(size(B,2),size(BOW,1));
    for i = 1:size(B,2)
        for j = 1:size(BOW,1)
            index = find (strcmp(BOW(j),B{i}));
            if (size(index,1) ~= 0)
                DocVector(i,j) = 1;
            else
                DocVector(i,j) = 0;
            end
        end
    end
    size(DocVector)
    
    [center,U,objFcn] = fcm(DocVector,2);
    maxU = max(U);
    index1 = find(U(1, :) == maxU);
    index2 = find(U(2, :) == maxU);
    figure
    line(DocVector(index1, 1), DocVector(index1, 2), 'linestyle',...
    'none','marker', 'o','color','g');
    line(DocVector(index2,1),DocVector(index2,2),'linestyle',...
    'none','marker', 'x','color','r');
    hold on
    plot(center(1,1),center(1,2),'ko','markersize',15,'LineWidth',2)
    plot(center(2,1),center(2,2),'kx','markersize',15,'LineWidth',2)

    doc = DocVector;users = A;cen = center;Un = U;obFcn = ojFcn;