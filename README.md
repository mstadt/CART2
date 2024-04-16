# CART PKPD model
This code is for my AM 881 (Introduction to Mathematical Oncology) final project. The code replicates and analyzes the PKPD model presented in [Kirouac et al., Nature Biotechnology, 2023.](https://www.nature.com/articles/s41587-023-01687-x) 

## Key files
- **mod_eqns** model equations
- **driver_allpatients.m** Run simulations for all the VPs presented in Kirouac et al., 2023. Model results are saved to directory "sims_patients"
- **plot_allpatients.m** Plot the results from driver_allpatients.m. This is used to make Fig. B.1, B.2, and B.3
- **parameter_PCA.m** conduct PCA and plot results for the 36 VPs from Kirouac et al., 2023. This is used to make Fig. B.4 and B.5
- **param_hists.m** Loads and creates histograms of the parameters for the 36 VPs from Kirouac et al., 2023. This is used to make Fig. B.6, B.7, B.8
- **generateVPparams.m** Generates parameter set for VPs. Results are saved to directory "VP"
- **simulateVP.m** Simulate CART therapy for each VP in the VP set generated from generateVPparams
- **sortVP.m** Creates labels for each of the VP based on the simulation results. NOTE: This requires the file VPsims.zip (see below) or will need to conduct own simulations from simulateVP.m
- **VP_paramPCA.m** Conduct PCA on the VP population results. Makes Fig. C.1.
- **VPparams_hist.m** Conducts ANOVA test for each parameter and plots a histogram of the values for diverges, responders, and non-responders. Makes Fig. C.2 and C.3 - C.8



### Simulation data
The VP simulation data directory VPsim has been uploaded to [https://figshare.com/articles/dataset/VP_simulations_for_CART_project/25612824](https://figshare.com/articles/dataset/VP_simulations_for_CART_project/25612824). This is required to run "sortVP.m".
