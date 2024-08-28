# Exploring ecological drivers of mammalian predator size and diet across the Cenozoic

J.D. Yeakel,
M.C. Hutchinson,
C.P. Kempes,
P.L. Koch,
J.L. Gill,
M.M. Pires


## Abstract
Body size drives the energetic demands of organisms, largely constraining trophic interactions between species, and can play a significant role in shaping the feasibility of species' populations in a community. On macroevolutionary timescales, these demands feed back to shape the selective landscape driving the evolution of size and diet. We develop a theoretical framework based on three-level trophic food chain to explore mammalian population dynamics premised on bioenergetic trade-offs.  Our results show that interactions between predators, prey, and external subsidies generate instabilities linked to body size extrema, corresponding to observed limits of predator size and diet. These instabilities generate size-dependent constraints on coexistence and highlight a stabilizing carnivore size range between 40 to 110 Kg, encompassing the mean body size of terrestrial Cenozoic hypercarnivores. Finally, we show that predator dietary generalization confers a selective advantage with larger body size, up to a point where those advantages then decline at very large size classes, aligning with observations of contemporary and Pleistocene species. Our framework underscores the importance of understanding macroevolutionary pressures through the lens of ecological interactions, where the selective forces shaping and reshaping the dynamics of communities can be explored.

## File Tree
|── 1_subsidy.nb  
|── 2024_PredSizeDiet.code-workspace  
|── 2_competition_gen.nb  
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
|     |── fixedpointwsPH1H2Ratio.m  
|     |── fixedpointwsPH1H2overWPhi.m  
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
This repository contains the code required to reproduce the analyses used in the manuscript *Exploring ecological drivers of mammalian predator size and diet across the Cenozoic* by JD Yeakel, MC Hutchinson, CP Kempes, PL Koch, JL Gill, and MM Pires. The primary files include the Mathematica files `1_subsidy.nb` and `2_competition_gen.nb`.  
*   `/1_subsidy.nb`: This notebook reproduces the analyses for the subsidy model where the predator derives its energy from both an herbivore prey and an external subsidy.  
*   `/2_competition_gen.nb`: This notebook reproduces the analyses for the competition model where the predator derives its energy from two herbivore prey, which both compete for a plant resource.  
*   Both notebooks require: `src/allometric_functions_predpersp.nb`, `src/analysis_functions.nb`, `src/metabolic_constants.nb`, and `ppmr_primary.nb`, which are described below.  
    *   `/src/metabolic_constants.nb`: Metabolic constants used to parameterize the timescales associated with growth, reproduction, and mortality of the plant resource, both mammalian herbivore species, and the mammalian predator species.  
    *   `/src/allometric_functions_predpersp.nb`: Defines functions related to growth, reproduction, and mortality of all species in the motif, integrating the metabolic constants.  
    *   `/src/analysis_functions.nb`: Defines numerous functions relating to the analysis of subsidy and competition models.  
    *   `/src/ppmr_primary.nb`: A minimal notebook that integrates the measured *Predator Prey Mass Relationship* that is evaluated in `/ppmr_fit.jl`, and defines the expected prey mass given a predator mass $E(M_H|M_P)$. This incorporates the output of the `/ppmr_fit.jl` code:  
        *   `/data/mammalian_fit_table.csv`: A table of the best-fit regression to log(prey mass) ~ log(predator mass)
        *   `/data/mammalian_mass.csv`: A list of mammalian predator and prey masses used to find the best-fit PPMR  
