Extension { #name : #RBRenamePackageChange }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBRenamePackageChange >> changeString [
	"Without it, the change is described by its class name (RBRefactoryChange>>#changeString)"

	^ 'Rename package ' , oldName asString , ' to ' , newName asString
]
