// KmlLoader.load returns a promise which resolves to and array containing all
// the trip sections
export const KmlLoader = {
  load: (path) => {
    return new Promise((resolve, reject) => {
      // Add planned route to map
      var kmlParser = new geoXML3.parser({
        afterParse: function (docSet) {
          let plannedPaths = [];

          for (var i = 0; i < docSet[0].gpolylines.length; i++) {
            const poly = docSet[0].gpolylines[i];
            const path = poly.getPath();

            var el = document.createElement( 'html' );
            el.innerHTML = poly.infoWindowOptions.content;
            const sectionName = el
              .getElementsByTagName('h3')[0]
              .innerHTML
              .replace('-&gt;', '&rarr;');

            // TODO: is there a neater way than `.b`?
            plannedPaths.push({ name: sectionName, path: path.b });
          }

          resolve(plannedPaths);
        }
      });

      kmlParser.parse(path)
    });
  }
};
