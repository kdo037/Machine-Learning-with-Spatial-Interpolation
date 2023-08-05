latitude = [33.83062; 34.10002; 34.06659; 34.106678; 34.1365; 34.2431; 34.1326; 34.05977; 33.99958; 33.95507; 34.056416];
longitude = [-117.93845; -117.49201; -118.22688; -117.274063; -117.92391; -117.27235; -118.1272; -117.14731; -117.41601; -118.43049; -117.598216];
locations = ["anaheim", "fontana", "la", "sb", "azusa", "crestline", "pasadena", "redlands", "rubidoux","LAX","ONT"];

latitude = [33.83061, 34.13648, 33.92077, 33.90145, 34.24313, 34.10015, 34.14437, ...
    33.92505, 33.67653, 33.95507, 34.06653, 33.80250, 33.99636, ...
    33.63005, 34.13265, 33.78933, 34.06698, 34.05965, 34.19920, 33.99952, ...
    34.01029, 34.38337, 34.10668, 34.10367, 33.58302];
longitude = [-117.93850, -117.92392, -116.85841, -118.20499, -117.27230, -117.49198, -117.85038, ...
    -117.95259, -117.33104, -118.43049, -118.22676, -118.22000, -117.49240, ...
    -117.67588, -118.12714, -117.22764, -117.75138, -117.14734, -118.53275, -117.41595, ...
    -118.06850, -118.52839, -117.27406, -117.62906, -117.07220];
locations = ["Anaheim","Azusa","Banning","Compton","Crestline","Fontana","Glendora", ...
    "La Habra","Lake Elsinore","LAX","LA North Main ST","Long Beach","Mira Loma", ...
    "Mission Viejo","Pasadena","Perris","Pomona","Redlands","Reseda","Rubidoux", ...
    "San Gabriel","Santa Clarita","San Bernardino","Upland","Winchester"];

% CSV observation import
link = "/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/PST/CMAQ Eval Stats/ozone/2017/";
% Anaheim
anaheim = readtable(link+"Anaheim_O3_PST.csv");
obs = readtable(link+"Anaheim_O3_PST.csv");
% Azusa
azusa = readtable(link+"Azusa_O3_PST.csv");
% Banning
banning = readtable(link+"Banning_O3_PST.csv");
% Compton
compton = readtable(link+"Compton_O3_PST.csv");
% Crestline
crestline = readtable(link+"Crestline_O3_PST.csv");
% Fontana
fontana = readtable(link+"Fontana_O3_PST.csv");
% Glendora
glendora = readtable(link+"Glendora_O3_PST.csv");
% La Habra
laHabra = readtable(link+"La Habra_O3_PST.csv");
% Lake Elsinore
lakeElsinore = readtable(link+"Lake Elsinore_O3_PST.csv");
% LAX
lax = readtable(link+"LAX_O3_PST.csv");
% Los Angeles
la = readtable(link+"LA North Main ST_O3_PST.csv");
% LB
lb = readtable(link+"Long Beach_O3_PST.csv");
% Mira Loma
miraLoma = readtable(link+"Mira Loma_O3_PST.csv");
% Mission Viejo
missionViejo = readtable(link+"Mission Viejo_O3_PST.csv");
% pasadena
pasadena = readtable(link+"Pasadena_O3_PST.csv");
% Perris
perris = readtable(link+"Perris_O3_PST.csv");
% Pomona
pomona = readtable(link+"Pomona_O3_PST.csv");
% redlands
redlands = readtable(link+"Redlands_O3_PST.csv");
% Reseda
reseda = readtable(link+"Reseda_O3_PST.csv");
% Rubidoux
rubidoux = readtable(link+"Rubidoux_O3_PST.csv");
% San Gabriel
sanGabriel = readtable(link+"San Gabriel_O3_PST.csv");
% Santa Clarita
santaClarita = readtable(link+"Santa Clarita_O3_PST.csv");
% San Bernardino
sb = readtable(link+"San Bernardino_O3_PST.csv");
% Upland
upland = readtable(link+"Upland_O3_PST.csv");
% Winchester
winchester = readtable(link+"Winchester_O3_PST.csv");

