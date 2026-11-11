Extension { #name : #RBRemovePackageChange }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBRemovePackageChange >> changeString [
	"Without it, the change is described by its class name (RBRefactoryChange>>#changeString)"

	^ 'Remove package ' , packageName asString
]
