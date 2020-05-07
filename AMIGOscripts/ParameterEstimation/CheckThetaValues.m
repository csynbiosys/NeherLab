
i=1
for i=1:36
    n=bestfit.pe_inputs.PEsol.id_local_theta_y0{1}(i,:);
    m=bestfit.pe_results.fit.local_theta_y0_estimated{1}(i);
    s=bestfit.pe_results.fit.l_var_cov_mat{1}(i+3,i+3);
    
    disp(['Tehta: ', n])
    disp(['Mean: ', num2str(m)])
    disp(['SD: ', num2str(s)])
    
    
    
end

i=16
(bestfit.pe_inputs.PEsol.id_global_theta(i,:))
bestfit.pe_results.fit.thetabest(i)
bestfit.pe_results.fit.g_var_cov_mat(i,i)








