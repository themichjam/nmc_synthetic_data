# NMC Synthetic Data Creation & Exploration

Data creation and exploration of the Nursing and Midwifery Council (NMC) revalidation records, including synthetic data generation.

## Synthetic data

Using the `simstudy` package, we're creating a synthetic dataset based on the variables in the Nursing & Midwifery Council's (NMC) revalidation records on registered nurses in the UK.

* [`create_synthetic__nmc_variables.Rmd`](./create_synthetic_nmc_variables.Rmd) - contains a script that translates the NMC list of variables into lists/vectors of variable names; these are fed into `simstudy` to create a 'dummy' dataset to demonstrate what further analyses could be done with the NMC's data.

**Credit has to go to [SCADR's Jan Savinc](https://www.scadr.ac.uk/about-us/our-people/jan-savinc) - also on [GitHub](https://github.com/jsavn) - for developing the skeleton of this synthetic data creation in 2021.**

## Project Structure

I structure all my ```R``` projects in a (hopefully) open and reproducable way. This projects structure is as follows;

### Overview
```
.
└── this_project
    ├── data
    │   ├── raw
    │   ├── processed
    │   └── metadata
    ├── docs
    ├── figs
    ├── imgs
    ├── output 
    ├── R
    ├── rmd
    ├── scripts
    ├── README.md
    ├── Rproj
    └── .gitignore
```

### The ```data``` folder


