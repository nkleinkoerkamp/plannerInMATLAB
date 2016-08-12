% Scene.m 
% This script generates the scenario and contains the variables which are
% to be initialized for running MTVRP

clear; close all; clc;
M=10000; % A very large number (in general, larger than any number to be found in this problem instance)
tdrop = 20; % dropping time [s] (including time for drone to turn around)
td = 30; % truck/depot rendezvous time [s] (including time for battery change and for drone to turn around)

%% Initialize scene

% Test case - 4 customers (correspoding to testMILP3.m)
% C = [0, 0; -2, 1; 12, 5; 4, -3; -10, -9]; % Co-ordinate matrix [x y] of all nodes

% SS-1 Scenario
width = 50;
x = -1000:width:1000;
y = ones(1,length(x))*100;
C = [0 x;0 y]';


% % Read CMT1 Scenario
% fileID = fopen('cmt1.txt','r');
% formatSpec = '%d %d %d';
% sizeA = [3 Inf];
% A = fscanf(fileID,formatSpec,sizeA);
% fclose(fileID);
% C = 15*A(2:3,:)';

% % Read CMT2 Scenario
% fileID = fopen('cmt2.txt','r');
% formatSpec = '%d %d %d';
% sizeA = [3 Inf];
% A = fscanf(fileID,formatSpec,sizeA);
% fclose(fileID);
% C = 15*A(2:3,:)';

% % Read CMT3 Scenario
% fileID = fopen('cmt3.txt','r');
% formatSpec = '%d %d %d';
% sizeA = [3 Inf];
% A = fscanf(fileID,formatSpec,sizeA);
% fclose(fileID);
% C = 15*A(2:3,:)';

% % Read CMT4 Scenario
% fileID = fopen('cmt4.txt','r');
% formatSpec = '%d %f %f';
% sizeA = [3 Inf];
% A = fscanf(fileID,formatSpec,sizeA);
% fclose(fileID);
% C = 15*A(2:3,:)';

% % Read CMT5 Scenario
% fileID = fopen('cmt5.txt','r');
% formatSpec = '%d %f %f';
% sizeA = [3 Inf];
% A = fscanf(fileID,formatSpec,sizeA);
% fclose(fileID);
% C = 15*A(2:3,:)';

% % Read CMT11 Scenario
% fileID = fopen('cmt11.txt','r');
% formatSpec = '%d %f %f';
% sizeA = [3 Inf];
% A = fscanf(fileID,formatSpec,sizeA);
% fclose(fileID);
% C = 15*A(2:3,:)';

% % Read CMT12 Scenario
% fileID = fopen('cmt12.txt','r');
% formatSpec = '%d %f %f';
% sizeA = [3 Inf];
% A = fscanf(fileID,formatSpec,sizeA);
% fclose(fileID);
% C = 15*A(2:3,:)';

% % Read SS-test Scenario
% fileID = fopen('../SS_test_enu.txt','r');
% formatSpec = '%f %f';
% sizeA = [2 Inf];
% A = fscanf(fileID,formatSpec,sizeA);
% fclose(fileID);
% C = A';


% Initialize drones
D = Drone();
D.batteryTime = 20*60; % in s
D.nDrones = 4;
D.speed = 15; % in m/s

Vw_g = [1, 1];
if norm(Vw_g) >= D.speed
    error('Wind speed is higher than the average airspeed of a drone');
end

% Variables to be initialized for making set R using Heuristics
radius = 50; %5;
searchRadius = radius; % Radius of the circle encompassing the customers which are combinatorially combined to form routes 
searchIncrement = 0.5*radius; % Increment in the radius of the above circle when number of customers within that circle are less than searchLimit
searchLimit = 4; %D.capacity; % maximum number of customers to be combinatorially combined together to form routes
    
