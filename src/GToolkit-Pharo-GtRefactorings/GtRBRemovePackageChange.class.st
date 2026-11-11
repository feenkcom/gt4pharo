Class {
	#name : #GtRBRemovePackageChange,
	#superclass : #GtRBPackageChange,
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #converting }
GtRBRemovePackageChange >> asUndoOperation [
	^ GtRBAddPackageChange packageName: packageName
]

{ #category : #printing }
GtRBRemovePackageChange >> changeString [
	^ 'Remove package ' , packageName asString
]

{ #category : #accessing }
GtRBRemovePackageChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeRemove
]

{ #category : #private }
GtRBRemovePackageChange >> primitiveExecute [
	(self packageOrganizer
		packageNamed: packageName asSymbol
		ifAbsent: [ ^ self ]) unregister
]
