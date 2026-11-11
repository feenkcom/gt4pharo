Extension { #name : #RBAddMethodChange }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBAddMethodChange >> changeString [
	"Describe the change as an action, consistent with RBRemoveMethodChange>>#changeString"

	<gtPharoPatch: #Pharo>
	^ 'Add <1s>>>#<2s>' expandMacrosWith: self displayClassName with: self selector
]
