import React from 'react';
import ReactDOM from 'react-dom';

import {
  pathsLength,
  pathLength,
  closestPointInPath,
  closestPath,
  nextPath,
  remainingDistance
} from './utils';

export const GoogleMap = React.createClass({
  componentDidUpdate: function (prevProps, prevState) {
    if (prevProps.google !== this.props.google) {
      this.loadMap();
    }
  },

  componentDidMount: function() {
    this.loadMap();
  },

  loadMap: function() {
    if (this.props && this.props.google) {
      const maps = this.props.google.maps;
      const mapRef = this.refs.map;
      const node = ReactDOM.findDOMNode(mapRef);

      const currentLatLng = {
        lat: this.props.lat,
        lng: this.props.lng,
      }
      const mapConfig = {
        center: currentLatLng,
        zoom: this.props.zoom,

        // Turned this off for now, adds a blue hue to the map
        // https://snazzymaps.com/style/124/50-shades-of-blue
        // styles: [{"featureType":"landscape.natural","stylers":[{"color":"#bcddff"}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#5fb3ff"}]},{"featureType":"road.arterial","stylers":[{"color":"#ebf4ff"}]},{"featureType":"road.local","elementType":"geometry.fill","stylers":[{"color":"#ebf4ff"}]},{"featureType":"road.local","elementType":"geometry.stroke","stylers":[{"visibility":"on"},{"color":"#93c8ff"}]},{"featureType":"landscape.man_made","elementType":"geometry","stylers":[{"color":"#c7e2ff"}]},{"featureType":"transit.station.airport","elementType":"geometry","stylers":[{"saturation":100},{"gamma":0.82},{"hue":"#0088ff"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#1673cb"}]},{"featureType":"road.highway","elementType":"labels.icon","stylers":[{"saturation":58},{"hue":"#006eff"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#4797e0"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#209ee1"},{"lightness":49}]},{"featureType":"transit.line","elementType":"geometry.fill","stylers":[{"color":"#83befc"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#3ea3ff"}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"saturation":86},{"hue":"#0077ff"},{"weight":0.8}]},{"elementType":"labels.icon","stylers":[{"hue":"#0066ff"},{"weight":1.9}]},{"featureType":"poi","elementType":"geometry.fill","stylers":[{"hue":"#0077ff"},{"saturation":-7},{"lightness":24}]}],
      };

      const map = new maps.Map(node, mapConfig);

      // Add actual route to map
      for (var i = 0; i < this.props.paths.length; i++) {
        const pathSoFar = new google.maps.Polyline({
          path: this.props.paths[i],
          geodesic: true,
          strokeColor: '#FF0000',
          strokeOpacity: 0.45,
          strokeWeight: 3,
          clickable: false
        });

        pathSoFar.setMap(map);
      }

      // Add a marker for current position
      var latestCheckInMarker = new maps.Marker({
        map: map,
        position: currentLatLng,
      });

      // Add photo markers
      var photoIcon = {
        url: 'images/camera-icon-12.png',
        size: new google.maps.Size(12, 12),
        anchor: new google.maps.Point(6, 6)
      };

      const photos = this.props.photos;
      for (var i = 0; i < photos.length; i++) {
        var photoMarker = new google.maps.Marker({
          map: map,
          position: {
            lat: photos[i].lat,
            lng: photos[i].lng
          },
          icon: photoIcon
        });

        // <3 Javascript
        const photoHandler = ((photoData) => {
          return () => {
            this.props.photoHandler(photoData);
          }
        })(photos[i]);

        photoMarker.addListener('click', photoHandler)
      }
    }
  },

  render: function() {
    return (
      <div className="map" ref="map">Loading map...</div>
    )
  }
});
