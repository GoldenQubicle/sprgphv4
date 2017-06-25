/*
current concerns

2406
hm yeah, just from this current quick mockup its evident I need to rethink the design because;
  - even with just a few gears, the properties list is becoming quit long already
  - the past has proven that certain properties (e.g. radius x & y ) tend to move together
  - these two things considered, itd probaly become quite elaborate and tedious to add tracks per property
  
SO what if I did away with the concept of individual tracks and instead group properties together sensibly, 
and thus create a two-tier selection system, i.e. 
  - select trackGroup for gear object, 
  - trackGroup contains animations tracks for all gear properties
  
  in similar fashion have
  - trackGroup color, which contains background, fill & stroke
  - trackGroup line, which contains lineX, lineY & strokeWeight
  
this require some thinking upfront though
basically I need to have an abstract trackGroup class, which has flexible design as to add properties of whatever type

- trackGroup: layerSelected
    - trackProperty:  layerobject, fieldname
        - trackSegment  delay, duration, value, easingType
  
  
hm yeah, good idea I still think, however it does pose a few additional issues
  - when a gear object is deleted from the layer, a check needs to be made to see if there's a trackGroup for that gear object, and is so delete that as well
  - allow possible duplicate trackGroups? probably not, so when hitting the button, it needs to become disabled and have message it already exists or something
  
 so, its apparent I need some storage to keep track of trackGroups xD
 perhaps have the controller keep track in a hashmap, so it can check to see if the keys already exist
 and may also be usefull later to check for changes
  
  
==========================================================================

moving forward
- make mock track ui, i.e. functional behaviourly, yet not hooked into anything yet
- be able to add / delete tracks
- be able to add / delete segments to track
- be able to edit segment length & position

once thats in place, figure out mapping of segment position to timeline, handled by controller

===========================================================================

 D E F I N I T I O N S 
 -  gearProperties are those variables which constitute a so-called gear, the makeup of which depends on layerType
 -  gearProperties must be kept in sync with NumberOfGears, i.e. anything which loops over NumberOfGears is considered a gearProperty
 -  hence, add & delete gear methods must exist in classes derived from Layer parent, and must include calls to super
 -  gearProperties may be exposed to GUI_gearGroup, if so, necesarry methods in both GUI_gearGroup and layerType must obviously exist
 
 
 ===========================================================================

 G E N E R A L  I D E A S
 -  have ui feedback on which controller and / or ui mode is active
 -  have the ability to edit multiple layers at once, e.g. set color over 4 layers 
 
 
 ===========================================================================
 
 regarding animations 
 
 so, make a giant switch case which check incoming value from propertiesList (for each track)
 and cast the appropriate property into a generic object
 
 this way, each and every ani object can - theoretically - have to same constructor call by calling
 
 new Ani(propertyToAnimate, duration, delay, propertyFieldName, Value)
 ................1.............2........3.............4...........5...        
 
 1 + 4) are determined on a trackObject level
 
 2 + 3 + 5) these need to be determined on a aniObject level
 
 1) this is taken care of by casting whatever property into a generic object
 4) should be handled as well by passing down value propertyList from track
 
 so, each track object need to hold multiple segments
     each segment consist of aniEasing list
     
 so here's a question, will the track object hold the anis, or should I pass this back into animation class proper. . 
 thats probably a good idea, because that way, I could quickly check if something has changed first on a track level
 and than on a ani level
 as in, the animation class holds an arraylist of tracks, the track class in turn holds an arraylist of segments
 then the animation class should have an update function which check current status (provided by gui) against tracks
 if something has changed, update the segment?!
 could perhaps use hashmaps here, e.g. store each track, let aninatiom class first chech if key is present, and is so if objects match
 and no, good
 if yes, retrieve segment hashmap from track, and rinse-and-repeat on segment level
 
 
 also, still not clear whats the best approach to handling the time, i.e. in seconds or frames?
 for now, think frames will do best
 
 that said, it is clear the animation class will need to have a rocksolid timer, which can be used for rendering as well
 
 also, may want to use ani sequence, because it appears that way seek wil act in the complete sequence instead individual ani
 yep that deffo works
 so the animation class  wil need to construct a complete sequence
 so in other words the track and segment objects only serve to pass information back-and-forth between gui and animation class
 
 
 
 
 */