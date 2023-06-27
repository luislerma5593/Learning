# Functions

## General
```py
str((datetime.now()).strftime('%Y%m%d_%H%M%S%f')[:-4]) #Get specific time format with ms
tqdm - Show computation progress
```

## Conda
* https://docs.conda.io/projects/conda/en/latest/_downloads/843d9e0198f2a193a3484886fa28163c/conda-cheatsheet.pdf
```py
conda env list

conda create -n name
conda install python=3.9.13

conda activate <env>

Pip install --numpy
conda deactivate

python -m pip install --upgrade pip    #Update pip
pip install opencv-python 

conda create --offline --name GPU_AMI #Create environment

conda env export > GPU_AMI.yml    #Exportar en Users\anaconda3\
conda env create -f GPU_AMI.yml    #Importar

conda create --name GPU_AMI --file AMI_ENV.txt    #Create environment
```

## OS
```py
os.path.exists(path) # Verify if path exists
os.listdir(path) #List items inside directory
os.path.join(parent_dir, directory) #Appends directory at the end of parent
os.mkdir(new_path)   #Create 1 dir
os.makedirs(new_path) #Create nested dirs

```

## Examples
```py
for index, filename in  enumerate(os.listdir('.')):

```

### Plot an image
```py
import matplotlib.image as mpimg
img = mpimg.imread(control_image)
imgplot = plt.imshow(img)
plt.show()
```

### Plotting a df with subplots
```py
import matplotlib.pyplot as plt

plt.style.use('seaborn-white')

fig = plt.figure(figsize=(50*1.2,30*1.2))
axes = fig.subplots(3, 3, sharex=True, sharey=False)
index=0
max_index = len(my_df.columns)


palette = ["#223127", "#66071E", "#932D48", "#2281A7", "#F9A03F", "#508991", "#B53737"]

for i in range(3):
    for j in range(3):
        
        if index == max_index:
            continue
        
        my_df.iloc[:,index].plot(ax=axes[i,j], color = palette[index], label = my_df.columns[index])
        axes[i,j].axhline(y=0, linestyle='--', color='k', linewidth=2)
        axes[i,j].legend(fontsize=40)
        
        axes[i, j].tick_params(axis='both', labelsize=40, labelbottom=True)
        axes[i, j].set_xticks(my_df.index)
        
        index += 1

# Delete the last two subplots
axes[-1, -1].remove()
axes[-1, -2].remove()
        
plt.show()
```


















