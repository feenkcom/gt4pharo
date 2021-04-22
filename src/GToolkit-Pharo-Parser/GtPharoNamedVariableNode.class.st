Class {
	#name : #GtPharoNamedVariableNode,
	#superclass : #GtPharoVariableNode,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoNamedVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNamedVariable: self
]
