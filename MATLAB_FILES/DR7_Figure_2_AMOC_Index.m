%% ########################################################################
%% AMOC Index Based on SST, SSS, Subsurface Temp
%    SST
%    Met Office HadISSTv1,NOAA ERSSTv5,ERA5 SST,IAPv4 Temp
%    Monthly SST, 1870-2023


%% ########################################################################
%% ########################################################################
%% SST from Met Office HadISST, ERSSTv5, ERA5, IAPv4 
clc;clear

% #########################################################################
% #########################################################################
%cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/3_Meridional_Transects/')
load(['cal_ATL_Basin_Zonal_TS_Density_and_AAIW_Vol_OHC_V6_1_Zonal_TS_Gam_OHC_Vol_1_IAPv42_Annual_19402023.mat'],...
      'CT_ATL_ann','SA_ATL_ann','dep_IAP','lat_IAP','time_ann','dep_IAP')
  
    % #####################################################################
    % linear trend during 1960-2023
    % Using annual mean TS
    for i=1:size(CT_ATL_ann,1)
        disp(['  linear trend# lon#',num2str(i),' #IAPv4.2 TS'])
        for j=1:size(CT_ATL_ann,2)
            % 1960-2023
            p1=polyfit(21:84,squeeze(CT_ATL_ann(i,j,21:84))',1);
            CT_ann_trend(i,j)=p1(1);
            clear p1
            % 1960-2023
            p1=polyfit(21:84,squeeze(SA_ATL_ann(i,j,21:84))',1);
            SA_ann_trend(i,j)=p1(1);
            clear p1
        end
    end
    clear i j time  
    % #####################################################################
% #########################################################################
% #########################################################################
    
    
% ######################################################################### 
figure('Color',[1 1 1]);  %create a new figure of white color background
ixs = 0.03; ixe = 0.01; ixd = 0.09; ixw = (1-ixs-ixe-2*ixd)/3;
iys = 0.15; iye = 0.13; iyd = 0.11; iyw = (1-iys-iye-1*iyd)/2;
pos{11}  = [ixs+0.0*ixw+0*ixd   iys+1*iyw+1*iyd  ixw+0.1*ixw 1*iyw]; 
pos{12}  = [ixs+1.1*ixw+1*ixd   iys+1*iyw+1*iyd  ixw-0.1*ixw 1*iyw]; 
pos{13}  = [ixs+2.0*ixw+2*ixd   iys+1*iyw+1*iyd  ixw+0.0*ixw 1*iyw]; 

pos{21}  = [ixs+0.0*ixw+0*ixd   iys+0*iyw+0*iyd  ixw+0.1*ixw 1.0*iyw];
pos{22}  = [ixs+1.1*ixw+1*ixd   iys+0*iyw+0*iyd  ixw-0.1*ixw 1.0*iyw];
pos{23}  = [ixs+2.0*ixw+2*ixd   iys+0*iyw+0*iyd  ixw+0.0*ixw 1.0*iyw];
% ######################################################################### 


% #########################################################################
subplot('position',pos{11})
% SST trend map
%cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/1_AMOC_SST_Index')
load('plot_AMOC_Index_V4_ESM_SST_Proxy_1_HadISST_18702023.mat','SST_ann_trend','lon_hadisst','lat_hadisst')
% #########################################################################

        m_proj('robinson','lon',[-180 180],'lat',[-80 80]); 
        m_pcolor(lon_hadisst,lat_hadisst,(SST_ann_trend').*100);
        shading flat
        hold on
        m_grid('box','on','tickdir','in','linestyle','none','LineWidth',1.5,'ticklen',0.01,'fontsize',16,...
                    'xticklabels',[],'xaxislocation','bottom','xtick',[-180:120:180],'Rotation',0,...
                    'yaxislocation','left','ytick',[-60:30:60]);
        m_coast('patch',[0.7 0.7 0.7],'edgecolor',[0.6 0.6 0.6]); 
        hold on;
        m_text(-100,-90,'60\circW','fontsize',16)
        m_text(  40,-90,'60\circE','fontsize',16)
        
        clear color color0 
        color=cbrewer('seq', 'Blues', 15,'pchip');
        color0( 1:12,:) = color(14:-1:3,:);

        color=cbrewer('seq', 'YlOrRd', 35,'pchip');
        color0(13:36,:) = color(2:1:25,:);
        colormap(gca,color0)
        caxis([-0.5 1.0]);
        title('a. SST trend, 1870-2023','fontsize',19,'FontWeight','bold')
        grid on
        
        
        % #########################################################################
        % Subpolar NA Warming Pool
        SST_index_mask=SST_ann_trend;
        SST_index_mask(SST_index_mask>0)=10;
        SST_index_mask(1:121,:) = NaN; SST_index_mask(163:end,:) = NaN;
        SST_index_mask(:,1:137) = NaN; SST_index_mask(:,156:180) = NaN;
        hold on;
        [C21,h21]=m_contour(lon_hadisst,lat_hadisst,smooth2a(SST_index_mask,0,0)',[0 0],'color',[0, 0.447, 0.741],'linewidth',4.0);
        v21=[0:0:0];
        clabel(C21,h21,v21,'labelspacing',8000,'fontsize',21)
        % #########################################################################
        
        hBar11 = colorbar('EastOutside');
        get(hBar11, 'Position') ;
        set(hBar11, 'Position', [ixs+1.1*ixw+0.004 iys+1.1*iyw+1.0*iyd 0.008 0.8*iyw]);
        set(hBar11,'ytick',-0.5:0.5:1.0,'yticklabel',{'-0.5','0','0.5','1.0'},'fontsize',16,'FontName','Arial','LineWidth',1.2,'TickLength',0.055);
        ylabel(hBar11, '[ \circC per century ]','rotation',90,'fontsize',16,'FontName','Arial');
% #########################################################################
        

     
% #########################################################################
subplot('position',pos{13}) 
    time_18542022(:,1)=(1854:1:2023-1);
        line00=plot(time_18542022,ones(length(time_18542022),1).*0);
        set(line00,'color',[.5 .5 .5],'LineWidth',1,'linestyle','--');
        text(1860+(2023-1860)*0.02, -0.8+(0.8+1.2)*0.455, '2004?2023 baseline','fontsize',14)

        % #################################################################
        cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/1_AMOC_SST_Index')
        load('plot_AMOC_Index_V4_ESM_SST_Proxy_1_HadISST_18702023.mat','SST_Index','','time_ann')
        hold on
        SST_main              = SST_Index - nanmean(SST_Index(end-19:end,1),1); clear SST_Index
        SST_main0             = smoothdata(SST_main,'movmean', 15); 
        SST_main1             = smoothdata(SST_main,'LOWESS',  15); 
        SST_main0(1:8)        = NaN;
        SST_main0(end-6:end)  = SST_main1(end-6:end,1); clear SST_main1
        SST_main              = SST_main0;              clear SST_main0 
        
        line_hadisst          = plot(time_ann,SST_main); clear SST_main
        set(line_hadisst,'color',[0.850, 0.325, 0.098],'LineWidth',6,'linestyle','-');
        % #################################################################
        
        
        % #################################################################
        cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/1_AMOC_SST_Index')
        load('plot_AMOC_Index_V4_ESM_SST_Proxy_2_ERSSTv5_18542023.mat','SST_Index','time_ann')
        hold on
        SST_main              = SST_Index - nanmean(SST_Index(end-19:end,1),1); clear SST_Index
        SST_main0             = smoothdata(SST_main,'movmean', 15); 
        SST_main1             = smoothdata(SST_main,'LOWESS',  15); 
        SST_main0(1:8)        = NaN;
        SST_main0(end-6:end)  = SST_main1(end-6:end,1); clear SST_main1
        SST_main              = SST_main0;              clear SST_main0 
        
        line_ersst            = plot(time_ann,SST_main); clear SST_main
        set(line_ersst,'color',[0.929, 0.694, 0.125],'LineWidth',6,'linestyle','-');
        % #################################################################
        
        
        % #################################################################
        cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/1_AMOC_SST_Index')
        load('plot_AMOC_Index_V4_ESM_SST_Proxy_3_ERA5_19402023.mat','SST_Index','time_ann')
        hold on
        SST_main              = SST_Index - nanmean(SST_Index(end-19:end,1),1); clear SST_Index
        SST_main0             = smoothdata(SST_main,'movmean', 15); 
        SST_main1             = smoothdata(SST_main,'LOWESS',  15); 
        SST_main0(1:8)        = NaN;
        SST_main0(end-6:end)  = SST_main1(end-6:end,1); clear SST_main1
        SST_main              = SST_main0;              clear SST_main0 
        
        line_era5             = plot(time_ann,SST_main); clear SST_main
        set(line_era5,'color',[0.301, 0.745, 0.933],'LineWidth',6,'linestyle','-');
        % #################################################################

        
        % #################################################################
        cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/1_AMOC_SST_Index')
        load('plot_AMOC_Index_V4_ESM_SST_Proxy_4_IAPv42_19402023.mat','SST_Index_5m','SST_Index_1000m','time_ann')
        hold on
        SST_main              = SST_Index_5m - nanmean(SST_Index_5m(end-19:end,1),1); clear SST_Index_5m
        SST_main0             = smoothdata(SST_main,'movmean', 15); 
        SST_main1             = smoothdata(SST_main,'LOWESS',  15); 
        SST_main0(1:8)        = NaN;
        SST_main0(end-6:end)  = SST_main1(end-6:end,1); clear SST_main1
        SST_main              = SST_main0;              clear SST_main0 
        
        line_iap5m            = plot(time_ann,SST_main); clear SST_main
        set(line_iap5m,'color',[0.4, 0.4, 0.4],'LineWidth',4,'linestyle','-');
        

        SST_main              = SST_Index_1000m - nanmean(SST_Index_1000m(end-19:end,1),1); clear SST_Index_1000m
        SST_main0             = smoothdata(SST_main,'movmean', 15); 
        SST_main1             = smoothdata(SST_main,'LOWESS',  15); 
        SST_main0(1:8)        = NaN;
        SST_main0(end-6:end)  = SST_main1(end-6:end,1); clear SST_main1
        SST_main              = SST_main0;              clear SST_main0 
        
        line_iap1000m         = plot(time_ann,SST_main); clear SST_main
        set(line_iap1000m,'color',[0.6, 0.6, 0.6],'LineWidth',3,'linestyle','-');
        % #################################################################
       

        legend([line_hadisst line_ersst line_era5 line_iap5m line_iap1000m],...
               'HadISSTv1','ERSSTv5','ERA5','IAPv4.2 T 5 m','IAPv4.2 T 5-1000 m','Location','southwest','NumColumns',2,'fontsize',14)
        hold on
        legend('boxoff','fontsize',14)

        
        xlim([1860 2023.5])
        set(gca,'XTick',1860:20:2020)
        set(gca,'XTickLabel',{'1860','1980','1900','1920','1940','1960','1980','2000','2020'},'fontsize',16)
        ylim([-0.8 1.2]);
        set(gca,'YTick',-0.8:0.4:1.2)
        set(gca,'YTickLabel',{'-0.8','-0.4','0','0.4','0.8','1.2'},'fontsize',16,'YAxisLocation','left')
        grid off
        set(gca,'GridColor',[.9 .9 .9],'GridAlpha',0.1,'GridLineStyle','-')
        ylabel('[ \circC ]','color','k','fontsize',16) % left y-axis
        xlabel([' Year '],'FontSize',18)  
        title('c. SST-based indice','fontsize',19,'color','k','FontWeight','bold')
% #########################################################################
% #########################################################################




% #########################################################################
% #########################################################################
% Annual Mean Salinity from IAPv4.2
time_ann(:,1)=(1940:2023)';
   cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/1_AMOC_SST_Index/') 
   load('plot_AMOC_Index_V4_ESM_SST_SSS_Proxy_plus_Transects_1_SSS_IAPv42.mat','SSS_index','SSS_ann_trend','lon_IAP','lat_IAP')
% #########################################################################
    

% #########################################################################
% Annual Mean Salinity from EN4
time_ann(:,1)=(1940:2023)';
   cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/1_AMOC_SST_Index/') 
   load('plot_AMOC_Index_V4_ESM_SST_SSS_Proxy_plus_Transects_2_SSS_EN4.mat','SSS_index_EN4','lon_EN4','lat_EN4')
% #########################################################################
    

% #########################################################################
% Annual Mean Salinity from Ishii
time_ann_ISHII(:,1)=(1955:2023)';
   cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/1_AMOC_SST_Index/') 
   load('plot_AMOC_Index_V4_ESM_SST_SSS_Proxy_plus_Transects_3_SSS_Ishii.mat','SSS_index_Ishii','lon_Ishii','lat_Ishii')
% #########################################################################
    

% #########################################################################
subplot('position',pos{21})
        m_proj('robinson','lon',[-180 180],'lat',[-80 80]); 
        m_pcolor(lon_IAP,lat_IAP,(SSS_ann_trend').*100);
        shading flat
        
        % #################################################################
        hold on 
        m_plot((lon_IAP(1,1):1:lon_IAP(360,1))',lat_IAP(56).*ones(length((lon_IAP(1,1):1:lon_IAP(360,1))'),1),'color',[0.3, 0.3, 0.3],'linewidth',3.0);
        hold on 
        m_plot((lon_IAP(1,1):1:lon_IAP(360,1))',lat_IAP(80).*ones(length((lon_IAP(1,1):1:lon_IAP(360,1))'),1),'color',[0.3, 0.3, 0.3],'linewidth',3.0);
        
        hold on 
        m_plot((lon_IAP(111,1):1:lon_IAP(200,1))',lat_IAP(56).*ones(length((lon_IAP(111,1):1:lon_IAP(200,1))'),1),'color',[0, 0.447, 0.741],'linewidth',3.5);
        hold on 
        m_plot((lon_IAP(111,1):1:lon_IAP(200,1))',lat_IAP(80).*ones(length((lon_IAP(111,1):1:lon_IAP(200,1))'),1),'color',[0, 0.447, 0.741],'linewidth',3.5);
        hold on 
        m_plot(lon_IAP(111).*ones(length((lat_IAP(56,1):1:lat_IAP(80,1))'),1),(lat_IAP(56,1):1:lat_IAP(80,1))','color',[0, 0.447, 0.741],'linewidth',3.5);
        hold on 
        m_plot(lon_IAP(200).*ones(length((lat_IAP(56,1):1:lat_IAP(80,1))'),1),(lat_IAP(56,1):1:lat_IAP(80,1))','color',[0, 0.447, 0.741],'linewidth',3.5);
        % #################################################################
        
        
        hold on
        m_grid('box','on','tickdir','in','linestyle','none','LineWidth',1.5,'ticklen',0.01,'fontsize',16,...
                    'xticklabels',[],'xaxislocation','bottom','xtick',[-180:120:180],'Rotation',0,...
                    'yaxislocation','left','ytick',[-60:30:60]);
        m_coast('patch',[0.7 0.7 0.7],'edgecolor',[0.6 0.6 0.6]); %'xticklabels',[],'yticklabels',[],
        hold on;
        m_text(-100,-90,'60\circW','fontsize',16)
        m_text(  40,-90,'60\circE','fontsize',16)
        
        clear color color0 
        color=cbrewer('seq', 'Blues', 20,'pchip');
        color0( 1:18,:) = color(18:-1:1,:);

        color=cbrewer('seq', 'YlOrRd', 20,'pchip');
        color0(19:36,:) = color(1:1:18,:);
        colormap(gca,color0)
        caxis([-0.6 0.6]);
        title('d. SSS trend, 1960-2023','fontsize',19,'FontWeight','bold')
        grid off
        
        
        hBar21 = colorbar('EastOutside');
        get(hBar21, 'Position') ;
        set(hBar21, 'Position', [ixs+1.1*ixw+0.004 iys+0.1*iyw+0*iyd 0.008 0.8*iyw]);
        set(hBar21,'ytick',-0.6:0.3:0.6,'yticklabel',{'-6','-3','0','3','6'},'fontsize',16,'FontName','Arial','LineWidth',1.2,'TickLength',0.055);
        ylabel(hBar21, '[ 10^{-1} g kg^{-1} per century ]','rotation',90,'fontsize',16,'FontName','Arial');
% #########################################################################
        

     
% #########################################################################
subplot('position',pos{23}) 
    time_18542022(:,1)= (1854:1:2023-1);
    time_ann(:,1)     = (1940:1:2023);
        line00=plot(time_18542022,ones(length(time_18542022),1).*0);
        set(line00,'color',[.5 .5 .5],'LineWidth',1,'linestyle','--');
        text(1948+(2023-1948)*0.02, -0.1+(0.1+0.23)*0.355, '2004?2023 baseline','fontsize',14)

        % #################################################################
        hold on
        SSS_main              = SSS_index - nanmean(SSS_index(end-19:end,1),1); clear SST_Index
        SSS_main0             = smoothdata(SSS_main,'movmean', 15); 
        SSS_main1             = smoothdata(SSS_main,'LOWESS',  15); 
        SSS_main0(1:8)        = NaN;
        SSS_main0(end-6:end)  = SSS_main1(end-6:end,1); clear SSS_main1
        SSS_main              = SSS_main0;              clear SSS_main0 
        
        line_iap              = plot(time_ann, SSS_main); clear SSS_main
        set(line_iap,'color',[0.850, 0.325, 0.098],'LineWidth',6,'linestyle','-');
        % #################################################################
        
  
        % #################################################################
        hold on
        SSS_main              = SSS_index_EN4 - nanmean(SSS_index_EN4(end-19:end,1),1); clear SSS_index_EN4
        SSS_main0             = smoothdata(SSS_main,'movmean', 15); 
        SSS_main1             = smoothdata(SSS_main,'LOWESS',  15); 
        SSS_main0(1:8)        = NaN;
        SSS_main0(end-6:end)  = SSS_main1(end-6:end,1); clear SSS_main1
        SSS_main              = SSS_main0;              clear SSS_main0 
        
        line_en4              = plot(time_ann, SSS_main); clear SSS_main
        set(line_en4,'color',[0.301, 0.745, 0.933],'LineWidth',6,'linestyle','-');
        % #################################################################
        
        
        % #################################################################
        hold on
        SSS_main              = SSS_index_Ishii - nanmean(SSS_index_Ishii(end-19:end,1),1); clear SSS_index_Ishii
        SSS_main0             = smoothdata(SSS_main,'movmean', 15); 
        SSS_main1             = smoothdata(SSS_main,'LOWESS',  15); 
        SSS_main0(1:8)        = NaN;
        SSS_main0(end-6:end)  = SSS_main1(end-6:end,1); clear SSS_main1
        SSS_main              = SSS_main0;              clear SSS_main0 
        
        line_Ishii            = plot(time_ann_ISHII, SSS_main); clear SSS_main
        set(line_Ishii,'color',[0.929, 0.694, 0.125],'LineWidth',6,'linestyle','-');    
        % #################################################################
        
        
        legend([line_iap line_en4 line_Ishii],...
               'IAPv4.2','EN4','Ishii','Location','northeast','NumColumns',1,'fontsize',15)
        hold on
        legend('boxoff','fontsize',15)

        
        xlim([1948 2023.5])
        set(gca,'XTick',1950:10:2020)
        set(gca,'XTickLabel',{'1950','1960','1970','1980','1990','2000','2010','2020'},'fontsize',16)
        ylim([-0.1 0.23]);
        set(gca,'YTick',-0.1:0.1:0.3)
        set(gca,'YTickLabel',{'-0.1','0','0.1','0.2','0.3'},'fontsize',16,'YAxisLocation','left')
        grid off
        set(gca,'GridColor',[.9 .9 .9],'GridAlpha',0.1,'GridLineStyle','-')
        ylabel('[ g kg^{-1} ]','color','k','fontsize',16) % left y-axis
        xlabel([' Year '],'FontSize',16)  
        title('f. SSS-based indice','fontsize',19,'color','k','FontWeight','bold')
% #########################################################################
% #########################################################################



% #########################################################################
% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/3_Meridional_Transects/')
load(['cal_ATL_Basin_Zonal_TS_Density_and_AAIW_Vol_OHC_V6_1_Zonal_TS_Gam_OHC_Vol_1_IAPv42_Annual_19402023.mat'],...
      'CT_ATL_ann','SA_ATL_ann','dep_IAP','lat_IAP','time_ann','dep_IAP')

    % #####################################################################
    clear color color0 
    color=cbrewer('div', 'RdBu', 12,'pchip');
    color0(1:size(color,1),:)=color(size(color,1):-1:1,:);
    color0(2:6,:)=(color0(2:6,:)+color0(1:5,:))./2;
    color0(6,:)=(color0(6,:)+color0(5,:))./2;
    % #####################################################################

  
% ######################################################################### 
% CT
subplot('position',pos{12})
      imagesc(lat_IAP,dep_IAP(1:201,1),(CT_ann_trend(:,1:201).*100)','AlphaData',~isnan((CT_ann_trend(:,1:201))'));

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
      % STMW Cell in SA
      hold on 
      [C_STMW_SA,h_STMW_SA]=contour(lat_IAP(1:75,1),dep_gamma(1:end,1),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,1:75,65:84,4),4),3),3,2)./1e6,[-2 -2],'k-');
      set(h_STMW_SA,'color',[0.301, 0.745, 0.933],'linewidth',1.5);
      v_STMW_SA = [];
      clabel(C_STMW_SA,h_STMW_SA,v_STMW_SA,'labelspacing',600,'fontsize',16,'color',[0.301, 0.745, 0.933])   
      hold on 

      % STMW Cell in NA
      AMOCyz_STMW_NA = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_STMW_NA (gamma_ATL_ann_map>=26.65) = NaN;
      hold on 
      [C_STMW_NA,h_STMW_NA]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_STMW_NA,4,2)./1e6,[ 9.5  9.5],'k-');
      set(h_STMW_NA,'color',[0.301, 0.745, 0.933],'linewidth',1.5);
      v_STMW_NA = [];
      clabel(C_STMW_NA,h_STMW_NA,v_STMW_NA,'labelspacing',1500,'fontsize',18,'color',[0.301, 0.745, 0.933])  

      % AAIW and NADW Cell
      AMOCyz_AAIW = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_AAIW (gamma_ATL_ann_map<=26.5) = NaN;
      hold on 
      [C_AAIW_cell,h_AAIW_cell]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_AAIW,4,2)./1e6,[ 9  9],'k-');
      set(h_AAIW_cell,'color',[.8 .1 .1],'linewidth',2.0);
      v_AAIW_cell = [];
      clabel(C_AAIW_cell,h_AAIW_cell,v_AAIW_cell,'labelspacing',1500,'fontsize',16,'color',[.8 .2 .2])   


      
      % My AUTO ARROW FACTORY 
      % AAIW Cell
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,53)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,54)+65)/135.*0.9*ixw],...
                          [iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,53))/1500.*iyw      iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,54))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,121)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,122)+65)/135.*0.9*ixw],...
                          [iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,121))/1500.*iyw      iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,122))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,234)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,235)+65)/135.*0.9*ixw],...
                          [iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,234))/1500.*iyw      iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,235))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,322)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,324)+65)/135.*0.9*ixw],...
                          [iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,322))/1500.*iyw      iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,324))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,416)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,418)+65)/135.*0.9*ixw],...
                          [iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,416))/1500.*iyw      iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,418))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);  
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,529)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,530)+65)/135.*0.9*ixw],...
                          [iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,529))/1500.*iyw      iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,530))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);                        
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,652)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,653)+65)/135.*0.9*ixw],...
                          [iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,652))/1500.*iyw      iys+1*iyw+1*iyd+(1500-C_AAIW_cell(2,653))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);                   
                      
      % NA STMW Cell
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_STMW_NA(1,2)+65)/135.*0.9*ixw      ixs+1.1*ixw+1*ixd+(C_STMW_NA(1,3)+65)/135.*0.9*ixw],...
                          [iys+1*iyw+1*iyd+(1500-C_STMW_NA(2,2))/1500.*iyw         iys+1*iyw+1*iyd+(1500-C_STMW_NA(2,3))/1500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 8, 'HeadLength',8);  
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_STMW_NA(1,46)+65)/135.*0.9*ixw     ixs+1.1*ixw+1*ixd+(C_STMW_NA(1,47)+65)/135.*0.9*ixw],...
                          [iys+1*iyw+1*iyd+(1500-C_STMW_NA(2,46))/1500.*iyw        iys+1*iyw+1*iyd+(1500-C_STMW_NA(2,47))/1500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 8, 'HeadLength',8); 
                      
      % NA STMW Cell
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_STMW_SA(1,117)+65)/135.*0.9*ixw    ixs+1.1*ixw+1*ixd+(C_STMW_SA(1,118)+65)/135.*0.9*ixw],...
                          [iys+1*iyw+1*iyd+(1500-C_STMW_SA(2,117))/1500.*iyw       iys+1*iyw+1*iyd+(1500-C_STMW_SA(2,118))/1500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 8, 'HeadLength',8);  
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_STMW_SA(1,151)+65)/135.*0.9*ixw    ixs+1.1*ixw+1*ixd+(C_STMW_SA(1,152)+65)/135.*0.9*ixw],...
                          [iys+1*iyw+1*iyd+(1500-C_STMW_SA(2,151))/1500.*iyw       iys+1*iyw+1*iyd+(1500-C_STMW_SA(2,152))/1500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 8, 'HeadLength',8);            
      % ################################################################### 
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
              line_max_strf =plot(lat_IAP(lat_num),dep_gamma(dep_max_strf(lat_num,1),1),'-+','MarkerSize',6);
              set(line_max_strf,'color',[.5 .5 .5], 'LineWidth', 1.0);
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 dep_max_strf
      % ################################################################### 
      
      
      xlim([-65 70])
      ylim([0 1500])
      set(gca,'XTick',-60:30:80)
      set(gca,'XTickLabel',{'60\circS','30\circS','0\circ','30\circN','60\circN'},'FontSize',16)
      set(gca,'YTick',0:500:2000)
      set(gca,'YTickLabel',{'0','500','1000','1500','2000'},'FontSize',16)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.1,'GridLineStyle','-')
      
      clear color color0 
      color=cbrewer('seq', 'Blues', 6,'pchip');
      color0( 1:4,:) = color(6:-1:3,:);

      color=cbrewer('seq', 'YlOrRd', 11,'pchip');
      color0(5:12,:) = color(1:1:8,:);
      colormap(gca,color0)
      caxis([-1 2]);
      title('b. Trend of Atlantic temperature, 1960-2023','fontsize',19,'FontWeight','bold')

      xlabel([' Latitude '],'FontSize',16)  
      ylabel(['Depth [m]'],'FontSize',16)  
     
      hBar12 = colorbar('EastOutside');
      get(hBar12, 'Position') ;
      set(hBar12, 'Position', [ixs+2*ixw+1*ixd+0.006 iys+1.1*iyw+1*iyd 0.008 0.8*iyw+0*iyd]);
      set(hBar12,'ytick',-1:1:2,'yticklabel',{'-1','0','1','2'},'fontsize',16,'FontName','Arial','LineWidth',1.2,'TickLength',0.055);
      
      ylabel(hBar12, '[ \circC per century ]','rotation',90,'fontsize',16);
      
      
      
