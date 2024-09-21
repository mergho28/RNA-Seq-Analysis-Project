# RNA-Seq-Analysis-Project
 This Shiny application provides an interactive pipeline for analyzing single-cell RNA sequencing (scRNA-seq) data, leveraging the Seurat package. Users can upload scRNA-seq data in Excel format, which the app processes by creating a Seurat object, normalizing the data, identifying highly variable features, and scaling the data. The app generates two key visualizations: a UMAP plot to visualize cell clusters in two-dimensional space, and a violin plot to display the distribution of RNA features across clusters. This tool allows for quick exploratory analysis of scRNA-seq data, making it accessible for users to assess gene expression patterns and cell heterogeneity.

## Files
- `pipeline.R`: The main R script for running the RNA-seq analysis.
- `data/`: Folder containing input data files.

## How to Run
1. Clone or download this repository.
2. Open `pipeline.R` in RStudio and run it.
