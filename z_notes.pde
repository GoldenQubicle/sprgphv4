/*


so currently the setAniValue is not working properly, as in, the x & y values of slider2d interferring
besides, I still don't quite like the setup any way

going forward, once Im able to get basic animation working and screencap it this project will be on the backburner
that said, there're definitly things to consider in the meanwhile, especially with regard to saving & loading
for example, upon load entire new GUI needs to be setup, and with regard to trackSegments, I need to get the data from somewhere
SO it probably is best to have the controller grab all the relevant data from the segments, and store it
then, have to animation use that data to construct the ani from it
that will make a lot more sense than the bouncing around which its doing now


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
delta = trackSegment.get(track).getPosition()[0] - currentsegmentEndPos;
endConstrain = trackSegment.get(track).getPosition()[0];
}
}

theoretically this should work, however, I probably want to implement this later on when save / load is actually working because otherwise in order to test this Id need to add trackGroup, add & position 3 segments, etc, every time and this will get cumbersome fast. besides, really think I should get the time mapping correct first

   
==========================================================================


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