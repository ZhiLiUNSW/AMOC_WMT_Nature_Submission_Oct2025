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
%% V3: AMOC Decomposition and Gv Decomposition at 26N, 53N, and 34.5S
clc;clear
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
load plot_AMOC_Streamfunction_V4_Ensemble_Observations_AMOC-IW_Cells_v2_3_AMOC_Decomposition_005Bin.mat
% #########################################################################
% #########################################################################


% #########################################################################
% #########################################################################
%  Plotting - AMOC Streamfunction decomposition at 26N From All Datasets  - 0.05 density bin
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.04; ixe = 0.02;  ixd = 0.040; ixw = (1-ixs-ixe-2*ixd)/3;
   iys = 0.10; iye = 0.10;  iyd = 0.050; iyw = (1-iys-iye-0*iyd)/1;

   pos{11}  = [ixs+0*ixw+0*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   pos{12}  = [ixs+1*ixw+1*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 
   pos{13}  = [ixs+2*ixw+2*ixd  iys+0*iyw+0*iyd   ixw 1.0*iyw]; 

% ######################################################################### 
    clear color color0 
    color0=cbrewer('div', 'RdBu', 40,'pchip');
    color0=color0(size(color0,1):-1:1,:);
% #########################################################################



% #########################################################################
subplot('position',pos{11})
% AMOC at 345S and decomposition

    % #####################################################################
    % Annual Mean Streamfunction
    % AMOC at 345S,              Ensemble Mean, 15-Year Running Mean
    AMOC_time_345S_max_ESM_005_LOW(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW(:,1:5),2),'movmean', 15)'; % Max at 345S
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW(:,1:5),2),'LOWESS',  15)'; % Max at 345S
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_345S          = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_345S,'color',[0.850, 0.325, 0.098],'LineWidth',5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    % #####################################################################

    
    
    % #################################################################
    % Patching of STD of AMOC-UP (IW layer)
    % STD of 15-Year running mean AMOC ESM
    for k = 1: size(AMOC_time_345S_max_ESM_005_LOW,2)
        AMOC_time_max_ESM_15_yr(:,k) = runmean(AMOC_time_345S_max_ESM_005_LOW(:,k),7);
    end 
    AMOC_time_max_ESM_15_yr(65:84,3) = runmean(AMOC_time_345S_max_ESM_005_LOW(65:84,3),7);
    AMOC_time_max_ESM_15_yr(16:84,4) = runmean(AMOC_time_345S_max_ESM_005_LOW(16:84,4),7);

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
    % SAMBA AMOC
    hold on
    % daily
    AMOC_time_SAMBA(:,1)         = runmean((upper_cell+17.3),540); % 3-yearrunning mean
    AMOC_time_SAMBA(1:10,1)      = NaN;
    AMOC_time_SAMBA(end-610:end) = NaN;    
    line_SAMBA                   = plot(time_daily_samba, AMOC_time_SAMBA);
    set(line_SAMBA,'color',[0.2, 0.2, 0.2],'LineWidth',  2.5,'linestyle','-');
    % #####################################################################
    % #####################################################################
    
    
    % #####################################################################
    % #####################################################################
    % AMOC 345S Max, 15-Year Running Mean

    % Ensemble Mean
    % AMOC 345S Max, 15-Year Running Mean
    AMOC_time_345S_max_ESM_005_LOW(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_345S          = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_345S,'color',[0.850, 0.325, 0.098],'LineWidth',6.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    % AMOC 345S Max by air-sea fluxes
    AMOC_time_345S_max_ESM_005_LOW_F(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_F(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_F(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_345S_F        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_345S_F,'color',[0    , 0.447, 0.741],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on

    % AMOC 345S Max by mesoscale mixing
    AMOC_time_345S_max_ESM_005_LOW_N(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_N(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_N(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_345S_N        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_345S_N,'color',[0.301, 0.745, 0.933],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    
    % AMOC 345S Max by volume change 
    AMOC_time_345S_max_ESM_005_LOW_dM(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_dM(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_dM(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_345S_dM       = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_345S_dM,'color',[0.929, 0.694, 0.125],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    
    % AMOC 345S Max by vertical mixing
    AMOC_time_345S_max_ESM_005_LOW_V(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_V(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_V(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_345S_V        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_345S_V,'color',[0.2, 0.7, 0.2],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    % AMOC 345S Max by vertical mixing
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_V_JCT(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_V_JCT(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_345S_V_JCT        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_345S_V_JCT,'color',[0.466, 0.674, 0.188],'LineWidth',2.0,'linestyle','--');
    clear AMOC_time0 AMOC_time1
    % AMOC 345S Max by vertical mixing
    hold on
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_V_JSA(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_V_JSA(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_345S_V_JSA        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_345S_V_JSA,'color',[0.2, 0.7, 0.2],'LineWidth',3.0,'linestyle','-.');
    clear AMOC_time0 AMOC_time1
    hold on
    
  
    % AMOC 345S Max by mesoscale and vertical mixing, and volume tendency
    AMOC_time_345S_max_ESM_005_LOW_N(:,1) = NaN; % remove IAPv4
    AMOC_time_345S_max_ESM_005_LOW_V(:,1) = NaN; % remove IAPv4
    AMOC_time_345S_max_ESM_005_LOW_dM(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_N(:,1:5),2),'movmean', 15)' + smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_V(:,1:5),2),'movmean', 15)' + smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_dM(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_N(:,1:5),2),'LOWESS', 15)'  + smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_V(:,1:5),2),'LOWESS', 15)'  + smoothdata(nanmean(AMOC_time_345S_max_ESM_005_LOW_dM(:,1:5),2),'LOWESS', 15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_345S_MV       = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_345S_MV,'color',[0.6, 0.6, 0.6],'LineWidth',4.5,'linestyle','-.');
    clear AMOC_time0 AMOC_time1
    hold on
    % #####################################################################
    % #####################################################################



    % #####################################################################
    % =========================
    % First legend (top-right)
    % =========================
    ax1  = gca; 
    leg1 = legend(ax1,[line_ESM_345S line_SAMBA], ...
                  'AMOC at 34.5\circS',...
                  'SAMBA 34.5\circS array',...
                  'Location','northeast','FontSize',18,'Orientation','vertical','NumColumns',1);
    legend(ax1,'boxoff')
    set(leg1,'FontSize',18)

    % #####################################################################


    set(ax1,'XLim',[1948 2023], ...
            'XTick',1950:10:2020, ...
            'XTickLabel',{'1950','1960','1970','1980','1990','2000','2010','2020'}, ...
            'YLim',[-0.5 30], ...
            'YTick',0:5:25, ...
            'YTickLabel',{'0','5','10','15','20','25','30'}, ...
            'FontSize',20);
        
    ylabel(ax1,'[ Sv ]','color','k','fontsize',20) 
    xlabel(ax1,' Year ','color','k','fontsize',20) 
    title( ax1,'a. AMOC decomp. at 34.5\circS','color','k','fontsize',22)
    grid(  ax1,'off')
% #########################################################################

    

   
% #########################################################################
subplot('position',pos{12})
% AMOC at 26N and decomposition

    % #####################################################################
    % AMOC 26N Max, 15-Year Running Mean
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
    line_25N_1957=plot((1957+ 9/12)',18.0,'s','MarkerSize',13,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1957,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on   
    line_25N_1981=plot((1981+ 7/12)',17.6,'s','MarkerSize',13,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1981,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    line_25N_1992=plot((1992+ 6/12)',18.6,'s','MarkerSize',13,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1992,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    line_25N_1998=plot((1998+ 1/12)',16.8,'s','MarkerSize',13,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_1998,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    hold on
    line_25N_2004=plot((2004+ 3/12)',16.1,'s','MarkerSize',13,'MarkerFaceColor', [1.0 0.75 0.8], 'MarkerEdgeColor', [1.0 0.75 0.8]);
    set(line_25N_2004,'color',[1.0 0.75 0.8], 'LineWidth', 2.0);
    % #####################################################################  
    % #####################################################################
    
  
    
    % #####################################################################
    % #####################################################################
    % Satellite Altimetary AMOC from Frajka-Williams 2015 ['http://dx.doi.org/10.1002/2015GL063220']
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
    
    % AMOC 26N Max by vertical mixing
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_V_JCT(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_V_JCT(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_26N_V_JCT        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_26N_V_JCT,'color',[0.466, 0.674, 0.188],'LineWidth',2.0,'linestyle','--');
    clear AMOC_time0 AMOC_time1
    % AMOC 26N Max by vertical mixing
    hold on
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_V_JSA(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_LOW_V_JSA(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_26N_V_JSA        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_26N_V_JSA,'color',[0.2, 0.7, 0.2],'LineWidth',3.0,'linestyle','-.');
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
    leg1 = legend(ax1,[line_ESM_26N line_RAPID line_FW2015 line_25N_2004 line_25Nmax_1957], ...
                  'AMOC at 26\circN',...
                  'RAPID 26\circN array',...
                  'Satellite altimetry',...
                  'Hydrographic at 25\circN',...
                  'Max. streamf. at 25\circN',...
                  'Location','northeast','FontSize',18,'Orientation','vertical','NumColumns',1);
    legend(ax1,'boxoff')
    set(leg1,'FontSize',18)


    set(ax1,'XLim',[1948 2023], ...
            'XTick',1950:10:2020, ...
            'XTickLabel',{'1950','1960','1970','1980','1990','2000','2010','2020'}, ...
            'YLim',[-0.5 27], ...
            'YTick',0:5:25, ...
            'YTickLabel',{'0','5','10','15','20','25'}, ...
            'FontSize',20);

    xlabel(ax1,' Year ','color','k','fontsize',20) 
    title( ax1,'b. AMOC decomp. at 26\circN','color','k','fontsize',22)
    grid(  ax1,'off')



% #########################################################################
subplot('position',pos{13})
% AMOC at 53N and decomposition

    % #####################################################################
    % Annual Mean Streamfunction
    % AMOC at 53N,              Ensemble Mean, 15-Year Running Mean
    AMOC_time_53N_max_ESM_005_LOW(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW(:,1:5),2),'movmean', 15)'; % Max at 53N
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW(:,1:5),2),'LOWESS',  15)'; % Max at 53N
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_53N          = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_53N,'color',[0.850, 0.325, 0.098],'LineWidth',5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    % #####################################################################

    
    
    % #################################################################
    % Patching of STD of AMOC-UP (IW layer)
    % STD of 15-Year running mean AMOC ESM
    for k = 1: size(AMOC_time_53N_max_ESM_005_LOW,2)
        AMOC_time_max_ESM_15_yr(:,k) = runmean(AMOC_time_53N_max_ESM_005_LOW(:,k),7);
    end 
    AMOC_time_max_ESM_15_yr(65:84,3) = runmean(AMOC_time_53N_max_ESM_005_LOW(65:84,3),7);
    AMOC_time_max_ESM_15_yr(16:84,4) = runmean(AMOC_time_53N_max_ESM_005_LOW(16:84,4),7);

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
    % OSNAP AMOC
    hold on
    line_OSNAP             = plot(tme_OSNAP,MOC_OSNAP_Mon);
    set(line_OSNAP,'color',[0.2, 0.2, 0.2],'LineWidth',  3.0,'linestyle','-');
    clear tme_OSNAP MOC_OSNAP_Mon
    % #####################################################################
    % #####################################################################

    % Ensemble Mean
    % AMOC 53N Max, 15-Year Running Mean
    AMOC_time_53N_max_ESM_005_LOW(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_53N          = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_53N,'color',[0.850, 0.325, 0.098],'LineWidth',6.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    % AMOC 53N Max by air-sea fluxes
    AMOC_time_53N_max_ESM_005_LOW_F(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_F(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_F(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_53N_F        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_53N_F,'color',[0    , 0.447, 0.741],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on

    % AMOC 53N Max by mesoscale mixing
    AMOC_time_53N_max_ESM_005_LOW_N(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_N(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_N(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_53N_N        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_53N_N,'color',[0.301, 0.745, 0.933],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    % AMOC 53N Max by vertical mixing
    AMOC_time_53N_max_ESM_005_LOW_V(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_V(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_V(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_53N_V        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_53N_V,'color',[0.2, 0.7, 0.2],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    % AMOC 53N Max by vertical mixing
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_V_JCT(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_V_JCT(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_53N_V_JCT        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_53N_V_JCT,'color',[0.466, 0.674, 0.188],'LineWidth',2.0,'linestyle','--');
    clear AMOC_time0 AMOC_time1
    % AMOC 53N Max by vertical mixing
    hold on
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_V_JSA(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_V_JSA(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_53N_V_JSA        = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_53N_V_JSA,'color',[0.2, 0.7, 0.2],'LineWidth',3.0,'linestyle','-.');
    clear AMOC_time0 AMOC_time1
    hold on
    
    
    
    % AMOC 53N Max by volume change 
    AMOC_time_53N_max_ESM_005_LOW_dM(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_dM(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_dM(:,1:5),2),'LOWESS',  15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_53N_dM       = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_53N_dM,'color',[0.929, 0.694, 0.125],'LineWidth',4.5,'linestyle','-');
    clear AMOC_time0 AMOC_time1
    hold on
    
    % AMOC 53N Max by mesoscale and vertical mixing, and volume tendency
    AMOC_time_53N_max_ESM_005_LOW_N(:,1) = NaN; % remove IAPv4
    AMOC_time_53N_max_ESM_005_LOW_V(:,1) = NaN; % remove IAPv4
    AMOC_time_53N_max_ESM_005_LOW_dM(:,1) = NaN; % remove IAPv4
    AMOC_time0(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_N(:,1:5),2),'movmean', 15)' + smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_V(:,1:5),2),'movmean', 15)' + smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_dM(:,1:5),2),'movmean', 15)'; 
    AMOC_time1(:,1)       = smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_N(:,1:5),2),'LOWESS', 15)'  + smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_V(:,1:5),2),'LOWESS', 15)'  + smoothdata(nanmean(AMOC_time_53N_max_ESM_005_LOW_dM(:,1:5),2),'LOWESS', 15)'; 
    AMOC_time0(1:8)       = NaN;
    AMOC_time0(end-6:end) = AMOC_time1(end-6:end,1);
    line_ESM_53N_MV       = plot(time_ann_IAP,AMOC_time0);                 
    set(line_ESM_53N_MV,'color',[0.6, 0.6, 0.6],'LineWidth',4.5,'linestyle','-.');
    clear AMOC_time0 AMOC_time1
    hold on
    % #####################################################################
    % #####################################################################


    % #####################################################################
    % =========================
    % First legend (top-right)
    % =========================
    ax1  = gca; 
    leg1 = legend(ax1,[line_ESM_53N line_OSNAP], ...
                  'AMOC within 40\circ-65\circN',...
                  'OSNAP subpolar array',...
                  'Location','northeast','FontSize',18,'Orientation','vertical','NumColumns',1);
    legend(ax1,'boxoff')
    set(leg1,'FontSize',18)
    % #####################################################################
    
    % =========================
    % Second legend (middle-right)
    % =========================
    ax2  = axes('Position',get(ax1,'Position'), ...
               'Color','none','XColor','none','YColor','none', ...
               'HitTest','off','PickableParts','none');  % not interactive
    leg2 = legend(ax2,[line_ESM_26N_F line_ESM_26N_N line_ESM_26N_V line_ESM_26N_V_JCT line_ESM_26N_V_JSA line_ESM_26N_dM line_ESM_26N_MV], ...
                  'Air-sea fluxes',...
                  'Meso. mixing',...
                  'Vertical mixing',...
                  'Vertical mixing, dCT/dz',...
                  'Vertical mixing, dSA/dz',...
                  'Volume tendency',...
                  'Mixing and vol. tend.',...
                  'Location','east','FontSize',16,'Orientation','vertical');
    title( leg2,'AMOC decomposition terms','fontsize',18','color',[0.850, 0.325, 0.098])
    legend(ax2,'boxoff')
    set(leg2,'FontSize',16)

    % =========================
    % Manual positioning
    % =========================
    %uistack(ax1,'top');
    
    set(leg2,'Position',[ixs+2.78*ixw+1*ixd iys+0.34*iyw 0.0*ixw 0.0*iyw]) 
    % #####################################################################



    set(ax1,'XLim',[1948 2023], ...
            'XTick',1950:10:2020, ...
            'XTickLabel',{'1950','1960','1970','1980','1990','2000','2010','2020'}, ...
            'YLim',[-0.5 27], ...
            'YTick',0:5:25, ...
            'YTickLabel',{'0','5','10','15','20','25'}, ...
            'FontSize',20);
        
    xlabel(ax1,' Year ','color','k','fontsize',20) 
    title( ax1,'c. AMOC decomp. within 40\circ-65\circN','color','k','fontsize',22)
    grid(  ax1,'off')
% #########################################################################



% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
% #########################################################################
% #########################################################################




