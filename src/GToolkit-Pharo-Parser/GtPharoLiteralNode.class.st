Class {
	#name : #GtPharoLiteralNode,
	#superclass : #GtPharoValueNode,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoLiteralNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLiteral: self
]

{ #category : #testing }
GtPharoLiteralNode >> gtIsBaselineName [
	(self isString or: [ self isSymbol ]) ifFalse: [ ^ false ].
	self class environment
		at: ('BaselineOf' , self literalValue) asSymbol
		ifAbsent: [ ^ false ].
	self topParent
		withAllNodesDo: [ :each | 
			(each isErrorNode not
				and: [ (each isSymbol or: [ each isString ])
						and: [ each literalValue = self literalValue ] ])
				ifTrue: [ each parent isMessage
						ifTrue: [ | index |
							index := each parent arguments identityIndexOf: each.
							index > 0
								ifTrue: [ (each parent selectorParts at: index) source = 'package:' ifTrue: [ ^ false ] ] ] ] ].
	^ true
]

{ #category : #testing }
GtPharoLiteralNode >> gtIsBaselinePackageName [
	(self isString or: [ self isSymbol ]) ifFalse: [ ^ false ].
	self packageOrganizer packageNamed: self literalValue ifAbsent: [ ^ false ].
	self topParent
		withAllNodesDo: [ :each | 
			(each isErrorNode not
				and: [ (each isSymbol or: [ each isString ])
						and: [ each literalValue = self literalValue ] ])
				ifTrue: [ each parent isMessage
						ifTrue: [ | index |
							index := each parent arguments identityIndexOf: each.
							index > 0
								ifTrue: [ (each parent selectorParts at: index) source = 'baseline:' ifTrue: [ ^ false ] ] ] ] ].
	^ true
]

{ #category : #testing }
GtPharoLiteralNode >> isLiteral [
	^ true
]

{ #category : #testing }
GtPharoLiteralNode >> isString [
	^ false
]

{ #category : #testing }
GtPharoLiteralNode >> isSymbol [

	^ false
]

{ #category : #accessing }
GtPharoLiteralNode >> literalValue [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPharoLiteralNode >> priority [
	^ 0
]
