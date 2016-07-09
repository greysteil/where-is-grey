# Where is Grey?

A simple app to plot my progress around the world


## Features

**Must have:**

- Current location, and all previous check-ins, on a map
  - Google Maps API presumably the best way to go here?
  - Pull check-in details from SPOT
    - Poll http://faq.findmespot.com/index.php?action=showEntry&data=69
    - Need to store the data
      - SPOT delete it after 30 days
      - SPOT rate-limit API to one request every 2.5 minutes

**Nice to have:**

- Metadata on each check-in
  - Date & time
  - Links to photos / blog posts (would need a way to add, too)
- Originally intended route


## Setup

- Postgres database
- Sinatra backend