% % Anaheim
% obs = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/UTC/CMAQ Eval Stats_9Sites/2017/Anaheim_O3_stats.csv');
% anaheim = readtable('/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/Stats/UTC/CMAQ Eval Stats_9Sites/2017/Anaheim_O3_stats.csv');
obs_date = "";
obs_O3 = [];
m_O3 = [];
anaheimO3=[];azusaO3=[];banningO3=[];comptonO3=[];crestlineO3=[];fontanaO3=[];glendoraO3=[];laHabraO3=[];lakeElsinoreO3=[];laxO3=[];laO3=[];lbO3=[];
miraLomaO3=[];missionViejoO3=[];pasadenaO3=[];perrisO3=[];pomonaO3=[];redlandsO3=[];resedaO3=[];rubidouxO3=[];sanGabrielO3=[];santaClaritaO3=[];sbO3=[];uplandO3=[];winchesterO3=[];

xloc = [];
yloc = [];

for i=1:length(obs.ObsDate)
    if length(num2str(obs.CMAQTime(i))) == 1
       obs_t = "00:00:00";
    elseif length(num2str(obs.CMAQTime(i))) == 5
        temp = num2str(obs.CMAQTime(i));
        obs_t = "0"+temp(1)+":"+temp(2:3)+":"+temp(4:5);
    else
        temp = num2str(obs.CMAQTime(i));
        obs_t = temp(1:2)+":"+temp(3:4)+":"+temp(5:6);
    end
   obs_date(i) =  datestr(obs.CMAQDate(i))+" "+obs_t;
   obs_O3(i) = obs.ObsO3(i);
   m_O3(i) = obs.CMAQO3(i);
   
   azusaO3(i) = azusa.ObsO3(i);
   crestlineO3(i) = crestline.ObsO3(i);
   fontanaO3(i) = fontana.ObsO3(i);
   laO3(i) = la.ObsO3(i);
   pasadenaO3(i) = pasadena.ObsO3(i);
   redlandsO3(i) = redlands.ObsO3(i);
   rubidouxO3(i) = rubidoux.ObsO3(i);
   sbO3(i) = sb.ObsO3(i);
   anaheimO3(i) = anaheim.ObsO3(i);

   anaheimO3(i) = anaheim.ObsO3(i);
   azusaO3(i) = azusa.ObsO3(i);
   banningO3(i) = banning.ObsO3(i);
   comptonO3(i) = compton.ObsO3(i);
   crestlineO3(i) = crestline.ObsO3(i);
   fontanaO3(i) = fontana.ObsO3(i);
   glendoraO3(i) = glendora.ObsO3(i);
   laHabraO3(i) = laHabra.ObsO3(i);
   lakeElsinoreO3(i) = lakeElsinore.ObsO3(i);
   laxO3(i) = lax.ObsO3(i);
   laO3(i) = la.ObsO3(i);
   lbO3(i) = lb.ObsO3(i);
   miraLomaO3(i) = miraLoma.ObsO3(i);
   missionViejoO3(i) = missionViejo.ObsO3(i);
   pasadenaO3(i) = pasadena.ObsO3(i);
   perrisO3(i) = perris.ObsO3(i);
   pomonaO3(i) = pomona.ObsO3(i);
   redlandsO3(i) = redlands.ObsO3(i);
   resedaO3(i) = reseda.ObsO3(i);
   rubidouxO3(i) = rubidoux.ObsO3(i);
   sanGabrielO3(i) = sanGabriel.ObsO3(i);
   santaClaritaO3(i) = santaClarita.ObsO3(i);
   sbO3(i) = sb.ObsO3(i);
   uplandO3(i) = upland.ObsO3(i);
   winchesterO3(i) = winchester.ObsO3(i);
end
% load gridcro2d to find the closest LAT and LON corresponding to the
% specific location
LAT = ncread('GRIDCRO2D_160702_20170422.nc', 'LAT');
LON = ncread('GRIDCRO2D_160702_20170422.nc', 'LON');

% finding the closest grid cell
tol = 0.025;
loc_LAT = 33.83062;
loc_LON = -117.93845;

for i=1:size(LAT,1)
    for j=1:size(LAT,2)
        if (abs(LAT(i,j) - loc_LAT) < tol) && (abs(LON(i,j) - loc_LON) < tol)
            x = i;
            y = j;
            break;
        end
    end
end

% find location array
for loc=1:length(latitude)
    for i=1:size(LAT,1)
        for j=1:size(LAT,2)
            if (abs(LAT(i,j) - latitude(loc)) < tol) && (abs(LON(i,j) - longitude(loc)) < tol)
                xloc(loc) = i;
                yloc(loc) = j;
                break;
            end
        end
    end
