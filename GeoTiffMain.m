clear;
clc;

[fileDir,pathName,~] = uigetfile({'*.tif'},'Open GeoTIFF');
[~,name,~] = fileparts([pathName,fileDir]);
[~, ~, boundaryBox] = geotiffread([pathName,fileDir]);
westBoundary = boundaryBox.XWorldLimits(1);
eastBoundary = boundaryBox.XWorldLimits(2);
southBoundary = boundaryBox.YWorldLimits(1);

insertPoint = [westBoundary,southBoundary];
realDistance = eastBoundary - westBoundary;

scriptString = sprintf('_IMAGE _A "%s" %f,%f %f 0.0',[pathName,fileDir],...
    insertPoint(1),insertPoint(2),realDistance);

fileID = fopen([pathName,name,'.scr'],'w');
fprintf(fileID,'UCS WORLD\r\n');
fprintf(fileID,'OSNAP NONE\r\n');
fprintf(fileID,'ORTHO OFF\r\n');
fprintf(fileID,'%s\r\n',scriptString);
fprintf(fileID,'ZOOM E\r\n');
fclose(fileID);
clear fileID