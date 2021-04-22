Class {
	#name : #GtPharoTemplatableNode,
	#superclass : #GtPharoProgramNode,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoTemplatableNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplatable: self
]
