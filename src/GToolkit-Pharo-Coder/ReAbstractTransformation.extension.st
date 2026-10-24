Extension { #name : #ReAbstractTransformation }

{ #category : #'*GToolkit-Pharo-Coder' }
ReAbstractTransformation >> gtExecuteWithUndo [
	"Like #execute, but the changes are performed by GtRefactoryChangeManager,
	so that they can be undone"

	self generateChanges.
	self changes gtExecuteWithUndo
]
