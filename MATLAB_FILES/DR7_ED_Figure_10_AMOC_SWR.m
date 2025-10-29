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
%% 3. AMOC Streamfuction at 26N by Air-Sea Fluxes, SWR Penetration, and Time Series 
clc; clear

% #########################################################################
% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
load plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat
load plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin_noSWR.mat
% #########################################################################
% #########################################################################


% #########################################################################
% #########################################################################
% Plot 3: Comparing air-sea fluxes without SWR penetration
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.045; ixe = 0.02;  ixd = 0.045; ixw = (1-ixs-ixe-2*ixd)/3;
   iys = 0.200; iye = 0.15;  iyd = 0.120; iyw = (1-iys-iye-0*iyd)/1;
   pos{11}  = [ixs+0*ixw+0.0*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   pos{21}  = [ixs+1*ixw+0.6*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   pos{31}  = [ixs+2*ixw+2.0*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
% ######################################################################### 
    clear color color0 
    color0=cbrewer('div', 'RdBu', 40,'pchip');
    color0=color0(size(color0,1):-1:1,:);
% #########################################################################


      
subplot('position',pos{11})
      imagesc(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005,3)./1e6,'AlphaData',~isnan(nanmean(AMOCyg_F_ESM_005,3)));

      
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005,3)./1e6,-20:10:-10,'k-');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005,3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005,3)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005,3)./1e6,[2 2],'k-');
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
      line_IW_26N = plot(26*ones(length(dens_rag_01(56:70))),dens_rag_01(56:70));
      set(line_IW_26N,'linestyle','--','color',[0.3, 0.3, 0.3],'linewidth',2.0);
      text(27.0,27.30, '26\circ N','fontsize',16,'FontWeight','normal'); 
      
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
      
      
      xlim([-25 60])
      ylim([21 28.5])
      set(gca,'XTick',-60:20:80)
      set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0','20\circN','40\circN','60\circN'},'FontSize',22)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',22)

      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-20 20]);  
      ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',22) % left y-axis
      xlabel(' Latitude ','color','k','fontsize',22) 
      title('a. AMOC by air-sea flux (SWRP incl.)','fontsize',22,'FontWeight','bold')


      hBar11 = colorbar('horiz');
      get(hBar11, 'Position') ;
      set(hBar11, 'Position', [ixs+0.5*ixw+0*ixd iys+0*iyw-0.9*iyd 1*ixw+0.4*ixd 0.018]);
      set(hBar11,'ytick',-25:5:25,'yticklabel',{'<-25','<-20','-15','-10','-5','0','5','10','15','>20','>25'},'fontsize',20,'FontName','Arial','LineWidth',1.2,'TickLength',0.030);
      
      ylabel(hBar11, '[ Sv ]','rotation',0,'fontsize',20);

% #########################################################################

    
      

% #########################################################################
   subplot('position',pos{21})
      imagesc(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005_noSWR,3)./1e6,'AlphaData',~isnan(nanmean(AMOCyg_F_ESM_005_noSWR,3)));
 
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005_noSWR,3)./1e6,-20:10:-10,'k-');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005_noSWR,3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005_noSWR,3)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005_noSWR,3)./1e6,[2 2],'k-');
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
      line_IW_26N = plot(26*ones(length(dens_rag_01(56:70))),dens_rag_01(56:70));
      set(line_IW_26N,'linestyle','--','color',[0.3, 0.3, 0.3],'linewidth',2.0);
      text(27.0,27.30, '26\circ N','fontsize',16,'FontWeight','normal'); 
      
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
      
      
      xlim([-25 60])
      ylim([21 28.5])
      set(gca,'XTick',-60:20:80)
      set(gca,'XTickLabel',{'60\circS','40\circS','20\circS','0','20\circN','40\circN','60\circN'},'FontSize',22)
      set(gca,'YTick',21:1:28.5)

      set(gca,'YTickLabel',[],'FontSize',22)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-20 20]);  
      % ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',22) % left y-axis
      xlabel(' Latitude ','color','k','fontsize',22) 
      title('b. AMOC by air-sea flux (SWRP excl.)','fontsize',22,'FontWeight','bold')