end
% load CONC from CMAQ simulation
s_date = datetime("2017-05-01");
t_O3 = []; % time series of CMAQ ozone
t_d = [];
t_t = "";
count = 1;
correct = 0;
diff = [];
obs_model_diff = {};
utc_date_time = "";
pst_date_time = "";
save_name = "";
for duration = 1:154
    d = yyyymmdd(s_date+duration-1);
    d_str = num2str(d);
    d_str = d_str(5:end);
    file = "/home/khanh/seagate10tb/2017_Reanalysis/AQMD/Summer2017/CCTM_CONC_v521_gcc_160702_2017"+d_str+".nc";
    O3 = ncread(file, 'O3');
    dt = ncread(file, 'TFLAG');
    % ncdisp('/home/khanh/AQMD/CMAQ_data/summer_2017/CCTM_CONC/CCTM_CONC_v521_gcc_160702_20170501.nc');
    if size(O3,4) < 24
        msg = 'This day is less than 24 hours';
        error(msg)
        break; %#ok<UNRCH>
    end
    for t=1:24
        CMAQ_O3 = [];
        t_O3(size(t_O3,2)+1) = double(O3(x,y,1,t));
        jdate = rem(dt(1,1,t),1000);
        jyear = dt(1,1,t)/1000;
        datetime(jyear,1,jdate);
        t_d = [t_d; datetime(jyear,1,jdate)]; 
        t_t = [t_t; dt(2,1,t)];
        C_O3=O3(x,y,1,t);
%         locations = ["anaheim", "fontana", "la", "sb", "azusa", "crestline", "pasadena", "redlands", "rubidoux","LAX","ONT"];
        for loc=1:length(xloc)
            CMAQ_O3(loc) = O3(xloc(loc),yloc(loc),1,t);
        end
        % saveas(gcf,'Fontana','epsc')
%         im=O3(:,:,1,t);
%         h = imagesc(LON(:,1),LAT(1,:),im);
%         c= colorbar; colormap('jet');caxis([0,0.1]);
%         ylabel(c, 'Ozone Concentrations [ppmV]')
%         xlim([min(LON(:,1)), max(LON(:,1))])
%         ylim([min(min(LAT(1,:))), max(max(LAT(1,:)))])
%         s2 = shaperead('dc33871f-031d-4dc2-bec7-f43f2f02e99e202044-1-h8gavz.0eutq.shp');
%         hold on
%         plot([s2.X],[s2.Y],'k','LineWidth',2);
%         s1 = shaperead('cb_2018_us_county_20m.shp');
%         plot([s1.X],[s1.Y],'b')
%         scatter(longitude,latitude,'k')
%         locations = ["anaheim", "fontana", "la", "sb", "azusa", "crestline", "pasadena", "redlands", "rubidoux","LAX","ONT"];
        % convert to PST
        sd = num2str(d);
        st = t-1;
        da = sd(1:4)+"-"+d_str(1:2)+"-"+d_str(3:4) + " "+st+":00:00";
        sdt1 = datetime(da,'TimeZone','UTC');
        locations = ["Anaheim","Azusa","Banning","Compton","Crestline","Fontana","Glendora", ...
            "La Habra","Lake Elsinore","LAX","LA North Main ST","Long Beach","Mira Loma", ...
            "Mission Viejo","Pasadena","Perris","Pomona","Redlands","Reseda","Rubidoux", ...
            "San Gabriel","Santa Clarita","San Bernardino","Upland","Winchester"];
        if sdt1 == obs_date(count)
