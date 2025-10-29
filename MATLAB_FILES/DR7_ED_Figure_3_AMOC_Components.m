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
clc;clear
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
load plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat

% #########################################################################
% #########################################################################


% #########################################################################
% #########################################################################
%  Plotting 1 - AMOC in All Datasets and AMOC Decomposition
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.04; ixe = 0.07;  ixd = 0.025; ixw = (1-ixs-ixe-3*ixd)/4;
   iys = 0.05; iye = 0.05;  iyd = 0.080; iyw = (1-iys-iye-1*iyd)/2;
   pos{11}  = [ixs+0*ixw+0*ixd  iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{12}  = [ixs+1*ixw+1*ixd  iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{13}  = [ixs+2*ixw+2*ixd  iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{14}  = [ixs+3*ixw+3*ixd  iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   
   pos{21}  = [ixs+0*ixw+0*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   pos{22}  = [ixs+1*ixw+1*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   pos{23}  = [ixs+2*ixw+2*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   pos{24}  = [ixs+3*ixw+3*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   
   
% ######################################################################### 
    clear color color0 
    color0=cbrewer('div', 'RdBu', 40,'pchip');
    color0=color0(size(color0,1):-1:1,:);
% #########################################################################


   
% #########################################################################
subplot('position',pos{11})
      imagesc(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,1)./1e6,'AlphaData',~isnan(AMOCyg_ESM_005(:,:,1)));
      
      
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,1)./1e6,-20:10:-10,'k-');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,1)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,1)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,1)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',2.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      
      
    
      % ###################################################################
      % Subtropical Cell: MW
      dens_rag_01 = (21.1:0.1:28.9)';
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
      
      
      xlim([-65 70])
      ylim([21.5 28.5])
      set(gca,'XTick',-60:30:60)
      set(gca,'XTickLabel',{'60\circS','30\circS','0','30\circN','60\circN'},'FontSize',18)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
     %set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-20 20]);  
      ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
     %xlabel(' Latitude ','color','k','fontsize',18) 
      title('a. AMOC streamfunction, IAP','fontsize',20,'FontWeight','bold')

% #########################################################################

    


% #########################################################################
subplot('position',pos{12})
      imagesc(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,5)./1e6,'AlphaData',~isnan(AMOCyg_ESM_005(:,:,5)));

      
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,5)./1e6,-20:10:-10,'k-');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,5)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,5)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1500,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,5)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',2.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      
    
    
      % ###################################################################
      % Subtropical Cell: MW
      dens_rag_01 = (21.1:0.1:28.9)';
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
      
      
      
      xlim([-65 70])
      ylim([21.5 28.5])
      set(gca,'XTick',-60:30:60)
      set(gca,'XTickLabel',{'60\circS','30\circS','0','30\circN','60\circN'},'FontSize',18)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
     %set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-20 20]);  
     %ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
     %xlabel(' Latitude ','color','k','fontsize',18) 
      title('b. AMOC streamfunction, EN4','fontsize',20,'FontWeight','bold')
% #########################################################################




% #########################################################################
subplot('position',pos{13})
      imagesc(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,3)./1e6,'AlphaData',~isnan(AMOCyg_ESM_005(:,:,3)));
      
      
      % ###################################################################
      % Un-resolved density range below > 27.8
      hold on 
      line278=plot(lat_IAP,27.80*ones(length(lat_IAP)));
      set(line278,'linestyle','--','color',[.7 .7 .7],'linewidth',1.2);
      hold on 
      line278=plot(lat_IAP,27.90*ones(length(lat_IAP)));
      set(line278,'linestyle','--','color',[.7 .7 .7],'linewidth',1.2);
      hold on 
      line278=plot(lat_IAP,28.00*ones(length(lat_IAP)));
      set(line278,'linestyle','--','color',[.7 .7 .7],'linewidth',1.2);
      hold on 
      line278=plot(lat_IAP,28.10*ones(length(lat_IAP)));
      set(line278,'linestyle','--','color',[.7 .7 .7],'linewidth',1.2);
      hold on 
      line278=plot(lat_IAP,28.20*ones(length(lat_IAP)));
      set(line278,'linestyle','--','color',[.7 .7 .7],'linewidth',1.2);
      hold on 
      line278=plot(lat_IAP,28.30*ones(length(lat_IAP)));
      set(line278,'linestyle','--','color',[.7 .7 .7],'linewidth',1.2);
      hold on 
      line278=plot(lat_IAP,28.40*ones(length(lat_IAP)));
      set(line278,'linestyle','--','color',[.7 .7 .7],'linewidth',1.2);
      % ###################################################################
      
      
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,3)./1e6,-20:10:-10,'k-');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,3)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',2.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      
    
      % ###################################################################
      % Subtropical Cell: MW
      dens_rag_01 = (21.1:0.1:28.9)';
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
      
      
      
      xlim([-65 70])
      ylim([21.5 28.5])
      set(gca,'XTick',-60:30:60)
      set(gca,'XTickLabel',{'60\circS','30\circS','0','30\circN','60\circN'},'FontSize',18)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
     %set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-20 20]);  
     %ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
     %xlabel(' Latitude ','color','k','fontsize',18) 
      title('c. AMOC streamfunction, Argo','fontsize',20,'FontWeight','bold')

