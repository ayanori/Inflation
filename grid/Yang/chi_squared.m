% calculate CHI^2 based on what's written out in 'Numerical Recipies' for
% data fitting - works only for radially symmetrical stuff

function  chi = chi_squared(data, model, RMSE_TYPE)

    chi1 = sum( ((model.ux-data.ue) ./ data.esig ) .^2 );
    chi2 = sum( ((model.uy-data.un) ./ data.nsig ) .^2 );
    chi3 = sum( ((model.uz-data.uz) ./ data.usig ) .^2 );              

    chi = ( chi1 + chi2 + chi3 ) / 3;

    if(RMSE_TYPE == 2)
        chi = (chi1+chi2) / 2;
    elseif(RMSE_TYPE == 3)
        chi = chi3;
    end

end
