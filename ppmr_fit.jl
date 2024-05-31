using(DataFrames)
using(CSV)
using(RCall)
using(LinearAlgebra)
using(Distributions)
using(Distributed)
using(UnicodePlots)

haywardfulldata = CSV.read("$(homedir())/Dropbox/PostDoc/2024_PCR/data/data_hayward_all.csv",header=true,DataFrame);

delongdata = CSV.read("$(homedir())/Dropbox/PostDoc/2024_PCR/data/data_delong_mammal.csv",header=true,DataFrame);

# "Panthera leo"
# "Crocuta crocuta"
# "Panthera pardus"
# "Cuon alpinus"
# "Lycaon pictus"
# "Acinonyx jubatus"
# "Panthera tigris"


# Cut out predators < 50 kg
# unique(haywardfulldata[!,:Predbodymasskg])
smallpreds = findall(x->x<50,haywardfulldata[!,:Predbodymasskg]);
# This doesn't make a big difference (1.45 vs. 1.48)
haywardfulldata = delete!(haywardfulldata,smallpreds);

#Caculcate mean preferred mass per predator
preds = unique(haywardfulldata[!,:Predator]);

#SIMULATION FIT
function genpredprey()
    preyinds = Array{Float64}(undef,0);
    predinds = Array{Float64}(undef,0);
    meancarnivore = Array{Float64}(undef,0);
    meanherbivore = Array{Float64}(undef,0);
    meancarnivorediet = Array{Float64}(undef,length(preds));
    for i=1:length(preds)
        pref = haywardfulldata[!,:PercentOfKills][findall(x->x==preds[i],haywardfulldata[!,:Predator])];
        pref[findall(isnan,pref)].=0.;
        #Average non-zero entries
        # nonzeromean = mean(pref[findall(!iszero,pref)]);
        # pref[findall(iszero,pref)].=nonzeromean;
        # pref = round.((pref)*10000);
        pref = round.((pref ./ sum(pref))*1000); #10000
        preyind = sum(pref);

        meanpredmass = mean(haywardfulldata[!,:Predbodymasskg][findall(x->x==preds[i],haywardfulldata[!,:Predator])]);

        #Save mean predator value
        push!(meancarnivore,meanpredmass);

        # meanpredmass *= groupsize[i];
        predmassSD = 0.1*meanpredmass;
        predbodysizedist = Normal(meanpredmass,predmassSD);

        #DRAW BODY SIZES FOR PREDATOR INDIVIDUALS
        predinds_draw = abs.(rand(predbodysizedist,Int64(preyind)));
        predinds = [predinds; predinds_draw];
        preyi = haywardfulldata[!,:Prey][findall(x->x==preds[i],haywardfulldata[!,:Predator])];
        
        #Make empty preyinds list for predator i
        preyinds_predi = Array{Float64}(undef,0);
        for j=1:length(preyi)
            if pref[j] > 0.
                #draw body masses
                #Preybodymasskg
                #Preybodymasskg34adultfemalemass
                meanmass = haywardfulldata[!,:Preybodymasskg34adultfemalemass][findall(x->x==preds[i],haywardfulldata[!,:Predator])][j];
                #Save mean herbivore value
                push!(meanherbivore,meanmass);
                massSD = 0.25*meanmass;
                preybodysizedist = Normal(meanmass,massSD);
                numbers = Int64(pref[j]);
                preyinds_draw = abs.(rand(preybodysizedist,numbers));
                #Build predator-specific prey inds first, then contatenate to full list after loop
                #NOTE: checked and this doesn't change anything
                preyinds_predi = [preyinds_predi; preyinds_draw];
            end
        end
        meancarnivorediet[i] = mean(preyinds_predi);
        #Concatenate full list
        preyinds = [preyinds; preyinds_predi];
        
    end
    return(predinds,preyinds,meancarnivore,meanherbivore,meancarnivorediet)
