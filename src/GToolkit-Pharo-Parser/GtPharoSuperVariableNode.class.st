Class {
	#name : #GtPharoSuperVariableNode,
	#superclass : #GtPharoVariableNode,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoSuperVariableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSuperVariable: self
]

{ #category : #testing }
GtPharoSuperVariableNode >> isSpecialVariable [
	^ true
]

{ #category : #testing }
GtPharoSuperVariableNode >> isSuper [
	^ true
]
