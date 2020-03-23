clear
close all
%% description
% This script runs a simulation with the Rover in the simulator
% framework, using RTD to plan online.
%
% Author: Sean Vaskov
% Created: 12 March 2020
%
%% user parameters
% world
obstacle_size_bounds = [0.3,0.7;0.2,0.4] ; 
obstacle_long_spacing = [4,8];
obstacle_lat_spacing = [0,0];
N_obstacles = 3 ;
road_length = 30;
lane_width =  0.6;
bound_space = 0.6;

% planner
buffer = 0.1 ; % m
t_plan = 1; % if t_plan = t_move, then real time planning is enforced
t_move = 0.5 ;
lookahead_distance = 8;
FRS_directory = '/Users/seanvaskov/MATLAB/IJRR_bridging_the_gap/step_3_FRS_computation/data/simulation_mirror';

plot_FRS_flag = true ;
plot_HLP_flag = false ;

% simulation
verbose_level = 5 ;
max_sim_time = 1000 ;
max_sim_iterations = 1000;
%% automated from here
A = RoverAWD();

W = two_lane_road_static('N_obstacles',N_obstacles,'bound_space',bound_space,...
                     'verbose',verbose_level, 'obstacle_size_bounds',obstacle_size_bounds,...
                     'lane_width',lane_width,'road_length',road_length,...
                     'obstacle_long_spacing',obstacle_long_spacing,'obstacle_lat_spacing',obstacle_lat_spacing) ;

P = rover_RTD_mirror('FRS_directory',FRS_directory,'verbose',verbose_level,'buffer',buffer,...
                                 't_plan',t_plan,'t_move',t_move,...
                                 'plot_FRS_flag',plot_FRS_flag,...
                                 'plot_HLP_flag',plot_HLP_flag','HLP',lane_HLP,'lookahead_distance',lookahead_distance) ;
                 
                 
S = simulator(A,W,P,'allow_replan_errors',true,'verbose',verbose_level,...
              'max_sim_time',max_sim_time,...
              'max_sim_iterations',max_sim_iterations) ;

%% run simulation
S.run() ;