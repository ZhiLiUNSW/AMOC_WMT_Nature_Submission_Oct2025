%% ########################################################################
%% PLOTTING AMOC STREAMFUNCTION AT INTERMEDIATE LAYER, [ Sv ]
%  SIO Argo  data for 2004-2023, 0-2000 m, annual mean of monthly means
%  Ishiiv731 data for 1955-2023, 0-3000 m, annual mean of monthly means
%  IPAv4     data for 1940-2023, 0-2000 m, annual mean of monthly means
%  IPAv4.2   data for 1940-2023, 0-6000 m, annual mean of monthly means
%  EN4-ESM   data for 1940-2023, 0-5500 m, annual mean of monthly means
% #########################################################################
% #########################################################################


% #########################################################################
% #########################################################################
%%  Plotting 1.0 - AMOC Upper Limb Strength and Subpolar Strength, 26N, 26.6 <= gamma <= 28.0 -- 0.05 bins
%   Density to depth cordinate conversion
clc;clear
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
load plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat


cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')
load('cal_AMOC_Streamfunction_V4_ESM_Observations_Z_Convt_ESM.mat','AMOCyz_ESM_005_map','lat_IAP','dep_gamma','time_ann_IAP')

  
% #########################################################################
% #########################################################################
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.045; ixe = 0.02;  ixd = 0.11; ixw = (1-ixs-ixe-1*ixd)/2;
   iys = 0.120; iye = 0.12;  iyd = 0.12; iyw = (1-iys-iye-1*iyd)/2;
   pos{11}  = [ixs          iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{21}  = [ixs+ixw+ixd  iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{31}  = [ixs          iys+0*iyw+0*iyd   ixw 2.0*iyw+1*iyd]; 
   pos{41}  = [ixs+ixw+ixd  iys+0*iyw+0*iyd   ixw 2.0*iyw+1*iyd]; 
  
   
% ######################################################################### 
    clear color color0 
    color0=cbrewer('div', 'RdBu', 40,'pchip');
    color0=color0(size(color0,1):-1:1,:);
% #########################################################################


% #########################################################################
% Option 2: AMOC Streamfunction within 70S-70N
subplot('position',pos{31})
      imagesc(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005,3)./1e6,'AlphaData',~isnan(nanmean(AMOCyg_ESM_005,3)));
      
      
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005,3)./1e6,-20:10:-10,'k-');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005,3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005,3)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_ESM_005,3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',2.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      

      % ###################################################################
      % Subtropical Cell: MW
      dens_rag_01 = (21.1 :0.1: 28.9)';
      hold on 
      line_STMW = plot(lat_IAP(101:130),dens_rag_01(30)*ones(length(lat_IAP(101:130))));
      set(line_STMW,'linestyle','-','color',[0.929, 0.694, 0.125],'linewidth',3.0);
      hold on 
      line_STMW = plot(lat_IAP(101:130),dens_rag_01(55)*ones(length(lat_IAP(101:130))));
      set(line_STMW,'linestyle','-','color',[0.929, 0.694, 0.125],'linewidth',3.0);
      hold on 
      line_STMW = plot(lat_IAP(101)*ones(length(dens_rag_01(30:55))),dens_rag_01(30:55));
      set(line_STMW,'linestyle','-','color',[0.929, 0.694, 0.125],'linewidth',3.0);
      hold on 
      line_STMW = plot(lat_IAP(130)*ones(length(dens_rag_01(30:55))),dens_rag_01(30:55));
      set(line_STMW,'linestyle','-','color',[0.929, 0.694, 0.125],'linewidth',3.0);

      % 26N
      hold on 
      line_IW_26N      = plot(26*ones(length(dens_rag_01(56:70))),dens_rag_01(56:70));
      set(line_IW_26N,'linestyle','--','color',[0.9, 0.1, 0.1],'linewidth',3.0);
      hold on
      line_UP_26N_tri  = plot(26,27.2,'^','MarkerSize',13,'MarkerFaceColor', 'none', 'MarkerEdgeColor', [0.9, 0.1, 0.1]);
      set(line_UP_26N_tri,'color',[0.9, 0.1, 0.1], 'LineWidth', 3.5);
      text(28.0,27.20, '26\circN','fontsize',17,'FontWeight','normal'); 
    
      % 34.5S
      hold on 
      line_IW_345S      = plot(-34.5*ones(length(dens_rag_01(56:70))),dens_rag_01(56:70));
      set(line_IW_345S,'linestyle','--','color',[0.2, 0.7, 0.2],'linewidth',3.0);
      hold on
      line_UP_345S_tri  = plot(-34.5,27.25,'^','MarkerSize',13,'MarkerFaceColor', 'none', 'MarkerEdgeColor', [0.2, 0.7, 0.2]);
      set(line_UP_345S_tri,'color',[0.2, 0.7, 0.2], 'LineWidth', 3.5);
      text(-32.5,27.25, '34.5\circS','fontsize',17,'FontWeight','normal'); 
      
      
      % Subtropical Cell: IW
      hold on 
      line_STIW = plot(lat_IAP(101:130),dens_rag_01(56)*ones(length(lat_IAP(101:130))));
      set(line_STIW,'linestyle','-','color',[0    , 0.447, 0.741],'linewidth',3.0);
      hold on 
      line_STIW = plot(lat_IAP(101:130),dens_rag_01(70)*ones(length(lat_IAP(101:130))));
      set(line_STIW,'linestyle','-','color',[0    , 0.447, 0.741],'linewidth',3.0);
      hold on 
      line_STIW = plot(lat_IAP(101)*ones(length(dens_rag_01(56:70))),dens_rag_01(56:70));
      set(line_STIW,'linestyle','-','color',[0    , 0.447, 0.741],'linewidth',3.0);
      hold on 
      line_STIW = plot(lat_IAP(130)*ones(length(dens_rag_01(56:70))),dens_rag_01(56:70));
      set(line_STIW,'linestyle','-','color',[0    , 0.447, 0.741],'linewidth',3.0);
      
      
      % Subpolar Cell: DW
      hold on 
      line_SPDW = plot(lat_IAP(131:150),dens_rag_01(56)*ones(length(lat_IAP(131:150))));
      set(line_SPDW,'linestyle','-','color',[0.301, 0.745, 0.933],'linewidth',3.0);
      hold on 
      line_SPDW = plot(lat_IAP(131:150),dens_rag_01(70)*ones(length(lat_IAP(131:150))));
      set(line_SPDW,'linestyle','-','color',[0.301, 0.745, 0.933],'linewidth',3.0);
      hold on 
      line_SPDW = plot(lat_IAP(131)*ones(length(dens_rag_01(56:70))),dens_rag_01(56:70));
      set(line_SPDW,'linestyle','-','color',[0.301, 0.745, 0.933],'linewidth',3.0);
      hold on 
      line_SPDW = plot(lat_IAP(150)*ones(length(dens_rag_01(56:70))),dens_rag_01(56:70));
      set(line_SPDW,'linestyle','-','color',[0.301, 0.745, 0.933],'linewidth',3.0);
      % ###################################################################
      
      
      
      % ###################################################################
      % Add an arrow annotation [x_start x_end] and [y_start y_end]
      % Subpolar Cell from AAIW to NADW
      annotation('arrow', [ixs+0.10*ixw ixs+0.30*ixw], [iys+0.55*iyw iys+0.55*iyw],'Color', [0.635, 0.078, 0.184], 'LineWidth', 8,'HeadWidth', 22, 'HeadLength',25);
      annotation('arrow', [ixs+0.52*ixw ixs+0.66*ixw], [iys+0.55*iyw iys+0.55*iyw],'Color', [0.635, 0.078, 0.184], 'LineWidth', 6,'HeadWidth', 20, 'HeadLength',25);
     
      % Transformation from subtropical/intermediate water to LSW
      annotation('arrow', [ixs+0.81*ixw ixs+0.91*ixw], [iys+0.55*iyw iys+0.40*iyw],'Color', [0.635, 0.078, 0.184], 'LineWidth', 4,'HeadWidth', 15, 'HeadLength',20);
      annotation('arrow', [ixs+0.915*ixw ixs+0.885*ixw], [iys+0.38*iyw iys+0.28*iyw],'Color', [0.635, 0.078, 0.184], 'LineWidth', 4,'HeadWidth', 13, 'HeadLength',15);
      
      annotation('arrow', [ixs+0.30*ixw ixs+0.15*ixw], [iys+0.25*iyw iys+0.25*iyw],'Color', [0.635, 0.078, 0.184], 'LineWidth', 6,'HeadWidth', 20, 'HeadLength',25);
      annotation('arrow', [ixs+0.66*ixw ixs+0.52*ixw], [iys+0.25*iyw iys+0.25*iyw],'Color', [0.635, 0.078, 0.184], 'LineWidth', 6,'HeadWidth', 20, 'HeadLength',25);
     
      
      % Subtropical Cell
      annotation('arrow', [ixs+0.03*ixw ixs+0.15*ixw], [iys+1.35*iyw iys+1.35*iyw],'Color', [0.635, 0.078, 0.184], 'LineWidth', 4,'HeadWidth', 20, 'HeadLength',25);
      annotation('arrow', [ixs+0.54*ixw ixs+0.64*ixw], [iys+1.37*iyw iys+1.37*iyw],'Color', [0.635, 0.078, 0.184], 'LineWidth', 4,'HeadWidth', 20, 'HeadLength',25);
      % Transformation from surafce water to subtropical water
      annotation('arrow', [ixs+0.65*ixw ixs+0.74*ixw], [iys+1.35*iyw iys+0.95*iyw],'Color', [0.635, 0.078, 0.184], 'LineWidth', 4,'HeadWidth', 20, 'HeadLength',25);
      
      annotation('arrow', [ixs+0.74*ixw ixs+0.60*ixw], [iys+0.68*iyw iys+0.68*iyw],'Color', [0.635, 0.078, 0.184], 'LineWidth', 4,'HeadWidth', 20, 'HeadLength',25,'linestyle','-');
      
      
      % Equatorial Cell
      annotation('arrow', [ixs+0.40*ixw ixs+0.30*ixw], [iys+1.65*iyw+iyd iys+1.65*iyw+iyd],'Color', [0    , 0.447, 0.741], 'LineWidth', 4,'HeadWidth', 15, 'HeadLength',20);
      annotation('arrow', [ixs+0.30*ixw ixs+0.40*ixw], [iys+1.30*iyw+iyd iys+1.30*iyw+iyd],'Color', [0    , 0.447, 0.741], 'LineWidth', 4,'HeadWidth', 15, 'HeadLength',20);
      % ###################################################################  
      
 
      % ###################################################################
      % Add text on Subtropical and Subpolar Cells, and IW
      text(-30.5,23.10, 'Equatorial Cell','fontsize',19,'FontWeight','normal');
      
      text( 10.0,24.20, 'Subtropical Cell','fontsize',19,'FontWeight','normal');
      text( 23.0,26.30, 'STMW','fontsize',19,'FontWeight','normal');

      text(-45.0,27.03, 'Antarctic Intermediate Water','fontsize',19,'FontWeight','normal');
      
      text( 27.5,27.85, 'LSW and NADW','fontsize',19,'FontWeight','normal'); 
      % ###################################################################
      
      
      
      xlim([-60 70])
      ylim([21.5 28.5])
      set(gca,'XTick',-60:20:80)
      set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0','20\circN','40\circN','60\circN'},'FontSize',22)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',22)
      set(gca,'tickdir','in','box','on')
      grid off
     %grid on
     %set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-20 20]);  
      ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',22) % left y-axis
      xlabel(' Latitude ','color','k','fontsize',22) 
      title('a. AMOC streamfunction in density space','fontsize',24,'FontWeight','bold')


      hBar21 = colorbar('EastOutside');
      get(hBar21, 'Position') ;
      set(hBar21, 'Position', [ixs+1*ixw+0*ixd+0.008 iys+0.5*iyw+0*iyd 0.013 1.0*iyw+1*iyd]);
      set(hBar21,'ytick',-25:5:25,'yticklabel',{'<-25','<-20','-15','-10','-5','0','5','10','15','>20','>25'},'fontsize',21,'FontName','Arial','LineWidth',1.2,'TickLength',0.045);
      
     %ylabel(hBar21, '[ Sv ]','rotation',90);
     text(70.5,22.65, '[ Sv ]','fontsize',21,'FontWeight','normal');
