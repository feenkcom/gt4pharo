Extension { #name : #RBMethodProtocolChange }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBMethodProtocolChange >> changeString [
	"Describe the change as an action, consistent with the other method changes"

	<gtPharoPatch: #Pharo>
	^ 'Move <1s>>>#<2s> to protocol <3s>'
		expandMacrosWith: self displayClassName
		with: self selector
		with: self protocol asString
]