*   The notebooks incorporate various data files:  
    *   `/data/densitydata.csv`: Mammalian density data by body size from Damuth et al. (1981). Columns - C1: Body mass (grams); C2: Density (inds/m^2)  
    *   `/data/carnivoredensities_trimmed.csv`: Mammalian carnivore density data by body size from Carbon & Gittleman (2002). Columns - C1: Body mass (grams); C2: Density (inds/m^2)  
    *   `/data/data_Hayward_all.csv`: Prey preferences and dietary data for large-bodied carnivores collated from Hayward, 2006; Hayward et al., 2006a,b; Hayward and Kerley, 2008, 2005; Hayward et al., 2006c. Columns - C1: Predator; C2: Predbodymasskg; C3: Prey; C4: JacobsIndex; C5: JI_SE; C6: PercentOfKills; C7: SE; C8: Preybodymasskg34adultfemalemass; C9: Preybodymasskg; C10: HerdSize; C11: HabitatDensity; C12: ThreatToPredator. See specific references for details.  
    *   `/data_delong_mammal.csv`: Predator and prey mass relationships for mammals in the FoRAGE database (Uiterwaal et al., 2018). Columns - C1: Species_name; C2: Pred_mass_mg; C3: Pred_mass_kg; C4: Prey_mass_mg; C5: Prey_mass_kg  
    *   `/data/diet_sinclair_results.csv`: Locality information for contempoary predators alongside prey body mass range as both an absolute value (carn_range; Kg) and a relative (unitless) value (ratio: prey body mass range / total prey range). The total prey range is denoted as herb_range. Data from (Sinclair et al. 2003). Columns - C1: location; C2: time period; C3: carnivore; C4: herb_range, C5: carn_range; C6: ratio; C7: predmassmin; C8: predmassmax; C9: family; C10: source
    *   `/data/diet_results.csv`: Locality information for Pleistocene predators alongside prey carbon isotopic range as both an absolute value (carn_range; permil) and a relative (unitless) value (ratio: predator isotopic range / prey isotopic range). The prey isotopic range is denoted as herb_range. Data from (Anyonge & Roman, 2006; Christiansen & Harris, 2005; Coltrain et al., 2004; Dantas, 2022; DeSantis et al., 2021; Feranec & DeSantis, 2014; Figueirido et al., 2011; Flower, 2016; Fox-Dobbs et al., 2008; Fuller et al., 2014; Fuller et al., 2020; Gazin, 1942; Hill & Easterla, 2023; Koch et al., 2004; Koufos et al., 2018; Marciszak & Lipecki, 2022; Palmqvist et al., 1996; Palmqvist et al., 2002; Palmqvist et al., 2008; Sherani, 2016; Sorkin, 2006; Trayler et al., 2015). Columns - C1: location; C2: time period; C3: carnivore; C4: herb_range, C5: carn_range; C6: ratio; C7: predmassmin; C8: predmassmax; C9: family; C10: source  
*   `/ppmr_fit.jl`: Code used to measure and generated the predator-prey mass relationship used in the mathematica notebooks.  
*   `/diet_analyses.R`: Code used to generate the empirical diet breadth measures used in the Mathematica notebooks and stored in `/data/diet_sinclair_results.csv` and `/data/diet_results.csv`  
*   `/contemp_mammalian_analysis.R`: Code to calculate the average body mass of both contemporary and Cenozoic carnivorans. Incorporates data from `/data/contemp_mammal_mass_smith_2004.csv` (Smith et al., 2004) and `/data/carnivore_mass_MoM.csv` (Smith et al., 2003).  
    *   `/data/contemp_mammal_mass_smith_2004.csv`: Contemporary mammal body size and locality information (Smith et al. 2004). Columns - C1: continent; C2: order; C3: family; genus; C4: genus_age; C5: richness; C6: mass_mean_log10; C7: mass_mean_grams  
    *   `/data/carnivore_mass_MoM.csv`: Cenozoic carnivoran body size information extract from the Mass of Mammals Database (MoM v.4.1) (Smith et al. 2003): Columns - C1: Order; C2: Family; C3: Genus; C4: Species; C5: Mass_g  

>   Note: There are a few code blocks in the Mathematica notebooks that take a long time to run (2-3 hours on 18 cores). To avoid those, the notebooks can alternatively import `fixedpointwsPH1H2overWPhi.m` and `fixedpointwsPH1H2Ratio.m`.
<!-- 
## References
*   Damuth, J. 1981. Population density and body size in mammals. Nature 290:699–700.  
*   Carbone, C., and J. L. Gittleman. 2002. A common rule for the scaling of carnivore density. Science 295:2273–2276.
*   Hayward, M. 2006. Prey preferences of the spotted hyaena (*Crocuta crocuta*) and degree of dietary overlap with the lion (*Panthera leo*). J. Zoology 270:606–614.  
*   Hayward, M., P. Henschel, J. O'Brien, M. Hofmeyr, G. Balme, and G. I. Kerley. 2006a. Prey preferences of the leopard (*Panthera pardus*). Journal of Zoology 270:298–313.  
*   Hayward, M., M. Hofmeyr, J. O'brien, and G. I. Kerley. 2006b. Prey preferences of the cheetah (*Acinonyx jubatus*)(felidae: Carnivora): morphological limitations or the need to capture rapidly consumable prey before kleptoparasites arrive? Journal of Zoology 270:615–627.  
*   Hayward, M. W., and G. Kerley. 2008. Prey preferences and dietary overlap amongst Africa's large predators. S. African J. Wild. Res. 38:93–108.  
*   Hayward, M. W., and G. I. Kerley. 2005. Prey preferences of the lion (*Panthera leo*). Journal of zoology 267:309–322.  
*   Hayward, M. W., J. O'Brien, M. Hofmeyr, and G. I. Kerley. 2006c. Prey preferences of the african wild dog *Lycaon pictus* (canidae: Carnivora): ecological requirements for conservation. Journal of Mammalogy 87:1122–1131  
*   Sinclair, A.R.E., Mduma, S. & Brashares, J.S. (2003). Patterns of predation in a diverse predator–prey system. Nature, 425, 288–290  
*   Smith, F., Brown, J.H., Haskell, J., Lyons, S., Alroy, J., Charnov, E., Dayan, T., Enquist, B., Morgan Ernest, S. & Hadly, E. (2004). Similarity of mammalian body size across the taxonomic hierarchy and across space and time. Am. Nat., 163, 672–691.  
*   Smith, F.A., Lyons, S.K., Ernest, S.M., Jones, K.E., Kaufman, D.M., Dayan, T., Marquet, P.A., Brown, J.H. & Haskell, J.P. (2003). Body mass of late quaternary mammals: ecological archives e084-094. Ecology, 84, 3403–3403. -->


