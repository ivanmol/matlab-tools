files = dir('.\EL600_Volunteer_Test_v1\img\*.jpg');
for file = files'
    img = imread(file.name);
    img = imresize(img, [800 NaN]);
    imwrite(img, strcat('.\EL600_Volunteer_Test_v1\img\',char(file.name)))
    % Do some stuff
end