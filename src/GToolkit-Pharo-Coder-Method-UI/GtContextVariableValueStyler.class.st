Class {
	#name : #GtContextVariableValueStyler,
	#superclass : #GtAbstractVariableValueStyler,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #accessing }
GtContextVariableValueStyler >> valueForVariableNamed: aVariableName ifPresent: presentBlock ifAbsent: absentBlock [
	^ coderViewModel sharedBindings 
		bindingValueOf: aVariableName
		ifPresent: [ :value | presentBlock value: value ]
		ifAbsent: absentBlock
]
