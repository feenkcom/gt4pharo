Class {
	#name : #GtPharoClassExpanderAttribute,
	#superclass : #BrGlamorousTriangleExpanderTextAttribute,
	#instVars : [
		'classToExpand'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Attributes'
}

{ #category : #'initialize-release' }
GtPharoClassExpanderAttribute class >> forClass: aClass [
	^ self new
		forClass: aClass;
		definingMethod: (GtPhlowDefiningMethodsCollector forContext: thisContext) collect;
		yourself
]

{ #category : #private }
GtPharoClassExpanderAttribute >> buildBehaviorCoder [
	| editorElement |
	editorElement := GtCoderElement forClass: classToExpand.
	editorElement background: Color white.
	editorElement
		aptitude: BrShadowAptitude
				+ (BrGlamorousWithVerticalResizerAptitude new
						beBottom;
						yourself).
	editorElement
		height: 400;
		margin: (BlInsets
				top: 3
				right: 10
				bottom: 10
				left: 10).
	^ editorElement
]

{ #category : #accessing }
GtPharoClassExpanderAttribute >> expandedClass [
	^classToExpand
]

{ #category : #'initialize-release' }
GtPharoClassExpanderAttribute >> forClass: aClass [
	classToExpand := aClass
]

{ #category : #'initialize-release' }
GtPharoClassExpanderAttribute >> initialize [
	super initialize.
	self
		attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [ self buildBehaviorCoder ] ]
]
