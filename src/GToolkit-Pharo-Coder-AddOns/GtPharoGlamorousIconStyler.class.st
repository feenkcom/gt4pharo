"
I display an icon next to {{gtClass:BrGlamorousIcons}} and {{gtClass:BrGlamorousVectorIcons}} messages.
#Example
##Pixeled Icon
The following example shows how a pixel {{gtMethod:BrGlamorousIcons class >> #refresh | label=#selector}} looks like directly in the code: {{gtExample:GtPharoGlamorousIconStylerExamples>>#glamorousPixelIcon}}
##Vector Icon
The following example shows how a vector {{gtMethod:BrGlamorousVectorIcons class >> #refresh | label=#selector}} looks like directly in the code: {{gtExample:GtPharoGlamorousIconStylerExamples>>#glamorousVectorIcon}}
"
Class {
	#name : #GtPharoGlamorousIconStyler,
	#superclass : #GtGenericPharoStyler,
	#category : 'GToolkit-Pharo-Coder-AddOns-Icon'
}

{ #category : #'private - styling' }
GtPharoGlamorousIconStyler >> styleNode: aMessageSendNode withForm: aFormOrStencil [
	self
		attribute:
			(BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [ aFormOrStencil asElement
						margin: (BlInsets top: 2);
						when: BlClickEvent
							do: [ :e | e target phlow spawnObject: aFormOrStencil ] ])
		from: aMessageSendNode stopPosition
		to: aMessageSendNode stopPosition
]

{ #category : #'private - styling' }
GtPharoGlamorousIconStyler >> styleNode: aMessageSendNode withIconLibrary: anIconLibrary [
	| icon |
	icon := anIconLibrary perform: aMessageSendNode message selector.
	((icon isKindOf: Form) or: [ icon isKindOf: BrStencil ])
		ifFalse: [ ^ self ].
	self styleNode: aMessageSendNode withForm: icon
]

{ #category : #generated }
GtPharoGlamorousIconStyler >> visitMessageSend: aMessageSendNode [
	| receiver anIconLibrary aMethod |
	super visitMessageSend: aMessageSendNode.
	aMessageSendNode receiver isVariable ifFalse: [ ^ self ].
	receiver := aMessageSendNode receiver variableName.
	(receiver = BrGlamorousVectorIcons name
		or: [ receiver = BrGlamorousVectorIcons name ]) ifFalse: [ ^ self ].
	aMessageSendNode message arguments size isZero ifFalse: [ ^ self ].
	anIconLibrary := self class environment at: receiver ifAbsent: [ ^ self ].
	aMethod := anIconLibrary class
			compiledMethodAt: aMessageSendNode message selector
			ifAbsent: [ ^ self ].
	aMethod protocolName = #icons ifFalse: [ ^ self ].

	self styleNode: aMessageSendNode withIconLibrary: anIconLibrary
]
