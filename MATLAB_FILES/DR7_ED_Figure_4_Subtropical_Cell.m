%% ########################################################################
%% PLOTTING AMOC STREAMFUNCTION AT INTERMEDIATE LAYER, [ Sv ]
%  SIO Argo  data for 2004-2023, 0-2000 m, annual mean of monthly means
%  Ishiiv731 data for 1980-2023, 0-3000 m, annual mean of monthly means
%  IPAv4     data for 1940-2023, 0-2000 m, annual mean of monthly means
%  IPAv4.2   data for 1940-2023, 0-6000 m, annual mean of monthly means
%  EN4-ESM   data for 1940-2023, 0-5500 m, annual mean of monthly means

% #########################################################################
% #########################################################################



% #########################################################################
% #########################################################################
%% Subtropical Cell Strength
% #########################################################################
clc; clear
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction')
load plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_2_AMOC_IW_v2_12Mon.mat
% #########################################################################
% #########################################################################
      
    
% #########################################################################
% #########################################################################
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.06; ixe = 0.11;  ixd = 0.11; ixw = (1-ixs-ixe-1*ixd)/2;
   iys = 0.10; iye = 0.10;  iyd = 0.12; iyw = (1-iys-iye-0*iyd)/1;
   pos{31}  = [ixs          iys+0*iyw+0*iyd   ixw      1.0*iyw+0*iyd]; 
   pos{41}  = [ixs+ixw+ixd  iys+0*iyw+0*iyd   ixw+0.08 1.0*iyw+0*iyd]; 
  
   
% ######################################################################### 
    clear color color0 
    color0=cbrewer('div', 'RdBu', 40,'pchip');
    color0=color0(size(color0,1):-1:1,:);
% #########################################################################


% #########################################################################
% Option 2: Lat-Depth of Density 
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/3_Meridional_Transects/')
load(['cal_ATL_Basin_Zonal_TS_Density_and_AAIW_Vol_OHC_V6_1_Zonal_TS_Gam_OHC_Vol_1_IAPv42_20042023.mat'],...
      'gamma_ATL_ann','dep_IAP','lat_IAP')
  
gamma_ATL_ann     = nanmean(   gamma_ATL_ann(:,:,:),3);

