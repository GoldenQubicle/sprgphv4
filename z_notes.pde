/*
 D E F I N I T I O N S 
 -  layer properties are those variables which constitute a so-called gear, the makeup of which depends on layerType
 -  layerType properties must be kept in sync with NumberOfGears, i.e. anything which loops over NumberOfGears is considered a layer property
 -  hence, add & delete property methods must exist in derived classes, and must include calls to super
 -  layerType properties may be exposed to GUI_gearGroup, if so, necesarry methods in both GUI_gearGroup and layerType must obviously exist
 
===========================================================================


so okidoki, lets first see if I can add just the default properties to the scrollable list
and then pipe those down to the animation class, no matter how it gets done at first

 FUCK YEAH!!
 so, make a giant switch case which check incoming value from propertiesList (for each track)
 and casts the appropriate property into a generic object
 
 this way, each and every ani object can - theoretically - have to same constructor call by calling
 
 new Ani(propertyToAnimate, duration, propertyFieldName, Value)
 
 hmmm, okay, so I do have to rework some stuff, as in, what exaclty is the field name for IntList petals?!
 still, that seems like a minor issue
 hmmm come to think of it, the concept of having a gear class as wrapper for properties doesnt seem so silly anymore
 honestly it really does make a lot of sense from a design perspective as well
 HOWEVER
 that does mean that each layerType will need to be able to construct different gear objects
 i.e. what now called addProperties, needs to be replace by something which constructs gears

 
 */