% #########################################################################



% #########################################################################
subplot('position',pos{14})
      imagesc(lat_IAP,dens_rag_005(1:end),AMOCyg_ESM_005(:,:,4)./1e6,'AlphaData',~isnan(AMOCyg_ESM_005(:,:,4)));
      
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,dens_rag_005(1:end),smooth2a(AMOCyg_ESM_005(:,:,4),1,1)./1e6,-20:10:-10,'k-');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',300,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),smooth2a(AMOCyg_ESM_005(:,:,4),1,1)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),smooth2a(AMOCyg_ESM_005(:,:,4),1,1)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),smooth2a(AMOCyg_ESM_005(:,:,4),1,1)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',2.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      
    
    
      % ###################################################################
      % Subtropical Cell: MW
      dens_rag_01 = (21.1:0.1:28.9)';
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
      
      
      xlim([-65 70])
      ylim([21.5 28.5])
      set(gca,'XTick',-60:30:60)
      set(gca,'XTickLabel',{'60\circS','30\circS','0','30\circN','60\circN'},'FontSize',18)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
     %set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-20 20]);  
     %ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
     %xlabel(' Latitude ','color','k','fontsize',18) 
      title('d. AMOC streamfunction, Ishii','fontsize',20,'FontWeight','bold')

      
      hBar14 = colorbar('EastOutside');
      get(hBar14, 'Position') ;
      set(hBar14, 'Position', [ixs+4*ixw+3*ixd+0.010 iys+1*iyw+1*iyd 0.012 1.0*iyw]);
      set(hBar14,'ytick',-25:5:25,'yticklabel',{'<-25','<-20','-15','-10','-5','0','5','10','15','>20','>25'},'fontsize',18,'FontName','Arial','LineWidth',1.2,'TickLength',0.05);
      
      ylabel(hBar14, '[ Sv ]','rotation',90);
     %text(60.5,22.25, '[ Sv ]','fontsize',22,'FontWeight','normal'); 
% #########################################################################
% #########################################################################



% #########################################################################
% #########################################################################
subplot('position',pos{21})
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
      clabel(C012,h012,v012,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005,3)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_F_ESM_005,3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',2.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      
      
      xlim([-65 70])
      ylim([21.5 28.5])
      set(gca,'XTick',-60:30:60)
      set(gca,'XTickLabel',{'60\circS','30\circS','0','30\circN','60\circN'},'FontSize',18)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
     %set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-20 20]);  
      ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',18) % left y-axis
     %xlabel(' Latitude ','color','k','fontsize',18) 
      title('e. Air-sea fluxes','fontsize',20,'FontWeight','bold')

      
      hBar21 = colorbar('EastOutside');
      get(hBar21, 'Position') ;
      set(hBar21, 'Position', [ixs+0.75*ixw+0*ixd+0.010 iys+0.4*iyw+0*iyd 0.008 0.55*iyw]);
      set(hBar21,'ytick',-25:5:25,'yticklabel',{'<-25','<-20','-15','-10','-5','0','5','10','15','>20','>25'},'fontsize',16,'FontName','Arial','LineWidth',1.2,'TickLength',0.055);
      
      %ylabel(hBar21, '[ Sv ]','rotation',90,'fontsize',16,'FontName','Arial');
% #########################################################################




