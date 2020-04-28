clc, clear;
matrix = [0,0,0,0,0,0,0;
          0,0,1,1,0,0,0;
          0,0,0,1,0,0,0;
          0,0,0,1,1,0,0;
          0,0,1,1,1,1,0;
          0,0,1,1,1,0,0;
          0,1,0,1,0,1,0;
          0,0,0,0,0,0,0]
      
mask1 = [1, 1, 1];
mask2=[1, 1; 
       0, 1];
   
result1 = dilation(matrix, mask1, 1, 1)
result2 = erosion(matrix, mask1, 1, 1)
result3 = dilation(matrix, mask2, 1, 2)
result4 = erosion(matrix, mask2, 1, 2)
%开运算先腐蚀再膨胀
result5mask1 = dilation(result2, mask1, 1, 1)
result5mask2 = dilation(result4, mask2, 1, 2)
%闭运算先膨胀再腐蚀
result6mask1 = erosion(result1, mask1, 1, 1)
result6mask2 = erosion(result3, mask2, 1, 2)