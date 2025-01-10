# Project Overview
This project explores two key areas:

1. **Principal Component Analysis (PCA):** A custom algorithm (myPCA) was developed to analyze COVID-19 data from 27 countries, reducing its dimensionality from six variables to two principal components. This enabled visual insights into relationships between variables such as infection rate, mortality rate, and cure rate.
2. **Spatial S.I.R. Model:** A spatially-resolved Susceptible-Infectious-Recovered (S.I.R.) model was implemented to simulate the spread of infectious diseases across a 50x75 grid. The project includes numerical solutions using a Fourth-Order Runge-Kutta (RK4) algorithm and MATLAB's ode45 solver.

# Objectives
1. Develop and test a custom PCA algorithm for dimensionality reduction.
2. Create and solve a spatial S.I.R. model to simulate infection dynamics.
3. Visualize results with biplots, time-series plots, and 2D animations.

# Part 1: Principal Component Analysis
# Methodology
- Custom PCA Algorithm (myPCA):
  - Normalizes input data.
  - Computes covariance matrix, eigenvalues, and eigenvectors.
  - Identifies principal components based on sorted eigenvalues.
  - Projects data into a lower-dimensional space (2D).

- **Data Source:**
  COVID-19 data from 27 countries, including variables like Infection Rate, Cure Rate, and Mortality Rate.

# Results
- Biplot Visualization:
  - Displayed relationships between variables and principal components.
  - Revealed positive correlations (e.g., Mortality Rate and Deaths) and negative correlations (e.g., Infection Rate and Cure Rate).
- Insights:
  - Principal Component 1 correlated strongly with Cures and Cure Rate.
  - Principal Component 2 distinguished countries with high Cure Rate but low Infection Rate.

# Part 2: Spatial S.I.R. Model
# Methodology
- Differential Equations:
  - Modeled disease dynamics for Susceptible (S), Infected (I), and Recovered (R) populations.
  - Incorporated spatial contact rates with weighting functions for grid-based interactions.
- RK4 Solver:
  - Implemented the Fourth-Order Runge-Kutta algorithm for numerical solutions.
  - Compared performance with MATLAB's built-in ode45 solver.
- Visualization:
  - **Time-Series Plots:** Showed S, I, R dynamics over time for specific grid locations.
  - **2D Animations:** Illustrated the spatial spread of infection over the entire grid.

# Results
- Performance:
  - **RK4 runtime:** ~0.98 seconds
  - **ode45 runtime:** ~0.26 seconds (4x faster due to adaptive time-stepping).
- Insights:
  - Infection spreads radially across the grid, with red (infected) areas growing initially, followed by green (recovered) areas dominating as the infection subsides.
  - By the end of the simulation, the entire grid transitions to recovered (green).

# Key Highlights
- **Custom Algorithm:** The myPCA function demonstrated versatility for dimensionality reduction in real-world datasets.
- **S.I.R. Modeling:** Successfully simulated and visualized infection dynamics with RK4 and ode45.
- **Visualization:** Clear and intuitive animations and plots for analyzing disease spread and population recovery.

# How to Run
1. Load COVID-19 data or the initial values for the S.I.R. model.
2. Run the myPCA function for PCA analysis and visualization.
3. Use the solveSpatialSIR function with RK4 or ode45 to simulate the S.I.R. model.
4. Generate plots and animations with plotTimeSeries and animate functions.

# Future Enhancements
- Extend the S.I.R. model to include additional states (e.g., Exposed, Vaccinated).
- Implement parallel processing for faster simulations on larger grids.
- Apply myPCA to other high-dimensional datasets for broader applications.
