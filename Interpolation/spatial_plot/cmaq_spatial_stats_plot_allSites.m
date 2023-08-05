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
names = ["Anaheim","Azusa","Banning","Compton","Crestline","Fontana","Glendora", ...
    "La Habra","Lake Elsinore","LAX","LA North Main ST","Long Beach","Mira Loma", ...
    "Mission Viejo","Pasadena","Perris","Pomona","Redlands","Reseda","Rubidoux", ...
    "San Gabriel","Santa Clarita","San Bernardino","Upland","Winchester"];

% CSV observation import
link = "/media/khanh/Seagate Backup Plus Drive1/Shared Drives/Air Quality Modeling and Exposure Lab/AQMD Ozone Project/Evaluation/policy_relavant/STATS/CMAQ/Ozone/allSites/2017_Reanalysis/MDA8/";
% % Anaheim
% anaheim = readtable(link+"Anaheim_60ppb_eval_stats.csv");
% obs = readtable(link+"Anaheim_60ppb_eval_stats.csv");
% % Azusa
% azusa = readtable(link+"Azusa_60ppb_eval_stats.csv");
% % Banning
% banning = readtable(link+"Banning_60ppb_eval_stats.csv");
% % Compton
% compton = readtable(link+"Compton_60ppb_eval_stats.csv");
% % Crestline
% crestline = readtable(link+"Crestline_60ppb_eval_stats.csv");
% % Fontana
% fontana = readtable(link+"Fontana_60ppb_eval_stats.csv");
% % Glendora
% glendora = readtable(link+"Glendora_60ppb_eval_stats.csv");
% % La Habra
% laHabra = readtable(link+"La Habra_60ppb_eval_stats.csv");
% % Lake Elsinore
% lakeElsinore = readtable(link+"Lake Elsinore_60ppb_eval_stats.csv");
% % LAX
% lax = readtable(link+"LAX_60ppb_eval_stats.csv");
% % Los Angeles
% la = readtable(link+"LA North Main ST_60ppb_eval_stats.csv");
% % LB
% lb = readtable(link+"Long Beach_60ppb_eval_stats.csv");
% % Mira Loma
% miraLoma = readtable(link+"Mira Loma_60ppb_eval_stats.csv");
% % Mission Viejo
% missionViejo = readtable(link+"Mission Viejo_60ppb_eval_stats.csv");
% % pasadena
% pasadena = readtable(link+"Pasadena_60ppb_eval_stats.csv");
% % Perris
% perris = readtable(link+"Perris_60ppb_eval_stats.csv");
% % Pomona
% pomona = readtable(link+"Pomona_60ppb_eval_stats.csv");
% % redlands
% redlands = readtable(link+"Redlands_60ppb_eval_stats.csv");
% % Reseda
% reseda = readtable(link+"Reseda_60ppb_eval_stats.csv");
% % Rubidoux
% rubidoux = readtable(link+"Rubidoux_60ppb_eval_stats.csv");
% % San Gabriel
% sanGabriel = readtable(link+"San Gabriel_60ppb_eval_stats.csv");
% % Santa Clarita
% santaClarita = readtable(link+"Santa Clarita_60ppb_eval_stats.csv");
% % San Bernardino
% sb = readtable(link+"San Bernardino_60ppb_eval_stats.csv");
% % Upland
% upland = readtable(link+"Upland_60ppb_eval_stats.csv");
% % Winchester
% winchester = readtable(link+"Winchester_60ppb_eval_stats.csv");

