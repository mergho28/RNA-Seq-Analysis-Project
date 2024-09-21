# Load Necessary Libraries
library(shiny)
library(Seurat)
library(ggplot2)
library(readxl)

# Define the User Interface
ui <- fluidPage(
  titlePanel("Single-Cell RNA-seq Analysis Pipeline"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Upload Excel File", accept = c(".xlsx")),
      actionButton("analyze", "Analyze Data")
    ),
    mainPanel(
      verbatimTextOutput("dataInfo"),       # Display dataset info
      plotOutput("umapPlot"),               # UMAP Plot
      plotOutput("violinPlot")              # Violin Plot
    )
  )
)

# Define Server Logic
server <- function(input, output) {
  
  # Reactive expression to read and process the uploaded file
  processed_data <- eventReactive(input$analyze, {
    req(input$file1)  # Ensure a file is uploaded
    
    # Step 1: Load the Excel file
    file_path <- input$file1$datapath
    data <- tryCatch({
      read_excel(file_path)
    }, error = function(e) {
      stop("Error reading Excel file. Ensure it is a valid .xlsx file.")
    })
    
    # Step 2: Convert to matrix, assuming first column contains gene names
    gene_names <- data[[1]]  # First column as gene names
    data_matrix <- as.matrix(data[, -1])  # Convert the rest to a numeric matrix
    rownames(data_matrix) <- gene_names
    
    # Step 3: Create Seurat Object
    seurat_obj <- CreateSeuratObject(counts = data_matrix)
    
    # Step 4: Normalize the data
    seurat_obj <- NormalizeData(seurat_obj)
    
    # Step 5: Identify highly variable features
    seurat_obj <- FindVariableFeatures(seurat_obj, selection.method = "vst", nfeatures = 2000)
    
    # Step 6: Scale the data
    seurat_obj <- ScaleData(seurat_obj)
    
    # Return the Seurat object
    return(seurat_obj)
  })
  
  # Output Dataset Info (basic info about data dimensions)
  output$dataInfo <- renderPrint({
    req(processed_data())
    seurat_obj <- processed_data()
    num_features <- dim(seurat_obj)[1]
    num_cells <- dim(seurat_obj)[2]
    cat("Number of genes:", num_features, "\n")
    cat("Number of cells:", num_cells, "\n")
  })
  
  # Output UMAP Plot
  output$umapPlot <- renderPlot({
    req(processed_data())
    seurat_obj <- processed_data()
    
    # Run PCA and UMAP
    seurat_obj <- RunPCA(seurat_obj, features = VariableFeatures(object = seurat_obj), npcs = 30)
    seurat_obj <- RunUMAP(seurat_obj, dims = 1:30)
    
    # Plot UMAP
    DimPlot(seurat_obj, reduction = "umap", label = TRUE, label.size = 3) +
      labs(x = "UMAP Dimension 1", y = "UMAP Dimension 2", title = "UMAP Plot")
  })
  
  # Output Violin Plot
  output$violinPlot <- renderPlot({
    req(processed_data())
    seurat_obj <- processed_data()
    
    # Violin plot of RNA features
    VlnPlot(seurat_obj, features = "nFeature_RNA") +
      labs(x = "Cluster", y = "Number of RNA Features", title = "Violin Plot for RNA Features")
  })
}

# Run the Shiny App
shinyApp(ui = ui, server = server)
