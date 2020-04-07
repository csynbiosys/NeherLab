import matplotlib.pyplot as plt

def plot_result(name, title, x_label, y_label, time, time_series):
  plt.title(title)
  plt.xlabel(x_label)
  plt.ylabel(y_label)
  plt.plot(time, time_series)
  plt.savefig(name)
