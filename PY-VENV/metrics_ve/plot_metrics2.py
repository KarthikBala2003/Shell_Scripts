import matplotlib.pyplot as plt
from matplotlib.table import Table

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
    fig, ax = plt.subplots(figsize=(10, 5))

    # Plot Uptime
    ax.plot(data['Soak Duration'], data['Uptime'], marker='o', linestyle='-', color='b', label='Uptime')

    # Plot Free Mem
    ax.plot(data['Soak Duration'], data['Free Mem'], marker='o', linestyle='-', color='g', label='Free Mem')

    ax.set_title('Uptime and Free Mem vs. Soak Duration')
    ax.set_xlabel('Soak Duration')
    ax.set_ylabel('Uptime / Free Mem')
    ax.legend()
    ax.grid(True)

    # Add some space below the X-axis
    plt.subplots_adjust(bottom=0.2)

    # Add data as a table
    table_data = []
    table_data.append(['Soak Duration', 'Uptime', 'Free Mem'])
    for i in range(len(data['Soak Duration'])):
        table_data.append([data['Soak Duration'][i], data['Uptime'][i], data['Free Mem'][i]])

    table = ax.table(cellText=table_data, loc='bottom', cellLoc='center')
    table.auto_set_font_size(False)
    table.set_fontsize(10)
    table.scale(1, 1.2)

    plt.tight_layout()
    plt.show()

# Main function
def main():
    file_path = 'metrics_data.csv'  # Change to the path of your data file
    data = read_data(file_path, delimiter=',')  # Specify the correct delimiter
    plot_data(data)

if __name__ == "__main__":
    main()