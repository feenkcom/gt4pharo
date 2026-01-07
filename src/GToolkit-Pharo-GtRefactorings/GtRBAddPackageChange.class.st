Class {
	#name : #GtRBAddPackageChange,
	#superclass : #GtRBPackageChange,
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #converting }
GtRBAddPackageChange >> asUndoOperation [
	^ GtRBRemovePackageChange packageName: packageName
]

{ #category : #accessing }
GtRBAddPackageChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeAdd
]

{ #category : #private }
GtRBAddPackageChange >> primitiveExecute [	
	(self packageOrganizer includesPackageNamed: packageName)
		ifTrue: [ ^ self ].

	self packageOrganizer createPackageNamed: packageName
]
