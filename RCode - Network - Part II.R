###################    Part II: Computing Network metrics   ################################################

#install.packages("igraph") # install the package, if not already installed
library("igraph")
## A number of useful functions in this package can be accessed at http://igraph.org/r/doc/.

###### Example: Airlines Network using Edge List ##################
## Data source: http://openflights.org/data.html
dir()

airports <- read.csv("C:/Datasets_BA/Network Analytics/airports.dat", header=FALSE) ## source: http://openflights.org/data.html
colnames(airports) <- c("Airport ID","Name","City","Country","IATA_FAA","ICAO","Latitude","Longitude","Altitude","Timezone","DST","Tz database timezone")
head(airports)

airline_routes <- read.csv("C:/Datasets_BA/Network Analytics/routes.dat", header=FALSE) ## source: http://openflights.org/data.html
##colnames(airline_routes) <- c("Airline", "Airline ID", "Source Airport","Source Airport ID","Destination Airport","Destination Airport ID","Codeshare","Stops","Equipment")
colnames(airline_routes) <- c("Airline", "Airline ID", "Source Airport","Source Airport ID","Destination Airport","Destination Airport ID","Stops","Equipment")
head(airline_routes)

AirlineNW <- graph.edgelist(as.matrix(airline_routes[,c(3,5)]), directed=TRUE)
plot(AirlineNW)

## How many airports are there in the network?
?vcount
vcount(AirlineNW)

## How many connections are there in the network?
?ecount
ecount(AirlineNW)

# Which airport has most flights coming in, and how many?
?degree
indegree <- degree(AirlineNW,mode="in")
max(indegree)
index <- which(indegree == max(indegree))
indegree[index]
which(airports$IATA_FAA=="ATL")
airports[3584,]

# Which airport has most flights going out of, and how many?
outdegree <- degree(AirlineNW,mode="out")
max(outdegree)
index <- which(outdegree == max(outdegree))
outdegree[index]
which(airports$IATA_FAA=="ATL")
airports[3584,]

# Which airport is close to most of the airports (in terms of number of flights)
?closeness
closeness_in <- closeness(AirlineNW, mode="in",normalized = TRUE)
max(closeness_in)
index <- which(closeness_in == max(closeness_in))
closeness_in[index]
which(airports$IATA_FAA=="FRA")
airports[338,]

# Which airport comes in between most of the routes and hence is an important international hub?
?betweenness
?edge.betweenness
btwn <- betweenness(AirlineNW,normalized = TRUE)
max(btwn)
index <- which(btwn == max(btwn))
btwn[index]
which(airports$IATA_FAA=="LAX")
airports[3386,]

# Degree, closeness, and betweenness centralities together
centralities <- cbind(indegree, outdegree, closeness_in, btwn)
colnames(centralities) <- c("inDegree","outDegree","closenessIn","betweenness")
head(centralities)

# correlations of the centralities
cor(centralities)

# Any pair with low correlation?

plot(centralities[,"closenessIn"],centralities[,"betweenness"])
?subset
subset(centralities, (centralities[,"closenessIn"] > 0.015) & (centralities[,"betweenness"] > 0.06))
airports[which(airports$IATA_FAA=="LAX"),]
airports[which(airports$IATA_FAA=="CDG"),]
airports[which(airports$IATA_FAA=="ANC"),]
subset(centralities, (centralities[,"closenessIn"] < 0.005) & (centralities[,"betweenness"] < 0.02))


# Which is one of the most important airport in the world (the Google way)?
?eigen_centrality
eigenv <- eigen_centrality(AirlineNW, directed = TRUE, scale = FALSE, weights = NULL)
eigenv$vector
max(eigenv$vector)
index <- which(eigenv$vector == max(eigenv$vector))
eigenv$vector[index]
which(airports$IATA_FAA=="ATL")
airports[3584,]

?page_rank
pg_rank <- page_rank(AirlineNW, damping = 0.999) # do not put damping=1; the solution not necessarily converges; put a value close to 1.
pg_rank$vector
max(pg_rank$vector)
index <- which(pg_rank$vector == max(pg_rank$vector))
pg_rank$vector[index]
which(airports$IATA_FAA=="ATL")
airports[3584,]