% SA
subplot('position',pos{22})
      imagesc(lat_IAP,dep_IAP(1:201,1),(SA_ann_trend(:,1:201).*100)','AlphaData',~isnan((SA_ann_trend(:,1:201))'));

      % #########################################################################
      % ###################################################################
      % STMW Cell in SA
      hold on 
      [C_STMW_SA,h_STMW_SA]=contour(lat_IAP(1:75,1),dep_gamma(1:end,1),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,1:75,65:84,4),4),3),3,2)./1e6,[-2 -2],'k-');
      set(h_STMW_SA,'color',[0.301, 0.745, 0.933],'linewidth',1.5);
      v_STMW_SA = [];
      clabel(C_STMW_SA,h_STMW_SA,v_STMW_SA,'labelspacing',600,'fontsize',16,'color',[0.301, 0.745, 0.933])   
      hold on 

      % STMW Cell in NA
      AMOCyz_STMW_NA = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_STMW_NA (gamma_ATL_ann_map>=26.65) = NaN;
      hold on 
      [C_STMW_NA,h_STMW_NA]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_STMW_NA,4,2)./1e6,[ 9.5  9.5],'k-');
      set(h_STMW_NA,'color',[0.301, 0.745, 0.933],'linewidth',1.5);
      v_STMW_NA = [];
      clabel(C_STMW_NA,h_STMW_NA,v_STMW_NA,'labelspacing',1500,'fontsize',18,'color',[0.301, 0.745, 0.933])  

      % AAIW and NADW Cell
      AMOCyz_AAIW = nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3);
      AMOCyz_AAIW (gamma_ATL_ann_map<=26.5) = NaN;
      hold on 
      [C_AAIW_cell,h_AAIW_cell]=contour(lat_IAP,dep_gamma(1:end),smooth2a(AMOCyz_AAIW,4,2)./1e6,[ 9  9],'k-');
      set(h_AAIW_cell,'color',[.8 .1 .1],'linewidth',2.0);
      v_AAIW_cell = [];
      clabel(C_AAIW_cell,h_AAIW_cell,v_AAIW_cell,'labelspacing',1500,'fontsize',16,'color',[.8 .2 .2])   

      
      % My AUTO ARROW FACTORY 
      % AAIW Cell
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,53)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,54)+65)/135.*0.9*ixw],...
                          [iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,53))/1500.*iyw      iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,54))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,121)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,122)+65)/135.*0.9*ixw],...
                          [iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,121))/1500.*iyw      iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,122))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,234)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,235)+65)/135.*0.9*ixw],...
                          [iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,234))/1500.*iyw      iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,235))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,322)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,324)+65)/135.*0.9*ixw],...
                          [iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,322))/1500.*iyw      iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,324))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,416)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,418)+65)/135.*0.9*ixw],...
                          [iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,416))/1500.*iyw      iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,418))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);  
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,529)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,530)+65)/135.*0.9*ixw],...
                          [iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,529))/1500.*iyw      iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,530))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);                        
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,652)+65)/135.*0.9*ixw   ixs+1.1*ixw+1*ixd+(C_AAIW_cell(1,653)+65)/135.*0.9*ixw],...
                          [iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,652))/1500.*iyw      iys+0*iyw+0*iyd+(1500-C_AAIW_cell(2,653))/1500.*iyw],...
                          'Color', [0.2, 0.2, 0.2], 'LineWidth', 2,'Linestyle','-','HeadWidth', 12, 'HeadLength',12);                   
                      
      % NA STMW Cell
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_STMW_NA(1,2)+65)/135.*0.9*ixw      ixs+1.1*ixw+1*ixd+(C_STMW_NA(1,3)+65)/135.*0.9*ixw],...
                          [iys+0*iyw+0*iyd+(1500-C_STMW_NA(2,2))/1500.*iyw         iys+0*iyw+0*iyd+(1500-C_STMW_NA(2,3))/1500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 8, 'HeadLength',8);  
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_STMW_NA(1,46)+65)/135.*0.9*ixw     ixs+1.1*ixw+1*ixd+(C_STMW_NA(1,47)+65)/135.*0.9*ixw],...
                          [iys+0*iyw+0*iyd+(1500-C_STMW_NA(2,46))/1500.*iyw        iys+0*iyw+0*iyd+(1500-C_STMW_NA(2,47))/1500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 8, 'HeadLength',8); 
                      
      % NA STMW Cell
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_STMW_SA(1,117)+65)/135.*0.9*ixw    ixs+1.1*ixw+1*ixd+(C_STMW_SA(1,118)+65)/135.*0.9*ixw],...
                          [iys+0*iyw+0*iyd+(1500-C_STMW_SA(2,117))/1500.*iyw       iys+0*iyw+0*iyd+(1500-C_STMW_SA(2,118))/1500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 8, 'HeadLength',8);  
      annotation('arrow', [ixs+1.1*ixw+1*ixd+(C_STMW_SA(1,151)+65)/135.*0.9*ixw    ixs+1.1*ixw+1*ixd+(C_STMW_SA(1,152)+65)/135.*0.9*ixw],...
                          [iys+0*iyw+0*iyd+(1500-C_STMW_SA(2,151))/1500.*iyw       iys+0*iyw+0*iyd+(1500-C_STMW_SA(2,152))/1500.*iyw],...
                          'Color', [0.4, 0.4, 0.4], 'LineWidth', 2,'Linestyle','-','HeadWidth', 8, 'HeadLength',8);            
      % ################################################################### 
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
              line_max_strf =plot(lat_IAP(lat_num),dep_gamma(dep_max_strf(lat_num,1),1),'-+','MarkerSize',6);
              set(line_max_strf,'color',[.5 .5 .5], 'LineWidth', 1.0);
          end
      end
      clear lat_num AMOC_density_max_strf_ESM_20042023 dep_max_strf
      % ################################################################### 
      
      
      xlim([-65 70])
      ylim([0 1500])
      set(gca,'XTick',-60:30:80)
      set(gca,'XTickLabel',{'60\circS','30\circS','0\circ','30\circN','60\circN'},'FontSize',16)
      set(gca,'YTick',0:500:2000)
      set(gca,'YTickLabel',{'0','500','1000','1500','2000'},'FontSize',16)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.1,'GridLineStyle','-')
      
      clear color color0 
      color=cbrewer('seq', 'Blues', 7,'pchip');
      color0( 1:6,:) = color(7:-1:2,:);

      color=cbrewer('seq', 'YlOrRd', 10,'pchip');
      color0(7:12,:) = color(2:1:7,:);
      colormap(gca,color0)
      caxis([-.3 .3]);
      title('e. Trend of Atlantic salinity, 1960-2023','fontsize',19,'FontWeight','bold')

      ylabel(['Depth [m]'],'FontSize',16)  
      xlabel([' Latitude '],'FontSize',16)  

      hBar22 = colorbar('EastOutside');
      get(hBar22, 'Position') ;
      set(hBar22, 'Position', [ixs+2*ixw+1*ixd+0.006 iys+0.1*iyw+0*iyd 0.008 0.8*iyw+0*iyd]);
      set(hBar22,'ytick',-0.3:0.1:0.3,'yticklabel',{'-3','-2','-1','0','1','2','3'},'fontsize',16,'FontName','Arial','LineWidth',1.2,'TickLength',0.055);
      
      ylabel(hBar22, '[ 10^{-1} g kg^{-1} per century ]','rotation',90,'fontsize',16);
      
      
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/1_AMOC_SST_Index')
% #########################################################################
% #########################################################################


