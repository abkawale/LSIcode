try
t = convert(xmltree('tweeterids.xml'));
catch ME
    fprintf(2,'%s\n',ME.message);
end
count = t.id;