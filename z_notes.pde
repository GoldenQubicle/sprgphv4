/*

ok so make stringValue match EXACTLY, AND set them at layer level
then to differentiate between x,y,z for vectors, use the Id of segments or something
thats why I had the buttonpressed var in the first place, wasnt it?!

yeeeahhh so thing is:
when I delete a trackGroup and want to remove the corresponding segments
I cannot iterate over segmentsMap and remove them from said map at the same
THAT is why I had the aniUpdate flag for deletion system setup in the frigging first place
doesnt mean it cannot exists in parrallel, or maybe even have a temporary segmentSelectedMap serve more than one purpose
besides, Im not quite happy with using an IntDict as means  to keep track, 
because I now have to first retrieve keys, and then retrieve actual segment to get to the stringValue
Id much rather just pass the key, or perhaps even pass in the actual segment selected


RRRIGHT - if I want to have the intial layerState, I need to have a method which replaces the obj of the ani to be the current state
SOOOO - actually need to 1) keep track of which segments have been editted - which is different from the list of segmentsSelected
as in, a segment may be editted (e.g. in length) while not have been selected, because the latter is only used to match segment to controller, i.e. to set the endValue


hmm actually, what if I only change the inital layer state? 
then, no segment would be flagged for change / selected
however, the ani object would still need to be updated to reflect the changes in initial state
in other words, I actually probably will have to just update each and all ani, i.e. create new ani and replace them in map





k so current thinking, 

when in editMode
- listen for controllers active, get their stringValue
- get selected trackSegments, and get their stringValue
- perform stringValue matching, if ok
- retrieve ani by segmentKey, and pass down controller value

so, what this means in practical terms: 
- design a naming scheme which will serve to match controllers with trackSegments
- implement said naming scheme for controllers using the stringValue
- carefully re-organize construction of segmentKey, such that they're still getting an unique key, however, segments gets passed the appropriate stringValue 
- when performing matching, there needs to be a check for layer selected - can possibly get this from trackgroup id

And more generally speaking, atm ani creation & updating is deffered 
however I might want to consider more direct approach because that'll free up aniUpdate Map 
which can then be used to retain the keys which can be used to do stringValue matching. 
Or in other words, there really isn't any particular reason why it's set up the way it is
other than it initially helped me figure stuff out - which is a legit reason - but it doesn't really serve an inherent purpose. 


SO on ani creation, all I really need is the object and the field

naming scheme to match trackSegments with controllers by matching stringValue


gear - 1 - vector      | this requires additional check on segment if it's x or y, since slider2d cannot differentiate that
gear - 2 - petals    
gear - 3 - connect



soo here's an additional thing: I'd much prefer it if I only had to set these stringValues once, i.e. have 1 place where I can add them, and they'll propogate throughout the stringValue fields
and the same goes for other property types and the like
or to put that another, whatever needs to be matched in dependent on the layer type and it's properties
and atm I feel there's a few too many places which rely on manually setting switches / stringValues, etc

so yeah, really need to carefully trace the whole trackGroup &  trackSegment flow to ensure that
1) trackGroups have unique keys, but cannot be made more than once!
2) segments have unique keys, but share the stringValue with controllers

some more thinking: the stringValue of actual segments can be used as key, since segments are bound to a track, i.e. controller is already known
so I could use the parent, i.e. the indivudal track to store the controller string value
and then use the add buttons stringValue to pass down the fieldname for aniCreation

==========================================================================

ok so the question below, how to hold on, and return to, inital layerState after setting ani values
AND the particular ill considered question of actually getting end values into the ani
BOTH boil down to a question of editting

so, the current thinking is: I have a timeline, and an indicator
when in edit mode, the indicator asks: at this particular time, i.e. frame number, 
is there an ani whose delay+duration match this frame number ~ implies some form of snapping / rubber banding of indicator to segment end, otherwise it would fidlly I think to get it exact
if so, are there any anis in this subset whose layer object / id, matches with the one currently selected in gui ~implies either object comparison, or give the later an id field
if so, which controller is currently broadcasting, i.e. being manipulated ~ implies a global listeren active during edit mode
if so, does one of the anis map to the same object / field?  ~ this implies the controllers have some field (e.g. stingvalue) which matches with part of the aniKey?
finally, if this is all true, then the values from the current controller is directly passed down the ani with setEnd()


hm yeah I really like this idea better than needing to select segments, temporarily store the key, look up the controller / layer it belongs to and then listen for events
though, come to think of it, it does eliminate the process of elimination, hehe
so, that mean, select a segment and store its key
from that key, check if the current layer selected matches (simply done by checking the value of layerlist!)
and actually, why would I have the ani value be set from the controller, instead why not simply ask the laterobject?! - hm no, because that would require getters for all layer stuffies, color ect
yeah so, bascially what I propose here is using the segmentkey, to look up to apprpriate controller by stringValue / Id / name / whatever
soooo couldnt I give the segment a callback which in edit mode would just take care of that?!

bascially, there two ways to go about: 
- topdown, from controller active, checking time line, looking up ani 
     pros direct line from gui to ani, does not involve the tracksegments, which is good because the value is not graphically represented in segment anyway
     cons lots of checks going on, would need to parse key into strings, and a switch case to get the appropriate value
- bottomup, segment active, look up controller, get value
     pros potentially easy matching by stringvalue, name, id, etc
     cons does require a lot of redesign, tracksegments no longer purely visual elements


what about a hybrid method
basically, when in edit mode get the active controller name / stringvalue / whatever makes it unique id-able
then check if there any segments selected which have the same unique id-able properties
if yes, get the key, use that to retrieve ani and pass down value, eg.

identified by active segment | identified by active controller

gif.aniSegments.get(aniKey).setEnd(theEvent.getController.getValue());


==========================================================================



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