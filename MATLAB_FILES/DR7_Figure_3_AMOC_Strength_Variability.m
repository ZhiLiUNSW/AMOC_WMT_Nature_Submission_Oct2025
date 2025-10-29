%% ########################################################################
%% PLOTTING AMOC STREAMFUNCTION AT INTERMEDIATE LAYER, [ Sv ]
%  SIO Argo  data for 2004-2023, 0-2000 m, annual mean of monthly means
%  Ishiiv731 data for 1980-2023, 0-3000 m, annual mean of monthly means
%  IPAv4     data for 1940-2023, 0-2000 m, annual mean of monthly means
%  IPAv4.2   data for 1940-2023, 0-6000 m, annual mean of monthly means
%  EN4-ESM   data for 1940-2023, 0-5500 m, annual mean of monthly means

% #########################################################################
% #########################################################################



%% #########################################################################
% #########################################################################
clc; clear
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction')
load plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_2_AMOC_IW_v2_12Mon.mat
% #########################################################################
% #########################################################################


% #########################################################################
% #########################################################################
% Plotting 1. - AMOC Upper Limb Strength and Subpolar Strength, 26N, 26.6 <= gamma <= 28.0 -- 0.05 bins
% #########################################################################
% #########################################################################
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.05; ixe = 0.03;  ixd = 0.10; ixw = (1-ixs-ixe-1*ixd)/2;
   iys = 0.10; iye = 0.10;  iyd = 0.12; iyw = (1-iys-iye-1*iyd)/2;
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
      imagesc(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:)./1e6,'AlphaData',~isnan(AMOCyg_ESM_005));
      
      
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:)./1e6,-20:10:-10,'k-');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',2.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      

      % ###################################################################
      % Subtropical Cell: MW
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
      line_UP_26N_tri  = plot(    26,27.2, '^','MarkerSize',13,'MarkerFaceColor', [.2 .2 .2], 'MarkerEdgeColor', [0.9, 0.1, 0.1]);
      set(line_UP_26N_tri,'color',[0.9, 0.1, 0.1], 'LineWidth', 2.0);
      text(28.0,27.20, '26\circN','fontsize',17,'FontWeight','normal'); 
    
      % 34.5S
      hold on 
      line_IW_345S      = plot(-34.5*ones(length(dens_rag_01(56:70))),dens_rag_01(56:70));
      set(line_IW_345S,'linestyle','--','color',[0.2, 0.7, 0.2],'linewidth',3.0);
      hold on
      line_UP_345S_tri  = plot(-34.5,27.25,'^','MarkerSize',13,'MarkerFaceColor', [.2 .2 .2], 'MarkerEdgeColor', [0.2, 0.7, 0.2]);
      set(line_UP_345S_tri,'color',[0.2, 0.7, 0.2], 'LineWidth', 2.0);
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
      title('a. AMOC Streamfunction','fontsize',24,'FontWeight','bold')


      hBar21 = colorbar('EastOutside');
      get(hBar21, 'Position') ;
      set(hBar21, 'Position', [ixs+1*ixw+0*ixd+0.008 iys+0.5*iyw+0*iyd 0.013 1.0*iyw+1*iyd]);
      set(hBar21,'ytick',-25:5:25,'yticklabel',{'<-25','<-20','-15','-10','-5','0','5','10','15','>20','>25'},'fontsize',21,'FontName','Arial','LineWidth',1.2,'TickLength',0.045);
      
     %ylabel(hBar21, '[ Sv ]','rotation',90);
     %text(60.5,22.25, '[ Sv ]','fontsize',22,'FontWeight','normal');
% #########################################################################
  

