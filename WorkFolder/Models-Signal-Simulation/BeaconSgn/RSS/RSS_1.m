function RSSvalue = RSS_1(position,ibeacon,params)
%
    x = position.x;
    y = position.y;
    z = position.z;

    bx = ibeacon.r(1);
    by = ibeacon.r(2);
    bz = ibeacon.r(3);

%%
   distance = sqrt((x-bx)^2 + (y-by)^2 + 16*(z-bz)^2 );

   sigma = 1.0;
   RSSvalue = 10*log10(distance)  + normrnd(0,sigma);
   
   if RSSvalue > 15
       RSSvalue = -1;
   end
   
end

