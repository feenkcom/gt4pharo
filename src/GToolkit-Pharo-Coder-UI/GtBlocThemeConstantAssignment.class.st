Class {
	#name : #GtBlocThemeConstantAssignment,
	#superclass : #GtBlocThemePropertyAssignment,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeConstantAssignment >> generateAccessorSource [
	^ 'self constantAt: #{1}' format: { self valueName }
]

{ #category : #'as yet unclassified' }
GtBlocThemeConstantAssignment >> isConstantAssignment [
	^ true
]
