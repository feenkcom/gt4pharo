Extension { #name : #SmalltalkImage }

{ #category : #'*GToolkit-Pharo-Extensions' }
SmalltalkImage >> classInstaller [
	<gtPharoPatch: #Pharo>
	"Answer the class responsible of creating classes in the system."
	
	^ GtShiftClassInstaller
]
