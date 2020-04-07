import math

class Systems:

  def __init__(self, tr_parameters, parameters, time):
      self.tr_params = tr_parameters
      self.params = parameters
      self.time = time
      self.infected_over_time = 0.
      self.eps = 0.2 # seasonal variation according to github

  #time dependent transmission rate formula
  #some confusion here as equations on about and github different
  def tr_rate(self, t): 
    return self.tr_params['r_o'] * (1 + self.eps * math.cos((t/365)*2.*math.pi))

  #system to be solved
  def sys(self, y, t):
    transmission_rate = self.tr_rate(t)

    #species
    susceptible = y[0]
    exposed = y[1]
    infected = y[2]
    hospitalized = y[3]
    critical = y[4]
    recovered = y[5]
    died = y[6]

    self.infected_over_time = self.infected_over_time + infected

    #model ODEs
    d_susceptible_dt = -(1./self.params['pop']) * transmission_rate * susceptible * self.infected_over_time
    d_exposed_dt = (1./self.params['pop']) * transmission_rate * susceptible * (self.infected_over_time - exposed/self.params['t_l'])
    d_infected_dt = (exposed/self.params['t_l']) - (infected/self.params['t_i'])
    d_hospitalized_dt = (((1. - self.params['m_a']) * infected)/self.params['t_i']) + (((1. - self.params['f_a']) * critical)/self.params['t_c']) - (hospitalized/self.params['t_h'])
    d_critical_dt = (self.params['c_a'] * hospitalized/self.params['t_h']) - (critical/self.params['t_c'])
    d_recovered_dt = ((self.params['m_a'] * infected)/self.params['t_i']) + (((1. - self.params['c_a'])* hospitalized)/self.params['t_h'])
    d_died_dt = (self.params['f_a'] * critical)/self.params['t_c']

    return [d_susceptible_dt,
            d_exposed_dt,
            d_infected_dt,
            d_hospitalized_dt,
            d_critical_dt,
            d_recovered_dt,
            d_died_dt]
