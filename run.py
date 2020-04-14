import rates
import systems
import plots
from scipy.integrate import odeint

#helper functions

def evaluate_model(tr_params, params, time, initial_conditions):
  model = systems.Systems(tr_params, params, time) #define system instance
  #result[:, 0] ... result[:, 6] == susceptible time series ... died time series
  return odeint(model.sys, initial_conditions, list(range(time)))

def sum_species_across_age(results_per_age, species, time):
  species_labels = ['susceptible', 'exposed', 'infected', 'hospitalized', 'critical', 'recovered', 'died']
  return [results_per_age['0-9'][t, species_labels.index(species)] + 
          results_per_age['10-19'][t, species_labels.index(species)] +
          results_per_age['20-29'][t, species_labels.index(species)] +
          results_per_age['30-39'][t, species_labels.index(species)] +
          results_per_age['40-49'][t, species_labels.index(species)] +
          results_per_age['50-59'][t, species_labels.index(species)] +
          results_per_age['60-69'][t, species_labels.index(species)] +
          results_per_age['70-79'][t, species_labels.index(species)] +
          results_per_age['80+'][t, species_labels.index(species)] for t in range(time)]

def params_for_age(params, age_range):
  return {'pop': params['population'],
          't_l': params['t_l'][age_range],
          't_i': parmas['t_i'][age_range],
          't_h': params['t_h'][age_range],
          't_c': params['t_c'][age_range],
          'm_a': params['m_a'][age_range],
          'c_a': params['c_a'][age_range],
          'f_a': params['f_a'][age_range]}

def init_for_age(init, age_range):
  return {'susceptible': init['susceptible'],
          'exposed': init['exposed'][age_range],
          'infected': init['infected'][age_range],
          'hospitalized': init['hospitalized'],
          'critical': init['critical'],
          'recovered': init['recovered'],
          'died': init['died']}

rates = rates.Rates()
init = rates.initial()
tr_params = rates.tr_parameters()
params = rates.parameters()

time = 365 #1year

results_per_age = {'0-9': evaluate_model(tr_params, params_for_age(params, '0-9'), time, init_for_age(init, '0-9')),
                   '10-19': evaluate_model(tr_params, params_for_age(params, '10-19'), time, init_for_age(init, '10-19')),
                   '20-29': evaluate_model(tr_params, params_for_age(params, '20-29'), time, init_for_age(init, '20-29')),
                   '30-39': evaluate_model(tr_params, params_for_age(params, '30-39'), time, init_for_age(init, '30-39')),
                   '40-49': evaluate_model(tr_params, params_for_age(params, '40-49'), time, init_for_age(init, '40-49')),
                   '50-59': evaluate_model(tr_params, params_for_age(params, '50-59'), time, init_for_age(init, '50-59')),
                   '60-69': evaluate_model(tr_params, params_for_age(params, '60-69'), time, init_for_age(init, '60-69')),
                   '70-79': evaluate_model(tr_params, params_for_age(params, '70-79'), time, init_for_age(init, '70-79')),
                   '80+': evaluate_model(tr_params, params_for_age(params, '80+'), time, init_for_age(init, '80+'))}

#sum across age groups
susceptible_count = sum_species_across_age(results_per_age, 'susceptible', time)
exposed_count = sum_species_across_age(results_per_age, 'exposed', time)
infected_count = sum_species_across_age(results_per_age, 'infected', time)
hospitalized_count = sum_species_across_age(results_per_age, 'hospitalized', time)
critical_count = sum_species_across_age(results_per_age, 'critical', time)
recovered_count = sum_species_across_age(results_per_age, 'recovered', time)
died_count = sum_species_across_age(results_per_age, 'died', time)

#pass sums of species to plotting function
plots.plot_result('susceptible.png', 'Suspectible', 'Time(Days)', 'Susceptible(Number of People)', list(range(time)), susceptible_count)
plots.plot_result('exposed.png', 'Exposed', 'Time(Days)', 'Exposed(Number of People)', list(range(time)), exposed_count)
plots.plot_result('infected.png', 'Infected', 'Time(Days)', 'Infected(Number of People)', list(range(time)), infected_count)
plots.plot_result('hospitalized.png', 'Hospitalized', 'Time(Days)', 'Hospitalized(Number of People)', list(range(time)), hospitalized_count)
plots.plot_result('critical.png', 'Critical', 'Time(Days)', 'Critical(Number of People)', list(range(time)), critical_count)
plots.plot_result('recovered.png', 'Recovered', 'Time(Days)', 'Recovered(Number of People)', list(range(time)), recovered_count)
plots.plot_result('died.png', 'Died', 'Time(Days)', 'Died(Number of People)', list(range(time)), died_count)
