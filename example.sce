clear;
clc;

//get the path of this file
dir_utama = get_absolute_file_path("example.sce");

//load glcm.sci
getd(dir_utama);

//Just for simple example, we create a 5 x 5 random matrix containing 0 to 5 . For real use, F should be a matrix containing grayscale value of an image.
F=grand(5,5,"uin",0,5);

//display the input matrix
disp(" F = ");
disp(F);

//start the timer 
tic(); 

//call the glcm function
[G0,G45,G90,G135]=glcm(F,1,1);

//stop the time
t=toc(); 

//display the results
disp("GLCM O = ");
disp(G0);
disp("GLCM 45 = ");
disp(G45);
disp("GLCM 9O = ");
disp(G90);
disp("GLCM 135 = ");
disp(G135);

//show the total time for creating 4 GLCM matrices
disp("total time (second) :");
disp(t);
