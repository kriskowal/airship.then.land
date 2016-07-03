'use strict';
var Animator = require('blick');;
var Engine = require('inkblot/engine');
var LocalStorage = require('inkblot/localstorage');
var Document = require('inkblot/document');
var story = require('./airship.json');
var Heavens = require('./heavens');

var scope = {};
scope.window = window;
scope.animator = new Animator();

var style = document.getElementById('style');

var heavens = new Heavens(null, scope);
heavens.month = 0.5;
heavens.setSheet(style.sheet);
var doc = new Document(document.body, redraw);
var engine = new Engine({
    story: story, 
    start: localStorage.getItem('start'),
    render: doc, 
    dialog: doc,
    storage: new LocalStorage(localStorage)
});

engine.end = function end() {
    heavens.day = 0;
    heavens.day$ = 0;
    return this.goto('start');
};

doc.clear();
engine.continue();

function redraw() {
    var hour = engine.top.get('time') / 2;
    var day = (hour + 0.5) / 14;
    heavens.day = day;
}
redraw();

window.onkeypress = function onkeypress(event) {
    if (engine.top.get('end')) {
        return;
    }
    var key = event.key || String.fromCharCode(event.charCode);
    var match = /^(\d+)$/.exec(key);
    if (match) {
        engine.answer(match[1]);
    }
    redraw();
};
