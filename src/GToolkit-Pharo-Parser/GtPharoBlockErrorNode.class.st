Class {
	#name : #GtPharoBlockErrorNode,
	#superclass : #GtPharoBlockNode,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoBlockErrorNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitBlockError: self
]
