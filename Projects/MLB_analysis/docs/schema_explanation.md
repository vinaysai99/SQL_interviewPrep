# Database Schema Documentation

## Players Table
### Purpose
Tracks comprehensive player biographical information from birth through career.

### Key Columns
- `playerID`: Unique identifier for each player
- `nameFirst`, `nameLast`: Player's name
- `birthYear`, `birthMonth`, `birthDay`: Birth details
- `debut`, `finalGame`: Career span
- `weight`, `height`: Physical attributes
- `bats`, `throws`: Playing characteristics

## Salaries Table
### Purpose
Track player compensation across different teams and years.

### Key Columns
- `yearID`: Year of salary
- `teamID`: Team identifier
- `playerID`: Player identifier
- `salary`: Annual compensation

## School Details Table
### Purpose
Provide comprehensive information about educational institutions.

### Key Columns
- `schoolID`: Unique school identifier
- `name_full`: Complete school name
- `city`, `state`, `country`: School location

## Schools Table
### Purpose
Map players to their educational institutions.

### Key Columns
- `playerID`: Player identifier
- `schoolID`: School identifier
- `yearID`: Year of association
