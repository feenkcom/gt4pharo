Class {
	#name : 'GtPharoLiteralNode',
	#superclass : 'GtPharoValueNode',
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : 'generated' }
GtPharoLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLiteral: self
]

{ #category : 'testing' }
GtPharoLiteralNode >> isLiteral [
	^ true
]

{ #category : 'testing' }
GtPharoLiteralNode >> isString [
	^ false
]

{ #category : 'accessing' }
GtPharoLiteralNode >> literalValue [
	^ self subclassResponsibility
]