% Anaheim
anaheim = readtable(link+"Anaheim_eval_stats.csv");
obs = readtable(link+"Anaheim_eval_stats.csv");
% Azusa
azusa = readtable(link+"Azusa_eval_stats.csv");
% Banning
banning = readtable(link+"Banning_eval_stats.csv");
% Compton
compton = readtable(link+"Compton_eval_stats.csv");
% Crestline
crestline = readtable(link+"Crestline_eval_stats.csv");
% Fontana
fontana = readtable(link+"Fontana_eval_stats.csv");
% Glendora
glendora = readtable(link+"Glendora_eval_stats.csv");
% La Habra
laHabra = readtable(link+"La Habra_eval_stats.csv");
% Lake Elsinore
lakeElsinore = readtable(link+"Lake Elsinore_eval_stats.csv");
% LAX
lax = readtable(link+"LAX_eval_stats.csv");
% Los Angeles
la = readtable(link+"LA North Main ST_eval_stats.csv");
% LB
lb = readtable(link+"Long Beach_eval_stats.csv");
% Mira Loma
miraLoma = readtable(link+"Mira Loma_eval_stats.csv");
% Mission Viejo
missionViejo = readtable(link+"Mission Viejo_eval_stats.csv");
% pasadena
pasadena = readtable(link+"Pasadena_eval_stats.csv");
% Perris
perris = readtable(link+"Perris_eval_stats.csv");
% Pomona
pomona = readtable(link+"Pomona_eval_stats.csv");
% redlands
redlands = readtable(link+"Redlands_eval_stats.csv");
% Reseda
reseda = readtable(link+"Reseda_eval_stats.csv");
% Rubidoux
rubidoux = readtable(link+"Rubidoux_eval_stats.csv");
% San Gabriel
sanGabriel = readtable(link+"San Gabriel_eval_stats.csv");
% Santa Clarita
santaClarita = readtable(link+"Santa Clarita_eval_stats.csv");
% San Bernardino
sb = readtable(link+"San Bernardino_eval_stats.csv");
% Upland
upland = readtable(link+"Upland_eval_stats.csv");
% Winchester
winchester = readtable(link+"Winchester_eval_stats.csv");


% % Anaheim
obs_date = "";
obs_O3 = [];
m_O3 = [];
anaheimO3=[];azusaO3=[];banningO3=[];comptonO3=[];crestlineO3=[];fontanaO3=[];glendoraO3=[];laHabraO3=[];lakeElsinoreO3=[];laxO3=[];laO3=[];lbO3=[];
miraLomaO3=[];missionViejoO3=[];pasadenaO3=[];perrisO3=[];pomonaO3=[];redlandsO3=[];resedaO3=[];rubidouxO3=[];sanGabrielO3=[];santaClaritaO3=[];sbO3=[];uplandO3=[];winchesterO3=[];
vars = [14 15 16 17]; %[RMSE rRMSE MAE MBE]
vars = [2 3 4 5 6];
tit = ["MBE" "NMB" "MAE" "MFB" "MFE"];
% tit = ["RMSE" "rRMSE" "MAE" "MBE"];