### References

*   Anyonge, W. & Roman, C. (2006). New body mass estimates for Canis dirus, the extinct Pleistocene dire wolf. Journal of Vertebrate Paleontology, 26(1), 209-212.

*   Carbone, C., and J. L. Gittleman. (2002). A common rule for the scaling of carnivore density. Science, 295, 2273-2276.

*   Christiansen, P. & Harris, J. M. (2005). Body size of Smilodon (Mammalia: Felidae). Journal of Morphology, 266(3), 369-384.

*   Coltrain, J. B., Harris, J. M., Cerling, T. E., Ehleringer, J. R., Dearing, M. D., Ward, J. & Allen, J. (2004). Rancho La Brea stable isotope biogeochemistry and its implications for the palaeoecology of late Pleistocene, coastal southern California. Palaeogeography, Palaeoclimatology, Palaeoecology, 205(3-4), 199-219.

*   Damuth, J. (1981). Population density and body size in mammals. Nature, 290, 699-700.

*   Dantas, M. A. T. (2022). Estimating the body mass of the late Pleistocene megafauna from the South America Intertropical Region and a new regression to estimate the body mass of extinct xenarthrans. Journal of South American Earth Sciences, 119, 103900.

*   DeSantis, L. R. G., Feranec, R. S., Antón, M. & Lundelius, E. L. (2021). Dietary ecology of the scimitar-toothed cat Homotherium serum. Current Biology, 31(12), 2674-2681.

*   Feranec, R. S. & DeSantis, L. R. G. (2014). Understanding specifics in generalist diets of carnivorans by analyzing stable carbon isotope values in Pleistocene mammals of Florida. Paleobiology, 40(3), 477-493.

*   Figueirido, B., Pérez-Claros, J. A., Hunt, R. M. & Palmqvist, P. (2011). Body mass estimation in amphicyonid carnivoran mammals: a multiple regression approach from the skull and skeleton. Acta Palaeontologica Polonica, 56(2), 225-246.

*   Flower, L. O. H. (2016). New body mass estimates of British Pleistocene wolves: Palaeoenvironmental implications and competitive interactions. Quaternary Science Reviews, 149, 230-247.

*   Fox-Dobbs, K., Leonard, J. A. & Koch, P. L. (2008). Pleistocene megafauna from eastern Beringia: Paleoecological and paleoenvironmental interpretations of stable carbon and nitrogen isotope and radiocarbon records. Palaeogeography, Palaeoclimatology, Palaeoecology, 261(1-2), 30-46.

*   Fuller, B. T., Fahrni, S. M., Harris, J. M., Farrell, A. B., Coltrain, J. B., Gerhart, L. M., Ward, J. K., Taylor, R. E. & Southon, J. R. (2014). Ultrafiltration for asphalt removal from bone collagen for radiocarbon dating and isotopic analysis of Pleistocene fauna at the tar pits of Rancho La Brea, Los Angeles, California. Quaternary Geochronology, 22, 85-98.

*   Fuller, B. T., Southon, J. R., Fahrni, S. M., Farrell, A. B., Takeuchi, G. T., Nehlich, O., Guiry, E. J., Richards, M. P., Lindsey, E. L. & Harris, J. M. (2020). Pleistocene paleoecology and feeding behavior of terrestrial vertebrates recorded in a pre-LGM asphaltic deposit at Rancho La Brea, California. Palaeogeography, Palaeoclimatology, Palaeoecology, 537, 109383.

*   Gazin, C. L. (1942). The late Cenozoic vertebrate faunas from the San Pedro Valley, Ariz. Proceedings of the United States National Museum.

*   Hayward, M. (2006). Prey preferences of the spotted hyaena (*Crocuta crocuta*) and degree of dietary overlap with the lion (*Panthera leo*). J. Zoology, 270, 606-614.

