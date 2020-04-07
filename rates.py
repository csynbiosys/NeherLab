class Rates:

  def tr_parameters(self): #params for transmission rate format
    r_o = 2.7 #baseline infection
    d_i = 0.4 #degree of isolation
    return {'r_o': r_o,
            'd_i': d_i}

  def parameters(self):
    population = 66000000.

    #days
    t_l = 5. #latency time from infection to infectiousness
    t_i = 3. #time to recovery or falling severely ill
    t_h = 4. #time to recovery or critically ill
    t_c = 14. #time from critical to death or stabilize

    m_a = .85 #asymptomatic or mild infection
    c_a = .25 #severe cases that turn critical
    f_a = .37 #critical cases that are fatal

    return {'pop': population,
            't_l': t_l,
            't_i': t_i,
            't_h': t_h,
            't_c': t_c,
            'm_a': m_a,
            'c_a': c_a,
            'f_a': f_a}

  #30% of cases (4143) start as infected rest as exposed
  def initial(self):
    susceptible = 0.
    exposed = 2900.1
    infected = 1242.9
    hospitalized = 0.
    critical = 0.
    recovered = 0.
    died = 0.
    return [susceptible, 
            exposed, 
            infected, 
            hospitalized, 
            critical, 
            recovered, 
            died]
