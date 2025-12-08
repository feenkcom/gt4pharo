Class {
	#name : #GtPharoByteArrayLiteralNode,
	#superclass : #GtPharoArrayLiteralNode,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoByteArrayLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitByteArrayLiteral: self
]

{ #category : #accessing }
GtPharoByteArrayLiteralNode >> guessType: completionStrategy [
	^ ByteArray
]

{ #category : #accessing }
GtPharoByteArrayLiteralNode >> literalValue [
	^ self values collect: [ :eachValue | eachValue literalValue ] as: ByteArray
]
