import pandas as pd
import os, sys

BATCH_SIZE = 7

if __name__ == '__main__':
    if len(sys.argv) == 2:
        output_dir = 'CHTC_reference_files'
    elif len(sys.argv) == 3:
        output_dir = sys.argv[2]
    else:
        print("Usage: python split_proteingym_ref_files.py <path_to_input_csv> <path_to_output_dir>")
        exit(1)

    file_path = sys.argv[1]

    if not os.path.isdir(output_dir):
        os.mkdir(output_dir)
    filename = file_path.split(os.sep)[-1].split('.')[0]


    csv = pd.read_csv(file_path)
    csvs = []
    dividing_indices = [(i*BATCH_SIZE, (i+1)*BATCH_SIZE-1) for i in range(len(csv)//BATCH_SIZE - 1)]
    dividing_indices.append(((len(csv)//BATCH_SIZE - 1)*BATCH_SIZE, len(csv)-1))

    print(f"Indices: {dividing_indices}")
    for ind in dividing_indices:
        csvs.append(csv.loc[ind[0]:ind[1]].copy())
        csvs[-1].reset_index(inplace = True, drop = True)
    
    for i,c in enumerate(csvs):
        c.to_csv(f'{output_dir}/{filename}_queue{i}.csv')

