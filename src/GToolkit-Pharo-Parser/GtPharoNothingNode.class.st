Class {
	#name : #GtPharoNothingNode,
	#superclass : #GtPharoProgramNode,
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoNothingNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNothing: self
]
