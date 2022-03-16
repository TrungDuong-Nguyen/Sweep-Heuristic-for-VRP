% --------------------------------------------------------------------- %
% @Function    extract_matrix
% @Brief       Extract a given matrix into many small square matrix
% @Input Parameters     
%              M          Matrix to be extracted 
%              D          Vector that specifies the size of the square                      %                         matrix obtained after extraction
% @Output Parameters       
%              H          “Structure array” data type that contain all square %                         matrix 
%               
% @Author      NGUYEN Trung Duong – Student Master OSS - UTT
% @Date        2013/01/04
% --------------------------------------------------------------------- %

function H = extract_matrix(M,D) 
   
SizeD = size(D,2);
    
Index = zeros(1,SizeD);
Index(1) = D(1);
 
for i=2:SizeD
    Index(i) = Index(i-1) + D(i);
end
 
r(1).Index = 1:D(1);
 
for i=2:SizeD
    r(i).Index = 1+Index(i-1):Index(i);
end
 
for i=1:SizeD
    H(i).Mat = M(r(i).Index, r(i).Index);
end

end