%% ########################################################################
%% ATLANTIC BASIN MEAN TS AND DENSITY 
%% Depth and Latitude of Zonal Mean CT, SA, and Density
%  IAPv4,v4.2 data, Annual Mean, 1950-2023
%  Annual Mean of Monthly Mean
%  Vertical gradients of TS


% #########################################################################
% #########################################################################
%% 4. Plotting - Temperature, Salinity, AMOC Changes
clc; clear

% #########################################################################
time_ann = (1940 :1: 2023)';
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/3_Meridional_Transects/')
load(['cal_ATL_Basin_Zonal_TS_Density_and_AAIW_Vol_OHC_V6_1_Zonal_TS_Gam_OHC_Vol_1_IAPv42_Annual_19402023.mat'],...
      'gamma_ATL_ann','CT_ATL_ann','SA_ATL_ann','alpha_ATL_ann','beta_ATL_ann',...
      'dep_IAP','AMOC_idx_mon','lon_IAP','lat_IAP','time_ann')


% #########################################################################
% Climatology over 2004-2024
gamma_ATL_ann     = nanmean( gamma_ATL_ann(:,:,65:84),3);
CT_ATL_ann        = nanmean(    CT_ATL_ann(:,:,65:84),3);
SA_ATL_ann        = nanmean(    SA_ATL_ann(:,:,65:84),3);

