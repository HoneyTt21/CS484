% HW3-b
% Calculate the fundamental matrix using the normalized eight-point
% algorithm.
function f = calculate_fundamental_matrix(pts1, pts2)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here
    [npts1, T1] = normalize_points(transpose(pts1),2);
    [npts2, T2] = normalize_points(transpose(pts2),2);
    
    % Matrix A
    x1 = transpose(npts1(1,:));
    y1 = transpose(npts1(2,:));
    x2 = transpose(npts2(1,:));
    y2 = transpose(npts2(2,:));
    
    A=ones(8,9);
    for i=1:8
        A(i,1)=x1(i,1)*x2(i,1);
        A(i,2)=x1(i,1)*y2(i,1);
        A(i,3)=x1(i,1);
        A(i,4)=y1(i,1)*x2(i,1);
        A(i,5)=y1(i,1)*y2(i,1);
        A(i,6)=y1(i,1);
        A(i,7)=x2(i,1);
        A(i,8)=y2(i,1);
        A(i,9)=1;
    end
    
    [~,~,V] = svd(A'*A);
    F=reshape(V(:,9), 3, 3)';
    [U,S,V] = svd(F);
    S(3,3)=0;
    temp = U*diag([S(1,1) S(2,2) 0])*V';
    T1 = [T1(1:2, 1:2) [T1(1, end); T1(2, end)]; 0 0 1];
    T2 = [T2(1:2, 1:2) [T2(1, end); T2(2, end)]; 0 0 1];
    f= (transpose(T1)*temp*T2)';


%     f = estimateFundamentalMatrix(pts1,pts2,'Method','Norm8Point');
    
    
end
