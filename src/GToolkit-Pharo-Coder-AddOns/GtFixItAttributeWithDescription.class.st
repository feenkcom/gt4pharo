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
	| pane label text |
	pane := BrVerticalPane new.
	pane fitContent.
	text := description foreground: BrGlamorousColors disabledButtonTextColor.
	text
		attribute: (GtButtonAttribute new
				beAppend;
				stencil: [ BrButton new
						aptitude: BrGlamorousButtonWithIconAptitude new;
						beTinySize;
						margin: (BlInsets left: 5);
						icon: BrGlamorousVectorIcons browse;
						label: 'Browse rule definition';
						action: [ anEditorElement phlow spawnTool: ((GtMethodCoderTool compiledMethod: GtFixItAttributeWithDescription>>#dropDownElementFor:)) ] ])
		from: text size
		to: text size.
	label := BrEditor new
			hMatchParent;
			vFitContent;
			aptitude: BrGlamorousRegularEditorAptitude new glamorousCodeSmallSize;
			text: text.
	pane addChild: label.
	pane addChild: (super dropDownElementFor: anEditorElement).
	^ pane
]
