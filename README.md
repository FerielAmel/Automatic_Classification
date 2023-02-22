# Automatic_Classification

## Data informations
### Description
Measurements on 48 rock samples from a petroleum reservoir.
### Format
A data frame with 48 rows and 4 numeric columns.
1.  ***area***	area of pores space, in pixels out of 256 by 256.
2.  ***peri***	perimeter in pixels.
3.  ***shape***	perimeter/sqrt(area).
4.  ***perm***	permeability in milli-Darcies.
### Source
Data from BP Research, image analysis by Ronit Katz, U. Oxford.
## Process
### Required libraries
```R
> library(datasets)
> library(factoextra)
> library(FactoMineR)
```
### Results
We start by calculating the euclidean distance between each two data elements, then proceed to do an Hierarchical Clustering. The hclust function in R uses the complete linkage agglomeration method for hierarchical clustering by default. We also display the Cluster Dendrogram.
```R
> df <- scale(rock)
> res.dist <- dist(df, method = "euclidean")
> as.matrix(res.dist)[1:7, 1:7]
         1         2         3         4         5         6         7
1 0.000000 1.2808210 1.6698316 1.2014188 1.4183173 1.6760645 2.2830094
2 1.280821 0.0000000 0.4650127 0.4001638 0.4728275 0.4342250 1.0471849
3 1.669832 0.4650127 0.0000000 0.7982895 0.7438005 0.2573977 0.7265239
4 1.201419 0.4001638 0.7982895 0.0000000 0.2372189 0.6505380 1.1882544
5 1.418317 0.4728275 0.7438005 0.2372189 0.0000000 0.5363872 0.9967993
6 1.676065 0.4342250 0.2573977 0.6505380 0.5363872 0.0000000 0.6186843
7 2.283009 1.0471849 0.7265239 1.1882544 0.9967993 0.6186843 0.0000000
> res.hc <- hclust(res.dist)
> fviz_dend(res.hc, cex = 0.5)
```
![image](https://user-images.githubusercontent.com/107730108/220685549-efdc0b7b-2c2f-47ea-8d40-2c477109f93b.png)

Then we display the Cluster Plot.
```R
> grp <- cutree(res.hc, k = 3)
> fviz_cluster(list(data = df, cluster = grp),palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),ellipse.type = "convex", repel = TRUE, show.clust.cent = FALSE, ggtheme = theme_minimal())
```
![image](https://user-images.githubusercontent.com/107730108/220688096-06e1d620-0085-41b6-9aa8-8be389b77632.png)

After that we apply a PCA to our dataset before classifying them, this approach is also known as ***HCPC***.   
The HCPC (***Hierarchical Clustering on Principal Components***) approach allows us to combine the three standard methods used in multivariate data analyses (Husson, Josse, and J. 2010):
1.  Principal component methods (PCA, CA, MCA, FAMD, MFA).
2.  Hierarchical clustering.
3.  Partitioning clustering, particularly the k-means method.  

It allows us to obtain a more stable clustering as we reduce the dimension of the data into some variables containing most of the information about the data.
The following code displays the PCA graph of variables and the three graphs shown below.

![image](https://user-images.githubusercontent.com/107730108/220688957-cf95dc5a-afbe-45b7-bd0a-7fe155dad7c0.png)
![image](https://user-images.githubusercontent.com/107730108/220689316-2e9c15dc-c701-4908-a975-90085aca8016.png)
![image](https://user-images.githubusercontent.com/107730108/220689522-9e2b8b84-507e-4752-a749-014e3dba1e70.png)
![image](https://user-images.githubusercontent.com/107730108/220689735-b9e9f76f-c195-48b1-b2f6-bff57c499d22.png)

The final Cluster Dendrogram and Plot obtained after the PCA are displayed using these two lines of code.
```R
> fviz_dend(res.hcpc,cex = 0.7,palette = "jco",rect = TRUE, rect_fill = TRUE,rect_border = "jco",labels_track_height = 0.8)
> fviz_cluster(res.hcpc, repel = TRUE,show.clust.cent = TRUE,palette = "jco",ggtheme = theme_minimal(),main = "Factor map")
```
![image](https://user-images.githubusercontent.com/107730108/220689776-7c9be9bd-e672-46aa-9d39-e322d0eeec02.png)
![image](https://user-images.githubusercontent.com/107730108/220689859-62398497-b808-49ef-9dc1-672b74783c72.png)
