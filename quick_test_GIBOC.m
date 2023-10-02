% Using new example data for testing the GIBOC for femur tibia and patella. 

clearvars 
close all

% addpath(genpath(strcat('C:\Users\87123\Documents\GitHub\GIBOC-Knee-Coordinate-System','/SubFunctions')));

dir = 'E:\OneDrive - Griffith University\___Current_Project_data\_Project_2_KNEE\_pipeline1_ID_v2\bone_geometry\';

% Testing subject 
subject = 'TD03';

subDir = fullfile(dir,subject);

%% Debug plot before patella algorithm 
addpath('C:\Users\87123\Documents\GitHub\knee-PM\visualization\')

fem_name = subject + "_femur_r_with_cart.stl";
fem_tri = stlread(fullfile(subDir,fem_name));

% stl format 
pat_name = subject + "_patella_r_with_cart.stl";
pat_tri = stlread(fullfile(subDir,pat_name));


fig = figure();
hold on;

plotMesh(fem_tri,fig);
plotMesh(pat_tri,fig)

%% Debug, Use within the RPatellaFun()
% Plot inital Inertia property calculation
% plotCoordinateSys(V_all(:,1), V_all(:,2),V_all(:,3),Center,gcf,50)


%% Example for a Patella
[Patella] = ReadMesh(strcat(subDir,sprintf('/%s_patella_r_with_cart.stl',subject)));

[ PatACSsResults, PatellaTriangulations ] = RPatellaFun( Patella );
PlotPatella( PatACSsResults.VR, PatellaTriangulations )

%% Quick plot, femur & patella 
addpath('C:\Users\87123\Documents\GitHub\knee-PM\visualization\')

fem_name = subject + "_femur_r_with_cart.stl";
fem_tri = stlread(fullfile(subDir,fem_name));

% stl format 
pat_name = subject + "_patella_r_with_cart.stl";
pat_tri = stlread(fullfile(subDir,pat_name));


fig = figure();
hold on;

plotMesh(fem_tri,fig,'faceAlpha',0.3);
plotMesh(pat_tri,fig,'faceAlpha',0.3);

CSV = PatACSsResults.VR.V;
plotCoordinateSys(CSV(:,1),CSV(:,2),CSV(:,3),PatACSsResults.VR.Origin,fig,50)

% Plot patella art surf 
plotMesh(PatellaTriangulations.PatArtSurf, fig, "faceColor",'r','faceAlpha', 0.3)
plotPoints(PatellaTriangulations.RidgePts_Separated,fig,'Color','g','Size',15)


% EXAMPLE %
% -------------------------------------------------------------------------
% EXAMPLE DATA CAN BE FOUND AT
% https://www.dropbox.com/sh/ciy1fu2k63nqnd4/AACWkJvSHsiA_-9slJBiEEiua?dl=0
%
% then they should be put at the root of the code
%
% Reading .msh file might be a bit faster than stl
%--------------------------------------------------------------------------
% 
% 
% %% Example for a Tibia composed of two parts (distal and proximal)
% [ProxTib,DistTib] = ReadMesh(strcat(pwd,'/ProxTib_S1_05.msh'),...
%     strcat(pwd,'/DistTib_S1_05.msh'));
% 
% [ TibACSsResults, TibiaTriangulations ] = RTibiaFun( ProxTib , DistTib);
% PlotTibia( TibACSsResults.PIAASL, TibiaTriangulations )
% 
% %% Example for a Femur composed of two parts (distal and proximal)
% [DistFem,ProxFem] = ReadMesh(strcat(pwd,'/DistFem_S2_05.msh'),...
%     strcat(pwd,'/ProxFem_S2_05.msh'));
% 
% [ FemACSsResults, FemurTriangulations ] = RFemurFun( DistFem, ProxFem);
% PlotFemur( FemACSsResults.PCC, FemurTriangulations )
% 
% %% Example for a Patella
% [Patella] = ReadMesh(strcat(pwd,'/Patella_S4_05.msh'));
% 
% [ PatACSsResults, PatellaTriangulations ] = RPatellaFun( Patella );
% PlotPatella( PatACSsResults.VR, PatellaTriangulations )
