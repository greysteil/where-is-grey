import React from 'react';

export const DistanceDone = React.createClass({
  render: function() {
    var hoursOnTheRoad = this.props.hoursOnTheRoad;
    var distance = this.props.distance;

    return (
      <div className="stat">
        <div className="stat-heading">DISTANCE TRAVELLED</div>
        <div className="stat-body">
          <span className="stat-value">{Math.round(distance).toLocaleString()}</span>
          <span className="stat-unit">km</span>
        </div>
        <div className="stat-footer">{hoursOnTheRoad} hours on the road</div>
      </div>
    );
  }
});