% #########################################################################
  

% #########################################################################
% Inset map in bottom right corner of bottom panel
% #########################################################################

% Define inset position
inset_pos = [ixs+0.68*ixw iys+1.60*iyw+iyd 0.315*ixw 0.38*iyw];  % [left bottom width height]

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

        m_text(-67, 20, 'ATL.','FontSize',14)
% #########################################################################
% #########################################################################



% #########################################################################
% #########################################################################
% AMOC Streamfunction in Depth Coordinate
subplot('position',pos{41})
%       imagesc(lat_IAP,dep_gamma(1:end),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3),4,2)./1e6,'AlphaData',~isnan(nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3)));
      
    % Compute AMOC streamfunction mean
      % Define stretched vertical coordinate
      dep_stretch          = dep_gamma; 
      dep_stretch(1:150)   = 2 .* dep_gamma(1:150);         % stretch upper 1500 m
      dep_stretch(151:end) = linspace(3010,5995,length(dep_gamma)-150)';

      % Plot using pcolor (respects uneven grid)
      pcolor(lat_IAP,-dep_stretch,smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3),4,2)./1e6)
      shading interp
      
      
      % ################################################################### 
      % RAPID 26N 0-6000 m / bottom
      hold on 
      line_IW_26N = plot(26*ones(length((5:10:6000)')),-(5:10:6000)');
      set(line_IW_26N,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);
      text(27.0,-5500, 'RAPID (26\circN)','fontsize',16,'FontWeight','normal'); 
      
      % OSNAP 53N 0-6000 m / bottom
      hold on 
      line_IW_53N = plot(53*ones(length((5:10:6000)')),-(5:10:6000)');
      set(line_IW_53N,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);
      text(54.0,-5500, 'OSNAP','fontsize',16,'FontWeight','normal'); 
      
      % SAMBA 34.5S 0-6000 m / bottom
      hold on 
      line_IW_345S = plot(-34.5*ones(length((5:10:6000)')),-(5:10:6000)');
      set(line_IW_345S,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.0);
      text(-33.5,-5500, 'SAMBA (34.5\circS)','fontsize',16,'FontWeight','normal'); 
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
      
      load(['cal_AMOC_Streamfunction_V4_ESM_Observations_Z_Convt_3_ISHII_Annual_Gam_19552023.mat'],...
            'gamma_ATL_ann','dep_Ishii','lat_Ishii')
      gamma_ATL_ann = nanmean(gamma_ATL_ann(:,:,50:69),3);
      [lat_org,depth_org]  = meshgrid(lat_Ishii, dep_Ishii);
      [lat0,depth0]        = meshgrid(lat_IAP, (5:10:6000)');
      gamma_ATL_ann_map(:,:,2)    = griddata(lat_org,depth_org,   gamma_ATL_ann(:,:)',lat0,depth0,'linear');
      clear lat_org depth_org lat0 depth0 gamma_ATL_ann
      gamma_ATL_ann_map = nanmean(gamma_ATL_ann_map,3);
      
      % Subtropical Cell: IW [26.6 27.6]
      hold on
      [C21,h21]=contour(lat_IAP(:,1),-dep_stretch,gamma_ATL_ann_map,[26.6 26.6],'k-');
      set(h21,'color',[.4 .4 .4],'linewidth',1.5);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',600,'fontsize',16,'color',[.4 .4 .4])    
      hold on
      [C21,h21]=contour(lat_IAP(:,1),-dep_stretch,gamma_ATL_ann_map,[27.6 27.6],'k-');
      set(h21,'color',[.4 .4 .4],'linewidth',1.5);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',600,'fontsize',16,'color',[.4 .4 .4]) 
      
      % Subpolar Cell: DW [27.6 28]
      hold on
      [C21,h21]=contour(lat_IAP(:,1),-dep_stretch,gamma_ATL_ann_map,[28.0 28.0],'k-');
      set(h21,'color',[.4 .4 .4],'linewidth',1.5);
      v21=25.0:0.5:29.0;
      clabel(C21,h21,v21,'labelspacing',600,'fontsize',16,'color',[.4 .4 .4]) 
      % ###################################################################
     
      
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,-dep_stretch(1:end),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3),3,2)./1e6,-20:10:-10,'k--');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,-dep_stretch(1:end),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3),3,2)./1e6,[-2 -2],'k--');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      
      % AABW is clear in ISHII data
      [C012,h012]=contour(lat_IAP(1:30,1),-dep_stretch(1:end),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,1:30,65:84,4),4),3),1,1)./1e6,[-1 -1],'k--');
      set(h012,'color',[0    , 0.447, 0.741],'linewidth',3.0);
      v012=-1;
      clabel(C012,h012,v012,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])  
      % AABW is clear in ISHII data
      [C012,h012]=contour(lat_IAP(1:75,1),-dep_stretch(1:end),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,1:75,65:84,4),4),3),1,1)./1e6,[-2 -2],'k--');
      set(h012,'color',[0    , 0.447, 0.741],'linewidth',3.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])  
      
      hold on 
      [C02,h02]=contour(lat_IAP,-dep_stretch(1:end),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3),3,2)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .1 .1],'linewidth',3.0);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,-dep_stretch(1:end),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,:,65:84,:),4),3),3,2)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',2.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',2000,'fontsize',16,'color',[.2 .2 .2])  
      
      hold on 
      [C02,h02]=contour(lat_IAP,-dep_stretch(1:end),smooth2a(nanmean(nanmean(AMOCyz_ESM_005_map(:,:,21:40,:),4),3),3,2)./1e6,[10 10],'k-');
      set(h02,'color',[0.929, 0.694, 0.125],'linewidth',3.0);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      
      
      % ###################################################################
      % Add text on Subtropical and Subpolar Cells, and IW
      % text( 15.0,100, 'Subtropical Cell','fontsize',20,'FontWeight','normal');
      text( 20.0,-250, 'STMW','fontsize',16,'FontWeight','normal');

      text(-43,-1200, 'Antarctic Intermediate Water','fontsize',19,'FontWeight','normal');
            
      text( 17,-2500, 'LSW and NADW','fontsize',18,'FontWeight','normal'); 
      
      text(-82,-3000, 'AABW','fontsize',18,'FontWeight','normal','Rotation',- 80,'color','[.2 .4 .6]');
      % ###################################################################   

      
      % ###################################################################  
      text(  0,  - 540,'>','fontsize',30,'Rotation',    0,'color',[.4 .2 .2]);
      text( 48,  - 240,'>','fontsize',30,'Rotation',   10,'color',[.4 .2 .2]);
      text( 48,  -1500,'>','fontsize',30,'Rotation',- 100,'color',[.4 .2 .2]);
      text(  0,  -2380,'>','fontsize',30,'Rotation',- 180,'color',[.4 .2 .2]);
      text(-38,  - 540,'>','fontsize',30,'Rotation',-  60,'color',[.4 .2 .2]);
      text(-51,  -1500,'>','fontsize',30,'Rotation',- 255,'color',[.4 .2 .2]);
      
      text( 22,  -  80,'>','fontsize',20,'Rotation',    0,'color',[.4 .2 .2]);
      text( 27,  - 440,'>','fontsize',20,'Rotation',- 180,'color',[.4 .2 .2]);
      
      text( 64.5,-1500,'>','fontsize',30,'Rotation',- 100,'color',[.4 .2 .2]);
      text(  0,  -4350,'>','fontsize',30,'Rotation',- 170,'color',[.4 .2 .2]);
      % ################################################################### 
      

      xlim([-90 70])
      set(gca,'XTick',-80:20:80)
      set(gca,'XTickLabel',{'80\circS','60\circS','40\circS','20\circS','0','20\circN','40\circN','60\circN'},'FontSize',22)
      
      ylim([-6000 0])
      % Real Y-Ticks are: dep_gamma(1:25:151); dep_gamma(151): ((5995-1505)./300).*50: dep_gamma(end)
      set(gca,'YTick',-6000:500:0) 
      set(gca,'YTickLabel',{'6000','5250','4500','3750','3000','2250','1500','1250','1000','750','500','250','0'},'FontSize',22)
      
      set(gca,'tickdir','in','box','on')
      grid off

      clear color color0 
      color0=cbrewer('div', 'RdBu', 40,'pchip');
      color0=color0(size(color0,1):-1:1,:);
      
      colormap(gca,color0)
      caxis([-20 20]);  
      ylabel('Depth [ m ]','color','k','fontsize',22) % left y-axis
      xlabel(' Latitude ','color','k','fontsize',22) 
      title('b. AMOC streamfunction in depth space','fontsize',24,'FontWeight','bold')

% #########################################################################
% #########################################################################
    

% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction_Z_convt/')
% #########################################################################
% #########################################################################


