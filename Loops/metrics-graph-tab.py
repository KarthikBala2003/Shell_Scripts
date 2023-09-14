import pandas as pd
import matplotlib.pyplot as plt

# Define a function to read data from a CSV file and create plots
def create_plots(file_path):
    # Read the CSV file into a DataFrame
    df = pd.read_csv(file_path, delimiter='\t')

    # Extract data from the DataFrame
    mnemonics = df['Mnemonic']
    uptime = df['Uptime']
    mem_free = df['MemFree']

    # Plot a line graph
    plt.figure(figsize=(10, 5))
    plt.plot(mnemonics, mem_free, marker='o', linestyle='-', color='b')
    plt.title('Memory Free vs Mnemonic')
    plt.xlabel('Mnemonic')
    plt.ylabel('MemFree')
    plt.xticks(rotation=45)
    plt.grid(True)
    plt.tight_layout()
    plt.savefig('line_graph.png')
    plt.show()

    # Plot a bar graph
    plt.figure(figsize=(10, 5))
    plt.bar(mnemonics, uptime, color='g')
    plt.title('Uptime vs Mnemonic')
    plt.xlabel('Mnemonic')
    plt.ylabel('Uptime')
    plt.xticks(rotation=45)
    plt.grid(True)
    plt.tight_layout()
    plt.savefig('bar_graph.png')
    plt.show()

# Call the function with the CSV file path
create_plots('metrics.csv')


