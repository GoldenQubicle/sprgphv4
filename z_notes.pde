/*

ok so play / pause is sorta fixed for now
HOWEVER, since each ani is checked if it has ended individually, it still looks a bit wonky
YET this is not an issue because I know what's causing it
ANDd I plan to remedy this by putting the anis in a sequence, and use play/pause/seek on the sequence

==========================================================================



question still is how to actually differentiate between the initial layerState and edit layerState. Or to put that another way,  how need to retrieve layerValues to pass into ani, and then change the layerValues back to initial state?

- could try setting up a temporary edit layer, possibly by cloning / copying the inital layer
- if this produces a referenced object - which is a distinct possibility - Id much prefer to start looking into saving stuff out properly to json 

==========================================================================

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

==========================================================================

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
 
so for shits 'n giggles lets document the workflow for adding new animating properties to a layer
first of all, a new StringList is needed in the layerObject, populated with the fieldnames of the values to be animated
then, in GUI_trackGroup a new button needs to be setup, and added to menu
then, new switch cases for that trackGroup need to added to the tgController & the animation class
also, probably need to recast the layer into its type in order to acces the propertyList & field values
all-in-all it should, theoretically, work quite smoothly

 
 
 
 
 */