import sys
from app import app, db
from flask import render_template, redirect, url_for, request
from app.forms import ParameterForm

@app.route('/')
@app.route('/home', methods=['GET', 'POST'])
def start():
    form = ParameterForm()
    if form.validate_on_submit():
        country = form.country.data
        population = form.population.data
        age_dist = form.age_dist.data
        init_cases = form.init_cases.data
        imports = form.imports.data
        hosp_beds = form.hosp_beds.data
        icu = form.icu.data
        confirmed_cases = form.confirmed_cases.data
        sim_range = form.sim_range.data
        avg_ro = form.avg_ro.data
        latency = form.latency.data
        infect_period = form.infect_period.data
        seasonal_forcing = form.seasonal_forcing.data
        seasonal_peak = form.seasonal_peak.data
        hosp_stay = form.hosp_stay.data
        icu_stay = form.icu_stay.data
        severity_overflow = form.severity_overflow.data
        return redirect(url_for('model_results', 
                                country=country, 
                                population=population, 
                                age_dist=age_dist, 
                                init_cases=init_cases,
                                imports=imports,
                                hosp_beds=hosp_beds,
                                icu=icu,
                                confirmed_cases=confirmed_cases,
                                sim_range=sim_range,
                                avg_ro=avg_ro,
                                latency=latency,
                                infect_period=infect_period,
                                seasonal_forcing=seasonal_forcing,
                                seasonal_peak=seasonal_peak,
                                hosp_stay=hosp_stay,
                                icu_stay=icu_stay,
                                severity_overflow=severity_overflow))
    return render_template('home.html', form=form)
