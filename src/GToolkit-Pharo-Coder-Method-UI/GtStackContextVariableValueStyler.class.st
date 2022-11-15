Class {
	#name : #GtStackContextVariableValueStyler,
	#superclass : #GtAbstractVariableValueStyler,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #accessing }
GtStackContextVariableValueStyler >> valueForVariableNamed: aVariableName ifPresent: presentBlock ifAbsent: absentBlock [
	| value |
	value := coderViewModel context readVariableNamed: aVariableName.
	^ value ifNotNil: [ presentBlock value: value ] ifNil: absentBlock
]
