# Where is Grey?

A simple app to plot my progress around the world.

## How it works

- Route taken (so far) is built up from check-ins from my SPOT GPS tracker.
  Every 10 minutes a job is run to ask SPOT for all recent check-ins, and
  stores them (since SPOT stop making them available after 7 days)
- If there's a discontinuity (e.g., I take a ferry across a sea) I manually
  mark it as such on the check-in. Otherwise all check-ins are assumed to link
  up
- Proposed route map is stored as a KML document, which is then parsed and
  plotted on a Google map

## Technical setup

- Postgres database
- Sinatra backend
- Webpack/ES6 frontend

To run locally:

```bash
bundle install
npm install
bundle exec rake db:seed
bundle exec shotgun (watches and rebuilds backend)
npm start (watches and rebuilds front end)
```

## Potential improvements

- Explanation page (what is this website)
- Stats page (per day elevation, hours ridden, miles travelled)
- Better info windows on route so far (better information)
