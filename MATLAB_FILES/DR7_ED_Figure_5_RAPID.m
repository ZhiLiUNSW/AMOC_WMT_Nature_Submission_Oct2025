%% ########################################################################
%% PLOTTING AMOC STREAMFUNCTION FROM RAPID ARRAYS, [ Sv ]

% #########################################################################
% #########################################################################


% #########################################################################
% #########################################################################
%% 1. RAPID-AMOC Streamfunction in Depth / Density Coordinate
clc; clear

% #########################################################################
% #########################################################################
% RAPID AMOC v2023.1a 10-day mean
% RAPID AMOC Depth
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/9_AMOC_Subtropical_RAPID/v2023.1a_2004April_2023Feb/')
stream_depth_10day = ncread('meridional_transports.nc','stream_depth'); % Streamfunction in depth coordinates
amoc_depth_10day   = ncread('meridional_transports.nc','amoc_depth');   % Maximum of streamfunction evaluated in depth coordinates
depth_10day        = ncread('meridional_transports.nc','depth');        % Depth coordinates

% RAPID AMOC Density
stream_sigma_10day = ncread('meridional_transports.nc','stream_sigma'); % Streamfunction in density coordinates
amoc_sigma_10day   = ncread('meridional_transports.nc','amoc_sigma');   % Maximum of streamfunction evaluated in sigma0 coordinates
sigma_10day        = ncread('meridional_transports.nc','sigma0');       % Sigma0 coordinates
  
% Depth / Sigma0 with the maximum streamfunction
 for year = 1:size(stream_sigma_10day,2)
     AMOC_Rapid_depth0(year,1) = depth_10day(find(amoc_depth_10day(year,1)==squeeze(stream_depth_10day(:,year))),1);
     AMOC_Rapid_sigma0(year,1) = sigma_10day(find(amoc_sigma_10day(year,1)==squeeze(stream_sigma_10day(:,year))),1);
 end
 clear year
 
% Correct AMOC Sstreangth and Sigma0 with the maximum streamfunction
 for year = 1:size(stream_sigma_10day,2)
     amoc_sigma_10day_corr(year,1)  = max(squeeze(stream_sigma_10day(131:631,year))); % 26.6/27.0-28.0
     if length(find(amoc_sigma_10day_corr(year,1)==squeeze(stream_sigma_10day(:,year)))) > 2
        amoc_sigma_10day_corr(year,1)  = max(squeeze(stream_sigma_10day(131:580,year))); % 26.6-27.9
        AMOC_Rapid_sigma0_corr(year,1) = sigma_10day(find(amoc_sigma_10day_corr(year,1)==squeeze(stream_sigma_10day(:,year))),1);
     else
        AMOC_Rapid_sigma0_corr(year,1) = sigma_10day(find(amoc_sigma_10day_corr(year,1)==squeeze(stream_sigma_10day(:,year))),1);
     end
 end
 clear year
     
% Time  
tme_RAPID_10day   = ncread('meridional_transports.nc','time');       % days since 1950-01-01
   
% tme_RAPID_10day = (2004 +(tme_RAPID_10day - ((50+1+1+1+1)*365))/365)';
        % #############################################################
        % Convert to datetime using 1950-01-01 as the origin
        base_date = datetime(1950,1,1);
        dates     = base_date + days(tme_RAPID_10day);

        % Extract year, and calculate day of year
        clear year
        year_val      = year(dates);
        start_of_year = datetime(year_val,1,1);
        days_elapsed  = days(dates - start_of_year);

        % Determine if leap year to get correct total days
        is_leap       = eomday(year_val, 2) == 29;
        days_in_year  = 365 + is_leap;

        % Decimal year = year + (elapsed_days / total_days)
        decimal_year  = year_val + days_elapsed ./ days_in_year;
        clear year_val days_elapsed days_in_year is_leap start_of_year base_date dates
        % #############################################################

