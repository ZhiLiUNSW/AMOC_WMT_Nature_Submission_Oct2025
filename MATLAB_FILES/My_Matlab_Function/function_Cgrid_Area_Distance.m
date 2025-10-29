function [Sxy,dx,dy]=function_Cgrid_Area_Distance(lon,lat)
        %------------------------------------------------------------------
        % Zhi Li
        % University of New South Wales
        % Sydney NSW 2052 Australia
        % zhi.li4@unsw.edu.au
        %------------------------------------------------------------------
        %% Sxy: aera of every grind point
        % dx Unit:m
        % dy Unit:m
        dx=nan(length(lon),length(lat)); %Distance in X Direction
        dy=nan(length(lon),length(lat)); %Distance in Y Direction
        %------------------------------------------------------------------
        %% DX
        for i=1
            for j=1:length(lat)
                dx(i,j)=function_Distance(lon(i), lat(j), 0, lon(i+1), lat(j), 0);%Ref to sea surface, p=0 
            end
        end   
        for i=2:length(lon)-1
            for j=1:length(lat)
                dx(i,j)=function_Distance((lon(i-1)+lon(i)).*0.5, lat(j), 0,(lon(i+1)+lon(i)).*0.5, lat(j), 0);%Ref to sea surface, p=0 
            end
        end   
        for i=length(lon)
            for j=1:length(lat)
                dx(i,j)=function_Distance(lon(end-1), lat(j), 0, lon(end), lat(j), 0);%Ref to sea surface, p=0 
            end
        end  
        %------------------------------------------------------------------
        %% DY
        for j=1
            for i=1:length(lon)
                dy(i,j)=function_Distance(lon(i), lat(j), 0, lon(i), lat(j+1), 0);%Ref to sea surface, p=0 
            end
        end  
        for j=2:length(lat)-1
            for i=1:length(lon)
                dy(i,j)=function_Distance(lon(i), (lat(j-1)+lat(j)).*0.5, 0, lon(i), (lat(j+1)+lat(j)).*0.5, 0);%Ref to sea surface, p=0 
            end
        end   
        for j=length(lat)
            for i=1:length(lon)
                dy(i,j)=function_Distance(lon(i), lat(j-1), 0, lon(i), lat(j), 0);%Ref to sea surface, p=0 
            end
        end   
        %------------------------------------------------------------------
        %% SXY
        Sxy=dy.*dx;
        %------------------------------------------------------------------
end