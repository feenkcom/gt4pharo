Class {
	#name : #GtContextVariableValueStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'variables'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #accessing }
GtContextVariableValueStyler >> hasValueForVariableNamed: aVariableName [
	^ self 
		valueForVariableNamed: aVariableName 
		ifPresent: [ :value | true ] 
		ifAbsent: [ false ]
]

{ #category : #accessing }
GtContextVariableValueStyler >> valueForVariableNamed: aVariableName ifPresent: presentBlock ifAbsent: absentBlock [
	^ coderViewModel sharedBindings 
		bindingValueOf: aVariableName
		ifPresent: [ :value | presentBlock value: value ]
		ifAbsent: absentBlock
]

{ #category : #accessing }
GtContextVariableValueStyler >> visitVariable: aVariableNode [
	(self hasValueForVariableNamed: aVariableNode name value) ifFalse: [ ^ self ].

	(text from: aVariableNode startPosition to: aVariableNode stopPosition) replacingAdornment: [ :aTBrTextEditorTextualPiece :anEditorElement | 
		| aContainer aTextPieceElement displayText aValueElement theValue |
		aContainer := BlElement new
			clipChildren: false;
			layout: BlLinearLayout vertical;
			constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical fitContent ].
		aTextPieceElement := (BrTextEditableWordPieceStencilBuilder new segmentPiece: aTBrTextEditorTextualPiece) asElement.
		aContainer addEventHandler: (BlEventDelegator delegate: BrTextEditorRequest to: aTextPieceElement).
		displayText := self 
			valueForVariableNamed: aVariableNode name value
			ifPresent: [ :aValue |
				theValue := aValue.
				([ aValue gtDisplayString asRopedText
						foreground: (Color veryLightGray);
						fontSize: 8 ] 
				on: Error, Halt
				do: [ :e | e messageText asRopedText foreground: Color red ]) ] 
			ifAbsent: [ 
				'<missing>' asRopedText foreground: Color red ].
		aValueElement := BlShrinkingTextElement new text: displayText.
		aValueElement aptitude: ((BrGlamorousWithTooltipAptitude content: [
			| aTooltipContainer |
			aTooltipContainer := BlElement new
				layout: BlFrameLayout new;
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				when: GtPhlowObjectToSpawn do: [ :anEvent | aValueElement phlow spawnObject: theValue ].
			(theValue gtViewsFor: GtPhlowEmptyView new) asElementDo: [ :anInspectorElement |
				aTooltipContainer addChild: ((anInspectorElement exact: 400@400) asScalableElement size: 200@200)
			] ]) showDelay: 200 milliSeconds).
		aValueElement when: BlClickEvent do: [ :event | aValueElement phlow spawnObject: theValue ].
		aValueElement clipChildren: true.
		aValueElement constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
		aContainer addChildren: { aTextPieceElement . aValueElement } ].
]