%             disp('test')
            correct = correct + 1;
            diff(count) = obs_O3(count)-C_O3;
   
            obs_model_diff{count}{1} = CMAQ_O3(1) - anaheimO3(count);
            obs_model_diff{count}{2} = CMAQ_O3(2) - azusaO3(count);
            obs_model_diff{count}{3} =  CMAQ_O3(3) - banningO3(count);
            obs_model_diff{count}{4} =  CMAQ_O3(4) - comptonO3(count);
            obs_model_diff{count}{5} =  CMAQ_O3(5) - crestlineO3(count);
            obs_model_diff{count}{6} =  CMAQ_O3(6) - fontanaO3(count);
            obs_model_diff{count}{7} =  CMAQ_O3(7) - glendoraO3(count);
            obs_model_diff{count}{8} =  CMAQ_O3(8) -laHabraO3(count);
            obs_model_diff{count}{9} =  CMAQ_O3(9) - lakeElsinoreO3(count);
            obs_model_diff{count}{10} = CMAQ_O3(10) - laxO3(count);
            obs_model_diff{count}{11} = CMAQ_O3(11) - laO3(count);
            obs_model_diff{count}{12} = CMAQ_O3(12) - lbO3(count);
            obs_model_diff{count}{13} =  CMAQ_O3(13) - miraLomaO3(count);
            obs_model_diff{count}{14} =  CMAQ_O3(14) - missionViejoO3(count);
            obs_model_diff{count}{15} =  CMAQ_O3(15) - pasadenaO3(count);
            obs_model_diff{count}{16} =  CMAQ_O3(16) - perrisO3(count);
            obs_model_diff{count}{17} =  CMAQ_O3(17) - pomonaO3(count);
            obs_model_diff{count}{18} =  CMAQ_O3(18) - redlandsO3(count);
            obs_model_diff{count}{19} =  CMAQ_O3(19) - resedaO3(count);
            obs_model_diff{count}{20} = CMAQ_O3(20) - rubidouxO3(count); 
            obs_model_diff{count}{21} = CMAQ_O3(21) - sanGabrielO3(count);
            obs_model_diff{count}{22} = CMAQ_O3(22) - santaClaritaO3(count);
            obs_model_diff{count}{23} =  CMAQ_O3(23) - sbO3(count);
            obs_model_diff{count}{24} =  CMAQ_O3(24) - uplandO3(count);
            obs_model_diff{count}{25} =  CMAQ_O3(25) - winchesterO3(count);
            
            utc_date_time(count) = sdt1;
            sdt1.TimeZone = 'America/Los_Angeles';
            if length(datestr(sdt1)) == 20
                pst_date_time(count) = datestr(sdt1);
            else
                pst_date_time(count) = datestr(sdt1)+" 00:00:00";
            end
            sformat = datestr(sdt1);
            if length(datestr(sdt1)) == 20
                save_name(count) = sformat(1:11)+"_"+sformat(13:14)+"_"+sformat(16:17)+"_"+sformat(19:20);
            else
                save_name(count) = datestr(sdt1)+"_00_00_00";
            end
        end
        count = count + 1;
%         sdt = datetime(da,'TimeZone','UTC');
%         sdt.TimeZone = 'America/Los_Angeles';
%         if length(datestr(sdt)) == 20
%             title(datestr(sdt))
%         else
%             title(datestr(sdt)+" 00:00:00")
%         end
%         ax = gca;
%         ax.YDir = 'normal';
% %         pause(0.01)
%         sformat = datestr(sdt);
%         if length(sformat) == 20
%             title_name = sformat(1:11)+"_"+sformat(13:14)+"_"+sformat(16:17)+"_"+sformat(19:20)+".epsc";
%         else
%             title_name = sformat(1:11)+"_00:00:00.epsc";
%         end
% %         fname = '/home/khanh/Temp/CMAQ_paper/plots';
% %         saveas(gcf, fullfile(fname, title_name),'epsc')
%         hold off
    end

end

for i=1:count-1
    s2 = shaperead('dc33871f-031d-4dc2-bec7-f43f2f02e99e202044-1-h8gavz.0eutq.shp');
    plot([s2.X],[s2.Y],'k','LineWidth',2);
    hold on
    s1 = shaperead('cb_2018_us_county_20m.shp');
    plot([s1.X],[s1.Y],'k')
    xlim([min(LON(:,1)), max(LON(:,1))])
    ylim([min(min(LAT(1,:))), max(max(LAT(1,:)))])
    s=scatter(longitude(1:25),latitude(1:25),50,cell2mat(obs_model_diff{i})','filled');
%     temp = cell2mat(obs_model_diff{i});
%     scatter(longitude(1:3),latitude(1:3),50,temp(1:3)','filled');
%     scatter(longitude(5:9),latitude(5:9),50,temp(5:9)','filled');
    cb = colorbar; colormap(flipud(brewermap([],'RdBu'))); ylabel(cb, 'Differences (Model-Observation) [ppmV]');caxis([-0.03,0.03]);s.MarkerEdgeColor='k'; s.MarkerEdgeAlpha=0.3;
%     pause(0.01)
    xlabel(pst_date_time(i))
    title('Model and Observation Differences of $O_{3}$', 'Interpreter','latex')
    fname = '/home/khanh/Temp/CMAQ_paper/plots/differences';
%     print -depsc2 -painters pst_date_time(i).eps
%     saveas(gcf, fullfile(fname, save_name(i)),'epsc')
    exportgraphics(gcf, fullfile(fname, save_name(i)+'.jpg'),'Resolution',500)
    hold off
end
