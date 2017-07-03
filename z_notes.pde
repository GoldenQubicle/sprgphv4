/*

question still is how to actually differentiate between the initial layerState and edit layerState. Or to put that another way,  how need to retrieve layerValues to pass into ani, and then change the layerValues back to initial state?

- could try setting up a temporary edit layer, possibly by cloning / copying the inital layer
- if this produces a referenced object - which is a distinct possibility - Id much prefer to start looking into saving stuff out properly to json 

==========================

ok some quick thoughts how to handle updating aniSegments

basically, keep track of which segments have been added, deleted or possibly changed by flagging them as such in a separate segmentChanged dictionary which clears upon play

onMouseEnter the segmentKey gets added to dictionary and the 'changed' flag is set
on added the segmentKey gets added to dictionary and the 'new' flag is set
on deleted the segmentKey gets added to dictionary and the 'removed' flag is set

then upon play, the controller goes over the segmentChanged dictionary
when it encounters the changed flag, it retrieves the actual segment by key, constructs a new ani from the values and compares it against the ani already present in the AniList
if it's the same (which is possible since the changed flag is set by virtue of entering the segment) it discards the new ani, otherwise it replaces the one in the AniList

when it encounters the added flag, it retrieves the segment by key, constructs a new ani and adds it to the AniList (which implies the addSegment button does nothing more than add a gui element, and as such is NOT responsible for actually creating ani!!)

when it encounters the deleted flag, it deletes the ani by key from het AniList

finally, in all 3 cases the controller somehow keeps track of changed frame ranges and lastly clears the segmentChanged dictionary

so, this means the trackGroup gui simply has no direct relation anymore with the ani, and as such, the scrollableList should not send anything down directly to the gif / ani class in terms of easingstyle

=================

as for how to check overlapping trackSegments
basically it means the constrains currently static need to be made dynamic
that is, filter the trackSegment hashmap for the current segment, i.e. use part of segmentKey

then the question is: given the startPos of the current segment, which other segment endPos has the minimal difference in between
likewise, given the endPos of the current segment, which other segment startPos has the minimal difference in between
and finally, those start & end positions of the nearest segments need to be used as constrains for the current segment

if(trackSegment.get(track).getPosition()[0] > currentsegmentEndPos)
{
   if(trackSegment.get(track).getPosition()[0] - currentsegmentEndPos < delta)
{
deltta = trackSegment.get(track).getPosition()[0] - currentsegmentEndPos;
endConstrain = trackSegment.get(track).getPosition()[0];
}
}

theoretically this should work, however, I probably want to implement this later on when save / load is actually working because otherwise in order to test this Id need to add trackGroup, add & position 3 segments, etc, every time and this will get cumbersome fast. besides, really think I should get the time mapping correct first

==========================================================================

- trackGroup: layerSelected
    - trackProperty:  layerobject, fieldname
        - trackSegment  delay, duration, value, easingType
  
  
 - when a gear object is deleted from the layer, a check needs to be made to see if there's a trackGroup for that gear object, and if so delete that as well
    
==========================================================================

moving forward 24-6
- make mock track ui, i.e. functional behaviourly, yet not hooked into anything yet DONE 1-7
- be able to add / delete tracks  DONE  1-7
- be able to add / delete segments to track DONE 3-7
- be able to edit segment length & position DONE 2-7

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