*   Hayward, M., Henschel, P., O'Brien, J., Hofmeyr, M., Balme, G. & Kerley, G. I. (2006a). Prey preferences of the leopard (*Panthera pardus*). Journal of Zoology, 270, 298-313.

*   Hayward, M., Hofmeyr, M., O'brien, J. & Kerley, G. I. (2006b). Prey preferences of the cheetah (*Acinonyx jubatus*)(felidae: Carnivora): morphological limitations or the need to capture rapidly consumable prey before kleptoparasites arrive? Journal of Zoology, 270, 615-627.

*   Hayward, M. W. & Kerley, G. I. (2005). Prey preferences of the lion (*Panthera leo*). Journal of Zoology, 267, 309-322.

*   Hayward, M. W. & Kerley, G. I. (2008). Prey preferences and dietary overlap amongst Africa's large predators. S. African J. Wild. Res., 38, 93-108.

*   Hayward, M. W., O'Brien, J., Hofmeyr, M. & Kerley, G. I. (2006c). Prey preferences of the African wild dog *Lycaon pictus* (canidae: Carnivora): ecological requirements for conservation. Journal of Mammalogy, 87, 1122-1131.

*   Hill, M. G. & Easterla, D. A. (2023). A complete sabertooth cat cranium from the Midcontinent of North America and its evolutionary and ecological context. Quaternary Science Reviews, 307, 108045.

*   Koch, P. L., Diffenbaugh, N. S. & Hoppe, K. A. (2004). The effects of late Quaternary climate and pCO2 change on C4 plant abundance in the south-central United States. Palaeogeography, Palaeoclimatology, Palaeoecology, 207(3-4), 331-357.

*   Koufos, G. D., Konidaris, G. E. & Harvati, K. (2018). Revisiting Ursus etruscus (Carnivora, Mammalia) from the Early Pleistocene of Greece with description of new material. Quaternary International, 497, 222-239.

*   Marciszak, A. & Lipecki, G. (2022). Panthera gombaszoegensis (Kretzoi, 1938) from Poland in the scope of the species evolution. Quaternary International, 633, 36-51.

*   Palmqvist, P., Martínez-Navarro, B. & Arribas, A. (1996). Prey selection by terrestrial carnivores in a lower Pleistocene paleocommunity. Paleobiology, 22(4), 514-534.

*   Palmqvist, P., Mendoza, M., Arribas, A. & Gröcke, D. R. (2002). Estimating the body mass of Pleistocene canids: discussion of some methodological problems and a new ‘taxon free’ approach. Lethaia, 35(4), 358-360.

*   Palmqvist, P., Pérez-Claros, J. A. & Hunt, R. M. (2011). Body mass estimation in amphicyonid carnivoran mammals: a multiple regression approach from the skull and skeleton. Acta Palaeontologica Polonica, 56(2), 225-246.

*   Palmqvist, P., Pérez-Claros, J. A., Janis, C. M. & Gröcke, D. R. (2008). Tracing the ecophysiology of ungulates and predator--prey relationships in an early Pleistocene large mammal community. Palaeogeography, Palaeoclimatology, Palaeoecology, 266(1-2), 95-111.

*   Sherani, S. (2016). A new specimen-dependent method of estimating felid body mass. PeerJ Preprints, 4, e2327v1.

*   Sinclair, A. R. E., Mduma, S. & Brashares, J. S. (2003). Patterns of predation in a diverse predator–prey system. Nature, 425, 288-290.

*   Smith, F. A., Brown, J. H., Haskell, J., Lyons, S., Alroy, J., Charnov, E., Dayan, T., Enquist, B., Morgan Ernest, S. & Hadly, E. (2004). Similarity of mammalian body size across the taxonomic hierarchy and across space and time. American Naturalist, 163, 672-691.

*   Smith, F. A., Lyons, S. K., Ernest, S. M., Jones, K. E., Kaufman, D. M., Dayan, T., Marquet, P. A., Brown, J. H. & Haskell, J. P. (2003). Body mass of late Quaternary mammals: ecological archives e084-094. Ecology, 84, 3403-3403.

*   Sorkin, B. (2006). Ecomorphology of the giant short-faced bears Agriotherium and Arctodus. Historical Biology, 18(1), 1-20.

*   Trayler, R. B., Dundas, R. G., Fox-Dobbs, K. & Van De Water, P. K. (2015). Inland California during the Pleistocene—Megafaunal stable isotope records reveal new paleoecological and paleoenvironmental insights. Palaeogeography, Palaeoclimatology, Palaeoecology, 437, 132-140.

*   Uiterwaal, S.F., Lagerstrom, I.T., Lyon, S.R. & DeLong, J.P. (2022). Forage database: A compilation
of functional responses for consumers and parasitoids. Ecology, 103, e3706.