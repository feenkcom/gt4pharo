Class {
	#name : #GtPharoSuperVariableNode,
	#superclass : #GtPharoVariableNode,
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoSuperVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSuperVariable: self
]

{ #category : #testing }
GtPharoSuperVariableNode >> isSuper [
	^ true
]
