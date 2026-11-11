Extension { #name : #RBAddPackageChange }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBAddPackageChange >> changeString [
	"Without it, the change is described by its class name (RBRefactoryChange>>#changeString)"

	^ 'Add package ' , packageName asString
]
