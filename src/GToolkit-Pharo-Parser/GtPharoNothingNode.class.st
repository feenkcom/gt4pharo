Class {
	#name : 'GtPharoNothingNode',
	#superclass : 'GtPharoProgramNode',
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : 'generated' }
GtPharoNothingNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNothing: self
]
