Class {
	#name : #GtFixItAttributeWithDescription,
	#superclass : #GtFixItAttribute,
	#instVars : [
		'descriptionBlock'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics-FixIt'
}

{ #category : #accessing }
GtFixItAttributeWithDescription >> description: aBlockReturningBlText [
	descriptionBlock := aBlockReturningBlText
]

{ #category : #accessing }
GtFixItAttributeWithDescription >> dropDownElementFor: anEditorElement [
	| pane label text |
	pane := BrVerticalPane new.
	pane fitContent.
	text := (descriptionBlock cull: anEditorElement) asRopedText foreground: BrGlamorousColors disabledButtonTextColor.
	label := BrEditor new
			hMatchParent;
			vFitContent;
			aptitude: BrGlamorousRegularEditorAptitude new glamorousCodeSmallSize;
			text: text.
	pane addChild: label.
	pane addChild: (super dropDownElementFor: anEditorElement).
	^ pane
]

{ #category : #accessing }
GtFixItAttributeWithDescription >> initialize [
	super initialize.
	descriptionBlock := [ :editorElement | '' ]
]
