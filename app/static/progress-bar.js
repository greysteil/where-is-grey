import React from 'react';

// Fun stats relative to other random distances/durations
export const ProgressBar = React.createClass({
  getInitialState: function () {
    return {
      percentage: this.props.distanceTravelled / this.props.distanceTotal,
    }
  },

  render: function() {
    return (
      <div className="progress-bar">
        <div className="progress-bar-inner" style={{ width: `${100 * this.state.percentage}%` }}>
          <div className="progress-bar-inner-inner">
            <img className="progress-bar-cyclist" src="/cyclist.svg" />
          </div>
        </div>
      </div>
    );
  }
});

