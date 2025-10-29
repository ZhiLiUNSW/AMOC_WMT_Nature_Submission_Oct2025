%% ########################################################################
%% PLOTTING AMOC STREAMFUNCTION AT 26N, [ Sv ]
%  SIO Argo  data for 2004-2023, 0-2000 m, annual mean of monthly means
%  Ishiiv731 data for 1980-2023, 0-3000 m, annual mean of monthly means
%  IPAv4     data for 1940-2023, 0-2000 m, annual mean of monthly means
%  IPAv4.2   data for 1940-2023, 0-6000 m, annual mean of monthly means
%  EN4-ESM   data for 1940-2023, 0-5500 m, annual mean of monthly means

% #########################################################################
% #########################################################################


% #########################################################################
% #########################################################################
%% AMOC 26N Decomposition
clc;clear
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
load plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat


% #########################################################################
% #########################################################################
% Plotting - AMOC Streamfunction at 26N From All Datasets  - 0.05 density bin
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.05; ixe = 0.02;  ixd = 0.050; ixw = (1-ixs-ixe-2*ixd)/3;
   iys = 0.10; iye = 0.10;  iyd = 0.050; iyw = (1-iys-iye-0*iyd)/1;
   pos{11}  = [ixs+0*ixw-0.1*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   pos{12}  = [ixs+1*ixw+0.6*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   pos{13}  = [ixs+2*ixw+1.5*ixd  iys+0*iyw+0*iyd   ixw+0.5*ixd 1.0*iyw]; 

% ######################################################################### 
    clear color color0 
    color0=cbrewer('div', 'RdBu', 40,'pchip');
    color0=color0(size(color0,1):-1:1,:);
% #########################################################################

   
% #########################################################################
subplot('position',pos{11})
      imagesc(time_ann_IAP,dens_rag_005(1:end),nanmean(AMOC_time_26N_ESM_005,3),'AlphaData',~isnan(nanmean(AMOC_time_26N_ESM_005,3)));
   
      
      % ###################################################################
      dens_rag_01 = (21.1: 0.1: 28.9)';
      % Subtropical Cell: MW 24.0 - 26.5
      hold on
      line_STMW = plot((1940:1:2025)', dens_rag_01(30)*ones(length((1940:1:2025)')));
      set(line_STMW,'linestyle','--','color',[0.8, 0.8, 0.8],'linewidth',2.5);
      hold on 
      line_STMW = plot((1940:1:2025)', dens_rag_01(56)*ones(length((1940:1:2025)')));
      set(line_STMW,'linestyle','--','color',[0.8, 0.8, 0.8],'linewidth',2.5);

      % Intermediate Water layer: 26.5 - 27.68
      hold on 
      line_STIW = plot((1940:1:2025)', dens_rag_01(56)*ones(length((1940:1:2025)')));
      set(line_STIW,'linestyle','--','color',[0.6, 0.6, 0.6],'linewidth',2.5);
      hold on 
      line_STIW = plot((1940:1:2025)', dens_rag_01(68)*ones(length((1940:1:2025)')));
      set(line_STIW,'linestyle','--','color',[0.6, 0.6, 0.6],'linewidth',2.5);
      
      % LSW and NADW layer: 26.68 - 28.1
      hold on 
      line_STIW = plot((1940:1:2025)', dens_rag_01(68)*ones(length((1940:1:2025)')));
      set(line_STIW,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.5);
      hold on 
      line_STIW = plot((1940:1:2025)', dens_rag_01(72)*ones(length((1940:1:2025)')));
      set(line_STIW,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.5);
      % ###################################################################
      

      % ###################################################################
      % Add text on Subtropical and Subpolar Cells, and IW
      text(  1949,24.13, 'Subtropical Cell','fontsize',18,'FontWeight','normal');

      text(  1949,26.73, 'Intermediate Water','fontsize',18,'FontWeight','normal');
      
      text(  1949,27.93, 'Deep Water','fontsize',18,'FontWeight','normal');
      
      text(  2008,26.5, '(~300 m)',      'fontsize',17,'FontWeight','normal');
      text(  2008,27.7, '(~1200 m)',     'fontsize',17,'FontWeight','normal');
      % ###################################################################
      
      
      % ###################################################################
      % plot the depth/sigma0 of the maximum streamfunction
      % Depth / Sigma0 with the maximum streamfunction
      for year = 1:size(AMOC_time_26N_ESM_005,2)
          for num_data = 1 : size(AMOC_time_26N_ESM_005,3)
              if isnan(AMOC_time_26N_max_ESM_005_LOW(year,num_data)) == 0
                 AMOC_WMT_gamma(year,num_data) = dens_rag_005(find(AMOC_time_26N_max_ESM_005_LOW(year,num_data)==squeeze(AMOC_time_26N_ESM_005(:,year,num_data))),1);
              else
                 AMOC_WMT_gamma(year,num_data) = NaN;
              end
          end
      end
      clear year num_data
      AMOC_WMT_gamma = nanmean(AMOC_WMT_gamma,2);
 
      hold on
      line_AMOC_WMT_gamma=plot(time_ann_IAP(1:end,1),AMOC_WMT_gamma); clear AMOC_WMT_gamma
      set(line_AMOC_WMT_gamma,'color',[0.2, 0.4, 0.6],'LineWidth', 2.5, 'linestyle','-'); 
      % ###################################################################
      
      xlim([1948 2023.5])
      set(gca,'XTick',1950:10:2020)
      set(gca,'XTickLabel',{'1950','1960','1970','1980','1990','2000','2010','2020'},'fontsize',20)
      ylim([23 28.3])
      set(gca,'YTick',22:1:29)
      set(gca,'YTickLabel',{'22','23','24','25','26','27','28','29'},'FontSize',20)
      set(gca,'tickdir','in','box','on')
      grid off
      colormap(gca,color0)
      caxis([-30 30]);  
      ylabel('Neutral density [ kg m^{-3} ]','color','k','fontsize',20) % left y-axis
      xlabel(' Year ','color','k','fontsize',20) 
      title('a. AMOC streamfunction at 26\circN','fontsize',22,'FontWeight','bold')
      

