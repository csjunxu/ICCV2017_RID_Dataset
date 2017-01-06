% This code is used for the NIPS work "Online Optimization for Max-Norm Regularization", Jie Shen, Huan Xu, Ping Li
%
% configure file to examine the EV values w.r.t. #samples under different rho
%
% Copyright by Jie Shen, js2007@rutgers.edu

function [ config ] = ev_samples_config()

test_mode = false;

task = 'ev_samples';

config.methods = {'mrmd', 'orpca', 'pcp', 'opca'};

%% dirs
root_dir = ['ExpData/' task '/'];
if ~exist(root_dir, 'dir')
    mkdir(root_dir)
end

config.data_dir = [root_dir 'data/'];
if ~exist(config.data_dir, 'dir')
    mkdir(config.data_dir);
end

config.result_dir = [root_dir 'result/'];
if ~exist(config.result_dir, 'dir')
    mkdir(config.result_dir);
end

config.sub_result_dirs = cell(1, length(config.methods));
for i=1:length(config.methods)
    config.sub_result_dirs{i} = [config.result_dir config.methods{i} '/'];
    if ~exist(config.sub_result_dirs{i}, 'dir')
        mkdir(config.sub_result_dirs{i});
    end
end

config.stat_dir = [root_dir 'stat/'];
if ~exist(config.stat_dir, 'dir')
    mkdir(config.stat_dir);
end

config.figure_dir = [root_dir 'figure/'];
if ~exist(config.figure_dir, 'dir')
    mkdir(config.figure_dir);
end

%% files
% format: rho rep
config.data_file_format = [config.data_dir task '_data_rho_%.2f_rep_%d.mat'];
% format: method method rho rep
config.result_file_format = [config.result_dir '%s/' task '_result_%s_rho_%.2f_rep_%d.mat'];

config.stat_file_format = [config.stat_dir task '_stat.mat'];

% format: rho
config.fig_file_format = [config.figure_dir task '_rho_%.2f.fig'];
config.eps_file_format = [config.figure_dir task '_rho_%.2f.eps'];

%% figure setting
config.colors = {'r', 'b', 'k', 'g', 'm', 'c', 'y'};
% config.shapes = {'>', 's', 'd', 'x', 'o', '.', '^'};
config.shapes = {'', '', '>', '', 'o', '.', '^'};
config.lines = {'-', '--', '-', '-', '-', '-', '-'};

%% data
config.p = 400;
config.n = 5000;
config.d = 80;

config.rho = [0.01, 0.1, 0.3, 0.5];

config.repetitions = 1:10;

if test_mode
    config.p = 20;
    config.n = 100;
    config.rho = 0.1;
    config.d = 10;
    config.repetitions = 1:2;
    
    task = ['test_' task];
    
    config.data_file_format = [config.data_dir task '_data_rho_%.2f_rep_%d.mat'];
    config.result_file_format = [config.result_dir '%s/' task '_result_%s_rho_%.2f_rep_%d.mat'];
    
    config.stat_file_format = [config.stat_dir task '_stat.mat'];
    
    config.fig_file_format = [config.figure_dir task '_rho_%.2f.fig'];
    config.eps_file_format = [config.figure_dir task '_rho_%.2f.eps'];
end

end
