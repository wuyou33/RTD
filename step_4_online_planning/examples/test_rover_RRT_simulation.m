clear
close all
%% description
% This script runs a simulation with the Rover in the simulator
% framework, using RRT to plan online.
%
% Author: Sean Vaskov
% Created: 22 March 2020
%
%% user parameters
% world
obstacle_size_bounds = [0.3,0.7;0.2,0.4] ; 
obstacle_long_spacing = [5,7];
obstacle_lat_spacing = [-0.1 0.1];
N_obstacles = 3 ;
road_length = 30;
lane_width = 0.6;
bound_space = 1;

% planner
buffer = 0.01 ; % m
t_plan = 1 ;  % if t_plan = t_move, then real time planning is enforced
t_move = 0.5 ;
y_weight = 10;
control_weights = [0 50]';

plot_HLP_flag = true ;

% simulation
verbose_level = 5 ;
max_sim_time = 1000 ;
max_sim_iterations = 1000 ;

%% automated from here
A = RoverAWD();

W = two_lane_road_static('N_obstacles',N_obstacles,'bound_space',0.4,...
                     'verbose',verbose_level, 'obstacle_size_bounds',obstacle_size_bounds,...
                     'lane_width',lane_width,'road_length',road_length,...
                     'obstacle_long_spacing',obstacle_long_spacing,'obstacle_lat_spacing',obstacle_lat_spacing) ;

P = rover_RRT_planner('rrt_dynamics',@rover_rrt_dynamics,'verbose',verbose_level,'buffer',buffer,...
                                 't_plan',t_plan,'t_move',t_move,...
                                 'plot_HLP_flag',plot_HLP_flag','HLP',lane_HLP,'y_weight',y_weight,'control_weights',control_weights) ;
                 
                 
S = simulator(A,W,P,'allow_replan_errors',true,'verbose',verbose_level,...
              'max_sim_time',max_sim_time,...
              'max_sim_iterations',max_sim_iterations) ;

%% run simulation
S.run() ;