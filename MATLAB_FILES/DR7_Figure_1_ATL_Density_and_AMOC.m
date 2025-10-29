%% ########################################################################
%% ATLANTIC BASIN MEAN DENSITY and STREAMFUNCTION
%% Depth and Latitude of Zonal Mean Density
%  Annual Mean of Monthly Mean
%  SIO Argo  data for 2004-2023, 0-2000 m, annual mean of monthly means
%  Ishiiv731 data for 1955-2023, 0-3000 m, annual mean of monthly means
%  IPAv4     data for 1940-2023, 0-2000 m, annual mean of monthly means
%  IPAv4.2   data for 1940-2023, 0-6000 m, annual mean of monthly means
%  EN4-ESM   data for 1940-2023, 0-5500 m, annual mean of monthly means
% #########################################################################
% #########################################################################



% #########################################################################
% #########################################################################
%% MAPPING FIGURE #1: ATL BASIN DENSITY AND STRF_z
clc; clear

% #########################################################################
% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')
load(['cal_AMOC_Streamfunction_V4_ESM_Observations_Z_Convt_1_IAPv4_Annual_Gam_19402023.mat'],...
      'gamma_ATL_ann','dep_IAP','lon_IAP','lat_IAP','time_ann')
[lat_org,depth_org]  = meshgrid(lat_IAP, dep_IAP);
[lat0,depth0]        = meshgrid(lat_IAP, (5:10:6000)');
gamma_ATL(:,:,1)     = griddata(lat_org,depth_org, nanmean(gamma_ATL_ann(:,:,65:84),3)',lat0,depth0,'linear');
clear lat0 depth0 lat_org depth_org gamma_ATL_ann
% #########################################################################


% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')
load(['cal_AMOC_Streamfunction_V4_ESM_Observations_Z_Convt_2_IAPv42_Annual_Gam_19402023.mat'],...
      'gamma_ATL_ann','dep_IAP','lon_IAP','lat_IAP','time_ann')
[lat_org,depth_org]  = meshgrid(lat_IAP, dep_IAP);
[lat0,depth0]        = meshgrid(lat_IAP, (5:10:6000)');
gamma_ATL(:,:,2)     = griddata(lat_org,depth_org, nanmean(gamma_ATL_ann(:,:,65:84),3)',lat0,depth0,'linear');
clear lat0 depth0 lat_org depth_org gamma_ATL_ann
% #########################################################################


% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')
load(['cal_AMOC_Streamfunction_V4_ESM_Observations_Z_Convt_4_EN4_Annual_Gam_19402023.mat'],...
      'gamma_ATL_ann','depth10','lat_EN4','time_ann')
[lat_org,depth_org]  = meshgrid(lat_EN4, depth10);
[lat0,depth0]        = meshgrid(lat_IAP, (5:10:6000)');
gamma_ATL(:,:,3)    = griddata(lat_org,depth_org, nanmean(gamma_ATL_ann(:,:,65:84),3)',lat0,depth0,'linear');
clear lat0 depth0 lat_org depth_org gamma_ATL_ann
% #########################################################################

% ESM
dep_gamma           = (5:10:6000)';
gamma_ATL(gamma_ATL == 0) = NaN;
gamma_ATL_ann_map   = nanmean(gamma_ATL,3);
% #########################################################################
% #########################################################################


% #########################################################################
% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')
load('cal_AMOC_Streamfunction_V4_ESM_Observations_Z_Convt_ESM.mat','AMOCyz_ESM_005_map','lat_IAP','dep_gamma','time_ann_IAP')
% #########################################################################
% #########################################################################


% #########################################################################
% #########################################################################
%  1. Atlantic Ocean Density Transect - 2004-2023 
   % ######################################################################
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.16; ixe = 0.16;  ixd = 0.110; ixw = (1-ixs-ixe-0*ixd)/1;
   iys = 0.09; iye = 0.08;  iyd = 0.000; iyw = (1-iys-iye-1*iyd)/2;
   pos{11}  = [ixs          iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{21}  = [ixs          iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   % ######################################################################
   
   
   % ######################################################################
    clear color color0 
    color=cbrewer('div', 'RdBu', 12,'pchip');
    color0=color;
    %color0(1:size(color,1),:)=color(size(color,1):-1:1,:);
    color0(6,:)=(color0(6,:)+color0(5,:))./2;
    color0(12,:)=(color0(12,:)+color0(11,:))./2;
    color0(11,:)=color0(9,:);
    color0(10,:)=color0(9,:);
    
    color0(7,:)=color0(5,:) - [0.0 .1 .1];
    color0(8,:)=color0(5,:) - [0.0 .1 .1];
    color0(9,:)=color0(5,:) - [0.0 .1 .1];
    
    color0(6,:)=color0(3,:);
    color0(5,:)=color0(3,:);
    color0(4,:)=color0(3,:);
    
    color0(1,:)=color0(2,:);
    color0(2,:)=color0(2,:);
    color0(3,:)=color0(2,:);
   % ######################################################################
    
   
% #########################################################################
% Gamma
subplot('position',pos{11})
      imagesc(lat_IAP,dep_gamma,(gamma_ATL_ann_map),'AlphaData',~isnan(gamma_ATL_ann_map));

      % ###################################################################
      % ###################################################################
      % Add Topography
      hold on
      cd('/Users/z5195509/Documents/Data/GEBCO_2025_TOPO/gebco_2025_sub_ice_topo/')
      load GEOCO_2025_ATL_25W_Topo.mat
        lat     = (-89.5:0.25:89.5)';    % full lat vector
        atl_idx = 25:679;                % your Atlantic subset (keep as before)

        % load topo
        topo_all    = -topo_2025W_ave;                     % make depths positive
        topo_interp = interp1(lat_topo, topo_all, lat, 'nearest'); % onto same lat grid
        topo_atl    = topo_interp(atl_idx);

        % clip / fill NaNs (optional but recommended)
        nanmask = isnan(topo_atl);
        if any(nanmask)
            topo_atl(nanmask) = interp1(lat(atl_idx(~nanmask)), topo_atl(~nanmask), lat(atl_idx(nanmask)), 'linear', 'extrap');
        end
        topo_atl(topo_atl>6000) = 6000;  % ensure inside plotting range
        topo_atl(topo_atl<0) = 0;

        % build polygon coordinates (single-column vectors)
        x_poly = [lat(atl_idx); flipud(lat(atl_idx))];
        y_poly = [topo_atl; 6000*ones(size(topo_atl))];

        set(gca,'YDir','reverse');   % depth downward
        x_poly = [lat(atl_idx); flipud(lat(atl_idx))];
        y_poly = [topo_atl; 6000*ones(size(topo_atl))];

        fill(x_poly, y_poly, [0.55 0.55 0.55], 'EdgeColor','none');
       %plot(lat(atl_idx), topo_atl, 'k','LineWidth',1.2);
      % ###################################################################
      % ###################################################################
      


      % ################################################################### 
      % RAPID 26N 0-6000 m / bottom
      hold on 
      line_IW_26N = plot(26*ones(length((5:10:1500)')),(5:10:1500)');
      set(line_IW_26N,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);

      % OSNAP 53N 0-6000 m / bottom
      hold on 
      line_IW_53N = plot(53*ones(length((5:10:1500)')),(5:10:1500)');
      set(line_IW_53N,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);

      % SAMBA 34.5S 0-6000 m / bottom
      hold on 
      line_IW_345S = plot(-34.5*ones(length((5:10:1500)')),(5:10:1500)');
      set(line_IW_345S,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);
      % ################################################################### 

     
      
      % ################################################################### 
      % Equatorial Cell: gamma = 24
      hold on
      [C21,h21]=contour(lat_IAP(:,1),dep_gamma,gamma_ATL_ann_map,[24 24],'k-');
      set(h21,'color',[0    , 0.447, 0.741],'linewidth',2.0);
      v21=24;
      clabel(C21,h21,v21,'labelspacing',600,'fontsize',16,'color',[0    , 0.447, 0.741])  

      % Subtropical Mode Water: gamma = 26.6
      hold on
      [C21,h21]=contour(lat_IAP(:,1),dep_gamma,gamma_ATL_ann_map,[26.6 26.6],'k-');
      set(h21,'color',[0    , 0.447, 0.741],'linewidth',2.0);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',1000,'fontsize',16,'color',[0    , 0.447, 0.741])    
      
      % Antarctic Intermediate Water: gamma = 27.6
      hold on
      [C21,h21]=contour(lat_IAP(:,1),dep_gamma,gamma_ATL_ann_map,[27.6 27.6],'k-');
      set(h21,'color',[0    , 0.447, 0.741],'linewidth',2.0);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',1000,'fontsize',16,'color',[0    , 0.447, 0.741]) 
      % ###################################################################
      
      
      % ###################################################################
      % AMOC Streamfunction in Depth Space
      % ###################################################################
      % STMW cell in SA
      hold on 
      [C_STMW_SA,h_STMW_SA]=contour(lat_IAP(1:75,1),dep_gamma(1:end,1),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,1:75,65:84,4),4),3),3,2)./1e6,[-2 -2],':');
      set(h_STMW_SA,'color',[0.929, 0.694, 0.125],'linewidth',4.0);
      v_STMW_SA = [];
      clabel(C_STMW_SA,h_STMW_SA,v_STMW_SA,'labelspacing',600,'fontsize',18,'color',[0.929, 0.694, 0.125])   
      hold on 

      
      % ########################################
      % Upper AAIW cell
      % AMOC-Z = 9 Sv
      AMOCyz_AAIW = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_AAIW (gamma_ATL_ann_map<=26.5) = NaN;
      hold on 
      [C_AAIW_cell,h_AAIW_cell]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_AAIW,4,2)./1e6,[ 9  9],'k-');
      set(h_AAIW_cell,'color',[.8 .1 .1],'linewidth',6.0);
      v_AAIW_cell = [];
      clabel(C_AAIW_cell,h_AAIW_cell,v_AAIW_cell,'labelspacing',1500,'fontsize',20,'color',[.8 .2 .2])  
      
      
      % ########################################
      % ########################################
      % Lower NADW Cell: v2: full circle
      AMOCyz_NADW = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_NADW (gamma_ATL_ann_map<=26.6) = NaN;
      AMOCyz_NADW = smooth2a(AMOCyz_NADW(:,15:end),50,10)./1e6;
      hold on 
      [C_NADW_cell,h_NADW_cell]=contour(lat_IAP(15:end),dep_gamma(1:end),AMOCyz_NADW,[04.0 04.0],'k-');
      set(h_NADW_cell,'color',[.8 .4 .4],'linewidth',3.0);
      v_NADW_cell = [];
      clabel(C_NADW_cell,h_NADW_cell,v_NADW_cell,'labelspacing',2000,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      
      
      % STMW cell in NA
      AMOCyz_STMW_NA = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_STMW_NA (gamma_ATL_ann_map>=26.65) = NaN;
      hold on 
      [C_STMW_NA,h_STMW_NA]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_STMW_NA,4,2)./1e6,[ 9.5  9.5],'k-');
      set(h_STMW_NA,'color',[0.929, 0.694, 0.125],'linewidth',4.0);
      v_STMW_NA = [];
      clabel(C_STMW_NA,h_STMW_NA,v_STMW_NA,'labelspacing',1200,'fontsize',18,'color',[0.929, 0.694, 0.125])  
      % ###################################################################
      
      
      % ###################################################################  
      % My AUTO ARROW FACTORY 
      % AAIW Cell
      annotation('arrow', [ixs+(C_AAIW_cell(1,53)+77)/147.*ixw        ixs+(C_AAIW_cell(1,54)+77)/147.*ixw],...
                          [iys+(1500-C_AAIW_cell(2,53))/1500.*iyw+iyw iys+(1500-C_AAIW_cell(2,54))/1500.*iyw+iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 24, 'HeadLength',22);
      annotation('arrow', [ixs+(C_AAIW_cell(1,121)+77)/147.*ixw        ixs+(C_AAIW_cell(1,122)+77)/147.*ixw],...
                          [iys+(1500-C_AAIW_cell(2,121))/1500.*iyw+iyw iys+(1500-C_AAIW_cell(2,122))/1500.*iyw+iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 24, 'HeadLength',22);
      annotation('arrow', [ixs+(C_AAIW_cell(1,234)+77)/147.*ixw        ixs+(C_AAIW_cell(1,235)+77)/147.*ixw],...
                          [iys+(1500-C_AAIW_cell(2,234))/1500.*iyw+iyw iys+(1500-C_AAIW_cell(2,235))/1500.*iyw+iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 24, 'HeadLength',22);
      annotation('arrow', [ixs+(C_AAIW_cell(1,322)+77)/147.*ixw        ixs+(C_AAIW_cell(1,324)+77)/147.*ixw],...
                          [iys+(1500-C_AAIW_cell(2,322))/1500.*iyw+iyw iys+(1500-C_AAIW_cell(2,324))/1500.*iyw+iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 24, 'HeadLength',22);
      annotation('arrow', [ixs+(C_AAIW_cell(1,416)+77)/147.*ixw        ixs+(C_AAIW_cell(1,418)+77)/147.*ixw],...
                          [iys+(1500-C_AAIW_cell(2,416))/1500.*iyw+iyw iys+(1500-C_AAIW_cell(2,418))/1500.*iyw+iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 24, 'HeadLength',22);  
      annotation('arrow', [ixs+(C_AAIW_cell(1,529)+77)/147.*ixw        ixs+(C_AAIW_cell(1,530)+77)/147.*ixw],...
                          [iys+(1500-C_AAIW_cell(2,529))/1500.*iyw+iyw iys+(1500-C_AAIW_cell(2,530))/1500.*iyw+iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 24, 'HeadLength',18);  
      annotation('arrow', [ixs+(C_AAIW_cell(1,652)+77)/147.*ixw        ixs+(C_AAIW_cell(1,653)+77)/147.*ixw],...
                          [iys+(1500-C_AAIW_cell(2,652))/1500.*iyw+iyw iys+(1500-C_AAIW_cell(2,653))/1500.*iyw+iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 24, 'HeadLength',18);  
                      
          
      % NADW Cell
      annotation('arrow', [ixs+(C_NADW_cell(1,15)+77)/147.*ixw        ixs+(C_NADW_cell(1,17)+77)/147.*ixw],...
                          [iys+(1500-C_NADW_cell(2,15))/1500.*iyw+iyw iys+(1500-C_NADW_cell(2,17))/1500.*iyw+iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 18, 'HeadLength',18);
      annotation('arrow', [ixs+(C_NADW_cell(1,121)+77)/147.*ixw        ixs+(C_NADW_cell(1,122)+77)/147.*ixw],...
                          [iys+(1500-C_NADW_cell(2,121))/1500.*iyw+iyw iys+(1500-C_NADW_cell(2,122))/1500.*iyw+iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 18, 'HeadLength',18);
      annotation('arrow', [ixs+(C_NADW_cell(1,640)+77)/147.*ixw        ixs+(C_NADW_cell(1,641)+77)/147.*ixw],...
                          [iys+(1500-C_NADW_cell(2,640))/1500.*iyw+iyw iys+(1500-C_NADW_cell(2,641))/1500.*iyw+iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 18, 'HeadLength',18);
      annotation('arrow', [ixs+(C_NADW_cell(1,750)+77)/147.*ixw        ixs+(C_NADW_cell(1,751)+77)/147.*ixw],...
                          [iys+(1500-C_NADW_cell(2,750))/1500.*iyw+iyw iys+(1500-C_NADW_cell(2,751))/1500.*iyw+iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 18, 'HeadLength',18);
     
                      
      % NA STMW Cell
      annotation('arrow', [ixs+(C_STMW_NA(1,2)+77)/147.*ixw         ixs+(C_STMW_NA(1,3)+77)/147.*ixw],...
                          [iys+(1500-C_STMW_NA(2,2))/1500.*iyw+iyw  iys+(1500-C_STMW_NA(2,3))/1500.*iyw+iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15);  
      annotation('arrow', [ixs+(C_STMW_NA(1,46)+77)/147.*ixw        ixs+(C_STMW_NA(1,47)+77)/147.*ixw],...
                          [iys+(1500-C_STMW_NA(2,46))/1500.*iyw+iyw iys+(1500-C_STMW_NA(2,47))/1500.*iyw+iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15); 
                      
      % NA STMW Cell
      annotation('arrow', [ixs+(C_STMW_SA(1,117)+77)/147.*ixw         ixs+(C_STMW_SA(1,118)+77)/147.*ixw],...
                          [iys+(1500-C_STMW_SA(2,117))/1500.*iyw+iyw  iys+(1500-C_STMW_SA(2,118))/1500.*iyw+iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15);  
      annotation('arrow', [ixs+(C_STMW_SA(1,151)+77)/147.*ixw        ixs+(C_STMW_SA(1,152)+77)/147.*ixw],...
                          [iys+(1500-C_STMW_SA(2,151))/1500.*iyw+iyw iys+(1500-C_STMW_SA(2,152))/1500.*iyw+iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15);            
      % ################################################################### 
      
      
      
      % ################################################################### 
      % Density/depth with the max stremfunction
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
      load('plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin_2_Density_of_MaxStrf.mat',...
           'AMOC_density_max_strf_ESM_20042023')
      for lat_num = 28:160%length(lat_IAP)
          if isnan(AMOC_density_max_strf_ESM_20042023(lat_num,2)) == 0 && sum(isnan(gamma_ATL_ann_map(:,lat_num))==0) >=1
              dep_max_strf(lat_num,1) = find(abs(gamma_ATL_ann_map(:,lat_num) - AMOC_density_max_strf_ESM_20042023(lat_num,2)) == min(abs(gamma_ATL_ann_map(:,lat_num) - AMOC_density_max_strf_ESM_20042023(lat_num,2))));
              dep_max_strf(lat_num,2) = find(abs(gamma_ATL_ann_map(:,lat_num) - AMOC_density_max_strf_ESM_20042023(lat_num,1)) == min(abs(gamma_ATL_ann_map(:,lat_num) - AMOC_density_max_strf_ESM_20042023(lat_num,1))));
              dep_max_strf(lat_num,3) = find(abs(gamma_ATL_ann_map(:,lat_num) - AMOC_density_max_strf_ESM_20042023(lat_num,3)) == min(abs(gamma_ATL_ann_map(:,lat_num) - AMOC_density_max_strf_ESM_20042023(lat_num,3))));
              dep_max_strf(lat_num,4) = find(abs(gamma_ATL_ann_map(:,lat_num) - AMOC_density_max_strf_ESM_20042023(lat_num,4)) == min(abs(gamma_ATL_ann_map(:,lat_num) - AMOC_density_max_strf_ESM_20042023(lat_num,4))));
              dep_max_strf(lat_num,5) = find(abs(gamma_ATL_ann_map(:,lat_num) - AMOC_density_max_strf_ESM_20042023(lat_num,5)) == min(abs(gamma_ATL_ann_map(:,lat_num) - AMOC_density_max_strf_ESM_20042023(lat_num,5))));
              dep_max_strf(dep_max_strf==0) = NaN;
              dep_max_strf = round(nanmean(dep_max_strf,2));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dep_gamma(dep_max_strf(lat_num,1),1),'-+','MarkerSize',12);
              set(line_max_strf,'color',[.5 .5 .5], 'LineWidth', 3.0);
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 dep_max_strf
      % ################################################################### 
      
      
      
      % ###################################################################
      % Add text on Subtropical and Subpolar Cells, and IW
      % text( 15.0,100, 'Subtropical Cell','fontsize',20,'FontWeight','normal');
      text( 22.0, 140, 'STMW','fontsize',18,'FontWeight','normal');
      text(-34.0, 170, 'STMW','fontsize',16,'FontWeight','normal');

     %text(-41,   650, 'Antarctic Intermediate Water','fontsize',22,'FontWeight','normal');%
      text(-48,   150, 'SAMW and AAIW','fontsize',20,'FontWeight','normal','rotation',-58);
            
     %text( 29.5,1400, 'LSW and NADW','fontsize',22,'FontWeight','normal'); 
      text( 31.5,1480, 'LSW and NADW','fontsize',22,'FontWeight','normal','rotation',33); 
      
      text( 58.7, 060, 'LSW','fontsize',20,'FontWeight','normal'); 
      text(-69,   040, 'CDW','fontsize',17,'FontWeight','normal'); 
                  
      text( -3,   480,'\Psi_{max}','fontsize',21,'Color', [0.2, 0.2, 0.2])
      % ###################################################################    
      
      

      % ###################################################################
      xlim([-77 70])
      ylim([0 1500])
      set(gca,'XTick',-60:20:80)
      set(gca,'XTickLabel',[],'FontSize',22)
      set(gca,'YTick',0:300:2000)
      set(gca,'YTickLabel',{'0','300','600','900','1200','1500'},'FontSize',22)
      set(gca,'tickdir','in','box','on')
      grid off

      colormap(gca,color0)
      caxis([24.6 28.6]);
      title('Atlantic Basin Density and Overturning Circulation','fontsize',28,'FontWeight','bold')

      ylabel(['Depth [ m ]                                                  '])  
      % ###################################################################


      % ################################################################### 
      % Only show top, left, and right boundaries
      set(gca,'box','off')              % remove full box
    % set(gca,'XAxisLocation','bottom') % keep bottom x-axis ticks
      set(gca,'YAxisLocation','left')   % keep left y-axis ticks
      set(gca,'XAxisLocation','top')
      % To re-draw only vertical axis lines:
      ax = gca;
      ax.XColor = 'k';  % show x-axis ticks and labels
      ax.YColor = 'k';  % show y-axis ticks and labels
      
      yl = ylim;              % current y-axis limits
      xl = xlim;              % current x-axis limits
      hold on
      line_bond_r1 = plot([xl(2) xl(2)], yl, 'k','linewidth',1.5);   % vertical line at right edge
      % ################################################################### 
% #########################################################################



% #########################################################################    
% Gamma
subplot('position',pos{21})
      imagesc(lat_IAP,dep_gamma,(gamma_ATL_ann_map),'AlphaData',~isnan(gamma_ATL_ann_map));

      % ################################################################### 
      % RAPID 26N 0-6000 m / bottom
      hold on 
      line_IW_26N      = plot(26*ones(length((1500:10:5800)')),(1500:10:5800)');
      set(line_IW_26N,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);

      % OSNAP 53N 0-6000 m / bottom
      hold on 
      line_IW_53N = plot(53*ones(length((1500:10:3800)')),(1500:10:3800)');
      set(line_IW_53N,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);

      % SAMBA 34.5S 0-6000 m / bottom
      hold on 
      line_IW_345S = plot(-34.5*ones(length((1500:10:5100)')),(1500:10:5100)');
      set(line_IW_345S,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);
      % ################################################################### 

      
      % ###################################################################
      % ###################################################################
      % Add Topography
      hold on
      cd('/Users/z5195509/Documents/Data/GEBCO_2025_TOPO/gebco_2025_sub_ice_topo/')
      load GEOCO_2025_ATL_25W_Topo.mat
        lat = (-89.5:0.25:89.5)';        % full lat vector
        atl_idx = 25:679;                % your Atlantic subset (keep as before)

        % load topo
        topo_all    = -topo_2025W_ave;                     % make depths positive
        topo_interp = interp1(lat_topo, topo_all, lat, 'nearest'); % onto same lat grid
        topo_atl    = topo_interp(atl_idx);

        % clip / fill NaNs (optional but recommended)
        nanmask = isnan(topo_atl);
        if any(nanmask)
            topo_atl(nanmask) = interp1(lat(atl_idx(~nanmask)), topo_atl(~nanmask), lat(atl_idx(nanmask)), 'linear', 'extrap');
        end
        topo_atl(topo_atl>6000) = 6000;  % ensure inside plotting range
        topo_atl(topo_atl<0) = 0;

        % build polygon coordinates (single-column vectors)
        x_poly = [lat(atl_idx); flipud(lat(atl_idx))];
        y_poly = [topo_atl; 6000*ones(size(topo_atl))];

        set(gca,'YDir','reverse');   % depth downward
        x_poly = [lat(atl_idx); flipud(lat(atl_idx))];
        y_poly = [topo_atl; 6000*ones(size(topo_atl))];

        fill(x_poly, y_poly, [0.56 0.55 0.55], 'EdgeColor','none');
       %plot(lat(atl_idx), topo_atl, 'k','LineWidth',1.2);
      % ###################################################################
      % ###################################################################
      
      
      
      % ###################################################################   
      % Antarctic Intermediate Water: gamma = 27.6
      hold on
      [C21,h21]=contour(lat_IAP(:,1),dep_gamma,gamma_ATL_ann_map,[27.6 27.6],'k-');
      set(h21,'color',[0    , 0.447, 0.741],'linewidth',2.0);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',600,'fontsize',16,'color',[0    , 0.447, 0.741]) 
      % ###################################################################
      
      
      
      % ################################################################### 
      % RAPID 26N 0-6000 m / bottom
      hold on 
      line_UP_26N_tri  = plot(26,4750,'^','MarkerSize',16,'MarkerFaceColor', [0.9, 0.1, 0.1],       'MarkerEdgeColor', [0.2, 0.2, 0.2]);
      set(line_UP_26N_tri,'color',[0.9, 0.1, 0.1], 'LineWidth', 1.5);      
      text(16.5,4750, 'RAPID','fontsize',18,'FontWeight','normal'); 

      % OSNAP 53N 0-6000 m / bottom
      hold on 
      line_UP_53N_tri  = plot(53,3450,'^','MarkerSize',16,'MarkerFaceColor', [0.301, 0.745, 0.933], 'MarkerEdgeColor', [0.2, 0.2, 0.2]);
      set(line_UP_53N_tri,'color',[0.301, 0.745, 0.933], 'LineWidth', 1.5); 
      text(54.5,3450, 'OSNAP','fontsize',18,'FontWeight','normal'); 

      % SAMBA 34.5S 0-6000 m / bottom
      hold on 
      line_UP_345S_tri  = plot(-34.5,3900,'^','MarkerSize',16,'MarkerFaceColor', [0.2, 0.7, 0.2],   'MarkerEdgeColor', [0.2, 0.2, 0.2]);
      set(line_UP_345S_tri,'color',[0.2, 0.7, 0.2], 'LineWidth', 1.5);
      text(-33.0,3900, 'SAMBA','fontsize',18,'FontWeight','normal'); 
      % ################################################################### 
      
      % ###################################################################
      % Add text on Subtropical and Subpolar Cells, and IW
      text(-72,3000, 'Antarctic ','fontsize',22,'FontWeight','normal');
      text(-72,3400, 'Bottom Water','fontsize',22,'FontWeight','normal');
      % ###################################################################
      
      
      
      % ###################################################################
      % Add arrow annotations to indicate the AMOC upper and lower branches
      annotation('arrow', [ixs+0.93*ixw ixs+0.90*ixw],  [iys+1.15*iyw iys+1.00*iyw],'Color', [0.8, 0.4, 0.4], 'LineWidth', 2.5,'Linestyle','-','HeadWidth', 10, 'HeadLength',10);
      annotation('arrow', [ixs+0.82*ixw ixs+0.78*ixw],  [iys+0.78*iyw iys+0.75*iyw],'Color', [0.8, 0.4, 0.4], 'LineWidth', 2.5,'Linestyle','-','HeadWidth', 10, 'HeadLength',10);

      % AABW
      annotation('arrow', [ixs+0.04*ixw ixs+0.06*ixw],  [iys+1.25*iyw iys+0.80*iyw],'Color', [0.201, 0.645, 0.933], 'LineWidth', 4.0,'Linestyle','-','HeadWidth', 15, 'HeadLength',15);
      annotation('arrow', [ixs+0.12*ixw ixs+0.18*ixw],  [iys+0.45*iyw iys+0.40*iyw],'Color', [0.201, 0.645, 0.933], 'LineWidth', 4.0,'Linestyle','-','HeadWidth', 15, 'HeadLength',10);
      annotation('arrow', [ixs+0.36*ixw ixs+0.44*ixw],  [iys+0.30*iyw iys+0.30*iyw],'Color', [0.201, 0.645, 0.933], 'LineWidth', 4.0,'Linestyle','-','HeadWidth', 15, 'HeadLength',10);
      % ###################################################################  
       
      

      % ###################################################################
      % AMOC Streamfunction in Depth Space
      % ###################################################################
      % Upper AAIW Cell 
      % AMOC-Z = 9 Sv
      AMOCyz_AAIW = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_AAIW (gamma_ATL_ann_map<=26.5) = NaN;
      hold on 
      [C_AAIW_cell,h_AAIW_cell]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_AAIW,4,2)./1e6,[ 9  9],'k-');
      set(h_AAIW_cell,'color',[.8 .1 .1],'linewidth',6.0);
      v_AAIW_cell = [];
      clabel(C_AAIW_cell,h_AAIW_cell,v_AAIW_cell,'labelspacing',1500,'fontsize',20,'color',[.8 .2 .2])   
      
      % ########################################
      % ########################################
      % Lower NADW Cell: v2: full circle
      AMOCyz_NADW = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_NADW (gamma_ATL_ann_map<=27.6) = NaN;
      hold on 
      [C_NADW_cell,h_NADW_cell]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_NADW,50,10)./1e6,[04.0 04.0],'k-');
      set(h_NADW_cell,'color',[.8 .4 .4],'linewidth',3.0);
      v_NADW_cell = [];
      clabel(C_NADW_cell,h_NADW_cell,v_NADW_cell,'labelspacing',2000,'fontsize',16,'color',[.2 .2 .2])   
      
            
      % ###################################################################
      % Add an arrow annotation [x_start x_end] and [y_start y_end]
      % NADW Cell
      annotation('arrow', [ixs+(C_NADW_cell(1,338)+77)/147.*ixw          ixs+(C_NADW_cell(1,339)+77)/147.*ixw],...
                          [iys+(5600-C_NADW_cell(2,338))/4100.*iyw+0*iyw iys+(5600-C_NADW_cell(2,339))/4100.*iyw+0*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 18, 'HeadLength',18);
      % ###################################################################
      % ###################################################################  
    

      % ################################################################### 
      xlim([-77 70])
      ylim([1500 5600])
      set(gca,'XTick',-60:20:80)
      set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0\circ','20\circN','40\circN','60\circN','80\circN'},'FontSize',22)
      set(gca,'YTick',2500:1000:6500)
      set(gca,'YTickLabel',{'2500','3500','4500','5500','6500'},'FontSize',22)
      set(gca,'tickdir','in','box','on')
      grid off
%       grid on
%       set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.1,'GridLineStyle','-')

      colormap(gca,color0)
      caxis([24.6 28.6]);
      xlabel(['Latitude'])  
      % ################################################################### 
      

      % ################################################################### 
      % Only show bottom, left, and right boundaries
      set(gca,'box','off')              % remove full box
      set(gca,'XAxisLocation','bottom') % keep bottom x-axis ticks
      set(gca,'YAxisLocation','left')   % keep left y-axis ticks

      % To re-draw only vertical axis lines:
      ax = gca;
      ax.XColor = 'k';  % show x-axis ticks and labels
      ax.YColor = 'k';  % show y-axis ticks and labels
      
      yl = ylim;              % current y-axis limits
      xl = xlim;              % current x-axis limits
      hold on
      line_bond_r2 = plot([xl(2) xl(2)], yl, 'k','linewidth',1.5);   % vertical line at right edge
      % ################################################################### 

      
  hBar1 = colorbar('EastOutside');
  get(hBar1, 'Position') ;
  set(hBar1, 'Position', [ixs+1*ixw+0.010 iys+0.5*iyw+1*iyd 0.012 1.0*iyw+1*iyd]);
  set(hBar1,'ytick',24.6:1:28.6,'yticklabel',{'24.6','25.6','26.6','27.6','28.6'},'fontsize',20,'FontName','Arial','LineWidth',1.2,'TickLength',0.05);

  ylabel(hBar1, '[ kg m^{-3} ]','rotation',90);
% #########################################################################
% #########################################################################



% #########################################################################
% Inset map in bottom right corner of bottom panel
% #########################################################################

% Define inset position (relative to figure, not to subplot)
inset_pos = [0.65 0.105 0.20 0.19];  % [left bottom width height]

axes('Position', inset_pos);

    % #########################################################################
    % AMOC AND ATLANTIC BASIN MASKC:
      disp('Basin Mask#')
      load('heat_content_anomaly_0-2000_pentad_Levitus2012.mat',...
            'lon_Lev','lat_Lev','basin_mask')
      basin_mask_AO=basin_mask; clear basin_mask
      basin_mask_AO(basin_mask_AO>1)=NaN;
      basin_mask_AO(basin_mask_AO<1)=NaN;

      % Remapping AMOC Mask onto IAP Grids [-179 180]
      [lo,la] = meshgrid((lon_IAP)',(lat_IAP)');
      basin_mask_AO(:,:)=griddata(lon_Lev,lat_Lev,squeeze(basin_mask_AO(:,:))',lo',la','nearest');
      clear lon_Lev lat_Lev lo la
      basin_mask_AO(1:80,   :)=NaN; % 100W
      basin_mask_AO(210:end,:)=NaN; %  30E
      % Set 70N as the Northern Boundary
      basin_mask_AO(:,    162:end)=NaN;
      basin_mask_AO(80:95,155:162)=NaN;
    % #########################################################################

    % Plot the Atlantic basin mask map
        m_proj('robinson','lon',[-180 180],'lat',[-80 80]);  
        m_pcolor(lon_IAP,lat_IAP,basin_mask_AO');
        shading flat
        hold on
        
        
        % Customize the map grid and coastlines
        m_grid('box','on','tickdir','in','linestyle','none','LineWidth',1.5,...
               'ticklen',0.01,'fontsize',12,...
               'xticklabels',[],'yticklabels',[]);  % Hide axis labels for compactness

        m_coast('patch',[0.6 0.6 0.6],'edgecolor',[0.4 0.4 0.4]); 
        hold on

        % Apply colormap
        clear color color0 
        color = cbrewer('seq', 'Oranges',3,'pchip');
        colormap(gca, color)
        caxis([0 1]);

        m_text(-58, 20, 'ATL.','FontSize',14,'FontWeight','bold')

% #########################################################################
% #########################################################################

cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')

% #########################################################################
% #########################################################################