end

function lineartablebuild(x,y)
    #Expected Prey size as a function of predator size
    R"""
    linearmodel = lm(log($y) ~ log($x))
    summary(linearmodel)
    fitintercept = linearmodel[[1]][[1]];
    fitslope = linearmodel[[1]][[2]];
    CI = confint(linearmodel,level=0.95)
    intlow = CI[[1]];
    slopelow = CI[[2]];
    inthigh = CI[[3]];
    slopehigh = CI[[4]];
    """
    fitintercept = @rget fitintercept;
    fitslope = @rget fitslope;
    intlow = @rget intlow;
    slopelow = @rget slopelow;
    inthigh = @rget inthigh;
    slopehigh = @rget slopehigh;

    #Export for the mathematica notebook
    fit_table = DataFrame([fitintercept intlow inthigh; fitslope slopelow slopehigh], :auto);
    rename!(fit_table,[:Fit,:FitLow,:FitHigh])
    return fit_table
end


predinds,preyinds,meancarnivore,meanherbivore,meancarnivorediet = genpredprey();
R"""
par(mfrow=c(2,2))
plot($predinds,$preyinds,log='xy',pch='.')
"""


sizebins = 100;
reps = 1000;
RawPrey_preds = Array{Float64}(undef,reps,length(preds));
RawPrey_preys = Array{Float64}(undef,reps,length(preds));

# Not really useful for this analysis, but doesn't hurt either
for r = 1:reps

    predinds,preyinds,meancarnivore,meanherbivore,meancarnivorediet = genpredprey();

    # ## EXPECTED PREDATOR MASS GIVEN PREY MASS
    RawPrey_preds[r,:] = meancarnivore;
    RawPrey_preys[r,:] = meancarnivorediet;

end

RawPrey_preds_mean = mean(RawPrey_preds,dims=1);
RawPrey_preys_mean = mean(RawPrey_preys,dims=1);


# Delong data - RAW DATA
delong_preds = unique(delongdata[!,:Species_name]);
#NOTE: remove ursus arctos - it is matched only with salmon
# delong_preds = delong_preds[delong_preds .!= "Ursus arctos"];
# This doesn't make a big difference
delong_predmass = Array{Float64}(undef,length(delong_preds));
delong_preymass = Array{Float64}(undef,length(delong_preds));
for i=1:length(delong_preds)
    predi = findall(x->x==delong_preds[i],delongdata[!,:Species_name]);
    delong_predmass[i] = mean(delongdata[predi,:Pred_mass_kg]);
    delong_preymass[i] = mean(delongdata[predi,:Prey_mass_kg]);
end

# RawPrey_sizetable_delong = DataFrame([delong_predmass delong_preymass],:auto);
# rename!(RawPrey_sizetable_delong,[:predmass,:preymass]);
# CSV.write("$(homedir())/Dropbox/PostDoc/2022_PredatorConsumerResource/data/RawPreymass_delong.csv",RawPrey_sizetable_delong; header=false);


#Evaluate fit for all MEAN MAMMALIAN DATA (Hayward + Delong)
RawMammalianMean_preds = vec([RawPrey_preds_mean'; delong_predmass]);
RawMammalianMean_prey = vec([RawPrey_preys_mean'; delong_preymass]);
mammalian_fit_table=lineartablebuild(RawMammalianMean_preds,RawMammalianMean_prey);

CSV.write("$(homedir())/Dropbox/PostDoc/2024_PCR/data/mammalian_fit_table.csv",mammalian_fit_table; header=true);

Rawmammalian_sizetable = DataFrame([RawMammalianMean_preds RawMammalianMean_prey],:auto);
rename!(Rawmammalian_sizetable,[:predmass,:preymass]);
CSV.write("$(homedir())/Dropbox/PostDoc/2024_PCR/data/mammalian_mass.csv",Rawmammalian_sizetable; header=false);
