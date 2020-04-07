import rates
import systems
import plots
from scipy.integrate import odeint

rates = rates.Rates()
init = rates.initial()
tr_params = rates.tr_parameters()
params = rates.parameters()

time = 365 #1year
model = systems.Systems(tr_params, params, time) #define system class

#result[:, 0] ... result[:, 6] == susceptible time series ... died time series
result = odeint(model.sys, init, list(range(time))) #solve ODE system

plots.plot_result('susceptible.png', 'Suspectible', 'Time(Days)', 'Susceptible(Number of People)', list(range(time)), result[:, 0])
plots.plot_result('exposed.png', 'Exposed', 'Time(Days)', 'Exposed(Number of People)', list(range(time)), result[:, 1])
plots.plot_result('infected.png', 'Infected', 'Time(Days)', 'Infected(Number of People)', list(range(time)), result[:, 2])
plots.plot_result('hospitalized.png', 'Hospitalized', 'Time(Days)', 'Hospitalized(Number of People)', list(range(time)), result[:, 3])
plots.plot_result('critical.png', 'Critical', 'Time(Days)', 'Critical(Number of People)', list(range(time)), result[:, 4])
plots.plot_result('recovered.png', 'Recovered', 'Time(Days)', 'Recovered(Number of People)', list(range(time)), result[:, 5])
plots.plot_result('died.png', 'Died', 'Time(Days)', 'Died(Number of People)', list(range(time)), result[:, 6])