hBar1 = colorbar('EastOutside','horizontal');
get(hBar1, 'Position') ;
set(hBar1, 'Position', [ixs+0.001*ixw iys+0.92*iyw+0*iyd 0.31*ixw 0.010]);
set(hBar1,'ytick',-20:10:20,'yticklabel',{'-20','-10','0','10','20'},'fontsize',14,'FontName','Arial','LineWidth',1.2,'TickLength',0.05);
ylabel(hBar1, '[ Sv ]','rotation',0,'fontsize',14);
% #########################################################################



  
% ######################################################################### 
% Vertical Profiles averaged between 1981 and 2023
subplot('position',pos{12})

      % ###################################################################
      dens_rag_01 = (21.1: 0.1: 28.9)';
      % Subtropical Cell: MW 24.0 - 26.5
      line_STMW = plot((-5:25)',- dens_rag_01(30)*ones(length((-5:25)')));
      set(line_STMW,'linestyle','--','color',[0.8, 0.8, 0.8],'linewidth',2.5);
      hold on 
      line_STMW = plot((-5:25)',- dens_rag_01(56)*ones(length((-5:25)')));
      set(line_STMW,'linestyle','--','color',[0.8, 0.8, 0.8],'linewidth',2.5);

      % Intermediate Water layer: 26.5 - 27.68
      hold on 
      line_STIW = plot((-5:25)',- dens_rag_01(56)*ones(length((-5:25)')));
      set(line_STIW,'linestyle','--','color',[0.6, 0.6, 0.6],'linewidth',2.5);
      hold on 
      line_STIW = plot((-5:25)',- dens_rag_01(68)*ones(length((-5:25)')));
      set(line_STIW,'linestyle','--','color',[0.6, 0.6, 0.6],'linewidth',2.5);
      
      % LSW and NADW layer: 26.68 - 28.1
      hold on 
      line_STIW = plot((-5:25)',- dens_rag_01(68)*ones(length((-5:25)')));
      set(line_STIW,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.5);
      hold on 
      line_STIW = plot((-5:25)',- dens_rag_01(72)*ones(length((-5:25)')));
      set(line_STIW,'linestyle','--','color',[0.4, 0.4, 0.4],'linewidth',2.5);
      % ###################################################################
      
      
      % ###################################################################
        % Patching of STD of AMOC-UP (IW layer)
        AMOC_time_26N_ESM_005_by_dens = squeeze(nanmean(AMOC_time_26N_ESM_005(:,65:84,:),2));
        AMOC_time_26N_ESM_005_by_dens (AMOC_time_26N_ESM_005_by_dens ==0) = NaN;
        % Standard Deviation of Each Year, Given by All Products Available
        for dens = 1 : size(AMOC_time_26N_ESM_005_by_dens,1)
            AMOC_time(:,1)=AMOC_time_26N_ESM_005_by_dens(dens,:)';
            count=1;
            for k = 1:size(AMOC_time_26N_ESM_005_by_dens,2)
                if isnan(AMOC_time(k,1))==0
                   AMOC_time_noNaN(count,1)=AMOC_time(k,1);
                   count=count+1;
                end
            end
            clear count k AMOC_time
            AMOC_time_26N_ESM_std(dens,1)=std(AMOC_time_noNaN(:,1),1,1);
            clear AMOC_time_noNaN
        end
        % Pacthing of 2*STD
        AMOC_time_26N_ESM_2std(:,1)=nanmean(AMOC_time_26N_ESM_005_by_dens(:,:),2) + runmean(AMOC_time_26N_ESM_std,1);
        AMOC_time_26N_ESM_2std(:,2)=nanmean(AMOC_time_26N_ESM_005_by_dens(:,:),2) - runmean(AMOC_time_26N_ESM_std,1);
        clear AMOC_time_26N_ESM_std AMOC_time_26N_ESM_005_by_dens
        hold on

        % Construct patch in Sv vs density space
        densVals = dens_rag_005(9:end-6,1);             % density [kg/m^3]
        Sv_upper = AMOC_time_26N_ESM_2std(9:end-6,1)';  % +2? [Sv]
        Sv_lower = AMOC_time_26N_ESM_2std(9:end-6,2)';  % -2? [Sv]

        % Patch requires x = Sv, y = density
        hp1 = patch([Sv_lower fliplr(Sv_upper)], [-densVals' fliplr(-densVals')],'b');
        set(hp1,'facecolor',[0.5, 0.8, 0.85],'edgecolor','none','FaceAlpha',0.6)
        clear AMOC_time_max_ESM_2std
        hold on
      % ###################################################################

      
      % ###################################################################
      % Add text on Subtropical and Subpolar Cells, and IW
      text(  0.1,-25.93, 'Subtropical Cell','fontsize',17,'FontWeight','normal');

      text(  0.1,-27.12, 'Intermediate',    'fontsize',17,'FontWeight','normal');
      text(  0.1,-27.28, 'Water',           'fontsize',17,'FontWeight','normal');
       
      text( 14.0,-28.02, 'Deep Water',      'fontsize',17,'FontWeight','normal');

      text( 0.1,-26.5, '(~300 m)',      'fontsize',17,'FontWeight','normal');
      text( 0.1,-27.7, '(~1200 m)',      'fontsize',17,'FontWeight','normal');
      % ###################################################################
      
      
      % ###################################################################
      % Add an arrow annotation [x_start x_end] and [y_start y_end]
      % Subpolar Cell from AAIW to NADW
      annotation('arrow', [ixs+1.12*ixw ixs+1.26*ixw], [iys+0.270*iyw iys+0.270*iyw],'Color', [0.301, 0.745, 0.933], 'LineWidth', 7,'HeadWidth', 22, 'HeadLength',18);
      annotation('arrow', [ixs+1.26*ixw ixs+1.12*ixw], [iys+0.080*iyw iys+0.080*iyw],'Color', [0.301, 0.745, 0.933], 'LineWidth', 7,'HeadWidth', 22, 'HeadLength',18);
      
      % Subtropical Cell
      annotation('arrow', [ixs+1.26*ixw ixs+1.12*ixw], [iys+0.380*iyw iys+0.380*iyw],'Color', [0.301, 0.745, 0.933], 'LineWidth', 5,'HeadWidth', 15, 'HeadLength',15);
      annotation('arrow', [ixs+1.12*ixw ixs+1.26*ixw], [iys+0.780*iyw iys+0.780*iyw],'Color', [0.301, 0.745, 0.933], 'LineWidth', 5,'HeadWidth', 15, 'HeadLength',15);
      % ###################################################################  
      
      
      % ################################################################### 
      % Interpolate the sigma to nuetral density at 26N
        cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/3_Meridional_Transects/')
        load(['cal_ATL_Basin_Zonal_TS_Density_and_AAIW_Vol_OHC_V6_1_Zonal_TS_Gam_OHC_Vol_1_IAPv42_20042023.mat'],...
              'gamma_ATL_ann','Rh0_ATL_ann','gamma_ATL_mon','Rh0_ATL_mon','dep_IAP')
        gamma_26N = squeeze(nanmean(nanmean(gamma_ATL_ann(116:117,:,:),3),1))'; clear gamma_ATL_ann
        Rh0_26N   = squeeze(nanmean(nanmean(  Rh0_ATL_ann(116:117,:,:),3),1))'; clear Rh0_ATL_ann
        Rh0_26N0( 1:53,1)                   = (22.0:0.05:24.60)'; 
        Rh0_26N0(53:53+length(Rh0_26N)-1,1) = Rh0_26N; 
        Rh0_26N                             = Rh0_26N0; clear Rh0_26N0
        gamma_26N0( 1:53,1)                     = (22.0:0.05:24.60)'; 
        gamma_26N0(53:53+length(gamma_26N)-1,1) = gamma_26N; 
        gamma_26N                               = gamma_26N0; clear gamma_26N0
        
        Rapid_26N_stream = interp1(sigma_10day-1000,nanmean(stream_sigma_10day(:,:),2),Rh0_26N,'linear');
      hold on 
      line_RAPID  = plot(Rapid_26N_stream(1:316,1),      -gamma_26N(1:316,1));
      set(line_RAPID,'color',[0.3, 0.3, 0.3],'LineWidth',5.0,'linestyle','-'); 
      % ################################################################### 
      
      hold on
      line_ESM = plot(nanmean(nanmean(AMOC_time_26N_ESM_005(:,65:84,:),3),2), -dens_rag_005);
      set(line_ESM,'color',[0.9,0.325,0.098],'LineWidth',6.0,'linestyle','-');
      % ################################################################### 
      
      
    
      % ###################################################################  
      leg=legend([line_RAPID line_ESM],...
                  'RAPID array at 26\circN',...
                  'AMOC reconstruction at 26\circN',...
                  'Location','northeast','fontsize',17,'Orientation','vertical','NumColumns',1);
      set(leg,'fontsize',17)
      hold on
      %title(leg,'AMOC Strength','fontsize',20','color','k')
      legend('boxoff')
      % ###################################################################
   

      xlim([-0.3 20])
      ylim([-28.3 -23.0])
      set(gca,'XTick',0:5:20)
      set(gca,'XTickLabel',{'0','5','10','15','20'},'FontSize',20)
      set(gca,'YTick',-28:1:-22)
      set(gca,'YTickLabel',{'28','27','26','25','24','23','22'},'FontSize',20)
      set(gca,'tickdir','in','box','on')
      grid off
%     grid on
%     set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')

      % ylabel('Density [ kg m^{-3} ]','color','k','fontsize',22) % left y-axis
      xlabel(' [ Sv ] ','color','k','fontsize',20) 
      title('b. AMOC at 26\circN','fontsize',22,'FontWeight','bold')

% #########################################################################

    

   
% #########################################################################
% #########################################################################
% AMOC at 26N and decomposition
subplot('position',pos{13})

    % #####################################################################
    % Annual Mean Streamfunction
    % AMOC at 26N,              Ensemble Mean, 15-Year Running Mean
    AMOC_time_26N_max_ESM_005_LOW(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(:,1:5),2),'movmean', 15)'; % Max at 26N
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(:,1:5),2),'LOWESS',  15)'; % Max at 26N
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_26N          = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_26N,'color',[0.850, 0.325, 0.098],'LineWidth',5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    % #####################################################################

    
    
    % #################################################################
    % Patching of STD of AMOC-UP (IW layer)
    % STD of 15-Year running mean AMOC ESM
    for k = 1: size(AMOC_time_26N_max_ESM_005_LOW,2)
        AMOC_time_max_ESM_15_yr(:,k) = runmean(AMOC_time_26N_max_ESM_005_LOW(:,k),7);
    end 
    AMOC_time_max_ESM_15_yr(65:84,3) = runmean(AMOC_time_26N_max_ESM_005_LOW(65:84,3),7);
    AMOC_time_max_ESM_15_yr(16:84,4) = runmean(AMOC_time_26N_max_ESM_005_LOW(16:84,4),7);

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
    AMOC_time_max_ESM_2std(:,1)=nanmean(AMOC_time_max_ESM_15_yr(:,:),2) + runmean(AMOC_time_max_ESM_std,0);
    AMOC_time_max_ESM_2std(:,2)=nanmean(AMOC_time_max_ESM_15_yr(:,:),2) - runmean(AMOC_time_max_ESM_std,0);
    clear AMOC_time_max_ESM_std AMOC_time_max_ESM_15_yr
    hp1=patch([time_ann_IAP(9:end-6,1)' fliplr(time_ann_IAP(9:end-6,1)')],[AMOC_time_max_ESM_2std(9:end-6,2)' fliplr(AMOC_time_max_ESM_2std(9:end-6,1)')],'b');
    set(hp1,'facecolor',[0.5, 0.8, 0.85],'edgecolor','none','FaceAlpha',0.6)
    clear AMOC_time_max_ESM_2std
    hold on
    % #################################################################

        

    % #####################################################################
    % #####################################################################
    % Hydrographic Sections at 25N, Atkinson at al. (2012)
    % Intermediate 0-1100 m integration
    bar_25N_1957=errorbar((1957+ 9/12)',18.0, 2.9);
    set(bar_25N_1957,'color',[1.0 0.75 0.8], 'LineWidth', 2.0,'linestyle','-');
    hold on
    bar_25N_1981=errorbar((1981+ 7/12)',17.6, 2.9);
    set(bar_25N_1981,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    bar_25N_1992=errorbar((1992+ 6/12)',18.6, 2.9);
    set(bar_25N_1992,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    bar_25N_1998=errorbar((1998+ 1/12)',16.8, 2.9);
    set(bar_25N_1998,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    bar_25N_2004=errorbar((2004+ 3/12)',16.1, 2.9);
    set(bar_25N_2004,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);

    hold on
    line_25N_1957=plot((1957+ 9/12)',18.0,'s','MarkerSize',10,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1957,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on   
    line_25N_1981=plot((1981+ 7/12)',17.6,'s','MarkerSize',10,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1981,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    line_25N_1992=plot((1992+ 6/12)',18.6,'s','MarkerSize',10,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1992,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    line_25N_1998=plot((1998+ 1/12)',16.8,'s','MarkerSize',10,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1998,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    line_25N_2004=plot((2004+ 3/12)',16.1,'s','MarkerSize',10,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_2004,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
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
    set(line_FW2015,'color',[0.694, 0.384, 0.556],'LineWidth',  4.5,'linestyle','-');
    clear recon dates AMOC_FW2015 tme_AMOC_FW2015
    % #####################################################################
    % #####################################################################
    
    
    % #####################################################################
    % #####################################################################
    % RAPID AMOC
    hold on
    line_RAPID=plot(decimal_year(2:3:end-2,1),amoc_sigma_mon_corr);
    set(line_RAPID,'color',[0.1, 0.1, 0.1],'LineWidth',  3.0,'linestyle','-'); 
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
    set(line_OSNAP,'color',[0.6, 0.6, 0.6],'LineWidth',  3.0,'linestyle','-');
    clear tme_OSNAP MOC_OSNAP_Mon
    % #####################################################################
    % #####################################################################

    
    % #####################################################################
    % #####################################################################
    % AMOC 26N, from WOA2023
    hold on
    line_IW_WOA23   = plot((1975:1:1984)',ones(length((1975:1:1984)'),1)*AMOC_time_26N_max_WOA_005_LOW(3,1));    
    set(line_IW_WOA23,'color',[0.5, 0.5, 0.5],'LineWidth',3.0,'linestyle',':');
    hold on
    line_IW_WOA23   = plot((1985:1:1994)',ones(length((1985:1:1994)'),1)*AMOC_time_26N_max_WOA_005_LOW(4,1));    
    set(line_IW_WOA23,'color',[0.5, 0.5, 0.5],'LineWidth',3.0,'linestyle',':');
    hold on
    line_IW_WOA23   = plot((1995:1:2004)',ones(length((1955:1:1964)'),1)*AMOC_time_26N_max_WOA_005_LOW(5,1));    
    set(line_IW_WOA23,'color',[0.5, 0.5, 0.5],'LineWidth',3.0,'linestyle',':');
    hold on
    line_IW_WOA23   = plot((2005:1:2014)',ones(length((1965:1:1974)'),1)*AMOC_time_26N_max_WOA_005_LOW(6,1));    
    set(line_IW_WOA23,'color',[0.5, 0.5, 0.5],'LineWidth',3.0,'linestyle',':');
    hold on
    line_IW_WOA23   = plot((2015:1:2022)',ones(length((2015:1:2022)'),1)*AMOC_time_26N_max_WOA_005_LOW(7,1));    
    set(line_IW_WOA23,'color',[0.5, 0.5, 0.5],'LineWidth',3.0,'linestyle',':');
    % #####################################################################
    % #####################################################################

    
    % #####################################################################
    % #####################################################################
    % AMOC 26N Max, 15-Year Running Mean
    hold on
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(:,2),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(:,2),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_IW_IAPv42        = plot(time_ann_IAP,AMOC_time0);    
    set(line_IW_IAPv42,'color',[0.850, 0.325, 0.098],'LineWidth',2.0,'linestyle','-');
    clear AMOC_time0 AMOC_time1

    hold on
    AMOC_time0(65:84,1)   = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(65:84,3),2),'movmean', 15)'; 
    AMOC_time1(65:84,1)   = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(65:84,3),2),'LOWESS',  15)'; 
    AMOC_time0(1:64)      = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_IW_RG18          = plot(time_ann_IAP,AMOC_time0);    
    set(line_IW_RG18,'color',[0.2, 0.8, 0.2],'LineWidth',2.0,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    
    hold on
    AMOC_time0(16:84,1)   = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(16:84,4),2),'movmean', 15)'; 
    AMOC_time1(16:84,1)   = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(16:84,4),2),'LOWESS',  15)'; 
    AMOC_time0(1:15+7)    = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_IW_Ishii         = plot(time_ann_IAP,AMOC_time0);    
    set(line_IW_Ishii,'color',[0    , 0.447, 0.741],'LineWidth',2.0,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    
    hold on
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(:,5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(:,5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_IW_EN4           = plot(time_ann_IAP,AMOC_time0);    
    set(line_IW_EN4,'color',[0.929, 0.694, 0.125],'LineWidth',2.0,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    
    
    % Ensemble Mean
    % AMOC 26N Max, 15-Year Running Mean
    AMOC_time_26N_max_ESM_005_LOW(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_26N          = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_26N,'color',[0.850, 0.325, 0.098],'LineWidth',6.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    % AMOC 26N Max by air-sea fluxes
    AMOC_time_26N_max_ESM_005_LOW_F(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_F(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_F(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_26N_F        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_26N_F,'color',[0    , 0.447, 0.741],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on

    % AMOC 26N Max by mesoscale mixing
    AMOC_time_26N_max_ESM_005_LOW_N(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_N(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_N(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_26N_N        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_26N_N,'color',[0.301, 0.745, 0.933],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    % AMOC 26N Max by vertical mixing
    AMOC_time_26N_max_ESM_005_LOW_V(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_V(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_V(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_26N_V        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_26N_V,'color',[0.2, 0.7, 0.2],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    % AMOC 26N Max by volume change 
    AMOC_time_26N_max_ESM_005_LOW_dM(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_dM(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_dM(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_26N_dM       = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_26N_dM,'color',[0.929, 0.694, 0.125],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    % AMOC 26N Max by mesoscale and vertical mixing, and volume tendency
    AMOC_time_26N_max_ESM_005_LOW_N(:,1) = NaN; % remove IAPv4
    AMOC_time_26N_max_ESM_005_LOW_V(:,1) = NaN; % remove IAPv4
    AMOC_time_26N_max_ESM_005_LOW_dM(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_N(:,1:5),2),'movmean', 15)' + smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_V(:,1:5),2),'movmean', 15)' + smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_dM(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_N(:,1:5),2),'LOWESS', 15)'  + smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_V(:,1:5),2),'LOWESS', 15)'  + smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_dM(:,1:5),2),'LOWESS', 15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_26N_MV       = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_26N_MV,'color',[0.6, 0.6, 0.6],'LineWidth',4.5,'linestyle','-.');
    clear AMOC_time0 AMOC_time1
    hold on
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
    % =========================
    % First legend (top-right)
    % =========================
    ax1  = gca; 
    leg1 = legend(ax1,[line_ESM_26N line_IW_IAPv42 line_IW_RG18 line_IW_Ishii line_IW_EN4 line_IW_WOA23 line_RAPID line_OSNAP line_FW2015 line_25N_2004 line_25Nmax_1957], ...
                  'AMOC at 26\circN',...
                  'IAPv4.2',...
                  'SIO Argo ',...
                  'Ishii',...
                  'EN4',...
                  'WOA 2023',...
                  'RAPID 26\circN array',...
                  'OSNAP subpolar array',...
                  'Satellite altimetry',...
                  'Hydrographic at 25\circN',...
                  'Max. streamf. at 25\circN',...
                  'Location','northeast','FontSize',14,'Orientation','vertical','NumColumns',2);
    legend(ax1,'boxoff')
    set(leg1,'FontSize',14)

    % =========================
    % Second legend (middle-right)
    % =========================
    ax2  = axes('Position',get(ax1,'Position'), ...
               'Color','none','XColor','none','YColor','none', ...
               'HitTest','off','PickableParts','none');  % not interactive
    leg2 = legend(ax2,[line_ESM_26N_F line_ESM_26N_N line_ESM_26N_V line_ESM_26N_dM line_ESM_26N_MV], ...
                  'Air-sea fluxes',...
                  'Meso. mixing',...
                  'Vertical mixing',...
                  'Volume tendency',...
                  'Mixing and vol. tend.',...
                  'Location','east','FontSize',14,'Orientation','vertical');
    title( leg2,'AMOC at 26\circN decomp.','fontsize',15','color',[0.850, 0.325, 0.098])
    legend(ax2,'boxoff')
    set(leg2,'FontSize',14)

    % =========================
    % Manual positioning
    % =========================
    %uistack(ax1,'top');
    
    set(leg2,'Position',[ixs+2.88*ixw+1.5*ixd iys+0.34*iyw 0.0*ixw 0.0*iyw]) 
    % #####################################################################


    set(ax1,'XLim',[1948 2023], ...
            'XTick',1950:10:2020, ...
            'XTickLabel',{'1950','1960','1970','1980','1990','2000','2010','2020'}, ...
            'YLim',[0 27], ...
            'YTick',0:5:25, ...
            'YTickLabel',{'0','5','10','15','20','25'}, ...
            'FontSize',20);
        
    ylabel(ax1,'[ Sv ]','color','k','fontsize',20) 
    xlabel(ax1,' Year ','color','k','fontsize',20) 
    title( ax1,'c. AMOC strength at 26\circN','color','k','fontsize',22)
    grid(  ax1,'off')
    

% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
% #########################################################################
% #########################################################################

