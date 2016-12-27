# elm-hot-table

Embedding the `hot-table` web component in an Elm application.

See http://handsontable.github.io/hot-table for more information.


## Notes

Added Polymer shadow dom settings in the `index.html` template.  With the
current default, `dom: 'shady'`, the hot-table component would freeze up
when clicked.

For more information, see https://groups.google.com/forum/#!msg/elm-discuss/8Q2xwRh6UYc/tGem48QjAQAJ and
and https://www.polymer-project.org/1.0/docs/devguide/settings


```
window.Polymer = {
    dom: 'shadow',
    lazyRegister: true
};
```


## Building

Install node.js, bower and Elm. Then:

```
bower install
elm-package install
elm-make src/Main.elm --output=dist/main.js
```

Note: This project was "ejected" from a `create-elm-app` starter project.

Note: Had problem getting ports (Javascript interop) to work. Solution was
to `elm-package install elm-lang/http`.


## Deploying

```
rm -rf dist
mkdir dist
elm-make src/Main.elm --output=dist/main.js
cp src/favicon.ico dist
cp src/index.html dist
cp -r bower_components dist
mv dist <your_webserver_document_root_here>
```


## Handsontable options (not tested yet!)

`datarows` (Handsontable `data`)

Default Value: undefined

Initial data source that will be bound to the data grid by reference (editing data grid alters the data source). Can be declared as an Array of Arrays, Array of Objects or a Function.

`max-rows` (Handsontable `maxRows`)

Default Value: Infinity

Maximum number of rows. If set to a value lower than the initial row count, the data will be trimmed to the provided value as the number of rows.

Handsontable `colHeaders`

Default Value: null

Setting true or false will enable or disable the default column headers (A, B, C).
You can also define an array `['One', 'Two', 'Three', ...]` or a function to define the headers.
If a function is set, then the index of the column is passed as a parameter.

Handsontable `rowHeaders`

Default Value: null

Setting true or false will enable or disable the default row headers (1, 2, 3).
You can also define an array `['One', 'Two', 'Three', ...]` or a function to define the headers.
If a function is set the index of the row is passed as a parameter.