for var=1:length(vars)
% for var=2:3
    for i=1:length(anaheim.Month)
       obs_date(i) =  datestr([2017, anaheim.Month(i),15,0,0,0]);
       obs_O3(i) = anaheim.(vars(var))(i);
       m_O3(i) = obs.(vars(var))(i);
       
       anaheimO3(i) = anaheim.(vars(var))(i);
       azusaO3(i) = azusa.(vars(var))(i);
       banningO3(i) = banning.(vars(var))(i);
       comptonO3(i) = compton.(vars(var))(i);
       crestlineO3(i) = crestline.(vars(var))(i);
       fontanaO3(i) = fontana.(vars(var))(i);
       glendoraO3(i) = glendora.(vars(var))(i);
       laHabraO3(i) = laHabra.(vars(var))(i);
       lakeElsinoreO3(i) = lakeElsinore.(vars(var))(i);
       laxO3(i) = lax.(vars(var))(i);
       laO3(i) = la.(vars(var))(i);
       lbO3(i) = lb.(vars(var))(i);
       miraLomaO3(i) = miraLoma.(vars(var))(i);
       missionViejoO3(i) = missionViejo.(vars(var))(i);
       pasadenaO3(i) = pasadena.(vars(var))(i);
       perrisO3(i) = perris.(vars(var))(i);
       pomonaO3(i) = pomona.(vars(var))(i);
       redlandsO3(i) = redlands.(vars(var))(i);
       resedaO3(i) = reseda.(vars(var))(i);
       rubidouxO3(i) = rubidoux.(vars(var))(i);
       sanGabrielO3(i) = sanGabriel.(vars(var))(i);
       santaClaritaO3(i) = santaClarita.(vars(var))(i);
       sbO3(i) = sb.(vars(var))(i);
       uplandO3(i) = upland.(vars(var))(i);
       winchesterO3(i) = winchester.(vars(var))(i);
    end

    anaheimO3(anaheimO3==Inf) = NaN;
    azusaO3(azusaO3==Inf) = NaN;
    banningO3(banningO3==Inf) = NaN;
    comptonO3(comptonO3==Inf) = NaN;
    crestlineO3(crestlineO3==Inf) = NaN;
    fontanaO3(fontanaO3==Inf) = NaN;
    glendoraO3(glendoraO3==Inf) = NaN;
    laHabraO3(laHabraO3==Inf) = NaN;
    lakeElsinoreO3(lakeElsinoreO3==Inf) = NaN;
    laxO3(laxO3==Inf) = NaN;
    laO3(laO3==Inf) = NaN;
    lbO3(lbO3==Inf) = NaN;
    miraLomaO3(miraLomaO3==Inf) = NaN;
    missionViejoO3(missionViejoO3==Inf) = NaN;
    pasadenaO3(pasadenaO3==Inf) = NaN;
    perrisO3(perrisO3==Inf) = NaN;
    pomonaO3(pomonaO3==Inf) = NaN;
    redlandsO3(redlandsO3==Inf) = NaN;
    resedaO3(resedaO3==Inf) = NaN;
    rubidouxO3(rubidouxO3==Inf) = NaN;
    sanGabrielO3(sanGabrielO3==Inf) = NaN;
    santaClaritaO3(santaClaritaO3==Inf) = NaN;
    sbO3(sbO3==-Inf) = NaN;
    uplandO3(uplandO3==Inf) = NaN;
    winchesterO3(winchesterO3==Inf) = NaN;
    obs_O3(anaheimO3==-Inf) = NaN;

    maxi=max([max(anaheimO3),max(azusaO3),max(banningO3),max(comptonO3),max(crestlineO3), ...
        max(fontanaO3),max(glendoraO3),max(laHabraO3),max(lakeElsinoreO3),max(laxO3), ...
        max(laO3),max(lbO3),max(miraLomaO3),max(missionViejoO3),max(pasadenaO3), ...
        max(perrisO3),max(pomonaO3),max(redlandsO3),max(resedaO3),max(rubidouxO3), ...
        max(sanGabrielO3),max(santaClaritaO3),max(sbO3),max(uplandO3),max(winchesterO3)]);

    mini=min([min(anaheimO3),min(azusaO3),min(banningO3),min(comptonO3),min(crestlineO3), ...
        min(fontanaO3),min(glendoraO3),min(laHabraO3),min(lakeElsinoreO3),min(laxO3), ...
        min(laO3),min(lbO3),min(miraLomaO3),min(missionViejoO3),min(pasadenaO3), ...
        min(perrisO3),min(pomonaO3),min(redlandsO3),min(resedaO3),min(rubidouxO3), ...
        min(sanGabrielO3),min(santaClaritaO3),min(sbO3),min(uplandO3),min(winchesterO3)]);
    temp = [anaheimO3;azusaO3;banningO3;comptonO3;crestlineO3;fontanaO3;glendoraO3;laHabraO3;lakeElsinoreO3;laxO3; ...
        laO3;lbO3;miraLomaO3;missionViejoO3;pasadenaO3;perrisO3;pomonaO3;redlandsO3;resedaO3; ...
        rubidouxO3;sanGabrielO3;santaClaritaO3;sbO3;uplandO3;winchesterO3];

    for i=1:length(anaheimO3)
%     for i=1:5
        s2 = shaperead('dc33871f-031d-4dc2-bec7-f43f2f02e99e202044-1-h8gavz.0eutq.shp');
        plot([s2.X],[s2.Y],'k','LineWidth',2);
        hold on
        s1 = shaperead('cb_2018_us_county_20m.shp');
        plot([s1.X],[s1.Y],'k')
        xlim([-120, -114.8])
        ylim([32.5, 35.3])
%         scatter(longitude(1:3),latitude(1:3),50,temp(1:3,i),'filled');
%         hold on
%         scatter(longitude(5:9),latitude(5:9),50,temp(5:9,i),'filled');
        s=scatter(longitude(1:25),latitude(1:25),50,temp(1:25,i),'filled');
%         if var == 4
%             cb = colorbar; colormap(flipud(brewermap([],'RdBu')));s.MarkerEdgeColor='k'; s.MarkerEdgeAlpha=0.3;
%         else
            cb = colorbar; colormap('jet');s.MarkerEdgeColor='k'; s.MarkerEdgeAlpha=0.3;
%         end
        %colormap(bluewhitered);
        ylabel(cb, tit(var));
        caxis([mini,maxi]);
        if var == 2
            caxis([mini,0.7])
        end
        pause(0.01)
        xdt = char(obs_date(i));
        xdt = xdt(4:end);
        xlabel(xdt)
        title([{'Monthly '+tit(var)+' of Model and Observation for $O_{3}$ MDA8'},{'2017 Reanalysis'}], 'Interpreter','latex')
        fname = '/home/khanh/seagate10tb/CMAQ_All_Sites/spatial_plot/plots/';
        exportgraphics(gcf, fullfile(fname, tit(var)+ ' '+ xdt+'.jpg'),'Resolution',500)
        hold off
    end
end