% #########################################################################
% #########################################################################
% #########################################################################



      
% #########################################################################
% #########################################################################
subplot('position',pos{31})

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
    

    
    
    % #####################################################################
    % #####################################################################
    % Satellite Altimetary AMOC from Frajka-Williams 2015 ['http://dx.doi.org/10.1002/2015GL063220']
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
    line_RAPID=plot(decimal_year(2:3:end-2,1),amoc_sigma_mon_corr);
    set(line_RAPID,'color',[0.1, 0.1, 0.1],'LineWidth',  4.0,'linestyle','-'); 
    % #####################################################################
    % #####################################################################
    
    
    % #####################################################################
    % #####################################################################
    % OSNAP AMOC
    hold on
    line_OSNAP             = plot(tme_OSNAP,MOC_OSNAP_Mon);
    set(line_OSNAP,'color',[0.6, 0.6, 0.6],'LineWidth',  3.5,'linestyle','-');
    clear tme_OSNAP MOC_OSNAP_Mon
    % #####################################################################
    % #####################################################################

    

    % #####################################################################
    % #####################################################################
    % Ensemble mean of IAPv4, IAPv4.2, EN4-ESM, SIO Argo (2004-), ISHII (1980-)
    % AMOC 26N Max, 15-Year Running Mean
    hold on
    AMOC_time_26N_max_ESM_005_LOW(:,1) = NaN; % remove IAPv4
    AMOC_main(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(:,1:5),2),'movmean', 15)'; 
    AMOC_edge(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(:,1:5),2),'LOWESS',  15)'; 
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = AMOC_edge(end-6:end,1);
    line_ESM_26N         = plot(time_ann_IAP,AMOC_main);                 
    set(line_ESM_26N,'color',[0.850, 0.325, 0.098],'LineWidth',5.0,'linestyle','-');
    clear AMOC_main AMOC_edge

    hold on
    AMOC_time_26N_max_ESM_005_LOW_F(:,1) = NaN; % remove IAPv4
    AMOC_main(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_F(:,1:5),2),'movmean', 15)'; 
    AMOC_edge(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_F(:,1:5),2),'LOWESS',  15)'; 
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = AMOC_edge(end-6:end,1);
    line_ESM_15yr_F      = plot(time_ann_IAP,AMOC_main);    
    set(line_ESM_15yr_F,'color',[0    , 0.447, 0.741],'LineWidth',4.0,'linestyle','-');
    clear AMOC_main
     
    % AMOC 26N Max, 15-Year Running Mean, without SWR penetration
    hold on
    AMOC_time_26N_max_ESM_005_LOW_noSWR(:,1) = NaN; % remove IAPv4
    AMOC_main(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_noSWR(:,1:5),2),'movmean', 15)'; 
    AMOC_edge(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_noSWR(:,1:5),2),'LOWESS',  15)'; 
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = AMOC_edge(end-6:end,1);
    line_ESM_26N_noSWR   = plot(time_ann_IAP,AMOC_main);                 
    set(line_ESM_26N_noSWR,'color',[0.850, 0.325, 0.098],'LineWidth',5.0,'linestyle','-.');
    clear AMOC_main

    hold on
    AMOC_time_26N_max_ESM_005_LOW_F_noSWR(:,1) = NaN; % remove IAPv4
    AMOC_main(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_F_noSWR(:,1:5),2),'movmean', 15)'; 
    AMOC_edge(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_F_noSWR(:,1:5),2),'LOWESS',  15)'; 
    AMOC_main(1:8)       = NaN;
    AMOC_main(end-6:end) = AMOC_edge(end-6:end,1);
    line_ESM_15yr_F_noSWR= plot(time_ann_IAP,AMOC_main);    
    set(line_ESM_15yr_F_noSWR,'color',[0    , 0.447, 0.741],'LineWidth',4.0,'linestyle','-.');
    clear AMOC_main
    % #####################################################################
    % #####################################################################
    
    
    
    % #####################################################################
    % #####################################################################
    % Hydrographic Sections at 25N, Kanzow at al. (2010)
    % Maximum streamfunction
    hold on
    line_25Nmax_1957=plot((1957+ 9/12)',20.1,'^','MarkerSize',20,'MarkerFaceColor', 'none', 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1957,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on   
    line_25Nmax_1981=plot((1981+ 7/12)',17.3,'^','MarkerSize',20,'MarkerFaceColor', 'none', 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1981,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on
    line_25Nmax_1992=plot((1992+ 6/12)',18.6,'^','MarkerSize',20,'MarkerFaceColor', 'none', 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1992,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on
    line_25Nmax_1998=plot((1998+ 1/12)',18.1,'^','MarkerSize',20,'MarkerFaceColor', 'none', 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_1998,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    hold on
    line_25Nmax_2004=plot((2004+ 3/12)',17.5,'^','MarkerSize',20,'MarkerFaceColor', 'none', 'MarkerEdgeColor', [0.494, 0.184, 0.556]);
    set(line_25Nmax_2004,'color',[0.494, 0.184, 0.556], 'LineWidth', 3.5);
    % #####################################################################  
    % #####################################################################
    
    
    
    % #####################################################################    
    leg=legend([line_ESM_26N line_ESM_26N_noSWR line_ESM_15yr_F line_ESM_15yr_F_noSWR line_RAPID line_OSNAP line_FW2015 line_25N_1957 line_25Nmax_1957],...
                  'AMOC at 26\circN        (SWRP included)',...
                  'AMOC at 26\circN        (SWRP excluded)',...
                  'Air-sea flux at 26\circN (SWRP included)',...
                  'Air-sea flux at 26\circN (SWRP excluded)',...
                  'RAPID 26\circN array',...
                  'OSNAP subpolar array',...
                  'Satellite altimetry',...
                  'Hydrographic sections at 25\circN',...
                  'Maximum streamfunction at 25\circN',...
                  'Location','northeast','fontsize',14,'Orientation','vertical','NumColumns',1);
    set(leg,'fontsize',14)
    hold on
    legend('boxoff')
    % #####################################################################

    

    xlim([1948 2023])
    ylim([10 26]);
    set(gca,'XTick',1950:10:2020)
    set(gca,'XTickLabel',{'1950','1960','1970','1980','1990','2000','2010','2020'},'fontsize',22)
    set(gca,'YTick',10:2.5:26)
    set(gca,'YTickLabel',{'10','12.5','15','17.5','20','22.5','25'},'fontsize',22)
    grid off
    set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
    ylabel('[ Sv ]','color','k','fontsize',22) % left y-axis
    xlabel(' Year ','color','k','fontsize',22) 
    title('c. AMOC at 26\circN by air-sea flux','color','k','fontsize',22)
       
% #########################################################################
% #########################################################################

cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')

% #########################################################################
% #########################################################################




