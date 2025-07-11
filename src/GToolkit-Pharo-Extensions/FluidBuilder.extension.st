Extension { #name : #FluidBuilder }

{ #category : #'*GToolkit-Pharo-Extensions' }
FluidBuilder >> install [
	<gtPharoPatch: #Pharo>
	"Install the class in the system environment"
	
	^ self 
		forPharo12: [
			GtShiftClassInstaller12 new makeWithBuilder: self ] 
		forPharo11AndPharo10: [ 
			GtShiftClassInstaller new makeWithBuilder: self shiftClassBuilder ]
]
