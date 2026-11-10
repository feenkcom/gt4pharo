Extension { #name : #RBRenameClassChange }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBRenameClassChange >> changeString [
	"Describe the change as an action, consistent with RBRenameVariableChange>>#changeString.
	Without it, the change is described by its class name (RBRefactoryChange>>#changeString)"

	^ 'Rename ' , self oldName asString , ' to ' , self newName asString
]
