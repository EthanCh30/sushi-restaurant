CREATE TABLE Country
(
    countryID      INTEGER,
    name           VARCHAR(50),
    population     INTEGER,
    PRIMARY KEY (countryID)
);

CREATE TABLE Publisher
(
    pubID      INTEGER,
    name       VARCHAR(50),
    revenue    INTEGER,
    countryID  INTEGER,
    PRIMARY KEY (pubID),
    FOREIGN KEY (countryID) references Country(countryID)
);

CREATE TABLE AgeRating
(
    arID           INTEGER,
    label          VARCHAR(50),
    minAge         INTEGER,
    PRIMARY KEY (arID)
);

CREATE TABLE Genre
(
    genreID           INTEGER,
    label             VARCHAR(50),
    PRIMARY KEY (genreID)
);

CREATE TABLE Console
(
    consoleID           INTEGER,
    consoleName             VARCHAR(50),
    PRIMARY KEY (consoleID)
);

CREATE TABLE Team
(
    teamID           INTEGER,
    teamName             VARCHAR(50),
    PRIMARY KEY (teamID)
);


CREATE TABLE Gamer
(
    gamerID         INTEGER,
    firstName       VARCHAR(50),
    lastName        VARCHAR(50),
    birthYear       INTEGER,
    gender          CHAR(1),
    countryID       INTEGER,
    teamID          INTEGER,
    teamPoints      INTEGER,
    PRIMARY KEY (gamerID),
    FOREIGN KEY (teamID) references Team(teamID),
    FOREIGN KEY (countryID) references Country(countryID)
);

CREATE TABLE Game
(
    gameID      INTEGER,
    title       VARCHAR(50),
    pubID       INTEGER,
    arID        INTEGER,
    genreID     INTEGER,
    PRIMARY KEY (gameID),
    FOREIGN KEY (pubID) references Publisher(pubID),
    FOREIGN KEY (arID) references AgeRating(arID),
    FOREIGN KEY (genreID) references Genre(genreID)
);


CREATE TABLE Purchase
(
    purchaseID      INTEGER,
    purchaseDate    DATE,
    cost            DECIMAL(5,2),
    gameID          INTEGER,
    consoleID       INTEGER,
    gamerID         INTEGER,
    PRIMARY KEY (purchaseID),
    FOREIGN KEY (gameID) references Game(gameID),
    FOREIGN KEY (consoleID) references Console(consoleID),
    FOREIGN KEY (gamerID) references Gamer(gamerID)
);


-- *:* relationships
CREATE TABLE GameRating
(
    gameID           INTEGER,
    gamerID          INTEGER,
    ratingDate       DATE,
    rating           NUMBER,
    PRIMARY KEY (gameID, gamerID, ratingDate),
    FOREIGN KEY (gamerID) references Gamer(gamerID),
    FOREIGN KEY (gameID) references Game(gameID)
);

CREATE TABLE GameRelease
(
    gameID           INTEGER,
    consoleID        INTEGER,
    releaseDate       DATE,
    releaseCost       NUMBER,
    PRIMARY KEY (gameID, consoleID),
    FOREIGN KEY (consoleID) references Console(consoleID),
    FOREIGN KEY (gameID) references Game(gameID)
);


.save game.db
.exit





