library(ape)
my_info <- read.table("adder_info.txt", header=TRUE)

pdf("my_adder_plot.pdf", width=8, height=4.5)
layout(matrix(c(1,2,3,1,2,3,4,4,4), nrow=3, ncol=3, byrow=TRUE))

# pca
par(mar=c(5,5,4,1))

my_cov <- read.table("bamlist_ingroup.covMat")
my_pca <- eigen(my_cov)
pc1_var <- (my_pca$values[1]/sum(my_pca$values)) * 100
pc2_var <- (my_pca$values[2]/sum(my_pca$values)) * 100

plot(my_pca$vectors[,1], my_pca$vectors[,2],
	pch=21, bg=my_info$col,
	xlab=paste("PC1:", signif(pc1_var,3), "% variation"),
    ylab=paste("PC2:", signif(pc2_var,3), "% variation"),
    main="PCA of 1,222,329 variable sites", cex.main=0.95

)

leglab=c("Leeds", 
"Wensleydale", 
"Manchester", 
"Caerphilly", 
"Gouda", 
"Stockholm", 
"Cheddar", 
"Huddersfield", 
"Sheffield", 
"Leicester", 
"Nottingham", 
"Stilton", 
"bosniensis")

legend("topright", inset=0.03, legend=leglab, pch=21, cex=0.5,
pt.bg=c("red", "blue", "green", "orange", "purple", "brown", "pink", "cyan", "yellow", "magenta", "darkgreen", "gold", "black")
)

mtext(substitute(paste(bold("A."))), side=3, line=1.2, cex=1, adj=-0.275, cex.lab=1.5)

# nj
par(mar=c(1,1,4,5), xpd=TRUE)

my_mat <- as.dist(read.table("bamlist_outgroup.ibsMat"))
my_tree <- nj(my_mat)
my_root <- root(my_tree, outgroup=48)
plot(my_root, show.tip.label=FALSE, edge.width=1.5, 
	main="NJ distance tree", cex.main=0.95
)

tiplabels(pch=21, cex=0.75, bg=my_info$col)
tiplabels(my_info$loc, frame="none", cex=0.5, adj=-0.3)

mtext(substitute(paste(bold("B."))), side=3, line=1.2, cex=1, adj=0, cex.lab=1.5)

# histo
par(mar=c(5,1,4,5))

my_sfs <- read.table("adder01_het.window.sfs")
hist((my_sfs$V2/100), col="red", breaks=40,
	xlab="heterozygous sites per kb", axes=FALSE,
	main="adder01 heterozygosity distribution", cex.main=0.95
)
axis(1)
mtext(substitute(paste(bold("C."))), side=3, line=1.2, cex=1, adj=-0.2, cex.lab=1.5)

# chr plot
par(mar=c(3,5,2,5))

plot(1:length(my_sfs$V2), my_sfs$V2/100, type="l", col="red",
	xlab="", ylab="Het sites per kb",
	main="adder01 heterozygosity chromosome 7 (100 kb windows)", cex.main=0.95
)

mtext(substitute(paste(bold("D."))), side=3, line=1.2, cex=1, adj=-0.08, cex.lab=1.5)

dev.off()
