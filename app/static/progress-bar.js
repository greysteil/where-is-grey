import React from 'react';


const PelotonCyclist = React.createClass({
  render: function() {
    const {color, offset} = this.props;
    return <div className="progress-bar-peloton-emoji" style={{right: 17 + offset}}>
      { Math.random() > 0.5 ? "🚴" : "🚴‍♀️" }
    </div>;
    // return <div className="progress-bar-peloton" style={{backgroundColor: color, right: 17 + offset}}></div>;
  }
});

// Fun stats relative to other random distances/durations
export const ProgressBar = React.createClass({
  getInitialState: function () {
    return {
      percentage: this.props.distanceTravelled / this.props.distanceTotal,
    }
  },

  render: function() {
    let peloton = [];

    const numRiders = Math.round(Math.random() * 7) + 5
    for(let i = 0; i < numRiders; i++) {
      const offset = Math.round(Math.random()*200)
      const colors = [
        'red', 'green', 'marine', 'yellow', 'pink', 'purple',
      ];
      const color = colors[Math.round(Math.random()*colors.length)];
      peloton.push(<PelotonCyclist key={i} color={color} offset={offset} />)
    }

    return (
      <div className="progress-bar-container">
        <div className="progress-bar">
          <div className="progress-bar-inner" style={{ width: `${100 * this.state.percentage}%` }}>
            <div className="progress-bar-inner-inner">
              <img className="progress-bar-grey" src="/grey.png" />
              {peloton}
            </div>
          </div>
        </div>
      </div>
    );
  }
});

