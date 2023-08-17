Class {
	#name : #GtRBAddPackageChange,
	#superclass : #GtRBPackageChange,
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #converting }
GtRBAddPackageChange >> asUndoOperation [
	^ GtRBRemovePackageChange packageName: packageName
]

{ #category : #private }
GtRBAddPackageChange >> primitiveExecute [	
	(RPackage organizer includesPackageNamed: packageName)
		ifTrue: [ ^ self ].

	RPackage organizer createPackageNamed: packageName
]
