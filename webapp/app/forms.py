from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired

class ParameterForm(FlaskForm):
    country = StringField('Country: ', validators=[DataRequired()])
    population = StringField('Population:', validators=[DataRequired()])
    age_dist = StringField('Age Distribution:', validators=[DataRequired()])
    init_cases = StringField('Initial Cases:', validators=[DataRequired()])
    imports = StringField('Imports per Day:', validators=[DataRequired()])
    hosp_beds = StringField('Hospital Beds:', validators=[DataRequired()])
    icu = StringField('ICU:', validators=[DataRequired()])
    confirmed_cases = StringField('Confirmed Cases:', validators=[DataRequired()])
    sim_range = StringField('Simulation Range:', validators=[DataRequired()])
    avg_ro = StringField('Average Ro:', validators=[DataRequired()])
    latency = StringField('Latency:', validators=[DataRequired()])
    infect_period = StringField('Infectious Period:', validators=[DataRequired()])
    seasonal_forcing = StringField('Seasonal Forcing:', validators=[DataRequired()])
    seasonal_peak = StringField('Seasonal Peak:', validators=[DataRequired()])
    hosp_stay = StringField('Hospital Stay:', validators=[DataRequired()])
    icu_stay = StringField('ICU Stay:', validators=[DataRequired()])
    severity_overflow = StringField('Severity of ICU Overflow:', validators=[DataRequired()])
    submit = SubmitField('Submit')
  
