/*
soo next up: get layer type buttons in place, and probably want look into json serialisation
 once that's done, implement multiple layers + displayStyle gui
 
 
 couple of thoughts on how to handle animation:
 - limit playback to 30 fps, or maybe lower still to improve performance
 - have continual playback do a hard reset when looping (i.e. previously state of ani interferered with re-start)
 - add properties to animate on case-by-case basis
 - ideally Id like to have more flexibility in timing, i.e. somehow do away with matrix
 - so imagine normalized timeline from 0-1, be able to insert ani at any point, and simply drag out a desired length
 - that would entail two things to be realized:
 1) need to have a timer running in background which fires anis (or. . perhaps put the ani's on a delay from start. . ?!
 2) need to store values which ani has to animate to 
 
 */