% Interpolate to regular depth intervals to enable mapping correctly
[lat_org,depth_org]  = meshgrid(lat_IAP, dep_IAP);
[lat0,depth0]        = meshgrid(lat_IAP, (5:10:6000)');
gamma_ATL_ann_map    = griddata(lat_org,depth_org,   gamma_ATL_ann(:,:)',lat0,depth0,'linear');
CT_ATL_ann_map       = griddata(lat_org,depth_org,      CT_ATL_ann(:,:)',lat0,depth0,'linear');
SA_ATL_ann_map       = griddata(lat_org,depth_org,      SA_ATL_ann(:,:)',lat0,depth0,'linear');
clear lat0 depth0 lat_org depth_org gamma_ATL_ann CT_ATL_ann SA_ATL_ann ohc_ATL_ann
dep_gamma = (5:10:6000)';
% #########################################################################
% #########################################################################
    

% #########################################################################
% ######################################################################### 
% AMOC-G Streamfunction Trend 1960-2023
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
load plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat
AMOC_SFygtn_ESM_005_LOW    (AMOC_SFygtn_ESM_005_LOW    ==0) = NaN;
AMOC_SFygtn_F_ESM_005_LOW  (AMOC_SFygtn_F_ESM_005_LOW  ==0) = NaN;
AMOC_SFygtn_N_ESM_005_LOW  (AMOC_SFygtn_N_ESM_005_LOW  ==0) = NaN;
AMOC_SFygtn_V_ESM_005_LOW  (AMOC_SFygtn_V_ESM_005_LOW  ==0) = NaN;
AMOC_SFygtn_dM_ESM_005_LOW (AMOC_SFygtn_dM_ESM_005_LOW ==0) = NaN;
AMOC_SFygtn_V_JCT_ESM_LOW (AMOC_SFygtn_V_JCT_ESM_LOW ==0) = NaN;
AMOC_SFygtn_V_JSA_ESM_LOW (AMOC_SFygtn_V_JSA_ESM_LOW ==0) = NaN;

AMOC_F_ESM       = nanmean(AMOC_SFygtn_F_ESM_005_LOW(:,:,:,2:5),4);
AMOC_N_ESM       = nanmean(AMOC_SFygtn_N_ESM_005_LOW(:,:,:,2:5),4);
AMOC_V_JCT_ESM   = nanmean(AMOC_SFygtn_V_JCT_ESM_LOW(:,:,:,2:5),4);
AMOC_V_JSA_ESM   = nanmean(AMOC_SFygtn_V_JSA_ESM_LOW(:,:,:,2:5),4);
AMOC_dM_ESM      = nanmean(AMOC_SFygtn_dM_ESM_005_LOW(:,:,:,2:5),4);

% #########################################################################
% Calculate linear trend of AMOC streamfunction
% Trend from 1960 to 2023
for i = 1 : size(AMOC_N_ESM,1)
    disp(['AMOC trend# lon#',num2str(i),' #ESM'])
    for j = 1 : size(AMOC_N_ESM,2)
        % Air-Sea Flux
        p1                        = polyfit(21:size(AMOC_N_ESM,3),squeeze(AMOC_F_ESM    (i,j,21:end))',1);
        AMOCyg_F_trend(i,j)       = p1(1,1); clear p1
        % Neutral Mixing
        p1                        = polyfit(21:size(AMOC_N_ESM,3),squeeze(AMOC_N_ESM    (i,j,21:end))',1);
        AMOCyg_N_trend(i,j)       = p1(1,1); clear p1
        % Vertical Mixing
        p1                        = polyfit(21:size(AMOC_N_ESM,3),squeeze(AMOC_V_JCT_ESM(i,j,21:end))',1);
        AMOCyg_V_JCT_trend(i,j)   = p1(1,1); clear p1
        % Neutral Mixing
        p1                        = polyfit(21:size(AMOC_N_ESM,3),squeeze(AMOC_V_JSA_ESM(i,j,21:end))',1);
        AMOCyg_V_JSA_trend(i,j)   = p1(1,1); clear p1
        % Neutral Mixing
        p1                        = polyfit(21:size(AMOC_N_ESM,3),squeeze(AMOC_dM_ESM   (i,j,21:end))',1);
        AMOCyg_dM_trend(i,j)      = p1(1,1); clear p1
    end
end
clear i j 
AMOCyg_F_trend    (AMOCyg_F_trend    ==0) = NaN;
AMOCyg_N_trend    (AMOCyg_N_trend    ==0) = NaN;
AMOCyg_V_JCT_trend(AMOCyg_V_JCT_trend==0) = NaN;
AMOCyg_V_JSA_trend(AMOCyg_V_JSA_trend==0) = NaN;
AMOCyg_dM_trend   (AMOCyg_dM_trend   ==0) = NaN;
% clear AMOC_SFyg*
% #########################################################################
% ######################################################################### 




% #########################################################################
% #########################################################################
% #########################################################################
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.06; ixe = 0.09;  ixd = 0.07; ixw = (1-ixs-ixe-1*ixd)/2;
   iys = 0.08; iye = 0.06;  iyd = 0.09; iyw = (1-iys-iye-1*iyd)/2;
   pos{11}  = [ixs                iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{21}  = [ixs+ixw+ixd  iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{31}  = [ixs                iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   pos{41}  = [ixs+ixw+ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   
   
    clear color color0 
    color=cbrewer('div', 'RdBu', 12,'pchip');
    color0(1:size(color,1),:)=color(size(color,1):-1:1,:);
    color0(2:6,:)=(color0(2:6,:)+color0(1:5,:))./2;
    color0(6,:)=(color0(6,:)+color0(5,:))./2;
% #########################################################################
   


% #########################################################################
% #########################################################################
% Temperature
subplot('position',pos{11})
      imagesc(lat_IAP,dep_gamma(:,1),(CT_ATL_ann_map),'AlphaData',~isnan(CT_ATL_ann_map));

      % ################################################################### 
      % RAPID 26N 0-6000 m / bottom
      hold on 
      line_IW_26N = plot(26*ones(length((5:10:2500)')),(5:10:2500)');
      set(line_IW_26N,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);
      text(27.0,2400, 'RAPID (26\circN)','fontsize',14,'FontWeight','normal'); 

      % OSNAP 53N 0-6000 m / bottom
      hold on 
      line_IW_53N = plot(53*ones(length((5:10:2500)')),(5:10:2500)');
      set(line_IW_53N,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);
      text(54.0,2400, 'OSNAP','fontsize',14,'FontWeight','normal'); 
      
      % SAMBA 34.5S 0-6000 m / bottom
      hold on 
      line_IW_345S = plot(-34.5*ones(length((5:10:2500)')),(5:10:2500)');
      set(line_IW_345S,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);
      text(-33.5,2400, 'SAMBA (34.5\circS)','fontsize',14,'FontWeight','normal'); 
      % ################################################################### 


      % ################################################################### 
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')
      load(['cal_AMOC_Streamfunction_V4_ESM_Observations_Z_Convt_2_IAPv42_Annual_Gam_19402023.mat'],...
            'gamma_ATL_ann','dep_IAP','lat_IAP')
      gamma_ATL_ann = nanmean(gamma_ATL_ann(:,:,65:84),3);
      [lat_org,depth_org]  = meshgrid(lat_IAP, dep_IAP);
      [lat0,depth0]        = meshgrid(lat_IAP, (5:10:6000)');
      gamma_ATL_ann_map    = griddata(lat_org,depth_org,   gamma_ATL_ann(:,:)',lat0,depth0,'linear');
      clear lat_org depth_org lat0 depth0 gamma_ATL_ann
      
      
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
      
      % Subpolar Cell: LSW and NADW gamma = 28
      hold on
      [C21,h21]=contour(lat_IAP(:,1),dep_gamma,gamma_ATL_ann_map,[28.0 28.0],'k-');
      set(h21,'color',[0    , 0.447, 0.741],'linewidth',2.0);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',1000,'fontsize',16,'color',[0    , 0.447, 0.741]) 
      % ###################################################################
      % ###################################################################
     
      
      % ###################################################################
      % AMOC Streamfunction in Depth Space
      % #########################################################################
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')
      load('cal_AMOC_Streamfunction_V4_ESM_Observations_Z_Convt_ESM.mat','AMOCyz_ESM_005_map','lat_IAP','dep_gamma','time_ann_IAP')
      % #########################################################################
      % ###################################################################
      % STMW cell in SA
      hold on 
      [C_STMW_SA,h_STMW_SA]=contour(lat_IAP(1:75,1),dep_gamma(1:end,1),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,1:75,65:84,4),4),3),3,2)./1e6,[-2 -2],'k--');
      set(h_STMW_SA,'color',[0.929, 0.694, 0.125],'linewidth',3.0);
      v_STMW_SA = -2;
      clabel(C_STMW_SA,h_STMW_SA,v_STMW_SA,'labelspacing',600,'fontsize',16,'color',[0.929, 0.694, 0.125])   
      hold on 

      AMOCyz_AAIW = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_AAIW (gamma_ATL_ann_map<=26.5) = NaN;
      hold on 
      [C_AAIW_cell,h_AAIW_cell]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_AAIW,4,2)./1e6,[ 9  9],'k-');
      set(h_AAIW_cell,'color',[.8 .1 .1],'linewidth',4.0);
      v_AAIW_cell = 9;
      clabel(C_AAIW_cell,h_AAIW_cell,v_AAIW_cell,'labelspacing',1500,'fontsize',16,'color',[.8 .2 .2])   

      % STMW cell in NA
      AMOCyz_STMW_NA = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_STMW_NA (gamma_ATL_ann_map>=26.65) = NaN;
      hold on 
      [C_STMW_NA,h_STMW_NA]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_STMW_NA,4,2)./1e6,[ 9.5  9.5],'k-');
      set(h_STMW_NA,'color',[0.929, 0.694, 0.125],'linewidth',3.0);
      v_STMW_NA = [];
      clabel(C_STMW_NA,h_STMW_NA,v_STMW_NA,'labelspacing',1500,'fontsize',18,'color',[0.929, 0.694, 0.125])  

      % My AUTO ARROW FACTORY 
      % AAIW Cell
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_AAIW_cell(1,53)+77)/147.*ixw    ixs+0*ixw+0*ixd+(C_AAIW_cell(1,54)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,53))/2500.*iyw   iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,54))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_AAIW_cell(1,121)+77)/147.*ixw   ixs+0*ixw+0*ixd+(C_AAIW_cell(1,122)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,121))/2500.*iyw  iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,122))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_AAIW_cell(1,234)+77)/147.*ixw   ixs+0*ixw+0*ixd+(C_AAIW_cell(1,235)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,234))/2500.*iyw  iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,235))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_AAIW_cell(1,322)+77)/147.*ixw   ixs+0*ixw+0*ixd+(C_AAIW_cell(1,324)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,322))/2500.*iyw  iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,324))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_AAIW_cell(1,413)+77)/147.*ixw   ixs+0*ixw+0*ixd+(C_AAIW_cell(1,414)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,413))/2500.*iyw  iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,414))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);  
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_AAIW_cell(1,529)+77)/147.*ixw   ixs+0*ixw+0*ixd+(C_AAIW_cell(1,530)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,529))/2500.*iyw  iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,530))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 24, 'HeadLength',18);  
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_AAIW_cell(1,652)+77)/147.*ixw   ixs+0*ixw+0*ixd+(C_AAIW_cell(1,653)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,652))/2500.*iyw  iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,653))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 24, 'HeadLength',18);  
                      
      % NA STMW Cell
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_STMW_NA(1,2)+77)/147.*ixw       ixs+0*ixw+0*ixd+(C_STMW_NA(1,3)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_STMW_NA(2,2))/2500.*iyw      iys+1*iyw+1*iyd+(2500-C_STMW_NA(2,3))/2500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15);  
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_STMW_NA(1,46)+77)/147.*ixw      ixs+0*ixw+0*ixd+(C_STMW_NA(1,47)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_STMW_NA(2,46))/2500.*iyw     iys+1*iyw+1*iyd+(2500-C_STMW_NA(2,47))/2500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15); 
                      
      % NA STMW Cell
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_STMW_SA(1,117)+77)/147.*ixw     ixs+0*ixw+0*ixd+(C_STMW_SA(1,118)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_STMW_SA(2,117))/2500.*iyw    iys+1*iyw+1*iyd+(2500-C_STMW_SA(2,118))/2500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15);  
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_STMW_SA(1,151)+77)/147.*ixw     ixs+0*ixw+0*ixd+(C_STMW_SA(1,152)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_STMW_SA(2,151))/2500.*iyw    iys+1*iyw+1*iyd+(2500-C_STMW_SA(2,152))/2500.*iyw],...
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
              dep_max_strf = round(nanmean(dep_max_strf(:,1),2));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dep_gamma(dep_max_strf(lat_num,1),1),'-+','MarkerSize',10);
              set(line_max_strf,'color',[.6 .6 .6], 'LineWidth', 3.0);
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 dep_max_strf
      % ################################################################### 
      

      % ###################################################################
      % Add text on Subtropical and Subpolar Cells, and IW
      text( 22.0, 140, 'STMW','fontsize',14,'FontWeight','normal');
      text(-34.0, 170, 'STMW','fontsize',14,'FontWeight','normal');

      text(-48,   150, 'SAMW and AAIW','fontsize',16,'FontWeight','normal','rotation',-40);
            
      text( 29.5,1250, 'LSW and NADW','fontsize',16,'FontWeight','normal'); 
               
      text(  0,   480,'\Psi_{max}','fontsize',16,'Color', [0.3, 0.3, 0.3])
      % ###################################################################  
      
      
      xlim([-77 70])
      ylim([0 2500])
      set(gca,'XTick',-60:20:80)
      set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0\circ','20\circN','40\circN','60\circN','80\circN'},'FontSize',20)
      set(gca,'YTick',0:500:2500)
      set(gca,'YTickLabel',{'0','500','1000','1500','2000','2500'},'FontSize',20)
      set(gca,'tickdir','in','box','on')
      grid off
      colormap(gca,color0)
      caxis([-2 28]);
      title('a. Atlantic basin temperature (2004-2023)','fontsize',24,'FontWeight','bold')

      ylabel(['Depth [m]'],'FontSize',20)  
     
      hBar1 = colorbar('EastOutside');
      get(hBar1, 'Position') ;
      set(hBar1, 'Position', [ixs+1*ixw+0.010 iys+1*iyw+1*iyd 0.012 1.0*iyw+0*iyd]);
      set(hBar1,'ytick',-2:5:28,'yticklabel',{'-2','3','8','13','18','23','28'},'fontsize',20,'FontName','Arial','LineWidth',1.2,'TickLength',0.055);
      
      ylabel(hBar1, '[ \circC ]','rotation',90,'FontSize',20);
      
      

