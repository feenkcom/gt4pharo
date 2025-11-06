Extension { #name : #RBArgumentName }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBArgumentName >> argValue [
	"Adding method to P11 so we can use it in any version of Pharo."

	<gtPharoPatch: #Pharo11>
	^ value
]
