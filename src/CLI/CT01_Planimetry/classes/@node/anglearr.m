function theta=anglearr(n1,n2)
   scalar = n1.r(1)*n2.r(1) + n1.r(2)*n2.r(2);
   norm1 = norm(n1.r);
   norm2 = norm(n2.r);
   theta = acos(scalar/(norm1*norm2));
end