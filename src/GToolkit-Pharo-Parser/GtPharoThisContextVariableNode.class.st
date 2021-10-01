Class {
	#name : #GtPharoThisContextVariableNode,
	#superclass : #GtPharoVariableNode,
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoThisContextVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitThisContextVariable: self
]

{ #category : #testing }
GtPharoThisContextVariableNode >> isThisContext [
	^ true
]
