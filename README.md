# Exploring ecological drivers of mammalian predator size and diet across the Cenozoic

J.D. Yeakel,
M.C. Hutchinson,
C.P. Kempes,
P.L. Koch,
J.L. Gill,
M.M. Pires


## Abstract
Body size drives the energetic demands of organisms, and largely governs trophic interactions between species. On macroevolutionary timescales, these demands feed back to shape the selective landscape driving the evolution of size and diet. We develop a theoretical framework based on tri-trophic interaction motifs to explore mammalian population dynamics premised on bioenergetic tradeoffs. Our results show how interactions between predators, prey, and external subsidies generate instabilities linked to body size extrema, corresponding to observed limits of predator size and diet. These instabilities generate size-dependent constraints on coexistence and highlight a stabilizing carnivore size of 63 Kg. Finally, we show that increases in predator size confers selective advantage to dietary generalization, aligning with observations of predator diets among contemporary and Pleistocene species. Our framework underscores the importance of understanding macroevolutionary pressures through the lens of ecological interactions, where the selective forces shaping and reshaping the dynamics of communities can be explored.

## File Tree
|── 1_subsidy.nb  
|── 2024_PCR.code-workspace  
|── 2_competition.nb  
|── README.md  
|── contemp_mammal_analysis.R  
|── data  
|     |── carnivore_mass_MoM.csv  
|     |── carnivoredensities_trimmed.csv  
|     |── contemp_mammal_mass_smith_2004.csv  
|     |── data_delong_mammal.csv  
|     |── data_hayward_all.csv  
|     |── densitydata.csv  
|     |── diet_results.csv  
|     |── diet_sinclair_results.csv  
|     |── fixedpointwsPC1C2Ratio.m  
|     |── fixedpointwsPC1C2overWPhi.m  
|     |── mammalian_fit_table.csv  
|     |── mammalian_isotopes_all.xlsx  
|     |── mammalian_mass.csv  
|── diet_analysis.R  
|── file_tree.md  
|── file_tree.txt  
|── ppmr_fit.jl  
|── src  
|     |── allometric_functions_predpersp.nb  
|     |── analysis_functions.nb  
|     |── metabolic_constants.nb  
|     |── ppmr_primary.nb  

## Description
This repository contains the code required to reproduce the analyses used in the manuscript *Exploring ecological drivers of mammalian predator size and diet across the Cenozoic* by JD Yeakel, MC Hutchinson, CP Kempes, PL Koch, JL Gill, and MM Pires. The primary files include the Mathematica files `1_subsidy.nb` and `2_competition.nb`.  
*   `1_subsidy.nb`: This notebook reproduces the analyses for the tri-trophic motif where the predator derives its energy from both an herbivore consumer and an external subsidy.  
*   `2_competition.nb`: This notebook reproduces the analyses for the tri-trophic motif where the predator derives its energy from two herbivore consumers, which both compete for plant resource.  
*   Both notebooks require: `src/allometric_functions_predpersp.nb`, `src/analysis_functions.nb`, `src/metabolic_constants.nb`, and `ppmr_primary.nb`, which are described below.  
    *   `src/metabolic_constants.nb`: Metabolic constants used to parameterize the timescales associated with growth, reproduction, and mortality of the plant resource, both mammalian herbivore species, and the mammalian predator species.  
    *   `src/allometric_functions_predpersp.nb`: Defines functions related to growth, reproduction, and mortality of all species in the motif, integrating the metabolic constants.  
    *   `src/analysis_functions.nb`: Defines numerous functions relating to the analysis of tri-trophic subsidy and competition systems.  
    *   `src/ppmr_primary.nb`: A minimal notebook that integrates the measured *Predator Prey Mass Relationship* that is evaluated in `ppmr_fit.jl`, and defines the expected prey mass given a predator mass $E(M_C|M_P)$. This incorporates the output of the `ppmr_fit.jl` code:  
        *   `mammalian_fit_table.csv`: A table of the best-fit regression to log(prey mass) ~ log(predator mass)
        *   `mammalian_mass.csv`: A list of mammalian predator and prey masses used to find the best-fit PPMR  
*   The notebooks incorporate various data files:  
    *   `densitydata.csv`: Empirical mammalian herbivore mass-density data. Mammalian density data by body size from Damuth et al. (1981). Columns - C1: Body mass (grams); C2: Density (inds/m^2)  
    *   `carnivoredensities_trimmed.csv`: Empirical mammalian carnivore mass-density data. Columns - C1: Body mass (grams); C2: Density (inds/m^2)  
    *   `data_Hayward_all.csv`: Prey preferences and dietary data for large-bodied carnivores collated from Hayward, 2006; Hayward et al., 2006a,b; Hayward and Kerley, 2008, 2005; Hayward et al., 2006c. Columns - C1: Predator; C2: Predbodymasskg; C3: Prey; C4: JacobsIndex; C5: JI_SE; C6: PercentOfKills; C7: SE; C8: Preybodymasskg34adultfemalemass; C9: Preybodymasskg; C10: HerdSize; C11: HabitatDensity; C12: ThreatToPredator. See specific references for details.  
    *   `data_delong_mammal.csv`: Predator and prey mass relationships for mammals in the FoRAGE database (Uiterwaal et al., 2018). C1: Species_name; C2: Pred_mass_mg; C3: Pred_mass_kg; C4: Prey_mass_mg; C5: Prey_mass_kg  
    *   `diet_sinclair_results.csv`: Locality information for contempoary predators alongside prey body mass range as both an absolute value (carn_range; Kg) and a relative (unitless) value (ratio: prey body mass range / total prey range). The total prey range is denoted as herb_range. C1: location; C2: time period; C3: carnivore; C4: herb_range, C5: carn_range; C6: ratio; C7: predmassmin; C8: predmassmax; C9: family; C10: source
    *   `diet_results.csv`: Locality information for Pleistocene predators alongside prey carbon isotopic range as both an absolute value (carn_range; permil) and a relative (unitless) value (ratio: predator isotopic range / prey isotopic range). The prey isotopic range is denoted as herb_range. C1: location; C2: time period; C3: carnivore; C4: herb_range, C5: carn_range; C6: ratio; C7: predmassmin; C8: predmassmax; C9: family; C10: source  
*   `ppmr_fit.jl`: Code used to measure and generated the predator-prey mass relationship used in the mathematica notebooks.  
*   `diet_analyses.R`: Code used to generate the empirical diet breadth measures used in the Mathematica notebooks and stored in `diet_sinclair_results.csv` and `diet_results.csv`  

Note: There are a few code blocks in the Mathematica notebooks that take a long time to run (2-3 hours on 18 cores). To avoid those, the notebooks can alternatively import `fixedpointwsPC1C2overWPhi.m` and `fixedpointwsPC1C2Ratio.m`.
