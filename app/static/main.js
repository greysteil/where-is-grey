// Webpack kindly handles our CSS too
import './styles.css';

import React from 'react';
import ReactDOM from 'react-dom';

import {App} from './app';
import _ from 'lodash';
import {KmlLoader} from './kml';

// appData is assigned to window as part of index.html.erb
const appData = window.appData;

KmlLoader.load('/route.kml')
  .then((plannedPaths) => _.extend(appData, { plannedPaths }))
  .then((data) => ReactDOM.render(<App data={data} />, document.getElementById('app')));
