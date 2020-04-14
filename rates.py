class Rates:

  def tr_parameters(self): #params for transmission rate format
    r_o = 2.7 #baseline infection
    d_i = 0.4 #degree of isolation
    return {'r_o': r_o,
            'd_i': d_i}

  def parameters(self):
    population_total = 66000000.

    pop_dist = {'0-9': 8.05,
                '10-19': 7.53,
                '20-29': 8.71,
                '30-39': 8.83,
                '40-49': '8.5',
                '50-59': '8.96',
                '60-69': '7.07',
                '70-79': '5.49',
                '3.27'}

    #days
    t_l = {'0-9': 5., 
           '10-19': 5.,
           '20-29': 5.,
           '30-39': 5.,
           '40-49': 5.,
           '50-59': 5.,
           '60-69': 5.,
           '70-79': 5.,
           '80+': 5.} #latency time from infection to infectiousness
    t_i = {'0-9': 3.,
           '10-19': 3.,
           '20-29': 3.,
           '30-39': 3.,
           '40-49': 3.,
           '50-59': 3.,
           '60-69': 3.,
           '70-79': 3.,
           '80+': 3.} #time to recovery or falling severely ill
    t_h = {'0-9': 4.,
           '10-19': 4.,
           '20-29': 4.,
           '30-39': 4.,
           '40-49': 4.,
           '50-59': 4.,
           '60-69': 4.,
           '70-79': 4.,
           '80+': 4.} #time to recovery or critically ill
    t_c = {'0-9': 14.,
           '10-19': 14.,
           '20-29': 14.,
           '30-39': 14.,
           '40-49': 14.,
           '50-59': 14.,
           '60-69': 14.,
           '70-79': 14.,
           '80+': 14.} #time from critical to death or stabilize

    m_a = {'0-9': .85,
           '10-19': .85,
           '20-29': .85,
           '30-39': .85,
           '40-49': .85,
           '50-59': .85,
           '60-69': .85,
           '70-79': .85,
           '80+': .85} #asymptomatic or mild infection
    c_a = {'0-9': .25,
           '10-19': .25,
           '20-29': .25,
           '30-39': .25,
           '40-49': .25,
           '50-59': .25,
           '60-69': .25,
           '70-79': .25,
           '80+': .25} #severe cases that turn critical
    f_a = {'0-9': .37,
           '10-19': .37,
           '20-29': .37,
           '30-39': .37,
           '40-49': .37,
           '50-59': .37,
           '60-69': .37,
           '70-79': .37,
           '80+': .37} #critical cases that are fatal

    return {'pop': population,
            'pop_dist': pop_dist,
            't_l': t_l,
            't_i': t_i,
            't_h': t_h,
            't_c': t_c,
            'm_a': m_a,
            'c_a': c_a,
            'f_a': f_a}

  #30% of cases (4143 uk) start as infected rest as exposed
  def initial(self):
    total_initial_cases = 4143.
    total_initial_infected = (total_initial_cases/100.)*30.
    total_initial_exposed = total_initial_cases - total_initial_exposed
    pop_dist = self.parameters['pop_dist']

    susceptible = 0.
    exposed = {'0-9': (total_initial_exposed/100.)/pop_dist['0-9'],
               '10-19': (total_initial_exposed/100.)/pop_dist['10-19'],
               '20-29': (total_initial_exposed/100.)/pop_dist['20-29'],
               '30-39': (total_initial_exposed/100.)/pop_dist['30-39'],
               '40-49': (total_initial_exposed/100.)/pop_dist['40-49'],
               '50-59': (total_initial_exposed/100.)/pop_dist['50-59'],
               '60-69': (total_initial_exposed/100.)/pop_dist['60-69'],
               '70-79': (total_initial_exposed/100.)/pop_dist['70-79'],
               '80+': (total_initial_exposed/100.)/pop_dist['80+']}
    infected = {'0-9': (total_initial_infected/100.)/pop_dist['0-9'],
                '10-19': (total_initial_infected/100.)/pop_dist['10-19'],
                '20-29': (total_initial_infected/100.)/pop_dist['20-29'],
                '30-39': (total_initial_infected/100.)/pop_dist['30-39'],
                '40-49': (total_initial_infected/100.)/pop_dist['40-49'],
                '50-59': (total_initial_infected/100.)/pop_dist['50-59'],
                '60-69': (total_initial_infected/100.)/pop_dist['60-69'],
                '70-79': (total_initial_infected/100.)/pop_dist['70-79'],
                '80+': (total_initial_infected/100.)/pop_dist['80+']}
    hospitalized = 0.
    critical = 0.
    recovered = 0.
    died = 0.
    return {'susceptible': susceptible, 
            'exposed': exposed, 
            'infected': infected, 
            'hospitalized': hospitalized, 
            'critical': critical, 
            'recovered': recovered, 
            'died': died}
