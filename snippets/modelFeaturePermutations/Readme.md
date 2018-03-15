# modelFeaturePermutations.R

This code chunk performs one simple task. Given a vector of model features (as characters), it creates a list (called formulas) of every possible model permutation that can be made out of those features to predict/classify a given target.

Where can this be useful? You can cross-validate across different model permutations to figure out for a given model, which combination of features gives the best results.

## Downsides

Very computationally intense to try every possible model permutation.

Currently, this script does not set thresholds. It creates every possible model. It may be useful to specify only models with between x1 and x2 features.

When cross-validating, it may be wise to randomly sample some of the model permutations. The amount of model permutations will exponentially increase so this may not work well for large feature sets.

Perhaps adding in a probabilistic function in to this script to reduce the amount of model permutations would be smart. This would require a lot of EDA ahead of time.

## Disclaimer

This script is just for fun. It is an extremely lazy way to figure out the best model features to include.

It is at the extreme end of automation, completely bipassing the need for any manual exploration of the data.

I would not reccomend using this vanilla on large data or feature sets. But the concept I think can be interesting and made much smarter.
