Extension { #name : #FluidBuilder }

{ #category : #'*GToolkit-Pharo-Extensions' }
FluidBuilder >> install [
	<gtPharoPatch: #Pharo>
	"Install the class in the system environment"
	
	^ GtShiftClassInstaller new makeWithBuilder: self shiftClassBuilder
]
