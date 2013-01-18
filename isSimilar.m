function resBool = isSimilar(str1,str2)
try
    resBool = 0;
    threshold = 0.6;
    lenStr1 = length(str1);
    lenStr2 = length(str2);
    if(lenStr1 == 0 && lenStr2 == 0)
        resBool = 1;
        return;
    end
    if(lenStr1 == 0 || lenStr2 == 0)
        return;
    end
    if(lenStr1 > lenStr2)
        similarValue = (findLength(str2,str1)*1.0)/(lenStr1);
        if (similarValue >= threshold)
            resBool = 1;
        end
    else
        similarValue = (findLength(str1,str2)*1.0)/lenStr2;
        if (similarValue >= threshold)
            resBool = 1;
        end
    end
catch ME
    fprintf(2,'%s\n',ME.message);
end

function count = findLength(str1,str2)
    count = 0;
    flag = 0;
    for i=1:length(str1)
        if(str1(i) == str2(i) && ~flag)
            count = count + 1;
        else
            flag = 1;
        end
    end