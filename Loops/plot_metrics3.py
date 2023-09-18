import matplotlib.pyplot as plt
from matplotlib.table import Table
import numpy as np

# Function to read data from a CSV file without pandas
def read_data(file_path, delimiter=','):
    data = {'Soak Duration': [], 'Uptime': [], 'Free Mem': []}

    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Skip the header line
    lines = lines[1:]

    for line in lines:
        # Split the line by the specified delimiter
        values = line.strip().split(delimiter)

        # Check if there are enough values on this line
        if len(values) != 3:
            print(f"Skipping line due to incorrect format: {line.strip()}")
            continue

        try:
            soak_duration = int(values[0])
            uptime = int(values[1])
            free_mem = int(values[2])

            data['Soak Duration'].append(soak_duration)
            data['Uptime'].append(uptime)
            data['Free Mem'].append(free_mem)
        except ValueError:
            print(f"Skipping line due to invalid values: {line.strip()}")

    return data

# Function to plot data
def plot_data(data):
    fig, ax = plt.subplots(figsize=(12,8))

    # Plot Uptime
    ax.plot(data['Soak Duration'], data['Uptime'], marker='o', linestyle='-', color='b', label='Uptime')

    # Plot Free Mem
    ax.plot(data['Soak Duration'], data['Free Mem'], marker='o', linestyle='-', color='g', label='Free Mem')

    ax.set_title('Uptime and Free Mem vs. Soak Duration')
    ax.set_xlabel('Soak Duration')
    ax.set_ylabel('Uptime / Free Mem')
    ax.legend()
    ax.grid(True)

    # Create a table above the plot using numpy with reduced line margins
    table_data = [['Soak Duration', 'Uptime', 'Free Mem']] + \
                 [[str(data['Soak Duration'][i]), str(data['Uptime'][i]), str(data['Free Mem'][i])] for i in range(len(data['Soak Duration']))]

    table = np.array(table_data)
    table = ax.table(cellText=table, cellLoc='center', bbox=[0, 1.1, 1, 0.6])  # Adjust the bbox as needed
    table.auto_set_font_size(False)
    table.set_fontsize(10)
    table.scale(1, 1.5)  # Adjust the scaling factor as needed

    plt.tight_layout()
    plt.show()

# Main function
def main():
    file_path = 'metrics.csv'  # Change to the path of your data file
    data = read_data(file_path, delimiter=',')  # Specify the correct delimiter
    plot_data(data)

if __name__ == "__main__":
    main()
