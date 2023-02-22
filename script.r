
#Required libraries
library(datasets)
library(factoextra)
library(FactoMineR)
df <- scale(rock)
res.dist <- dist(df, method = "euclidean")


#To display a portion of the calculated euclidean distances.
as.matrix(res.dist)[1:7, 1:7] 


res.hc <- hclust(res.dist)
#To display the Cluster Dendrogram.
fviz_dend(res.hc, cex = 0.5)


#To display the Cluster Plot.
grp <- cutree(res.hc, k = 3)
fviz_cluster(list(data = df, cluster = grp),palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),ellipse.type = "convex", repel = TRUE, show.clust.cent = FALSE, ggtheme = theme_minimal())


#HCPC 
res.pca <- PCA(rock, scale.unit = TRUE,ncp = 5, graph = TRUE)
res.hcpc <- HCPC(res.pca, graph = TRUE)


#To display the Cluster Dendrogram and Plot obtained after the PCA
fviz_dend(res.hcpc,cex = 0.7,palette = "jco",rect = TRUE, rect_fill = TRUE,rect_border = "jco",labels_track_height = 0.8)
fviz_cluster(res.hcpc, repel = TRUE,show.clust.cent = TRUE,palette = "jco",ggtheme = theme_minimal(),main = "Factor map")


