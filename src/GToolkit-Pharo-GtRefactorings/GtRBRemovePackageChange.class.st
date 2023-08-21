Class {
	#name : #GtRBRemovePackageChange,
	#superclass : #GtRBPackageChange,
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #converting }
GtRBRemovePackageChange >> asUndoOperation [
	^ GtRBAddPackageChange packageName: packageName
]

{ #category : #private }
GtRBRemovePackageChange >> primitiveExecute [
	(RPackageOrganizer default
		packageNamed: packageName asSymbol
		ifAbsent: [ ^ self ]) unregister
]
