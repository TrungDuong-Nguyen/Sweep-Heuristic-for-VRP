% --------------------------------------------------------------------- %
% @Function    extract_matrix
% @Brief       Extract a given matrix into many small square matrices
% @Input Parameters
%              M  Matrix to be extracted
%              D  Vector that specifies the size of the square matrix obtained after extraction
% @Output Parameters
%              H  Structure array that contains all square matrices
%
% @Programmer  NGUYEN Trung Duong
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