import matplotlib.pyplot as plt

# Function to read data from a CSV file without pandas
def read_data(file_path):
    data = {'oak Duration': [], 'Uptime': [], 'Free Mem': []}

    with open(file_path, 'r') as file:
        lines = file.readlines()

    # Skip the header line
    lines = lines[1:]

    for line in lines:
        values = line.strip().split('\t')

        # Check if there are enough values on this line
        if len(values) != 3:
            print(f"Skipping line due to incorrect format: {line.strip()}")
            continue

        try:
            oak_duration = int(values[0])
            uptime = int(values[1])
            free_mem = int(values[2])

            data['oak Duration'].append(oak_duration)
            data['Uptime'].append(uptime)
            data['Free Mem'].append(free_mem)
        except ValueError:
            print(f"Skipping line due to invalid values: {line.strip()}")

    return data

# Function to plot data
def plot_data(data):
    plt.figure(figsize=(10, 5))

    # Plot Uptime
    plt.plot(data['oak Duration'], data['Uptime'], marker='o', linestyle='-', color='b', label='Uptime')

    # Plot Free Mem
    plt.plot(data['oak Duration'], data['Free Mem'], marker='o', linestyle='-', color='g', label='Free Mem')

    plt.title('Uptime and Free Mem vs. Oak Duration')
    plt.xlabel('Oak Duration')
    plt.ylabel('Uptime / Free Mem')
    plt.legend()
    plt.grid(True)
    plt.tight_layout()
    plt.show()

# Main function
def main():
    file_path = 'metrics_data.csv'  # Change to the path of your data file
    data = read_data(file_path)
    plot_data(data)

if __name__ == "__main__":
    main()
