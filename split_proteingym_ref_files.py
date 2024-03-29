import pandas as pd
import os, sys

BATCH_SIZE = 30

if __name__ == '__main__':
    assert(len(sys.argv) == 2)
    
    file_path = sys.argv[1]
    if not os.path.isdir('CHTC_reference_files'):
        os.mkdir('CHTC_reference_files')
    filename = file_path.split(os.sep)[-1].split('.')[0]


    csv = pd.read_csv(file_path)
    csvs = []
    dividing_indices = [(i*BATCH_SIZE, (i+1)*BATCH_SIZE-1) for i in range(len(csv)//BATCH_SIZE - 1)]
    print(dividing_indices)
    for ind in dividing_indices:
        csvs.append(csv.loc[ind[0]:ind[1]].copy())
        csvs[-1].reset_index(inplace = True, drop = True)
    
    for i,c in enumerate(csvs):
        c.to_csv(f'CHTC_reference_files/{filename}_queue{i}.csv')

