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
%Plotting 1.2 - Monthly AMOC Upper Limb Strength within 2004-2023

% #########################################################################
% #########################################################################
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.25; ixe = 0.25;  ixd = 0.06; ixw = (1-ixs-ixe-0*ixd)/1;
   iys = 0.10; iye = 0.10;  iyd = 0.06; iyw = (1-iys-iye-0*iyd)/1;
   pos{31}  = [ixs          iys+0*iyw+0*iyd  ixw    iyw]; 
% ######################################################################### 
    clear color color0 
    color0=cbrewer('div', 'RdBu', 40,'pchip');
    color0=color0(size(color0,1):-1:1,:);
% #########################################################################

      
% #########################################################################
% #########################################################################
subplot('position',pos{31})

    % #####################################################################
    % #####################################################################
    % Satellite Altimetary AMOC from Frajka-Williams 2015 ['http://dx.doi.org/10.1002/2015GL063220']
    line_FW2015           = plot(tme_AMOC_FW2015,AMOC_FW2015);
    set(line_FW2015,'color',[0.694, 0.384, 0.556],'LineWidth',  5.0,'linestyle','-');
    clear recon dates AMOC_FW2015 tme_AMOC_FW2015
    % #####################################################################
    % #####################################################################
    

    
    % #####################################################################
    % #####################################################################
    % RAPID AMOC (CORRECTED USING IW LAYER DENSITY)
    hold on
    line_RAPID=plot(decimal_year(2:3:end-2,1),rapid_main);
    set(line_RAPID,'color',[0.1, 0.1, 0.1],'LineWidth',  4.5,'linestyle','-'); 
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
    % Annual Mean of 12-Month Avergaed Streamfunction
    % AMOC Upper Limb, 10N-40N, Ensemble Mean, 5-Year Running Mean of Monthly Mean
    AMOC_time_subtropical_IW_005(:,1) = NaN; % Remove IAPv4
    hold on
    AMOC_main(:,1)        = smoothdata(nanmean(AMOC_time_subtropical_IW_005_12Mon(:,1:4),2),'movmean', 60)';
    AMOC_main(1:29)       = NaN;  
    AMOC_main(end-29:end) = NaN;
    line_ESM_STIW         = plot(time_mon_IAP,AMOC_main);    
    set(line_ESM_STIW,'color',[0    , 0.447, 0.741],'LineWidth',6.0,'linestyle','-');
    clear AMOC_main AMOC_edge
    
    
    % AMOC Subpolar, 40N-60N,   Ensemble Mean, 5-Year Running Mean
    AMOC_time_subpolar_DW_005(:,1) = NaN; % Remove IAPv4
    hold on
    AMOC_main(:,1)        = smoothdata(nanmean(AMOC_time_subpolar_DW_005_12Mon(:,1:4),2),'movmean', 60)'; % Max at 26N
    AMOC_main(1:29)       = NaN;
    AMOC_main(end-29:end) = NaN;
    line_ESM_SPDW         = plot(time_mon_IAP,AMOC_main);    
    set(line_ESM_SPDW,'color',[0.301, 0.745, 0.933],'LineWidth',6.0,'linestyle','-');
    clear AMOC_main AMOC_edge
    
 
    % AMOC at 26N,              Ensemble Mean, 5-Year Running Mean
    AMOC_time_26N_max_ESM_005(:,1) = NaN; % remove IAPv4
    hold on
    AMOC_main(:,1)        = smoothdata(nanmean(AMOC_time_26N_max_ESM_005_12Mon(:,1:4),2),'movmean', 60)'; % Max at 26N
    AMOC_main(1:29)       = NaN;
    AMOC_main(end-29:end) = NaN;
    line_ESM_26N          = plot(time_mon_IAP,AMOC_main);                 
    set(line_ESM_26N,'color',[0.850, 0.325, 0.098],'LineWidth',6.5,'linestyle','-');
    clear AMOC_main AMOC_edge
    % #####################################################################
    % #####################################################################
    
    
    
    % #####################################################################    
    leg=legend([line_ESM_26N line_ESM_STIW line_ESM_SPDW line_RAPID line_OSNAP line_FW2015],...
                  'AMOC at 26\circN',...
                  'AMOC-Up (max., 10\circN - 40\circN)',...
                  'AMOC-Up (max., 40\circN - 60\circN)',...
                  'RAPID 26\circN array',...
                  'OSNAP subpolar array',...
                  'Satellite altimetry',...
                  'Location','northeast','fontsize',20,'Orientation','vertical','NumColumns',1); %line_IW_IAPv4 'AMOC-upper limb, IAPv4',...
    set(leg,'fontsize',20)
    hold on
    %title(leg,'AMOC Strength','fontsize',20','color','k')
    legend('boxoff')
    % #####################################################################


    xlim([2004 2023])
    ylim([14 20]);
    set(gca,'XTick',2004:3:2023)
    set(gca,'XTickLabel',{'2004','2007','2010','2013','2016','2019','2022'},'fontsize',22)
    set(gca,'YTick',14:1:20)
    set(gca,'YTickLabel',{'14','15','16','17','18','19','20'},'fontsize',22)
    grid on
    set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.05,'GridLineStyle','-')
    ylabel('[ Sv ]','color','k','fontsize',22) % left y-axis
    xlabel(' Year ','color','k','fontsize',22) 
    title('AMOC strength during 2004-2023','color','k','fontsize',24)
       

% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/8_AMOC_Streamfunction/')
% #########################################################################
% #########################################################################


