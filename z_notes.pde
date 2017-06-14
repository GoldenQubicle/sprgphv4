/*


GENERAL: have UI feedback which controller is active, or edit mode currently active 

for the time being the focus should be on animation & serialisation because they are intertwined.
that is, the layer object to be serialised will need to hold animation objects as well, since I want multiple layer support


sooo yeah these plans below are all fine and dandy, however, it really does open a can of worms like: start & end positions, insert, edit mode, etc
or, in other and more practical words, in the current setup, how often have I wished to be able to tweak the aniDuration with more precision
than adding/subtracting keyFrames? The answer is: never. 

What's more, the dynamic gear groups already are quite a can of worms, even with the current setup! 

for starters: there no longer is a fixed list of properties for the aniMatrix
that is, theY and corresponding Layerproperties have been decoupled
instead, itll have to be setup like theY -> getItemFromScrollablePropertiesList -> property
moreover, said layerProperties are ALSO no longer fixed, since it now is dependent on layerType
and this is bit of an issue since the ani will need to have some object to act on
however, since currently the display method is called on the layer parent, it would in effect mean that
all additional properties of children have to be duplicated . . ? Unless, could I set the ani on a type specific child instance, in a seperate array, 
perhaps not even rendering, and see the changes take effect on the parent instance in the Layer array?! => yeah this will probably work
i.e. to animate layerType specific properties, the anis will need to get passed the layerType object, instead of the LayerParent object
andnnnddd, i guess the same is true for setting up the additional properties in the aniMatrix, 
that is, the scrollable list from which to choose, will need to be read/write from layerType specific objects




 
 
 

 
 
 */