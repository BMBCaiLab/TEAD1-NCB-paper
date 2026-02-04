These are the custom-written code used for SPT analysis of TEAD1 residence times inside and outside of condensates.
See methods for detailed description of the protocol and parameters used.

We followed the following protocol available in [Yoshida & Chong (2024)](https://app.jove.com/t/66169/single-molecule-measurement-protein-interaction-dynamics-within) 
and the accompanying code found here: [https://github.com/Shasha-Chong/CodeFor2018SciencePaper](https://github.com/Shasha-Chong/CodeFor2018SciencePaper)

SLIMfast, a GUI implementation of the MTT algorithm, was used to localize and track single particles. 
It is available in [Teves et al. (2016)](https://elifesciences.org/articles/22280).

These files were used to supplement the linked protocol. Below are explanations of each file included.
# segmentation_TWS
- Semi-automated ImageJ macro that segments an image stack using a 'mask' image as a reference
- This macro was used to segment raw image stacks of single-molecule images according to a nuclear mask, which was a single snapshot.

# filter_spt_trajectories
- Python script that takes a spreadsheet of trajectories generated from SLIMfast tracking and filters them by a specified number of frames

# random_rotate_cluster_mask
- Semi-automated ImageJ macro that takes the binary mask and randomly rotates and places it within a specified bound (i.e. the nucleus)
- Input: binary condensate mask generated during the above protocol
