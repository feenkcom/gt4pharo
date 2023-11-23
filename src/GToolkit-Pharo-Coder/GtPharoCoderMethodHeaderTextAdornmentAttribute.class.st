Class {
	#name : #GtPharoCoderMethodHeaderTextAdornmentAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'coderViewModel',
		'attributeElementStencil'
	],
	#category : #'GToolkit-Pharo-Coder-SelectorAttributes'
}

{ #category : #accessing }
GtPharoCoderMethodHeaderTextAdornmentAttribute >> attributeElementStencil: aStencil [
	attributeElementStencil := aStencil
]

{ #category : #accessing }
GtPharoCoderMethodHeaderTextAdornmentAttribute >> coderViewModel: aCoderViewModel [
	coderViewModel := aCoderViewModel 
]

{ #category : #accessing }
GtPharoCoderMethodHeaderTextAdornmentAttribute >> computeAttributeElement [
	^ attributeElementStencil asElement
]

{ #category : #accessing }
GtPharoCoderMethodHeaderTextAdornmentAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	"Return the label element that is appended"
	<return: #SequenceableCollection of: #BlElement>

	^ {BrFrame new 
		fitContent;
		addChild: self computeAttributeElement }
]

{ #category : #initialization }
GtPharoCoderMethodHeaderTextAdornmentAttribute >> initialize [

	super initialize.
	self beAppend
]
