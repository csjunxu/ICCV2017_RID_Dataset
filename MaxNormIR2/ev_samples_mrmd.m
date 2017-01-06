clear;
%% config the project

config = ev_samples_config();

method = 'mrmd';

all_rho = config.rho;
all_rep = config.repetitions;

lambda1 = 1/sqrt(config.p);
lambda2 = 1/sqrt(config.p);

%% compute EV

for k=1:length(all_rep)
    rep = all_rep(k);
    for i=1:length(all_rho)
        rho = all_rho(i);
        
        fprintf('OMRMD: rep = %d, rho = %.2f\n', rep, rho);
        
        result_file = sprintf(config.result_file_format, method, method, rho, rep);
        
        % if we have got the result file, skip
        % comment the if statement if we need to re-launch the completed exp
        if exist(result_file, 'file')
            continue; 
        end
        
        data_file = sprintf(config.data_file_format, rho, rep);
        load(data_file);
        
        Z = U * V' + E;
        
        [L_est, ~, ~] = js_solve_mrmd(Z, config.d, lambda1, lambda2);
        
        EV = zeros(1, config.n);
        UUt = U * U';
        traceUUt = trace(UUt);
        for t=1:config.n
            EV(t) = js_compute_EV(L_est{t+1}, UUt, traceUUt);
        end
        
        save(result_file, 'EV');
        fprintf('save to %s\n', result_file);
    end
    
end