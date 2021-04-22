Class {
	#name : #GtPharoKeywordNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'selectorParts'
	],
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoKeywordNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitKeyword: self
]

{ #category : #'generated-initialize-release' }
GtPharoKeywordNode >> initialize [
	super initialize.
	selectorParts := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoKeywordNode >> otherVariables [
	^ #(#selectorParts)
]

{ #category : #accessing }
GtPharoKeywordNode >> selector [
	^ Symbol streamContents: [ :stream | self selectorParts do: [ :eachNode | stream nextPutAll: eachNode source ] ]
]

{ #category : #generated }
GtPharoKeywordNode >> selectorParts [
	^ selectorParts
]

{ #category : #generated }
GtPharoKeywordNode >> selectorParts: anOrderedCollection [
	self setParent: self selectorParts to: nil.
	selectorParts := anOrderedCollection.
	self setParent: self selectorParts to: self
]
