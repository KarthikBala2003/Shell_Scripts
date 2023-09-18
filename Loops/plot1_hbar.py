import matplotlib.pyplot as plt
import csv
  
x = []
y = []
  
with open('metrics.csv','r') as csvfile:
    plots = csv.reader(csvfile, delimiter = ',')
      
    for row in plots:
        x.append(row[0])
        y.append(int(row[1]))

# Bar Chart  
# plt.bar(x, y, color = 'g', width = 0.72, label = "Metrics")
# Line Chart
plt.hbar(x, y, label = "Metrics")
plt.xlabel('Performance Attributes')
plt.ylabel('Measurment %')
plt.title('Metrics of different OND1')
plt.legend()
plt.show()