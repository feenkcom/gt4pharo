Class {
	#name : #GtRBAddMetaclassWithSlotsChange,
	#superclass : #RBAddMetaclassChange,
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #private }
GtRBAddMetaclassWithSlotsChange class >> definitionPatterns [
	^ #('`className class slots: `@slotsExpression'
		'`className class uses: `@traitComposition slots: `@slotsExpression')
]
