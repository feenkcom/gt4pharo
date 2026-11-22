"
I display a color next to {{gtClass:BrGlamorousColors}} messages.
#Example
The following example shows how a {{gtMethod:BrGlamorousColors class >> #pressedButtonBorderColor | label=#selector}} looks like directly in the code: {{gtExample:GtPharoGlamorousColorStylerExamples>>#glamorousColor}}
"
Class {
	#name : #GtPharoGlamorousColorStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Color'
}

{ #category : #'private - styling' }
GtPharoGlamorousColorStyler >> styleNode: aMessageSendNode [
	| color |
	color := [ aMessageSendNode receiver variableName asClass perform: aMessageSendNode message selector ]
			on: Error
			do: [ :anException | anException return: nil ].
	(color isKindOf: Color) ifFalse: [ ^ self ].
	self styleNode: aMessageSendNode withColor: color.
]

{ #category : #'private - styling' }
GtPharoGlamorousColorStyler >> styleNode: aMessageSendNode withColor: color [
	self
		attribute:
			(BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [ BlElement new
						size: 10 @ 10;
						background: color;
						when: BlClickEvent
							do: [ :e | e target phlow spawnObject: color ] ])
		from: aMessageSendNode stopPosition
		to: aMessageSendNode stopPosition
]

{ #category : #generated }
GtPharoGlamorousColorStyler >> visitMessageSend: aMessageSendNode [
	| receiver |
	super visitMessageSend: aMessageSendNode.
	aMessageSendNode receiver isVariable ifFalse: [ ^ self ].
	receiver := aMessageSendNode receiver variableName.
	aMessageSendNode message isUnary ifFalse: [ ^ self ].
	(receiver = BrGlamorousColors name
		and: [ aMessageSendNode message selector endsWith: 'Color' ])
		ifTrue: [ self styleNode: aMessageSendNode ].
	receiver = BrAntColors name ifTrue: [ self styleNode: aMessageSendNode ]
]
