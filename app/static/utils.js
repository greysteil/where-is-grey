// Given an array of paths, return the total length in km
export const pathsLength = (paths) => {
  let currLength = 0;

  for (var i = 0; i < paths.length; i++) {
    currLength += pathLength(paths[i])
  }

  return currLength;
};

// Given a single path (array of google LatLng objects), return the length in km
const pathLength = (path) => {
  var meters = google.maps.geometry.spherical.computeLength(path);
  return meters / 1000.0; //KM
};

// Given a path (array of google latlngs) return the latlgn which is closest to
// the provided lat and lng.
//
// Returns the location, along with the distance
const closestPointInPath = (path, lat, lng) => {
  const location = new google.maps.LatLng({ lat, lng });

  const closest = path.reduce((prev, curr) => {
    var cdist = google.maps.geometry.spherical.computeDistanceBetween(location, curr);
    var pdist = google.maps.geometry.spherical.computeDistanceBetween(location, prev);

    return cdist < pdist ? curr : prev;
  });

  // Now we have the closest one, get the distance to return
  const smallestDist = google.maps.geometry.spherical.computeDistanceBetween(location, closest);

  return { location: closest, dist: smallestDist };
};

// Given a list of journey sections, lat & lng, return the section which is
// closest to the current position. Useful for estimating which section of the
// journey Grey is currently on
export const closestJourneySection = (journeySections, lat, lng) => {
  return journeySections.reduce((prev, curr) => {
    var cdist = closestPointInPath(curr.path, lat, lng).dist;
    var pdist = closestPointInPath(prev.path, lat, lng).dist;

    return cdist < pdist ? curr : prev;
  });
}

// Given a journey section and a list of all journey sections, return the
// journey section after the provided one
//
// e.g. (b, [a,b,c,d]) => c
// Can probably use indexing here to be more efficient!
export const nextJourneySection = (currentJourneySection, journeySections) => {
  return journeySections.reduce((prev, curr) => {
    return prev == currentJourneySection ? curr : prev;
  });
}

// Given a list of journey sections, estimate how far grey has left to go
export const calculateRemainingDistance = (journeySections, lat, lng) => {
  // First, figure out where he is now
  const currentSection = closestJourneySection(journeySections, lat, lng);

  // Then, work out where along the current section he is, getting the closest point
  const nearestPoint = closestPointInPath(currentSection.path, lat, lng).location;

  // Then, figure out the remaining distance for this section
  let pointsRemainingInCurrentSection = [];
  let pastNearestPoint = false;
  for(let i = 0; i < currentSection.path.length; i++) {
    const currentPoint = currentSection.path[i];
    if (pastNearestPoint) {
      pointsRemainingInCurrentSection.push(currentPoint)
    }

    // TODO: Given these are both google latlongs, can we just compare == ?
    const reachedNearestPoint = currentPoint.lat() == nearestPoint.lat() && currentPoint.lng() == nearestPoint.lng();
    pastNearestPoint = pastNearestPoint || reachedNearestPoint;
  }

  let distance = pathLength(pointsRemainingInCurrentSection);
  let pastCurrentSection = false;
  for(let i = 0; i < journeySections.length; i++) {
    if (pastCurrentSection) {
      distance += pathLength(journeySections[i].path);
    }
    pastCurrentSection = pastCurrentSection || (journeySections[i] == currentSection);
  }

  return distance;
};

// Returns a promise which resolves to a country name
export const countryFromLatLong = (lat, lng) => {
  var geocodeUrl = 'http://maps.googleapis.com/maps/api/geocode/json?' +
                   'latlng=' + lat + ',' + lng +
                   '&sensor=false';

  // The google geocode API lists results in decreasing specificity order. The
  // last result will be the most general location (i.e., country).
  const extractCountryFromGeocodeResponse = (responseJson) => {
    var results = responseJson.results;
    var lastResult = results[results.length - 1];
    return lastResult.formatted_address;
  };

  return fetch(geocodeUrl)
    .then((response) => response.json())
    .then(extractCountryFromGeocodeResponse)
    .catch((err) => console.error(err));
};

