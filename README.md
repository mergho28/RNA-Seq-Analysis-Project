# RNA-Seq-Analysis-Project
 This Shiny application provides an interactive pipeline for analyzing single-cell RNA sequencing (scRNA-seq) data, leveraging the Seurat package. Users can upload scRNA-seq data in Excel format, which the app processes by creating a Seurat object, normalizing the data, identifying highly variable features, and scaling the data. The app generates two key visualizations: a UMAP plot to visualize cell clusters in two-dimensional space, and a violin plot to display the distribution of RNA features across clusters. This tool allows for quick exploratory analysis of scRNA-seq data, making it accessible for users to assess gene expression patterns and cell heterogeneity.

## Files
- `pipeline.R`: The main R script for running the RNA-seq analysis.
- `data/`: Folder containing input data files.

## How to Run
1. Go to RNA seq analysis Pipeline located in this repository
2. Copy the code from the Respository.
3. Paste into RStudio and run it. 

Note: Dataset size ranges from 2,000-5,000 cells, and 10,000-20,000 genes are the most optimal for this program