% Monthly AMOC averages from 10-day mean
count = 1;
for month = 1:3:length(amoc_depth_10day)-2
    amoc_depth_mon(count,1)      = nanmean(amoc_depth_10day((count-1)*3+1:(count-1)*3+3,1),1);
    amoc_sigma_mon(count,1)      = nanmean(amoc_sigma_10day((count-1)*3+1:(count-1)*3+3,1),1);
    amoc_sigma_mon_corr(count,1) = nanmean(amoc_sigma_10day_corr((count-1)*3+1:(count-1)*3+3,1),1);
    count = count + 1;
end
clear month year count  
tme_RAPID_mon = (2004 + (tme_RAPID_10day(2:3:end-2,1) - ((50+1+1+1+1)*365))/365)'; % Time series from April 2004 to Feb 2023

amoc_depth_mon       = runmean(amoc_depth_mon,30);
amoc_sigma_mon       = runmean(amoc_sigma_mon,30);
amoc_sigma_mon_corr  = runmean(amoc_sigma_mon_corr,30);
% #########################################################################
% #########################################################################
     

% 1.3 RAPID-AMOC in Density Coordinate - AMOC Strength Corrected to Below 27

% #########################################################################
% #########################################################################
   figure('Color',[1 1 1]);  %create a new figure of white color background
   ixs = 0.06; ixe = 0.11;  ixd = 0.11; ixw = (1-ixs-ixe-1*ixd)/2;
   iys = 0.10; iye = 0.10;  iyd = 0.12; iyw = (1-iys-iye-1*iyd)/2;
   pos{11}  = [ixs          iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{21}  = [ixs+ixw+ixd  iys+1*iyw+1*iyd   ixw 1.0*iyw]; 
   pos{31}  = [ixs          iys+0*iyw+0*iyd   ixw 2.0*iyw+1*iyd]; 
   pos{41}  = [ixs+ixw+ixd  iys+0*iyw+0*iyd   ixw+0.08 2.0*iyw+1*iyd]; 
  
   
% ######################################################################### 
    clear color color0 
    color0=cbrewer('div', 'RdBu', 40,'pchip');
    color0=color0(21:-1:1,:);
% #########################################################################

      
% #########################################################################
subplot('position',pos{31})
      %stream_sigma_10day(1:20,1:20)=NaN;
      % sigma_10day needs to be interpolated to regular density intervals to enable mapping correctly
       [time_org,rho_org]       = meshgrid(decimal_year, sigma_10day);
       [time_reg,rho_reg]       = meshgrid(decimal_year, (1022:0.02:1028)');
       stream_sigma_10day_map   = griddata(time_org,rho_org,stream_sigma_10day(:,:),time_reg,rho_reg,'linear');
       clear time_org rho_org time_reg rho_reg %stream_sigma_10day 
           
      imagesc(decimal_year,(1022:0.02:1028)',stream_sigma_10day_map,'AlphaData',~isnan(stream_sigma_10day_map));
      
      % plot the depth/sigma0 of the maximum streamfunction
      hold on
      line_RAPID_10day      = plot(decimal_year(1:end,1),AMOC_Rapid_sigma0);
      set(line_RAPID_10day,     'color',[0.2, 0.4, 0.6],'LineWidth',  2.5, 'linestyle','-'); 
      hold on
      line_RAPID_10day_corr = plot(decimal_year(1:end,1),runmean(AMOC_Rapid_sigma0_corr,0));
      set(line_RAPID_10day_corr,'color',[0.4, 0.9, 0.4],'LineWidth',  1.5, 'linestyle','-'); 
      
      xlim([2004 2024])
      set(gca,'XTick',2004:2:2024)
      set(gca,'XTickLabel',{'2004','2006','2008','2010','2012','2014','2016','2018','2020','2022','2024'},'FontSize',20)
      
      ylim([1023 1028])
      set(gca,'YTick',1022:1:1029)
      set(gca,'YTickLabel',{'22','23','24','25','26','27','28','29'},'FontSize',20)
      set(gca,'tickdir','in','box','on')
      grid off
      set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
      colormap(gca,color0)
      caxis([0 30]);  
      ylabel('Potential density [ kg m^{-3} ]','color','k','fontsize',20) % left y-axis
      xlabel(' Latitude ','color','k','fontsize',20) 
      title('a. AMOC Streamfunction by Density','fontsize',22,'FontWeight','bold')


      hBar21 = colorbar('EastOutside');
      get(hBar21, 'Position') ;
      set(hBar21, 'Position', [ixs+1*ixw+0*ixd+0.010 iys+0.5*iyw+0*iyd 0.013 1.0*iyw+1*iyd]);
      set(hBar21,'ytick',-30:5:30,'yticklabel',{'<-30','-25','-20','-15','-10','-5','0','5','10','15','20','25','>30'},'fontsize',21,'FontName','Arial','LineWidth',1.2,'TickLength',0.05);
% #########################################################################

    

      
% #########################################################################
% #########################################################################
subplot('position',pos{41})

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
    % RAPID AMOC
    hold on
    line_RAPID_10day=plot(decimal_year(1:end,1),amoc_sigma_10day);
    set(line_RAPID_10day,   'color',[0.7, 0.7, 0.7],'LineWidth',  2.0,'linestyle','-');

    hold on
    line_RAPID_dep=plot(decimal_year(2:3:end-2,1),amoc_depth_mon);
    set(line_RAPID_dep,'color',[0.2, 0.2, 0.2],'LineWidth',  5.0,'linestyle','-'); 
    
    hold on
    line_RAPID_mon=plot(decimal_year(2:3:end-2,1),amoc_sigma_mon);
    set(line_RAPID_mon,     'color',[0.9, 0.4, 0.4],'LineWidth',  5.0,'linestyle','-'); 
    
    hold on
    line_RAPID_mon_corr=plot(decimal_year(2:3:end-2,1),amoc_sigma_mon_corr);
    set(line_RAPID_mon_corr,'color',[0.4, 0.6, 0.4],'LineWidth',  5.0,'linestyle','-'); 
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
    set(line_OSNAP,'color',[0.5, 0.5, 0.5],'LineWidth',  3.5,'linestyle','-');
    clear tme_OSNAP MOC_OSNAP_Mon
    % #####################################################################
    % #####################################################################
    
    

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
    leg=legend([line_RAPID_mon line_RAPID_mon_corr line_RAPID_dep line_RAPID_10day line_OSNAP line_FW2015 line_25N_1957 line_25Nmax_1957],...
                  'RAPID 26\circN array (monthly mean)',...
                  'RAPID 26\circN array (monthly mean, corrected)',...
                  'RAPID 26\circN array (monthly mean, depth)',...
                  'RAPID 26\circN array (10-day mean)',...
                  'OSNAP subpolar array',...
                  'Satellite altimetry',...
                  'Hydrographic sections at 25\circN',...
                  'Max. streamfunction at 25\circN',...
                  'Location','northwest','fontsize',16,'Orientation','vertical','NumColumns',1);
    set(leg,'fontsize',18)
    hold on
    legend('boxoff')
    % #####################################################################
    

    xlim([1990 2023])
    ylim([11.3 26.0]);
    set(gca,'XTick',1950:10:2020)
    set(gca,'XTickLabel',{'1950','1960','1970','1980','1990','2000','2010','2020'},'fontsize',22)
    set(gca,'YTick',12:1.5:28)
    set(gca,'YTickLabel',{'12','13.5','15','16.5','18','19.5','21','22.5','24','25.5','27'},'fontsize',22)
    grid on
    set(gca,'GridColor',[.8 .8 .8],'GridAlpha',0.2,'GridLineStyle','-')
    ylabel('[ Sv ]','color','k','fontsize',22) % left y-axis
    xlabel(' Year ','color','k','fontsize',22) 
    title('b. AMOC Strength at 26\circN','color','k','fontsize',24)
       
% #########################################################################
cd('/Users/z5195509/Documents/7_AMOC_Proxy and Variability/9_AMOC_Subtropical_RAPID/')
% #########################################################################
% #########################################################################

