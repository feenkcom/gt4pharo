Class {
	#name : #GtFixItAttributeWithDescription,
	#superclass : #GtFixItAttribute,
	#instVars : [
		'description'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics-FixIt'
}

{ #category : #accessing }
GtFixItAttributeWithDescription >> description [
	^ description
]

{ #category : #accessing }
GtFixItAttributeWithDescription >> description: aBlText [
	description := aBlText asRopedText
]

{ #category : #accessing }
GtFixItAttributeWithDescription >> dropDownElementFor: anEditorElement [
	| pane label |
	pane := BrVerticalPane new.
	pane fitContent.
	label := BrEditor new
			hMatchParent;
			vFitContent;
			aptitude: BrGlamorousRegularEditorAptitude new glamorousCodeSmallSize;
			text: (description foreground: BrGlamorousColors disabledButtonTextColor).
	pane addChild: label.
	pane addChild: (super dropDownElementFor: anEditorElement).
	^ pane
]