% #########################################################################
subplot('position',pos{22})
      imagesc(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_N_ESM_005,3)./1e6,'AlphaData',~isnan(nanmean(AMOCyg_N_ESM_005,3)));
      
      
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_N_ESM_005,3)./1e6,-20:10:-10,'k-');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_N_ESM_005,3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_N_ESM_005,3)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_N_ESM_005,3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',2.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      
      
      xlim([-65 70])
      ylim([21.5 28.5])
      set(gca,'XTick',-60:30:60)
      set(gca,'XTickLabel',{'60\circS','30\circS','0','30\circN','60\circN'},'FontSize',18)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
     %set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-10 10]);    
      title('f. Mesoscale mixing','fontsize',20,'FontWeight','bold')

% #########################################################################


% #########################################################################
subplot('position',pos{23})
      imagesc(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_V_ESM_005,3)./1e6,'AlphaData',~isnan(nanmean(AMOCyg_V_ESM_005,3)));
      
      
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_V_ESM_005,3)./1e6,-20:10:-10,'k-');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',300,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_V_ESM_005,3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',300,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_V_ESM_005,3)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_V_ESM_005,3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',2.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      
      
      xlim([-65 70])
      ylim([21.5 28.5])
      set(gca,'XTick',-60:30:60)
      set(gca,'XTickLabel',{'60\circS','30\circS','0','30\circN','60\circN'},'FontSize',18)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
     %set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-10 10]);  
      title('g. Vertical mixing','fontsize',20,'FontWeight','bold')

% #########################################################################


% #########################################################################
subplot('position',pos{24})
      imagesc(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_dM_ESM_005,3)./1e6,'AlphaData',~isnan(nanmean(AMOCyg_dM_ESM_005,3)));
      
      
      % ###################################################################
      % Contours
      hold on 
      [C01,h01]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_dM_ESM_005,3)./1e6,-20:10:-10,'k-');
      set(h01 ,'color',[.2 .4 .6],'linewidth',2.0);
      v01=-25:5:25;
      clabel(C01,h01,v01,'labelspacing',500,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C012,h012]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_dM_ESM_005,3)./1e6,[-2 -2],'k-');
      set(h012,'color',[.2 .4 .6],'linewidth',2.0);
      v012=-2;
      clabel(C012,h012,v012,'labelspacing',600,'fontsize',16,'color',[.2 .2 .2])   
      
      hold on 
      [C02,h02]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_dM_ESM_005,3)./1e6,10:5:20,'k-');
      set(h02,'color',[.8 .3 .3],'linewidth',2.5);
      v02=-25:5:25;
      clabel(C02,h02,v02,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      hold on 
      [C03,h03]=contour(lat_IAP,dens_rag_005(1:end),nanmean(AMOCyg_dM_ESM_005,3)./1e6,[2 2],'k-');
      set(h03,'color',[.8 .3 .3],'linewidth',2.5);
      v03=2;
      clabel(C03,h03,v03,'labelspacing',1000,'fontsize',16,'color',[.2 .2 .2])   
      % ###################################################################
      
      
      xlim([-65 70])
      ylim([21.5 28.5])
      set(gca,'XTick',-60:30:60)
      set(gca,'XTickLabel',{'60\circS','30\circS','0','30\circN','60\circN'},'FontSize',18)
      set(gca,'YTick',21:1:28.5)
      set(gca,'YTickLabel',{'21','22','23','24','25','26','27','28'},'FontSize',18)
      set(gca,'tickdir','in','box','on')
      grid off
     %set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([-10 10]);  
      title('h. Volume tendency','fontsize',20,'FontWeight','bold')
      
      
      hBar24 = colorbar('EastOutside');
      get(hBar24, 'Position') ;
      set(hBar24, 'Position', [ixs+4*ixw+3*ixd+0.010 iys+0*iyw+0*iyd 0.012 1.0*iyw]);
      set(hBar24,'ytick',-10:2:10,'yticklabel',{'<-10','-8','-6','-4','-2','0','2','4','6','8','>10'},'fontsize',18,'FontName','Arial','LineWidth',1.2,'TickLength',0.05);
      
      ylabel(hBar24, 'Panels (f-h). [ Sv ]','rotation',90);
% #########################################################################


cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction')

% #########################################################################  
% #########################################################################



