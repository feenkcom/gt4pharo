Class {
	#name : #GtStackContextVariableValueStyler,
	#superclass : #GtAbstractVariableValueStyler,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #accessing }
GtStackContextVariableValueStyler >> valueForVariableNamed: aVariableName ifPresent: presentBlock ifAbsent: absentBlock [
	| value |
	aVariableName = 'self' ifTrue: [ ^ absentBlock value ].
	value := coderViewModel context readVariableNamed: aVariableName.
	^ value
		ifNotNil: [ :val | 
			(val isBehavior and: [ val name = aVariableName ])
				ifTrue: [ absentBlock value ]
				ifFalse: [ presentBlock value: val ] ]
		ifNil: absentBlock
]
