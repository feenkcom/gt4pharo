Class {
	#name : #GtPharoKeywordNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'selectorParts'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoKeywordNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitKeyword: self
]

{ #category : #converting }
GtPharoKeywordNode >> asString [
	^ self source asString
]

{ #category : #converting }
GtPharoKeywordNode >> asSymbol [
	^ self asString asSymbol
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

{ #category : #converting }
GtPharoKeywordNode >> selector [
	^ self asSymbol
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