% #########################################################################
% Inset map in bottom right corner of bottom panel
% #########################################################################
% V4: map of ATL mask
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
subplot('position',pos{41})
    % #####################################################################
    % #####################################################################
    % Annual Mean Streamfunction
    % AMOC at 26N,              Ensemble Mean, 15-Year Running Mean
    AMOC_time_26N_max_ESM_005(:,1) = NaN; % remove IAPv4
    AMOC_main(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005(:,1:5),2),'movmean', 15)'; % Max at 26N
    AMOC_edge(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005(:,1:5),2),'LOWESS',  15)'; % Max at 26N
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = AMOC_edge(end-6:end,1);
    line_ESM_26N         = plot(time_ann_IAP,AMOC_main);                 
    set(line_ESM_26N,'color',[0.850, 0.325, 0.098],'LineWidth',6.5,'linestyle','-');
    clear AMOC_main AMOC_edge
    % #####################################################################
    % #####################################################################
    
    
    
    % #################################################################
    % #################################################################
    % Patching of STD of Annual Mean AMOC Strength
    % AMOC Upper Limb, 10N-40N, Ensemble Mean, 15-Year Running Mean
    AMOC_time_subtropical_IW_005(:,1) = NaN; % Remove IAPv4
    hold on
    % STD of 15-Year running mean AMOC ESM
    for k = 1: size(AMOC_time_subtropical_IW_005,2)
        AMOC_time_15_yr(:,k) =    runmean(AMOC_time_subtropical_IW_005(:,k),7);
    end 
    AMOC_time_15_yr(65:84,3) =    runmean(AMOC_time_subtropical_IW_005(65:84,3),7);
    AMOC_time_15_yr(16:84,4) =    runmean(AMOC_time_subtropical_IW_005(16:84,4),7);

    % Standard Deviation of Each Year, Given by All Products Available
    for year=1:length(time_ann_IAP)
        AMOC_time(:,1)=AMOC_time_15_yr(year,:)';
        count=1;
        for k=1:size(AMOC_time_15_yr,2)
            if isnan(AMOC_time(k,1))==0
               AMOC_time_noNaN(count,1)=AMOC_time(k,1);
               count=count+1;
            end
        end
        clear count k AMOC_time
        AMOC_time_std(year,1)=std(AMOC_time_noNaN(:,1),1,1);
        clear AMOC_time_noNaN
    end
    % Pacthing of 2*STD
    AMOC_time_ESM_std(:,1) = nanmean(AMOC_time_15_yr(:,:),2) + runmean(AMOC_time_std,2);
    AMOC_time_ESM_std(:,2) = nanmean(AMOC_time_15_yr(:,:),2) - runmean(AMOC_time_std,2);
    clear AMOC_time_std AMOC_time_15_yr
    hp1=patch([time_ann_IAP(9:end-6,1)' fliplr(time_ann_IAP(9:end-6,1)')],[AMOC_time_ESM_std(9:end-6,2)' fliplr(AMOC_time_ESM_std(9:end-6,1)')],'b');
    set(hp1,'facecolor',[0    , 0.447, 0.741],'edgecolor','none','FaceAlpha',0.1)
    clear AMOC_time_ESM_std
    hold on
    % #################################################################
    
    
    % #################################################################
    % AMOC Subpolar, 40N-60N, Ensemble Mean, 15-Year Running Mean
    AMOC_time_subpolar_DW_005(:,1) = NaN; % Remove IAPv4
    hold on
    % STD of 15-Year running mean AMOC ESM
    for k = 1: size(AMOC_time_subpolar_DW_005,2)
        AMOC_time_15_yr(:,k) =    runmean(AMOC_time_subpolar_DW_005(:,k),7);
    end 
    AMOC_time_15_yr(65:84,3) =    runmean(AMOC_time_subpolar_DW_005(65:84,3),7);
    AMOC_time_15_yr(16:84,4) =    runmean(AMOC_time_subpolar_DW_005(16:84,4),7);
 
    % Standard Deviation of Each Year, Given by All Products Available
    for year=1:length(time_ann_IAP)
        AMOC_time(:,1)=AMOC_time_15_yr(year,:)';
        count=1;
        for k=1:size(AMOC_time_15_yr,2)
            if isnan(AMOC_time(k,1))==0
               AMOC_time_noNaN(count,1)=AMOC_time(k,1);
               count=count+1;
            end
        end
        clear count k AMOC_time
        AMOC_time_std(year,1)=std(AMOC_time_noNaN(:,1),1,1);
        clear AMOC_time_noNaN
    end
    % Pacthing of 2*STD
    AMOC_time_ESM_std(:,1) = nanmean(AMOC_time_15_yr(:,:),2) + runmean(AMOC_time_std,2);
    AMOC_time_ESM_std(:,2) = nanmean(AMOC_time_15_yr(:,:),2) - runmean(AMOC_time_std,2);
    clear AMOC_time_std AMOC_time_15_yr
    hp2=patch([time_ann_IAP(9:end-6,1)' fliplr(time_ann_IAP(9:end-6,1)')],[AMOC_time_ESM_std(9:end-6,2)' fliplr(AMOC_time_ESM_std(9:end-6,1)')],'b');
    set(hp2,'facecolor',[0.301, 0.845, 0.933],'edgecolor','none','FaceAlpha',0.15)
    clear AMOC_time_ESM_std
    hold on
    % #################################################################
        

    % #################################################################
    % AMOC at 26N, Ensemble Mean, 15-Year Running Mean
    AMOC_time_26N_max_ESM_005(:,1) = NaN; % Remove IAPv4
    hold on
    % STD of 15-Year running mean AMOC ESM
    for k = 1: size(AMOC_time_26N_max_ESM_005,2)
        AMOC_time_15_yr(:,k) =    runmean(AMOC_time_26N_max_ESM_005(:,k),7);
    end 
    AMOC_time_15_yr(65:84,3) =    runmean(AMOC_time_26N_max_ESM_005(65:84,3),7);
    AMOC_time_15_yr(16:84,4) =    runmean(AMOC_time_26N_max_ESM_005(16:84,4),7);

    % Standard Deviation of Each Year, Given by All Products Available
    for year=1:length(time_ann_IAP)
        AMOC_time(:,1)=AMOC_time_15_yr(year,:)';
        count=1;
        for k=1:size(AMOC_time_15_yr,2)
            if isnan(AMOC_time(k,1))==0
               AMOC_time_noNaN(count,1)=AMOC_time(k,1);
               count=count+1;
            end
        end
        clear count k AMOC_time
        AMOC_time_std(year,1)=std(AMOC_time_noNaN(:,1),1,1);
        clear AMOC_time_noNaN
    end
    % Pacthing of 2*STD
    AMOC_time_ESM_std(:,1) = nanmean(AMOC_time_15_yr(:,:),2) + runmean(AMOC_time_std,2);
    AMOC_time_ESM_std(:,2) = nanmean(AMOC_time_15_yr(:,:),2) - runmean(AMOC_time_std,2);
    clear AMOC_time_std AMOC_time_15_yr
    hp3=patch([time_ann_IAP(9:end-6,1)' fliplr(time_ann_IAP(9:end-6,1)')],[AMOC_time_ESM_std(9:end-6,2)' fliplr(AMOC_time_ESM_std(9:end-6,1)')],'b');
    set(hp3,'facecolor',[0.850, 0.325, 0.098],'edgecolor','none','FaceAlpha',0.2)
    clear AMOC_time_ESM_std
    hold on
    % #################################################################

    

    % #####################################################################
    % #####################################################################
    % Hydrographic Sections at 25N, Atkinson at al. (2012)
    % Intermediate 0-1100 m integration
    bar_25N_1957=errorbar((1957+ 9/12)',18.0, 2.9);
    set(bar_25N_1957,'color',[1.0 0.75 0.8], 'LineWidth', 3.0,'linestyle','-');
    hold on
    bar_25N_1981=errorbar((1981+ 7/12)',17.6, 2.9);
    set(bar_25N_1981,'color',[1.0 0.75 0.8], 'LineWidth', 3.0);
    hold on
    bar_25N_1992=errorbar((1992+ 6/12)',18.6, 2.9);
    set(bar_25N_1992,'color',[1.0 0.75 0.8], 'LineWidth', 3.0);
    hold on
    bar_25N_1998=errorbar((1998+ 1/12)',16.8, 2.9);
    set(bar_25N_1998,'color',[1.0 0.75 0.8], 'LineWidth', 3.0);
    hold on
    bar_25N_2004=errorbar((2004+ 3/12)',16.1, 2.9);
    set(bar_25N_2004,'color',[1.0 0.75 0.8], 'LineWidth', 3.0);

    hold on
    line_25N_1957=plot((1957+ 9/12)',18.0,'s','MarkerSize',15,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1957,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on   
    line_25N_1981=plot((1981+ 7/12)',17.6,'s','MarkerSize',15,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1981,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    line_25N_1992=plot((1992+ 6/12)',18.6,'s','MarkerSize',15,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1992,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    line_25N_1998=plot((1998+ 1/12)',16.8,'s','MarkerSize',15,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1998,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    line_25N_2004=plot((2004+ 3/12)',16.1,'s','MarkerSize',15,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_2004,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    % #####################################################################  
    % #####################################################################
    
    
    
    % #########################################################################
    % #########################################################################
    % AMOC Upper Limb, 34.5S, Ensemble Mean, 15-Year Running Mean
    clear AMOC_time_upper_005
    % AMOC Upper Limb Strength in Subtropical and Subpolar Latitudes from WMT-Based Streamfunction 
    % 0.05 Density Bin, Maximum in 10N-40N or 40N-65N, 0.1 smooth window 
      for data_num = 1 : size(AMOC_SFygtn_ESM_005_LOW,4)
          for year = 1 : size(AMOC_SFygtn_ESM_005_LOW,3)
              for lat = 1 : size(AMOC_SFygtn_ESM_005_LOW,2)
                  % Upper Limb Strength, within 26.6 <= gamma <= 28.0 at each latitude
                  AMOC_time_upper_005(lat,year,data_num) =  max(max( AMOC_SFygtn_ESM_005_LOW(112:140, lat, year,data_num)))./1e6;  
              end
          end 
      end
      clear year data_num  

      AMOC_time_upper_005(:,:,1) = NaN; % Remove IAPv4 data
      AMOC_time_upper_005        = squeeze(nanmean(AMOC_time_upper_005(:,:,:),3)); % Ensembl Data Mean
      AMOC_time_upper_345S       = squeeze(AMOC_time_upper_005(56,:))';
    % SAMOC at 34.5S
    hold on
    AMOC_main(:,1)         = smoothdata(squeeze(nanmean(AMOC_time_upper_005(56,:),1)),'movmean', 15);
    AMOC_edge(:,1)         = smoothdata(squeeze(nanmean(AMOC_time_upper_005(56,:),1)),'LOWESS',  15);
    AMOC_main(1:8)         = NaN;
    AMOC_main(end-6:end)   = AMOC_edge(end-6:end,1); clear AMOC_edge
    line_IW_LAT_345S       = plot(time_ann_IAP,AMOC_main);   
    set(line_IW_LAT_345S,'color',[0.2, 0.7, 0.2],'LineWidth',3.5,'linestyle','-');
    clear AMOC_main AMOC_edge AMOC_time_upper_005
    % #####################################################################
    % #####################################################################
    
    
    
    % #####################################################################
    % #####################################################################
    % Satellite Altimetary AMOC from Frajka-Williams 2015 ['http://dx.doi.org/10.1002/2015GL063220']
    cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/')
    load('9_AMOC_Frajka-Williams_2015GRL.mat','recon');
    tme_AMOC_FW2015       = recon.time';
    dates                 = datetime(tme_AMOC_FW2015, 'ConvertFrom', 'datenum');
    tme_AMOC_FW2015       = (1993 :1/12: 2015-1/12)';
    AMOC_FW2015           = recon.mocproxy';
    
    AMOC_FW2015_temp      = smoothdata(AMOC_FW2015(10:246,1),'movmean',60); % 5-Year Running Mean
    AMOC_FW2015(10:246,1) = AMOC_FW2015_temp; clear AMOC_FW2015_temp
    
    hold on
    line_FW2015           = plot(tme_AMOC_FW2015,AMOC_FW2015);
    set(line_FW2015,'color',[0.694, 0.384, 0.556],'LineWidth',  4.0,'linestyle','-');
    clear recon dates AMOC_FW2015 tme_AMOC_FW2015
    % #####################################################################
    % #####################################################################
    

    
    % #####################################################################
    % #####################################################################
    % RAPID AMOC (CORRECTED USING IW LAYER DENSITY)
    hold on
    line_RAPID  =  plot(decimal_year(2:3:end-2,1),amoc_sigma_mon_corr);
    set(line_RAPID,'color',[0.1, 0.1, 0.1],'LineWidth',  4.0,'linestyle','-'); 
    % #####################################################################
    % #####################################################################
    
    
    
    % #####################################################################
    % #####################################################################
    % OSNAP AMOC
    cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/9_AMOC_Subpolar_OSNAP/')
    MOC_OSNAP_Mon          = ncread('OSNAP_MOC_MHT_MFT_TimeSeries_201408_202006_2023.nc','MOC_ALL');
    tme_OSNAP              = (2014+8/12:1/12:2020+6/12)';
    MOC_OSNAP_Mon          = smoothdata(MOC_OSNAP_Mon(1:67,1),'movmean',60); % 5-Year Running Mean
    MOC_OSNAP_Mon(68:71,1) = NaN;
    hold on
    line_OSNAP             = plot(tme_OSNAP,MOC_OSNAP_Mon);
    set(line_OSNAP,'color',[0.6, 0.6, 0.6],'LineWidth',  3.5,'linestyle','-');
    clear tme_OSNAP MOC_OSNAP_Mon
    % #####################################################################
    % #####################################################################

   
    
    % #####################################################################
    % #####################################################################
    % Annual Mean Streamfunction
    % AMOC Upper Limb, 10N-40N, Ensemble Mean, 15-Year Running Mean
    AMOC_time_subtropical_IW_005(:,1) = NaN; % Remove IAPv4
    hold on
    AMOC_main(:,1)       = smoothdata(nanmean(AMOC_time_subtropical_IW_005(:,1:5),2),'movmean', 15)';
    AMOC_edge(:,1)       = smoothdata(nanmean(AMOC_time_subtropical_IW_005(:,1:5),2),'LOWESS',  15)'; % Max at 26N
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = AMOC_edge(end-6:end,1);
    line_ESM_STIW        = plot(time_ann_IAP,AMOC_main);    
    set(line_ESM_STIW,'color',[0    , 0.447, 0.741],'LineWidth',6.0,'linestyle','-');
    clear AMOC_main AMOC_edge
    
    
    % AMOC Subpolar, 40N-60N,   Ensemble Mean, 15-Year Running Mean
    AMOC_time_subpolar_DW_005(:,1) = NaN; % Remove IAPv4
    hold on
    AMOC_main(:,1)       = smoothdata(nanmean(AMOC_time_subpolar_DW_005(:,1:5),2),'movmean', 15)'; % Max at 26N
    AMOC_edge(:,1)       = smoothdata(nanmean(AMOC_time_subpolar_DW_005(:,1:5),2),'LOWESS',  15)'; % Max at 26N
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = AMOC_edge(end-6:end,1);
    line_ESM_SPDW        = plot(time_ann_IAP,AMOC_main);    
    set(line_ESM_SPDW,'color',[0.301, 0.745, 0.933],'LineWidth',6.0,'linestyle','-');
    clear AMOC_main AMOC_edge
    
 
    % AMOC at 26N,              Ensemble Mean, 15-Year Running Mean
    AMOC_time_26N_max_ESM_005(:,1) = NaN; % remove IAPv4
    hold on
    AMOC_main(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005(:,1:5),2),'movmean', 15)'; % Max at 26N
    AMOC_edge(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005(:,1:5),2),'LOWESS',  15)'; % Max at 26N
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = AMOC_edge(end-6:end,1);
    line_ESM_26N         = plot(time_ann_IAP,AMOC_main);                 
    set(line_ESM_26N,'color',[0.850, 0.325, 0.098],'LineWidth',6.5,'linestyle','-');
    clear AMOC_main AMOC_edge
    % #########################################################################
    % #########################################################################
    


    % #####################################################################
    % #####################################################################
    % Hydrographic Sections at 25N, Kanzow at al. (2010)
    % Maximum streamfunction
    hold on
    line_25Nmax_1957=plot((1957+ 9/12)',20.1,'^','MarkerSize',20,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1957,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on   
    line_25Nmax_1981=plot((1981+ 7/12)',17.3,'^','MarkerSize',20,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1981,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on
    line_25Nmax_1992=plot((1992+ 6/12)',18.6,'^','MarkerSize',20,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1992,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on
    line_25Nmax_1998=plot((1998+ 1/12)',18.1,'^','MarkerSize',20,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1998,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on
    line_25Nmax_2004=plot((2004+ 3/12)',17.5,'^','MarkerSize',20,'MarkerFaceColor', [0.494, 0.184, 0.556], 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_2004,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    % #####################################################################  
    % #####################################################################
    
    
    
    % #####################################################################    
    leg=legend([line_ESM_26N line_ESM_STIW line_ESM_SPDW line_IW_LAT_345S line_RAPID line_OSNAP line_FW2015 line_25N_1957 line_25Nmax_1957],...
                  'AMOC at 26\circN',...
                  'AMOC-Up (max. 10\circN-40\circN)',...
                  'AMOC-Up (max. 40\circN-60\circN)',...
                  'AMOC at 34.5\circS',...
                  'RAPID 26\circN array',...
                  'OSNAP subpolar array',...
                  'Satellite altimetry',...
                  'Hydrographic sections at 25\circN',...
                  'Max. streamfunction at 25\circN',...
                  'Location','northeast','fontsize',16,'Orientation','vertical','NumColumns',1); %line_IW_IAPv4 'AMOC-upper limb, IAPv4',...
    set(leg,'fontsize',16)
    hold on
    %title(leg,'AMOC Strength','fontsize',20','color','k')
    legend('boxoff')
    % #####################################################################


    xlim([1948 2023.1])
    ylim([13.1 27.5]);
    set(gca,'XTick',1950:10:2020)
    set(gca,'XTickLabel',{'1950','1960','1970','1980','1990','2000','2010','2020'},'fontsize',22)
    set(gca,'YTick',12:1.5:28)
    set(gca,'YTickLabel',{'12','13.5','15','16.5','18','19.5','21','22.5','24','25.5','27'},'fontsize',22)
    grid off
   %grid on
   %set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.15,'GridLineStyle','-')
    ylabel('[ Sv ]','color','k','fontsize',22) % left y-axis
    xlabel(' Year ','color','k','fontsize',22) 
    title('b. AMOC Upper Limb Strength','color','k','fontsize',24)
       

% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
% #########################################################################
% #########################################################################