% Interpolate to regular depth intervals to enable mapping correctly
[lat_org,depth_org]  = meshgrid(lat_IAP, dep_IAP);
[lat0,depth0]        = meshgrid(lat_IAP, (5:5:6000)');
gamma_ATL_ann_map    = griddata(lat_org,depth_org,   gamma_ATL_ann(:,:)',lat0,depth0,'linear');
clear lat0 depth0  gamma_ATL_ann
% #########################################################################
    

subplot('position',pos{31})
      imagesc(lat_IAP,(5:5:6000)',(gamma_ATL_ann_map),'AlphaData',~isnan(gamma_ATL_ann_map));

      
      % ################################################################### 
      % Subtropical Cell: MW [24 26.5]
      hold on
      [C21,h21]=contour(lat_IAP(:,1),(5:5:6000)',gamma_ATL_ann_map,[24 24],'k-');
      set(h21,'color',[0.929, 0.694, 0.125],'linewidth',2.0);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',600,'fontsize',16,'color',[0.929, 0.694, 0.125])  
      hold on
      [C21,h21]=contour(lat_IAP(:,1),(5:5:6000)',gamma_ATL_ann_map,[26.5 26.5],'k-');
      set(h21,'color',[0.929, 0.694, 0.125],'linewidth',2.0);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',600,'fontsize',16,'color',[0.929, 0.694, 0.125])  
      
      % RAPID 26N 0-6000 m / bottom
      hold on 
      line_IW_26N = plot(26*ones(length((5:5:6000)')),(5:5:6000)');
      set(line_IW_26N,'linestyle','--','color',[0.3, 0.3, 0.3],'linewidth',2.0);
      hold on 
      line_UP_26N_tri  = plot(26,1970,'^','MarkerSize',16,'MarkerFaceColor', [0.9, 0.1, 0.1],       'MarkerEdgeColor', [0.2, 0.2, 0.2]);
      set(line_UP_26N_tri,'color',[0.9, 0.1, 0.1], 'LineWidth', 1.5);      
      text(27.0,1960, 'RAPID (26\circN)','fontsize',18,'FontWeight','normal'); 

      % Subtropical Cell: IW [26.6 27.6]
      hold on
      [C21,h21]=contour(lat_IAP(:,1),(5:5:6000)',gamma_ATL_ann_map,[26.6 26.6],'k-');
      set(h21,'color',[0    , 0.447, 0.741],'linewidth',2.0);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',600,'fontsize',16,'color',[0    , 0.447, 0.741])    
      hold on
      [C21,h21]=contour(lat_IAP(:,1),(5:5:6000)',gamma_ATL_ann_map,[27.6 27.6],'k-');
      set(h21,'color',[0    , 0.447, 0.741],'linewidth',2.0);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',600,'fontsize',16,'color',[0    , 0.447, 0.741]) 
      
      
      % Subpolar Cell: DW [27.6 28]
      hold on
      [C21,h21]=contour(lat_IAP(:,1),(5:5:6000)',gamma_ATL_ann_map,[27.9 27.9],'k-');
      set(h21,'color',[0.301, 0.745, 0.933],'linewidth',2.0);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',600,'fontsize',16,'color',[0.301, 0.745, 0.933])    
      hold on
      [C21,h21]=contour(lat_IAP(:,1),(5:5:6000)',gamma_ATL_ann_map,[28 28],'k-');
      set(h21,'color',[0.301, 0.745, 0.933],'linewidth',2.0);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',600,'fontsize',16,'color',[0.301, 0.745, 0.933]) 
      % ###################################################################
      
      
      
      % ###################################################################
      % AMOC Streamfunction in Depth Space
      % #########################################################################
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
      cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')
      load('cal_AMOC_Streamfunction_V4_ESM_Observations_Z_Convt_ESM.mat','AMOCyz_ESM_005_map','lat_IAP','dep_gamma','time_ann_IAP')
      % #########################################################################
      % ###################################################################
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
      set(h_STMW_NA,'color',[0.929, 0.694, 0.125],'linewidth',4.0);
      v_STMW_NA = [];
      clabel(C_STMW_NA,h_STMW_NA,v_STMW_NA,'labelspacing',1500,'fontsize',18,'color',[0.929, 0.694, 0.125])  

      % My AUTO ARROW FACTORY 
      % AAIW Cell
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_AAIW_cell(1,123)+0)/70.*ixw   ixs+0*ixw+0*ixd+(C_AAIW_cell(1,124)+0)/70.*ixw],...
                          [iys+0*iyw+0*iyd+(2000-C_AAIW_cell(2,124))/2000.*iyw  iys+0*iyw+0*iyd+(2000-C_AAIW_cell(2,123))/2000.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_AAIW_cell(1,234)+0)/70.*ixw   ixs+0*ixw+0*ixd+(C_AAIW_cell(1,235)+0)/70.*ixw],...
                          [iys+0*iyw+0*iyd+(2000-C_AAIW_cell(2,234))/2000.*iyw  iys+0*iyw+0*iyd+(2000-C_AAIW_cell(2,235))/2000.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_AAIW_cell(1,322)+0)/70.*ixw   ixs+0*ixw+0*ixd+(C_AAIW_cell(1,324)+0)/70.*ixw],...
                          [iys+0*iyw+0*iyd+(2000-C_AAIW_cell(2,322))/2000.*iyw  iys+0*iyw+0*iyd+(2000-C_AAIW_cell(2,324))/2000.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_AAIW_cell(1,413)+0)/70.*ixw   ixs+0*ixw+0*ixd+(C_AAIW_cell(1,414)+0)/70.*ixw],...
                          [iys+0*iyw+0*iyd+(2000-C_AAIW_cell(2,413))/2000.*iyw  iys+0*iyw+0*iyd+(2000-C_AAIW_cell(2,414))/2000.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 4,'Linestyle','-','HeadWidth', 22, 'HeadLength',20);  
       
      % NA STMW Cell
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_STMW_NA(1,2)+0)/70.*ixw       ixs+0*ixw+0*ixd+(C_STMW_NA(1,3)+0)/70.*ixw],...
                          [iys+0*iyw+0*iyd+(2000-C_STMW_NA(2,2))/2000.*iyw      iys+0*iyw+0*iyd+(2000-C_STMW_NA(2,3))/2000.*iyw],...
                          'Color', [0.3, 0.3, 0.3], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15);  
      annotation('arrow', [ixs+0*ixw+0*ixd+(C_STMW_NA(1,46)+0)/70.*ixw      ixs+0*ixw+0*ixd+(C_STMW_NA(1,47)+0)/70.*ixw],...
                          [iys+0*iyw+0*iyd+(2000-C_STMW_NA(2,46))/2000.*iyw     iys+0*iyw+0*iyd+(2000-C_STMW_NA(2,47))/2000.*iyw],...
                          'Color', [0.3, 0.3, 0.3], 'LineWidth', 2,'Linestyle','-','HeadWidth', 18, 'HeadLength',15); 
      % ################################################################### 
      
      
      % ###################################################################
      % Add text on Subtropical and Subpolar Cells, and IW
      text( 15.0,100, 'Subtropical Cell','fontsize',18,'FontWeight','normal');
      text( 25.0,170, 'STMW','fontsize',18,'FontWeight','normal');

      text(0.5,500, 'Antarctic Intermediate Water','fontsize',22,'FontWeight','normal');
      
      text(0.5,1300, 'LSW and NADW','fontsize',22,'FontWeight','normal'); 
      % ###################################################################      
%       

      xlim([0 70])
      ylim([0 2000])
      set(gca,'XTick',0:10:80)
      set(gca,'XTickLabel',{'0^o','10^oN','20^oN','30^oN','40^oN','50^oN','60^oN','70^oN','80^oN'},'FontSize',20)
      set(gca,'YTick',0:400:2000)
      set(gca,'YTickLabel',{'0','400','800','1200','1600','2000'},'FontSize',20)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.1,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([25 29]);
      title('a. Atlantic Basin Neutral Density (2004-2023)','fontsize',24,'FontWeight','bold')

      ylabel(['Depth [m]'])  
     
  hBar1 = colorbar('EastOutside');
  get(hBar1, 'Position') ;
  set(hBar1, 'Position', [ixs+1*ixw+0*ixd+0.010 iys+0.25*iyw-0.5*iyd 0.013 0.5*iyw+1*iyd]);
  set(hBar1,'ytick',25:1:29,'yticklabel',{'25','26','27','28','29'},'fontsize',20,'FontName','Arial','LineWidth',1.2,'TickLength',0.042);

  ylabel(hBar1, '[ kg m^{-3} ]','rotation',90);
% #########################################################################




% #########################################################################
subplot('position',pos{41})

    % #####################################################################
    % AMOC Upper Subtroppical Cell 
    AMOC_time_subtropical_MW_005(:,1) = NaN; % Remove IAPv4 data
    AMOC_main(:,1)       =    runmean(nanmean(AMOC_time_subtropical_MW_005(:,1:5),2),7)';
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = NaN;
    line_ESM_STIW        = plot(time_ann_IAP,AMOC_main);    
    set(line_ESM_STIW,'color',[0.929, 0.694, 0.125],'LineWidth',5.0,'linestyle','-');
    clear AMOC_main AMOC_edge
    
    % #################################################################
    % Patching of STD of AMOC-UP (IW layer)
    % STD of 15-Year running mean AMOC ESM
    for k = 1: size(AMOC_time_subtropical_MW_005,2)
        AMOC_time_max_ESM_15_yr(:,k) = runmean(AMOC_time_subtropical_MW_005(:,k),7);
    end 
    AMOC_time_max_ESM_15_yr(65:84,3) = runmean(AMOC_time_subtropical_MW_005(65:84,3),7);
    AMOC_time_max_ESM_15_yr(16:84,4) = runmean(AMOC_time_subtropical_MW_005(16:84,4),7);

    % Standard Deviation of Each Year, Given by All Products Available
    for year=1:length(time_ann_IAP)
        AMOC_time(:,1)=AMOC_time_max_ESM_15_yr(year,:)';
        count=1;
        for k=1:size(AMOC_time_max_ESM_15_yr,2)
            if isnan(AMOC_time(k,1))==0
               AMOC_time_noNaN(count,1)=AMOC_time(k,1);
               count=count+1;
            end
        end
        clear count k AMOC_time
        AMOC_time_max_ESM_std(year,1)=std(AMOC_time_noNaN(:,1),1,1);
        clear AMOC_time_noNaN
    end
    % Pacthing of 2*STD
    AMOC_time_max_ESM_2std(:,1)=nanmean(AMOC_time_max_ESM_15_yr(:,:),2)+AMOC_time_max_ESM_std.*1;
    AMOC_time_max_ESM_2std(:,2)=nanmean(AMOC_time_max_ESM_15_yr(:,:),2)-AMOC_time_max_ESM_std.*1;
    clear AMOC_time_max_ESM_std AMOC_time_max_ESM_15_yr
    hp1=patch([time_ann_IAP(9:end-7,1)' fliplr(time_ann_IAP(9:end-7,1)')],[AMOC_time_max_ESM_2std(9:end-7,2)' fliplr(AMOC_time_max_ESM_2std(9:end-7,1)')],'b');
    set(hp1,'facecolor',[0.5, 0.8, 0.85],'edgecolor','none','FaceAlpha',0.6)
    clear AMOC_time_max_ESM_2std
    hold on
    % #################################################################

    
    
    % #####################################################################
    % #####################################################################
    % AMOC Subtropical Intermediate Water 
    hold on
    AMOC_main(:,1)       = runmean(nanmean(AMOC_time_subtropical_MW_005(:,2),2),7)';
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = NaN;
    line_IW_IAPv42       = plot(time_ann_IAP,AMOC_main);    
    set(line_IW_IAPv42,'color',[0.850, 0.325, 0.098],'LineWidth',2.0,'linestyle','-');
    clear AMOC_main
        
    hold on
    AMOC_main(65:84,1)   = runmean(nanmean(AMOC_time_subtropical_MW_005(65:84,3),2),7)';
    AMOC_main(1:64)      = NaN;
    AMOC_main(end-6:end) = NaN;
    line_IW_RG18         = plot(time_ann_IAP,AMOC_main);    
    set(line_IW_RG18,'color',[0.635, 0.078, 0.184],'LineWidth',2.0,'linestyle','-');
    clear AMOC_main   
    
    hold on
    AMOC_main(16:84,1)   = runmean(nanmean(AMOC_time_subtropical_MW_005(16:84,4),2),7)';
    AMOC_main(1:15)      = NaN;
    AMOC_main(end-6:end) = NaN;
    line_IW_Ishii        = plot(time_ann_IAP,AMOC_main);    
    set(line_IW_Ishii,'color',[0.466, 0.674, 0.188],'LineWidth',2.0,'linestyle','-');
    clear AMOC_main
    
    hold on
    AMOC_main(:,1)       = runmean(nanmean(AMOC_time_subtropical_MW_005(:,5),2),7)';
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = NaN;
    line_IW_EN4          = plot(time_ann_IAP,AMOC_main);    
    set(line_IW_EN4,'color',[0.5, 0.5, 0.5],'LineWidth',2.0,'linestyle','-');
    clear AMOC_main
    
    % Ensemble Mean
    hold on
    AMOC_main(:,1)       = runmean(nanmean(AMOC_time_subtropical_MW_005(:,2:5),2),7)';
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = NaN;
    line_ESM_STIW        = plot(time_ann_IAP,AMOC_main);    
    set(line_ESM_STIW,'color',[0.929, 0.694, 0.125],'LineWidth',6.0,'linestyle','-');
    clear AMOC_main
    % #####################################################################
    % #####################################################################
    


    
    % #####################################################################    
    leg=legend([line_ESM_STIW line_IW_IAPv42 line_IW_RG18 line_IW_Ishii line_IW_EN4],...
                  'Subtropical cell strength, Ensemble mean',...
                  'Subtropical cell strength, IAPv4.2',...
                  'Subtropical cell strength, Argo',...
                  'Subtropical cell strength, Ishii',...
                  'Subtropical cell strength, EN4-ESM',...
                  'Location','northeast','fontsize',16,'Orientation','vertical','NumColumns',1); %line_IW_IAPv4 'AMOC-upper limb, IAPv4',...
    set(leg,'fontsize',19)
    hold on
    %title(leg,'AMOC Strength','fontsize',20','color','k')
    legend('boxoff')
    % #####################################################################


    xlim([1948 2020])
    ylim([17 29.0]);
    set(gca,'XTick',1950:10:2020)
    set(gca,'XTickLabel',{'1950','1960','1970','1980','1990','2000','2010','2020'},'fontsize',22)
    set(gca,'YTick',17:2:29)
    set(gca,'YTickLabel',{'17','19','21','23','25','27','29'},'fontsize',22)
    grid on
    set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
    ylabel('[ Sv ]','color','k','fontsize',22) % left y-axis
    xlabel(' Year ','color','k','fontsize',22) 
    title('b. Subtropical Cell Strength','color','k','fontsize',24)
% #########################################################################
 
 
% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
% #########################################################################
% #########################################################################



