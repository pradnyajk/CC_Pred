
# Cervical Cancer Prediction using ML

ML based classification model to predict given sample is tumor or normal.


## Contents
* ``data`` This folder contains the dump of classification models
* ``predict.R`` This is the R script for making predictions on the test set
## System Dependencies
* R language (64 bit) 
* make sure to add the path of R language to the sytem environment variables.
For adding path of R language to system environment variable use following command:                        
```bash
pathman /au C:\Program Files\R\R-4.3.2\bin\x64\
```                                                                               
Above command is for R version 4.3.2, change it according to the R version installed               
For example for R version 4.2.0:                                                       
```bash
pathman /au C:\Program Files\R\R-4.2.0\bin\x64\
```

## Required R libraries
* Use following command in the command prompt to install required R libraries:                                                         
```bash
Rscript -e "install.packages(c('kernlab','randomForest','caret','class','xgboost'),repos='https://cloud.r-project.org', dependencies=TRUE)"
```
## Usage
### To make the prediction need log2 normalized gene expression values of following set of genes in following order:

* C1QTNF7
* TRHDE
* LYVE1
* HPSE2
* GSTM5
* APOD
* CRISP3
* COL14A1
* CDKN2A
* MYBL2
* MCM2
* SPARCL1
* KIF2C
* PAMR1
* LAMA2
* SLC18A2
* OGN
* EMCN
* AR
* PDK4
* CGNL1
* NUF2
* PLK1
* DCN
* NUSAP1
* DUSP1
* AURKA
* STIL
* GJA1
* ASF1B

#### **See the sample_data.csv in ``data`` folder.*
#### If gene expression values are non normalized, then normalize them using log2 normalization 

### 1. Download the repository and save all the files and folders of repository in one folder.
### 2. Then Use the follwing command by changing current working directory to the folder where repository predict.R is saved.
```bash
Rscript predict.R
```
### 3. User wil be prompted to select ``.csv`` file of sample gene expression data of above 14 genes.  
### 4. Once the .csv file is selected and the process is completed, results will be saved in ``cervical_cancer_prediction.csv`` file.