% Salinity
subplot('position',pos{21})
      imagesc(lat_IAP,dep_gamma(:,1),(SA_ATL_ann_map),'AlphaData',~isnan(SA_ATL_ann_map));
      
      
      % ################################################################### 
      % RAPID 26N 0-6000 m / bottom
      hold on 
      line_IW_26N = plot(26*ones(length((5:10:2500)')),(5:10:2500)');
      set(line_IW_26N,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);
      text(27.0,2400, 'RAPID (26\circN)','fontsize',14,'FontWeight','normal'); 

      % OSNAP 53N 0-6000 m / bottom
      hold on 
      line_IW_53N = plot(53*ones(length((5:10:2500)')),(5:10:2500)');
      set(line_IW_53N,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);
      text(54.0,2400, 'OSNAP','fontsize',14,'FontWeight','normal'); 
      
      % SAMBA 34.5S 0-6000 m / bottom
      hold on 
      line_IW_345S = plot(-34.5*ones(length((5:10:2500)')),(5:10:2500)');
      set(line_IW_345S,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);
      text(-33.5,2400, 'SAMBA (34.5\circS)','fontsize',14,'FontWeight','normal'); 
      % ################################################################### 

      
      % ################################################################### 
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')
      load(['cal_AMOC_Streamfunction_V4_ESM_Observations_Z_Convt_2_IAPv42_Annual_Gam_19402023.mat'],...
            'gamma_ATL_ann','dep_IAP','lat_IAP')
      gamma_ATL_ann = nanmean(gamma_ATL_ann(:,:,65:84),3);
      [lat_org,depth_org]  = meshgrid(lat_IAP, dep_IAP);
      [lat0,depth0]        = meshgrid(lat_IAP, (5:10:6000)');
      gamma_ATL_ann_map    = griddata(lat_org,depth_org,   gamma_ATL_ann(:,:)',lat0,depth0,'linear');
      clear lat_org depth_org lat0 depth0 gamma_ATL_ann
      
      
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
      
      % Subpolar Cell: LSW and NADW gamma = 28
      hold on
      [C21,h21]=contour(lat_IAP(:,1),dep_gamma,gamma_ATL_ann_map,[28.0 28.0],'k-');
      set(h21,'color',[0    , 0.447, 0.741],'linewidth',2.0);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',1000,'fontsize',16,'color',[0    , 0.447, 0.741]) 
      % ###################################################################
      % ###################################################################
     
      
      % ###################################################################
      % AMOC Streamfunction in Depth Space
      % #########################################################################
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')
      load('cal_AMOC_Streamfunction_V4_ESM_Observations_Z_Convt_ESM.mat','AMOCyz_ESM_005_map','lat_IAP','dep_gamma','time_ann_IAP')
      % #########################################################################
      % ###################################################################
      % STMW cell in SA
      hold on 
      [C_STMW_SA,h_STMW_SA]=contour(lat_IAP(1:75,1),dep_gamma(1:end,1),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,1:75,65:84,4),4),3),3,2)./1e6,[-2 -2],'k--');
      set(h_STMW_SA,'color',[0.929, 0.694, 0.125],'linewidth',3.0);
      v_STMW_SA = -2;
      clabel(C_STMW_SA,h_STMW_SA,v_STMW_SA,'labelspacing',600,'fontsize',16,'color',[0.929, 0.694, 0.125])   
      hold on 

      AMOCyz_AAIW = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_AAIW (gamma_ATL_ann_map<=26.5) = NaN;
      hold on 
      [C_AAIW_cell,h_AAIW_cell]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_AAIW,4,2)./1e6,[ 9  9],'k-');
      set(h_AAIW_cell,'color',[.8 .1 .1],'linewidth',4.0);
      v_AAIW_cell = 9;
      clabel(C_AAIW_cell,h_AAIW_cell,v_AAIW_cell,'labelspacing',1500,'fontsize',16,'color',[.8 .2 .2])   

      % STMW cell in NA
      AMOCyz_STMW_NA = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_STMW_NA (gamma_ATL_ann_map>=26.65) = NaN;
      hold on 
      [C_STMW_NA,h_STMW_NA]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_STMW_NA,4,2)./1e6,[ 9.5  9.5],'k-');
      set(h_STMW_NA,'color',[0.929, 0.694, 0.125],'linewidth',3.0);
      v_STMW_NA = [];
      clabel(C_STMW_NA,h_STMW_NA,v_STMW_NA,'labelspacing',1500,'fontsize',18,'color',[0.929, 0.694, 0.125])  

      % My AUTO ARROW FACTORY 
      % AAIW Cell
      annotation('arrow', [ixs+ixw+ixd+(C_AAIW_cell(1,53)+77)/147.*ixw       ixs+ixw+ixd+(C_AAIW_cell(1,54)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,53))/2500.*iyw  iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,54))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);
      annotation('arrow', [ixs+ixw+ixd+(C_AAIW_cell(1,121)+77)/147.*ixw      ixs+ixw+ixd+(C_AAIW_cell(1,122)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,121))/2500.*iyw iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,122))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);
      annotation('arrow', [ixs+ixw+ixd+(C_AAIW_cell(1,234)+77)/147.*ixw      ixs+ixw+ixd+(C_AAIW_cell(1,235)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,234))/2500.*iyw iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,235))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);
      annotation('arrow', [ixs+ixw+ixd+(C_AAIW_cell(1,322)+77)/147.*ixw      ixs+ixw+ixd+(C_AAIW_cell(1,324)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,322))/2500.*iyw iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,324))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);
      annotation('arrow', [ixs+ixw+ixd+(C_AAIW_cell(1,413)+77)/147.*ixw      ixs+ixw+ixd+(C_AAIW_cell(1,414)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,413))/2500.*iyw iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,414))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);  
      annotation('arrow', [ixs+ixw+ixd+(C_AAIW_cell(1,529)+77)/147.*ixw        ixs+ixw+ixd+(C_AAIW_cell(1,530)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,529))/2500.*iyw iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,530))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 24, 'HeadLength',18);  
      annotation('arrow', [ixs+ixw+ixd+(C_AAIW_cell(1,652)+77)/147.*ixw        ixs+ixw+ixd+(C_AAIW_cell(1,653)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,652))/2500.*iyw iys+1*iyw+1*iyd+(2500-C_AAIW_cell(2,653))/2500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 24, 'HeadLength',18);  
                      
      % NA STMW Cell
      annotation('arrow', [ixs+ixw+ixd+(C_STMW_NA(1,2)+77)/147.*ixw         ixs+ixw+ixd+(C_STMW_NA(1,3)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_STMW_NA(2,2))/2500.*iyw  iys+1*iyw+1*iyd+(2500-C_STMW_NA(2,3))/2500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15);  
      annotation('arrow', [ixs+ixw+ixd+(C_STMW_NA(1,46)+77)/147.*ixw        ixs+ixw+ixd+(C_STMW_NA(1,47)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_STMW_NA(2,46))/2500.*iyw iys+1*iyw+1*iyd+(2500-C_STMW_NA(2,47))/2500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15); 
                      
      % NA STMW Cell
      annotation('arrow', [ixs+ixw+ixd+(C_STMW_SA(1,117)+77)/147.*ixw         ixs+ixw+ixd+(C_STMW_SA(1,118)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_STMW_SA(2,117))/2500.*iyw  iys+1*iyw+1*iyd+(2500-C_STMW_SA(2,118))/2500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15);  
      annotation('arrow', [ixs+ixw+ixd+(C_STMW_SA(1,151)+77)/147.*ixw         ixs+ixw+ixd+(C_STMW_SA(1,152)+77)/147.*ixw],...
                          [iys+1*iyw+1*iyd+(2500-C_STMW_SA(2,151))/2500.*iyw  iys+1*iyw+1*iyd+(2500-C_STMW_SA(2,152))/2500.*iyw],...
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
              dep_max_strf = round(nanmean(dep_max_strf(:,1),2));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dep_gamma(dep_max_strf(lat_num,1),1),'-+','MarkerSize',10);
              set(line_max_strf,'color',[.6 .6 .6], 'LineWidth', 3.0);
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 dep_max_strf
      % ################################################################### 
      

      % ###################################################################
      % Add text on Subtropical and Subpolar Cells, and IW
      text( 22.0, 140, 'STMW','fontsize',14,'FontWeight','normal');
      text(-34.0, 170, 'STMW','fontsize',14,'FontWeight','normal');

      text(-48,   150, 'SAMW and AAIW','fontsize',16,'FontWeight','normal','rotation',-40);
            
      text( 29.5,1250, 'LSW and NADW','fontsize',16,'FontWeight','normal'); 
               
      text(  0,   480,'\Psi_{max}','fontsize',16,'Color', [0.3, 0.3, 0.3])
      % ###################################################################  
      
      
      xlim([-77 70])
      ylim([0 2500])
      set(gca,'XTick',-60:20:80)
      set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0\circ','20\circN','40\circN','60\circN','80\circN'},'FontSize',20)
      set(gca,'YTick',0:500:2500)
      set(gca,'YTickLabel',[],'FontSize',20)
      set(gca,'tickdir','in','box','on')
      grid off
      colormap(gca,color0)
      caxis([34 36]);
      title('b. Atlantic basin salinity (2004-2023)','fontsize',24,'FontWeight','bold')
 

      hBar21 = colorbar('EastOutside');
      get(hBar21, 'Position') ;
      set(hBar21, 'Position', [ixs+2*ixw+ixd+0.010 iys+1*iyw+1*iyd 0.012 1.0*iyw+0*iyd]);
      set(hBar21,'ytick',34:0.5:36,'yticklabel',{'34.0','34.5','35.0','35.5','36.0'},'fontsize',20,'FontName','Arial','LineWidth',1.2,'TickLength',0.055);
      
      ylabel(hBar21, '[ g kg^{-1} ]','rotation',90,'FontSize',20);
% #########################################################################   
    
      

% #########################################################################
   %figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.06; ixe = 0.09;  ixd = 0.015; ixw = (1-ixs-ixe-3*ixd)/4;
   iys = 0.08; iye = 0.06;  iyd = 0.090; iyw = (1-iys-iye-1*iyd)/2;
   pos{11}  = [ixs+0*ixw+0*ixd  iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{12}  = [ixs+1*ixw+1*ixd  iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{13}  = [ixs+2*ixw+2*ixd  iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{14}  = [ixs+3*ixw+3*ixd  iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   
   pos{31}  = [ixs+0*ixw+0*ixd  iys+0.60*iyw+0*iyd ixw 0.40*iyw]; 
   pos{32}  = [ixs+0*ixw+0*ixd  iys+0.00*iyw+0*iyd ixw 0.60*iyw];
   
   pos{41}  = [ixs+1*ixw+1*ixd  iys+0.60*iyw+0*iyd ixw 0.40*iyw]; 
   pos{42}  = [ixs+1*ixw+1*ixd  iys+0.00*iyw+0*iyd ixw 0.60*iyw]; 
   
   pos{51}  = [ixs+2*ixw+2*ixd  iys+0.60*iyw+0*iyd ixw 0.40*iyw];
   pos{52}  = [ixs+2*ixw+2*ixd  iys+0.00*iyw+0*iyd ixw 0.60*iyw];
   
   pos{61}  = [ixs+3*ixw+3*ixd  iys+0.60*iyw+0*iyd ixw 0.40*iyw]; 
   pos{62}  = [ixs+3*ixw+3*ixd  iys+0.00*iyw+0*iyd ixw 0.60*iyw]; 
   
    clear color color0 
    color0=cbrewer('div', 'RdBu', 40,'pchip');
    color0=color0(size(color0,1):-1:1,:);
% #########################################################################
   


% #########################################################################
% #########################################################################
subplot('position',pos{31})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_N_trend./1e6,1,1),'AlphaData',~isnan(AMOCyg_N_trend));
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])   

      
      xlim([-36 70])
      ylim([22.5 26.5])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',[],'FontSize',20)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      %caxis([-2 2]);  
      caxis([-0.08 0.08]);  
      title('c. Meso. mixing trend','fontsize',20,'FontWeight','bold')
      
      % ################################################################### 
      % Only show top, left, and right boundaries
      set(gca,'box','off')              % remove full box
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
      
      
subplot('position',pos{32})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_N_trend./1e6,1,1),'AlphaData',~isnan(AMOCyg_N_trend));
 
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(116:end),nanmean(AMOCyg_ESM_005(116:end,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:114),nanmean(AMOCyg_ESM_005(1:114,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])   

      
      % ###################################################################
      % 26N
      hold on
      line_UP_26N_tri  = plot(26,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(29.5,28.24, '26\circN','fontsize',14,'FontWeight','normal'); 
    
      % 34.5S
      hold on
      line_UP_345S_tri  = plot(-34.5,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.929, 0.694, 0.125], 'MarkerEdgeColor', [0.929, 0.694, 0.125]);
      set(line_UP_345S_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(-31.5,28.24, '34.5\circS','fontsize',14,'FontWeight','normal'); 
      
      % 53N
      hold on
      line_UP_53N_tri  = plot(53,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.466, 0.674, 0.188], 'MarkerEdgeColor', [0.466, 0.674, 0.188]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(56.0,28.24, '53\circN','fontsize',14,'FontWeight','normal'); 
      % ###################################################################
      

      
      % ################################################################### 
      % Density/depth with the max stremfunction
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
      load('plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat','AMOC_SFygtn_ESM_005_LOW')
      AMOC_SFygtn_ESM_005_LOW (AMOC_SFygtn_ESM_005_LOW    ==0) = NaN;
      % 1980-2000
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,41:61,2:5),4),3)./1e6;
      for lat_num = 28:1:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',5);
              set(line_max_strf,'color',[.9 .4 .4], 'LineWidth', 1.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      
      % 2004-2023
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,65:84,2:5),4),3)./1e6;
      for lat_num = 28:1:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',7);
              set(line_max_strf,'color',[0    , 0.447, 0.741], 'LineWidth', 1.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      % ################################################################### 
      
      
      xlim([-36 70])
      ylim([26.5 28.3])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0','20\circN','40\circN','60\circN'},'FontSize',20)
      set(gca,'YTick',26.5:0.5:28.5)
      set(gca,'YTickLabel',{'26.5','27','27.5','28','28.5'},'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      %caxis([-3 3]); 
      caxis([-0.08 0.08]);  
      ylabel('                              Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
      xlabel(' Latitude ','color','k','fontsize',18) 
      %title('c. Air-sea flux changes','fontsize',20,'FontWeight','bold')
      
      
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
% #########################################################################
% #########################################################################    
      


% #########################################################################
% #########################################################################
subplot('position',pos{41})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_V_JCT_trend./1e6,1,1),'AlphaData',~isnan(AMOCyg_V_JCT_trend));

      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])   
  
      
      xlim([-36 70])
      ylim([22.5 26.5])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',[],'FontSize',20)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',[],'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
     %caxis([-2 2]); 
      caxis([-0.08 0.08]);  
       title('d. Vertical mixing trend, temp.','fontsize',20,'FontWeight','bold')
      
      
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
      
      
subplot('position',pos{42})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_V_JCT_trend./1e6,1,1),'AlphaData',~isnan(AMOCyg_V_JCT_trend));

      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(116:end),nanmean(AMOCyg_ESM_005(116:end,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:114),nanmean(AMOCyg_ESM_005(1:114,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])   
        

      % ###################################################################
      % 26N
      hold on
      line_UP_26N_tri  = plot(26,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(29.5,28.24, '26\circN','fontsize',14,'FontWeight','normal'); 
    
      % 34.5S
      hold on
      line_UP_345S_tri  = plot(-34.5,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.929, 0.694, 0.125], 'MarkerEdgeColor', [0.929, 0.694, 0.125]);
      set(line_UP_345S_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(-31.5,28.24, '34.5\circS','fontsize',14,'FontWeight','normal'); 
      
      % 53N
      hold on
      line_UP_53N_tri  = plot(53,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.466, 0.674, 0.188], 'MarkerEdgeColor', [0.466, 0.674, 0.188]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(56.0,28.24, '53\circN','fontsize',14,'FontWeight','normal'); 
      % ###################################################################
      
      
      % ################################################################### 
      % Density/depth with the max stremfunction
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
      load('plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat','AMOC_SFygtn_ESM_005_LOW')
      AMOC_SFygtn_ESM_005_LOW (AMOC_SFygtn_ESM_005_LOW    ==0) = NaN;
      % 1980-2000
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,41:61,2:5),4),3)./1e6;
      for lat_num = 28:1:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',5);
              set(line_max_strf,'color',[.9 .4 .4], 'LineWidth', 1.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      
      % 2004-2023
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,65:84,2:5),4),3)./1e6;
      for lat_num = 28:1:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',7);
              set(line_max_strf,'color',[0    , 0.447, 0.741], 'LineWidth', 1.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      % ################################################################### 
      
      
      xlim([-36 70])
      ylim([26.5 28.3])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0','20\circN','40\circN','60\circN'},'FontSize',20)
      set(gca,'YTick',26.5:0.5:28.5)
      set(gca,'YTickLabel',[],'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
     %caxis([-2 2]); 
      caxis([-0.08 0.08]);  
     %ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
      xlabel(' Latitude ','color','k','fontsize',18) 

     
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
% #########################################################################
% #########################################################################



% #########################################################################
% #########################################################################
subplot('position',pos{51})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_V_JSA_trend./1e6,1,1),'AlphaData',~isnan(AMOCyg_V_JSA_trend));

      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])   

      
      xlim([-36 70])
      ylim([22.5 26.5])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',[],'FontSize',20)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',[],'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-0.08 0.08]);  
      title('e. Vertical mixing trend, salt.','fontsize',20,'FontWeight','bold')
     
      
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
      
      
subplot('position',pos{52})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_V_JSA_trend./1e6,1,1),'AlphaData',~isnan(AMOCyg_V_JSA_trend));

      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(116:end),nanmean(AMOCyg_ESM_005(116:end,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:114),nanmean(AMOCyg_ESM_005(1:114,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])   
             

      % ###################################################################
      % 26N
      hold on
      line_UP_26N_tri  = plot(26,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(29.5,28.24, '26\circN','fontsize',14,'FontWeight','normal'); 
    
      % 34.5S
      hold on
      line_UP_345S_tri  = plot(-34.5,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.929, 0.694, 0.125], 'MarkerEdgeColor', [0.929, 0.694, 0.125]);
      set(line_UP_345S_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(-31.5,28.24, '34.5\circS','fontsize',14,'FontWeight','normal'); 
      
      % 53N
      hold on
      line_UP_53N_tri  = plot(53,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.466, 0.674, 0.188], 'MarkerEdgeColor', [0.466, 0.674, 0.188]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(56.0,28.24, '53\circN','fontsize',14,'FontWeight','normal'); 
      % ###################################################################
      
      
      % ################################################################### 
      % Density/depth with the max stremfunction
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
      load('plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat','AMOC_SFygtn_ESM_005_LOW')
      AMOC_SFygtn_ESM_005_LOW (AMOC_SFygtn_ESM_005_LOW    ==0) = NaN;
      % 1980-2000
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,41:61,2:5),4),3)./1e6;
      for lat_num = 28:1:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',5);
              set(line_max_strf,'color',[.9 .4 .4], 'LineWidth', 1.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      
      % 2004-2023
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,65:84,2:5),4),3)./1e6;
      for lat_num = 28:1:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',7);
              set(line_max_strf,'color',[0    , 0.447, 0.741], 'LineWidth', 1.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      % ################################################################### 
      
      
      xlim([-36 70])
      ylim([26.5 28.3])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0','20\circN','40\circN','60\circN'},'FontSize',20)
      set(gca,'YTick',26.5:0.5:28.5)
      set(gca,'YTickLabel',[],'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
     %caxis([-2 2]); 
      caxis([-0.08 0.08]);  
     %ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
      xlabel(' Latitude ','color','k','fontsize',18) 
     %title('e. Vertical mixing changes','fontsize',20,'FontWeight','bold')
           
     
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
% #########################################################################
% #########################################################################
     
      

% #########################################################################
% #########################################################################
subplot('position',pos{61})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_dM_trend./1e6,1,1),'AlphaData',~isnan(AMOCyg_dM_trend));

      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])                  
      
      xlim([-36 70])
      ylim([22.5 26.5])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',[],'FontSize',20)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',[],'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
     %caxis([-2 2]); 
      caxis([-0.08 0.08]);  
     %ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
     %xlabel(' Latitude ','color','k','fontsize',18) 
      title('f. Volume tendency trend','fontsize',20,'FontWeight','bold')

      
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
      
      
subplot('position',pos{62})
      imagesc(lat_IAP,dens_rag(1:end),smooth2a(AMOCyg_dM_trend./1e6,1,1),'AlphaData',~isnan(AMOCyg_dM_trend));

      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',1.5);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',14,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(116:end),nanmean(AMOCyg_ESM_005(116:end,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:114),nanmean(AMOCyg_ESM_005(1:114,:,2:5),3)./1e6,[9 9],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',1.5);
      v02 = 9;
      clabel(C02,h02,v02,'labelspacing',500,'fontsize',14,'color',[.2 .2 .2])  
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005(:,:,2:5),3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',1.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',800,'fontsize',14,'color',[.2 .2 .2])   

      % ###################################################################
      % 26N
      hold on
      line_UP_26N_tri  = plot(26,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(29.5,28.24, '26\circN','fontsize',14,'FontWeight','normal'); 
    
      % 34.5S
      hold on
      line_UP_345S_tri  = plot(-34.5,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.929, 0.694, 0.125], 'MarkerEdgeColor', [0.929, 0.694, 0.125]);
      set(line_UP_345S_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(-31.5,28.24, '34.5\circS','fontsize',14,'FontWeight','normal'); 
      
      % 53N
      hold on
      line_UP_53N_tri  = plot(53,28.3,'^','MarkerSize',12,'MarkerFaceColor', [0.466, 0.674, 0.188], 'MarkerEdgeColor', [0.466, 0.674, 0.188]);
      set(line_UP_26N_tri,'color',[0.1, 0.1, 0.1], 'LineWidth', 1.5);
      text(56.0,28.24, '53\circN','fontsize',14,'FontWeight','normal'); 
      % ###################################################################
      
      
      % ################################################################### 
      % Density/depth with the max stremfunction
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
      load('plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat','AMOC_SFygtn_ESM_005_LOW')
      AMOC_SFygtn_ESM_005_LOW (AMOC_SFygtn_ESM_005_LOW    ==0) = NaN;
      % 1980-2000
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,41:61,2:5),4),3)./1e6;
      for lat_num = 28:1:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',5);
              set(line_max_strf,'color',[.9 .4 .4], 'LineWidth', 1.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      
      % 2004-2023
      AMOC_ESM_005 = nanmean(nanmean(AMOC_SFygtn_ESM_005_LOW(:,:,65:84,2:5),4),3)./1e6;
      for lat_num = 28:1:160%length(lat_IAP)
          if  sum(isnan(AMOC_ESM_005(:,lat_num))==0) >=1
              max_temp  =  find(AMOC_ESM_005(:,lat_num) == max(AMOC_ESM_005(112:140,lat_num)));
              hold on  
              line_max_strf =plot(lat_IAP(lat_num),dens_rag_005(max_temp,1),'-+','MarkerSize',7);
              set(line_max_strf,'color',[0    , 0.447, 0.741], 'LineWidth', 1.5);
              clear max_temp
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 AMOC_ESM_005
      % ################################################################### 
      
      
      xlim([-36 70])
      ylim([26.5 28.3])
      set(gca,'XTick',-60:20:60)
      set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0','20\circN','40\circN','60\circN'},'FontSize',20)
      set(gca,'YTick',26.5:0.5:28.5)
      set(gca,'YTickLabel',[],'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
     %caxis([-2 2]); 
      caxis([-0.08 0.08]);   
     %ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
      xlabel(' Latitude ','color','k','fontsize',18) 
     %title('f. Volume tendency changes','fontsize',20,'FontWeight','bold')
      
     
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
      
      
      hBar21 = colorbar('EastOutside');
      get(hBar21, 'Position') ;
      set(hBar21, 'Position', [ixs+4*ixw+3*ixd+0.008 iys+0*iyw+0*iyd 0.011 1*iyw+0*iyd]);
      set(hBar21,'ytick',-0.08:0.04:0.08,'yticklabel',{'<-0.08','-0.04','0','0.04','>0.08'},'fontsize',18,'FontName','Arial','LineWidth',1.2,'TickLength',0.05);
      
      ylabel(hBar21, '[ Sv per year ]','rotation',90,'fontsize',18,'FontName','Arial');
% #########################################################################
  
  
% #########################################################################
% #########################################################################    
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/3_Meridional_Transects')

% #########################################################################
% #########################################################################


