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

	(text from: aVariableNode startPosition to: aVariableNode stopPosition)
		overlayingAdornment: [ :aTextPiece :anEditorElement | 
			| aContainer displayText aValueElement theValue verticalBar |
			aContainer := BlElement new
					clipChildren: false;
					layout: BlFrameLayout new;
					constraintsDo: [ :c | 
						c horizontal exact: aTextPiece textLength * 10.
						c vertical exact: 25 ].
			verticalBar := BlElement new
					constraintsDo: [ :c | 
						c frame vertical alignBottom.
						c horizontal exact: 1.
						c vertical exact: 15 ];
					background: Color veryLightGray.

			displayText := self
					valueForVariableNamed: aVariableNode name value
					ifPresent: [ :aValue | 
						theValue := aValue.
						[ aValue gtDisplayString asRopedText glamorousRegularFont
							foreground: Color veryLightGray;
							fontSize: 10 ]
							on: Error , Halt
							do: [ :e | e messageText asRopedText glamorousRegularFont foreground: Color red ] ]
					ifAbsent: [ '<missing>' asRopedText glamorousRegularFont
							foreground: Color red ].
			aValueElement := BlShrinkingTextElement new text: displayText.
			aValueElement
				aptitude: ((BrGlamorousWithTooltipAptitude
						content: [ | aTooltipContainer |
							aTooltipContainer := BlElement new
									layout: BlFrameLayout new;
									constraintsDo: [ :c | 
										c horizontal fitContent.
										c vertical fitContent ];
									when: GtPhlowObjectToSpawn
										do: [ :anEvent | aValueElement phlow spawnObject: theValue ].
							(theValue gtViewsFor: GtPhlowEmptyView new)
								asElementDo: [ :anInspectorElement | 
									aTooltipContainer
										addChild: ((anInspectorElement exact: 400 @ 400) asScalableElement size: 200 @ 200) ] ])
						showDelay: 200 milliSeconds).
			aValueElement
				when: BlClickEvent
					do: [ :event | aValueElement phlow spawnObject: theValue ];
				when: BlMouseEnterEvent
					do: [ :event | 
						aValueElement
							text: (aValueElement text copy foreground: BrGlamorousColors hoveredButtonBorderColor).
						verticalBar background: BrGlamorousColors hoveredButtonBorderColor ];
				when: BlMouseLeaveEvent
					do: [ :event | 
						aValueElement text: (aValueElement text copy foreground: Color veryLightGray).
						verticalBar background: Color veryLightGray ].
			aValueElement
				clipChildren: true;
				padding: (BlInsets left: 2);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent.
					c frame vertical alignBottom ].
			aContainer
				addChildren: {verticalBar.
						aValueElement} ]
]
