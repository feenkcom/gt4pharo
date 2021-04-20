Class {
	#name : #GtPharoTemplatableNode,
	#superclass : #GtPharoProgramNode,
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoTemplatableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplatable: self
]
