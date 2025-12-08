Class {
	#name : #GtPharoNamedVariableNode,
	#superclass : #GtPharoVariableNode,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoNamedVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNamedVariable: self
]

{ #category : #testing }
GtPharoNamedVariableNode >> isVariableDefinition [
	^ self whoDefines ifNil: [ false ] ifNotNil: [ :node | node variables identityIncludes: self ]
]
