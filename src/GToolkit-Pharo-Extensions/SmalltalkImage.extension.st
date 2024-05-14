Extension { #name : #SmalltalkImage }

{ #category : #'*GToolkit-Pharo-Extensions' }
SmalltalkImage >> classInstaller [
	<gtPharoPatch: #Pharo>
	"Answer the class responsible of creating classes in the system."
	
	^ self 
		forPharo12: [ ShiftClassInstaller] 
		forPharo11: [ GtShiftClassInstaller] 
		forPharo10: [ GtShiftClassInstaller] 
]
